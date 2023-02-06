Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D318968C5FA
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 19:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBFSlU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 13:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjBFSlT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 13:41:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60C1173F
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 10:41:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5393960FE7
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 18:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AE6C433D2
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675708876;
        bh=oOMpg7emTkWZU2H/ZsgIjfB5+CQw7lokK4mm+w0Hy3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HioZLp25aUlFTV7jUkFQSDu5kjB4GWWnCtM/rxGVeOX3OiXLPdlPHOwrIxM/C7olD
         sYTTm45OKZIUosqvVQDqD62RhEIrgq7je7lZKtq+iMe4Y1XOlvf20AB7UAS4sc6PX/
         ynjxaUiC6dtf98i/hyOqbydBf0r4pwaMMygp29Dz5pOPf0qSOfOIJhnct6DbTDere2
         Rp5JrfN4BEBi3tpMdGTI3FuBZzogDhE2lOEgAhZd1+bp89/PUrvS5UbLVFNM0tlWZF
         ILpuZ2XjDKlJYqCBQvBAo/aZ3trj8JXknOVs63AOTlxFCpjBWDvyBnNCKYQwIkgNkc
         QqOtmzfsoYv8g==
Received: by mail-ej1-f47.google.com with SMTP id mc11so36847680ejb.10
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 10:41:16 -0800 (PST)
X-Gm-Message-State: AO0yUKVxuNt3QW4bkeSU16vT2V2aHEG4G/+d7bUrTj5xajxeIp3033V5
        r1nVuraUEdRwfWSqdXB0NGkALKOIE6EVKGHuk1FsLg==
X-Google-Smtp-Source: AK7set8zY6vRAb1K82VeKVSyQrTv57YeHRdzbPXbcMdciVgLb7hWlBdldG20nLx+O9y1iXzNrC1xpnsSN4Q4Ei8A8yA=
X-Received: by 2002:a17:906:53d8:b0:87c:c2eb:6dfa with SMTP id
 p24-20020a17090653d800b0087cc2eb6dfamr97269ejo.204.1675708874928; Mon, 06 Feb
 2023 10:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20230120000818.1324170-1-kpsingh@kernel.org> <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook> <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
 <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com> <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
 <8b5f62f3-a2c4-9ba3-d1e4-af557047f44b@schaufler-ca.com>
In-Reply-To: <8b5f62f3-a2c4-9ba3-d1e4-af557047f44b@schaufler-ca.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 6 Feb 2023 19:41:04 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7=xPB-mzAq-GBszm2Q3NapVNbcrqBdSS0FZsTeTbL9QA@mail.gmail.com>
Message-ID: <CACYkzJ7=xPB-mzAq-GBszm2Q3NapVNbcrqBdSS0FZsTeTbL9QA@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Song Liu <song@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 6, 2023 at 7:29 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 2/6/2023 9:48 AM, Song Liu wrote:
> > On Mon, Feb 6, 2023 at 8:29 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 2/6/2023 5:04 AM, KP Singh wrote:
> >>> On Fri, Jan 20, 2023 at 5:36 AM Kees Cook <keescook@chromium.org> wrote:
> >>>> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
> >>>>> The indirect calls are not really needed as one knows the addresses of
> >>> [...]
> >>>
> >>>>> +/*
> >>>>> + * Define static calls and static keys for each LSM hook.
> >>>>> + */
> >>>>> +
> >>>>> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)                  \
> >>>>> +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),             \
> >>>>> +                             *((RET(*)(__VA_ARGS__))NULL));          \
> >>>>> +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME, NUM));
> >>>> Hm, another place where we would benefit from having separated logic for
> >>>> "is it built?" and "is it enabled by default?" and we could use
> >>>> DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we need to use
> >>>> DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
> >>>> out-of-line? (i.e. the default compiled state will be NOPs?) If we're
> >>>> trying to optimize for having LSMs, I think we should default to inline
> >>>> calls. (The machine code in the commit log seems to indicate that they
> >>>> are out of line -- it uses jumps.)
> >>>>
> >>> I should have added it in the commit description, actually we are
> >>> optimizing for "hot paths are less likely to have LSM hooks enabled"
> >>> (eg. socket_sendmsg).
> >> How did you come to that conclusion? Where is there a correlation between
> >> "hot path" and "less likely to be enabled"?
> > I could echo KP's reasoning here. AFAICT, the correlation is that LSMs on
> > hot path will give more performance overhead. In our use cases (Meta),
> > we are very careful with "small" performance hits. 0.25% is significant
> > overhead; 1% overhead will not fly without very good reasons (Do we
> > have to do this? Are there any other alternatives?). If it is possible to
> > achieve similar security on a different hook, we will not enable the hook on
> > the hot path. For example, we may not enable socket_sendmsg, but try
> > to disallow opening such sockets instead.
>
> I'm not asking about BPF. I'm asking about the impact on other LSMs.
> If you're talking strictly about BPF you need to say that. I'm all for
> performance improvement. But as I've said before, it should be for all
> the security modules, not just BPF.

It's a trade off that will work differently for different LSMs and
distros (based on the LSM they chose) and this the config option. I
even suggested this be behind CONFIG_EXPERT (which is basically says
this:

 "This option allows certain base kernel options and settings
 to be disabled or tweaked. This is for specialized
 environments which can tolerate a "non-standard" kernel.
 Only use this if you really know what you are doing."


>
> >
> >>>  But I do see that there are LSMs that have these
> >>> enabled. Maybe we can put this behind a config option, possibly
> >>> depending on CONFIG_EXPERT?
> >> Help me, as the maintainer of one of those LSMs, understand why that would
> >> be a good idea.
> > IIUC, this is also from performance concerns. We would like to manage
> > the complexity at compile time for performance benefits.
>
> What complexity? What config option? I know that I'm slow, but it looks
> as if you're suggesting making the LSM infrastructure incredibly fragile
> and difficult to understand.

I am sorry but the LSM is a core piece of the kernel that currently
has significant unnecessary overheads (look at the numbers that I
posted) and this not making it fragile, it's making it performant,
such optimisations are everywhere in the kernel and the LSM
infrastructure has somehow been neglected and is just catching up.
These are resources being wasted which could be saved.

>
> >
> > Thanks,
> > Song
