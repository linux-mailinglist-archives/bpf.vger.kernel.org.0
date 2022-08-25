Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD7E5A195E
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 21:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbiHYTTZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 15:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243611AbiHYTTX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 15:19:23 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38D6BC831
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 12:19:21 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11d08d7ece2so19444883fac.0
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=e8Gq1eg55USHCL83Reobt5ibzPL8cvMuV1NX5De9ZYY=;
        b=O7VCw6m6DYZ9SRwwETgBSqa1zuOS859jqBgpBIVSG63HOg7KKdU/QyOTg3x2mMKLlZ
         /sk+enC4j9MprDEgOepuTKPmBoZ+sG3JQUyandbIfwWBmTyew+NcfQNlQxrCLf562JLt
         CBDBuBCbwtrJNQe3ltgbUG8+lxI+qESJLbZ0QjttHTgIelL4DCFUrpjqekdSpJmnnmqw
         5+qWUz8Dkm4iat2Vs0aOfyU5R/QMPzUhEaDtsp239vjwfrvwNLroQmHWmjQKOUL6AgDf
         0aK+BsUrax9MV0QeahftRbTrPT7WR2Q4AhsrTUIGzz3L/CutBwNsczdrnoWMGQfm8Wko
         Shzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=e8Gq1eg55USHCL83Reobt5ibzPL8cvMuV1NX5De9ZYY=;
        b=ZjoAZOxfzoF+B3le2Lia6fWTBiSscH23pM3AUyJvozl/RMmnf79JkuPOhEiz3QnnuJ
         xkr7p4IowlRqVlX/2eH4DUUicztU4APZf08Edig8mNl9VU2py+Dp4CgXvwj779a4Ccz4
         GicPyqgiyD5GZeot3+VrXjm+DCvRwS/34mnv8+p9pFlIiBLRMW48LWIK724F8jDFz1e2
         C/aivmzsCs/PbKqG3ycCqCr0owDa15my/qMq9TnWvX9ldCmN1ZJJcGkY0SYXUPpt8gSG
         ngYwpG7ZL3OdAFBDCXiA0cFEOsuRIHJ8FdRkXMj0AmdU5oSGskpNoy/fnOYGLODCviZu
         zCDA==
X-Gm-Message-State: ACgBeo1sPSiDzlvxR1Ui0ceojUJJKUjHwbALDVCA95rdy1vgFpLkDoTW
        46hOn2fJZz8GhLHEGsYsCzHU15WyHU4et2E4AHRl
X-Google-Smtp-Source: AA6agR6ZnOvsjUOSNSEGS0LaKYyBUDvqU+sEg8pLS8j9NOxMj3Auk1GEnVJgv+Dn6EqNkIafEGAYyEbTIhKpOvto32I=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr257186oao.136.1661455160511; Thu, 25
 Aug 2022 12:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTuxxRfJg=Ax5z87Jz6tq1oVRcppB444dHM2gP-FZrkTQ@mail.gmail.com>
 <8735dux60p.fsf@email.froward.int.ebiederm.org> <CAHC9VhSHJNLS-KJ-Rz1R12PQbqACSksLYLbymF78d5hMkSGc-g@mail.gmail.com>
 <871qte8wy3.fsf@email.froward.int.ebiederm.org> <CAHC9VhSU_sqMQwdoh0nAFdURqs_cVFbva8=otjcZUo8s+xyC9A@mail.gmail.com>
 <8735du7fnp.fsf@email.froward.int.ebiederm.org> <CAHC9VhQuRNxzgVeNhDy=p5+RHz5+bTH6zFdU=UvvEhyH1e962A@mail.gmail.com>
 <87tu6a4l83.fsf@email.froward.int.ebiederm.org> <20220818140521.GA1000@mail.hallyn.com>
 <CAHC9VhRqBxtV04ARQFPWpMf1aFZo0HP_HiJ+8VpXAT-zXF6UXw@mail.gmail.com>
 <20220819144537.GA16552@mail.hallyn.com> <CAHC9VhSZ0aaa3k3704j8_9DJvSNRy-0jfXpy1ncs2Jmo8H0a7g@mail.gmail.com>
 <875yigp4tp.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <875yigp4tp.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Aug 2022 15:19:09 -0400
Message-ID: <CAHC9VhTN09ZabnQnsmbSjKgb8spx7_hkh4Z+mq5ArQmfPcVqAg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Introduce security_create_user_ns()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederick Lawler <fred@cloudflare.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, brauner@kernel.org,
        casey@schaufler-ca.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com,
        cgzones@googlemail.com, karl@bigbadwolfsecurity.com,
        tixxdz@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 2:15 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Fri, Aug 19, 2022 at 10:45 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> >>  I am hoping we can come up with
> >> "something better" to address people's needs, make everyone happy, and
> >> bring forth world peace.  Which would stack just fine with what's here
> >> for defense in depth.
> >>
> >> You may well not be interested in further work, and that's fine.  I need
> >> to set aside a few days to think on this.
> >
> > I'm happy to continue the discussion as long as it's constructive; I
> > think we all are.  My gut feeling is that Frederick's approach falls
> > closest to the sweet spot of "workable without being overly offensive"
> > (*cough*), but if you've got an additional approach in mind, or an
> > alternative approach that solves the same use case problems, I think
> > we'd all love to hear about it.
>
> I would love to actually hear the problems people are trying to solve so
> that we can have a sensible conversation about the trade offs.

Here are several taken from the previous threads, it's surely not a
complete list, but it should give you a good idea:

https://lore.kernel.org/linux-security-module/CAHC9VhQnPAsmjmKo-e84XDJ1wmaOFkTKPjjztsOa9Yrq+AeAQA@mail.gmail.com/

> As best I can tell without more information people want to use
> the creation of a user namespace as a signal that the code is
> attempting an exploit.

Some use cases are like that, there are several other use cases that
go beyond this; see all of our previous discussions on this
topic/patchset.  As has been mentioned before, there are use cases
that require improved observability, access control, or both.

> As such let me propose instead of returning an error code which will let
> the exploit continue, have the security hook return a bool.  With true
> meaning the code can continue and on false it will trigger using SIGSYS
> to terminate the program like seccomp does.

Having the kernel forcibly exit the process isn't something that most
LSMs would likely want.  I suppose we could modify the hook/caller so
that *if* an LSM wanted to return SIGSYS the system would kill the
process, but I would want that to be something in addition to
returning an error code like LSMs normally do (e.g. EACCES).

-- 
paul-moore.com
