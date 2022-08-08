Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB0B58CEBC
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 21:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbiHHTuC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 15:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiHHTuB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 15:50:01 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6E8DFA3
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 12:50:00 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n133so11577466oib.0
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 12:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QwPM4PLFy7X803pVMJ9DSGZMitNho7+Gl2Q9QGtgFJk=;
        b=olY0JcNAoCo8R9DUOtQIxIyIBWxL/XAUSCfilx+gzRsD/WOa/M0smejqhtiS+OWqNE
         8GenNiemn6WZ/oFwff7rnzJqA7NzD0lE87S7L5KP3mlynm9SCJodgasGHAu2J2iSAp1v
         beRUGT/4tib/2O5XL2vq1d2UMH/t3HtmqrWkxiQUUFNYD9VUWNa/8tGrDeqsB3grdYcF
         QpEnLJj7gGvhshKmUFmDGJE1hFXqdDUW/lSXksjJVzuRbbYJGI6tU4OImoaI3o3ht1Fx
         c8sDU1ezvw9WgzUjISOqzIypyKU/u+CZGy5XcYzw1OjfErMFGH2IH+4Tmykcvuf+veIp
         8JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QwPM4PLFy7X803pVMJ9DSGZMitNho7+Gl2Q9QGtgFJk=;
        b=C5LyhpKIEmr5U0YovmcO6wMGoM/w5GYFaIwJLVb85zHqhPcl7AT397rTFXZ6CRLqO2
         molpmqtgiVYrQFNrLw/dpSw4ewS/YgXzxUkcSbWlu5WrX+9yXVRKCVOO8tUUp1eaisyu
         owBvpL6Rl/PFAs9QbXjyHyj7irvBzMNjK/8guLTePSE2ZzMjeVGz581OFxWdbcNAfqr5
         c5UyjNGgUW+jdQlAE2LzsibH2s+jvvSOsGnspdw6AangNlasd4ZflgLJXjkxDLAM8jVC
         MqFqKrDqNpNxJHkXR5j9Ewss6HfeBEcXbbJsFwAHhph/cAsWZXRNMEH3GlcmupRJHxKq
         JzkA==
X-Gm-Message-State: ACgBeo1U9WLziEwGuLHHv0PhlNgcChr9OW/4GEpJCXTrYukFTUsRmt8s
        lLpRXjEgxCPPzsrGhdnoxCu/1w7esagtz6muNjxP
X-Google-Smtp-Source: AA6agR6WxtKAXU2tCsFp4WlxK1FRRnlmgamF4f5dtSHwdS1vrNPR4fglkNWBfNoWaQiFwqgCpTJgtCiTE0ZSXLf7OZw=
X-Received: by 2002:a05:6808:3087:b0:33a:a6ae:7bf7 with SMTP id
 bl7-20020a056808308700b0033aa6ae7bf7mr11960352oib.41.1659988199456; Mon, 08
 Aug 2022 12:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220801180146.1157914-1-fred@cloudflare.com> <87les7cq03.fsf@email.froward.int.ebiederm.org>
 <CAHC9VhRpUxyxkPaTz1scGeRm+i4KviQQA7WismOX2q5agzC+DQ@mail.gmail.com>
 <87wnbia7jh.fsf@email.froward.int.ebiederm.org> <CAHC9VhS3udhEecVYVvHm=tuqiPGh034-xPqXYtFjBk23+p-Szg@mail.gmail.com>
 <877d3ia65v.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <877d3ia65v.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Aug 2022 15:49:48 -0400
Message-ID: <CAHC9VhSKmqn5wxF3BZ67Z+-CV7sZzdnO+JODq48rZJ4WAe8ULA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Introduce security_create_user_ns()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Frederick Lawler <fred@cloudflare.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 8, 2022 at 3:26 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> >> I did provide constructive feedback.  My feedback to his problem
> >> was to address the real problem of bugs in the kernel.
> >
> > We've heard from several people who have use cases which require
> > adding LSM-level access controls and observability to user namespace
> > creation.  This is the problem we are trying to solve here; if you do
> > not like the approach proposed in this patchset please suggest another
> > implementation that allows LSMs visibility into user namespace
> > creation.
>
> Please stop, ignoring my feedback, not detailing what problem or
> problems you are actually trying to be solved, and threatening to merge
> code into files that I maintain that has the express purpose of breaking
> my users.

I've heard you talk about bugs being the only reason why people would
want to ever block user namespaces, but I think we've all seen use
cases now where it goes beyond that.  However, even if it didn't, the
need to build high confidence/assurance systems where big chunks of
functionality can be disabled based on a security policy is a very
real use case, and this patchset would help enable that.  I've noticed
you like to talk about these hooks being a source of "regressions",
but access controls are not regressions Eric, they are tools that
system builders, administrators, and users use to secure their
systems.

From my perspective, I believe that addresses your feedback around
"fix the bugs" and "this is a regression", which is the only thing
I've noted from your responses in this thread and others, but if I'm
missing something more technical please let me/us know.

> You just artificially constrained the problems, so that no other
> solution is acceptable.

There is a real need to be able to gain both additional visibility and
access control over user namespace creation, please suggest the
approach(es) you would find acceptable.

> On that basis alone I am object to this whole
> approach to steam roll over me and my code.

I saw that choice of wording in your last email and thought it a bit
curious, so I did a quick git log dump on kernel/user_namespace.c and
I see approximately 31 contributors to that one file.  I've always
thought of the open source maintainer role as more of a "steward" and
less of an "owner", but that's just my opinion.

-- 
paul-moore.com
