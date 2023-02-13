Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5526953A4
	for <lists+bpf@lfdr.de>; Mon, 13 Feb 2023 23:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBMWRR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 17:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjBMWRP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 17:17:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9605D1A65F
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 14:17:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id fj20so14955093edb.1
        for <bpf@vger.kernel.org>; Mon, 13 Feb 2023 14:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQmeB4kZpNulzj3YC16Y/CF0abLsGxtOjZ7MLt0xH/w=;
        b=eFoJqEoV3VCvNKpNthp82Sy73wkoN1jZZWbCYrDbj3xF/uyNj+eM7hIymnm91wIvDA
         PkijAYnlZC1+uvJpx1+yY13Dud5RiQniJhQuPtuso7YYniD9H2RtE9n7NLO05sZGYhhA
         gUwqByE/86eZ2mQfQpSpvq+RZD/LeKtrgReqeKFk5XT4ZiWV698OWYHdDr9uw1uVjRCQ
         Hq5GsMUb5kwUG7qd8v8ViQJalzR3lcyHZ2ymC6V+b/cw9aCpmxLHcznRUO17S517eZQt
         vF12MqojRl8tNE5gpVAdy+txSoMuqQ4GnVH0IQNhqhfko9oEqvSOWv3+TYkgk8yt5LLN
         0DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQmeB4kZpNulzj3YC16Y/CF0abLsGxtOjZ7MLt0xH/w=;
        b=7CaQ6t1cPu7swPjsCflG6TRD26PM9vwDOF+hUOCtYAvnCDZqaPOVWiDzmyk+qldRKF
         1/ch7eth17YIj+Kz/idTfppM2YKRqwdmOhJ0LKbbj32815FgLNzJz7d2gpQ1KFVGDzYx
         v5Uz10GWKJ2jsWMZ1v1OmUUbgPZvK1sEZfUOlKLZLJr/2XQhk9p4QiBchhUHchTVbkq0
         xeAt3PTFbfmgzxuPs7OD25SYHVXBdvGcqQXeIt1oOA5X3gGq7yJ5B7gIK3531j7+f/FC
         cBddM+TWlin8pHH8T7No+8fxkkcNnT2kIjMNzcyTjYfEQd+cc2JhS++pCsiQeEBdzF34
         jgOw==
X-Gm-Message-State: AO0yUKVvgZ5377sSpDPQHh31rDT1zsStq7/BsBvYd3o4eo17kVVlZotg
        Kp+yoA4rRFTwQzR+qrZ8BX6f1A/0xcwzXjyueSQ=
X-Google-Smtp-Source: AK7set+vH3hXHMCSKGj2qjLl86EfDF8sx5n26760RcMoI9XRw99BnabTZooKRlfHYCqh9a6LWG2MmC4rLWHF5LnOC6o=
X-Received: by 2002:a50:ba84:0:b0:4ac:b618:7fb1 with SMTP id
 x4-20020a50ba84000000b004acb6187fb1mr113376ede.6.1676326632994; Mon, 13 Feb
 2023 14:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20230212092715.1422619-4-davemarchevsky@fb.com>
 <202302121936.t36vlAFG-lkp@intel.com> <d04d33ff-0f8f-2bbd-3a67-9b8b813a799b@meta.com>
 <CAKwvOdketskm5z25aPRY7OsBOZe2kzvXV-i9RDTbwcLpZSAT0A@mail.gmail.com>
In-Reply-To: <CAKwvOdketskm5z25aPRY7OsBOZe2kzvXV-i9RDTbwcLpZSAT0A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Feb 2023 14:17:01 -0800
Message-ID: <CAADnVQ+qJMAugDDQXaerRbh0g4QdRygMZ_0UVmXViR2aJ4OLDQ@mail.gmail.com>
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

On Mon, Feb 13, 2023 at 12:49 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Feb 13, 2023 at 12:45 PM Dave Marchevsky
> <davemarchevsky@meta.com> wrote:
> >
> > On 2/12/23 6:21 AM, kernel test robot wrote:
> > > Hi Dave,
> > >
> > >>> kernel/bpf/helpers.c:1901:9: warning: cast from 'bool (*)(struct bp=
f_rb_node *, const struct bpf_rb_node *)' (aka '_Bool (*)(struct bpf_rb_nod=
e *, const struct bpf_rb_node *)') to 'bool (*)(struct rb_node *, const str=
uct rb_node *)' (aka '_Bool (*)(struct rb_node *, const struct rb_node *)')=
 converts to incompatible function type [-Wcast-function-type-strict]
> > >                          (bool (*)(struct rb_node *, const struct rb_=
node *))less);
> > >                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~
> >
> > This is the only new warning introduced by this series. A previous vers=
ion had
> > the same complaint by kernel test robot.
> >
> > struct bpf_rb_node is an opaque struct with the same size as struct rb_=
node.
> > It's not intended to be manipulated directly by any BPF program or bpf-=
rbtree
> > kernel code, but rather to be used as a struct rb_node by rbtree librar=
y
> > helpers.
> >
> > Here, the compiler complains that the less() callback taken by bpf_rbtr=
ee_add
> > is typed
> >
> > bool (*)(struct bpf_rb_node *, const struct bpf_rb_node *)
> >
> > while the actual rbtree lib helper rb_add's less() is typed
> >
> > bool (*)(struct rb_node *, const struct rb_node *)
> >
> > I'm not a C standard expert, but based on my googling, for C99 it's not=
 valid
> > to cast a function pointer to anything aside from void* and its origina=
l type.
> > Furthermore, since struct bpf_rb_node an opaque bitfield and struct rb_=
node
> > has actual members, C99 standard 6.2.7 paragraph 1 states that they're =
not
> > compatible:
> >
> >   Moreover, two structure,
> >   union, or enumerated types declared in separate translation units are=
 compatible if their
> >   tags and members satisfy the following requirements: If one is declar=
ed with a tag, the
> >   other shall be declared with the same tag. If both are complete types=
, then the following
> >   additional requirements apply: there shall be a one-to-one correspond=
ence between their
> >   members such that each pair of corresponding members are declared wit=
h compatible
> >   types, and such that if one member of a corresponding pair is declare=
d with a name, the
> >   other member is declared with the same name. For two structures, corr=
esponding
> >   members shall be declared in the same order
> >
> > I'm not sure how to proceed here. We could change bpf_rbtree_add's less=
() cb to
>
> I haven't looked at the series in question, but note that this compile
> time warning is meant to help us catch Control Flow Integrity runtime
> violations, which may result in a panic.

It's a transition from kernel to bpf prog.
If CFI trips on it it will trip on all transitions.
All calls from kernel into bpf are more or less the same.
Not sure what it means for other archs, but on x86 JIT emits 'endbr'
insn to make IBT/CFI happy.
