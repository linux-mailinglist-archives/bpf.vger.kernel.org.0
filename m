Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7A54A190
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 23:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiFMVfc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 17:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiFMVfb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 17:35:31 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B7D19F
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 14:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655156130; x=1686692130;
  h=from:to:cc:references:in-reply-to:subject:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ORKLEIhCiruEP5pmd7x1lo+cVUqt1f0iW5yAX6DQ0+U=;
  b=zBmn06S9weB2llzD/KPWzAZbTzoTWUlvwF0ZdrtoK544WuFAM3F6y3M5
   Sv44Gjd/Q2eVzuZS71fRHHsxTLatWXhU72uOs3vxZPYnVeEw1wmSbj5pU
   Bg9xg5DW1aJ91vU726MnuH+yacwu76nVcV4WhmGNJWvYjr9lcumjU1mtn
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jun 2022 14:35:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 14:35:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 13 Jun 2022 14:35:28 -0700
Received: from SATYAP (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 13 Jun
 2022 14:35:27 -0700
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
References: <20220613025244.31595-1-quic_satyap@quicinc.com> <87r13s2a0j.fsf@toke.dk> <fc16df47-df2b-ffa2-4e66-5a3dc92cb4db@fb.com> <005f01d87f4d$9a075210$ce15f630$@quicinc.com> <CAADnVQJUyvhqjnn9OuB=GN=NgA3Wu59fQqLM8nzg_TWh1HnJ4Q@mail.gmail.com>
In-Reply-To: <CAADnVQJUyvhqjnn9OuB=GN=NgA3Wu59fQqLM8nzg_TWh1HnJ4Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix rq lock recursion issue
Date:   Mon, 13 Jun 2022 14:35:27 -0700
Message-ID: <006701d87f6d$7fe0a060$7fa1e120$@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKrEOxW+dsAiaocNZxPQk3DYv9LuAIVsDb2Ad4ZquwCaPRg8wLfi+B+AukbvMc=
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


On 6/13/22 2:01 PM, Alexei Starovoitov wrote:
> is doesn't solve anything.
> Please provide a reproducer.

I'm trying to find an easy way to repro the issue, so far, unsuccessful.

> iirc the task's affinity change can race even with preemption disabled
> on this cpu. Why would s/migrate/preemption/ address the deadlock ?

I don't think task's affinity change races with preemption =
disabled/enabled.

Switching to preemption disable/enable calls helps as it's just simple
counter increment and decrement with a barrier, but with migrate=20
disable/enable when task's affinity changes, we run into recursive bug
due to rq lock.

By the way, migrate disable/enable does end up calling preemt =
disable/enable
as well, pls see [1].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/k=
ernel/sched/core.c#n2224


