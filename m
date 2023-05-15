Return-Path: <bpf+bounces-572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C8703E72
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 22:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958DE281368
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 20:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7F19918;
	Mon, 15 May 2023 20:18:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BBD18C2B
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 20:18:27 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D15811D98
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=qTFsyAOYiuv7NPnOLIItursIoLSIe1sHyfIEVg24M3U=; b=N4Ag37jzz7hCpc1cVAiYfixZ9Q
	EZhg2zK1/K4N2Hz3mteCYXjG43sLNxx9xFZNC+u4QLFIpiNZgW4rnK7TJcFjvITBotzIG+BpUuGBs
	u/7XoQR94QMHGiaY4wkAU553CJVF10FP6g90vBFFEpjlyMeR5ch/TkPKPc5ltNow4HVw5gL/fI6RA
	q6ggFXaej7+zvs4/DMCfti7t1+SlMF2P/dLlh4dYpr6gXU0bzzDX26L9Pl7N6/Wp45xPInMOWDB49
	KhV20FsAQoqpxN2snam4FHxWJlsXhh1hulZ54gsc9NP20FtllEbFTxaLyTsP6S+OWjytHMLa96PUu
	0blQM0tw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1pyedS-0001vD-Up; Mon, 15 May 2023 22:17:34 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1pyedS-000CNc-9M; Mon, 15 May 2023 22:17:34 +0200
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Fix memleak due to fentry attach
 failure
To: Song Liu <song@kernel.org>, Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
 yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 Jiri Olsa <olsajiri@gmail.com>
References: <20230515130849.57502-1-laoar.shao@gmail.com>
 <20230515130849.57502-2-laoar.shao@gmail.com>
 <CAPhsuW4_wBBKDfmCos+rXvYoT3H9=0W3EEzAWhS79i4-oHHYnA@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f88e789f-b2e9-5a20-fbc7-4b4ad6f735c4@iogearbox.net>
Date: Mon, 15 May 2023 22:17:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4_wBBKDfmCos+rXvYoT3H9=0W3EEzAWhS79i4-oHHYnA@mail.gmail.com>
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

On 5/15/23 5:52 PM, Song Liu wrote:
> On Mon, May 15, 2023 at 6:09 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> If it fails to attach fentry, the allocated bpf trampoline image will be
>> left in the system. That can be verified by checking /proc/kallsyms.
>>
>> This meamleak can be verified by a simple bpf program as follows,
>>
>>    SEC("fentry/trap_init")
>>    int fentry_run()
>>    {
>>        return 0;
>>    }
>>
>> It will fail to attach trap_init because this function is freed after
>> kernel init, and then we can find the trampoline image is left in the
>> system by checking /proc/kallsyms.
>>    $ tail /proc/kallsyms
>>    ffffffffc0613000 t bpf_trampoline_6442453466_1  [bpf]
>>    ffffffffc06c3000 t bpf_trampoline_6442453466_1  [bpf]
>>
>>    $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep "FUNC 'trap_init'"
>>    [2522] FUNC 'trap_init' type_id=119 linkage=static
>>
>>    $ echo $((6442453466 & 0x7fffffff))
>>    2522
>>
>> Note that there are two left bpf trampoline images, that is because the
>> libbpf will fallback to raw tracepoint if -EINVAL is returned.
>>
>> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> Cc: Song Liu <song@kernel.org>
>> Cc: Jiri Olsa <olsajiri@gmail.com>
> 
> Acked-by: Song Liu <song@kernel.org>

Won't this trigger a UAF for the case when progs are already running at
this address aka modify_fentry() fails where you would then also hit the
goto out_free path? This looks not correct to me.

Thanks,
Daniel

