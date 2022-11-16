Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4907662C6F3
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 18:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbiKPRzz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 12:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiKPRzy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 12:55:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750660EBD;
        Wed, 16 Nov 2022 09:55:53 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gv23so13278494ejb.3;
        Wed, 16 Nov 2022 09:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=65ksdtcKynE1zhhoUikCdWdh4bSAwSW8JPUcRDfF/As=;
        b=jU4mgg/doGrH3jjl9Q5bnWetaR90nJuTY5kFi5JvvD4WtC/ucUNy2NnMz3T1jGAgc0
         T4GiLKhhID4sbK6sGwz2QHcU4rmciwch0lpTI+vj/Mpa3GlHHhDatThPRmV3BfSGM4NR
         9dNJEKX8HaoXTkiVFd2+RBNr2SSAlofmiNUw2/5nDepQoY/009pQrnfkkYJlED2VLZ5z
         VbHVq8HZC6RuAG2/sPnTJ1gABXrru7iL1nCZrbkrkXIFaHnOuIh4WEgZGcJy8GH8fpSJ
         nCZKncigpVdN/GuKCBnrFkWxpQRAeDtpIlXZYVWX26mGzDTkEDcvHWZbmt2t4sZbYR2T
         Fhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65ksdtcKynE1zhhoUikCdWdh4bSAwSW8JPUcRDfF/As=;
        b=Wi7BR4V6WPy3pqwpvdopMryyInSqJyUdTFk1mJ/Wkj8g4OZ0cGBn7NQnd8E9UVFado
         MVrghVJ+VZkFW4KBVnY1m6/Yxp5BlBR+zdVugDZxgQMjutNcxGKzln3XoE69djtEwag7
         +Vba1kUrNJ1xIDlszO07Jl3rKm100Jmi/8oMmUWccU8HY15lMUhWiFxf7VDNLSxgWXQd
         S3udhMys7tJL5HXWZk81ydHmV0HJTrW1V1DTpB/BVPuLwlpahxLY+VSNGlaAp7NRvwcA
         bfDw7H9wpWr7YvEQt+/5zf2Jf8Mdk2Zc5ysbZL2oCI4Ve9xhg34Z8dNpSIlL2nJI0P8v
         bQbw==
X-Gm-Message-State: ANoB5plyPEHxGTgvTdhGowAOWmwjZEnSDdUHFAhvw/t2iF0D8F1asdLh
        JHupFO4N04FBOE4e827e1/Bk5DLrF/9tVggoofY=
X-Google-Smtp-Source: AA0mqf4+TwxxmQ2zlWxdT8/WmEyJUv2nrxwPqS6GdTTzuGmZe3wYv55MDIG23ubBgWdeiXJbwSX2IP6mZjWJVXNxNeI=
X-Received: by 2002:a17:906:9c93:b0:7ae:dc58:ffe7 with SMTP id
 fj19-20020a1709069c9300b007aedc58ffe7mr14935642ejc.58.1668621351668; Wed, 16
 Nov 2022 09:55:51 -0800 (PST)
MIME-Version: 1.0
References: <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com>
 <20221116154712.4115929-1-roberto.sassu@huaweicloud.com> <CAADnVQLQswvu3oGyeevLrKMT200yD4hzCbkBUAs=1bKSDVaOQg@mail.gmail.com>
 <05bf553f795ac93ea3032cfc1b56ca35fd6a920a.camel@huaweicloud.com>
In-Reply-To: <05bf553f795ac93ea3032cfc1b56ca35fd6a920a.camel@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 16 Nov 2022 09:55:40 -0800
Message-ID: <CAADnVQJu7isDCi4+f8s4LfiwcYJbN4kXkvgJ8+ZnsS+QGDVnMw@mail.gmail.com>
Subject: Re: [PoC][PATCH] bpf: Call return value check function in the JITed code
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 8:41 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Wed, 2022-11-16 at 08:16 -0800, Alexei Starovoitov wrote:
> > On Wed, Nov 16, 2022 at 7:48 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > +static bool is_ret_value_allowed(int ret, u32 ret_flags)
> > > +{
> > > +       if ((ret < 0 && !(ret_flags & LSM_RET_NEG)) ||
> > > +           (ret == 0 && !(ret_flags & LSM_RET_ZERO)) ||
> > > +           (ret == 1 && !(ret_flags & LSM_RET_ONE)) ||
> > > +           (ret > 1 && !(ret_flags & LSM_RET_GT_ONE)))
> > > +               return false;
> > > +
> > > +       return true;
> > > +}
> > > +
> > >  /* For every LSM hook that allows attachment of BPF programs, declare a nop
> > >   * function where a BPF program can be attached.
> > >   */
> > > @@ -30,6 +41,15 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)     \
> > >  #include <linux/lsm_hook_defs.h>
> > >  #undef LSM_HOOK
> > >
> > > +#define LSM_HOOK(RET, DEFAULT, RET_FLAGS, NAME, ...)   \
> > > +noinline RET bpf_lsm_##NAME##_ret(int ret)     \
> > > +{                                              \
> > > +       return is_ret_value_allowed(ret, RET_FLAGS) ? ret : DEFAULT; \
> > > +}
> > > +
> > > +#include <linux/lsm_hook_defs.h>
> > > +#undef LSM_HOOK
> > > +
> >
> > because lsm hooks is mess of undocumented return values your
> > "solution" is to add hundreds of noninline functions
> > and hack the call into them in JITs ?!
>
> I revisited the documentation and checked each LSM hook one by one.
> Hopefully, I completed it correctly, but I would review again (others
> are also welcome to do it).
>
> Not sure if there is a more efficient way. Do you have any idea?
> Maybe we find a way to use only one check function (by reusing the
> address of the attachment point?).
>
> Regarding the JIT approach, I didn't find a reliable solution for using
> just the verifier. As I wrote to you, there could be the case where the
> range can include positive values, despite the possible return values
> are zero and -EACCES.

Didn't you find that there are only 12 or so odd return cases.
Maybe refactor some of them to something that the verifier can enforce
and denylist the rest ?

Also denylist those that Casey mentioned like security_secid_to_secctx ?
