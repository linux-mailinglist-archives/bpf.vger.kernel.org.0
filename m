Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502D75EB03B
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 20:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiIZSlW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiIZSkx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 14:40:53 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453B213EA7
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:40:06 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-324ec5a9e97so78087457b3.7
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5hUUTlot75bUi6lFT1bK4YC3cIFpORtKOD1u4tJj+U8=;
        b=aQnB5HX/T549uRIbHX/lAhjAhKOU1wYtXb6phR444Er3lYBpTTeFUDBQkvkBGZUL0M
         ujc6jUNzOnuEtCjkoJsyVkZaYPbf74qasYOOkgVd8X1uI5ntZ8TMy6EwHB7UUkwlLZK2
         2Xrq9JaWF6XeAPXXwYB8YR07WLvZv496kCSPVTFo2wWqobzPt10YXZKPQkjaO93Z0lFH
         9YFOINq12PtZJwVO1CuQc4sS2C37nkHBp87F3n+hgHUQxSHjq2NjGbL9EjleH05Bv9O/
         v/MbjlHMR9NMsf4vnqyJg5Jj3twLn7em5Ce6u138+tEz5UltaiyngGGclqEm0KsGY7+O
         OmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5hUUTlot75bUi6lFT1bK4YC3cIFpORtKOD1u4tJj+U8=;
        b=Qu1SkNLpdNicP6R0ygxxXAhwLXdqGbQvGCE2jvt/4h4+6hKDjlCp/GwAwUmxKOkUou
         zXlOP3mJ5MXOeQN+NFnJykO6CJcaC1xGR8dc5aRKHN0MVcQJ0wCzW4iB4iZ+Xbs9Kwen
         QADiDxT4XEuUVEwzAGU878QGSscXJSqvrW7csUzfXNJS8c/OZ9Bi0l4wQhrMGkS7GjHQ
         OxEclU6iZYogp/fVxlHF/vAbEvZCZ3+06KrrgMYXSbPEF66cmz44XtL3jeNR/MQc56se
         amE3MiJGvb3aDae75PSFgAsHP2LhekIkEnuGnrbYpqeRpdc79CXPxmPqnRVU2pusb7HB
         Uiiw==
X-Gm-Message-State: ACrzQf0H1/aApbOx93zyCWb0cdfXWA5Pv5rQjTMaf0DVkkr6+ok5mdSp
        IZvmQ6ahHYH6RVJ0OZoosGh/0lJ/VtFfUDo2OTDX/g==
X-Google-Smtp-Source: AMsMyM42m1jDXWwvPKKCcB7cF0+mDgXqtvkffal5EgKFxA42voTGcH8VQlsteQOwPa2n8Q+kjk06svWGnnS3gmeq9do=
X-Received: by 2002:a81:910f:0:b0:345:de:d2e5 with SMTP id i15-20020a81910f000000b0034500ded2e5mr21673806ywg.102.1664217592482;
 Mon, 26 Sep 2022 11:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
 <4e66ca38-e99d-4fe5-b224-e36fb946878f@www.fastmail.com> <CA+khW7ittjLYfdHLpcVDGtpnXv1q-WPwRz-CqUTvFOSeywhBQA@mail.gmail.com>
 <e63e027d-c0a0-445c-94b7-c83d1d5dced5@www.fastmail.com>
In-Reply-To: <e63e027d-c0a0-445c-94b7-c83d1d5dced5@www.fastmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 26 Sep 2022 11:39:41 -0700
Message-ID: <CA+khW7jzrRsRzm4gHBC2qxWmXGqAKhORWRdJcjqKAynfrihSMQ@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Lorenz Bauer <oss@lmb.io>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 26, 2022 at 8:41 AM Lorenz Bauer <oss@lmb.io> wrote:
>
> On Fri, 23 Sep 2022, at 00:21, Hao Luo wrote:
[...]
>
> > For an idea mentioned in the summary,
> >
> >> In OBJ_GET, refuse a read-write fd if the fd passed to OBJ_PIN wasn't read-write.
> >
> > This sounds reasonable to me. Can we extend the object type referenced
> > by inode to include the permission?
>
> You're saying, add a layer of indirection? Instead of inode => bpf_map we have something like inode => bpf_perm => bpf_map.

Yes, that's what I mean.

> I think this is less user friendly than refusing !rw pin, since we decouple what you can do with a pinned file from the state that is observable via ls. Put another way, there should be a way to introspect bpf_perm if we end up going this way.
>
> I also think that this tries to plug the hole in the wrong place: it's not the caller of OBJ_GET that is escalating privs, is OBJ_PIN.

I actually think the problem is at OBJ_GET. I feel OBJ_GET is too
permissive, which can turn any pinned object into rw object.

I see what you meant by refusing !rw pin being more user-friendly. It
makes sense. We don't yet know how the introspection of bpf_perm will
look like. But on the other hand, I think introducing bpf_perm opens
up more potential use cases, because one can pin read-only objects and
allow others to get the object with less permissions. This is not
possible if refusing !rw pin in the first place.

I don't have strong opinions on the solution of this problem. Refusing
!rw pin is a simple solution, we can go for it and see how it works.
Thanks Lorenz for the ideas and discussions, let me know if there is
anything I can help with, this is interesting. :)

Hao
