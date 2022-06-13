Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4649C549C88
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 21:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbiFMTA2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241907AbiFMTAO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 15:00:14 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BD8FF80
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 09:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655137039; x=1686673039;
  h=from:to:cc:references:in-reply-to:subject:date:
   message-id:mime-version:content-transfer-encoding;
  bh=42M+tPbYGs85FyTiHQeWeG39rUkBreoMoXkHjkpNpBk=;
  b=WeZ0uYXDDET/ruB3tte3wjJ23gjL5sqW/CGMdOUT6NxZPyMum0KEWRE+
   ylza/JaQKawBqZLuitb3goaFY0GEc8t3h0Q2wCLeLuCN5O0utEo07ZQ04
   2XDLpimrsg1996xTMYcnVP6N8sxfsBDIJcaQloPU2t8whH15gW0QkKaxo
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 13 Jun 2022 09:17:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 09:17:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 09:17:18 -0700
Received: from SATYAP (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 13 Jun
 2022 09:17:18 -0700
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
To:     =?utf-8?Q?'Toke_H=C3=B8iland-J=C3=B8rgensen'?= <toke@redhat.com>,
        <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <andrii@kernel.org>, <daniel@iogearbox.net>,
        <joannelkoong@gmail.com>, <brouer@redhat.com>
References: <20220613025244.31595-1-quic_satyap@quicinc.com> <87r13s2a0j.fsf@toke.dk>
In-Reply-To: <87r13s2a0j.fsf@toke.dk>
Subject: Re: [PATCH] bpf: fix rq lock recursion issue
Date:   Mon, 13 Jun 2022 09:17:17 -0700
Message-ID: <004801d87f41$0d801810$28804830$@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKrEOxW+dsAiaocNZxPQk3DYv9LuAIVsDb2AdF3Cgs=
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


On 6/13/22 2:22 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com> writes:
>
>> Below recursion is observed in a rare scenario where __schedule()
>> takes rq lock, at around same time task's affinity is being changed,
>> bpf function for tracing sched_switch calls migrate_enabled(),
>> checks for affinity change (cpus_ptr !=3D cpus_mask) lands into
>> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
>> recursion bug.
> So this only affects tracing programs that attach to tasks that can =
have
> their affinity changed?

That's right.

>   Or do we need to review migrate_enable() vs
> preempt_enable() for networking hooks as well?

I believe networking hooks won't take rq locks, so, we won't see the =
issue
with networking hooks as far as I can tell.

>
> -Toke
>

