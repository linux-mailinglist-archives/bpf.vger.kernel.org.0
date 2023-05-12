Return-Path: <bpf+bounces-452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185CA700F1D
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 21:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF741C2135F
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 18:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEAF23D60;
	Fri, 12 May 2023 18:59:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465C23D43
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 18:59:50 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB71735A9
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:59:47 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ac7f53ae44so111521151fa.2
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683917986; x=1686509986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YweUPQ/RNAWg+2CKFB9193WYas7n6WYMbyR5urnGiO0=;
        b=guSIen/dFtIydD1dVsMyV+PFKB1Ja6jXzlDcJE4AQmLFB/tOxvPEFulFSnSlIZuaQE
         quDZPtAi9qFETmKBcW/yoTpB6u3ZNBeLjnS7XAof01itokh3cCjOgefT13SkapTtreST
         skuYTs3gHaQjCQS/KbxlbocfXs5OVaiweH3w8lvtqGsZanBXbR9bHGapNSuhMf3eR35E
         8G1yX0cUvHM9WlB3lWerGZbI3PytVnj/CIgMPOdEzzzx0epaZ9o7uNabn8+Doom6+YPy
         O3XtMeocsw1mBguVUqNC7RsC3Zzu0Ls+PMKmlI2uUCY2LVMWC3yRRI+RVKd5XnInoGiK
         U4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683917986; x=1686509986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YweUPQ/RNAWg+2CKFB9193WYas7n6WYMbyR5urnGiO0=;
        b=KNF6YR20kDStFjN6GpoGfiBbbK+9+CaTBOaU/MLGuoZWNzhl9pfQh4WGRqY7Ab8jDl
         Vvu6yepncAYe7SC1eDkWlYqrbIu+i/2SMluLISOcB93E/s8W9TIt6jdHyeErmQLhKPbL
         9AuCT5UQqm3pkD9mhel2fKepKIsaVJrMthQ2EeaqGD59xylfHt2C9GgW2n947O6l7Syx
         sLAxQWKgNh3F9N+GM9O1y7qsBK/tGV+CJsyv/A2Zp5VdPwvtYbrrfACuZVgLPgWyOI9p
         qvqsxAHKJt0ZeKZa1q09yU4tCgAL14WwTyBdYV32YuQVrDwhDiWmsi253pVpc8z049oe
         g6kA==
X-Gm-Message-State: AC+VfDx7KHiMCTYEzTn45W8DTjU0yuoOp24+FF85UmPBosr/OYjnkYjH
	XsfNXrLfiXHQUlHhP4EXf9bcA4PhpFoXe7NxtQ4=
X-Google-Smtp-Source: ACHHUZ4v34Z3wCaS/PCyqD244yLa4m4+Elf1pMZ/wHfeYeIf1UGl+euikUIUh4yoNd+pro/yyKKmPqNR6FbD1DTerb4=
X-Received: by 2002:a2e:6a19:0:b0:2a8:c8c5:c769 with SMTP id
 f25-20020a2e6a19000000b002a8c8c5c769mr4320418ljc.36.1683917985714; Fri, 12
 May 2023 11:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230510130241.1696561-1-alan.maguire@oracle.com>
 <CALOAHbDeK4SkP7pXdBWJ6Omwq2NyxJrYn6wZTX=z1-VkDtWwMQ@mail.gmail.com> <6b15f6ff-8b66-3a78-2df6-5def5cf77203@oracle.com>
In-Reply-To: <6b15f6ff-8b66-3a78-2df6-5def5cf77203@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 May 2023 11:59:34 -0700
Message-ID: <CAADnVQKDO8_Hnotf40iHLD-GRmJZpz_ygpkYZGRvey0ENJOc0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 12, 2023 at 9:04=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 12/05/2023 03:51, Yafang Shao wrote:
> > On Wed, May 10, 2023 at 9:03=E2=80=AFPM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> v1.25 of pahole supports filtering out functions with multiple inconsi=
stent
> >> function prototypes or optimized-out parameters from the BTF represent=
ation.
> >> These present problems because there is no additional info in BTF sayi=
ng which
> >> inconsistent prototype matches which function instance to help guide a=
ttachment,
> >> and functions with optimized-out parameters can lead to incorrect assu=
mptions
> >> about register contents.
> >>
> >> So for now, filter out such functions while adding BTF representations=
 for
> >> functions that have "."-suffixes (foo.isra.0) but not optimized-out pa=
rameters.
> >> This patch assumes that below linked changes land in pahole for v1.25.
> >>
> >> Issues with pahole filtering being too aggressive in removing function=
s
> >> appear to be resolved now, but CI and further testing will confirm.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  scripts/pahole-flags.sh | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> >> index 1f1f1d397c39..728d55190d97 100755
> >> --- a/scripts/pahole-flags.sh
> >> +++ b/scripts/pahole-flags.sh
> >> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
> >>         # see PAHOLE_HAS_LANG_EXCLUDE
> >>         extra_paholeopt=3D"${extra_paholeopt} --lang_exclude=3Drust"
> >>  fi
> >> +if [ "${pahole_ver}" -ge "125" ]; then
> >> +       extra_paholeopt=3D"${extra_paholeopt} --skip_encoding_btf_inco=
nsistent_proto --btf_gen_optimized"
> >> +fi
> >>
> >>  echo ${extra_paholeopt}
> >> --
> >> 2.31.1
> >>
> >
> > That change looks like a workaround to me.
> > There may be multiple functions that have the same proto, e.g.:
> >
> >   $ grep -r "bpf_iter_detach_map(struct bpf_iter_aux_info \*aux)"
> > kernel/bpf/ net/core/
> >   kernel/bpf/map_iter.c:static void bpf_iter_detach_map(struct
> > bpf_iter_aux_info *aux)
> >   net/core/bpf_sk_storage.c:static void bpf_iter_detach_map(struct
> > bpf_iter_aux_info *aux)
> >
> >   $ bpftool btf dump file /sys/kernel/btf/vmlinux   |  grep -B 2
> > bpf_iter_detach_map
> >   [34691] FUNC_PROTO '(anon)' ret_type_id=3D0 vlen=3D1
> >   'aux' type_id=3D2638
> >   [34692] FUNC 'bpf_iter_detach_map' type_id=3D34691 linkage=3Dstatic
> >
> > We don't know which one it is in the BTF.
> > However, I'm not against this change, as it can avoid some issues.
> >
>
> In the above case, the BTF representation is consistent though.
> That is, if I attach fentry progs to either of these functions
> based on that BTF representation, nothing will crash.
>
> That's ultimately what those changes are about; ensuring
> consistency in BTF representation, so when a function is in
> BTF we can know the signature of the function can be safely
> used by fentry for example.
>
> The question of being able to identify functions (as opposed
> to having a consistent representation) is the next step.
> Finding a way to link between kallsyms and BTF would allow us to
> have multiple inconsistent functions in BTF, since we could map
> from BTF -> kallsyms safely. So two functions called "foo"
> with different function signatures would be okay, because
> we'd know which was which in kallsyms and could attach
> safely. Something like a BTF tag for the function that could
> clarify that mapping - but just for cases where it would
> otherwise be ambiguous - is probably the way forward
> longer term.
>
> Jiri's talking about this topic at LSF/MM/BPF this week I believe.

Jiri presented a few ideas during LSFMMBPF.

I feel the best approach is to add a set of addr-s to BTF
via a special decl_tag.
We can also consider extending KIND_FUNC.
The advantage that every BTF func will have one or more addrs
associated with it and bpf prog loading logic wouldn't need to do
fragile name comparison between btf and kallsyms.
pahole can take addrs from dwarf and optionally double check with kallsyms.

