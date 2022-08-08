Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C290D58D04C
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 00:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbiHHWrh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 18:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiHHWrg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 18:47:36 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C066E1928E
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 15:47:32 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10cf9f5b500so12190032fac.2
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 15:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Xgr1zcvVw2pumc5i5OyXUSrHvFDN2EKwHe94fGDtFRc=;
        b=SpIxuRBySHLiJnzlZCqbG6d10oLBSB6+sdgZ2x0xGqg9Qwam4ErXCCwXAKSMe60/qQ
         LXKVAHne5E6sMcti6T8BzKOmUlluVg+91nYIVsD/0Gx3/1Rh2GpuPw9yoGoFsgMlDreE
         Hyl7ji9Dex0sOxkL7gyZ6yKDSJMbl0988qMpWHJVC/avb0dk6uwrDgie4XTtnptBThSh
         Up1jSUYskmN+BE7RpU+76YeIe2h9UEMKds5itTlwRZM2KUpbnrIwFoatEQqlk2f3vpqS
         XUCZ38YIDNDrGV3oUTW23sBHHU+JWpi09zppu2VYozxXeu5uN48iLjgdfOfOEWtu5/ZA
         oTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Xgr1zcvVw2pumc5i5OyXUSrHvFDN2EKwHe94fGDtFRc=;
        b=k8kMfybeqbuKiv9f4ROYmpugP2aVxaPCEtIOmE6oUPmIQNkxdN1IgQxgQUcs01g3fq
         0vzx/lUzol75JZSoii2egMNY0qIKbP1GNPoQixnZjq/Tn+OQf/uKZa8c1i5c/biuUbYH
         8BziVhTo5lQcbCO8EtdELQpYb1JJqlFqmls3FBkznC8BCGqZoxtmDvUE3k2CH8v0igfc
         N+CMsamdWkFu6yTY6a4lxRisVPLPmg/Zw9WfnIEEMGn935baoCWRrvHf/68YB3ufeDBi
         k9dKlgXX0RUSxHpt9dneUbS8yOlH7KYmC1aObbw9DAhOBFI1Qk7Be5ycZe2OxcrEJ3go
         Tynw==
X-Gm-Message-State: ACgBeo3rm1gFgY4DX+jHefrSTNI7NHNyXNM+cQocb3fPc0HCVzm7Mn85
        NHBlllZdOWxgIfXXCr5lcmkizKs2hX/hvbS2OZyz
X-Google-Smtp-Source: AA6agR4xuYwVmCC3J5R5EIaV2vMNU+sZEdEaDmuaoGD6OS/1cZ5bdac1//FK/Z+H/JjLJ5ZJ0b1/X9olSD/ppX1e9zM=
X-Received: by 2002:a05:6870:b41e:b0:116:5dc7:192a with SMTP id
 x30-20020a056870b41e00b001165dc7192amr2571672oap.136.1659998852083; Mon, 08
 Aug 2022 15:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220801180146.1157914-1-fred@cloudflare.com> <87les7cq03.fsf@email.froward.int.ebiederm.org>
 <CAHC9VhRpUxyxkPaTz1scGeRm+i4KviQQA7WismOX2q5agzC+DQ@mail.gmail.com>
 <87wnbia7jh.fsf@email.froward.int.ebiederm.org> <CAHC9VhS3udhEecVYVvHm=tuqiPGh034-xPqXYtFjBk23+p-Szg@mail.gmail.com>
 <877d3ia65v.fsf@email.froward.int.ebiederm.org> <87bksu8qs2.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87bksu8qs2.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Aug 2022 18:47:21 -0400
Message-ID: <CAHC9VhTEwD2y9Witj-1z3e2TC-NGjghQ4KT4Dqf3UOLzDcDc3Q@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 8, 2022 at 3:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Eric W. Biederman" <ebiederm@xmission.com> writes:
> > Paul Moore <paul@paul-moore.com> writes:
> >
> >>> I did provide constructive feedback.  My feedback to his problem
> >>> was to address the real problem of bugs in the kernel.
> >>
> >> We've heard from several people who have use cases which require
> >> adding LSM-level access controls and observability to user namespace
> >> creation.  This is the problem we are trying to solve here; if you do
> >> not like the approach proposed in this patchset please suggest another
> >> implementation that allows LSMs visibility into user namespace
> >> creation.
> >
> > Please stop, ignoring my feedback, not detailing what problem or
> > problems you are actually trying to be solved, and threatening to merge
> > code into files that I maintain that has the express purpose of breaking
> > my users.
> >
> > You just artificially constrained the problems, so that no other
> > solution is acceptable.  On that basis alone I am object to this whole
> > approach to steam roll over me and my code.
>
> If you want an example of what kind of harm it can cause to introduce a
> failure where no failure was before I invite you to look at what
> happened with sendmail when setuid was modified to fail, when changing
> the user of a process would cause RLIMIT_NPROC to be exceeded.

I think we are all familiar with the sendmail capabilities bug and the
others like it, but using that as an excuse to block additional access
controls seems very weak.  The Linux Kernel is very different from
when the sendmail bug hit (what was that, ~20 years ago?), with
advancements in capabilities and other discretionary controls, as well
as mandatory access controls which have enabled Linux to be certified
through a number of third party security evaluations.

> I am not arguing that what you are proposing is that bad but unexpected
> failures cause real problems, and at a minimum that needs a better
> response than: "There is at least one user that wants a failure here".

Let me fix that for you: "There are multiple users who want to have
better visibility and access control for user namespace creation."

--
paul-moore.com
