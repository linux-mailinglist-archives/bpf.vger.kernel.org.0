Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F635595BC1
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 14:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiHPM21 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 08:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiHPM20 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 08:28:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E507361B3F;
        Tue, 16 Aug 2022 05:28:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u3so14683477lfk.8;
        Tue, 16 Aug 2022 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=12z+d6LglnQXoKvRDJb4MyEPTMUhYNXf828Z5Uit61g=;
        b=hjPuWsDrCnwehNj5ojranCW3leCDRP9cbzilnfPqGUuAVlXX5mhdBc89FYhoB0J82k
         FBbLsi0zKgaeRpIxJ1yDFM74E8VNg0pO4LG7iv9jflzxLWP0fOVra7iPXwoTNJkO0iUI
         LxyrEjB+MnZegX2IHG26ovhpQmnQNQsDUjk2F45DH5I+wZRQnbTuXSTiiTyUdaGVYf6M
         NdeQTdlVRclIYh8GnA5RjhGk5cVDBayMm4VxF+cLbcZWNVnoHWKCwNylFwm6xdFPTan/
         6BXpim/59GH8ywME1CD15/UYalmxKoAJRETTk27d7DMhA3ohqBlrLLG/3O9bJ7JUyeaf
         gr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=12z+d6LglnQXoKvRDJb4MyEPTMUhYNXf828Z5Uit61g=;
        b=yA6JxEU712OJLGuesIj23W2tTNwcmuVfCWWjik9JZyWBUYeFd2WK/L2+73x370POGY
         Zhi1u/2k7pqsb6xB1Z9pohpl8UyIa8Cm/K1jW2XpXEhTK7wH8b2ZWwJvMpTfjLNnZ2i/
         RQZrMi1P4quR8lR+H7NS4agOqeLxxnhaxmkIWd6SiFzHO+zBx6m2ErLtFpZg2k61nYkg
         Poq9Jgd07w/HcVot6jBh0oGfXminp84kV2wgfN44MRcdkLdZMK46K/u6S6I6D7Vft8zF
         gBEkzsWITfBnXzCji72PwpiRhjPPmcPXasxTjEW1ylaJloyDfsaMYmzgiy26LULVXIUx
         jOPw==
X-Gm-Message-State: ACgBeo2SmQEJ4HS5mNL+pkmGpQkfr1ErEQYZUnIlvIwjaldcgKAHzyzt
        /mWMdAIu/j+BZzT+9efll9v4OJwXB+ktvs7uoTE=
X-Google-Smtp-Source: AA6agR5DQihesi5g7XyBe94IbJLBvXUHttDycFjD2D6OXmfICK3W9ohOdIJtMO0uujBEahANwZDoYtqpSA+HB6Ic5y4=
X-Received: by 2002:a05:6512:1149:b0:48c:ddba:b793 with SMTP id
 m9-20020a056512114900b0048cddbab793mr6842994lfg.280.1660652904038; Tue, 16
 Aug 2022 05:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220810171702.74932-1-flaniel@linux.microsoft.com>
 <20220810171702.74932-2-flaniel@linux.microsoft.com> <CAEf4BzYex03T7aYjLnbkfHb8vUsCHhj_DiMU6KbK29F+DyhXyA@mail.gmail.com>
In-Reply-To: <CAEf4BzYex03T7aYjLnbkfHb8vUsCHhj_DiMU6KbK29F+DyhXyA@mail.gmail.com>
From:   Alban Crequy <alban.crequy@gmail.com>
Date:   Tue, 16 Aug 2022 14:28:12 +0200
Message-ID: <CAMXgnP5d1qcGFh2d_G_P4MfNHw+iyaC3EQx+Cv0zA43dBT_xsg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/3] bpf: Make ring buffer overwritable.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Francis Laniel <flaniel@linux.microsoft.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Aug 2022 at 04:22, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 10, 2022 at 10:18 AM Francis Laniel
> <flaniel@linux.microsoft.com> wrote:
> >
> > By default, BPF ring buffer are size bounded, when producers already filled the
> > buffer, they need to wait for the consumer to get those data before adding new
> > ones.
> > In terms of API, bpf_ringbuf_reserve() returns NULL if the buffer is full.
> >
> > This patch permits making BPF ring buffer overwritable.
> > When producers already wrote as many data as the buffer size, they will begin to
> > over write existing data, so the oldest will be replaced.
> > As a result, bpf_ringbuf_reserve() never returns NULL.
> >
>
> Part of BPF ringbuf record (first 8 bytes) stores information like
> record size and offset in pages to the beginning of ringbuf map
> metadata. This is used by consumer to know how much data belongs to
> data record, but also for making sure that
> bpf_ringbuf_reserve()/bpf_ringbuf_submit() work correctly and don't
> corrupt kernel memory.
>
> If we simply allow overwriting this information (and no, spinlock
> doesn't protect from that, you can have multiple producers writing to
> different parts of ringbuf data area in parallel after "reserving"
> their respective records), it completely breaks any sort of
> correctness, both for user-space consumer and kernel-side producers.

The perf ring buffer solved this issue by adding an option to write
data backward with commit 9ecda41acb97 ("perf/core: Add
::write_backward attribute to perf event"). I'd like to see the BPF
ring buffer have a backward option as well to make overwrites work
without corruption. It's not completely clear to me if that will work
but I'd like to explore this with Francis. (Francis and I work in the
same team and we would like to use this for
https://github.com/kinvolk/traceloop).

Best regards,
Alban
