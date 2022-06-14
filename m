Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FC754A372
	for <lists+bpf@lfdr.de>; Tue, 14 Jun 2022 03:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiFNBKF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 21:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiFNBKF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 21:10:05 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636085FE0
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 18:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655169004; x=1686705004;
  h=from:to:cc:references:in-reply-to:subject:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ke0S6ngbERemCXTtiXprqtILNNbDKelqtjNuxGsKkQU=;
  b=IpPoxzhtYuWMo/5E+LVpDTCGyeotHIVp+7Va3lTpuk8HHedSPxkUj7Im
   HHMJC13Z8eY83EhAl91O301f26TeZqxnnwTrLHTh4tVZO2hlNLJvVEJPC
   njFfrDHM8dNQzHNEXmy54lAB2rw0Gasd814TFnm0+Ge+itjX96X6Vt/Rf
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 13 Jun 2022 18:10:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 18:10:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 18:10:03 -0700
Received: from SATYAP (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 13 Jun
 2022 18:10:02 -0700
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
To:     'Alexei Starovoitov' <alexei.starovoitov@gmail.com>
CC:     'Yonghong Song' <yhs@fb.com>,
        =?utf-8?Q?'Toke_H=C3=B8iland-J=C3=B8rgensen'?= <toke@redhat.com>,
        'bpf' <bpf@vger.kernel.org>,
        'Alexei Starovoitov' <ast@kernel.org>,
        "'Andrii Nakryiko'" <andrii@kernel.org>,
        'Daniel Borkmann' <daniel@iogearbox.net>,
        'Joanne Koong' <joannelkoong@gmail.com>,
        'Jesper Dangaard Brouer' <brouer@redhat.com>
References: <20220613025244.31595-1-quic_satyap@quicinc.com> <87r13s2a0j.fsf@toke.dk> <fc16df47-df2b-ffa2-4e66-5a3dc92cb4db@fb.com> <005f01d87f4d$9a075210$ce15f630$@quicinc.com> <CAADnVQJUyvhqjnn9OuB=GN=NgA3Wu59fQqLM8nzg_TWh1HnJ4Q@mail.gmail.com> <006701d87f6d$7fe0a060$7fa1e120$@quicinc.com> <CAADnVQKq-e1TT1Y2uhgCaRY4CUP37dq0HuSyTdgtxkNfv8DQUg@mail.gmail.com>
In-Reply-To: <CAADnVQKq-e1TT1Y2uhgCaRY4CUP37dq0HuSyTdgtxkNfv8DQUg@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix rq lock recursion issue
Date:   Mon, 13 Jun 2022 18:10:02 -0700
Message-ID: <009d01d87f8b$79f83140$6de893c0$@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKrEOxW+dsAiaocNZxPQk3DYv9LuAIVsDb2Ad4ZquwCaPRg8wLfi+B+AkHkarUCW3okDQHOCvd2
Content-Language: en-us
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


On 6/13/22 2:49 PM, Alexei Starovoitov wrote:
> On Mon, Jun 13, 2022 at 2:35 PM Satya Durga Srinivasu Prabhala
> <quic_satyap@quicinc.com> wrote:
>>
>> On 6/13/22 2:01 PM, Alexei Starovoitov wrote:
>>> is doesn't solve anything.
>>> Please provide a reproducer.
>> I'm trying to find an easy way to repro the issue, so far, =
unsuccessful.
>>
>>> iirc the task's affinity change can race even with preemption =
disabled
>>> on this cpu. Why would s/migrate/preemption/ address the deadlock ?
>> I don't think task's affinity change races with preemption =
disabled/enabled.
>>
>> Switching to preemption disable/enable calls helps as it's just =
simple
>> counter increment and decrement with a barrier, but with migrate
>> disable/enable when task's affinity changes, we run into recursive =
bug
>> due to rq lock.
> As Yonghong already explained, replacing migrate_disable
> with preempt_disable around bpf prog invocation is not an option.

If I understand correctly, Yonghong mentioned that replacing migrate_
with preempt_ won't work for RT Kernels and migrate_ APIs were =
introduced
for RT Kernels is what he was pointing to. I went back and cross checked
on 5.10 LTS Kernel, I see that the migrate_ calls end up just calling =
into
preemt_ calls [1]. So far non-RT kernels, sticking to preemt_ calls =
should
still work. Please let me know if I missed anything.

[1]
https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.1=
0/include/linux/preempt.h#335

