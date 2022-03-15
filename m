Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B73E4DA212
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 19:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350973AbiCOSJK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 14:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350978AbiCOSJJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 14:09:09 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E266375
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:07:57 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id q6so17899ilv.6
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EKD+GpPgfonm5ng1sSfjeJ53FmOU7ZMaaAf1xdWbs7Q=;
        b=D5IXVDd047uQGXIbYpugS8nAKIpekG8mXYAiAhvUPbDl3atqDXpdBhao6a2SG/DzxE
         kIBjS59Y2QGNjlPOrIqyBVaITdADQQEllJ2k3o3L6YNaNzE6syQFICcv7w8Kp/1TW3Uo
         4KlTjqS3rM4OirPuKiaEw/r3Dmv4NOn3cFIB6gYj1KgdOoXPOy8+VpVUVfQXsMCZ1YV8
         8BN7eVpmflq1pXPgnSSWrC6sVPPJLqQd5CTdQv8L2uxVrrSn0dkQ2XCNOeJklpwm+GX/
         5F7h4dvjRehRK5dJX0oY0twQ967hntM2+sbAMlB2KFZ7Y/jKTGFBraB0bFXKQwLU9AH0
         AsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EKD+GpPgfonm5ng1sSfjeJ53FmOU7ZMaaAf1xdWbs7Q=;
        b=tWGpsm/aQsXQFfsyKA0wXS1cuDFhsPhFqzYvJThGEIozGAUfCcOzggLEFAQk9cf0vy
         trmK9j/XAQozKDloQBlymIDLxzIkMc/mSQdCeWmyfzg4G8mOpXNf5t0MPdhTYLSFNgog
         vHLsGXBmWBo6Kt3k3k0NTXyM0w9WR2AHtLYoDutBitUpvnHrvhTv+Z8pzgZbrIzgWkGW
         Vd/K4GkjlMy4vlWy0qFY015Obldwxkj65bMVAc6EYmmhSTjE7mS1c06Kjfkc8PqwZ4hr
         TVKDR5wLSScboe/MKEKvR+Sy6hNm9YRPqYpV+6n9aextnZ31huvR7drnz9wciUnv7n9L
         FfeA==
X-Gm-Message-State: AOAM533RF+OeEJ3e3Ze0EyToOShVxsG8BrGUzBc9oQfrrjyg3if0kCb3
        By35Hr7UuQn0K45DqI5QMTKmaThM2mjaJc0MyBg=
X-Google-Smtp-Source: ABdhPJwvecCJQfWMlzAfbeZ7pUuxPVqIdy7DWzRmUfKPObsqXdrA3G8jQAn+xG4MARtE91uS7dtGb+6g8CfT455gBX0=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr22536797ilb.305.1647367677143; Tue, 15
 Mar 2022 11:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646957399.git.delyank@fb.com> <d3ee2b3bb282e8aa0e6ab01ca4be522004a7cba0.1646957399.git.delyank@fb.com>
 <CAEf4BzaeycEUjZVCd+7sxFaQWfbqhmsMd_G_bydS15+45LcDvA@mail.gmail.com>
 <e3e84d87c2a0c13ae9f20e44493c1578e06b6618.camel@fb.com> <534afc41cb3066ed049f0ab15ef65d32d30a33d3.camel@fb.com>
In-Reply-To: <534afc41cb3066ed049f0ab15ef65d32d30a33d3.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 11:07:46 -0700
Message-ID: <CAEf4Bza_smVP6xnR3S56K_U3Dr=XyU+Amc2uMAUtH+0OiNT4kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpftool: add support for subskeletons
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 10:28 AM Delyan Kratunov <delyank@fb.com> wrote:
>
> On Mon, 2022-03-14 at 16:13 -0700, Delyan Kratunov wrote:
> > Thanks, Andrii! The nits/refactors are straightforward but have some questions
> > below:
> >
> > On Fri, 2022-03-11 at 15:27 -0800, Andrii Nakryiko wrote:
> > > > +
> > > > +                       /* sanitize variable name, e.g., for static vars inside
> > > > +                        * a function, it's name is '<function name>.<variable name>',
> > > > +                        * which we'll turn into a '<function name>_<variable name>'.
> > > > +                        */
> > > > +                       sanitize_identifier(var_ident + 1);
> > >
> > > btw, I think we don't need sanitization anymore. We needed it for
> > > static variables (they would be of the form <func_name>.<var_name> for
> > > static variables inside the functions), but now it's just unnecessary
> > > complication
> >
> > How would we handle static variables inside functions in libraries then?
>
> Ah, just realized 31332ccb7562 (bpftool: Stop emitting static variables in BPF
> skeleton) stopped that. I'll remove the sanitization then.
>

yep

> [...]
>
>
> > > we don't know the name of the final object, why would we allow to set
> > > any object name at all?
> >
> > We don't really care about the final object name but we do need an object name
> > for the subskeleton. The subskeleton type name, header guard etc all use it.
> > We can say that it's always taken from the file name, but giving the user the
> > option to override it feels right, given the parallel with skeletons (and what
> > would we do if the file name is a pipe from a subshell invocation?).
>
> In particular, with the current test setup, if we don't use the name param, we'd
> end up inferring names like test_subskeleton_lib_linked3 from the filename. The
> tests case is a bit contrived and we can work around it but there may be other
> similar situations out there.
>

yep


>
> -- Delyan
