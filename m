Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6A84C2944
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 11:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiBXKWP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 05:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiBXKWN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 05:22:13 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC1011147
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 02:21:42 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a23so3285015eju.3
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 02:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Htc3oqWxZZMcWDbUXLeAQItx5CvgH1P5LweVKfWWbXU=;
        b=YKgYD1I6XrVZ0S6uDdTcELyy7K2p9re21N1W4SD5OwQmZL6TUJRWhHHVVU7MmtBdo+
         c+YcxC0tg9sLKNs0ZRamriW9Q8iKrVC+Dga8qoE/f8+XUP+96bDxFzXZV1pmdxXW86WN
         o69nXC4icshS8z7Nat2x8HSu3Lv/9ZOFZ6umFnyVmTwbEwcSxc2SMmkwXunSJMt1AI1g
         z+nKO54D0NayWsiZlFwHk+ah2KSAxnMFZSUHMgbjTB3tq34NAYNd9SaQV0nLfMRrOwLS
         iN2e7BURm3SbqZ+12DlUHVyoRoD0p1o6sYKFnQJZk7H8rU8qDc3Hf9wWmAVH4Yl3sTGH
         Nhow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Htc3oqWxZZMcWDbUXLeAQItx5CvgH1P5LweVKfWWbXU=;
        b=JSG3DrdmKEiRhr0KlX+ezlnnI7VWFKnAsnbx4y/PZ0SpOEfTzqGrBae8jSFWjA07/7
         D6SVY4vCNcXlX31gm6IxQT1nj0FX4dccP8pnhnVyk1rNKjc+QhI/zGqzUNOm2szSL2pz
         g3FrRguD4JMAkNDRmI0/BVLCpODNMOVPXvrfmsE+hRfKCyPt60qxEXk/V/qoImFku4fn
         l7O5nv/1Rum3028Lo8ko28O8JIYsdpfbvKRyMTpGWjRb5CAY+IwRfhge94vLRt+xnc5d
         FoUCySP0Ifm9mQVJlWv5/R1IltfJMzqHmiShd3+q614lh8IAwj+IPVIsRr7cl7fbmqki
         aUDA==
X-Gm-Message-State: AOAM531UAIpXu1omkYW3dnzLNMbDBR+gIZYFDYdsHHnJK5/IHei8ReSS
        ejYPNPcGdoWDyIMEjiHTPXch/6OdsE5jyg==
X-Google-Smtp-Source: ABdhPJwKwy9gbDflJtc0X3PRdaHY4Vg40d7PrjYzsLby7GuGttjiyc1cDQvE9DaqOeo+GCM9FQ3urg==
X-Received: by 2002:a17:906:1316:b0:6cf:d101:9638 with SMTP id w22-20020a170906131600b006cfd1019638mr1653017ejb.284.1645698100730;
        Thu, 24 Feb 2022 02:21:40 -0800 (PST)
Received: from ddolgov.remote.csb (dslb-178-012-046-224.178.012.pools.vodafone-ip.de. [178.12.46.224])
        by smtp.gmail.com with ESMTPSA id c29sm1151518ejj.117.2022.02.24.02.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 02:21:40 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:21:39 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [RFC PATCH v3] bpftool: Add bpf_cookie to link output
Message-ID: <20220224102139.rvf44rd6wbzlf4gc@ddolgov.remote.csb>
References: <20220218075103.10002-1-9erthalion6@gmail.com>
 <CAEf4BzaD4FJw9_45v0-N5MbSKMCDcENQPzUDwo1FWoX-5ixzsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaD4FJw9_45v0-N5MbSKMCDcENQPzUDwo1FWoX-5ixzsg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Wed, Feb 23, 2022 at 01:46:56PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 17, 2022 at 11:51 PM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > +static __always_inline __u64 get_bpf_cookie(struct bpf_link *link)
> > +{
> > +       struct bpf_perf_link *perf_link;
> > +       struct perf_event *event;
> > +
> > +       perf_link = container_of(link, struct bpf_perf_link, link);
> > +       event = BPF_CORE_READ(perf_link, perf_file, private_data);
> > +       return BPF_CORE_READ(event, bpf_cookie);
>
> not every bpf_link is bpf_perf_link, you can't do it for every
> instance of bpf_link.

Right, thanks. I was somehow testing it only with perf links, will fix.
