Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AD145992B
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 01:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhKWAf4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWAf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:35:56 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D08AC061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:32:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso1354055pjb.2
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvzhsp+Vac0FB6rdWN4NAL1yHJzcPpxVK46WCj5TJbM=;
        b=psVAw1pjGs62iQgrXYaoc691GBkoZ5ib/ZQu63VD8Pd35LgkiieDXuXYdcpq8TfMwd
         98OTAj7z7hho0zWEYe3dEZnUAJdy+/wROscqVvzkBjXLm/+e6X8nLActEHoI4TEJanNV
         RFf/w/isvnh8mhzRAJp5zYeqnqZQqGoBsM5jT61ezWPZELacK76bW0PKOJtgd/ANs2iR
         BhuN+/ss4w1gCbP3geo37qm9ZNrcFPp7G9EwHggjNOcV8qqwUYyoN2CLT8Pxaq8C2Uo1
         52JM/zcaBgJPwd0VZ7vV/Tk9m47DiPrQYpnxtTrmmloIlWBvx6s8FWw+12dYQ6liXVbG
         UCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvzhsp+Vac0FB6rdWN4NAL1yHJzcPpxVK46WCj5TJbM=;
        b=1zK83RQWZMmFv/UGoUCeFul6qksily98F9i/cMj9OVyJcTGT3Iw26ZeR3TS+mrFRLn
         L9+pX6cPNs3uTIKKcHr6Df/5IPI7KEPNisOzPWdMlrQvZluTJL17wTvycPwJrMZ1Rn+k
         8X0TgAurPgKUxKIvcIHLLjLJQbsFz+Cq/mdy5bmSO7eRpHP0N4apUGLUayDu8PNwBzYN
         HVXMPAr3iAicxALn1ZJx2MFJnY9jHpc0CkGgzGE2fNo7aW9aqKnvmdSrh3cUtj2s4Az6
         wQzsKclInwr2X/WYZNk7fk7lGkkhBBBYcrwxurbC7QyJizzmgXFznXvuKt+2kXN+LLTE
         cnxg==
X-Gm-Message-State: AOAM531V/7nVi+e53nqsu/c/guPXoX6SLdSNSJFJT9Z/FNJcFCJe2gEu
        61YI7Fq7jNehxBAiMI4pTSgPALHdwhq5F+U0DgQ=
X-Google-Smtp-Source: ABdhPJyA6B8A4o1zhebAamwhYqwaE0AkYI8qT+lrH81FGdFW8eKHa66qLBRdDUpaCN5eznTvaFHDnau7lV0vb2iL6J8=
X-Received: by 2002:a17:90a:1f45:: with SMTP id y5mr1343509pjy.138.1637627568644;
 Mon, 22 Nov 2021 16:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com>
 <20211120033255.91214-14-alexei.starovoitov@gmail.com> <20211123002306.dng6mv2ryih4qq2j@apollo.localdomain>
In-Reply-To: <20211123002306.dng6mv2ryih4qq2j@apollo.localdomain>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 22 Nov 2021 16:32:37 -0800
Message-ID: <CAADnVQLVBDJjVwmzwOVXEO8XHTqEWimCb2tJ+HwwjBQkBHrSnQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/13] selftest/bpf: Revert CO-RE removal in test_ksyms_weak.
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 22, 2021 at 4:23 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, Nov 20, 2021 at 09:02:55AM IST, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The commit 087cba799ced ("selftests/bpf: Add weak/typeless ksym test for light skeleton")
> > added test_ksyms_weak to light skeleton testing, but remove CO-RE access.
> > Revert that part of commit, since light skeleton can use CO-RE in the kernel.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/ksyms_btf.c  | 4 ++--
> >  tools/testing/selftests/bpf/progs/test_ksyms_weak.c | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> > index 79f6bd1e50d6..988f5db3e342 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/ksyms_btf.c
> > @@ -101,7 +101,7 @@ static void test_weak_syms(void)
> >       usleep(1);
> >
> >       data = skel->data;
> > -     ASSERT_EQ(data->out__existing_typed, 0, "existing typed ksym");
> > +     ASSERT_GE(data->out__existing_typed, 0, "existing typed ksym");
>
> I think original test (2211c825e7b6b) was doing ASSERT_EQ, since per cpu ptr for
> runqueue is from CPU 0.

Thanks for the explanation.
I saw that the value is zero, but didn't dig that far to see that
it's fixed due to runqueue design.
