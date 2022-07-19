Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D1157A74C
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 21:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiGSTiR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 15:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGSTiQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 15:38:16 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7745340BEB
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:38:15 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so1894726pjg.3
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W+bw1rlqP9bD4CtjQLvqFHkrkeNIImEme6vPKqZseN8=;
        b=AYpp0Vt0Bv9VuFoChdGVsrFCOom55Urf9sSrftgnLYKEpbsIJqWtC8N/Dg7QjdcbNI
         2SLCTKr3XqtefnEeHZtdFxsc+YNsqWCy/EB2EmE8c0TuW2k0aptW9KCtN0t9taMO2lq7
         +hZpwV0c3sKBW3Y7mgALTX/pHhgn0TCNuBnczUBLp2p8WBWkXIODkV0JJpPSNJ6FAweZ
         XbF3bG56Z+ly8JKCtgoz3LUycQkFl4tcVgUjJp0sjATG9sPTgoHjLL7hcqqVEhDIsblG
         liRHoz1ni+9hsXAkYombJ8nRuIcR1Ae1Ym/erW34sFyDfPlHp7fcbMO3+EqRHDeTccEh
         sPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=W+bw1rlqP9bD4CtjQLvqFHkrkeNIImEme6vPKqZseN8=;
        b=pFIxZD06zLRRqSPEzzw+C8j2FpmKCzun8tM1Ah6KB78w70BoAvi4ahTqqIulXVL8/L
         ML9aJU1ZOe+LENtS1T578vQiPS6W96HE2mV0ZLMZ/VOVqJ0csb6etLR5yweXnibU7QkQ
         WzesZMyRvSeNKLtcgSwkzSc2+6+V/EO8JpvumISGRVEZYukgifC36M5wYbDiBMX1EBmS
         ldhG83CUGjvLk5+bxuH2OISliy/ddzZkPfRDZQAtEAUze4apEcRGUjIEg7ff6ZHe8mb6
         S3lQ87wOutzZIJpMm3VMZW8asLsGZ/Iw3gItqTtk5mBSWS7y79zzhABdJAjDowarP84y
         aQHg==
X-Gm-Message-State: AJIora/QXD0j53mudlOLKkzdLnHFlwjsqvGbXbO9MrmWcMjQFXGegi00
        o/fbGm4SIkvSi6c8zdnAKmQ=
X-Google-Smtp-Source: AGRyM1t2wshx0Aa95sgGeKHlgBm4LNaZDZSN7wWNveJD/9qnW7Kf7GH/CKJaIkpAGXNHAGva3Ki7xg==
X-Received: by 2002:a17:903:2344:b0:16c:4331:e5da with SMTP id c4-20020a170903234400b0016c4331e5damr33941382plh.138.1658259494710;
        Tue, 19 Jul 2022 12:38:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f3dd])
        by smtp.gmail.com with ESMTPSA id i184-20020a626dc1000000b0052859441ad3sm11844908pfc.214.2022.07.19.12.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 12:38:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Jul 2022 09:38:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: cgroup specific sticky resources (was: Re: [PATCH bpf-next 0/5]
 bpf: BPF specific memory allocator.)
Message-ID: <YtcIJClKxUPntdM9@slm.duckdns.org>
References: <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
 <Ys4wRqCWrV1WeeWp@castle>
 <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
 <YtaV6byXRFB6QG6t@dhcp22.suse.cz>
 <CAJD7tkbieq_vDxwnkk_jTYz9Fe1t5AMY6b3Q=8O-ag9YLo9uZg@mail.gmail.com>
 <CAHS8izP-Ao7pYgHOuQ-8oE2f_xe1+tP6TQivDYovEOt+=_QC7Q@mail.gmail.com>
 <YtcDEpaHniDeN7fP@slm.duckdns.org>
 <CAJD7tkZkFnVqjkdOK3Wf8f1o3XmMWCmWkzHNQKh8Znh5dDF27w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZkFnVqjkdOK3Wf8f1o3XmMWCmWkzHNQKh8Znh5dDF27w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 12:30:17PM -0700, Yosry Ahmed wrote:
> Is there a reason why these resources cannot be moved across cgroups
> dynamically? The only scenario I imagine is if you already have tmpfs
> mounted and files charged to different cgroups, but once you attribute
> tmpfs to one cgroup.charge_for.tmpfs (or sticky,..), I assume that we
> can dynamically move the resources, right?
> 
> In fact, is there a reason why we can't move the tmpfs charges in that
> scenario as well? When we move processes we loop their pages tables
> and move pages and their stats, is there a reason why we wouldn't be
> able to do this with tmpfs mounts or bpf maps as well?

Nothing is impossible but nothing is free as well. Moving charges around
traditionally caused a lot of headaches in the past and never became
reliable. There are inherent trade-offs here. You can make things more
dynamic usually by making hot paths more expensive or doing some
synchronization dancing which tends to be pretty hairy. People generally
don't wanna make hot paths slower, so we tend to end up with something
twisted which unfortunately turns out to be a headache in the long term.

In general, I'd rather keep resource associations as static as possible.
It's okay if we do something neat inside the kernel but if we create
userspace expectation that resources can be moved around dynamically, we'll
be stuck with that for a long time likely forfeiting future simplification /
optimization opportunities.

So, that's gonna be a fairly strong nack from my end.

Thanks.

-- 
tejun
