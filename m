Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55563277E82
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 05:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIYD2m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 23:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYD2m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 23:28:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876FCC0613CE;
        Thu, 24 Sep 2020 20:28:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 5so1368460pgf.5;
        Thu, 24 Sep 2020 20:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKwaSEBh/aNFcHLbsrqXTKnHnGZtGuyc7kM8iGIPRLM=;
        b=OiYYJ/us006aCQf8GreRu+v+umHyKuyJ53tWXgVLYKCgpjHSbVOGfP9NeOMrPERPkN
         fmlosi7oYA0P9EtBqPMUJqOWUsBwE+ibW/ooPeQ70jKnWG4370Zrtv40OVzlDx0ZEf4r
         AnlTwk3rBGD2VttqfanX6R93rzUfDik7jwy84XIJcJg1TZrTaYfhfWBqM7TfyXykz2DB
         QI8Erwr5nqcOMAAj0di4ks6hTFBMfpD2NyTht2eaWuRHfTBdjkof5/3aHKUztSzFS0N5
         ZRYp0xekaQ7wZSDR9P6FISnEXN0RNXNFo24NqCRlyvr1bYMWDZX9QvG9s+xEjqGobfLo
         RAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKwaSEBh/aNFcHLbsrqXTKnHnGZtGuyc7kM8iGIPRLM=;
        b=N9HDAg6oAoebEk+WWagA2EFIob34n287YSLDFc17Q+78Jrpq2k0PrvG1yiPR/GGYD3
         Dk9UbOynxfbT+/wtcc+4o++1ZE4GbHZArNgS1t0iHMiDtXRh2JklRDxMxg9WDCT7RCED
         QrFHp4oeoh6nPrN6PUN3HzMcatBgg4a9G+o82pOSMzyOsvtxgKQNZEnPMMkFy2gPqKmt
         EmqEMgerd4OEr7GXQJAWR7zjOG4RFRO7s5DYRUjQI+dv6tSEtZ523dTGlc3ZBEfl1PaG
         ydWdrKhvBFp3BM9d7C3BL7ErFuzxPhr2I0JSPk0dwix3drxDOA/xt2cGZR8IX/Q7Yavw
         +2ug==
X-Gm-Message-State: AOAM53155HfCJIq+yzaMnzaX3ojvfo2sd9DJXgwMDzqmEbILhvbtYV5T
        h/EBBfj6DIiswHiKHdf4HZIzSLg1ilchMu1X47s=
X-Google-Smtp-Source: ABdhPJzyyAhHtoK2wZHqoUFbZHJWRTfpD857YUtUND4/x9KBeMbRkdMSgFIGeLqMu6/zEKEJVS4vbV6+V7CgGFtQdUk=
X-Received: by 2002:a63:511d:: with SMTP id f29mr1846448pgb.11.1601004522041;
 Thu, 24 Sep 2020 20:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
 <202009241658.A062D6AE@keescook> <CABqSeAQ=joheH+0LUZ201U-XwFFsHN3Ouo5FGoscUwn+itkL2w@mail.gmail.com>
 <202009242000.DE12689BD8@keescook>
In-Reply-To: <202009242000.DE12689BD8@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 22:28:31 -0500
Message-ID: <CABqSeATWoFXM6uBHywVrJCo1JvCwHZ6gyegiJp_y4nr97BY-3Q@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Linux Containers <containers@lists.linux-foundation.org>,
        bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
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

On Thu, Sep 24, 2020 at 10:09 PM Kees Cook <keescook@chromium.org> wrote:
> Right, sorry, I may not have been clear. When building my RFC I noticed
> that I couldn't use NR_syscall very "early" in the header file include
> stack on arm64, which complicated things. So I guess what I mean is
> something like "it's probably better to do all these seccomp-specific
> macros/etc in asm/include/seccomp.h rather than in syscall.h because I
> know at least one architecture that might cause trouble."

Ah. Makes sense.

> Ironicailly, that's the only place I actually know for sure where people
> using x32 because it shows measurable (10%) speed-up for builders:
> https://lore.kernel.org/lkml/CAOesGMgu1i3p7XMZuCEtj63T-ST_jh+BfaHy-K6LhgqNriKHAA@mail.gmail.com

Wow. 10% is significant. Makes you wonder why x32 hasn't conquered the world.

> So, yes, as you and Jann both point out, it wouldn't be terrible to just
> ignore x32, it seems a shame to penalize it. That said, if the masking
> step from my v1 is actually noticable on a native workload, then yeah,
> probably x32 should be ignored. My instinct (not measured) is that it's
> faster than walking a small array.[citation needed]

My instinct: should be pretty similar, with the loop unrolled.

You convince me that penalizing supporting x32 would be a pity :( The
10% is so nice I want it.

> It's easier to do a per-arch revert (i.e. all the -stable tree
> machinery, etc) with a single SHA instead of having to write a partial
> revert, etc.

I see. Thanks for clarifying.

How about this? Rather than specifically designing names for bitmasks
(native, compat, multiplex), just have SECCOMP_ARCH_{1,2,3}? Each arch
number would provide the size of the bitmap and a static inline
function to check the given seccomp_data belongs to the arch and if
so, the order of the bit in the bitmap. There is no need for the
shifts and madness in seccomp.c; it's arch-dependent code in their own
seccomp.h. We let the preprocessor and compiler to make things
optimized.

YiFei Zhu
