Return-Path: <bpf+bounces-4770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3228A74F1FB
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 16:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF01B281868
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 14:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9880A19BBD;
	Tue, 11 Jul 2023 14:23:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100114AB5
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 14:23:22 +0000 (UTC)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BE82D44
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:23:00 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7943be26e84so1867127241.2
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689085373; x=1691677373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+9v0i0ABTlKcuWoa6BJktNCo4AcOokPMS8xtG1hMqg=;
        b=r+HSkccS6HZmjTijGZD091hiregQegtSkhYPj//x8/PXY5mwGsEYCAHZS/1Syi0yXO
         B8MbtGzbBKoaaGrtCREbEBEpRkGiqHI4VdTFwqb4Iub2tL0FIu2HssE40E5CPcXFHBtF
         a0PmQG7NRUFMcx/lJ4V+bCtESdfKebljDCecxHUmhvMRvFtpGRyajNiTMFnpyJ6FDwzb
         rcQ4f+az5dpIK0XDH6JZ2khrw4N5LPO7WznavWixpHQFgI4scVmIJmzf8h8IVSTpSigp
         xKPEMcZ4bIXEaJ212wGNzJozTOt0JkmZ9Zl98kX8foBaMqYFa8FvcIxKNAL4jZfKC/p+
         CApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085373; x=1691677373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+9v0i0ABTlKcuWoa6BJktNCo4AcOokPMS8xtG1hMqg=;
        b=FdrfrM/HPrsO6B4f6tC+kKiw3UlDHY4d04dLxMzQglmuPRdgrLyMNNvzw//8KctLFz
         QczXnTckVVRhK5+rY/HJmLw+eXHbOQRAXzCau/oOGgLr4v/IcJ7SH1kYmItadTA68JwT
         WD4XhrQPBwtI4fLrolY/SKiPrhz44JiiWInmCGKrUNJhVfkNOywSHc6pIJ9ZHbMBMPxZ
         7vaobdliEPRREAraH/fUuaeIvZ6HSiJHo+nX4yenFx9+/JjJ7X3obvk9EqvgEyaR0FPE
         IbAlHEq+o3+dhc/XMJiooiv6/WxJEX8HdOV7tzc/cqEUiyL0XeR/rMsg3/c84b/IpiS8
         sP+g==
X-Gm-Message-State: ABy/qLb1Kp8p1PFq6jP9V0WCJEXr3Ms/GTwVbtyoWD4U2cJyAfKY9pE0
	BoPfSBLLoP6gkRKNC8+Nk5rLwfY78cOJO7Po6q4=
X-Google-Smtp-Source: APBJJlFYXbjHFqsTGFky++ZeeyH4ON8myZiOeG7fz9S1zF63dVWGr5U3jXHVmLN4zmch3zC2qjrBMY/SPH6KRVY6Lo4=
X-Received: by 2002:a67:ee53:0:b0:443:5ff0:bab2 with SMTP id
 g19-20020a67ee53000000b004435ff0bab2mr2950752vsp.22.1689085373412; Tue, 11
 Jul 2023 07:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230709025912.3837-1-laoar.shao@gmail.com> <20230709025912.3837-4-laoar.shao@gmail.com>
 <CAADnVQLUY4tb2s-tzSuxO5_8g3PAqnq_a-LwswPqxNL7=qLHBA@mail.gmail.com>
In-Reply-To: <CAADnVQLUY4tb2s-tzSuxO5_8g3PAqnq_a-LwswPqxNL7=qLHBA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 11 Jul 2023 22:22:17 +0800
Message-ID: <CALOAHbBAD_nvfti0iHKFv-T+jPVgixQXyjLqprLP5U2X38jLoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: Fix an error in verifying a field in a union
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 10:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Jul 8, 2023 at 7:59=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > We are utilizing BPF LSM to monitor BPF operations within our container
> > environment. When we add support for raw_tracepoint, it hits below
> > error.
> >
> > ; (const void *)attr->raw_tracepoint.name);
> > 27: (79) r3 =3D *(u64 *)(r2 +0)
> > access beyond the end of member map_type (mend:4) in struct (anon) with=
 off 0 size 8
> >
> > It can be reproduced with below BPF prog.
> >
> > SEC("lsm/bpf")
> > int BPF_PROG(bpf_audit, int cmd, union bpf_attr *attr, unsigned int siz=
e)
> > {
> >         switch (cmd) {
> >         case BPF_RAW_TRACEPOINT_OPEN:
> >                 bpf_printk("raw_tracepoint is %s", attr->raw_tracepoint=
.name);
> >                 break;
> >         default:
> >                 break;
> >         }
> >         return 0;
> > }
> >
> > The reason is that when accessing a field in a union, such as bpf_attr,
> > if the field is located within a nested struct that is not the first
> > member of the union, it can result in incorrect field verification.
> >
> >   union bpf_attr {
> >       struct {
> >           __u32 map_type; <<<< Actually it will find that field.
> >           __u32 key_size;
> >           __u32 value_size;
> >          ...
> >       };
> >       ...
> >       struct {
> >           __u64 name;    <<<< We want to verify this field.
> >           __u32 prog_fd;
> >       } raw_tracepoint;
> >   };
> >
> > Considering the potential deep nesting levels, finding a perfect
> > solution to address this issue has proven challenging. Therefore, I
> > propose a solution where we simply skip the verification process if the
> > field in question is located within a union.
> >
> > Fixes: 7e3617a72df3 ("bpf: Add array support to btf_struct_access")
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/btf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index fae6fc24a845..a542760c807a 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6368,7 +6368,7 @@ static int btf_struct_walk(struct bpf_verifier_lo=
g *log, const struct btf *btf,
> >                  * that also allows using an array of int as a scratch
> >                  * space. e.g. skb->cb[].
> >                  */
> > -               if (off + size > mtrue_end) {
> > +               if (off + size > mtrue_end && !(*flag & PTR_UNTRUSTED))=
 {
>
> The selftest for this condition is missing.

Will add it.

--=20
Regards
Yafang

