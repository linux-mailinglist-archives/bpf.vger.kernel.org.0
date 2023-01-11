Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4F8666693
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 23:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbjAKW5X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 17:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjAKW5Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 17:57:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5BA2630
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 14:57:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 18so24522470edw.7
        for <bpf@vger.kernel.org>; Wed, 11 Jan 2023 14:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+RrKmWwLDxiMIWtK50sCnrWD6hnHcixiZMQnfOYnyo=;
        b=ULVcwZbY0L+QoorUS8xZIOAA9mfAbbDn4FpQLnRvjgVbSdjFRPOYnzOw/dqodnqQeZ
         N2TRgP4mlU4AMJPzqxgdlyfRS2btujnqvzRO2cW99aRTZsIganfVHRURKI9jDjVkhR40
         udL2ODQ8ffUkIjD7Q9dultYirqlWDO75y11+PHfBD1Dfui3dmGwQnlVyfqSHJLxm9ohh
         oefg1G7x/SICcYps0nstXD+mXNOCqFj1WXRPVAslviEz8gMy/Hbd/a3dEUgVbNX+D/pv
         rgUPERzHWYuDc7yq/IFxbL+IBzryxibhbieWAS1nMWXlrmBdS0lCC5B0/hr7moMStfis
         RkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+RrKmWwLDxiMIWtK50sCnrWD6hnHcixiZMQnfOYnyo=;
        b=b+k/cy2qgi5CpYxSSNTNArBLp1x/037pN+7CEAOpvuyHrDRSj3TrtKeYEDYDuzKMae
         kBfmz99AgrZiAxln/QCvGvlyhnKF2ByIZGVj15KevMJGpLn6xqxte0KEmii3EG3i/YiE
         s8gT+sm3Lz8jT/07mnrezVPxZiTx557GZkaIGciEwI6SPhqL1Cu+ezcq7LI2O8+/QnJI
         bO6kbTLefiTDzmsdoMnlnp8BFzW65yivXihEHt3sBOEDBfkjPYzwM9RnIV+rAUQ0hLF1
         0ADoVhwz+9WHyhxL5o8AAVFpa7dQO/L35otdCIuUpLU4ai8Jf886Ymv/JhO8VFncZzOG
         e03w==
X-Gm-Message-State: AFqh2kpmUJB0OdRyjU36IVtr1kH4fLXVQQQkMyYG3zmPZqspGa9FOHB/
        xn47UzPytF8Zu8YhnMqlK3Q=
X-Google-Smtp-Source: AMrXdXvRs4dHsuAlCl8pIbJV81DwW7Aypbv/Bw+vPVQsF/tPDN8eKR9FF0KMEKAScvhTUPJnsOGcww==
X-Received: by 2002:a05:6402:1d98:b0:498:b9ea:1894 with SMTP id dk24-20020a0564021d9800b00498b9ea1894mr13388833edb.15.1673477820992;
        Wed, 11 Jan 2023 14:57:00 -0800 (PST)
Received: from localhost ([193.142.146.213])
        by smtp.gmail.com with ESMTPSA id l22-20020a056402029600b0048eb0886b00sm6587448edv.42.2023.01.11.14.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:57:00 -0800 (PST)
Date:   Thu, 12 Jan 2023 00:56:57 +0200
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        David Vernet <void@manifault.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@meta.com, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>
Subject: Re: bpf helpers freeze. Was: [PATCH v2 bpf-next 0/6] Dynptr
 convenience helpers
Message-ID: <Y78+iIqqpyufjWOv@mail.gmail.com>
References: <CAEf4BzbVoiVSa1_49CMNu-q5NnOvmaaHsOWxed-nZo9rioooWg@mail.gmail.com>
 <20221225215210.ekmfhyczgubx4rih@macbook-pro-6.dhcp.thefacebook.com>
 <CAEf4BzYhn0vASt1wfKTZg8Foj8gG2oem2TmUnvSXQVKLnyEN-w@mail.gmail.com>
 <20221230024641.4m2qwkabkdvnirrr@MacBook-Pro-6.local>
 <Y68wP/MQHOhUy2EY@maniforge.lan>
 <20221230193112.h23ziwoqqb747zn7@macbook-pro-6.dhcp.thefacebook.com>
 <Y69RZeEvP2dXO7to@maniforge.lan>
 <20221231004213.h5fx3loccbs5hyzu@macbook-pro-6.dhcp.thefacebook.com>
 <f69b7d7a-cdac-a478-931a-f534b34924e9@iogearbox.net>
 <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103235107.k5dobpvrui5ux3ar@macbook-pro-6.dhcp.thefacebook.com>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 03, 2023 at 03:51:07PM -0800, Alexei Starovoitov wrote:
> On Tue, Jan 03, 2023 at 12:43:58PM +0100, Daniel Borkmann wrote:
> > Discoverability plus being able to know semantics from a user PoV to figure out when
> > workarounds for older/newer kernels are required to be able to support both kernels.
> 
> Sounds like your concern is that there could be a kfunc that changed it semantics,
> but kept exact same name and arguments? Yeah. That would be bad, but we should prevent
> such patches from landing. It's up to us to define sane and user friendly deprecation of kfuncs.

I would advocate for adding versioning to BPF API (be it helpers or
"stable" kfuncs). Right now we have two extremes: helpers that can't be
changed/fixed/deprecated ever, and kfuncs that can be changed at any
time, so the end users can't be sure new kernel won't break their stuff.
Detecting and fixing the breakage can also be tricky: end users have to
write different probes on a case-by-case basis, and sometimes it's not
just a matter of checking the number of function parameters or presence
of some definition (such difficulties happen when backporting drivers to
older kernels, so I assume it may be an issue for BPF programs as well).

Let's say we add a version number to the kernel, and the BPF program
also has an API version number it's compiled for. Whenever something
changes in the stable API on the kernel side, the version number is
increased. At the same time, compatibility on the kernel side is
preserved for some reasonable period of time (2 years, 5 years,
whatever), which means that if the kernel loads a BPF program with an
older version number, and that version is within the supported period of
time, the kernel will behave in the old way, i.e. verify the old
signature of a function, preserve the old behavior, etc.

This approach has the following upsides:

1. End users can stop worrying that some function changes unexpectedly,
and they can have a smoother migration plan.

2. Clear deprecation schedule.

3. Easy way to probe for needed functionality, it's just a matter of
comparing numbers: the BPF program loader checks that the kernel is new
enough, and the kernel checks that the BPF program's API is not too old.

4. Kernel maintainers will have a deprecation strategy.

Cons:

1. Arguably a maintainance burden to preserve compatibility on the
kernel side, but I would say it's a balance between helpers (which are
maintainance burden forever) and kfuncs (which can be changed in every
kernel version without keeping any compatibility). "Kfunc that changed
its semantics is bad, we should prevent such patches" are just words,
but if the developer needs to keep both versions for a while, it will
serve as a calm-down mechanism to prevent changes that aren't really
necessary. At the same time, the dead code will stop accumulating,
because it can be removed according to the schedule.

2. Having a single version number complicates backporting features to
older kernels, it would require backporting all previous features
chronologically, even if there is no direct dependency. Having multiple
version numbers (per feature) is cumbersome for the BPF program to
declare. However, this issue is not new, it's already the case for BPF
helpers (you can't backport new helpers skipping some other, because the
numbers in the list must match).

The above description intentionally doesn't specify whether it should be
applied to helpers or kfuncs, because it's a universal concept, about
which I would like to hear opinions about versioning without bias to
helpers or kfuncs.

Regarding freezing helpers, I think there should be a solution for
deprecating obsolete stuff. There are historical examples of removing
things from UAPI: removing i386 support, ipchains, devfs, IrDA
subsystem, even a few architectures [1]. If we apply the versioning
approach to helpers, we can make long-waiting incompatible changes in
v1, keeping the current set of helpers as v0, used for programs that
don't declare a version. Eventually (in 5 years, in 10 years, whatever
sounds reasonable) we can drop v0 and remove the support for unversioned
BPF programs altogether, similar to how other big things were removed
from the kernel. Does it sound feasible?

[1]: https://lwn.net/Articles/748074/

> "Proper BPF helper" model is broken.
> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
> 
> is a hack that works only when compiler optimizes the code.

What if we replace codegen for helpers, so that it becomes something
like this?

static inline void *bpf_map_lookup_elem(void *map, const void *key)
{
	// pseudocode alert!
	asm("call 1" : : "r1"(map), "r2"(key));
}

I.e. can we just throw in some inline BPF assembly that prepares
registers and invokes a call instruction with the helper number? That
should be portable across clang and gcc, allowing to stop relying on
optimizations.

Any caveats?
