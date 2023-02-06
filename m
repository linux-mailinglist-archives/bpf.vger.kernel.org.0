Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6722568C599
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 19:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBFSTl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 13:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBFSTi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 13:19:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512BF2D4F
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 10:19:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BA04B815B1
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 18:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAD6C433A1
        for <bpf@vger.kernel.org>; Mon,  6 Feb 2023 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675707574;
        bh=9FO1UbEf8YHFmiTB0KZkS7B5W296ywbqyj2o66NVD5g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YptveKfVbeL/cI8JUD0Jr+4B6/w2h/ZdKlm5cVdKEaEk5JtRSH4SvJG0oydgRs8YI
         8upldQn2bGg01y/irH89cTwKJStHeMtqs/YWgxZDaksrhLKiri1h3CyoSjrVoD3iOa
         3M0saCPY/x0ouoeI3MHAy0t6uEjFB+2/sciMoi/os1kGvg1qzgdRQGwamxieLSSp84
         7zAvE3oqobCFzed5QhPlu5X8FHnwek8lhLc/JlNz2p2acOL1J8zwJQbkNVYEkDVY1a
         LIlJIoVQBEaWz8gogYU+TrQqVo1QUDDIexzaUYkiy9oazlr5h+89HbCWfsc1jK7efN
         ifWrPho4Z1xxg==
Received: by mail-ej1-f47.google.com with SMTP id e22so7401002ejb.1
        for <bpf@vger.kernel.org>; Mon, 06 Feb 2023 10:19:34 -0800 (PST)
X-Gm-Message-State: AO0yUKUSHKmXc+zMAr1+lAeP/eobMOO4u/rkwUa+iU3ialRHWch4jVLT
        Y3imasLegh9XLYTqE3oKpmcsPVmbgp/DpG66gqMzpQ==
X-Google-Smtp-Source: AK7set/62grWCqAae9xHJ1fG7puzQ2ciFFN6zfRWTUMnO9nX8ggqkErBrEuW7cSADF/lS8oWBgsRM2AWhXhVSw5SeQY=
X-Received: by 2002:a17:906:53d8:b0:87c:c2eb:6dfa with SMTP id
 p24-20020a17090653d800b0087cc2eb6dfamr75568ejo.204.1675707572830; Mon, 06 Feb
 2023 10:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20230120000818.1324170-1-kpsingh@kernel.org> <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook> <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
 <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com> <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
In-Reply-To: <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 6 Feb 2023 19:19:22 +0100
X-Gmail-Original-Message-ID: <CACYkzJ62BdqaUp5ufTq7dW32=N_yP0AaMoYoH-KJK2J6ax+D0w@mail.gmail.com>
Message-ID: <CACYkzJ62BdqaUp5ufTq7dW32=N_yP0AaMoYoH-KJK2J6ax+D0w@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
To:     Song Liu <song@kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
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

On Mon, Feb 6, 2023 at 6:49 PM Song Liu <song@kernel.org> wrote:
>
> On Mon, Feb 6, 2023 at 8:29 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 2/6/2023 5:04 AM, KP Singh wrote:
> > > On Fri, Jan 20, 2023 at 5:36 AM Kees Cook <keescook@chromium.org> wrote:
> > >> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
> > >>> The indirect calls are not really needed as one knows the addresses of
> > > [...]
> > >
> > >>> +/*
> > >>> + * Define static calls and static keys for each LSM hook.
> > >>> + */
> > >>> +
> > >>> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)                  \
> > >>> +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),             \
> > >>> +                             *((RET(*)(__VA_ARGS__))NULL));          \
> > >>> +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME, NUM));
> > >> Hm, another place where we would benefit from having separated logic for
> > >> "is it built?" and "is it enabled by default?" and we could use
> > >> DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we need to use
> > >> DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
> > >> out-of-line? (i.e. the default compiled state will be NOPs?) If we're
> > >> trying to optimize for having LSMs, I think we should default to inline
> > >> calls. (The machine code in the commit log seems to indicate that they
> > >> are out of line -- it uses jumps.)
> > >>
> > > I should have added it in the commit description, actually we are
> > > optimizing for "hot paths are less likely to have LSM hooks enabled"
> > > (eg. socket_sendmsg).
> >
> > How did you come to that conclusion? Where is there a correlation between
> > "hot path" and "less likely to be enabled"?
>
> I could echo KP's reasoning here. AFAICT, the correlation is that LSMs on
> hot path will give more performance overhead. In our use cases (Meta),
> we are very careful with "small" performance hits. 0.25% is significant

+1 to everything Song said, I am not saying that one direction is
better than the other and for distros that have LSMs (like SELinux and
AppArmor enabled) it's okay to have this default to
static_branch_likely. On systems that will have just the BPF LSM
enabled, it's the opposite that is true, i.e. one would never add a
hook on a hotpath as the overheads are unacceptable, and when one does
add a hook, they are willing to add the extra overhead (this is
already much less compared to the indirect calls). I am okay with the
default being static_branch_likely if that's what the other LSM
maintainers prefer.


> overhead; 1% overhead will not fly without very good reasons (Do we
> have to do this? Are there any other alternatives?). If it is possible to
> achieve similar security on a different hook, we will not enable the hook on
> the hot path. For example, we may not enable socket_sendmsg, but try
> to disallow opening such sockets instead.
>
> >
> > >  But I do see that there are LSMs that have these
> > > enabled. Maybe we can put this behind a config option, possibly
> > > depending on CONFIG_EXPERT?
> >
> > Help me, as the maintainer of one of those LSMs, understand why that would
> > be a good idea.
>
> IIUC, this is also from performance concerns. We would like to manage
> the complexity at compile time for performance benefits.
>
> Thanks,
> Song
