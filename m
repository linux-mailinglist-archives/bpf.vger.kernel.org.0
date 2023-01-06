Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E395366057D
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 18:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjAFRRj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 12:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjAFRRg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 12:17:36 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E9A140D4
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 09:17:35 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y1so2303774plb.2
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 09:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BszObA54pUrS6LbjCGZnkDETNcwahguKQU7tKjQAnc=;
        b=nxhl4YlRNgXEL6DzvFH0wf5sH3oKGJZwZW5j+mDfxIXt/jrXR/AvYhsm/DTbSwyH2M
         GlVyjfa8U81CTQwoVMfXXM2deCySN+LnBLXtMlTopy7jvlxMkgRJdUOzny0vjF5Gu80u
         UUJNnnceo33J2VG8PCW6A2hog6DTu34bTcfJ362Y/YfH9TSEa6TT8vTobx9p8UFTYMjh
         CAbsws84tyQQ/RS6kIbTZLWTsPGP8aZDfVZj2Eij1KZRa5N4wrs13BPG099tAQeFfZ9H
         3vAP33Fl5lpJx7ZS93miXyFDImJjBrdnJ9Zk3Ifn8nxSvSa2NBoZa6RbD16lNXnZPT7V
         /3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BszObA54pUrS6LbjCGZnkDETNcwahguKQU7tKjQAnc=;
        b=2fHjoRc01O4ek+uVfIl6R/b5SN3LpSZXXGLj5WGQVq8SOHAjfIQF7yCYFHbSkxRITA
         RCNkwBEEhYa1CCWbS3XRA74GSGwWIFYaYE4NS6Ngq3JfENX7RcjTRWeUS369MUXL6n9b
         u0iSSu41KvBLnbxNISuaJqP4SVg33/8tSdT1v5jMlCPSRGnqtZLGlernAdahzAcVJSx6
         EvKC+i4piA8Pf5bJL1tswTi99RPgNZg4SZQEYJXK1RlxVgs/zW9GLFRTy05RmXgFQ/a9
         dcaZVwaDOj75AAdNVrArJyGZzccNHt6GgkqH5z9GmP4AS/GCLIh7qtSSZcKd9O9ikbq+
         axGA==
X-Gm-Message-State: AFqh2kpHy+pXahnfmMI26CUn2Xh9ry1Kh8hBidmNR2dS17uSeNKLFtaj
        35owauqZYKKDKjiiMxScTskSSM0bzGQmFNXCH7LiTQ==
X-Google-Smtp-Source: AMrXdXsHeN7kO1opdugoqFTEsv0uWWRotDtg2lt7BlV0dLV+THh3uWF07Tz6TyKnsVTE2MPc28OY8yjdWAMHnomHBKM=
X-Received: by 2002:a17:90a:8b92:b0:218:9107:381b with SMTP id
 z18-20020a17090a8b9200b002189107381bmr4368808pjn.75.1673025454798; Fri, 06
 Jan 2023 09:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20230104215949.529093-1-sdf@google.com> <20230104215949.529093-6-sdf@google.com>
 <2795feb1-c968-b588-6a4c-9716afd8ecf2@linux.dev>
In-Reply-To: <2795feb1-c968-b588-6a4c-9716afd8ecf2@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 6 Jan 2023 09:17:23 -0800
Message-ID: <CAKH8qBvgE09m21ugW3j5Af99fOLqh8K0MH+4VM7hgS3TFW5Cdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 05/17] bpf: Introduce device-bound XDP programs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
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

On Thu, Jan 5, 2023 at 4:41 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/4/23 1:59 PM, Stanislav Fomichev wrote:
> > @@ -199,12 +197,12 @@ int bpf_prog_offload_init(struct bpf_prog *prog, union bpf_attr *attr)
> >           attr->prog_type != BPF_PROG_TYPE_XDP)
> >               return -EINVAL;
> >
> > -     if (attr->prog_flags)
> > +     if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> >               return -EINVAL;
> >
> > -     offload = kzalloc(sizeof(*offload), GFP_USER);
>
> The kzalloc is still needed. Although a latter patch added it bad, it is better
> not to miss it in the first place.

Oh, good catch, probably lost during reshuffling some changes around, will undo.


> > -     if (!offload)
> > -             return -ENOMEM;
> > +     if (attr->prog_type == BPF_PROG_TYPE_SCHED_CLS &&
> > +         attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY)
> > +             return -EINVAL;
> >
> >       offload->prog = prog;
> >
>
