Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A2D5593CA
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 08:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiFXG4b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 02:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXG4a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 02:56:30 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE1B67E7B
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 23:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656053789; x=1687589789;
  h=from:to:cc:references:in-reply-to:subject:date:
   message-id:mime-version:content-transfer-encoding;
  bh=YBYpXZJNMGlK48V9z8Zoyy6xHBBEuaFc111ImIH7aOw=;
  b=QdGb2bj4viFD5aB6ltI9ruBliUCetEd3+Q+Mj9yzfkRnSUUxQrt+qYiH
   qCt5ke84vRg7hZ63WOcMVqUVot7GgK5wgJHlyGbfrVrqqnzhvVWfnaHrG
   qHPbzXLlgM4xiD4JGFJtniIyjDoK50cXP73mrOkCPq/y44mn0WGkSGEW9
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Jun 2022 23:56:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 23:56:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 23 Jun 2022 23:56:27 -0700
Received: from SATYAP (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 23 Jun
 2022 23:56:27 -0700
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
To:     'Yonghong Song' <yhs@fb.com>,
        'Alexei Starovoitov' <alexei.starovoitov@gmail.com>
CC:     =?utf-8?Q?'Toke_H=C3=B8iland-J=C3=B8rgensen'?= <toke@redhat.com>,
        'bpf' <bpf@vger.kernel.org>,
        'Alexei Starovoitov' <ast@kernel.org>,
        "'Andrii Nakryiko'" <andrii@kernel.org>,
        'Daniel Borkmann' <daniel@iogearbox.net>,
        'Joanne Koong' <joannelkoong@gmail.com>,
        'Jesper Dangaard Brouer' <brouer@redhat.com>
References: <20220613025244.31595-1-quic_satyap@quicinc.com> <87r13s2a0j.fsf@toke.dk> <fc16df47-df2b-ffa2-4e66-5a3dc92cb4db@fb.com> <005f01d87f4d$9a075210$ce15f630$@quicinc.com> <CAADnVQJUyvhqjnn9OuB=GN=NgA3Wu59fQqLM8nzg_TWh1HnJ4Q@mail.gmail.com> <006701d87f6d$7fe0a060$7fa1e120$@quicinc.com> <CAADnVQKq-e1TT1Y2uhgCaRY4CUP37dq0HuSyTdgtxkNfv8DQUg@mail.gmail.com> <009d01d87f8b$79f83140$6de893c0$@quicinc.com> <621b35ac-5c93-9a6d-eaf0-62cceb52cf34@fb.com>
In-Reply-To: <621b35ac-5c93-9a6d-eaf0-62cceb52cf34@fb.com>
Subject: Re: [PATCH] bpf: fix rq lock recursion issue
Date:   Thu, 23 Jun 2022 23:56:26 -0700
Message-ID: <002601d88797$8699d6b0$93cd8410$@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQKrEOxW+dsAiaocNZxPQk3DYv9LuAIVsDb2Ad4ZquwCaPRg8wLfi+B+AkHkarUCW3okDQJg8SD9AotPdZkB8A/DNA==
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 6/13/22 11:09 PM, Yonghong Song wrote:
>
>
> On 6/13/22 6:10 PM, Satya Durga Srinivasu Prabhala wrote:
>>
>> On 6/13/22 2:49 PM, Alexei Starovoitov wrote:
>>> On Mon, Jun 13, 2022 at 2:35 PM Satya Durga Srinivasu Prabhala
>>> <quic_satyap@quicinc.com> wrote:
>>>>
>>>> On 6/13/22 2:01 PM, Alexei Starovoitov wrote:
>>>>> is doesn't solve anything.
>>>>> Please provide a reproducer.
>>>> I'm trying to find an easy way to repro the issue, so far,=20
>>>> unsuccessful.
>>>>
>>>>> iirc the task's affinity change can race even with preemption=20
>>>>> disabled
>>>>> on this cpu. Why would s/migrate/preemption/ address the deadlock =
?
>>>> I don't think task's affinity change races with preemption=20
>>>> disabled/enabled.
>>>>
>>>> Switching to preemption disable/enable calls helps as it's just =
simple
>>>> counter increment and decrement with a barrier, but with migrate
>>>> disable/enable when task's affinity changes, we run into recursive =
bug
>>>> due to rq lock.
>>> As Yonghong already explained, replacing migrate_disable
>>> with preempt_disable around bpf prog invocation is not an option.
>>
>> If I understand correctly, Yonghong mentioned that replacing migrate_
>> with preempt_ won't work for RT Kernels and migrate_ APIs were=20
>> introduced
>> for RT Kernels is what he was pointing to. I went back and cross =
checked
>> on 5.10 LTS Kernel, I see that the migrate_ calls end up just calling =

>> into
>> preemt_ calls [1]. So far non-RT kernels, sticking to preemt_ calls=20
>> should
>> still work. Please let me know if I missed anything.
>
> Yes, old kernel migrate_disable/enable() implementation with
> simply preempt_disable/enable() are transitional. You can check
> 5.12 kernel migrate_disable/enable() implementation. Note that
> your patch, if accepted, will apply to the latest kernel. So we
> cannot simply replace migrate_disable() with prempt_disable(),
> which won't work for RT kernel.

Thanks for getting back and apologies for the delay. I understand that
we may break RT kernels with this patch. So, I was proposing to stick to
migrate_disable/enable() calls on RT Kernels and use =
preempt_disable/enable()
in case of non-RT Kernel. Which warrants change in scheduler, will push=20
patch and try get feedback from Scheduler experts.

While I'm here I would like to cross check with you xperts on ideas to=20
reproduce the issue easily and consistently. Your inputs will immensely =
help to=20
debug issue further.
>
>>
>> [1]
>> =
https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.1=
0/include/linux/preempt.h#335=20
>>

