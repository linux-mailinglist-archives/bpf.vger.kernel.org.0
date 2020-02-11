Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA8B1598F0
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 19:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbgBKSoe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 13:44:34 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42433 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbgBKSod (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 13:44:33 -0500
Received: by mail-oi1-f180.google.com with SMTP id j132so13772500oih.9
        for <bpf@vger.kernel.org>; Tue, 11 Feb 2020 10:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HF3YzYTi/Ks+MTJab6l7yP1LaB89T8PPJLlG/hEhges=;
        b=EyplU89QVtIzl2H6+9ficfFQTF1vZAYEN53+R6TJ5NCz3uz+jNHjSriM366bGhUzpQ
         Zqu994vE7Ze0ZYuEQN+YncFcuvFWd22BHgpjgI4rzGNAff3PgSsRdZkRd1EU7hAwHhok
         EergH+heTb+5qyBgqhjOajSmFD6w7sQnCRuileRb1hqPKOy7Lj5M89WKOurMpOVx5Kw7
         7JV8hn3fVoJ5dqsp8HNRhPrWJirRS0wVrXcSgpNr8GrMKB52gFh9IV3OzFSOiu7HFQFZ
         zqUltX9NxqOHdAZ7z8iYAtiXoAzWJb24IPffAR9NYGmEI2bAYv4NbV8fVhpJOueAfmws
         Uk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HF3YzYTi/Ks+MTJab6l7yP1LaB89T8PPJLlG/hEhges=;
        b=XzbxxJsjrToCIJn+Grjz59hE60k3ZTZUeFC5zb2fqnSRQZGjDUTdXAyYLCo0v/cMod
         IZ1SOA6MfvTZFRck5Nd8lksbolFSIRUQur+heTyEiY38rKxh7uxqKa/nQ8ZJsMLmImM+
         l26/pvRefl4HvlkAaPQJfZ1jfnvyvJWVt9XfgsB2ebstIJPSRPcmBwqC17mpwsxAls4m
         Q9CoBl9wrB7vRdwuLNjXSwCqGAAGFpL2y3FT4mwAaW/qOkSzIAnjHbpvBwi86hOES9FO
         RDh2v6e7hStrp8BAHNRE3iV6jrjinS4HvfZ4sdMv2QPjbBUMcNnoaCZU0MPPF4QjSriT
         7jKw==
X-Gm-Message-State: APjAAAV2v2k2Q+NJCsaoRPvAnkz2ytEAUpSBPoaq7fkJwxBm8Xbqrj6g
        wGVXFi4bnHe2zirBXGIRCxHvkj86SBXH77JL3QUHLg==
X-Google-Smtp-Source: APXvYqxHhXtlnOfOnI+BNvZnfjjqdMwYbXF59ItzBGD1eUVpXRkHk2uJzd3UrlTykBUbQaQX8quldC+S030QTR/sgO0=
X-Received: by 2002:aca:b187:: with SMTP id a129mr3807804oif.175.1581446671435;
 Tue, 11 Feb 2020 10:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20200123152440.28956-1-kpsingh@chromium.org> <20200123152440.28956-5-kpsingh@chromium.org>
 <20200211031208.e6osrcathampoog7@ast-mbp> <20200211124334.GA96694@google.com> <20200211175825.szxaqaepqfbd2wmg@ast-mbp>
In-Reply-To: <20200211175825.szxaqaepqfbd2wmg@ast-mbp>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Feb 2020 19:44:05 +0100
Message-ID: <CAG48ez25mW+_oCxgCtbiGMX07g_ph79UOJa07h=o_6B6+Q-u5g@mail.gmail.com>
Subject: BPF LSM and fexit [was: [PATCH bpf-next v3 04/10] bpf: lsm: Add
 mutable hooks list for the BPF LSM]
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 11, 2020 at 6:58 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Feb 11, 2020 at 01:43:34PM +0100, KP Singh wrote:
[...]
> > * When using the semantic provided by fexit, the BPF LSM program will
> >   always be executed and will be able to override / clobber the
> >   decision of LSMs which appear before it in the ordered list. This
> >   semantic is very different from what we currently have (i.e. the BPF
> >   LSM hook is only called if all the other LSMs allow the action) and
> >   seems to be bypassing the LSM framework.
>
> It that's a concern it's trivial to add 'if (RC == 0)' check to fexit
> trampoline generator specific to lsm progs.
[...]
> Using fexit mechanism and bpf_sk_storage generalization is
> all that is needed. None of it should touch security/*.

If I understand your suggestion correctly, that seems like a terrible
idea to me from the perspective of inspectability and debuggability.
If at runtime, a function can branch off elsewhere to modify its
decision, I want to see that in the source code. If someone e.g.
changes the parameters or the locking rules around a security hook,
how are they supposed to understand the implications if that happens
through some magic fexit trampoline that is injected at runtime?
