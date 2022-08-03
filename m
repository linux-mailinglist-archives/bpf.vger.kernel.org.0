Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245805885A5
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 04:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiHCCKX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 22:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiHCCKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 22:10:21 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE704E613
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 19:10:19 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u76so18567121oie.3
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 19:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AKd54UEEghsfwjXpz+oyC5/2q9GwxUZBaaXWayE5vh0=;
        b=qg9W/DQpVQE1zuA+4brg05l1CHy54NhyVGtRCydMFzE12zh988wMgOkkr9TR0NnbD+
         WwLZEYJ1Cian3j4YxJ6WBJI2n6yDUQvvjr4ehpvwK4KCp7f4yn0RdxKoUyszuGjYGU8/
         s4E1AMSrnr1lDlkjPOo5wKPaIBoLHwkBvOU9km4nzASl+QT9wg5vM/8K7SAjtTtkEW29
         25vFkfMoCHPaDw7h3m3M0vH4pxXB12va4kqeKDyoWrNWw4lZSEAvXXf1zX0yDfCNnWyC
         aH8Nd3hL8pHuRPIP8ArbTcaG9k+HPIfZ6HqKDQfDUUkpcdS83+0RZGlY6YZT3HQacIml
         6HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AKd54UEEghsfwjXpz+oyC5/2q9GwxUZBaaXWayE5vh0=;
        b=oBtC+smblnvysKX+/wMkuXystGXGjoyLVLzVo2TzQowqpx9y9c7LbKRUEvqCgBOD81
         PZIzMhBm/wL3k4tEPl3G+GIYk9wGghrvf1xQbUKcjrAVzgpdDg4ldkVNPdEIj1kKp/Jo
         IBi9ujOKM2OxfXJpD8/Fo6DtxnJYpo5Cp13khgGlAaOFNYKjSoST/9ujSaa/dnG8pyci
         dXafk5JhluP/xCIgR6zhGsvZJ/XWq8cbMFs7KU4zbgHmRUVnSYd6oclzrlvwwLlejQUr
         CUA9f0Igz/te0TxGRizO3FkryPEemKvRGB8b6faoZbo+y+mxdCBmg3/8W2Pp83saDh0g
         cq0w==
X-Gm-Message-State: ACgBeo0IqR5SYF1z+gZrRPWCCk+zdSE+utzTb/o8rjJ89ooO4v7OMQeC
        jH8qdwjUGF6HADL7ah6npLzwmr5AAQ1Dxn3Ock3m
X-Google-Smtp-Source: AA6agR4S03AR8N+erK0dIxoJgLjDzb1SXWDYWcC+fk2W8Ymp3AWVXTOqoLi3Urbw7V2XDi+6IlDjFLZ1083IjnRqlFk=
X-Received: by 2002:a05:6808:2389:b0:33a:cbdb:f37a with SMTP id
 bp9-20020a056808238900b0033acbdbf37amr928281oib.136.1659492618285; Tue, 02
 Aug 2022 19:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220801180146.1157914-1-fred@cloudflare.com> <87les7cq03.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87les7cq03.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Aug 2022 22:10:07 -0400
Message-ID: <CAHC9VhRpUxyxkPaTz1scGeRm+i4KviQQA7WismOX2q5agzC+DQ@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 1, 2022 at 10:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Frederick Lawler <fred@cloudflare.com> writes:
>
> > While creating a LSM BPF MAC policy to block user namespace creation, we
> > used the LSM cred_prepare hook because that is the closest hook to prevent
> > a call to create_user_ns().
>
> Re-nack for all of the same reasons.
> AKA This can only break the users of the user namespace.
>
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> You aren't fixing what your problem you are papering over it by denying
> access to the user namespace.
>
> Nack Nack Nack.
>
> Stop.
>
> Go back to the drawing board.
>
> Do not pass go.
>
> Do not collect $200.

If you want us to take your comments seriously Eric, you need to
provide the list with some constructive feedback that would allow
Frederick to move forward with a solution to the use case that has
been proposed.  You response above may be many things, but it is
certainly not that.

We've heard from different users now that there are very real use
cases for this LSM hook.  I understand you are concerned about adding
additional controls to user namespaces, but these are controls
requested by real users, and the controls being requested (LSM hooks,
with BPF and SELinux implementations) are configurable by the *users*
at *runtime*.  This patchset does not force additional restrictions on
user namespaces, it provides a mechanism that *users* can leverage to
add additional granularity to the access controls surrounding user
namespaces.

Eric, if you have a different approach in mind to adding a LSM hook to
user namespace creation I think we would all very much like to hear
about it.  However, if you do not have any suggestions along those
lines, and simply want to NACK any effort to add a LSM hook to user
namespace creation, I think we all understand your point of view and
respectfully disagree.  Barring any new approaches or suggestions, I
think Frederick's patches look reasonable and I still plan on merging
them into the LSM next branch when the merge window closes.

-- 
paul-moore.com
