Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D79E2C0A36
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2019 19:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfI0RUR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Sep 2019 13:20:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44994 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0RUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Sep 2019 13:20:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id m13so3218527ljj.11
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2019 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/eekwhhc/lEaErl1cWQvuZyKqEyMda5rbusW6YMK7I=;
        b=LkvK4hE626X9t4s92tPCDu4GVP+JW+rdiOHfvNh9N4jF4NJ9fWlvc7td1nIDU+CA3n
         PEztECpiktmStFqQ0huvXxeFoYFnurGmt4lmEj4thS8is9bkVhtTwcYhaFJXZOE0CtAy
         FW3A90ZFOAblRyxevEgwyKNwOoEO9RZOQsrxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/eekwhhc/lEaErl1cWQvuZyKqEyMda5rbusW6YMK7I=;
        b=fkedn+B8vuNhFUxH+pZ5kmKE/Q5PqN3aQ4Q7aDGJiAty17V3EL2WLpb07vNhLGyJJU
         2C3krvYsABYuf6hQ3r9SvA5OTZ6AuCURaCdU4zJs/hueZN/NW+PLVmKSC0Su0VAo2dr2
         rou91ghihkxJd3aFzrcpx2mUntxYdnRkScv1PREw7knzjVe7+wRGZaBY1a7cYB65+Umo
         +lvLziKWbCThLNrNmI8Euobw4LvYBR2fq+taIpYCx4/ArpGypWBBFSRKRpAo2BVtV+ee
         r0eYA882S06eNgpbbID4lfzCOOKK0qzYQKWYg8p6s5F3l7AO62+IHD4AT3BeJlV2eKjk
         4p8w==
X-Gm-Message-State: APjAAAWnNgRbeme4mNZA7Iyt52t9aIytEK1B6KBiXAw59M5ocI7S714b
        cEbrCsttg47rsMn/+8QqQ+sfCEuwObFQDwcUrdvDAg==
X-Google-Smtp-Source: APXvYqwQ0sJhbgkRNydnIi4RrSi/dFi7mwr/zU4s+w0Ydcubj32ElrELRy3PvgOlQ56qXz+SBC5iH82TlZ2DYY/65VY=
X-Received: by 2002:a2e:5d17:: with SMTP id r23mr3716224ljb.229.1569604813845;
 Fri, 27 Sep 2019 10:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
 <alpine.DEB.2.21.9999.1908231717550.25649@viisi.sifive.com>
 <20190826145756.GB4664@cisco> <CAEn-LTrtn01=fp6taBBG_QkfBtgiJyt6oUjZJOi6VN8OeXp6=g@mail.gmail.com>
 <201908261043.08510F5E66@keescook> <alpine.DEB.2.21.9999.1908281825240.13811@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1908281825240.13811@viisi.sifive.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 27 Sep 2019 10:20:02 -0700
Message-ID: <CAJr-aD=UnCN9E_mdVJ2H5nt=6juRSWikZnA5HxDLQxXLbsRz-w@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincentc@andestech.com>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, me@carlosedp.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 28, 2019 at 6:30 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> On Mon, 26 Aug 2019, Kees Cook wrote:
>
> > On Mon, Aug 26, 2019 at 09:39:50AM -0700, David Abdurachmanov wrote:
> > > I don't have the a build with SECCOMP for the board right now, so it
> > > will have to wait. I just finished a new kernel (almost rc6) for Fedora,
> >
> > FWIW, I don't think this should block landing the code: all the tests
> > fail without seccomp support. ;) So this patch is an improvement!
>
> Am sympathetic to this -- we did it with the hugetlb patches for RISC-V --
> but it would be good to understand a little bit more about why the test
> fails before we merge it.

The test is almost certainly failing due to the environmental
requirements (i.e. namespaces, user ids, etc). There are some corner
cases in there that we've had to fix in the past. If the other tests
are passing, then I would expect all the seccomp internals are fine --
it's just the case being weird. It's just a matter of figuring out
what state the test environment is in so we can cover that corner case
too.

> Once we merge the patch, it will probably reduce the motivation for others
> to either understand and fix the underlying problem with the RISC-V code
> -- or, if it truly is a flaky test, to drop (or fix) the test in the
> seccomp_bpf kselftests.

Sure, I get that point -- but I don't want to block seccomp landing
for riscv for that. I suggested to David offlist that the test could
just be marked with a FIXME XFAIL on riscv and once someone's in a
better position to reproduce it we can fix it. (I think the test bug
is almost certainly not riscv specific, but just some missing
requirement that we aren't handling correctly.)

How does that sound?

-Kees
