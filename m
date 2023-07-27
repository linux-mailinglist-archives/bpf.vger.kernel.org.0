Return-Path: <bpf+bounces-6089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AF27657FD
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AE428173B
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5918007;
	Thu, 27 Jul 2023 15:48:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1617AC5
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 15:48:03 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C7AF3
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 08:48:01 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso16981051fa.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690472880; x=1691077680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVo0hV12S9SdQ1se1+hJ9mLGICbcIqynn/N9SnA+71A=;
        b=pmVJkO7Uw52QOA23uJMi1qgde1a4+LtrZ3DTE/ujXQ0H+HmzsGM0rzS99M0s0754aw
         ntpvSBA3MOw6n053NOZhTexskFTINl2cDjvxjaAOXLLuOwBwUHxLpSoOQBO0GYFRBRqA
         9ZWi8BhRhzylRDq+dnqjMa0pihLA/syMxd1zeJc7NLmLR1bWnvpatf/xBNFOizseXQrW
         RuvX8wiGEvzCLanLrtL7+Y56O2k0Egacufmn7LpLXBSNwKcaU6OtOf+ykKb4hpzPtmgN
         6Rl7f6xFV4Hx5I8mSi2cxsu7RjnlXwF7A34zwXzHrw10W1OjNWKAB1LFw/6aAIfgVRHZ
         7yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690472880; x=1691077680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVo0hV12S9SdQ1se1+hJ9mLGICbcIqynn/N9SnA+71A=;
        b=Vpvi2w13t0HQGyMZPN9QvdLjjX8wELw4YDXJ3aaMOf4gLV+PwlskzWxb9Pyp3Hdi4a
         vTEaiAYT5j4pn85HVyHZaudNo/tiY3bOF+US1MffB3kpYXVNiuwwf3fVYm2UoEqyxmKC
         l757+s/kaxSBd+MHM1LuGh3aH1UoQgnu+WQ7LSNAB+xEH6pV7G1PZhit4eC3CoXBsE8v
         y1sxqTXb8vzfzW1E1BKUby+vq1eXAQoLb3xxnEJIj+TYHsrdF/uRJqhEWiTQgPdtS9vA
         WaeMLjU2d8PcyGEF5XZxfcsFIzSyZKBcmcvjHgTEsv/ehrCk42lhWDjF0pmSpf1ThMIv
         +TjA==
X-Gm-Message-State: ABy/qLb+RKUy48KQ0+AJB5JFC1GBJ3oJa7h6z7dcHRn8CEcbszUa0zTC
	x3voWMvfUyJIFdXbnQvV00P+K1QEFJjL557dOf0=
X-Google-Smtp-Source: APBJJlHQXmCBh0J8zNPxFbksaUuabsfOxEfueUC3iHKjycCXpC+alXcboNh5tNsCjQ0dkt0RiBVVCQ9NA5oZZR1QknY=
X-Received: by 2002:a2e:9092:0:b0:2b7:33a6:f2c0 with SMTP id
 l18-20020a2e9092000000b002b733a6f2c0mr2152644ljg.4.1690472879705; Thu, 27 Jul
 2023 08:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230720201443.224040-1-alan.maguire@oracle.com>
 <20230720201443.224040-2-alan.maguire@oracle.com> <ZMD35ydVT69zDipR@krava> <a6ade0a3-a03d-d526-afc0-db9ffcfe86ea@oracle.com>
In-Reply-To: <a6ade0a3-a03d-d526-afc0-db9ffcfe86ea@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jul 2023 08:47:48 -0700
Message-ID: <CAADnVQLVng1GVGsFZO6hKkHg_uafCSz5USwhZepT1kokiVH0eg@mail.gmail.com>
Subject: Re: [RFC dwarves 1/2] dwarves: auto-detect maximum kind supported by vmlinux
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 8:29=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 26/07/2023 11:39, Jiri Olsa wrote:
> > On Thu, Jul 20, 2023 at 09:14:42PM +0100, Alan Maguire wrote:
> >> When a newer pahole is run on an older kernel, it often knows about BT=
F
> >> kinds that the kernel does not support.  This is a problem because the=
 BTF
> >> generated is then embedded in the kernel image and read, and if unknow=
n
> >> kinds are found, BTF handling fails and core BPF functionality is
> >> unavailable.
> >>
> >> The scripts/pahole-flags.sh script enumerates the various pahole optio=
ns
> >> available associated with various versions of pahole, but the problem =
is
> >> what matters in the case of an older kernel is the set of kinds the ke=
rnel
> >> understands.  Because recent features such as BTF_KIND_ENUM64 are adde=
d
> >> by default (and only skipped if --skip_encoding_btf_* is set), BTF wil=
l
> >> be created with these newer kinds that the older kernel cannot read.
> >> This can be fixed by stable-backporting --skip options, but this is
> >> cumbersome and would have to be done every time a new BTF kind is
> >> introduced.
> >>
> >> Here instead we pre-process the DWARF information associated with the
> >> target for BTF generation; if we find an enum with a BTF_KIND_MAX
> >> value in the DWARF associated with the object, we use that to
> >> determine the maximum BTF kind supported.  Note that the enum
> >> representation of BTF kinds starts for the 5.16 kernel; prior to this
> >> The benefit of auto-detection is that no work is required for older
> >> kernels when new kinds are added, and --skip_encoding options are
> >> less needed.
> >>
> >> [1] https://github.com/oracle-samples/bpftune/issues/35
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  btf_encoder.c  | 12 ++++++++++++
> >>  dwarf_loader.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++=
+
> >>  dwarves.h      |  2 ++
> >>  3 files changed, 66 insertions(+)
> >>
> >> diff --git a/btf_encoder.c b/btf_encoder.c
> >> index 65f6e71..98c7529 100644
> >> --- a/btf_encoder.c
> >> +++ b/btf_encoder.c
> >> @@ -1889,3 +1889,15 @@ struct btf *btf_encoder__btf(struct btf_encoder=
 *encoder)
> >>  {
> >>      return encoder->btf;
> >>  }
> >> +
> >> +void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_k=
ind_max)
> >> +{
> >> +    if (btf_kind_max < 0 || btf_kind_max >=3D BTF_KIND_MAX)
> >> +            return;
> >> +    if (btf_kind_max < BTF_KIND_DECL_TAG)
> >> +            conf_load->skip_encoding_btf_decl_tag =3D true;
> >> +    if (btf_kind_max < BTF_KIND_TYPE_TAG)
> >> +            conf_load->skip_encoding_btf_type_tag =3D true;
> >> +    if (btf_kind_max < BTF_KIND_ENUM64)
> >> +            conf_load->skip_encoding_btf_enum64 =3D true;
> >> +}
> >
> > hi,
> > so there are some older kernels other than stable that would use this f=
eature
> > right? because stable already have proper setup for pahole options
> >
> > or it's just there to be complete and we'd eventually add new rules in =
here?
> > wouldn't that be covered by the BTF kind layout stuff you work on? is t=
here
> > some overlap?
> >
>
> Yeah, the idea is to minimize the complexity when adding new kinds. The
> approach explored here does this because when adding a new kind we have
> to either
>
> - make it a pahole opt-in parameter, which means more --btf_encode_*
> parameters for dwarves; or
> - make it an opt-out parameter, which means more stable backports to set
> the opt-out.
>
> My original hope was BTF kind layout encoding would solve the problem,
> but the problem is that new kinds are often entwined tightly in the
> representation of structures, functions etc. When that happens, even
> knowing the kind layout won't help an older kernel interpret what the
> BTF actually means when it was generated by a newer pahole. Kind layout
> still has value - it means BTF can always be dumped for example - but it
> can't really help the kernel to reliabily _use_ kernel/module BTF
> information. So the approach here is to try to streamline the process by
> not requiring new options when a new kind is added; we can simply detect
> if the kernel knows about the kind and skip it if not. Since this
> detection is all internal to pahole, nothing needs to be exposed to the
> user.
>
>
> >> diff --git a/dwarf_loader.c b/dwarf_loader.c
> >> index ccf3194..8984043 100644
> >> --- a/dwarf_loader.c
> >> +++ b/dwarf_loader.c
> >> @@ -3358,8 +3358,60 @@ static int __dwarf_cus__process_cus(struct dwar=
f_cus *dcus)
> >>      return 0;
> >>  }
> >>
> >> +/* Find enumeration value for BTF_KIND_MAX; replace conf_load->btf_ki=
nd_max with
> >> + * this value if found since it indicates that the target object does=
 not know
> >> + * about kinds > its BTF_KIND_MAX value.  This is valuable for kernel=
/module
> >> + * BTF where a newer pahole/libbpf operate on an older kernel which c=
annot
> >> + * parse some of the newer kinds pahole can generate.
> >> + */
> >> +static void dwarf__find_btf_kind_max(struct dwarf_cus *dcus)
> >> +{
> >> +    struct conf_load *conf =3D dcus->conf;
> >> +    uint8_t pointer_size, offset_size;
> >> +    Dwarf_Off off =3D 0, noff;
> >> +    size_t cuhl;
> >> +
> >> +    while (dwarf_nextcu(dcus->dw, off, &noff, &cuhl, NULL, &pointer_s=
ize, &offset_size) =3D=3D 0) {
> >> +            Dwarf_Die die_mem;
> >> +            Dwarf_Die *cu_die =3D dwarf_offdie(dcus->dw, off + cuhl, =
&die_mem);
> >> +            Dwarf_Die child;
> >> +
> >> +            if (cu_die =3D=3D NULL)
> >> +                    break;
> >> +            if (dwarf_child(cu_die, &child) =3D=3D 0) {
> >> +                    Dwarf_Die *die =3D &child;
> >> +
> >> +                    do {
> >> +                            Dwarf_Die echild, *edie;
> >> +
> >> +                            if (dwarf_tag(die) !=3D DW_TAG_enumeratio=
n_type ||
> >> +                                !dwarf_haschildren(die) ||
> >> +                                dwarf_child(die, &echild) !=3D 0)
> >> +                                    continue;
> >> +                            edie =3D &echild;
> >> +                            do {
> >> +                                    const char *ename;
> >> +                                    int btf_kind_max;
> >> +
> >> +                                    if (dwarf_tag(edie) !=3D DW_TAG_e=
numerator)
> >> +                                            continue;
> >> +                                    ename =3D attr_string(edie, DW_AT=
_name, conf);
> >> +                                    if (!ename || strcmp(ename, "BTF_=
KIND_MAX") !=3D 0)
> >> +                                            continue;
> >> +                                    btf_kind_max =3D attr_numeric(edi=
e, DW_AT_const_value);
> >> +                                    dwarves__set_btf_kind_max(conf, b=
tf_kind_max);
> >> +                                    return;
> >> +                            } while (dwarf_siblingof(edie, edie) =3D=
=3D 0);
> >> +                    } while (dwarf_siblingof(die, die) =3D=3D 0);
> >> +            }
> >> +            off =3D noff;
> >> +    }
> >> +}
> >> +
> >>  static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
> >>  {
> >> +    dwarf__find_btf_kind_max(dcus);
> >
> > first I though this should be enabled by some (detect) option.. but tha=
t
> > would probably beat the main purpose.. also I think we don't need kerne=
l
> > with BTF that it can't process
> >
>
> Hmm, maybe it might be good to have it associated with --btf_gen_all in
> case we ever want to disable it for debugging purposes? What do you
> think? Thanks!

Overall approach makes sense to me and an extra flag like --btf_gen_all
to disable this smartness also makes sense.

