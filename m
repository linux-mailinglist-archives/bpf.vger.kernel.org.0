Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DDA68C51E
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 18:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBFRtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 12:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBFRtQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 12:49:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11BF1CF41;
        Mon,  6 Feb 2023 09:49:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D29D60FC6;
        Mon,  6 Feb 2023 17:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C15C4339B;
        Mon,  6 Feb 2023 17:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675705752;
        bh=Q6U8O/+O8ktOW5TwrWzmYYWFhoc5mnoVra9PevbBKu4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kToAHsCE73O3vI265cOKmjo7Hp/5wz+aPNK6vuMejLSCRc4y7p04MigexbGCOzvac
         aZ6T3vCpEbS4FpA+jAT63YzdSVOeVxNTN2oVBgt7Egzm0PQ0lon4MzjwP4u8Qa2MxT
         WYJbAWaGaZVpBtB0R/M5HbEFPn9Nr3I66zQMSan2GVc/8Qb1BxL/uMxZxWzmlWkUgi
         /Zxe7RdH9F5JmB7hM5MUF8LEqlJdei0oQms5dgizdfLtwRT4mo6/7Gp9fJuVQwUIb6
         OE6CUhZbkjSUYDxVpTxrUAryhCLB/Dk0mKE4KWXWVP5wq/F/XuMoq1HoJQK+yEEmdj
         80g9YiK8ZRq5A==
Received: by mail-lf1-f43.google.com with SMTP id j17so18788394lfr.3;
        Mon, 06 Feb 2023 09:49:12 -0800 (PST)
X-Gm-Message-State: AO0yUKWKP/v0uQ9hN99o+tJSCi23QZYX3sg19XiH5rx8QCpK1lHxXFwK
        cR/a7PgBaI6x862ZaB3qICFmfmuwwrpT8LXuxLo=
X-Google-Smtp-Source: AK7set/MtMP/TeNFMAuG8UTa7R5RNt6agX9+RtocVxWMfng3xHZhRy8VqYERZK7W4TnN0fCfFPEXBBhwUbOmJOft32Y=
X-Received: by 2002:a05:6512:31b:b0:4d5:82bb:c06d with SMTP id
 t27-20020a056512031b00b004d582bbc06dmr4922983lfp.256.1675705750725; Mon, 06
 Feb 2023 09:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20230120000818.1324170-1-kpsingh@kernel.org> <20230120000818.1324170-4-kpsingh@kernel.org>
 <202301192004.777AEFFE@keescook> <CACYkzJ75nYnunhcAaE-20p9YHLzVynUEAA+uK1tmGeOWA83MjA@mail.gmail.com>
 <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com>
In-Reply-To: <db1fed31-0283-5401-cf55-d18a98ca33ae@schaufler-ca.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 6 Feb 2023 09:48:56 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
Message-ID: <CAPhsuW4C8NU15mjetX8Ucp3R66xEgOGS6udiaauUtPg06Si93Q@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next 3/4] security: Replace indirect LSM hook
 calls with static calls
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, paul@paul-moore.com, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 6, 2023 at 8:29 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 2/6/2023 5:04 AM, KP Singh wrote:
> > On Fri, Jan 20, 2023 at 5:36 AM Kees Cook <keescook@chromium.org> wrote:
> >> On Fri, Jan 20, 2023 at 01:08:17AM +0100, KP Singh wrote:
> >>> The indirect calls are not really needed as one knows the addresses of
> > [...]
> >
> >>> +/*
> >>> + * Define static calls and static keys for each LSM hook.
> >>> + */
> >>> +
> >>> +#define DEFINE_LSM_STATIC_CALL(NUM, NAME, RET, ...)                  \
> >>> +     DEFINE_STATIC_CALL_NULL(LSM_STATIC_CALL(NAME, NUM),             \
> >>> +                             *((RET(*)(__VA_ARGS__))NULL));          \
> >>> +     DEFINE_STATIC_KEY_FALSE(SECURITY_HOOK_ENABLED_KEY(NAME, NUM));
> >> Hm, another place where we would benefit from having separated logic for
> >> "is it built?" and "is it enabled by default?" and we could use
> >> DEFINE_STATIC_KEY_MAYBE(). But, since we don't, I think we need to use
> >> DEFINE_STATIC_KEY_TRUE() here or else won't all the calls be
> >> out-of-line? (i.e. the default compiled state will be NOPs?) If we're
> >> trying to optimize for having LSMs, I think we should default to inline
> >> calls. (The machine code in the commit log seems to indicate that they
> >> are out of line -- it uses jumps.)
> >>
> > I should have added it in the commit description, actually we are
> > optimizing for "hot paths are less likely to have LSM hooks enabled"
> > (eg. socket_sendmsg).
>
> How did you come to that conclusion? Where is there a correlation between
> "hot path" and "less likely to be enabled"?

I could echo KP's reasoning here. AFAICT, the correlation is that LSMs on
hot path will give more performance overhead. In our use cases (Meta),
we are very careful with "small" performance hits. 0.25% is significant
overhead; 1% overhead will not fly without very good reasons (Do we
have to do this? Are there any other alternatives?). If it is possible to
achieve similar security on a different hook, we will not enable the hook on
the hot path. For example, we may not enable socket_sendmsg, but try
to disallow opening such sockets instead.

>
> >  But I do see that there are LSMs that have these
> > enabled. Maybe we can put this behind a config option, possibly
> > depending on CONFIG_EXPERT?
>
> Help me, as the maintainer of one of those LSMs, understand why that would
> be a good idea.

IIUC, this is also from performance concerns. We would like to manage
the complexity at compile time for performance benefits.

Thanks,
Song
