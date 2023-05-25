Return-Path: <bpf+bounces-1246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830647117A1
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 21:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5AD2815C2
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0BC24156;
	Thu, 25 May 2023 19:49:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C51FC05
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 19:49:46 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0099CA3
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=E/d2juNGLq5nWh9BcYx0izMymu5NUvjpEmbzk1q++V8=; b=qcFYGbE2ZvDeYsJss07JKdgsPr
	lmJEFV/Q75YMIUmT92lRNZjpFBHY04VbZCTB1ren/oSO16l8IXWLyRTnF7e+qgg1WU/tqxU+l8aXo
	P3GIV9MBTCuBtn8DQ4CUzG6YEUV9M72LWTnRbXvKMsa7ov4aEwjzm/lhhq9X/Xw4Jv0a3YtoRmCpR
	hPopZNr9BeUbAHL4l5Y8Nev5fLrbO9G8eL9LMDGPseZ0SEAqWUZDRAV3BCq4QYoJu5VQugfh0lGst
	e4c+L4F2ajlwfJDGK6djCdxhj99oVm2DGXBD3xuEdEIKyftVGrhbxdkimkeuC9vWA9w7gYk1mxSg+
	uJ71aLGw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q2Gxw-000Q0H-U2; Thu, 25 May 2023 21:49:40 +0200
Received: from [178.197.248.42] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q2Gxw-000Tbu-F2; Thu, 25 May 2023 21:49:40 +0200
Subject: Re: [PATCH bpf-next 3/3] bpf: don't require bpf_capable() for
 GET_INFO_BY_FD
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@kernel.org, kernel-team@meta.com
References: <20230524225421.1587859-1-andrii@kernel.org>
 <20230524225421.1587859-4-andrii@kernel.org>
 <7f4071ff-70fd-eef2-9aa1-a0263b71dbbb@iogearbox.net>
 <CAEf4BzbNR+u2fvp82+cd-SOAGOL8QM4QEf4XgUQgQ5mp89Hc5Q@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c231bac1-b3d4-ccb1-9122-d681cd9624ff@iogearbox.net>
Date: Thu, 25 May 2023 21:49:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbNR+u2fvp82+cd-SOAGOL8QM4QEf4XgUQgQ5mp89Hc5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26918/Thu May 25 09:25:14 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/25/23 7:20 PM, Andrii Nakryiko wrote:
> On Thu, May 25, 2023 at 6:14 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 5/25/23 12:54 AM, Andrii Nakryiko wrote:
>>> The rest of BPF subsystem follows the rule that if process managed to
>>> get BPF object FD, then it has an ownership of this object, and thus can
>>> query any information about it, or update it. Doing something special in
>>> GET_INFO_BY_FD operation based on bpf_capable() goes against that
>>> philosophy, so drop the check and unify the approach with the rest of
>>> bpf() syscall.
>>>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>>    kernel/bpf/syscall.c | 11 -----------
>>>    1 file changed, 11 deletions(-)
>>>
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 1d74c0a8d903..b07453ce10e7 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -4022,17 +4022,6 @@ static int bpf_prog_get_info_by_fd(struct file *file,
>>>
>>>        info.verified_insns = prog->aux->verified_insns;
>>>
>>> -     if (!bpf_capable()) {
>>> -             info.jited_prog_len = 0;
>>> -             info.xlated_prog_len = 0;
>>> -             info.nr_jited_ksyms = 0;
>>> -             info.nr_jited_func_lens = 0;
>>> -             info.nr_func_info = 0;
>>> -             info.nr_line_info = 0;
>>> -             info.nr_jited_line_info = 0;
>>> -             goto done;
>>> -     }
>>
>> Isn't this leaking raw kernel pointers from JIT image this way for unpriv? I think that
>> is the main reason why we guarded this (originally behind !capable(CAP_SYS_ADMIN)) back
>> then..
> 
> Ah, ok, makes sense. We are protecting kernel from unpriv prog/user,
> so the "if you have FD you can get info about object" rule doesn't
> apply here.

Yeah that is correct.

