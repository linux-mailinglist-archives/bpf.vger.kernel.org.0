Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC455B4B4
	for <lists+bpf@lfdr.de>; Mon, 27 Jun 2022 02:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiF0Akt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Jun 2022 20:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiF0Akt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Jun 2022 20:40:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C56A2DE3
        for <bpf@vger.kernel.org>; Sun, 26 Jun 2022 17:40:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o9so10808747edt.12
        for <bpf@vger.kernel.org>; Sun, 26 Jun 2022 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1nvrNEcMz+SCaU8rTwCEG+EJDY+e//mlpXeVHB0cbs=;
        b=iZZF7mZMoAi6Dp9gnPKbUh5RBWW6LPqI29mYA04/0MQGWe1yy1asuoHiJ9chDqMnPr
         hzylNzpnrnGDE/PGbPUC2xXdTErd2mZfQgmU6uK2ggctm081bQAUsy1XZpcU311RPpjb
         2I6KXBqH0/Gqlj8DsqlhxfcSoohXchSmya1FfSKpwblWiIrkaAjzNKNMV9chF7Hs9Wk0
         pfoP+FP/1vizDteU1HiBgxW8x0DKqhUM6LiE49kiCT5JgEex4434n8hSUzyrCNaQeB6o
         eLCWPko2STy03DFUT4w1HN8BjXRekeWeOoA+1XicFDBh8ygtolGQlzPOBtRPA2pkYgsM
         4++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1nvrNEcMz+SCaU8rTwCEG+EJDY+e//mlpXeVHB0cbs=;
        b=kL6NFSvO6rkT3LCX/Pjss9wH6attQk/kzGZhDWArZ2AVGLqUy5MctVleyuyoC3EuSb
         r/5MfMiVmNT4t43wY0evpNqigLPUIM+3r3eK3x6uaRk8PIgKDqJhi2JSkEnLde36qP2y
         yiBH3+UaQe/UcyKeh87VNHgvtdLZwrBccyvhy+4HqtYXbvgBLmV32QmCsiADuw2pUpw5
         wg4oonSGXYbBAzyLhv1TqNMlXPoeHlNIQKAgf5EOdn5dUWgGE/38CXW53JH9avgXGQb7
         bnBjwU0m3ZMEn79r7JP3pWpHw7J7Gw9AueMsdH6yKm4xNzWNIhZ2Y9s9d9z/C8+T/V93
         stOQ==
X-Gm-Message-State: AJIora/8OHeUUJ2OK2MwX81uzIScKy5mM21sGf+SdNoApPrusmINTt2+
        xhh5Riz1Ds5hilUHIezaUtb82uOXqyJC7QcfLu0=
X-Google-Smtp-Source: AGRyM1ukjWkWsE1bOP1O1a/cnANVhmqET8VtBCPEROUakZqZm3N1tWLOWIKoHVJOJJ5N1OvdD6TOTyYm65+VGfzKkKE=
X-Received: by 2002:a05:6402:3487:b0:435:b0d2:606e with SMTP id
 v7-20020a056402348700b00435b0d2606emr13966235edc.66.1656290446969; Sun, 26
 Jun 2022 17:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220619155032.32515-1-laoar.shao@gmail.com> <YrPeJ5L5mSI/MqrP@castle>
 <CALOAHbBXJkOqMZEzeTVy8JmMVjRr62n=69W5EQ=oTWyoeGVgNQ@mail.gmail.com>
In-Reply-To: <CALOAHbBXJkOqMZEzeTVy8JmMVjRr62n=69W5EQ=oTWyoeGVgNQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 26 Jun 2022 17:40:35 -0700
Message-ID: <CAADnVQJHi+MUBmfU0rcgagJo0T5yzzpjK2Kv90SNH5Ng5yFbDA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/10] bpf, mm: Recharge pages when reuse bpf map
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
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

On Fri, Jun 24, 2022 at 8:26 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> I'm planning to support it for all map types and progs. Regarding the
> progs, it seems that we have to introduce a new UAPI for the user to
> do the recharge, because there's no similar reuse path in libbpf.
>
> Our company is a heavy bpf user.

What company is that?
