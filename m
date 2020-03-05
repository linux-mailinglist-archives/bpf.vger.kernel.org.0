Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8213D17AF13
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 20:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgCETl5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 14:41:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45483 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCETl5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 14:41:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id f21so6480otp.12;
        Thu, 05 Mar 2020 11:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgpZmEtXtUnXzdjflmvnfXtJf2QN3RICWNEoFCC9Fuo=;
        b=kz1O1/KvzwF2FSey5oAcJkszo7ONwn8pPWHFyYeLWcpUpkjs7tJj9K6d7KFHPbvbJr
         xyBwFwxkxbtwZ+M19iBnX36SqjN+Xefce93rjQYiNhHKcwieOvTO+H7Ub9h6I+HlTT0O
         B/PAEjljcL3dem0afDYZ1K95cmKrxO4gZTQxDqy3ho/pbnreEFUA5SFU/EgWMTirG4Qs
         bmm/pu4pWDtGioihnEey3Q8s1kvW3OHjEE0tIOodKCEcZR6QqhVASW7E1y9eS5GC1Yi4
         Oz8DeVaeI5LPwCDrvFtyIA++6XYLAN6P6vI396fyZO9s9PGN9Q94M0m9oG5fb2WYN4T7
         n6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgpZmEtXtUnXzdjflmvnfXtJf2QN3RICWNEoFCC9Fuo=;
        b=LOYF3qT1ERirWoUgh0sfNTwLKlMFJ94/YM/gvq43kdvRZ1jqBr2T9rsiW0LpQMGn/o
         MDuNtNwGdehO724gpiBZcbghawlyFXB8KsN5Fr8/398HyCaO+GeELA+wwNwHr8QXvl/R
         WZ7j7RBiYu5CfNeEmm/6I1ieJaZQX0emHpsTsLgikbBPKduzOQ5+WN150AJXRX+WPdfF
         G8gw+O21z6UDtjROMfokm2MR9ngWsEKlb/Ztpq+oHdlHbinvANOyKmNla5JvJC6HiYTw
         TaAynxy77tfuyd7GT8FZsAhgsiyvU7CPh9zdX25X6KCidiuOQKJy9q9GTSOCLmpPqcwb
         Sg0Q==
X-Gm-Message-State: ANhLgQ2fsWL6n5UgnCHUx58KAjz0k9P/DhoSk8HzvqkuZmfsNRmXS1Vb
        JXy+i1fIPpPO2K45D3d2UeN/u1tqr/isvZ3cg94=
X-Google-Smtp-Source: ADFU+vuF6qr530ZXMU50IfbbDKehJtz6mxtmhJ13ocNVHx1IdRrwZlYKkFbXkb3nGtgwQ7VbR3+WVNXV0ktTy6Mme4E=
X-Received: by 2002:a9d:6457:: with SMTP id m23mr93769otl.162.1583437315076;
 Thu, 05 Mar 2020 11:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20200304191853.1529-1-kpsingh@chromium.org> <20200304191853.1529-4-kpsingh@chromium.org>
 <CAEjxPJ4+aW5JVC9QjJywjNUS=+cVJeaWwRHLwOssLsZyhX3siw@mail.gmail.com> <20200305155421.GA209155@google.com>
In-Reply-To: <20200305155421.GA209155@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 5 Mar 2020 14:43:01 -0500
Message-ID: <CAEjxPJ5u7tsa_9-7Oq_Wi28mZD_aDC1tVWj5Tb8ud=bfEYsY9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Introduce BPF_MODIFY_RETURN
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 5, 2020 at 10:54 AM KP Singh <kpsingh@chromium.org> wrote:
>
> On 05-Mar 08:51, Stephen Smalley wrote:
> > IIUC you've switched from a model where the BPF program would be
> > invoked after the original function logic
> > and the BPF program is skipped if the original function logic returns
> > non-zero to a model where the BPF program is invoked first and
> > the original function logic is skipped if the BPF program returns
> > non-zero.  I'm not keen on that for userspace-loaded code attached
>
> We do want to continue the KRSI series and the effort to implement a
> proper BPF LSM. In the meantime, the tracing + error injection
> solution helps us to:
>
>   * Provide better debug capabilities.
>   * And parallelize the effort to come up with the right helpers
>     for our LSM work and work on sleepable BPF which is also essential
>     for some of the helpers.
>
> As you noted, in the KRSI v4 series, we mentioned that we would like
> to have the user-space loaded BPF programs be unable to override the
> decision made by the in-kernel logic/LSMs, but this got shot down:
>
>    https://lore.kernel.org/bpf/00c216e1-bcfd-b7b1-5444-2a2dfa69190b@schaufler-ca.com
>
> I would like to continue this discussion when we post the v5 series
> for KRSI as to what the correct precedence order should be for the
> BPF_PROG_TYPE_LSM and would appreciate if you also bring it up there.

That's fine but I guess I don't see why you or anyone else would
bother with introducing a BPF_PROG_TYPE_LSM
if BPF_PROG_MODIFY_RETURN is accepted and is allowed to attach to the
LSM hooks.  What's the benefit to you
if you can achieve your goals directly with MODIFY_RETURN?

> > to LSM hooks; it means that userspace BPF programs can run even if
> > SELinux would have denied access and SELinux hooks get
> > skipped entirely if the BPF program returns an error.  I think Casey
> > may have wrongly pointed you in this direction on the grounds
> > it can already happen with the base DAC checking logic.  But that's
>
> What we can do for this tracing/modify_ret series, is to remove
> the special casing for "security_" functions in the BPF code and add
> ALLOW_ERROR_INJECTION calls to the security hooks. This way, if
> someone needs to disable the BPF programs being able to modify
> security hooks, they can disable error injection. If that's okay, we
> can send a patch.

Realistically distros tend to enable lots of developer-friendly
options including error injection, and most users don't build their
own kernels
and distros won't support them when they do. So telling users they can
just rebuild their kernel without error injection if they care about
BPF programs being able to modify security hooks isn't really viable.
The security modules need a way to veto it based on their policies.
That's why I suggested a security hook here.
