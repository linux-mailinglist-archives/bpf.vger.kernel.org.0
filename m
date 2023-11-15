Return-Path: <bpf+bounces-15100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652847EC969
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 18:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECEC28150E
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EC141755;
	Wed, 15 Nov 2023 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HsEs+XH1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067CF41210
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 17:09:10 +0000 (UTC)
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595FA19E
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 09:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700068148; bh=ecTXeIx/uMKgbGOKAy0MvHVqzTSGKM9Lk/9ujm0b0QM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=HsEs+XH1IROzd+0K+Z3Hregqg5U+MRbM8GvxZ2De3cmbRzMogJM4OR5IyxnsQeEeAvr551cfUOuGlBeZ3XFIzNEiSuwc6+qDjKgP0SzMPR47EpMAwUb57nN93kqHu63ogwB5I1VUKulxGW6bqsdl2+nEypCr8IWeiO9yM5Mimi1Y0rWu78llqoe8OEyq/nmF7nn2VcZe5eBqotzlIfDONfU6OgotkVPZ90flT+ODoVJmthNGiLJL3gf41fZb5uBgGNdRuTAwa/7DCjxuv2l7skJiRTL14EOt2QbGEDMZ3OdBDmmaCh6DqEFVubYF4hlDY5XQsanS/JQp5CAlngUsWg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700068148; bh=LFLw8pbFIm85Dqu/AR5jKKtHOktuTDMmPnsp+Igg8u+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=R1hfnVwX82urobldJOqcge1VkXCM5PGONMUH/el/jxnyhC6UKOJwMkys7Dcu3I/sDZohD3cPUKT4RAQTeVMwAH3ma5S+VOmeP7J5fnYdbiTGhNlvOulchrQQv2yqmYdpeZqxs7JkDu+TeKyEmJE3fpsrT/4AcJ/3Gh7rDMRjlvH54vdqZPcjFNJc9mG7AwKZrEli+U1SCR1AEvXO04VylCjrNTd9dCfvB9CJCKYJi9GY8oasRxjzrlHOdQ5lzT69UGRVG4auDRQTN5hcbC2wtMw32RYl2KbB/NY0TaYvBaus91SAqcZMKWzXTeRI35TW+3mpUxHzWwwA+oLmQeX+Aw==
X-YMail-OSG: kwrHWYEVM1nLxbQ8X8BkmBr_suF5zkyXjoCnyPbpwuCO6..saAOxydxDSw20v4L
 wgy14qaJ2n.7F0lmCyrqcTVLBo3XvKZuPdGlXH6HSeepF0xjPY_5EkrF6Q02.J0mrS_sTKICMc3l
 quzbuhtQxxDi4zsW5Iaqiwl4OLAqvKiAvOD8qSveiFs_kLcfkRLzFrUuSf6vnlyRTzudbixZtfgn
 GXkWcieI4B8aMg2rGHt.fVxPtOl79r9qwzDFESX.VqaqN_fjQoDSUWSiFsD7XWWtQm40m_tSa3AC
 VKd1JPxm0ai08nJw7tJtXnaNcVygHqGy2r5Dv5Gl7qAOwB0_4iEQPec0Lli9pq9hI1tjMSPbl3ts
 W2BE2pnzvtoe1Fq9_9YMWJH1x1Ws2yy4GdpOH6e.1_Xg9KW0HVuHRPJN9UGJCFa7k5HjT4arLZiD
 L3yHmrFDLCZGLKNiLu7xSBdNop1mFQfzTS4XhnGrUFBur8TeXknuGgsHQCJd6lfXAOuFR8Zl_ymy
 JxHwJU9DM0h.2xr2fVXU7mbJT5Os8I71Mf_zRNhGWPbfBGVa3ZmSf8sBUT3BiqQfgniRNcSiu9Qp
 gFIXzpftl2nexrCGp_3IbWRMT9dAxaA.vNg2ECYd6RedUFmO7QMc28jEXYCBmJ4WN49J8c9U7m.9
 4CM8AojMnoY5ubhvNz_v7zRJROGVEvUThF4E3o0w5CQn2wT5ae.QzworO9_qJ2GmuOef7rVw0d5r
 ZqP3qhGULayksG0KRGuqng4iinZG1JRIb3sScmHfPHB10o._MYvQjGTWXYujUJTT0Xq.fWhhlo3H
 1NnkyEev11W8oa5qX7ssjY0_XQu9K7edhI.81Bde5n..yuqFHGF9VqeuqyWaTII8dtnUA5xSz8tz
 fAKUnH_8jVajZarjjNm0q7E36CANO4pRmf8IQv_1q2bb.W6oOTsutqNitG8vvp9wIyv.071wwXUE
 HI.DejBVafHPmmoW6ODBHspwf9qsQodCofeEj4KTGe4sI5qt8QTNZGx5e_tnmBRM238iKZXUzo8z
 WwXW8IrnL3_oO0.lZRGOoCkwvyvNtys.1zKqxajzozqA19Lthezgn_T3WYpwABnWBMMu2vxhRRAZ
 Ir781ExWiOLyZNQV9RhSkQ.hx.NIRjMv9hREcP04mNQQCwNVHIIrGQT6tTsrIdDwjmzVvftw19qt
 .ATYjbwbr2JYDz0qe5I7T.4g4p5kjFNC7ZoEYB3pEgzAMHpFuGzNxhDOSCfuL1dLFIRX0fAhmHFc
 TRoDQTAnXhImsrRnPfn1PW2xD0QG0YVSexZu41xRgnNwZIgK5TxX1zvTJUpeXN9J6aNj83bdUNQ2
 l_MwgS6JipZyIoPvL7EDYGnnQ73aIPHv0FpGddiVv2QAItN0oeLpMW6HciwK0QlHxyPSQr4gelbJ
 uBNSNkkU_M3kcldcQRbNZaT8yRC9hoZdOqFabqtvXS0GY0TP426GAGR90PR9m.XqNs29SD90egdn
 AksBiG2QKHal5OGue2IN45lOtCbTOeCi23VTIXW3751uohktOd_33vhb1ddZsrPg1H1ReUkPQ7mk
 DdD5H215rBDXPLBx9rT2ycBrTHOCgUcIWjSWbgGyTUiO98miStWatO2Vjc7RMHpYSNquDCnFJfL3
 hFN4CFYM45Gb3ZlHlf.mzfsPgIvSMJuWA9DBAMBjVr_v6tvLPRvMKaYqo5S6jPplvC7ZAzsSnlRb
 oGavxgz36ybpR3l26sODvyxwZ0WaMiD2.NfkOkaQLdU47ay2lBmgD95vWwc6SN47PzipxiEA2v.u
 ssHEc928..ZPtNSsr06ScOvb.PuwtupxuJ4xW1vBU95wbBpjLdKxMXnQUj_Ljd9UuVkksynIf5ll
 P8_6RNZYdu.C1cBaSX5I36TWZ.CU0xuiUNKwCsaJJFZYfrRI0HAL_1EI1aA4uxRykW9YpyaTjp3v
 gouqQ5Z8jAJKbe0exPSO5MurF8Xwcqv3AX41ZlEVNSIvJ87S.FVXRvcBpLhP7u_u5ncR8TMXcTso
 xUbZt39z5rmvjxeRRT4qHNmPH7gLUWmgUWQ9B1XTd.GriMXy58h.rtqMYQz2pEhMV9_DBKSdoRhm
 Ve5Vb3qB3aaiSaNM6DNPm.jYLAhw4Irmm_eG_NBVrMMrd1LjegJ3hgx6mq6TjhYXSx5B1ao0D_UR
 vNKZX7TUEZlQVCr4dvxwK_bOnVVM.6mJel86.SDShzzQDOTC8SoskR5S3NuPGROhn9tsvsLidg2T
 pbSP9I52k8n4SB7TqqtM_tXQOOsulrkpdNymX.kK_gUgZYMKIW36oYOrZwRodaGccg442WhFWNKl
 _3xATQp6jjQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 41df1ed9-af91-480b-b4ad-fb50df66925a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Nov 2023 17:09:08 +0000
Received: by hermes--production-ne1-56df75844-w2gpf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 916ffbc0e12a03b751b0f160810b39af;
          Wed, 15 Nov 2023 17:09:07 +0000 (UTC)
Message-ID: <22994ba0-18eb-4f9d-a399-abde52ffdc38@schaufler-ca.com>
Date: Wed, 15 Nov 2023 09:09:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>, Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org, ligang.bdlg@bytedance.com,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231112073424.4216-1-laoar.shao@gmail.com>
 <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
 <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
 <ZVNIprbQU3NqwPi_@tiehlicka>
 <CALOAHbDi_8ERHdtPB6sJdv=qewoAfGkheCfriW+QLoN0rLUQAw@mail.gmail.com>
 <b13050b3-54f8-431a-abcf-1323a9791199@schaufler-ca.com>
 <CALOAHbBKCsdmko_ugHZ_z6Zpgo-xJ8j46oPHkHj+gBGsRCR=eA@mail.gmail.com>
 <ZVSFNzf4QCbpLGyF@tiehlicka>
 <CALOAHbAjHJ_47b15v3d+f3iZZ+vBVsLugKew_t_ZFaJoE2_3uw@mail.gmail.com>
 <CALOAHbDK0hzvxw84brfV2tZnyVp9Ry22gp3Jj8EmQySUbdqmiw@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CALOAHbDK0hzvxw84brfV2tZnyVp9Ry22gp3Jj8EmQySUbdqmiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/15/2023 6:26 AM, Yafang Shao wrote:
> On Wed, Nov 15, 2023 at 5:33 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>> On Wed, Nov 15, 2023 at 4:45 PM Michal Hocko <mhocko@suse.com> wrote:
>>> On Wed 15-11-23 09:52:38, Yafang Shao wrote:
>>>> On Wed, Nov 15, 2023 at 12:58 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> On 11/14/2023 3:59 AM, Yafang Shao wrote:
>>>>>> On Tue, Nov 14, 2023 at 6:15 PM Michal Hocko <mhocko@suse.com> wrote:
>>>>>>> On Mon 13-11-23 11:15:06, Yafang Shao wrote:
>>>>>>>> On Mon, Nov 13, 2023 at 12:45 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>>>> On 11/11/2023 11:34 PM, Yafang Shao wrote:
>>>>>>>>>> Background
>>>>>>>>>> ==========
>>>>>>>>>>
>>>>>>>>>> In our containerized environment, we've identified unexpected OOM events
>>>>>>>>>> where the OOM-killer terminates tasks despite having ample free memory.
>>>>>>>>>> This anomaly is traced back to tasks within a container using mbind(2) to
>>>>>>>>>> bind memory to a specific NUMA node. When the allocated memory on this node
>>>>>>>>>> is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
>>>>>>>>>> indiscriminately kills tasks. This becomes more critical with guaranteed
>>>>>>>>>> tasks (oom_score_adj: -998) aggravating the issue.
>>>>>>>>> Is there some reason why you can't fix the callers of mbind(2)?
>>>>>>>>> This looks like an user space configuration error rather than a
>>>>>>>>> system security issue.
>>>>>>>> It appears my initial description may have caused confusion. In this
>>>>>>>> scenario, the caller is an unprivileged user lacking any capabilities.
>>>>>>>> While a privileged user, such as root, experiencing this issue might
>>>>>>>> indicate a user space configuration error, the concerning aspect is
>>>>>>>> the potential for an unprivileged user to disrupt the system easily.
>>>>>>>> If this is perceived as a misconfiguration, the question arises: What
>>>>>>>> is the correct configuration to prevent an unprivileged user from
>>>>>>>> utilizing mbind(2)?"
>>>>>>> How is this any different than a non NUMA (mbind) situation?
>>>>>> In a UMA system, each gigabyte of memory carries the same cost.
>>>>>> Conversely, in a NUMA architecture, opting to confine processes within
>>>>>> a specific NUMA node incurs additional costs. In the worst-case
>>>>>> scenario, if all containers opt to bind their memory exclusively to
>>>>>> specific nodes, it will result in significant memory wastage.
>>>>> That still sounds like you've misconfigured your containers such
>>>>> that they expect to get more memory than is available, and that
>>>>> they have more control over it than they really do.
>>>> And again: What configuration method is suitable to limit user control
>>>> over memory policy adjustments, besides the heavyweight seccomp
>>>> approach?

What makes seccomp "heavyweight"? The overhead? The infrastructure required?

>>> This really depends on the workloads. What is the reason mbind is used
>>> in the first place?
>> It can improve their performance.

How much? You've already demonstrated that using mbind can degrade their performance.

>>
>>> Is it acceptable to partition the system so that
>>> there is a numa node reserved for NUMA aware workloads?
>> As highlighted in the commit log, our preference is to configure this
>> memory policy through kubelet using cpuset.mems in the cpuset
>> controller, rather than allowing individual users to set it
>> independently.
>>
>>> If not, have you
>>> considered (already proposed numa=off)?
>> The challenge at hand isn't solely about whether users should bind to
>> a memory node or the deployment of workloads. What we're genuinely
>> dealing with is the fact that users can bind to a specific node
>> without our explicit agreement or authorization.
> BYW, the same principle should also apply to sched_setaffinity(2).
> While there's already a security_task_setscheduler() in place, it's
> undeniable that we should also consider adding a
> security_set_mempolicy() for consistency.

	"A foolish consistency is the hobgoblin of little minds"
	- Ralph Waldo Emerson



