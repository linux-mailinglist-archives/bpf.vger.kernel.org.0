Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE543228AA
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 11:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhBWKMf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 05:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhBWKLs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 05:11:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17494C061574
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 02:10:57 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id e7so10412085lft.2
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 02:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSiaCFu+244vSDwMi2SVRQIE07m+0ajrljfb0U+L/MI=;
        b=iBe8/+rbC8fuwkD84ucf1LPejX+eTzW8LnVHnl1Sp8npjz3bzThOJ2j05NqA+3JAwI
         dmmV/jAt6jkIDUURDz8WlhEVWZGRRhHLOkPMqq7AArvsWVehA6GiZUSgUbxI1zjEnvy/
         fvYqIp92c8Spk5opogYW88TcbXVIxsYrfU7K0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSiaCFu+244vSDwMi2SVRQIE07m+0ajrljfb0U+L/MI=;
        b=Ej4CaVCDcTMWQRynUzgAQaNMLMiQxVNJXAOMJATHIsE6pRMSMaWKjgstUrsbiLsyBA
         x5hWCHQp1nVIldI8HoTciEVUtJQnH8TKZrVfHo66jnhl9DDVqJDUnynSIY/7MqnLrPx6
         pkxG5+BUcUwb+B7CZHTwoFAw97uNpe6kKnJkHAywizYxepdEkgafE1hJ0qBzK0T2QFPQ
         P4guMchMxSF1HkNBRFR7mz6BJRy4U/CJbveIGWuT7iXqB5PF5zqIrhEBDu4AJMCTHZjw
         eWYt8k3y5UvWviOd6at9rIqnlsCa2E/lT+dgvkwxdR17GOIelMWn7tiWXFMCH9sOUg3M
         O18Q==
X-Gm-Message-State: AOAM531GWwcJjWZoSVIPzwjX0RqKBxjMYRg23TweZacg0s8wD8TZIX4V
        Fhu9P0NsZQfEiYsGV+a9bl5m4qMK/+XqRlucViz5Ew==
X-Google-Smtp-Source: ABdhPJxEcF4RIT0ItB5V6OCMLoGA77oJGjKcGT0aK88oPFCUS8oPkE7g8gZWVNqqJO4hye7wrWmL/wI7m25hozhWvJY=
X-Received: by 2002:a19:711e:: with SMTP id m30mr15206441lfc.97.1614075055606;
 Tue, 23 Feb 2021 02:10:55 -0800 (PST)
MIME-Version: 1.0
References: <20210216105713.45052-1-lmb@cloudflare.com> <20210216105713.45052-5-lmb@cloudflare.com>
 <20210223011153.4cvzpvxqn7arbcej@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210223011153.4cvzpvxqn7arbcej@ast-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 23 Feb 2021 10:10:44 +0000
Message-ID: <CACAyw99hQgG+=WvUVmDU-E6nGsPvosSuSOWgw9uWDDZ-vFfsqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf: add PROG_TEST_RUN support for sk_lookup programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Feb 2021 at 01:11, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I'm struggling to come up with the case where running N sk_lookup progs
> like this cannot be done with running them one by one.
> It looks to me that this N prog_fds api is not really about running and
> testing the progs, but about testing BPF_PROG_SK_LOOKUP_RUN_ARRAY()
> SK_PASS vs SK_DROP logic.

In a way that is true, yes. TBH I figured that my patch set would be
rejected if I just
implemented single program test run, since it doesn't allow exercising the full
sk_lookup test run semantics.

> So it's more of the kernel infra testing than program testing.
> Are you suggesting that the sequence of sk_lookup progs are so delicate
> that they are aware of each other and _has_ to be tested together
> with gluing logic that the macro provides?

We currently don't have a case like that.

> But if it is so then testing the progs one by one would be better,
> because test_run will be able to check each individual prog return code
> instead of implicit BPF_PROG_SK_LOOKUP_RUN_ARRAY logic.

That means emulating the kind of subtle BPF_PROG_SK_LOOKUP_RUN_ARRAY
in user space, which isn't trivial and a source of bugs.

For example we rely on having multiple programs attached when
"upgrading" from old to new BPF. Here we care mostly that we don't drop
lookups on the floor, and the behaviour is tightly coupled to the in-kernel
implementation. It's not much use to cobble up my own implementation of
SK_LOOKUP_RUN_ARRAY here, I would rather use multi progs to test this.
Of course we can also already spawn a netns and test it that way, so not
much is lost if there is no multi prog test run.

> It feels less of the unit test and more as a full stack test,
> but if so then lack of cookie on input is questionable.

I'm not sure what you mean with "the lack of cookie on input is
questionable", can you rephrase?

> In other words I'm struggling with in-between state of the api.
> test_run with N fds is not really a full test, but not a unit test either.

If I understand you correctly, a "full" API would expose the
intermediate results from
individual programs as well as the final selection? Sounds quite
complicated, and as
you point out most of the benefits can be had from running single programs.

I'm happy to drop the multiple programs bit, like I mentioned I did it
for completeness sake.
I care about being able to test or benchmark a single sk_lookup program.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
