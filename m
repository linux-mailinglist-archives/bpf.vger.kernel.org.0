Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAA86315A3
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 19:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKTSQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 13:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKTSQA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 13:16:00 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1192E9D9
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:15:59 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id c15so6134009qtw.8
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 10:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9XEPRm3EHX78oUcXlqrebzhqob0ATnI0OJC4VBAm3c=;
        b=g0hcxG/TBHlGQfhwhXW3WhVa2AgKfsIESHbqrIdVm4h8wF8KnmmYyg+b6CSs9DNy6T
         jzzIP3m7q6BBhXcAjj9aK8gXG2l5pZBes78GAfxOX8D6JUBAkNx1V46QtfesNTR/v7Fy
         yNAvzDci1mMoJ69fhDqGpGq/gJ/FVU1QNA2Wf5icRo6AAu2CaxyzJruy9QnNWNW8zg0a
         YN4Ii/bAySkOiCUv0jTAqo8eww1Qfy1SMsu7q7DDDOi/k+FCrfECy3c1kkK88cXoOgE2
         nRWFWlIX50Hg9ebkx415uOAIk9AtBQiceLMO8JMNFaQffs4sLD9tALHG0kbR5UVSvDYj
         hwyw==
X-Gm-Message-State: ANoB5pli32r/8gc9GzQZqvT1cfspMDfofduwi0Dioo6zBH4hUvRTLVfB
        F+woevO6HsDCsBMlX5VloTBAtbXcTSAhVG4n
X-Google-Smtp-Source: AA0mqf73D+ayKRPTDiddtKlALb4op2rSsljy4YyaQx4ka11Sh0zOmh1ZxXYkkUTLlq659koUdcZXGw==
X-Received: by 2002:ac8:6611:0:b0:3a5:8084:9f7f with SMTP id c17-20020ac86611000000b003a580849f7fmr14612997qtp.358.1668968158256;
        Sun, 20 Nov 2022 10:15:58 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id w128-20020a379486000000b006cf19068261sm6491711qkd.116.2022.11.20.10.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 10:15:57 -0800 (PST)
Date:   Sun, 20 Nov 2022 12:16:02 -0600
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Rework process_dynptr_func
Message-ID: <Y3pu4tR0feM3/3t3@maniforge.lan>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-4-memxor@gmail.com>
 <Y3ajnSVA20j3o/16@maniforge.lan>
 <20221120180651.5zhi62yjsdgzqbyk@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120180651.5zhi62yjsdgzqbyk@apollo>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 20, 2022 at 11:36:51PM +0530, Kumar Kartikeya Dwivedi wrote:

[...]

> > Not your change, but this is an awkwardly phrased error message. IMO
> > "dynptr must be initialized" is more succinct. Feel free to ignore if
> > you'd like, I'm happy to submit a separate patch to change it as some
> > point.
> >
> 
> Feel free to, since I think unrelated changes should not be mixed in this patch.

No problem, will do.

[...]

> > >  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > > @@ -6119,11 +6216,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> > >  	if (arg_type_is_release(arg_type)) {
> > >  		if (arg_type_is_dynptr(arg_type)) {
> > >  			struct bpf_func_state *state = func(env, reg);
> > > -			int spi = get_spi(reg->off);
> > > +			int spi;
> > >
> > > -			if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> > > -			    !state->stack[spi].spilled_ptr.id) {
> > > -				verbose(env, "arg %d is an unacquired reference\n", regno);
> >
> > Can we add a comment here explaining why only PTR_TO_STACK dynptrs are
> > expected to be released? I know we have such comments elsewhere already,
> > but if we're going to have logic like this which is hard-coded against
> > assumptions of what types of dynptrs can be used in which contexts /
> > helpers, I think it is important to be verbose in calling that out as
> > it's not obvious from the code itself why this is the case.
> >
> 
> Sure, but you mean a code comment, right?

Yep, a code comment.

[...]
