Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4EA1EBC1C
	for <lists+bpf@lfdr.de>; Tue,  2 Jun 2020 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgFBMxZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Jun 2020 08:53:25 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:47216 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBMxZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Jun 2020 08:53:25 -0400
X-Greylist: delayed 96103 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2020 08:53:25 EDT
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 357ACE8154A;
        Tue,  2 Jun 2020 14:53:24 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id DBA17160AC6; Tue,  2 Jun 2020 14:53:23 +0200 (CEST)
Date:   Tue, 2 Jun 2020 14:53:23 +0200
From:   Lennart Poettering <lennart@poettering.net>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: new seccomp mode aims to improve performance
Message-ID: <20200602125323.GB123838@gardel-login>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
 <202005291043.A63D910A8@keescook>
 <20200601101137.GA121847@gardel-login>
 <CAHC9VhTK1306C2+ghMWHC0X6XVHiG+vBKPC5=7QLjxXwX4Eu9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTK1306C2+ghMWHC0X6XVHiG+vBKPC5=7QLjxXwX4Eu9Q@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mo, 01.06.20 08:32, Paul Moore (paul@paul-moore.com) wrote:

> In situations where the calling application creates multiple per-ABI
> filters, the seccomp_merge(3) function can be used to merge the
> filters into one.  There are some limitations (same byte ordering,
> filter attributes, etc.) but in general it should work without problem
> when merging x86_64, x32, and x86.

Hmm, so we currently only use seccomp_rule_add_exact() to build an
individual filter and finally seccomp_load() to install it. Which
tells us exactly what works and what does not.

If we now would use seccomp_rule_add_exact() to build the filters, but
then use seccomp_merge() to merge them all, and then only do a single
seccomp_load(), will this give us the same info? i.e. will
seccomp_merge() give us the same errors seccomp_load() currently gives
us when something cannot work?

> > If we wanted to optimize that in userspace, then libseccomp would have
> > to be improved quite substantially to let us know exactly what works
> > and what doesn't, and to have sane fallback both when building
> > whitelists and blacklists.
>
> It has been quite a while since we last talked about systemd's use of
> libseccomp, but the upcoming v2.5.0 release (no date set yet, but
> think weeks not months) finally takes a first step towards defining
> proper return values on error for the API, no more "negative values on
> error".  I'm sure there are other things, but I recall this as being
> one of the bigger systemd wants.

Yes, we care about error codes a lot.

> As an aside, it is always going to be difficult to allow fine grained
> control when you have a single libseccomp filter that includes
> multiple ABIs; the different ABI oddities are just too great (see
> comments above).  If you need exacting control of the filter, or ABI
> specific handling, then the recommended way is to create those filters
> independently and merge them together before loading them into the
> kernel or applying any common rules.

Hmm, so not sure I got this. But are you saying that when using
seccomp_merge() am I supposed to merge filters for different archs
into one megafilter, or are you saying the opposite: am I supposed not
to do that?

I.e. in an ideal world, should we come to a situation where per
service on x86-64 we will have exactly one filter installed, or should
we come to a situation where we'll have exactly three installed, once
for each ABI?

Lennart

--
Lennart Poettering, Berlin
