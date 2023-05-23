Return-Path: <bpf+bounces-1089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B8870DE5A
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 16:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2DE1C20D31
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2EE1F174;
	Tue, 23 May 2023 14:00:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A91B8F2
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 14:00:40 +0000 (UTC)
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D872B1A1;
	Tue, 23 May 2023 07:00:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id 8CEBF580505;
	Tue, 23 May 2023 09:59:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 23 May 2023 09:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1684850390; x=1684857590; bh=gdE+dcQizuRxq92HvxIoxB/lQE+OMVaJSaN
	1azoGowA=; b=gyq0KLu4ecjEB700eaXqIb0RGHwJwmYw3knHSbLSuHo5Ux+Bz9q
	NlDeyKsvMmROIO5uctFDUEVKCRg5uGopgOPJlKaDyGUNSOVAmvbGmb9SEXoiDk08
	HRtVhZ7gHTgplc6CIVkWWWDcUZxD5s85YqOXqDpj/VEQpKQNwtGRMbX2UJ2FPBoC
	d/VqG1fejyo+H0bPP3cetk+uW/ETvSR80Kd2f2kgO2A7bcpkeoZ0+qNVv/yrJLsR
	+K1PsGNPeSxwgXH8MsqSW35WsbJybrbwtE/vbXq9OkZKSICOT8inMjDKLGhAE0wp
	y2n/NElZ0LrgXHSt+WgkRUk0sUkL+6PqDHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1684850390; x=1684857590; bh=gdE+dcQizuRxq92HvxIoxB/lQE+OMVaJSaN
	1azoGowA=; b=Uw6UiliXmZiS8O9zPo71IzFPgJOg78eZm/2yzWHd3pryQlrC7Rq
	B3AxYa4rQKOd1icpu71L8vTiHyOxJ0M/ohRln51qcDgD5tAtn6G7oDOu3ZRYGvSd
	17EiZEdvZ0J6KsJxgOzK+/PJN5ZnCx7Hpf1K4FWih01pyvD354DyoXCchuzGR1YA
	2mja5nDjPZ8/2eB0Rtxqp2t89B/p1zhfOajiJkHiOpnGaFM6OHtEre6syavoGSQA
	4wDDlWNivDl+nIdW7BL45HcxRAuxvq88yM+XENsY2SINaPemwB0qZDPNWa+L6oWl
	AFVYaT/ByGroxV+0zpCd5dJgHr3IPt0n1jg==
X-ME-Sender: <xms:1cZsZAr0HBto61r2LeJPGUEZrpebrWkBSyPmk-j0YzasXnb5s2aWJA>
    <xme:1cZsZGoAw3sz_k6KUjAiQSpjmKNsf3GcJvDIMejgxuMPoj_lux41A4xJYgHdAb_F1
    xKmcHf1rZJ40CEaaiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejfedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:1cZsZFPBfimrVNtytYiLAqPcuQeJuSDEXKolyB_Q_oyUNhBP8QOVBg>
    <xmx:1cZsZH5OEATTsBe0AcSov-Z1Khu32SJNKHAbrhhzMwyNx2w2ZC4_MA>
    <xmx:1cZsZP5j4j2JRhXl5qEAlKf-2coe1G-m77XtPIB5Ug_STxvJyL1H3Q>
    <xmx:1sZsZMzQbm8rXpsyzTEFwzRPMPjEEVSNgLW3GIpYC3p9PStkF97byw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 716F3B6008D; Tue, 23 May 2023 09:59:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <60d76601-de3a-498b-9ebd-e09add11f96f@app.fastmail.com>
In-Reply-To: 
 <CAADnVQL+K22KEMu8fkQbsdmDAMcws1Cja3iM=E9zPLhDfDWmqw@mail.gmail.com>
References: <20230517125617.931437-1-arnd@kernel.org>
 <20230517125617.931437-2-arnd@kernel.org>
 <CAADnVQL+K22KEMu8fkQbsdmDAMcws1Cja3iM=E9zPLhDfDWmqw@mail.gmail.com>
Date: Tue, 23 May 2023 15:59:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yhs@fb.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@google.com>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Delyan Kratunov" <delyank@fb.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 "Menglong Dong" <imagedong@tencent.com>,
 "Yafang Shao" <laoar.shao@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] bpf: add bpf_probe_read_kernel declaration
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 23, 2023, at 03:05, Alexei Starovoitov wrote:
> On Wed, May 17, 2023 at 5:56=E2=80=AFAM Arnd Bergmann <arnd@kernel.org=
> wrote:
>> @@ -1635,11 +1635,14 @@ bool bpf_opcode_in_insntable(u8 code)
>>  }
>>
>>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>> -u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *un=
safe_ptr)
>> +u64 bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_pt=
r);
>> +#ifndef CONFIG_BPF_EVENTS
>> +u64 bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_pt=
r)
>>  {
>>         memset(dst, 0, size);
>>         return -EFAULT;
>>  }
>
> This is not right, but you've spotted a bug.
> bpf_probe_read_kernel
> It should be BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
>            const void *, unsafe_ptr)
> here in kernel/bpf/core.c as well otherwise bpf prog won't
> pass the arguments correctly on 32-bit arches.

I tried that before and again now, but could not figure out how
to do this correctly though.

With this patch on top:

--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1635,9 +1635,8 @@ bool bpf_opcode_in_insntable(u8 code)
 }
=20
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-u64 bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr);
 #ifndef CONFIG_BPF_EVENTS
-u64 bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
+BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size, const void *,=
 unsafe_ptr)
 {
        memset(dst, 0, size);
        return -EFAULT;

I see a ton of other build failures, for every function calling
bpf_probe_read_kernel() from kernel/bpf:

kernel/bpf/core.c: In function '___bpf_prog_run':
kernel/bpf/core.c:1936:39: error: passing argument 1 of 'bpf_probe_read_=
kernel' makes integer from pointer without a cast [-Werror=3Dint-convers=
ion]
 1936 |                 bpf_probe_read_kernel(&DST, sizeof(SIZE),       =
        \
      |                                       ^
      |                                       |
      |                                       u64 * {aka long long unsig=
ned int *}
kernel/bpf/core.c:1937:39: error: passing argument 3 of 'bpf_probe_read_=
kernel' makes integer from pointer without a cast [-Werror=3Dint-convers=
ion
 1937 |                                       (const void *)(long) (SRC =
+ insn->off));  \


Though the code from samples/bpf seems to be able to call this
without problems.

If you have a suggestion for how to do it correctly, can you send
that as a patch yourself? Let me know if you'd like me to run that
through my test builds.

> The kconfig without CONFIG_BPF_EVENTS and with BPF_SYSCALL is very odd.
> I suspect the progs will likely refuse to load, but still worth
> fixing it correctly at least to document the calling convention.

Do you think there should be a change to the Kconfig files as well then?
I see a lot of features depend on BPF_SYSCALL but not BPF_EVENTS:
HID_BPF, BPF_LIRC_MODE2, CGROUP_BPF, BPF_PRELOAD, DEBUG_INFO_BTF,
BPF_STREAM_PARSER, AF_KCM, XDP_SOCKETS and NETFILTER_BPF_LINK.

Right now, these can all be enabled when {KPROBE,UPROBE,PERF,BPF}_EVENTS
are disabled.

    Arnd

