Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F4068C622
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 19:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBFSvD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 13:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFSvB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 13:51:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AC8193FB
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 10:50:57 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id pj3so12525074pjb.1
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 10:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HVH5gtsNLCSDGDZFyLphSEPHrugkVjQ6fi1m3xd0EAU=;
        b=ESQk6pJNxt69nqaS4Pl+XhuUP1l4DfPnk5fATJA8VLjkoMwEfG/tP9oV0BQ+xXilmd
         zVeeBmJmBGeUiJF7DURi45pEoG5Irtcr7xuibq6yCSvLlOHJvjmfZ6FOeg/GyU1gh6rW
         DTXHkF9tPk8AZLFIrMcilowbJbSNUVB+3I5PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVH5gtsNLCSDGDZFyLphSEPHrugkVjQ6fi1m3xd0EAU=;
        b=yG1++ogdzrtuX/kCVXzCiuPvcS5SU36a3aZG8uqvZyOVCdPp4+6i+/k4FIlellMlfH
         0dGDo7L6hlfj5bvYNzmsSlH0J+K/NCBn+MIKeEBmBcSiRUhrTRdg0wN9He7ufVFH1J4H
         0TAgX856Zi8A9Vv3Gbm8F8zViLi0HL00YRiAqFpdoVqilWIaWvM5nReEC+FT75tXDnZk
         Oxk5JdstONrF0TYgmqia4NO280T0G9Vh+CIYnvNSw98oHI752Trglgx4GsaGOJYxy3se
         lmbDcf0mfIWPnSjDwrobKdOS03HH2TE7PQJttPjsO8vld22f2UB0DmwiMbmBpBfoJWq/
         lNtw==
X-Gm-Message-State: AO0yUKXRShdVLBMOxNva7LVO6WZxTcrIPJZNFHngqwsJxvrimpJXZJrE
        iAU1LfNQmJ34pfQLkkNexnAs9omlh6xBVXyL
X-Google-Smtp-Source: AK7set+hqfrgGeZJf9HmNepkBbWtR1QsrTUXTvh3Ykh/m82ZEMyT9HnMdvse70kZaUB6mCWDjrYxVQ==
X-Received: by 2002:a17:902:cf44:b0:199:2b9f:f370 with SMTP id e4-20020a170902cf4400b001992b9ff370mr191287plg.1.1675709456706;
        Mon, 06 Feb 2023 10:50:56 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v16-20020a17090331d000b001948cc9c2fbsm7274738ple.133.2023.02.06.10.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:50:56 -0800 (PST)
Message-ID: <63e14c10.170a0220.beb2a.bc4c@mx.google.com>
X-Google-Original-Message-ID: <202302061047.@keescook>
Date:   Mon, 6 Feb 2023 10:50:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, revest@chromium.org
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
References: <20230120000818.1324170-1-kpsingh@kernel.org>
 <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook>
 <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
 <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com>
 <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
 <8b5f62f3-a2c4-9ba3-d1e4-af557047f44b@schaufler-ca.com>
 <CACYkzJ7=xPB-mzAq-GBszm2Q3NapVNbcrqBdSS0FZsTeTbL9QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ7=xPB-mzAq-GBszm2Q3NapVNbcrqBdSS0FZsTeTbL9QA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 06, 2023 at 07:41:04PM +0100, KP Singh wrote:
> On Mon, Feb 6, 2023 at 7:29 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 2/6/2023 9:48 AM, Song Liu wrote:
> > > On Mon, Feb 6, 2023 at 8:29 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >> On 2/6/2023 5:04 AM, KP Singh wrote:
> > >>> On Fri, Jan 20, 2023 at 5:36 AM Kees Cook <keescook@chromium.org> wrote:
> > >>>> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
> > >>>>> The indirect calls are not really needed as one knows the addresses of
> > >>> [...]
> > >>>
> > >>>>> +/*
> > >>>>> + * Define static calls and static keys for each LSM hook.
> > >>>>> + */
> > >>>>> +
> > >>>>> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)                  \
> > >>>>> +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),             \
> > >>>>> +                             *((RET(*)(__VA_ARGS__))NULL));          \
> > >>>>> +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME, NUM));
> > >>>> Hm, another place where we would benefit from having separated logic for
> > >>>> "is it built?" and "is it enabled by default?" and we could use
> > >>>> DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we need to use
> > >>>> DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
> > >>>> out-of-line? (i.e. the default compiled state will be NOPs?) If we're
> > >>>> trying to optimize for having LSMs, I think we should default to inline
> > >>>> calls. (The machine code in the commit log seems to indicate that they
> > >>>> are out of line -- it uses jumps.)
> > >>>>
> > >>> I should have added it in the commit description, actually we are
> > >>> optimizing for "hot paths are less likely to have LSM hooks enabled"
> > >>> (eg. socket_sendmsg).
> > >> How did you come to that conclusion? Where is there a correlation between
> > >> "hot path" and "less likely to be enabled"?
> > > I could echo KP's reasoning here. AFAICT, the correlation is that LSMs on
> > > hot path will give more performance overhead. In our use cases (Meta),
> > > we are very careful with "small" performance hits. 0.25% is significant
> > > overhead; 1% overhead will not fly without very good reasons (Do we
> > > have to do this? Are there any other alternatives?). If it is possible to
> > > achieve similar security on a different hook, we will not enable the hook on
> > > the hot path. For example, we may not enable socket_sendmsg, but try
> > > to disallow opening such sockets instead.
> >
> > I'm not asking about BPF. I'm asking about the impact on other LSMs.
> > If you're talking strictly about BPF you need to say that. I'm all for
> > performance improvement. But as I've said before, it should be for all
> > the security modules, not just BPF.
> 
> It's a trade off that will work differently for different LSMs and
> distros (based on the LSM they chose) and this the config option. I
> even suggested this be behind CONFIG_EXPERT (which is basically says
> this:
> 
>  "This option allows certain base kernel options and settings
>  to be disabled or tweaked. This is for specialized
>  environments which can tolerate a "non-standard" kernel.
>  Only use this if you really know what you are doing."

Using the DEFINE_STATIC_KEY_MAYBE() and static_branch_maybe() macros
tied to a new CONFIG seems like it can give us a reasonable knob for
in-line vs out-of-line calls.

> > >>>  But I do see that there are LSMs that have these
> > >>> enabled. Maybe we can put this behind a config option, possibly
> > >>> depending on CONFIG_EXPERT?
> > >> Help me, as the maintainer of one of those LSMs, understand why that would
> > >> be a good idea.
> > > IIUC, this is also from performance concerns. We would like to manage
> > > the complexity at compile time for performance benefits.
> >
> > What complexity? What config option? I know that I'm slow, but it looks
> > as if you're suggesting making the LSM infrastructure incredibly fragile
> > and difficult to understand.
> 
> I am sorry but the LSM is a core piece of the kernel that currently
> has significant unnecessary overheads (look at the numbers that I
> posted) and this not making it fragile, it's making it performant,
> such optimisations are everywhere in the kernel and the LSM
> infrastructure has somehow been neglected and is just catching up.
> These are resources being wasted which could be saved.

Let's just move forward to v2, which I think will look much cleaner. I
think we can get to both maintainable code and run-time performance with
this series.

-- 
Kees Cook
