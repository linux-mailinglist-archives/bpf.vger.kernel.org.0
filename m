Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFFE210F6E
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 17:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbgGAPgW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 11:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbgGAPgW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 11:36:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EF8C08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 08:36:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so12906514ljl.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYkOGZbPVrtxwcPLmw+hIFJbZatJVhLO7kRn53KUkto=;
        b=NnSS3Wu4b4i/MuNJHh9zUiI6jR+on2VYk5kE6sgMARE8JfnO3diMHh9nP3tfAoliJ+
         x/4U1s+94F1FVLyU0DwJQoakVuD/ZR5lrKWfA1uGZwR5S1j5OaRkFYFrzzu1R5Bzb2jW
         z/bsbegTTsjkVNlH3AZymOD/UkA+iJ6e1PH2+xDeTQGLMGRYZhwpkPrjYAjlC/qCwLuF
         SNo/BmBkbQqih6B32hIaCcxUqyQax+kzcGvNGdufFy6PbSdnKIW65d5mQ5x89s/KmbAI
         2YAPrc5SyWMN7ljrHRBh8SkubeBKpxIteEhany178sMwAG5z+E0e8a1ZQSX7fQktIVHY
         XiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYkOGZbPVrtxwcPLmw+hIFJbZatJVhLO7kRn53KUkto=;
        b=BP7Hutlpp1UM+nrhb0vAC5jUOPgUr2HmitJ5IVaxpO0TXzSTUiyMO+vg6W0eKxIsSp
         AqyriGBZUxb46errazFPpsjTXuUx7aD17s4cQFnMp1fZEwHsm6hgHTK2TVOgoTNM+Q5z
         gkwrIO6qUc8++t9uJMrVRWBarcfN4yp/d4EgKk55hZmQevnyql3gGzpX1Q7u1GSjUe40
         ZscL/Cqk9f/HpVVGFnrCaHZm37lJaIlhs886QKphZMOHYvNKNKOshJ9uoWTMqkL3mDbi
         kIm7/EW+/QfWOuKxtPfZfgv4yV9rZSWcf2KF0M2Sl2xeVwxIhpvVO3/i1SlIrd2NHtkw
         4WXw==
X-Gm-Message-State: AOAM5313P3e1WROsZem/xCwGpigvMTJSUhZcZLTC2BJHfXvECNAq7BoF
        d9nHAxSVmstK090+ZA/Rdg7a9n3AyySrnvA6j00=
X-Google-Smtp-Source: ABdhPJz2b7MIanaRgALuxI1ey96L0Zsji87a793wXOvXnq6ePNgd+TTTJuwrLBEoMfE2X+IsVCee6mifZAgbFBTSfvI=
X-Received: by 2002:a2e:9193:: with SMTP id f19mr2077637ljg.91.1593617780242;
 Wed, 01 Jul 2020 08:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <159353162763.912056.3435319848074491018.stgit@firesoul>
 <CAEf4BzZ-Ryq+i1ez3Q8G1js6tuD8niAejJzA5Gf7N-vS=6AE_g@mail.gmail.com>
 <20200630223224.16fb2377@carbon> <CAEf4BzYqojkRHQGszn0jcQEx6jYMvx3fZV4BERn5zeO-AxBjSQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYqojkRHQGszn0jcQEx6jYMvx3fZV4BERn5zeO-AxBjSQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Jul 2020 08:36:08 -0700
Message-ID: <CAADnVQJmz461mcv4MBq40jtHBzeX0FgpFaQW3XLB0=U6Y3WgGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: test_progs option for listing
 test names
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        bpf <bpf@vger.kernel.org>, Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 2:19 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Jun 30, 2020 at 1:32 PM Jesper Dangaard Brouer
> <brouer@redhat.com> wrote:
> >
> > On Tue, 30 Jun 2020 08:46:01 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > > @@ -688,9 +700,17 @@ int main(int argc, char **argv)
> > > >                         cleanup_cgroup_environment();
> > > >         }
> > > >         stdio_restore();
> > > > +
> > > > +       if (env.list_test_names) {
> > > > +               if (env.succ_cnt == 0)
> > > > +                       env.fail_cnt = 1;
> > > > +               goto out;
> > > > +       }
> > > > +
> > >
> > > Why failure if no test matched? Is that to catch bugs in whitelisting?
> >
> > I would not call it catch bugs, but sort of.  The purpose is to know if
> > requested test is valid.  This can be used to e.g. run through all the
> > tests numbers, and stopping when a test number (-n) is no-longer valid,
> > by using this shell exit value as a test, like:
> >
> >  n=1;
> >  while [ $(./test_progs --list -n $n) ] ; do \
> >    echo "./test_progs -n $n" ; n=$(( n+1 )); \
> >  done
> >
> > Notice that this features that be used for looking up a test number,
> > and returning a testname, which was the original request from CI.  I
> > choose this implementation as it more generic and generally useful.
> >
> >  $ ./test_progs --list -n 89
> >  xdp_adjust_tail
> >
>
> Yeah, it has a nice querying effect. Makes sense.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

hmm. it doesn't apply.
Applying: selftests/bpf: Test_progs option for listing test names
error: sha1 information is lacking or useless
(tools/testing/selftests/bpf/test_progs.c).
error: could not build fake ancestor
Patch failed at 0001 selftests/bpf: Test_progs option for listing test names

Could you please respin.
Thanks
