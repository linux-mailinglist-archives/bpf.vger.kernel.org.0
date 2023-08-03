Return-Path: <bpf+bounces-6905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8C76F636
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 01:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A353E2823DF
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C626B22;
	Thu,  3 Aug 2023 23:40:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE410EA0
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 23:40:07 +0000 (UTC)
Received: from out-66.mta1.migadu.com (out-66.mta1.migadu.com [95.215.58.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C89D3A8C
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 16:40:01 -0700 (PDT)
Message-ID: <5c9c4b8c-9f9a-7677-3c3f-6c0faf77397d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691105999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsWcqJqp3UWAuUaBqLlcAaS04nYnFCORUz3OLcwWUUk=;
	b=RwK8TbiFVk6plWneHnjRHhz+DTDMHp8x0+QN/byuFIdSOMoMjX7thRWSt9cJixicKO1E/0
	9GASftNfUqKbZAJrmeGHz0cwpNxesztIT3E9rdXLF/e3m4N+/CqKodj6ySKy2iuU3+WSf5
	sa84CTPna7HNg4rrLDhK+qtQb4B+NXo=
Date: Thu, 3 Aug 2023 16:39:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in
 bpf_mprog_detach
Content-Language: en-US
To: syzbot <syzbot+0c06ba0f831fe07a8f27@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, bpf@vger.kernel.org
References: <0000000000007095cd0601a9ad91@google.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sdf@google.com, song@kernel.org, yhs@fb.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <0000000000007095cd0601a9ad91@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/29/23 5:48 PM, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    ec87f05402f5 octeontx2-af: Install TC filter rules in hard..
> git tree:       net-next
> console output:https://syzkaller.appspot.com/x/log.txt?x=12a76df1a80000
> kernel config:https://syzkaller.appspot.com/x/.config?x=8acaeb93ad7c6aaa
> dashboard link:https://syzkaller.appspot.com/bug?extid=0c06ba0f831fe07a8f27
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image:https://storage.googleapis.com/syzbot-assets/0fc53904fc08/disk-ec87f054.raw.xz
> vmlinux:https://storage.googleapis.com/syzbot-assets/aee64718ea5c/vmlinux-ec87f054.xz
> kernel image:https://storage.googleapis.com/syzbot-assets/d3b6d3f4cfbc/bzImage-ec87f054.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by:syzbot+0c06ba0f831fe07a8f27@syzkaller.appspotmail.com
> 
> ================================================================================
> UBSAN: array-index-out-of-bounds in ./include/linux/bpf_mprog.h:292:24
> index 4294967295 is out of range for type 'bpf_mprog_fp [64]'
> CPU: 1 PID: 13232 Comm: syz-executor.1 Not tainted 6.5.0-rc2-syzkaller-00573-gec87f05402f5 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
>   ubsan_epilogue lib/ubsan.c:217 [inline]
>   __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:348
>   bpf_mprog_read include/linux/bpf_mprog.h:292 [inline]
>   bpf_mprog_fetch kernel/bpf/mprog.c:307 [inline]
>   bpf_mprog_detach+0xcd7/0xd50 kernel/bpf/mprog.c:381
>   tcx_prog_detach+0x258/0x950 kernel/bpf/tcx.c:78
>   bpf_prog_detach kernel/bpf/syscall.c:3877 [inline]
>   __sys_bpf+0x36ee/0x4ec0 kernel/bpf/syscall.c:5357

Thanks for the report. I will take a look.

