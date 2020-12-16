Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E72DC562
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 18:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgLPRbi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 12:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgLPRbi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 12:31:38 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C006AC061794
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 09:30:57 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d8so23738260otq.6
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LtzJlx+8MUo+ymvbVWyaGaBaPce4VrSfPCWylcMKks=;
        b=B0Gq56q+GGtH+JedcINphgyLvv2OnUG+PdcnI+HpMTyyc+wOMV1eMrBsij+rFEG1Pf
         UF3E643R4V4vrScTDwD+ExBGGsmR+PLN30/rUXKCuHCD1fRmFI4mM68CfjgBMFi8iICr
         LWLJRqhg5QlftFdu8zjg4MIZEQRxkOrV9jNJ7+XwzuEEOgB1II92O4U0oXl408UyaRoh
         GQbm/VdqaaQgYb0J4sqCPS8wPCD2CEzFWEGQg0xXOtMtFlQATkBw+vdlOnWfOX875RyM
         TvK4M0Ex90+L6LQDVjxg3TSR1ZhD0bH1mlF/+qxlzky+iCTxrz1kw3HB/NOwHOstc7pr
         GF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LtzJlx+8MUo+ymvbVWyaGaBaPce4VrSfPCWylcMKks=;
        b=pX3yw2zPofERU9YPZUCZfvuW4jkhbttMetLBUE5jOj7Hkx5yNaHqUW83ITp7HFVL05
         eemzFDHNZTeUbTiaMkCBK6xnl/PwfnP7sNqtjCaah3zWBJ5nUkRwCoOO7MwbFhJtYsV5
         8wLiw2YqhYEM0Dc6kJHA7he/gQ3BbMZlVjEEiwwGbaOuc2KCGWnyDVj7h1a9VEbYjZgf
         ++4Q8Jf9qotVq9CqR8gyNCYTlzdhIuQ4xz37yVdTEcreLho/UiGitGfzb61cUBwAcf9x
         DbGGPzrKUEOko5KrAb/QYxcon3K0YN+viBiyxnMGSgFI7IcQH+c4Z+IspLNwZDpQCluI
         wGLA==
X-Gm-Message-State: AOAM531eQybFfnlZ8yfET014gSpsDmLkYUWtrCKFtQHrQoT8W7rV4Evy
        cLsjW608T2WfsOmRK+A2MZ34XB2+GK7QuvUNge6xo8SF/co=
X-Google-Smtp-Source: ABdhPJx/zg4wJ0qMEmyLk72J95AHWiaiIngxDgjndq20WTpmP/qBFhjUJMjf4gdWZYs1uIGsakeSH+06QhnvDTPQ9B8=
X-Received: by 2002:a9d:27a7:: with SMTP id c36mr26705253otb.59.1608139857077;
 Wed, 16 Dec 2020 09:30:57 -0800 (PST)
MIME-Version: 1.0
References: <CACAyw98GbSi6UWDoN+A-B7Fct7fHsdgP67D5qf1oQVbUjdo1Fw@mail.gmail.com>
 <4fa59cd4-5fda-24e1-5382-a66579f51c7a@iogearbox.net> <CACAyw9_1+XpOXSJ9ycsJqMzBF+DrDo8FLnMVzPP8aaPr8bbnWw@mail.gmail.com>
In-Reply-To: <CACAyw9_1+XpOXSJ9ycsJqMzBF+DrDo8FLnMVzPP8aaPr8bbnWw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 16 Dec 2020 09:30:46 -0800
Message-ID: <CAADnVQLPXt4MD16VBkGeQODdnDfxV6hXxcw9oE+wvTptq-=xGg@mail.gmail.com>
Subject: Re: Can we share /sys/fs/bpf like /tmp?
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 16, 2020 at 7:33 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Wed, 16 Dec 2020 at 14:56, Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > > What were the reasons for changing the mode to 0700? Would it be
> > > reasonable to mount /sys/fs/bpf with 1777 nowadays?
> >
> > If you don't specify anything particular a3af5f800106 ("bpf: allow for
> > mount options to specify permissions") the sb is created with S_IRWXUGO.
>
> Makes sense, thanks for the context. I checked iproute2, that mounts
> /sys/fs/bpf with 0700 if it doesn't exist.
>
> > It's probably caution on systemd side (?), currently don't recall any
> > particular discussion on this matter.
>
> Alexei then maybe?

I don't recall, but I suggest to always use your own mount.
All bpffs instances are independent. That's the way to keep them
isolated. We've seen issues in the past where common /sys/fs/bpf
location was causing unpleasant collisions between different projects.
Now folks have learned to treat /sys/fs/bpf more carefully and don't touch
stuff that they didn't put in there, but it's still fragile until cap_bpf and
different user ids are universally adopted.
