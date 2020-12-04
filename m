Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B812CF478
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 20:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgLDTBR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 14:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbgLDTBQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 14:01:16 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37BC061A51;
        Fri,  4 Dec 2020 11:00:36 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id e81so6388868ybc.1;
        Fri, 04 Dec 2020 11:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4r6WZhkyZIzK0rIBwuYU0NPXTkSxOEOm52PkNYUaj+s=;
        b=nVjkunzY7D5aDuphMfTR8i1RClbCPQze/wlsEU2/jS6QF1X+vAX/caFXmat4i7/l0V
         OHmh2jAefBh3TWEn3CmIdoCRAM/eqPrw9ECeLd4K71opWhq/gXq0wkW/f/6PHxXUxnZw
         PnHOJrs5MFL53S8vuzksEWMi5QC5Jtkc6FuSTJrRRagvl+LFowkJ7JkvjucM6ws+5s9d
         0DRtcPsQ/gf1HGV/QFNMjAmIWTuH+BXyTZzeETNlwxKtaFW0NV6xfZ7DPcTMPV4fyOT+
         NqQkb/QnMzaX+VV4ytqJNAXuCleDP8e+YWbd6HoaYO/wo4USR8KdM+o6m+CLhkArR3N/
         umhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4r6WZhkyZIzK0rIBwuYU0NPXTkSxOEOm52PkNYUaj+s=;
        b=h6r1eVZS7S/xd80wDkA481XlVXdMzxNqk1Fg8B8mUW8UqyiF7Rlt91ydnx0KcnY/Xs
         pnDl7ijoDTuQn1q8Tfe815pKLyY0saePbrxUqO35D+1ONuugx5KLv3haVVXLI4eB7jx7
         ax7SWYb0f/1MZWx7cxL76B8dmQKTXaqCCTc4zcwSpfS/BkqzYpIw9vypd9LstwG2CZhY
         wUjnHmxvaHxEpSIPYRU9aoUhZXkAcwE2m6MYF7aTc0ImlSH3xiz0dA6xrcKIG8IYjvkP
         HKjLkcrNuqktam3EdvflKMm5t/4kAwjVvB7a8QpMooJbjVu0aTxoR7B3GxLvGD/Esy7W
         tP7g==
X-Gm-Message-State: AOAM531ZuxVFEds4FO6T3XQTWX2+lf9KBIymu1Km9q+aA092FXj7fbne
        aG/2SP+5Y1ufxKgTlRV9xVqASek3mfaKLBvlYrw=
X-Google-Smtp-Source: ABdhPJwi7vn/PyG6I6yqm1F6t35x8ql0GlGQM2rQTChGLp9KbLp2RmDVSFAGUzQud2MTtPTD/hdHTIRw4LkI8hckV/8=
X-Received: by 2002:a25:6a05:: with SMTP id f5mr4291189ybc.459.1607108435741;
 Fri, 04 Dec 2020 11:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com> <20201203160245.1014867-13-jackmanb@google.com>
 <CAEf4BzbEfPScq_qMVJkDxfWBh-oRhY5phFr=517pam80YcpgMg@mail.gmail.com> <X8oEOPViOhR8XdH6@google.com>
In-Reply-To: <X8oEOPViOhR8XdH6@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Dec 2020 11:00:24 -0800
Message-ID: <CAEf4BzaEystdQ3PbaZXhmpTfqbs410BVCEToHfKLgx-3wAm-KA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/14] bpf: Pull tools/build/feature biz into
 selftests Makefile
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 4, 2020 at 1:41 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Thu, Dec 03, 2020 at 01:01:27PM -0800, Andrii Nakryiko wrote:
> > On Thu, Dec 3, 2020 at 8:07 AM Brendan Jackman <jackmanb@google.com> wrote:
> > >
> > > This is somewhat cargo-culted from the libbpf build. It will be used
> > > in a subsequent patch to query for Clang BPF atomics support.
> > >
> > > Change-Id: I9318a1702170eb752acced35acbb33f45126c44c
> >
> > Haven't seen this before. What's this Change-Id business?
>
> Argh, apologies. Looks like it's time for me to adopt a less error-prone
> workflow for sending patches.
>
> (This is noise from Gerrit, which we sometimes use for internal reviews)
>
> > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > ---
> > >  tools/testing/selftests/bpf/.gitignore |  1 +
> > >  tools/testing/selftests/bpf/Makefile   | 38 ++++++++++++++++++++++++++
> > >  2 files changed, 39 insertions(+)
> >
> > All this just to detect the support for clang atomics?... Let's not
> > pull in the entire feature-detection framework unnecessarily,
> > selftests Makefile is complicated enough without that.
>
> Then the test build would break for people who haven't updated Clang.
> Is that acceptable?
>
> I'm aware of cases where you need to be on a pretty fresh Clang for
> tests to _pass_ so maybe it's fine.

I didn't mean to drop any detection of this new feature. I just didn't
want a new dependency on tools' feature probing framework. See
IS_LITTLE_ENDIAN and get_sys_includes, we already have various feature
detection-like stuff in there. So we can do this with a one-liner. I
just want to keep it simple. Thanks.
