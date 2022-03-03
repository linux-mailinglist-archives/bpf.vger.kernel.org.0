Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01F54CC665
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 20:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiCCTpE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 14:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiCCToq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 14:44:46 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED0017CC73
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 11:43:58 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id n185so4771892qke.5
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 11:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQRGmRac3HoqPUI4eVx9DWNAF0av56DUKyJ6WrJqlvc=;
        b=tHE27GKzaq8/s+SrNHsu2bVFELPKQrOGq2k5ap+pGfutc6xtgH36rG6YuqRTucIHTQ
         zW3leSl9K+3AyvBQnkvwWJcgbEY3SnimmpAGO36MSJAKoJ/a+P9rSv+e4GGsMR6cbs8j
         sy9R+Dv/L7ytx2sLRr1pRTp8l+9JjwKjS6fUQaHfYd9LUn+vOpWabF8P3tyDmeB2t9tg
         Cq/5H5s+EvhA2DJjCwYrwoHk4WZUk5JLI9G1lVC8YZ5ILi6pK0q+EojgVohg1UaEFr0N
         da3mxve4ghOjCUor36+x0betMRDiuCJJ0Vq3JPeDIwaoTouRIEc+RiMV/GbtRcfEf3Eb
         DuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQRGmRac3HoqPUI4eVx9DWNAF0av56DUKyJ6WrJqlvc=;
        b=nrNZOtwtCjxp3dTeIkV9+A/7EuO7AMl7QEWfbLgp0Zbp7KtZTPFdr0WvxU4LwzfxSA
         1Cd8K3h7jixe0lneDW5iAlSdKMW7gQxu4EOhx/L3/hiVAMLkQoJagupoMR4/mUiklIE9
         AXqwTNSvXxfCGarcNH0psowJtc2EsUWX32FCciJ10vAv6q+lduKlL/A0R+WLdxBhGCwW
         +xtvFMFNLIeVRR5GvqHkcBEo00xB7VFWKlhufl0dG4x1D7jndxA/aPzelu96G7nyqjJk
         qpjwm38S/yzxaLfr4/iszpirimiR5jTbP+JEVuqG7SWjBP/i1Px5s/kiPwMYhTVNiMyO
         vleA==
X-Gm-Message-State: AOAM530AXOcPZ32mHfT6vlwpbYO/pLxckRLPpSuWDXPvfRKBncRxz267
        TT6o7YTZJqPruuwK+fsFNCMirzGK4HT6stoMkY7qYQ==
X-Google-Smtp-Source: ABdhPJxeXoteXrOiqMqkfLkzjWg29B1Vx+7pl8RRzri12jbgH+IoZqPGUaSkWIYkFq1H5ptOTMVAci0rzRoCLSR1SxI=
X-Received: by 2002:ae9:c10c:0:b0:663:2047:2eed with SMTP id
 z12-20020ae9c10c000000b0066320472eedmr480140qki.221.1646336637693; Thu, 03
 Mar 2022 11:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-5-haoluo@google.com>
 <c323bce9-a04e-b1c3-580a-783fde259d60@fb.com> <CAADnVQ+q0vF03cH8w0c50XMZU1yf_0UjZ+ZarQ_RqMQrVpOFPA@mail.gmail.com>
 <93c3fc30-ad38-96fa-cf8e-20e55b267a3b@fb.com> <CAADnVQL4yxhDCLjvCCmpOtg0+8-HSg32KG07TCxx+L+Gji7n6g@mail.gmail.com>
In-Reply-To: <CAADnVQL4yxhDCLjvCCmpOtg0+8-HSg32KG07TCxx+L+Gji7n6g@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 3 Mar 2022 11:43:46 -0800
Message-ID: <CA+khW7gyOGgqJjyuSjJMJ8+iQmozZ6VhSJ7exZF0gGLOeS5gog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Introduce sleepable tracepoints
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 2, 2022 at 6:29 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 2, 2022 at 5:09 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 3/2/22 1:30 PM, Alexei Starovoitov wrote:
> > > On Wed, Mar 2, 2022 at 1:23 PM Yonghong Song <yhs@fb.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2/25/22 3:43 PM, Hao Luo wrote:
> > >>> Add a new type of bpf tracepoints: sleepable tracepoints, which allows
> > >>> the handler to make calls that may sleep. With sleepable tracepoints, a
> > >>> set of syscall helpers (which may sleep) may also be called from
> > >>> sleepable tracepoints.
> > >>
> > >> There are some old discussions on sleepable tracepoints, maybe
> > >> worthwhile to take a look.
> > >>
> > >> https://lore.kernel.org/bpf/20210218222125.46565-5-mjeanson@efficios.com/T/
> > >
> > > Right. It's very much related, but obsolete too.
> > > We don't need any of that for sleeptable _raw_ tps.
> > > I prefer to stay with "sleepable" name as well to
> > > match the rest of the bpf sleepable code.
> > > In all cases it's faultable.
> >
> > sounds good to me. Agree that for the bpf user case, Hao's
> > implementation should be enough.
>
> Just remembered that we can also do trivial noinline __weak
> nop function and mark it sleepable on the verifier side.
> That's what we were planning to do to trace map update/delete ops
> in Joe Burton's series.
> Then we don't need to extend tp infra.
> I'm fine whichever way. I see pros and cons in both options.

Joe is also cc'ed in this patchset, I will sync up with him on the
status of trace map work.

Alexei, do we have potentially other variants of tp? We can make the
current u16 sleepable a flag, so we can reuse this flag later when we
have another type of tracepoints.
