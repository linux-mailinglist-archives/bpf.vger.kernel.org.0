Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59FF62C8AD
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 20:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiKPTFA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 14:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKPTE5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 14:04:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97D15802E
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 11:04:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41F7261F6B
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 19:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F11C433B5
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668625495;
        bh=ggjBHz/iXOJuB+7T8rB0pJMs8tHXxqRRao0/V4leHlk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S9vbF+Y88A6uSIVAnsUXVA/q92/UiHzeT8YhSxacbWIgzcMYKZ32Lr3yNmhQFJYMl
         5C78L5HU4/aiHlZjzy1OdQHtXQnsC/Zk+QeyM8I5EXx4lbd1sDSRwtikRpHz3WpuMX
         yNihl/OID7CECeenLwpj+B8RDYfV5uyWnBDVyyTwsNp+I3dYM9mTL1iFy1mD32WHEI
         JpUgF1ONqEwYZcPTZtKe0i4ySsFkmtpXiF8YQ2k5CAmVfO+en2QGGLZ7wg0ibsFwYx
         C6z8IOInQjWAWrJFJlq5Iv3n0BVlRWulZyVM2H0ZC0wQIILR3BRrIrAj44dwlBZBcw
         muwf62K0jxDXQ==
Received: by mail-lf1-f50.google.com with SMTP id bp15so30985403lfb.13
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 11:04:55 -0800 (PST)
X-Gm-Message-State: ANoB5pnhVWGskL8GEgmv7xSybpg5ZrZohKFYMiNE+PjcYsZmXZ83qgoL
        hjAjOa2FPBGOZkq2W6HO3vZgeW943MkatYiJfagryg==
X-Google-Smtp-Source: AA0mqf5IdB3FqXYcB9+c5kH7kOk3qvvF5E6alzWTssMkbrf4o7080V2vd2Ecod+Wih5iK0/hHspdd/OGxQVNIPCaaBY=
X-Received: by 2002:a19:6748:0:b0:498:f589:c1b3 with SMTP id
 e8-20020a196748000000b00498f589c1b3mr7217976lfj.406.1668625493510; Wed, 16
 Nov 2022 11:04:53 -0800 (PST)
MIME-Version: 1.0
References: <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com>
 <20221116154712.4115929-1-roberto.sassu@huaweicloud.com> <CAADnVQLQswvu3oGyeevLrKMT200yD4hzCbkBUAs=1bKSDVaOQg@mail.gmail.com>
 <05bf553f795ac93ea3032cfc1b56ca35fd6a920a.camel@huaweicloud.com> <CAADnVQJu7isDCi4+f8s4LfiwcYJbN4kXkvgJ8+ZnsS+QGDVnMw@mail.gmail.com>
In-Reply-To: <CAADnVQJu7isDCi4+f8s4LfiwcYJbN4kXkvgJ8+ZnsS+QGDVnMw@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 16 Nov 2022 20:04:42 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6-zLNZhRmpaax+_ZywWLa5R2HwcxRke8hCHu_FgYceeA@mail.gmail.com>
Message-ID: <CACYkzJ6-zLNZhRmpaax+_ZywWLa5R2HwcxRke8hCHu_FgYceeA@mail.gmail.com>
Subject: Re: [PoC][PATCH] bpf: Call return value check function in the JITed code
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 6:55 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 16, 2022 at 8:41 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > On Wed, 2022-11-16 at 08:16 -0800, Alexei Starovoitov wrote:
> > > On Wed, Nov 16, 2022 at 7:48 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > +static bool is_ret_value_allowed(int ret, u32 ret_flags)
> > > > +{
> > > > +       if ((ret < 0 && !(ret_flags & LSM_RET_NEG)) ||
> > > > +           (ret == 0 && !(ret_flags & LSM_RET_ZERO)) ||
> > > > +           (ret == 1 && !(ret_flags & LSM_RET_ONE)) ||
> > > > +           (ret > 1 && !(ret_flags & LSM_RET_GT_ONE)))
> > > > +               return false;
> > > > +
> > > > +       return true;
> > > > +}
> > > > +
> > > >  /* For every LSM hook that allows attachment of BPF programs, declare a nop
> > > >   * function where a BPF program can be attached.
> > > >   */
> > > > @@ -30,6 +41,15 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)     \
> > > >  #include <linux/lsm_hook_defs.h>
> > > >  #undef LSM_HOOK
> > > >
> > > > +#define LSM_HOOK(RET, DEFAULT, RET_FLAGS, NAME, ...)   \
> > > > +noinline RET bpf_lsm_##NAME##_ret(int ret)     \
> > > > +{                                              \
> > > > +       return is_ret_value_allowed(ret, RET_FLAGS) ? ret : DEFAULT; \
> > > > +}
> > > > +
> > > > +#include <linux/lsm_hook_defs.h>
> > > > +#undef LSM_HOOK
> > > > +
> > >
> > > because lsm hooks is mess of undocumented return values your
> > > "solution" is to add hundreds of noninline functions
> > > and hack the call into them in JITs ?!
> >
> > I revisited the documentation and checked each LSM hook one by one.
> > Hopefully, I completed it correctly, but I would review again (others
> > are also welcome to do it).
> >
> > Not sure if there is a more efficient way. Do you have any idea?
> > Maybe we find a way to use only one check function (by reusing the
> > address of the attachment point?).
> >
> > Regarding the JIT approach, I didn't find a reliable solution for using
> > just the verifier. As I wrote to you, there could be the case where the
> > range can include positive values, despite the possible return values
> > are zero and -EACCES.
>
> Didn't you find that there are only 12 or so odd return cases.
> Maybe refactor some of them to something that the verifier can enforce
> and denylist the rest ?

+1

>
> Also denylist those that Casey mentioned like security_secid_to_secctx ?

Just replied to Casey's comment and I agree, these hooks should be denylisted.
