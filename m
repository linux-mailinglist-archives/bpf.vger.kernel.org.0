Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA85510CC1
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 01:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbiDZXja (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Apr 2022 19:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiDZXj3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 19:39:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379D36D397;
        Tue, 26 Apr 2022 16:36:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so3573773pjq.0;
        Tue, 26 Apr 2022 16:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FZfmA4O6jijtnWqTux7/X5JTseVL5txVGPDrlm3yH7Y=;
        b=eBR5n9Gvr7OIWFXAQJeOdFyFNvJA4aIFTgLbBl6gA860hc1dINuYdgarlKwDjdJGbL
         /OHJOE1JndONHQssFQVIxtDdIgOMoPS+vliYulPR9f0iwwSyGTjFLXvJoq699Ai8aJ+q
         lUgDBEzn3rM1qDbnvUFUYiFqOteT2RhJfr+URv3+SU+LNRjmPJKAgxsvynGSubye09Xl
         aFKwWOwDhVpIjLnruIdChN7j8Jn3vOwX8K9Gmlfk/qWw1klbwDCp8t/pWH4x22rkAvR7
         XVS96v8JHfqLe4ov17r1dWs9HJjrSR7l0bghrbbw2gUE1SQxnIJGloBKcEIEXMYFlR2l
         aWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FZfmA4O6jijtnWqTux7/X5JTseVL5txVGPDrlm3yH7Y=;
        b=uvnb201jh0MNfMyuliFDkpqpv9WvbxaxKVGgpztSMDcku/yf6Prv0WAhHvqgQZmgwj
         QIHyzxegj3jNrSxgI8702zs6bfMzQvUGYpxVCmQc/1/w2o47gsV3vnaMU+vblX/lllNL
         5BAiw4rtmoNIfwrQk+UidK49ONfqNzF48hdGvhXkPffk6SPdBch9ZI8PRJbBPyMcUwh2
         h4+0pIjW2wCPPGLIt3abyznAAt/juglp6E4DoiLBZGheCM2MeHQZ9tvKvn4Th+XBZnqf
         IWdQ8McWCycUgWTIuCbKMAMWQNX2SeO8kosMPWpB+jGvUEFDAPfH2cCsiCxEZ0kkA/UN
         r6zw==
X-Gm-Message-State: AOAM5336Ds5Sj3ohJ/4M8iyK3O48kx+f6g3my2PTXWPm/2MsGlistCXr
        ZcTjAwc9N5Z3OE5Lzk964RXSKWOMIydZDLlE7uU=
X-Google-Smtp-Source: ABdhPJxAT3/2mWkmwa0HoN/+xiyeBVybzSFCzBcAbwwaanzZUVVCIPcJpfM3UN6mqt5OAdQHpmn/dpbrksEEVaXmQJ4=
X-Received: by 2002:a17:90b:33c8:b0:1d9:9023:1103 with SMTP id
 lk8-20020a17090b33c800b001d990231103mr10780153pjb.26.1651016179724; Tue, 26
 Apr 2022 16:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <5689d065f739602ececaee1e05e68b8644009608.1650930000.git.jpoimboe@redhat.com>
 <YmexSIL5pqNK63iH@zn.tnic>
In-Reply-To: <YmexSIL5pqNK63iH@zn.tnic>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 26 Apr 2022 16:36:08 -0700
Message-ID: <CAADnVQKjfQMG_zFf9F9P7m0UzqESs7XoRy=udqrDSodxa8yBpg@mail.gmail.com>
Subject: Re: [PATCH] x86/speculation: Add missing prototype for unpriv_ebpf_notify()
To:     Borislav Petkov <bp@alien8.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, bpf <bpf@vger.kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 26, 2022 at 6:36 AM Borislav Petkov <bp@alien8.de> wrote:
>
> + bpf@vger.kernel.org
>
> Let's sync with bpf folks on who takes this. I could route it through tip=
 ...

I don't remember seeing the original patch on the bpf list.
I'm guessing it was done in private as part of bhb series?
Feel free to land it via tip.
Hopefully there will be no conflicts.

> On Mon, Apr 25, 2022 at 04:40:02PM -0700, Josh Poimboeuf wrote:
> > Fix the following warnings seen with "make W=3D1":
> >
> >   kernel/sysctl.c:183:13: warning: no previous prototype for =E2=80=98u=
npriv_ebpf_notify=E2=80=99 [-Wmissing-prototypes]
> >     183 | void __weak unpriv_ebpf_notify(int new_state)
> >         |             ^~~~~~~~~~~~~~~~~~
> >
> >   arch/x86/kernel/cpu/bugs.c:659:6: warning: no previous prototype for =
=E2=80=98unpriv_ebpf_notify=E2=80=99 [-Wmissing-prototypes]
> >     659 | void unpriv_ebpf_notify(int new_state)
> >         |      ^~~~~~~~~~~~~~~~~~
> >
> > Fixes: 44a3918c8245 ("x86/speculation: Include unprivileged eBPF status=
 in Spectre v2 mitigation reporting")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  include/linux/bpf.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index bdb5298735ce..ecc3d3ec41cf 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2085,6 +2085,8 @@ void bpf_offload_dev_netdev_unregister(struct bpf=
_offload_dev *offdev,
> >                                      struct net_device *netdev);
> >  bool bpf_offload_dev_match(struct bpf_prog *prog, struct net_device *n=
etdev);
> >
> > +void unpriv_ebpf_notify(int new_state);
> > +
> >  #if defined(CONFIG_NET) && defined(CONFIG_BPF_SYSCALL)
> >  int bpf_prog_offload_init(struct bpf_prog *prog, union bpf_attr *attr)=
;
> >
> > --
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
