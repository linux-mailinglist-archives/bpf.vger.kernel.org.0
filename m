Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F936953ED
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 23:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBMWeL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 17:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBMWeK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 17:34:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780B11E9DF
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 14:34:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d40so13723028eda.8
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfWVb6Dil2pQ+9lUGs2qSI8E23Clx1JFl1TyJZ7PbB4=;
        b=iNVVdZK217J2BmoY+73CscywKjWHeSC5c6xMm+9w45kmYJP2igMaYoEQq12fH2UG+Z
         KbOfKXO2JHS6iMt6qhFeSNNoO6a7SA+lr77qeUZkN28K/6IYnu0+CbLVL3aQWwKfheVr
         pDdwYZEBLW5ABd7iKDoo37vCVNZhPpgQTD/6CuIKnWZ0Ep4xm1ULidC+ln6b/eH8t9lq
         F8IIIpUZsOzpaE97PJHxtQWZYmagQ8clxYiuDg1Y7r6DaF2b4BbgJwCnGQLi9Gctx7bJ
         abe26gQOWwc10gYwgUfv8dtrY04Fl8PI0lyQP1YEHZPvDXuaaNgS1RDpA3Jdaa5jLWTf
         W/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfWVb6Dil2pQ+9lUGs2qSI8E23Clx1JFl1TyJZ7PbB4=;
        b=BtRTP2jpGVcUON/7n7bmpt7QtMjO38sVJhUouuPJ2c5OG0qo4CV9RrGdlR7akmVt1U
         3cv9c4duvozZbMaoji7khkUNu1R4VOEIHlCEduy/p6Ci5ZshP0kgVdPt3fzUPa8S868s
         IQgDRiMZBLt3B/ecAUWGvGfsGBrSItkDMXn6HadPD51DOn7aYcAOHD9d7ywr/L5zFzf3
         sKWa6DGHno8iMevtGLATtGCCXIPBe3reyN1zRSE2TddRNEbFXnIp9IanzOwEQrNoh2kl
         QNoIJ+mjPtpNIAReWjOAKGmv6LYbF9BCh1f06Nl53v5v8jV1hWkb3BoRNsme21nJ21CU
         9sTg==
X-Gm-Message-State: AO0yUKXVw3o45AKmB0DZSLqBwc4DSvfZoImktZA+4pVFv1UAuDMkY5Fa
        MT44umydbrK1OPqyP2xv9fxNL5VjXYEzTlQpB9w=
X-Google-Smtp-Source: AK7set8V/tscO1XNrqgeBbBVtbGQ2npDraDH/dwvCDFauj0DDWqQXYEiYLX9n0DCPRF6UviGKgghnys/lERIoQ3ZUVc=
X-Received: by 2002:a05:6402:f11:b0:4ab:4cf5:591 with SMTP id
 i17-20020a0564020f1100b004ab4cf50591mr6077197eda.3.1676327646827; Mon, 13 Feb
 2023 14:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20230212092715.1422619-4-davemarchevsky@fb.com>
 <202302121936.t36vlAFG-lkp@intel.com> <d04d33ff-0f8f-2bbd-3a67-9b8b813a799b@meta.com>
 <CAKwvOdketskm5z25aPRY7OsBOZe2kzvXV-i9RDTbwcLpZSAT0A@mail.gmail.com> <CAADnVQ+qJMAugDDQXaerRbh0g4QdRygMZ_0UVmXViR2aJ4OLDQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+qJMAugDDQXaerRbh0g4QdRygMZ_0UVmXViR2aJ4OLDQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Feb 2023 14:33:55 -0800
Message-ID: <CAADnVQKSyUOoV6cedF3tX33UTHVkC-gBiHCr-4uV+_cn_Z2n9g@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/9] bpf: Add bpf_rbtree_{add,remove,first} kfuncs
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dave Marchevsky <davemarchevsky@meta.com>,
        kernel test robot <lkp@intel.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        bpf <bpf@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        oe-kbuild-all@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
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

On Mon, Feb 13, 2023 at 2:17 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 13, 2023 at 12:49 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Feb 13, 2023 at 12:45 PM Dave Marchevsky
> > <davemarchevsky@meta.com> wrote:
> > >
> > > On 2/12/23 6:21 AM, kernel test robot wrote:
> > > > Hi Dave,
> > > >
> > > >>> kernel/bpf/helpers.c:1901:9: warning: cast from 'bool (*)(struct =
bpf_rb_node *, const struct bpf_rb_node *)' (aka '_Bool (*)(struct bpf_rb_n=
ode *, const struct bpf_rb_node *)') to 'bool (*)(struct rb_node *, const s=
truct rb_node *)' (aka '_Bool (*)(struct rb_node *, const struct rb_node *)=
') converts to incompatible function type [-Wcast-function-type-strict]
> > > >                          (bool (*)(struct rb_node *, const struct r=
b_node *))less);
> > > >                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
> > >
> > > This is the only new warning introduced by this series. A previous ve=
rsion had
> > > the same complaint by kernel test robot.
> > >
> > > struct bpf_rb_node is an opaque struct with the same size as struct r=
b_node.
> > > It's not intended to be manipulated directly by any BPF program or bp=
f-rbtree
> > > kernel code, but rather to be used as a struct rb_node by rbtree libr=
ary
> > > helpers.
> > >
> > > Here, the compiler complains that the less() callback taken by bpf_rb=
tree_add
> > > is typed
> > >
> > > bool (*)(struct bpf_rb_node *, const struct bpf_rb_node *)
> > >
> > > while the actual rbtree lib helper rb_add's less() is typed
> > >
> > > bool (*)(struct rb_node *, const struct rb_node *)
> > >
> > > I'm not a C standard expert, but based on my googling, for C99 it's n=
ot valid
> > > to cast a function pointer to anything aside from void* and its origi=
nal type.
> > > Furthermore, since struct bpf_rb_node an opaque bitfield and struct r=
b_node
> > > has actual members, C99 standard 6.2.7 paragraph 1 states that they'r=
e not
> > > compatible:
> > >
> > >   Moreover, two structure,
> > >   union, or enumerated types declared in separate translation units a=
re compatible if their
> > >   tags and members satisfy the following requirements: If one is decl=
ared with a tag, the
> > >   other shall be declared with the same tag. If both are complete typ=
es, then the following
> > >   additional requirements apply: there shall be a one-to-one correspo=
ndence between their
> > >   members such that each pair of corresponding members are declared w=
ith compatible
> > >   types, and such that if one member of a corresponding pair is decla=
red with a name, the
> > >   other member is declared with the same name. For two structures, co=
rresponding
> > >   members shall be declared in the same order
> > >
> > > I'm not sure how to proceed here. We could change bpf_rbtree_add's le=
ss() cb to
> >
> > I haven't looked at the series in question, but note that this compile
> > time warning is meant to help us catch Control Flow Integrity runtime
> > violations, which may result in a panic.
>
> It's a transition from kernel to bpf prog.
> If CFI trips on it it will trip on all transitions.
> All calls from kernel into bpf are more or less the same.
> Not sure what it means for other archs, but on x86 JIT emits 'endbr'
> insn to make IBT/CFI happy.

Having said the above it's good that the warning was there.
Just type casting the func is not correct.
We should call bpf progs like this:

-void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
-                   bool (less)(struct bpf_rb_node *a, const struct
bpf_rb_node *b))
-{
-       rb_add_cached((struct rb_node *)node, (struct rb_root_cached *)root=
,
-                     (bool (*)(struct rb_node *, const struct rb_node *))l=
ess);
+void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node
*node, bpf_callback_t less)
+{
+        struct rb_node **link =3D &((struct rb_root_cached
*)root)->rb_root.rb_node;
+        struct rb_node *parent =3D NULL;
+        bool leftmost =3D true;
+
+        while (*link) {
+                parent =3D *link;
+                if (less((uintptr_t)node, (uintptr_t)parent, 0, 0, 0)) {
+                        link =3D &parent->rb_left;
+                } else {
+                        link =3D &parent->rb_right;
+                        leftmost =3D false;
+                }
+        }
+
+        rb_link_node((struct rb_node *)node, parent, link);
+        rb_insert_color_cached((struct rb_node *)node, (struct
rb_root_cached *)root, leftmost);

Dave, please incorporate in the next respin.
I only compile tested the above.
