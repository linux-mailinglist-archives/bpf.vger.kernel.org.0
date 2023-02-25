Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341666A2550
	for <lists+bpf@lfdr.de>; Sat, 25 Feb 2023 01:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBYADJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 19:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBYADI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 19:03:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3711688D
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 16:03:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i34so3745891eda.7
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 16:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FOSJld2koUzZX+eKCbNz+nSMO8pbhVWW96Lp8yRrts4=;
        b=AzKmOEWQazx2JXW46Wk/kVkbOjg8AV1O0KLBGYJfJk5wIeYvnZF2/JQodCpjtG59oV
         3r3PW+1MJYNb1W3+0RD14kXEq1u8h+r1qk7zuxHksokRfj633uOQPMBCCKIeM+SGN8I/
         csSoA5PwUbwJ/uvR0ZqB9Dfmo6WQkf0VT1X7SolEojF7q+gctTajg6qGKDyaHL+dolBF
         acqg8FBXMgdNPwGNniZUMiSq6G5ozRRjmhw2w2f4+DGsAYMKMd5vKXr19t/xqHJAQi5e
         x1OIH2TEt2u5UY/hpDU8Y9jxUMe6Qi9FA2UCzB+1UdW0a72pFsSZWjNxVMllMqtunuCu
         +o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOSJld2koUzZX+eKCbNz+nSMO8pbhVWW96Lp8yRrts4=;
        b=tUs3jm4dT5FsapmZuuT4R+oo+oKDp5WX/FBk5ZCgq0P1XcJwbHSmP6movfb0MFnNgF
         lVkcqiABnIWLlZLfSDnelW5DNw3BBWeIiEONBMljvJS91tiLDzWYDPGdMnQnuY1o0GfS
         +UTNG3XO8dOo9MPNibCdSHOtIKDFKc+nbztZ9RyWhxGs+OjAwOGD2Aun8oyZlh0JiGma
         hwyzmFamuVy89St9apW60vOJtuJ3s7M5WpYzf70I9g7SdTeiFGRBtpHTJk7sfV81d/vP
         5uRUM2Pa3GGfFfy5F0rabV0e46HGgf6IkxbTHUtVcOuBkVVA0DuiLD+4/y2dWlBKywlK
         rM3g==
X-Gm-Message-State: AO0yUKXO8MY3hIQnf4PL5Hjs3kupnTQ/EHJe3jHF2/OthiOnEYx/8E3m
        ORSpxgvgjtoZDWkE44n/gLLDPNVAgn8mDOk+2lF8h9mf
X-Google-Smtp-Source: AK7set9P8+6+twPQNBea6Oher3NWv7Qxi9S+JrFZoEVgNuK7FU+vAM+bC1FxHtb5+Tm058I8I30vtEnyPW6lc66CRvQ=
X-Received: by 2002:a17:906:5158:b0:883:ba3b:eb94 with SMTP id
 jr24-20020a170906515800b00883ba3beb94mr11299507ejc.3.1677283381644; Fri, 24
 Feb 2023 16:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20230222223714.80671-1-iii@linux.ibm.com> <CAADnVQ+c_+sCXgb63_Kqp8Qb_0cMDcHXrDsbtoP60LiWerWpkQ@mail.gmail.com>
 <8e53174c5d5bae318a38997a7e276d7cdbccfa00.camel@linux.ibm.com>
In-Reply-To: <8e53174c5d5bae318a38997a7e276d7cdbccfa00.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 24 Feb 2023 16:02:50 -0800
Message-ID: <CAADnVQJ9-wBrAw5+Y17Bxv4+CrLHmtkjuU143eD3fwhpQ1wvKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/12] bpf: Support 64-bit pointers to kfuncs
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
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

On Thu, Feb 23, 2023 at 12:43 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Thu, 2023-02-23 at 09:17 -0800, Alexei Starovoitov wrote:
> > On Wed, Feb 22, 2023 at 2:37 PM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > v2:
> > > https://lore.kernel.org/bpf/20230215235931.380197-1-iii@linux.ibm.com/
> > > v2 -> v3: Drop BPF_HELPER_CALL (Alexei).
> > >           Drop the merged check_subprogs() cleanup.
> > >           Adjust arm, sparc and i386 JITs.
> > >           Fix a few portability issues in test_verifier.
> > >           Fix a few sparc64 issues.
> > >           Trim s390x denylist.
> >
> > I don't think it's a good idea to change a bunch of JITs
> > that you cannot test just to address the s390 issue.
> > Please figure out an approach that none of the JITs need changes.
>
> What level of testing for these JITs would you find acceptable?

Just find a way to avoid changing them.
