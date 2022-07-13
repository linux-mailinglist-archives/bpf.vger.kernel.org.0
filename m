Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33323572AB9
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 03:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiGMBUf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 21:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiGMBUf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 21:20:35 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBD65A456
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:20:34 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id b2so5111790qkk.3
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owSC8REchaM4Ok9cG4I7IkXl7i+VlUCURqS3t3MNdUg=;
        b=Lt7Cm0M/qnKIbv708dAwcafMgE5/uuOlHdbEsh7xLpAXQKxwxv8Z2PYn8fijNloQ9c
         d5yheS8aSum94/UWvXj27DQm14CKC6DgCYMsai3fJbJGrp/U4IUFnVY+kYYkc3tSOfdG
         PCD4HY8zTm02xTztVNrYmjPdjmOi/TnwiTLyPqXTNxEXapfMtMhzYkBssazpxcKlpwmj
         D4If/ecAtei+wDfO2LrYShqZ1jZT0SKYZZ6kvOcpPwPnk7QbOCZlZooazZDuEX++MTBp
         6y2KwY5BuOKfQUqPrFMXEQvQ/QN5hiz6XVxSXWUNhUB4wrs92fT5Qx4ORawFszbUzajh
         N9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owSC8REchaM4Ok9cG4I7IkXl7i+VlUCURqS3t3MNdUg=;
        b=Lxd/eZlUqewUHvC8gcUNKfvXBonHSasnmCtyPqs03xLRUs4C03j0A+fSuJXUzINg9B
         ybdfRdqy8RydoZs/kVKrcYcfl6kQDnz85yt54DNBWrgNW42d+ccsRqiDU7vY4jWrKhVE
         kIO/+3c73IC3//wG/5X/htuYH4cG1VihibOzzrr98/Fg5en3H3njKYUYbqzWQJT75C2L
         AyiODSX/UOSDFY71FpdOfInwW9MPj378Hj9nWAEu9gjjtN3uf5NT1BVZCacfu+4nLkmG
         GYf6pWgm1NLNdeFTHVn3xeZdASz6HhP3rjcyTJaPbaw7JB5rdkSfUiC4o5buBmb+f0wb
         R7Lg==
X-Gm-Message-State: AJIora9NBHO0PN8RWKkEhgXVT+NnBCzIsZyX/v2pU2Pftzq3GVlnEc4G
        z5XSOQzn4QF/CGJrEnSZgVzSp8//5xIE/w/88q+K+g==
X-Google-Smtp-Source: AGRyM1t9gGIo3uuXfqDB7pCYzBf88PBj4iLEW/X5VwSdXbBj7Gg7CVAPD8rzdb+0aueo1gNcdeLV8ohPjbRZ+STzqh8=
X-Received: by 2002:ae9:e80d:0:b0:6b5:9875:4e8a with SMTP id
 a13-20020ae9e80d000000b006b598754e8amr825569qkg.267.1657675232746; Tue, 12
 Jul 2022 18:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220712210603.123791-1-joannelkoong@gmail.com>
 <Ys35McCz+TZEdorp@google.com> <CAJnrk1bVEBXUUjp71+VFaYrRqsDharKRfpvb1theJQ-fP5+EKQ@mail.gmail.com>
In-Reply-To: <CAJnrk1bVEBXUUjp71+VFaYrRqsDharKRfpvb1theJQ-fP5+EKQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 12 Jul 2022 18:20:21 -0700
Message-ID: <CA+khW7jL+ajYEBXO_ge5gTHZ9ga+pAAzpvHSjyh+NtK=GL3RXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Tidy up verifier check_func_arg()
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     sdf@google.com, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 6:10 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> On Tue, Jul 12, 2022 at 3:44 PM <sdf@google.com> wrote:
> >
> > On 07/12, Joanne Koong wrote:
> > > This patch does two things:
> >
> > > 1. For matching against the arg type, the match should be against the
> > > base type of the arg type, since the arg type can have different
> > > bpf_type_flags set on it.
> >
> > Does this need a fixes tag? Something around the following maybe:
> >
> > Fixes: d639b9d13a39 ("bpf: Introduce composable reg, ret and arg types.")
> >
> > ?
> I will add that tag. Thanks!

Joanne and Stan, IMO this is not necessary. I think this change is a
cleanup rather than a fix.

> >
> > > 2. Uses switch casing to improve readability + efficiency.
> >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
[...]
> >
