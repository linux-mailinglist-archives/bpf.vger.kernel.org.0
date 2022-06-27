Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18E855C59B
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbiF0PDX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbiF0PDV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 11:03:21 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADA8167CB
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 08:03:20 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id w187so9257139vsb.1
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yewx1F85B4CMZKghLUuLrLNB7cSE5NEArD3TtbKr3ps=;
        b=ZTjGEitsUf62WdRZWZCpjIOzeLmc1qpLGHDlxxNW6ZGW4B0MSaC+Is4Z2in/Be8+PD
         AGI0oIDeKa+ZGrO477GgWA6Yu4VxTuE+EYI6ZCKXyYl8IpEj2BwtRU3sxFAqYF+cmqyT
         y10rcZeuz/pt4KlQukV0F/xDvtJZDIMSZPLMH4vmdTWedIKxRoui+Ay5CGmaSIw4Gkh+
         BQwpzJS2hkf1yKJjPJTXgRx8haEDApQ+MMKG6FHFSCq/3qtp1x34G1lqw+P6whXC6+sG
         cnbIHHc06JxJfCSeZIoJl8k/HqmvnZV7cMgdJ35DhlocI0ppLJtsGSsiABUBUxMdPS1V
         dQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yewx1F85B4CMZKghLUuLrLNB7cSE5NEArD3TtbKr3ps=;
        b=IodIVoYA/17jtrNFXEiUMiOLIeMIadc02cUsfV3fqAiqimudSWHCeqLmFg+9u8qJ9J
         jHceh56cDIi1Wh6E2ppARejivyxp+lD/JXhFfoRSPs2HvDmIGzUMfqPpMYspl60m5Tql
         S0Z4st/hLlifx1/Dy8Xlx7BE9KCleU7Ia1WojADe9nkbaP3AI5Jf1SdH4nGJPJHxWkeX
         RXjAoeyIso6FdejsvYxTN56ipWtlAhBcK/KSAkYApK1dDicQDT+2NJGb5POa7Kb+HD+/
         6ZzqDxsrFWT9GQSbZPt6jaTlTOhvhq87kTLR3z4D4wfsS8/zvI2hrEY0FG0ShzAZy5XZ
         /RmA==
X-Gm-Message-State: AJIora8VqIf03bGQV4lLNgo8wvEDcJ97gEjhE/78i7QpSJhblKxSeS/W
        VRc+E9FWe/KoKuh8LXy+CPRPtIlQ5cOUG94zakU=
X-Google-Smtp-Source: AGRyM1v+MmGYKihx9Y0nHOtpncNpfRHcA3bJKnaqQzK/fjNxr5fM0WTBuyVzpOcLDB1xfS9AuUP9B0zibuzydfX0L2U=
X-Received: by 2002:a05:6102:4ba:b0:355:3b13:daa2 with SMTP id
 r26-20020a05610204ba00b003553b13daa2mr4606497vsa.16.1656342199664; Mon, 27
 Jun 2022 08:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220619155032.32515-1-laoar.shao@gmail.com> <YrPeJ5L5mSI/MqrP@castle>
 <CALOAHbBXJkOqMZEzeTVy8JmMVjRr62n=69W5EQ=oTWyoeGVgNQ@mail.gmail.com> <CAADnVQJHi+MUBmfU0rcgagJo0T5yzzpjK2Kv90SNH5Ng5yFbDA@mail.gmail.com>
In-Reply-To: <CAADnVQJHi+MUBmfU0rcgagJo0T5yzzpjK2Kv90SNH5Ng5yFbDA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 27 Jun 2022 23:02:41 +0800
Message-ID: <CALOAHbBZzNA0VRbzZeQy9mcaOZ_NFe=VTLPgsdXZN-C3LCsB+g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/10] bpf, mm: Recharge pages when reuse bpf map
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Mon, Jun 27, 2022 at 8:40 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 24, 2022 at 8:26 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > I'm planning to support it for all map types and progs. Regarding the
> > progs, it seems that we have to introduce a new UAPI for the user to
> > do the recharge, because there's no similar reuse path in libbpf.
> >
> > Our company is a heavy bpf user.
>
> What company is that?

Pinduoduo, aka PDD, a small company in China.

-- 
Regards
Yafang
