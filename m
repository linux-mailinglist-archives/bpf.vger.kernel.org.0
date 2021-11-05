Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BD6446ADF
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 23:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhKEW3F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 18:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhKEW3F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 18:29:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67083C061570
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 15:26:25 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x64so10090581pfd.6
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fEf81p5PsDWzE7KhKYbsH/BDNSMdLmbPAYhOFdcx48g=;
        b=J+msY7+zhiOjUuP1oW93V+Au57Fl7R7OWg0xhtHbq77NhJYdH6dOIhArVfB2bIXD9W
         T75NwWAOY2bCZRwU63Hi+rLizR8b9xuDMPdP+ia3XRnvJnNLMQGEk+3itetV3SiRvS8E
         X8NuKOePtRn2rJKFnygGCZBabeasvxaaIexiDqK+0SMOakKVj77/jtsyW+KWcwtIw7pF
         +HLj/QYNvs18W4/HBy5ZAYF/5Mi6J8iJtyJyVW4wd4cUAQxOgG2rKZnrL+j/FI0R8CWw
         R4l8oRlX3VTGXhAZyK5cpmZXn0IR57hJkAJkprVOI9QpZI3Qn439EcE3wQ47S5Q/lNiW
         2XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fEf81p5PsDWzE7KhKYbsH/BDNSMdLmbPAYhOFdcx48g=;
        b=ocsrgtAtTuATkdWt7K6eAz4XcFVDKGJFUnOL15Z3hRSZEZJkwYwgxmra/+DzoBoMNK
         RMIfqk9sKGZ4vS0YBBMKg0W91C8HMgTdr9XKAcGTFnlEd7c3f1ljqGtAu5N9gb+ETfmh
         cAk3FRpcX1vOP+wyXk2EhrSSj8SxAn2tZOVwfHZTX4cJAAITGz3UvI8T7uMKWcwXurUy
         eWoVqjo98no2WN3VgzgNc2fnRhi1kdn6T2dDuVUdE6NBWEhCvfItoxE8cdT4DEGQmUrx
         Q72Vp1pTLxAFcrgYuGXEXVcjZszXqWsYav88e5DTH4DaWhPMfYlcwhScF7KqAkl1bl5Q
         0DlQ==
X-Gm-Message-State: AOAM533zAVS9+ftKSab2QsOMIiwyAU11NeorOyTeP73Ew756idwodBF1
        nosrDRKRE+SGnzFIcwCQrzs=
X-Google-Smtp-Source: ABdhPJwjG+a1WO67Y33tceALjm/tHwedY2PEvvXMNww0dbReLhTHKsuAzpsf5QZxVvqXe1ZFoMmw+w==
X-Received: by 2002:a05:6a00:1a4f:b0:481:2b22:e95c with SMTP id h15-20020a056a001a4f00b004812b22e95cmr28403752pfv.8.1636151184808;
        Fri, 05 Nov 2021 15:26:24 -0700 (PDT)
Received: from localhost ([2405:201:6014:d916:31fc:9e49:a605:b093])
        by smtp.gmail.com with ESMTPSA id y35sm8872843pfa.43.2021.11.05.15.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:26:24 -0700 (PDT)
Date:   Sat, 6 Nov 2021 03:56:21 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] libbpf: fix non-C89 loop variable declaration
 in gen_loader.c
Message-ID: <20211105222621.xcb724qki5ajvnt5@apollo.localdomain>
References: <20211105191055.3324874-1-andrii@kernel.org>
 <20211105204051.v7wzca6fryb774m4@apollo.localdomain>
 <CAEf4Bzb83Nz3iRa1t8+EknuowkkbYwf+zjwRj_SJSvh0ewfa+g@mail.gmail.com>
 <20211105220410.j2eur76wvzjd3fab@apollo.localdomain>
 <CAEf4BzZncpbHtSp47jv4cE0CYZ+3tFBNqrj+HoXFcx_5EjSNbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZncpbHtSp47jv4cE0CYZ+3tFBNqrj+HoXFcx_5EjSNbA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 06, 2021 at 03:50:47AM IST, Andrii Nakryiko wrote:
> On Fri, Nov 5, 2021 at 3:04 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > On Sat, Nov 06, 2021 at 03:19:38AM IST, Andrii Nakryiko wrote:
> > > On Fri, Nov 5, 2021 at 1:40 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > >
> > > > On Sat, Nov 06, 2021 at 12:40:55AM IST, Andrii Nakryiko wrote:
> > > > > Fix the `int i` declaration inside the for statement. This is non-C89
> > > > > compliant. See [0] for user report breaking BCC build.
> > > > >
> > > > >   [0] https://github.com/libbpf/libbpf/issues/403
> > > > >
> > > > > Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC relocations")
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > >
> > > > Thanks for the fix, and sorry about that.
> > > >
> > > > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > >
> > >
> > > No worries, we just need to figure out which compiler flags we need to
> > > catch this. I'm surprised BCC build caught this and neither libbpf's
> > > Makefile nor selftest did. Selftests are definitely too permissive
> > > w.r.t. stuff like this.
> > >
> > > If you could take a look and see what we'll need to lock it down a
> > > bit, that would be great. I've also requested help from the original
> > > reporter of this issue (see issue on Github).
> > >
> >
> > I think you want -std=gnu89 (i.e. C89 with GNU extensions). I get the same error
> > as the reporter when building with that.
>
> Oh, I think I tried -std=c89 and it didn't compile due to use of those
> extensions. Didn't realize gnu89 exists. Do you mind adding it to
> bpftool, libbpf, and selftests Makefiles and sending a patch?
>

Sure, will do!

--
Kartikeya
