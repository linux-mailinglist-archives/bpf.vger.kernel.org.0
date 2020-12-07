Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158182D0E98
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 12:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgLGLBB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 06:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgLGLBA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 06:01:00 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1C1C0613D1
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 03:00:20 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m5so2686165wrx.9
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 03:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Of1GuHMcacZDGavR17lWzfhPO8aTLH8wtw5w1WkEg9o=;
        b=k6q6RJ7sx6u0IFHGYe2vKIzMETe6DHIaz1Kof74EDPeou+CDRGX+hbJRk3sp0JBPYF
         dkVr80dVeWeDj7oa7wAWYCXvPntVHXrKGfSUkKB1W2lbLuzMy1blmizUyG6iM6RScldV
         x2qjf3B5jtnRjsS/iD6dNc5voF1y/3gp198Hb1H/vzmYBwvyvf2cQTrbMVH97hmsK3K8
         fCZ0MYw694cycyaQ3SfAtSRpSX59L58X0TazgGXZeaK4M/8DvVUjXYZhRdulwbkFTT+r
         GBXimEUMTcyRshSZwdIXCgbGQUYyNwho7pJLjcUhs1nh/AgyziAvdVRT0goGozmvlBl1
         VvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Of1GuHMcacZDGavR17lWzfhPO8aTLH8wtw5w1WkEg9o=;
        b=OO3e4sKXIQigzrUIMwC9nL3DtnjxE7GB/99KzDRiU4drc6PT+DzJOwW+D5ykoVY2gD
         nHq0uo3IJal5QsN6akOejvY+OZ040ykwee1cpH/qppvzrBs7n/bQ2z+lrgbH5cESi9OP
         Q2J8HADKOdqZrjCTGhI3EHo6y/1cyRS+mfzSwiJjHT+8FcaAbLxe4AMee2UKjQJFNRZU
         P8lTGZSD0wkANAl/1EoKP2kwJ2eEMgzHE28rT1x5z9nXChcuGb+ZwFhkXtKTSJSOWZed
         PdBiSG1EzHSCNKtqaQPLLyt78LaA1HVDK/HBDfxrbxQmqqBnve9SESy6U70keoKwch9A
         vqgA==
X-Gm-Message-State: AOAM532s1edCRcgyc/oVDOPiBhRAT12F2Pz8mZFYo2vq9oEzAComv86w
        z5WpwgubbqSmVMIdmCNfK2E2gg==
X-Google-Smtp-Source: ABdhPJxsTcHWsd5iv0L+PhwHVUAV3jErRZXdGhZUtFqRNCMzepiyvYbIIKlS++YTtT/yLyQLnZkKWQ==
X-Received: by 2002:adf:c986:: with SMTP id f6mr12341682wrh.361.1607338818674;
        Mon, 07 Dec 2020 03:00:18 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id z8sm13066080wmg.17.2020.12.07.03.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 03:00:17 -0800 (PST)
Date:   Mon, 7 Dec 2020 11:00:13 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 12/14] bpf: Pull tools/build/feature biz into
 selftests Makefile
Message-ID: <X84LPVp3PqfESx9U@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-13-jackmanb@google.com>
 <CAEf4BzbEfPScq_qMVJkDxfWBh-oRhY5phFr=517pam80YcpgMg@mail.gmail.com>
 <X8oEOPViOhR8XdH6@google.com>
 <CAEf4BzaEystdQ3PbaZXhmpTfqbs410BVCEToHfKLgx-3wAm-KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaEystdQ3PbaZXhmpTfqbs410BVCEToHfKLgx-3wAm-KA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 04, 2020 at 11:00:24AM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 4, 2020 at 1:41 AM Brendan Jackman <jackmanb@google.com> wrote:
> >
> > On Thu, Dec 03, 2020 at 01:01:27PM -0800, Andrii Nakryiko wrote:
> > > On Thu, Dec 3, 2020 at 8:07 AM Brendan Jackman <jackmanb@google.com> wrote:
> > > >
> > > > This is somewhat cargo-culted from the libbpf build. It will be used
> > > > in a subsequent patch to query for Clang BPF atomics support.
> > > >
> > > > Change-Id: I9318a1702170eb752acced35acbb33f45126c44c
> > >
> > > Haven't seen this before. What's this Change-Id business?
> >
> > Argh, apologies. Looks like it's time for me to adopt a less error-prone
> > workflow for sending patches.
> >
> > (This is noise from Gerrit, which we sometimes use for internal reviews)
> >
> > > > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > > > ---
> > > >  tools/testing/selftests/bpf/.gitignore |  1 +
> > > >  tools/testing/selftests/bpf/Makefile   | 38 ++++++++++++++++++++++++++
> > > >  2 files changed, 39 insertions(+)
> > >
> > > All this just to detect the support for clang atomics?... Let's not
> > > pull in the entire feature-detection framework unnecessarily,
> > > selftests Makefile is complicated enough without that.
> >
> > Then the test build would break for people who haven't updated Clang.
> > Is that acceptable?
> >
> > I'm aware of cases where you need to be on a pretty fresh Clang for
> > tests to _pass_ so maybe it's fine.
> 
> I didn't mean to drop any detection of this new feature. I just didn't
> want a new dependency on tools' feature probing framework. See
> IS_LITTLE_ENDIAN and get_sys_includes, we already have various feature
> detection-like stuff in there. So we can do this with a one-liner. I
> just want to keep it simple. Thanks.

Ah right gotcha. Then yeah I think we can do this:

 BPF_ATOMICS_SUPPORTED = $(shell \
        echo "int x = 0; int foo(void) { return __sync_val_compare_and_swap(&x, 1, 2); }" \
        | $(CLANG) -x cpp-output -S -target bpf -mcpu=v3 - -o /dev/null && echo 1 || echo 0)
