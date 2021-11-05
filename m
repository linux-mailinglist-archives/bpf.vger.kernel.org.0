Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE39446AC5
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 23:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhKEWGz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 18:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhKEWGx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 18:06:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3270C061570
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 15:04:13 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so8090406pgh.11
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 15:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r79gdAKkboiROIqleY33ruXBohLeWKn0vdRl+5ReWFY=;
        b=QgrmHwt9vqXqTnQNl87TT2mmdHq4ePZNJ8XgztBAodc5T24oCL8vHF1/OgHAeUBe2Q
         78YHsuyqL/0X6PgWLJArHSPme7CsirKDlslB/KHtACs7Eudqj+CtZ5Evygcfkw7Ut3OA
         ibi/ycaHwqeZtzVj7oCupC5QsJrVGFJdtwSRLSltfGamw3x+IawacaF7EaOb6025w98F
         X36JjhA0aP59aRqfgIwwmbJdiEQ/AVVfOg3ES+UegKSMJgZbJG0l7BoJfbhZLcPMTCs/
         Vx99GVvSW3DvO3GrRRvpD6lowRlEx6LzzX8XhFxs+15C548QHZGb8Ygz4dcE3fgW/odV
         AYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r79gdAKkboiROIqleY33ruXBohLeWKn0vdRl+5ReWFY=;
        b=eK9K/bYvfh+fA8sLIfv5Y75e+rw5GFxqBpwHCfBRL6nnU1IFohfI3HmIKBKlXltx/O
         jiNEWS5vdGKZnGD/XNPmKEh0fO6ef4bGVGU+SH5YEZTughaza1llekSq3vrQ4Z9aXBEq
         2aU8+V6mkzRHdCmfZPKzBJ9/xfNND3nXTVhaA7LDQCe+J2+82b8gJlq/ESPG4gxt7rMp
         xhgX9nvEoeOdSanRlU57bHb3qODQYpSLMxUz+/dpo74N+aoR7PktPcS9/hL+JuAKkj9r
         DsF4SVvq582lHNzD0E3C0z5GGE6Q9LiBWU7DtJvpOFRap5vjgBydnilgravYL50I9FFi
         jR5g==
X-Gm-Message-State: AOAM531VGw9RII5lAPAJeyqSdHvq6i2gUywKgAxtnHwvfUaaaSQ+K8nl
        /Jnb4kosD5xi8dko0tlpGEw=
X-Google-Smtp-Source: ABdhPJykL9U7fMng9aHIOjW3ooHqnwnW0KE74H3klr4DVOBH0gWbJnTbuXPe0v2vUViziusxw5FLCg==
X-Received: by 2002:a05:6a00:1acf:b0:49f:9cd6:529 with SMTP id f15-20020a056a001acf00b0049f9cd60529mr6918522pfv.62.1636149853456;
        Fri, 05 Nov 2021 15:04:13 -0700 (PDT)
Received: from localhost ([2405:201:6014:d916:31fc:9e49:a605:b093])
        by smtp.gmail.com with ESMTPSA id t2sm6794287pgf.35.2021.11.05.15.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:04:13 -0700 (PDT)
Date:   Sat, 6 Nov 2021 03:34:10 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] libbpf: fix non-C89 loop variable declaration
 in gen_loader.c
Message-ID: <20211105220410.j2eur76wvzjd3fab@apollo.localdomain>
References: <20211105191055.3324874-1-andrii@kernel.org>
 <20211105204051.v7wzca6fryb774m4@apollo.localdomain>
 <CAEf4Bzb83Nz3iRa1t8+EknuowkkbYwf+zjwRj_SJSvh0ewfa+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb83Nz3iRa1t8+EknuowkkbYwf+zjwRj_SJSvh0ewfa+g@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 06, 2021 at 03:19:38AM IST, Andrii Nakryiko wrote:
> On Fri, Nov 5, 2021 at 1:40 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > On Sat, Nov 06, 2021 at 12:40:55AM IST, Andrii Nakryiko wrote:
> > > Fix the `int i` declaration inside the for statement. This is non-C89
> > > compliant. See [0] for user report breaking BCC build.
> > >
> > >   [0] https://github.com/libbpf/libbpf/issues/403
> > >
> > > Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC relocations")
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Thanks for the fix, and sorry about that.
> >
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >
>
> No worries, we just need to figure out which compiler flags we need to
> catch this. I'm surprised BCC build caught this and neither libbpf's
> Makefile nor selftest did. Selftests are definitely too permissive
> w.r.t. stuff like this.
>
> If you could take a look and see what we'll need to lock it down a
> bit, that would be great. I've also requested help from the original
> reporter of this issue (see issue on Github).
>

I think you want -std=gnu89 (i.e. C89 with GNU extensions). I get the same error
as the reporter when building with that.

>
> > > [...]
> >
> > --
> > Kartikeya

--
Kartikeya
