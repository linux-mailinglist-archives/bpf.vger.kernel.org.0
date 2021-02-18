Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03A231E3DB
	for <lists+bpf@lfdr.de>; Thu, 18 Feb 2021 02:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhBRB1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 20:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBRB1j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 20:27:39 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443F9C0613D6
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 17:26:57 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id s24so390968iob.6
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 17:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fRYLy3H4F9oCMNJyt44WfxY2hQG5AXt3RTaWffSy2XU=;
        b=RSpao/8QwbLrP51weIC44yvipXuU4xaadCf4sbfh9e/IHbEJOHucUZvxnsD5eZrKtt
         Xp1TfkfhtGvqfTr7lF4LcmqtZXUbtAZpug01KG6mD8ExiavhNkaWMqifZT4ESh4Tib0h
         LDJjtw+g+ef0hSK06rMJEDliiPRgmlNl1obPWY7LYfxHJxobh4FBDx+urp4Omo/vNAnZ
         z9zQuLppY3eTQibts01sdWEuFFZZcfiFmn+PsrixscArNwYNuhlMefYrn4D0Q3Zx2wag
         shiEKA2r5Bblp/G9ec4EKWVvgCNTk2TqF5vYuUr07ZfpGHcb411rNrdWP00CjU4/HGIn
         jjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fRYLy3H4F9oCMNJyt44WfxY2hQG5AXt3RTaWffSy2XU=;
        b=CCw3mU1DZDqFnlOfvfTfdYseFsXDIRdDjWHw83ZJfyCx7ZOkHY1CEzk45tkS976ZDH
         CAFE1/x4bqXch1qtzbHUqwA1GRG+Ve5dH9rkWrlJVN23xvaAo9kDRH/Ha56+sCmqRz6C
         JlDOzJ9VhMwX+VIR94QFF+7EZZKY5LxGwndqck1EYZYaLkamVKTbd6McyNqXCwn4q2dv
         27q4z9CXLhNQq/2GBhmGRx031svdjgfaUSAmwWInlmiLk2kU24eu0Fl4cfyx+LiAjNMY
         t2QSgFdtloZEtInZv9/aK4npp4WuN1ezZ3KlcaFP8P2S1ehwHk8c0Wwgno01BSO8v67T
         UC3w==
X-Gm-Message-State: AOAM531CrADrZNSG+rC0JgKHU6ZpJfcqN+IBbqBUAdh/FpT8+ROIP4Kl
        qx/borX1j0s73j2wAPPdHuo=
X-Google-Smtp-Source: ABdhPJybHPIApDY+ktQczM8NTYClp4uQ+rLEGFSPs3RvPkX1rzqccDDaY22U2j4EDhQPXPBQkGLsrg==
X-Received: by 2002:a6b:f317:: with SMTP id m23mr1627585ioh.67.1613611616771;
        Wed, 17 Feb 2021 17:26:56 -0800 (PST)
Received: from localhost ([172.243.146.206])
        by smtp.gmail.com with ESMTPSA id w9sm3044830ioj.0.2021.02.17.17.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 17:26:56 -0800 (PST)
Date:   Wed, 17 Feb 2021 17:26:47 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>
Message-ID: <602dc2574df18_182c3208c0@john-XPS-13-9370.notmuch>
In-Reply-To: <fe6133e6e997b9eca7d9b3e0802642498812b3b5.camel@linux.ibm.com>
References: <20210216011216.3168-1-iii@linux.ibm.com>
 <20210216011216.3168-3-iii@linux.ibm.com>
 <602d83616c9f1_ddd2208dd@john-XPS-13-9370.notmuch>
 <602d86a63e754_fc54208eb@john-XPS-13-9370.notmuch>
 <fe6133e6e997b9eca7d9b3e0802642498812b3b5.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: Add BTF_KIND_FLOAT support
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ilya Leoshkevich wrote:
> On Wed, 2021-02-17 at 13:12 -0800, John Fastabend wrote:
> > John Fastabend wrote:
> > > Ilya Leoshkevich wrote:
> > > > The logic follows that of BTF_KIND_INT most of the time.
> > > > Sanitization
> > > > replaces BTF_KIND_FLOATs with equally-sized BTF_KIND_INTs on
> > > > older
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > Does this match the code though?
> > > =

> > > > kernels.
> > > > =

> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > =

> > > [...]
> > > =

> > > =

> > > > @@ -2445,6 +2450,9 @@ static void bpf_object__sanitize_btf(struct=

> > > > bpf_object *obj, struct btf *btf)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (!has_func_global && btf_is_func(=
t)) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0/* replace BTF_FUNC_GLOBAL with
> > > > BTF_FUNC_STATIC */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0t->info =3D BTF_INFO_ENC(BTF_KIND_FUNC, 0,
> > > > 0);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0} else if (!has_float && btf_is_float(t)) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/=
* replace FLOAT with INT */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0t=
->info =3D BTF_INFO_ENC(BTF_KIND_FLOAT, 0,
> > > > 0);
> > > =

> > > Do we also need to encode the vlen here?
> > =

> > Sorry typo on my side, 't->size =3D ?' is what I was trying to point
> > out.
> > Looks like its set in the other case where we replace VAR with INT.
> =

> The idea is to have the size of the INT equal to the size of the FLOAT
> that it replaces. I guess we can't do the same for VARs, because they
> don't have the size field, and if we don't have DATASECs, then we can't=

> find the size of a VAR at all.
> =


Right, but KINT_INT has some extra constraints that don't appear to be in=

place for KIND_FLOAT. For example meta_check includes max size check. We
should check these when libbpf does conversion as well? Otherwise kernel
is going to give us an error that will be a bit hard to understand.

Also what I am I missing here. I use the writers to build a float,

 btf__add_float(btf, "new_float", 8);

This will create the btf_type struct approximately like this,

 btf_type t {
   .name =3D name_off; // points at my name
   .info =3D btf_type_info(BTF_KIND_FLOAT, 0, 0);
   .size =3D 8
 };

But if I create an int_type with btf__add_int(btf, "net_int", 8); I will
get a btf_type + __u32. When we do the conversion how do we skip the =

extra u32 setup?

 *(__u32 *)(t + 1) =3D (encoding << 24) | (byte_sz * 8);

Should we set this up on the conversion as well? Otherwise later steps
might try to read the __u32 piece to find some arbitrary memory?

.John=
