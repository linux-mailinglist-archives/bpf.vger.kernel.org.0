Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8090F549DA3
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 21:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348552AbiFMT0p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 15:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350410AbiFMT0R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 15:26:17 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514F0B87C
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655142429; x=1686678429;
  h=from:to:cc:references:in-reply-to:subject:date:
   message-id:mime-version:content-transfer-encoding;
  bh=G/JeOvt/Fkhy5kYGohDzn3zSiozr8CRpfYSDj4hvP4g=;
  b=if4XNtUZo+NK/hwYARZwNLYigienL9ez+5IIUnHiRoEmtp8OsycBY7ZD
   C59wZiIC6h6aZbPJvLgrbkDsCLOhlSYAmOkzZlrENlhfWM83y2vabAbUX
   lhEWQCHp6KkibgdAPpKvfCEGb18IhqCdvR9If/ii9RReYaArCI4RY/+QC
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 13 Jun 2022 10:47:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 10:47:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 10:47:08 -0700
Received: from SATYAP (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 13 Jun
 2022 10:47:07 -0700
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
To:     'Yonghong Song' <yhs@fb.com>,
        =?utf-8?Q?'Toke_H=C3=B8iland-J=C3=B8rgensen'?= <toke@redhat.com>,
        <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
        <joannelkoong@gmail.com>, <brouer@redhat.com>
References: <20220613025244.31595-1-quic_satyap@quicinc.com> <87r13s2a0j.fsf@toke.dk> <fc16df47-df2b-ffa2-4e66-5a3dc92cb4db@fb.com>
In-Reply-To: <fc16df47-df2b-ffa2-4e66-5a3dc92cb4db@fb.com>
Subject: Re: [PATCH] bpf: fix rq lock recursion issue
Date:   Mon, 13 Jun 2022 10:47:07 -0700
Message-ID: <005f01d87f4d$9a075210$ce15f630$@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKrEOxW+dsAiaocNZxPQk3DYv9LuAIVsDb2Ad4ZquwCoSdkXg==
Content-Language: en-us
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 6/13/22 9:35 AM, Yonghong Song wrote:
>
>
> On 6/13/22 2:22 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> !-------------------------------------------------------------------|
>>    This Message Is From an External Sender
>>    This message came from outside your organization.
>> |-------------------------------------------------------------------!
>>
>> Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com> writes:
>>
>>> Below recursion is observed in a rare scenario where __schedule()
>>> takes rq lock, at around same time task's affinity is being changed,
>>> bpf function for tracing sched_switch calls migrate_enabled(),
>>> checks for affinity change (cpus_ptr !=3D cpus_mask) lands into
>>> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
>>> recursion bug.
>>
>> So this only affects tracing programs that attach to tasks that can =
have
>> their affinity changed? Or do we need to review migrate_enable() vs
>> preempt_enable() for networking hooks as well?
>
> I think that changing from migrate_disable() to preempt_disable()
> won't work from RT kernel. In fact, the original preempt_disable() to
> migrate_disable() is triggered by RT kernel discussion.
>
> As you mentioned, this is a very special case. Not sure whether we =
have
> a good way to fix it or not. Is it possible we can check whether rq =
lock
> is held or not under condition cpus_ptr !=3D cpus_mask? If it is,
> migrate_disable() (or a variant of it) should return an error code
> to indicate it won't work?

That essentially becomes using preempt_enable/disable().
If we need migrate_enable/disable() for RT kernels, we can
add specific check for RT Kernels like below which should fix
issue for non-RT Kernels?=20

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 2b914a56a2c5..ec1a287dbf5e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1414,7 +1414,11 @@ bpf_prog_run_array(const struct bpf_prog_array=20
*array,
         if (unlikely(!array))
                 return ret;

+#ifdef CONFIG_PREEMPT_RT
         migrate_disable();
+#else
+       preempt_disable();
+#endif
         old_run_ctx =3D bpf_set_run_ctx(&run_ctx.run_ctx);
         item =3D &array->items[0];
         while ((prog =3D READ_ONCE(item->prog))) {
@@ -1423,7 +1427,11 @@ bpf_prog_run_array(const struct bpf_prog_array=20
*array,
                 item++;
         }
         bpf_reset_run_ctx(old_run_ctx);
+#ifdef CONFIG_PREEMPT_RT
         migrate_enable();
+#else
+       preempt_enable();
+#endif
         return ret;
  }

>
>>
>> -Toke
>>

