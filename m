Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04857A709
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 21:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbiGSTQl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbiGSTQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 15:16:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5DE54074
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:16:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f11so14355566pgj.7
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gZmfNWIcwpYUn9IU6g2nzINZr3xWHYTQQ2xLd6CYUDk=;
        b=b0J5XIP1mnC6gW4uvEq1x8/XKtFs5GFnw3RVvilDUPS4G3rvquFIRH6pSjvW8owHIh
         8h7oFg4dGXilCafp9/37EhpB16kGehixd6Q/3yAYGo6PFO2YNp50+Jbc6tfIu9kvHmEZ
         HiMpXY/9MkF/2OgCG9QW/kJMxBAJcOh4q53MH4uS2/9teuw0eEcyPYWCBPYnODekMpz/
         GakPxJoPGFmlv9fFX9YEY5oxRdcHFQoEJcxh/btFthGHebblE6sGYKJuHWld6KozKYFr
         uThOkstQIoduYMs34e44PZRXXdzrypNmgkC9x0d5S3Vicm0S2vMdr7G8GA6h7k6kNbiq
         gTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gZmfNWIcwpYUn9IU6g2nzINZr3xWHYTQQ2xLd6CYUDk=;
        b=Yn/Iok8NDflCjK4807OwzmlTVw3zptYlB+TBJYAbk4ePiumJAqdT4sfr+HIVvQQ3R5
         8YLPklvHWkM99UJJSSPyJgFB1sPifQoPM3eklVZhZqg68q9eYyKVOQbhuWCFFl17ovzS
         3UZ7rV316Xv1C8E9Y9Y/EVQlGpVLs9YN0t/x9OGzc9KI+ZudHdjgAgIwBLjlIFKyHKvD
         AymhtoAcOed7w8GkEgZOEdglUc05TOfM6jGqdMaCGNPSSOSTh7OqDIbcP75GuDHnN16V
         7yBTYzZCN7SCLqq7N6pYyVLG43UakaWevhnEPcsw9fWXtGmJIXzOAl7+COBam9Bs+8TB
         Flew==
X-Gm-Message-State: AJIora/oE2zL7xIJB5ftZx7paIMCx9HWKYOYlW+naKGoAilq7MFYlVN1
        MgQyal1GZTVqX+ImbNvbfoSFmVIyXwo=
X-Google-Smtp-Source: AGRyM1tLL40fABGIJwyWDAsGPIx9WI5RQcJWsOfijr+6dzK2N5YFDE6t5Hv08w4BVR/pMg5MOx5hbg==
X-Received: by 2002:a63:4a06:0:b0:419:f141:888b with SMTP id x6-20020a634a06000000b00419f141888bmr19558210pga.55.1658258197034;
        Tue, 19 Jul 2022 12:16:37 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f3dd])
        by smtp.gmail.com with ESMTPSA id m1-20020a62a201000000b0052ab3039c4esm11969183pff.8.2022.07.19.12.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 12:16:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Jul 2022 09:16:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
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
Message-ID: <YtcDEpaHniDeN7fP@slm.duckdns.org>
References: <YswUS/5nbYb8nt6d@dhcp22.suse.cz>
 <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz>
 <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz>
 <Ys4wRqCWrV1WeeWp@castle>
 <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
 <YtaV6byXRFB6QG6t@dhcp22.suse.cz>
 <CAJD7tkbieq_vDxwnkk_jTYz9Fe1t5AMY6b3Q=8O-ag9YLo9uZg@mail.gmail.com>
 <CAHS8izP-Ao7pYgHOuQ-8oE2f_xe1+tP6TQivDYovEOt+=_QC7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izP-Ao7pYgHOuQ-8oE2f_xe1+tP6TQivDYovEOt+=_QC7Q@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Tue, Jul 19, 2022 at 11:46:41AM -0700, Mina Almasry wrote:
> An interface like cgroup.sticky.[bpf/tmpfs/..] would work for us
> similar to tmpfs memcg= mount option. I would maybe rename it to
> cgroup.charge_for.[bpf/tmpfs/etc] or something.

So, I'm not a fan because having this in cgroupfs would create the
expectation that these resources can be moved across cgroups dynamically
(and that's the only way the interface can be useful, right?). I'd much
prefer something a lot more minimal - e.g. temporarily allow assuming an
ancestor identity while creating a resource or sth along that line, and to
add something like that, I think we need pretty strong arguments for why it
can't be handled through cgroup layering in userspace.

Thanks.

-- 
tejun
