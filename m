Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5702E4A8C40
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 20:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353707AbiBCTKU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 14:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353676AbiBCTKT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 14:10:19 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDEFC06173B
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 11:10:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id n8so8048198lfq.4
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 11:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ynmf8AjH8Et2t1D/8nO4kTjYKzq6oPr1yGjthzD28xc=;
        b=XppQR1odninb58XQkHQZxOkb7D7s2rQyxjO9nGahV1FN6cGuzbsVLenP9ylclcRBfo
         uXvFmluELQEC3mgmj4rKiB+Etwd6UJBvMWo80bj54CwX/6r0WDtYHbpYgHmzhhXbKBF6
         AuTAVn3RsWpFS4SeIRTIlbk1YFkWtFII2Ot4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ynmf8AjH8Et2t1D/8nO4kTjYKzq6oPr1yGjthzD28xc=;
        b=MnLTtB9u2lONsD3L1m8BBMHtG4sZiOKiQ/ISRqsVHaunGihi9UVu4EiMbMXvytZa3W
         0hlMjOtCnaJp82aPUHJdRtE+mgIUWiC48nmMD0qaPEJXSEq0ONCscaJSLMprGTBxE2LB
         gwXmVStwCQMbKQxdFoe0zLuVpOeyI+3rKflYb08y0sU2yeE8Mg7U4smXh4oziLWKeath
         KEUrZwldiNiUgYWdkDUi+FXJ3m0uw9p4eewNQ77NnKtTMOIDoyh4l803Kqj/mYZfo5M/
         N01X7IVPKZ3w4PnwvFhU7rmNmAJcNwIx4SxHisO6fAyckesm5BGj2gqAUbU/SaOE3NUt
         eB0w==
X-Gm-Message-State: AOAM530AXLYmAo6CJ1Z+EcGxji/VQ1yNPP2T9Pk2rO8yzkDSD9FwkCQi
        ZPOSj3dEN6C2ZL4OVtmCXdol7wp8kSDpY41QOVoKBQ==
X-Google-Smtp-Source: ABdhPJzHIHnWIOTmGvYm8nIKwHSKOYfJgpJULETxSmdV0h3Un1nyIWposC4LAQ9tOs/Ut6LG1jmPr5N+8cKwDXPTzwk=
X-Received: by 2002:a05:6512:2823:: with SMTP id cf35mr27987626lfb.113.1643915417465;
 Thu, 03 Feb 2022 11:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20220128223312.1253169-1-mauricio@kinvolk.io> <20220128223312.1253169-6-mauricio@kinvolk.io>
 <d1b23ebb-21ac-558b-36a8-918b0c6cf909@isovalent.com>
In-Reply-To: <d1b23ebb-21ac-558b-36a8-918b0c6cf909@isovalent.com>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Thu, 3 Feb 2022 14:10:05 -0500
Message-ID: <CAHap4zvBfyFYB8rQo_s3aXGAyG3hEwJ4Xsn4pdrPr5k=GhwQZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/9] bpftool: Implement btfgen()
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>,
        Lorenzo Fontana <lorenzo.fontana@elastic.co>,
        Leonardo Di Donato <leonardo.didonato@elastic.co>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 1, 2022 at 3:57 PM Quentin Monnet <quentin@isovalent.com> wrote=
:
>
> 2022-01-28 17:33 UTC-0500 ~ Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> > btfgen() receives the path of a source and destination BTF files and a
> > list of BPF objects. This function records the relocations for all
> > objects and then generates the BTF file by calling btfgen_get_btf()
> > (implemented in the following commits).
> >
> > btfgen_record_obj() loads the BTF and BTF.ext sections of the BPF
> > objects and loops through all CO-RE relocations. It uses
> > bpf_core_calc_relo_insn() from libbpf and passes the target spec to
> > btfgen_record_reloc() that saves the types involved in such relocation.
> >
> > Signed-off-by: Mauricio V=C3=A1squez <mauricio@kinvolk.io>
> > Signed-off-by: Rafael David Tinoco <rafael.tinoco@aquasec.com>
> > Signed-off-by: Lorenzo Fontana <lorenzo.fontana@elastic.co>
> > Signed-off-by: Leonardo Di Donato <leonardo.didonato@elastic.co>
> > ---
> >  tools/bpf/bpftool/Makefile |   8 +-
> >  tools/bpf/bpftool/gen.c    | 221 ++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 223 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index 83369f55df61..97d447135536 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -34,10 +34,10 @@ LIBBPF_BOOTSTRAP_INCLUDE :=3D $(LIBBPF_BOOTSTRAP_DE=
STDIR)/include
> >  LIBBPF_BOOTSTRAP_HDRS_DIR :=3D $(LIBBPF_BOOTSTRAP_INCLUDE)/bpf
> >  LIBBPF_BOOTSTRAP :=3D $(LIBBPF_BOOTSTRAP_OUTPUT)libbpf.a
> >
> > -# We need to copy hashmap.h and nlattr.h which is not otherwise export=
ed by
> > -# libbpf, but still required by bpftool.
> > -LIBBPF_INTERNAL_HDRS :=3D $(addprefix $(LIBBPF_HDRS_DIR)/,hashmap.h nl=
attr.h)
> > -LIBBPF_BOOTSTRAP_INTERNAL_HDRS :=3D $(addprefix $(LIBBPF_BOOTSTRAP_HDR=
S_DIR)/,hashmap.h)
> > +# We need to copy hashmap.h, nlattr.h, relo_core.h and libbpf_internal=
.h
> > +# which are not otherwise exported by libbpf, but still required by bp=
ftool.
> > +LIBBPF_INTERNAL_HDRS :=3D $(addprefix $(LIBBPF_HDRS_DIR)/,hashmap.h nl=
attr.h relo_core.h libbpf_internal.h)
> > +LIBBPF_BOOTSTRAP_INTERNAL_HDRS :=3D $(addprefix $(LIBBPF_BOOTSTRAP_HDR=
S_DIR)/,hashmap.h relo_core.h libbpf_internal.h)
>
> Do you directly call functions from relo_core.h, or is it only required
> to compile libbpf_internal.h? (Asking because I'm wondering if there
> would be a way to have one fewer header copied).

bpf_core_calc_relo_insn() and bpf_core_calc_relo_insn() are used.
