Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F09D4AF6D3
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 17:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiBIQe3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 11:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiBIQe2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 11:34:28 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE071C0613C9
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 08:34:30 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 9so2316634pfx.12
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 08:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGI0DfFKB00AVZo8AWDexsF0EVSUK9TnVPzvu5q1qD0=;
        b=Bpdf6VDpa0pssJIky3kYuY94gTZmIsiTGUCSan8KBYrv2IrkOHEUSa0ocXBJZyCORV
         4Vuo6wBb/X0lxQUB9M++EJmmAfz6Naw4cdSLWp4ih/v46N3bGDTGFrVbCcb9SwkQBMQO
         3XlliYVc5d7C1OaoYcz8Q8ivh84WtKoJ9Mt6ouyxaGK48JTKabFgIrInEI+Sj4POBBmP
         pW/FA4uER/yiJBlpd1h8xIJ1A/0X6tRflkNe5+XQAALwuZOVjuhnNXfUzjDUihO13M9n
         2XLTFyvhAFfmqvbd2HbKlSWDo6dz+q352X1FXvNyGdTfMTC5Oijm4w8WtofzxcbDgbqB
         xUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGI0DfFKB00AVZo8AWDexsF0EVSUK9TnVPzvu5q1qD0=;
        b=t6Mb+KcKCHfXSNMrvG4B2Ra39xcMfaqzUUU7MxXVU8GiagJeOF4+szq6Hkwfwyu5GK
         AT3LHkPZZouxUQekj73nl4HbOox0dpZ5SMQE2sN4KHyAhhognKehdjg2X2kkqtpyb4uT
         96vsYmyjJG71Dmpd4yPsqX+I0AljTjwqfADsj4LI4cWAoFlWHqwk9d+juNVgeJ6IcwU3
         dT93O9fnqTBn8zkxp3HpOScIvph0pdBllNXbpEVoYsZ4tJEW+HkmdAJ027iCZ/qxTqfj
         5aBVS3rdE6DavSzx2LE8rKJerhoqF6qKzANMVbWWiY9BBezZsaMSuf9X6KREn08qldRn
         fHpw==
X-Gm-Message-State: AOAM5315G7BOSiroszls0xn55B3wn88n2Xc1RgAMXIoJt9bzvN0b/CHa
        jGTUUwaETZ4I0OaQo25tOQosvgxaQTmt7C0rRag=
X-Google-Smtp-Source: ABdhPJzwZzINNQUt+/aPgAlLWu6PxPzzuyZ4eOgLPCJxgfPjnpL5eDc++/N/G2YJmcI+lG1BiTqBLnT9SERW14NlggU=
X-Received: by 2002:a65:6182:: with SMTP id c2mr2541171pgv.95.1644424470271;
 Wed, 09 Feb 2022 08:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
 <20220209054315.73833-6-alexei.starovoitov@gmail.com> <20220209062235.ddrxjpua2xshoryq@thp>
In-Reply-To: <20220209062235.ddrxjpua2xshoryq@thp>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 9 Feb 2022 08:34:18 -0800
Message-ID: <CAADnVQK_YDBtDtgTchDFYJmZVPjH6u_+=Cw__5tFtZxfKEOkEw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/5] bpf: Convert bpf_preload.ko to use light skeleton.
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 8, 2022 at 10:22 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, Feb 09, 2022 at 11:13:15AM IST, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The main change is a move of the single line
> >   #include "iterators.lskel.h"
> > from iterators/iterators.c to bpf_preload_kern.c.
> > Which means that generated light skeleton can be used from user space or
> > user mode driver like iterators.c or from the kernel module or the kernel itself.
> > The direct use of light skeleton from the kernel module simplifies the code,
> > since UMD is no longer necessary. The libbpf.a required user space and UMD. The
> > CO-RE in the kernel and generated "loader bpf program" used by the light
> > skeleton are capable to perform complex loading operations traditionally
> > provided by libbpf. In addition UMD approach was launching UMD process
> > every time bpffs has to be mounted. With light skeleton in the kernel
> > the bpf_preload kernel module loads bpf iterators once and pins them
> > multiple times into different bpffs mounts.
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/inode.c                            |  39 ++----
> >  kernel/bpf/preload/Kconfig                    |   7 +-
> >  kernel/bpf/preload/Makefile                   |  14 +--
> >  kernel/bpf/preload/bpf_preload.h              |   8 +-
> >  kernel/bpf/preload/bpf_preload_kern.c         | 119 ++++++++----------
> >  kernel/bpf/preload/bpf_preload_umd_blob.S     |   7 --
> >  .../preload/iterators/bpf_preload_common.h    |  13 --
> >  kernel/bpf/preload/iterators/iterators.c      | 108 ----------------
> >  kernel/bpf/syscall.c                          |   2 +
> >  9 files changed, 70 insertions(+), 247 deletions(-)
> >  delete mode 100644 kernel/bpf/preload/bpf_preload_umd_blob.S
> >  delete mode 100644 kernel/bpf/preload/iterators/bpf_preload_common.h
> >  delete mode 100644 kernel/bpf/preload/iterators/iterators.c
> >
> > [...]
> >
> > -static int __init load_umd(void)
> > +static int __init load(void)
> >  {
> >       int err;
> >
> > -     err = umd_load_blob(&umd_ops.info, &bpf_preload_umd_start,
> > -                         &bpf_preload_umd_end - &bpf_preload_umd_start);
> > +     err = load_skel();
> >       if (err)
> >               return err;
> > -     bpf_preload_ops = &umd_ops;
> > +     bpf_preload_ops = &ops;
> >       return err;
> >  }
> >
> > -static void __exit fini_umd(void)
> > +static void __exit fini(void)
> >  {
> > -     struct pid *tgid;
> > -
> >       bpf_preload_ops = NULL;
> > -
> > -     /* kill UMD in case it's still there due to earlier error */
> > -     tgid = umd_ops.info.tgid;
> > -     if (tgid) {
> > -             kill_pid(tgid, SIGKILL, 1);
> > -
> > -             wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
> > -             umd_cleanup_helper(&umd_ops.info);
> > -     }
> > -     umd_unload_blob(&umd_ops.info);
> > +     free_links_and_skel();
> >  }
> > -late_initcall(load_umd);
> > -module_exit(fini_umd);
> > +late_initcall(load);
>
> Since load_skel invokes the loader which resolve kfuncs, and if the module is
> builtin, btf_vmlinux's kfunc_set_tab is not fully populated yet (other
> register_btf_id_kfunc_set calls may also happen in late_initcall), so I think it
> may be a problem.
>
> When I worked on it we didn't have this case where BPF syscall can be invoked at
> this point, but obviously that is true now. So I think ordering it later than
> late_initcall (or moving register_btf_id_kfunc_set invoking initcalls before) is
> required. WDYT?

Good point. Probably best to convert register_btf_kfunc_id_set invocations
to core_initcall.
I can follow up with a trivial patch later or you can beat me to it.
