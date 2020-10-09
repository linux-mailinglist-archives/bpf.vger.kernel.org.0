Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F83287F6D
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 02:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgJIARv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Oct 2020 20:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgJIARv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Oct 2020 20:17:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FBBC0613D2;
        Thu,  8 Oct 2020 17:17:51 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g29so5731179pgl.2;
        Thu, 08 Oct 2020 17:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfhHHR4pKbk7p2RCtudI48L9yccCmQn13QSmLqHOpqE=;
        b=l+9ARLRb9oLSk2zBqP7Ye+thTIcpC9bxYPWNxSajiaetz6v3CgqO1xHoPTX03fErKa
         QchKdmiUftQRFJ7jMHBLv4Nb8LACpVAlC32HvlYV26TEMUkuZgFDC8MiDZTOk5vU62g4
         GuWs6HoiK5wGXRVFpMbqidU1nmW62b4arwFBI/lDjjRQTQF3vblCUv36QKmjciqYPyXS
         gf0INfCeuAuKNFw4b0qBNdJGO6zsMZOI/RXdSOZObkutDnVNJ1jWEZZfS08DdtggAd+Z
         v8nZiUExVcHkjkABs4GnC4XBLwf4rj40VYZMBEVU4j646xJoiaGib0LiCT0VO+LdU7eS
         SGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfhHHR4pKbk7p2RCtudI48L9yccCmQn13QSmLqHOpqE=;
        b=cpmj5mBK8MfzGjB2IEckIZYMuRmWP+Jk7G8WnMJGnUxtZZYGn+r5INmRnnJxjHVjW0
         tLYOMO1xC9mhRE4qzIeBMVH+aBIun//xtX7ci6RsZJ5+jjw6PsMd8MtEZ3sBV0kj6zM+
         WnsYAkYQKTjRxHw/OTMz7guvCYEW0YbmMEoVq/3dHocvMCiakxnghtErDNwxlAJYFkO3
         z07gE0cDSDZV7oxvFM1EjIGDPwczC0gKvTtjiRZPrI3A2VK40gmNPDvq/8CKjO7ia10W
         MlvTFp+C02jFvA3eeSguDRT7QgUgqXK4lYMYbBRSao/gOoOXrZkMkcgl1xtS31ShFpAN
         1Lmw==
X-Gm-Message-State: AOAM530UvbZejLuMwiS5hR+zYgSKq7CKlgTpCOoei9QG0kuOXg6zOBkI
        8Y8dGrrQbIsZnKmdEt6qxxPvflO50AkOkwlkue4=
X-Google-Smtp-Source: ABdhPJwcXfNIgKgm3YkQPIhlaT3JnMp3WueuSFA6XTYpyR/WEW0+W0BG2h4lGxp1o1UtTjbNnQYadnf5Ix3d1XgiBug=
X-Received: by 2002:a63:1c19:: with SMTP id c25mr1245508pgc.66.1602202670500;
 Thu, 08 Oct 2020 17:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <83c72471f9f79fa982508bd4db472686a67b8320.1601478774.git.yifeifz2@illinois.edu>
 <202009301422.D9F6E6A@keescook>
In-Reply-To: <202009301422.D9F6E6A@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 8 Oct 2020 19:17:39 -0500
Message-ID: <CABqSeASbRXLYgE=rbKO8g8Si9q7nKEGB2UZpi-BcYG5etWVcjA@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 3/5] seccomp/cache: Lookup syscall allowlist
 for fast path
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 4:32 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 30, 2020 at 10:19:14AM -0500, YiFei Zhu wrote:
> > From: YiFei Zhu <yifeifz2@illinois.edu>
> >
> > The fast (common) path for seccomp should be that the filter permits
> > the syscall to pass through, and failing seccomp is expected to be
> > an exceptional case; it is not expected for userspace to call a
> > denylisted syscall over and over.
> >
> > This first finds the current allow bitmask by iterating through
> > syscall_arches[] array and comparing it to the one in struct
> > seccomp_data; this loop is expected to be unrolled. It then
> > does a test_bit against the bitmask. If the bit is set, then
> > there is no need to run the full filter; it returns
> > SECCOMP_RET_ALLOW immediately.
> >
> > Co-developed-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> > Signed-off-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
>
> I'd like the content/ordering of this and the emulator patch to be reorganized a bit.
> I'd like to see the infrastructure of the cache added first (along with
> the "always allow" test logic in this patch), with the emulator missing:
> i.e. the patch is a logical no-op: no behavior changes because nothing
> ever changes the cache bits, but all the operational logic, structure
> changes, etc, is in place. Then the next patch would be replacing the
> no-op with the emulator.
>
> > ---
> >  kernel/seccomp.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index f09c9e74ae05..bed3b2a7f6c8 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -172,6 +172,12 @@ struct seccomp_cache_filter_data { };
> >  static inline void seccomp_cache_prepare(struct seccomp_filter *sfilter)
> >  {
> >  }
> > +
> > +static inline bool seccomp_cache_check(const struct seccomp_filter *sfilter,
>
> bikeshedding: "cache check" doesn't tell me anything about what it's
> actually checking for. How about calling this seccomp_is_constant_allow() or
> something that reflects both the "bool" return ("is") and what that bool
> means ("should always be allowed").

We have a naming conflict here. I'm about to rename
seccomp_emu_is_const_allow to seccomp_is_const_allow. Adding another
seccomp_is_constant_allow is confusing. Suggestions?

I think I would prefer to change seccomp_cache_check to
seccomp_cache_check_allow. While in this patch set seccomp_cache_check
does imply the filter is "constant" allow, argument-processing cache
may change this, and specifying an "allow" in the name specifies the
'what that bool means ("should always be allowed")'.

YiFei Zhu
