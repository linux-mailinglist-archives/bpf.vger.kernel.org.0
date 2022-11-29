Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F88663C897
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 20:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237068AbiK2Tj0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 14:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbiK2TiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 14:38:12 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780A56E543
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:36:35 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3704852322fso149483617b3.8
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1bmuvgUk4OTyzS0cP/IZYe3bJ8nPbcieDdEYGxb93AQ=;
        b=ntXkEtvhVc/YnzEWpIUFZAj9rJeK2awgv14ux5liOk6ARFQ7QDmkY9WvWMn6EqOFU2
         n0pA2iVfSHzd+Pt8sMCAWm0CK60nTMK4dvyiY3Poqo2zPHY5NUEYZa1aSGTCWnh4Ym/6
         FI1Te3VLkqFV+1i2lu4M5DO0yWJBf5cq8aVFdwOJAFQ1nSnBIKa0RJYKkq24GZBrTmSk
         yg4RMe0/JV7RQAWFzsZR5jn7ePqPZQ1dqN2W0hi60e9o8c8NItwV6vTujonY0uxJhbCT
         cnopifUGk1l7GXsYdCiKrI8P9J0VYSn8g3mZvmOviAWx1ux5LIcU8jKeqjk5RhCWwhe0
         ByyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bmuvgUk4OTyzS0cP/IZYe3bJ8nPbcieDdEYGxb93AQ=;
        b=OHq7Re/zdxfwqb+8WVsgfbVhSuMT0hBtb0fujGh7JoifkLN+hxA5RF64nPi2/Itwjx
         dCiCzFNMH68dJhvPN0J3WZN91RJFrvNRxR24/p6Uy3MCN1VxKqX+MiA1xCUkKAP5s0Iq
         boT/8MMZVmo6SnNKtDbjJtDcIcR2isMtf8eW7mKlGaWGjkI0+IUTFPGUcDICWeozeV/Z
         I8Hpp2A+jOrnAA9XIuOOw4O4l2N8abWIX2wRFIFjiA7aOqa1WEpqtXhih7/bJqWSOtcx
         55C9UIvSop+04ATgmxPicoD1TEsTwFrYKW1LEdv9YZB9LBVco9AZOdUqDs0UBNEoyESq
         8ajA==
X-Gm-Message-State: ANoB5pnhWzEJyNwXrNOEDQIqglqZtJ8bFV/tdrU0hO79TkAU6GK1a7Ne
        ejihbY/HammD5psF3UlfJjxldRfLXUfuTke8IK5ENQ==
X-Google-Smtp-Source: AA0mqf5x/Ru6NTcJ+v1hnT7joZwXyMEwRPWqS7UveTWznS2uwIh9Ynrw+Ypu1vGW+xSyi3PXx0C43GetrUd2VejyV+k=
X-Received: by 2002:a0d:f0c5:0:b0:373:4bf9:626e with SMTP id
 z188-20020a0df0c5000000b003734bf9626emr37357556ywe.173.1669750594587; Tue, 29
 Nov 2022 11:36:34 -0800 (PST)
MIME-Version: 1.0
References: <41eda0ea-0ed4-1ffb-5520-06fda08e5d38@huawei.com>
 <CAMDZJNVSv3Msxw=5PRiXyO8bxNsA-4KyxU8BMCVyHxH-3iuq2Q@mail.gmail.com>
 <fdb3b69c-a29c-2d5b-a122-9d98ea387fda@huawei.com> <CAMDZJNWTry2eF_n41a13tKFFSSLFyp3BVKakOOWhSDApdp0f=w@mail.gmail.com>
 <CA+khW7jgsyFgBqU7hCzZiSSANE7f=A+M-0XbcKApz6Nr-ZnZDg@mail.gmail.com>
 <07a7491e-f391-a9b2-047e-cab5f23decc5@huawei.com> <CAMDZJNUTaiXMe460P7a7NfK1_bbaahpvi3Q9X85o=G7v9x-w=g@mail.gmail.com>
 <59fc54b7-c276-2918-6741-804634337881@huaweicloud.com> <541aa740-dcf3-35f5-9f9b-e411978eaa06@redhat.com>
 <Y4ZABpDSs4/uRutC@Boquns-Mac-mini.local> <Y4ZCKaQFqDY3aLTy@Boquns-Mac-mini.local>
In-Reply-To: <Y4ZCKaQFqDY3aLTy@Boquns-Mac-mini.local>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 29 Nov 2022 11:36:23 -0800
Message-ID: <CA+khW7hkQRFcC1QgGxEK_NeaVvCe3Hbe_mZ-_UkQKaBaqnOLEQ@mail.gmail.com>
Subject: Re: [net-next] bpf: avoid hashtab deadlock with try_lock
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Waiman Long <longman@redhat.com>, Hou Tao <houtao@huaweicloud.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 29, 2022 at 9:32 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Just to be clear, I meant to refactor htab_lock_bucket() into a try
> lock pattern. Also after a second thought, the below suggestion doesn't
> work. I think the proper way is to make htab_lock_bucket() as a
> raw_spin_trylock_irqsave().
>
> Regards,
> Boqun
>

The potential deadlock happens when the lock is contended from the
same cpu. When the lock is contended from a remote cpu, we would like
the remote cpu to spin and wait, instead of giving up immediately. As
this gives better throughput. So replacing the current
raw_spin_lock_irqsave() with trylock sacrifices this performance gain.

I suspect the source of the problem is the 'hash' that we used in
htab_lock_bucket(). The 'hash' is derived from the 'key', I wonder
whether we should use a hash derived from 'bucket' rather than from
'key'. For example, from the memory address of the 'bucket'. Because,
different keys may fall into the same bucket, but yield different
hashes. If the same bucket can never have two different 'hashes' here,
the map_locked check should behave as intended. Also because
->map_locked is per-cpu, execution flows from two different cpus can
both pass.

Hao
