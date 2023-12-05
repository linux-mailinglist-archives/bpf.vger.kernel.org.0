Return-Path: <bpf+bounces-16704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46D8048CE
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 05:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67C21F2143A
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 04:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2AB6123;
	Tue,  5 Dec 2023 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dHuXozN2"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ac])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F9BCA
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 20:52:16 -0800 (PST)
Message-ID: <266dc356-b2d3-48cc-ab98-096a07871dc9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701751934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pRKtz7xufD5EbRaOVijfUDYKkcRNExc2r/03K+nAR8=;
	b=dHuXozN2Zqm2krqDyAgGKJTFP7P2Fp8rDdcSpOLllnsrEQpP2qPSlKtNiAZU+2smT47eqF
	kwzo9q2imXAj90Si+vxC0cOlWgGlNacPsH8u94E6yP4aSjAH/P6rrv1jbUten4Irp7nUUM
	O+A2X6gmT/up3QJ9Wsotu4o5JH1ErMw=
Date: Mon, 4 Dec 2023 20:52:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf 1/2] bpf: Fix prog_array_map_poke_run map poke
 update
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Lee Jones <lee@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>
References: <20231203204851.388654-1-jolsa@kernel.org>
 <20231203204851.388654-2-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231203204851.388654-2-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/3/23 3:48 PM, Jiri Olsa wrote:
> Lee pointed out issue found by syscaller [0] hitting BUG in prog array
> map poke update in prog_array_map_poke_run function due to error value
> returned from bpf_arch_text_poke function.
>
> There's race window where bpf_arch_text_poke can fail due to missing
> bpf program kallsym symbols, which is accounted for with check for
> -EINVAL in that BUG_ON call.
>
> The problem is that in such case we won't update the tail call jump
> and cause imbalance for the next tail call update check which will
> fail with -EBUSY in bpf_arch_text_poke.
>
> I'm hitting following race during the program load:
>
>    CPU 0                             CPU 1
>
>    bpf_prog_load
>      bpf_check
>        do_misc_fixups
>          prog_array_map_poke_track
>
>                                      map_update_elem
>                                        bpf_fd_array_map_update_elem
>                                          prog_array_map_poke_run
>
>                                            bpf_arch_text_poke returns -EINVAL
>
>      bpf_prog_kallsyms_add
>
> After bpf_arch_text_poke (CPU 1) fails to update the tail call jump, the next
> poke update fails on expected jump instruction check in bpf_arch_text_poke
> with -EBUSY and triggers the BUG_ON in prog_array_map_poke_run.
>
> Similar race exists on the program unload.
>
> Fixing this by moving the update to bpf_arch_poke_desc_update function which
> makes sure we call __bpf_arch_text_poke that skips the bpf address check.
>
> Each architecture has slightly different approach wrt looking up bpf address
> in bpf_arch_text_poke, so instead of splitting the function or adding new
> 'checkip' argument in previous version, it seems best to move the whole
> map_poke_run update as arch specific code.
>
> [0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> Reported-by: syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com
> Tested-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

In bpf_arch_text_poke(), we also have
         if (is_endbr(*(u32 *)ip))
                 ip += ENDBR_INSN_SIZE;
Since the indirect call be converted to direct call,
so I think we do not need endbr insn at the beginning of
the function even if jit might have added endbr or
some other stuff in the beginning of the function.
See
   https://lore.kernel.org/bpf/20231130133630.192490507@infradead.org/

The patch looks good to me.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


