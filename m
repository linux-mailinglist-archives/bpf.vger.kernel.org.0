Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E4E6BDCDA
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 00:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjCPXYJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 19:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCPXX5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 19:23:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C4F1B311
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 16:23:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eg48so13815154edb.13
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 16:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679009033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czqxP9PKM7+sbr7kRlouxObpRtVS1Q9gPct5d2Lfc04=;
        b=Vo6i5jTeuX4YFVd8w5O9TMhazZDgnrxOmxrBkMM5M07rDzSHUNX6SKWmWCiefuMNTv
         VZ0s/g3KLDevAF2LcWziEkqnr41/m1i3+xazeR7Bkh4Rt3vJ0k0BiEWm/3IaJoB9dyA0
         MFAyX2i0xv6Al+ZBR77qnd6oYrWtCo33H8I6UOt5G+zl9H2303eL8mjBrvLFoWMVcm21
         UI5+B1jZAUS+3EJXUs1II4m76H0S0b7JTdiquFEUZib7npsCSm9AhbpJi0JIKLepNCVj
         UmDBDe9bcDPZjafF8JVi75W8r7mzToxeKCPWq3dIffkeiiKOpUKb5cD1pL/O6TUqgPxq
         5lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679009033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czqxP9PKM7+sbr7kRlouxObpRtVS1Q9gPct5d2Lfc04=;
        b=5Q35PjZrMxK754EUsOubGspcaVQnuhsuKQnWnr2gAmuVQZry9dpL4PvTYjzFuyBn3o
         TP2pd5XkOZ1PwiXZLdPHPV5IlpwSHqBID2RXPbEA5mbPfOidJWitdwhk6v2AA1I+8Psj
         ctzhPqU+ikHaCDmaDGtoDp7DU5mPL2O9FZkZMn/6ZnGa5MPjMsk/AM5CbnSK3ZbeLD8N
         cladJhwQxxH3DV3wITrYBYdsjfF6IJexSkt33AOcwD2sEQ4xYwD+Ox/0H+hs7bfeGq6h
         RuHA52wgGmkHfMvtpYIQ81eRGkoJbZcQiDIh/yOFGjvfNNIvl3ZrNmSVf8aHUG0/Fbo0
         McmA==
X-Gm-Message-State: AO0yUKXxUPJhjm1qm3In+x9JEEc9UVBy5R7vqXZ5bXxWm3m0hAAP1TTM
        NcXm//E3kUnhNmRB3urxMr4b6OuYnuIHejYi7m0IYsK7
X-Google-Smtp-Source: AK7set+HIkuAv8hMEYWsn+FUZ9NxEqU59UEgh5HQU2SAlXux6MoYS8SF6Mv7XoNtZ1ntk37mDUHmaiEXibNVXToB9Gs=
X-Received: by 2002:a17:906:5619:b0:92b:e576:ea31 with SMTP id
 f25-20020a170906561900b0092be576ea31mr5519423ejq.5.1679009033474; Thu, 16 Mar
 2023 16:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230316063901.3619730-1-chantr4@gmail.com> <665c32ae4ef880c1811b8a8e3b35a7ad0bcfb054.camel@gmail.com>
 <ZBNGBAAki3VUU0bQ@worktop> <97845fbdc4178dd3d7bea836b245af2c82347b94.camel@gmail.com>
In-Reply-To: <97845fbdc4178dd3d7bea836b245af2c82347b94.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Mar 2023 16:23:41 -0700
Message-ID: <CAEf4BzZj6FP+=UYVXEq8bsqk0Os2zLKB2B60vyVO9+FL5jnttw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: add --json-summary option to test_progs
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 16, 2023 at 12:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Thu, 2023-03-16 at 09:38 -0700, Manu Bretelle wrote:
> > [...]
> >
> > I was originally going to do a nested structure similar to this too
> > (minus the repeat of test_* entries for subtests. But while discussing =
this
> > offline with Andrii, a flatter structured seemed to be easier to parse/=
manage
> > with tools such as `jq`. I am also very probably missing the right
> > incantation for `jq`.
> >
> > Finding whether a test has subtests (currently only adding failed ones,
> > but this could change in the future) would be easier (essentially check=
ing
> > length(subtests)). But neither is it difficult to reconstruct using
> > higher level language.
> >
>
> `jq` query is a bit more complicated with nested structure, but not terri=
bly so:
>
>   $ cat query.jq
>   .results | map([
>                   .test_name,
>                   (.subtests | map([([.test_name, .subtest_name] | join("=
/")) ]))
>                  ])
>            | flatten

we should record this in the commit, if we go with nested structure :)
it's not "terribly more complicated", but not obvious either for
someone who uses jq very occasionally :)

>
>   $ jq -f query.jq test.json
>   [
>     "test_global_funcs",
>     "test_global_funcs/global_func16"
>   ]
>
> Test data for reference:
>
>   $ cat test.json | sed -r 's/"[^"]{20,}"/"..."/g'
>   {
>       "success": 1,
>       "success_subtest": 24,
>       "skipped": 0,
>       "failed": 1,
>       "results": [{
>               "test_name": "test_global_funcs",
>               "test_number": 223,
>               "message": "...",
>               "failed": true,
>               "subtests": [{
>                       "test_name": "test_global_funcs",
>                       "subtest_name": "global_func16",
>                       "test_number": 223,
>                       "subtest_number": 16,
>                       "message": "...",
>                       "is_subtest": true,
>                       "failed": true
>                   }
>               ]
>           }
>       ]
>   }
>
> > In term of logical structure and maybe extensibility, this is more appr=
opriate,
> > in term of pragmatism maybe less.
> >
> > I don't have strong opinions and can see benefit for both.
>
> idk, I don't have a strong opinion either.

me neither, flatter struct would be simple to work with either with jq
or hacky grepping, so I guess the question would be how much do we
lose by using flatter structure?

>
> > [...]
