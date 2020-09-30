Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A0227F574
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 00:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbgI3WtE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 18:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730981AbgI3WtD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 18:49:03 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A197C061755
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 15:49:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so2198426pgm.11
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 15:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VT2vDd9OB7uEL9vUlvmQWoFRKp72QNgXm7S/Mv4km2A=;
        b=b9W9/WFAa7j9YD1PJAI4yFg7dus7W0r/MW7Dboua7FmO8kMbs1gKAajU9Q2CldMKVq
         ScKuRCkr1vwZZCRbn/yF/6r9z2d5ANWOaT0AFusLzF4y5idwBkxeYt+G5BTv7KZAolR8
         6SxxMXSjfujZ2U/hIWKv0FguBBnmAB5AcFqfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VT2vDd9OB7uEL9vUlvmQWoFRKp72QNgXm7S/Mv4km2A=;
        b=bA5cPMRtS7JeXWKasLX8zMeJBFdUvfdhbkqc2O16JEc3PdT/lW8ljm5heCcz7jbPoQ
         518iKvz9ztD17e0PGfiKeNtcIAXxllqImszMbQMPYy1C4Ko8H0hv3ychY4N3izxLvZN7
         PdRvMgWANQgvSs7hcpASZNBezdmbL/Z0PlTpu6GkgKstZatnOE87OIrX7loZrnICubDC
         +LVlbIyuf7qNIMSO4pedaOhXEQwqa/8JFf7/sIzKiEdYAbBcMIEElbDafdKOyrqCPHc5
         kgAB8GV19vsVdOVdfxH2YtczkS/3GeCvBdyqPNfYTskiZ8k7I3dCaFtBHabO/7CGZG2R
         GGWQ==
X-Gm-Message-State: AOAM533RgQs5e68pL0AgfHYTa5HnopZVCk7fjpi8BGVGCZ1LfrlHkOoL
        rwvzou7uXLiC4NtCZE6KIknPyQ==
X-Google-Smtp-Source: ABdhPJwfSK5iNpfj80w0dYS73zpvMdKZB8MpSp2GpAdsedr4h3Z0FZm0dB+5To7uEo0x/wrmF8Kkpw==
X-Received: by 2002:a62:19c4:0:b029:13e:d13d:a0fd with SMTP id 187-20020a6219c40000b029013ed13da0fdmr4271918pfz.25.1601506142852;
        Wed, 30 Sep 2020 15:49:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u10sm3674241pfn.122.2020.09.30.15.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 15:49:02 -0700 (PDT)
Date:   Wed, 30 Sep 2020 15:49:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
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
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v3 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
Message-ID: <202009301546.6B7D648F57@keescook>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
 <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
 <CAG48ez0Njm0oS+9k-cgUqzyUWXV=cHPope2Xe9vVNPUVZ1PB4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0Njm0oS+9k-cgUqzyUWXV=cHPope2Xe9vVNPUVZ1PB4w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 01, 2020 at 12:24:32AM +0200, Jann Horn wrote:
> On Wed, Sep 30, 2020 at 5:20 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > SECCOMP_CACHE_NR_ONLY will only operate on syscalls that do not
> > access any syscall arguments or instruction pointer. To facilitate
> > this we need a static analyser to know whether a filter will
> > return allow regardless of syscall arguments for a given
> > architecture number / syscall number pair. This is implemented
> > here with a pseudo-emulator, and stored in a per-filter bitmap.
> >
> > Each common BPF instruction are emulated. Any weirdness or loading
> > from a syscall argument will cause the emulator to bail.
> >
> > The emulation is also halted if it reaches a return. In that case,
> > if it returns an SECCOMP_RET_ALLOW, the syscall is marked as good.
> >
> > Emulator structure and comments are from Kees [1] and Jann [2].
> >
> > Emulation is done at attach time. If a filter depends on more
> > filters, and if the dependee does not guarantee to allow the
> > syscall, then we skip the emulation of this syscall.
> >
> > [1] https://lore.kernel.org/lkml/20200923232923.3142503-5-keescook@chromium.org/
> > [2] https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/
> [...]
> > +static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sfilter,
> > +                                        void *bitmap, const void *bitmap_prev,
> > +                                        size_t bitmap_size, int arch)
> > +{
> > +       struct sock_fprog_kern *fprog = sfilter->prog->orig_prog;
> > +       struct seccomp_data sd;
> > +       int nr;
> > +
> > +       for (nr = 0; nr < bitmap_size; nr++) {
> > +               if (bitmap_prev && !test_bit(nr, bitmap_prev))
> > +                       continue;
> > +
> > +               sd.nr = nr;
> > +               sd.arch = arch;
> > +
> > +               if (seccomp_emu_is_const_allow(fprog, &sd))
> > +                       set_bit(nr, bitmap);
> 
> set_bit() is atomic, but since we only do this at filter setup, before
> the filter becomes globally visible, we don't need atomicity here. So
> this should probably use __set_bit() instead.

Oh yes, excellent point! That will speed this up a bit. When you do
this, please include a comment here describing why its safe to do it
non-atomic. :)

-- 
Kees Cook
