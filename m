Return-Path: <bpf+bounces-579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1769670400D
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 23:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE4A28133C
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 21:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92819BCD;
	Mon, 15 May 2023 21:49:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB66FBF9
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 21:49:56 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E124ADDBC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 14:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ws1V2TK4DCLfpV1z8dw9oYwkEEqoAfGCBDG/lYBRWkE=; b=J8FaeyNFSudq2xx8ksB+aT4MnU
	8mn0UPmEyH8ECsbi5gdtSsoJSD5lc55ZdFflNAG0F2hivtfg12bD2R1bpY1utuqimb9jokWQyliyh
	UkWYIbDduMbCz4JuysPTYRhdHFNRnoVv3gUUNiGjsq8mq/4sHattevCrRBXhAeKcdZR+970oLM65A
	vO8TyDMDxYKFU3sp4RwpKyHcmXcUFNJ7QCViW9XNZvOlmW2h+thseDR+iIaAPIQRbf86k+ACr9xrB
	f4KpeafwvbIGsgjXlR0a9f5zOC9v00abRnm4POryRW1Vb/vrXa3/RfmANQp0m5xB3ODEi5nYJqDah
	MyIjkteA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1pyg4f-00025i-Ts; Mon, 15 May 2023 23:49:45 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1pyg4f-000B2d-8z; Mon, 15 May 2023 23:49:45 +0200
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Fix memleak due to fentry attach
 failure
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, Yafang Shao <laoar.shao@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin Lau <kafai@meta.com>, Yonghong Song <yhs@meta.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 Jiri Olsa <olsajiri@gmail.com>
References: <20230515130849.57502-1-laoar.shao@gmail.com>
 <20230515130849.57502-2-laoar.shao@gmail.com>
 <CAPhsuW4_wBBKDfmCos+rXvYoT3H9=0W3EEzAWhS79i4-oHHYnA@mail.gmail.com>
 <f88e789f-b2e9-5a20-fbc7-4b4ad6f735c4@iogearbox.net>
 <5154108C-1556-4132-871B-D739C0B6751D@fb.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <65771059-5204-8a8f-405e-64cd939a01de@iogearbox.net>
Date: Mon, 15 May 2023 23:49:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5154108C-1556-4132-871B-D739C0B6751D@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26907/Mon May 15 09:25:12 2023)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/15/23 11:14 PM, Song Liu wrote:
>> On May 15, 2023, at 1:17 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 5/15/23 5:52 PM, Song Liu wrote:
>>> On Mon, May 15, 2023 at 6:09 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>
>>>> If it fails to attach fentry, the allocated bpf trampoline image will be
>>>> left in the system. That can be verified by checking /proc/kallsyms.
>>>>
>>>> This meamleak can be verified by a simple bpf program as follows,
>>>>
>>>>    SEC("fentry/trap_init")
>>>>    int fentry_run()
>>>>    {
>>>>        return 0;
>>>>    }
>>>>
>>>> It will fail to attach trap_init because this function is freed after
>>>> kernel init, and then we can find the trampoline image is left in the
>>>> system by checking /proc/kallsyms.
>>>>    $ tail /proc/kallsyms
>>>>    ffffffffc0613000 t bpf_trampoline_6442453466_1  [bpf]
>>>>    ffffffffc06c3000 t bpf_trampoline_6442453466_1  [bpf]
>>>>
>>>>    $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep "FUNC 'trap_init'"
>>>>    [2522] FUNC 'trap_init' type_id=119 linkage=static
>>>>
>>>>    $ echo $((6442453466 & 0x7fffffff))
>>>>    2522
>>>>
>>>> Note that there are two left bpf trampoline images, that is because the
>>>> libbpf will fallback to raw tracepoint if -EINVAL is returned.
>>>>
>>>> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>> Cc: Song Liu <song@kernel.org>
>>>> Cc: Jiri Olsa <olsajiri@gmail.com>
>>> Acked-by: Song Liu <song@kernel.org>
>>
>> Won't this trigger a UAF for the case when progs are already running at
>> this address aka modify_fentry() fails where you would then also hit the
>> goto out_free path? This looks not correct to me.
> 
> I am not following. If modify_fentry() fails, we will not use the new
> image anywhere, no? Did I miss something?

Hm, agree, I think I got confused with the again label earlier. Looks ok
indeed. Applied, thanks!

