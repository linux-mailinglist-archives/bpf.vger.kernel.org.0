Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C2555374A
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353475AbiFUQHB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 12:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353549AbiFUQHA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 12:07:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A414F1E
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1756461388
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 16:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A180C36AE3
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 16:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655827619;
        bh=WKXmvpKHiXF8HIz4rkJYUYibRv7Uv4uklkh4UR/cIbo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bSr7jJh8fhPN8M9KYv0VSDsMGSp579PIxQijlxfDGf0MbiUcagVP7eVDcGWIlEhK/
         tO+Nl4dz/aFdyCAuFBlaVFWbt7RUoi8G2UG8nztYg1jf1o7q1j64xmfSCeKuEUCBDT
         Q32QEFuzY46axmZGNyohlyUYhklDNWvp3cSGLby1WDdDGaizXRPllhgUPT282papHw
         0036tLntbpca+Zqjn6/SlvDuliHCbZKEWYksYKqkfYTVqLvtyOEOVs7Ntu8RRSBKRw
         2tlZ9FahyjI8fXRbQDOkNUc0tk65Q8Ajjwst7lypv9z9E2E0SXi0HjKxaKNd1vtnME
         M8ntbG8nW4B8g==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-317a66d62dfso75145957b3.7
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:06:59 -0700 (PDT)
X-Gm-Message-State: AJIora99CjNfF+Qqj4Sy65XtnTM/Qy7RoKUp0n2CEFEMn1bxQ3HPmBT0
        Us1OIgSPqhJJtmTSLWi6PdZqNR6dP9ZKC5jvy1zhoQ==
X-Google-Smtp-Source: AGRyM1uOvf2G/HTOk28asJ3XCqY4R29PVP4aYQLAsbfLR43nAQyBCYRC5QUKOEnwEXcrpbTPABYxw24lN9Krc5Q+2tA=
X-Received: by 2002:a0d:f741:0:b0:314:547b:968c with SMTP id
 h62-20020a0df741000000b00314547b968cmr33773024ywf.171.1655827618483; Tue, 21
 Jun 2022 09:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220621012811.2683313-5-kpsingh@kernel.org> <202206211035.p3LxbVfK-lkp@intel.com>
 <CACYkzJ775f+EGSpFiKUXkYdtx5x1mygbGC9P+knqvapio9XUyg@mail.gmail.com> <20220621124115.7daxj2csuyfxfvq5@apollo.legion>
In-Reply-To: <20220621124115.7daxj2csuyfxfvq5@apollo.legion>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 21 Jun 2022 18:06:46 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5CjOr+i2riupYsxcJToo4k+CpWxUP2W1ACrM06u3Wq=Q@mail.gmail.com>
Message-ID: <CACYkzJ5CjOr+i2riupYsxcJToo4k+CpWxUP2W1ACrM06u3Wq=Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/5] bpf: Add a bpf_getxattr kfunc
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, bpf@vger.kernel.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 2:41 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 12:48:08PM IST, KP Singh wrote:
> > On Tue, Jun 21, 2022 at 5:20 AM kernel test robot <lkp@intel.com> wrote:
> > >
> > > Hi KP,
> > >
> > > I love your patch! Perhaps something to improve:
> > >
> > > [auto build test WARNING on bpf-next/master]
[...]

> >
>
> You can silence this warning using __diag_push, e.g. see kfunc definitions in
> net/netfilter/nf_conntrack_bpf.c.

Thanks, done.

>
> > - KP
> >
> > >
> > > vim +/bpf_getxattr +1185 kernel/trace/bpf_trace.c
> > >
> > >   1184
> > > > 1185  noinline __weak ssize_t bpf_getxattr(struct dentry *dentry, struct inode *inode,
> > >   1186                                       const char *name, void *value, int size)
> > >   1187  {
> > >   1188          return __vfs_getxattr(dentry, inode, name, value, size);
> > >   1189  }
> > >   1190
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://01.org/lkp
>
> --
> Kartikeya
