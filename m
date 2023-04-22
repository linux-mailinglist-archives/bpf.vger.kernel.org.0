Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6AD6EB6C1
	for <lists+bpf@lfdr.de>; Sat, 22 Apr 2023 04:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDVCSn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 22:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDVCSm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 22:18:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A26C1FFE
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 19:18:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-504e232fe47so4082970a12.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 19:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682129919; x=1684721919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B+E+Y5mC2APDDEsupDtjUYHKLjYATHY6xlhtay5QNQ=;
        b=lS5j+S66EZVfIJgIdtMMiIaCo7jWo9EhZqCCalUYK9lLiOS0jakGXijJ86JlV96KLA
         jT6RlPVtmkWt8GKvpHiiryvKrrI/bhOdaJbtdZpNEgUCQAMf28m4yYnoDbzlt3BqvK0A
         j2pMbDw31806m612VQT+Nh2fVcreGpSfHM07+lMgrbxiiWsnnR2NqIT0+4ahAmgqdYPP
         lxXNrjSJVe5DRPrLhPsBlf/X3apRnD8A0NvT4tDEZjC8tgiJeyW/J8Stcxpchfysz3o0
         Na+0Lrz43SjpvO2wSWo0jFo9NgaZNOZ6BjEyAj56sFV0LXZ7Lq6fkPHyJotEXorLpkya
         hHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682129919; x=1684721919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B+E+Y5mC2APDDEsupDtjUYHKLjYATHY6xlhtay5QNQ=;
        b=NKeOsN3IvvPuoBugB7hIshUTBYuYB4szgNgHYmRhUzR+Mt/ePX4M0Ihxr5/8gEY7wC
         +pKqi6DD258I2umgFIAalqtglfLXjy35Mdw0LGnjZluMVQfW4gsbktzFa3LcXAN8wQ31
         icSWT431aAkoto49tSXfz1bb/GrShcsDHYY2u+5jG+dV3dTl6GbVhmLL/apl/cCYaQwb
         dBhmhzbhwt9rRWBItOi6DXQQn1Tc5UpWQMry5ryNpHANf6qmbxSwdrjb618kRXcZxvAE
         Mf8wfagtPL/AqVc9VIbRLo1eXuvIwvqwpOLlSp20KzepMv/bl85OTvpYYQM+ujOat0I6
         hIug==
X-Gm-Message-State: AAQBX9cQG0+38ZDUb7ENLP5iCwx4aY5UweaQMQSb1A9CxsN4rT0yJegO
        SP29UIPCwYKO/zk1DcIhCUi/jFTGmOQ3uBd5I/M=
X-Google-Smtp-Source: AKy350a2CcI+24vFUyvXvlFrqRTHdcidEkJSF66bQKbA5TQG5QCWCBU3bSHyugIzKe3+QH8kjoZgu3mrR29H0itsPlU=
X-Received: by 2002:aa7:c55a:0:b0:506:77e5:fbb3 with SMTP id
 s26-20020aa7c55a000000b0050677e5fbb3mr6077384edr.35.1682129919164; Fri, 21
 Apr 2023 19:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230415201811.343116-1-davemarchevsky@fb.com>
 <20230415201811.343116-10-davemarchevsky@fb.com> <atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd7tnwft34e3@xktodqeqevir>
 <20230421234908.tixmdprfxz5ixh6m@dhcp-172-26-102-232.dhcp.thefacebook.com> <4irsjhtdw4pf76jvlls6poso4yiruzevs3awu5bahzzl5zp5un@iao4jc3ihj7o>
In-Reply-To: <4irsjhtdw4pf76jvlls6poso4yiruzevs3awu5bahzzl5zp5un@iao4jc3ihj7o>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 21 Apr 2023 19:18:27 -0700
Message-ID: <CAADnVQLLyZL=ngzx=R2WZbcG52yivjOPs2iUtM2Vr3H3BkHmCQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: Add refcounted_kptr tests
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 21, 2023 at 7:06=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, Apr 22, 2023 at 01:49:08AM CEST, Alexei Starovoitov wrote:
> > On Sat, Apr 22, 2023 at 12:17:47AM +0200, Kumar Kartikeya Dwivedi wrote=
:
> > > On Sat, Apr 15, 2023 at 10:18:11PM CEST, Dave Marchevsky wrote:
> > > > Test refcounted local kptr functionality added in previous patches =
in
> > > > the series.
> > > >
> > > > Usecases which pass verification:
> > > >
> > > > * Add refcounted local kptr to both tree and list. Then, read and -
> > > >   possibly, depending on test variant - delete from tree, then list=
.
> > > >   * Also test doing read-and-maybe-delete in opposite order
> > > > * Stash a refcounted local kptr in a map_value, then add it to a
> > > >   rbtree. Read from both, possibly deleting after tree read.
> > > > * Add refcounted local kptr to both tree and list. Then, try readin=
g and
> > > >   deleting twice from one of the collections.
> > > > * bpf_refcount_acquire of just-added non-owning ref should work, as
> > > >   should bpf_refcount_acquire of owning ref just out of bpf_obj_new
> > > >
> > > > Usecases which fail verification:
> > > >
> > > > * The simple successful bpf_refcount_acquire cases from above shoul=
d
> > > >   both fail to verify if the newly-acquired owning ref is not dropp=
ed
> > > >
> > > > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > > ---
> > > > [...]
> > > > +SEC("?tc")
> > > > +__failure __msg("Unreleased reference id=3D3 alloc_insn=3D21")
> > > > +long rbtree_refcounted_node_ref_escapes(void *ctx)
> > > > +{
> > > > + struct node_acquire *n, *m;
> > > > +
> > > > + n =3D bpf_obj_new(typeof(*n));
> > > > + if (!n)
> > > > +         return 1;
> > > > +
> > > > + bpf_spin_lock(&glock);
> > > > + bpf_rbtree_add(&groot, &n->node, less);
> > > > + /* m becomes an owning ref but is never drop'd or added to a tree=
 */
> > > > + m =3D bpf_refcount_acquire(n);
> > >
> > > I am analyzing the set (and I'll reply in detail to the cover letter)=
, but this
> > > stood out.
> > >
> > > Isn't this going to be problematic if n has refcount =3D=3D 1 and is =
dropped
> > > internally by bpf_rbtree_add? Are we sure this can never occur? It to=
ok me some
> > > time, but the following schedule seems problematic.
> > >
> > > CPU 0                                       CPU 1
> > > n =3D bpf_obj_new
> > > lock(lock1)
> > > bpf_rbtree_add(rbtree1, n)
> > > m =3D bpf_rbtree_acquire(n)
> > > unlock(lock1)
> > >
> > > kptr_xchg(map, m) // move to map
> > > // at this point, refcount =3D 2
> > >                                     m =3D kptr_xchg(map, NULL)
> > >                                     lock(lock2)
> > > lock(lock1)                         bpf_rbtree_add(rbtree2, m)
> > > p =3D bpf_rbtree_first(rbtree1)                       if (!RB_EMPTY_N=
ODE) bpf_obj_drop_impl(m) // A
> > > bpf_rbtree_remove(rbtree1, p)
> > > unlock(lock1)
> > > bpf_obj_drop(p) // B
> >
> > You probably meant:
> > p2 =3D bpf_rbtree_remove(rbtree1, p)
> > unlock(lock1)
> > if (p2)
> >   bpf_obj_drop(p2)
> >
> > >                                     bpf_refcount_acquire(m) // use-af=
ter-free
> > >                                     ...
> > >
> > > B will decrement refcount from 1 to 0, after which bpf_refcount_acqui=
re is
> > > basically performing a use-after-free (when fortunate, one will get a
> > > WARN_ON_ONCE splat for 0 to 1, otherwise, a silent refcount raise for=
 some
> > > different object).
> >
> > As discussed earlier we'll be switching all bpf_obj_new to use BPF_MA_R=
EUSE_AFTER_RCU_GP
>
> I probably missed that thread. In that case, is use of this stuff going t=
o
> require bpf_rcu_read_lock in sleepable programs?

Correct.
We've refactored rcu enforcement.
We also decided to stop waiting for gcc btf_tag support to land and
went with allowlisting BTF_TYPE_SAFE_RCU[_OR_NULL] for fields that
we need to use now.
Overall it allowed us to get rid of kptr_get.
