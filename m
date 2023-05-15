Return-Path: <bpf+bounces-563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C0F703CD5
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 20:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE0A1C20C77
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D3918C18;
	Mon, 15 May 2023 18:38:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B68846E
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 18:38:22 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5ED2709
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 11:38:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac836f4447so134728671fa.2
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684175899; x=1686767899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLf2SE1fYfL6xeSuR0WDRX/x3axqVeUjY81i3x9qn+s=;
        b=HVXSrwdCmanHlrfLI+GyM8nH4wqEbxyOjSL0imoxKkiGzcByfLcKxHQdvabrj13AGj
         BwP3yOwu75I/1ABDGzsL2oj7zCd7FJ9tQqKm/kzA44YqZagmanWXBGqqUMHec5k2xnFH
         0b7sgFqImU9b5Xivk9Lg/kPFeViQzgDR8i/RLblQH3DBbDVZL91UdL3TFVADUhdNjmAx
         y2BvI6P01wh9kzuOvae2ujJ7v+L5y6+MxS4YCeOGu3Ox4T7FAFtkXrtueMUCuEZTNq0p
         AHyJz4XEujME2I3Xh7p79x/HsDxkhpS3bNEhS6Ma6SqL755dJ7QHFXgduJJ5JTNl3xH2
         EMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684175899; x=1686767899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLf2SE1fYfL6xeSuR0WDRX/x3axqVeUjY81i3x9qn+s=;
        b=DNVH7FOXeAauyLt7DnNZRDAtgPMkN4dmfl4mPCdjJMPec9h19zQ9X0Dneg6Ywj5ASq
         j7M2XPM6weLhzV+YFvHEuwzJlDbbOwgqzc1NR4AXkURrfy/FjTZ8HabxSRZMRSxmkiAh
         K18+tMzljtZWdA5crQ4V00k4KH4aWOoaWfCmR87GCcZfKpmoaw1tUtD36oON5dYu2vgX
         5q8AiqV6VsoVjCn+kQC+nwWSRPyLdxDnI07n5AR419WYmQes4+3VA1tiUQb+prbZn4Q7
         2mZXFnONMHt9JCHyJ8h6iUdf48xGnqs+YGfTrRk+ovb2qq+e3vqQ7qhrXv/PTW3kYAuV
         9JNg==
X-Gm-Message-State: AC+VfDwh1faXpvHyhRvnLUprmkzfDkygQ9Wlo3bHVkg5OTQYHSerfNQg
	Jm7SGMf0Pzyl7h9JittjeePswX71KijHmhI9Mw8=
X-Google-Smtp-Source: ACHHUZ6FfzdiIxq+FHRzEm9o13Kl8JRTnrfl2t/v9NULzVYfqkgIncByj/pIufjh+LhP6AWlzoDalhSrBH8kWtLE4Og=
X-Received: by 2002:ac2:53ae:0:b0:4f1:44c0:a921 with SMTP id
 j14-20020ac253ae000000b004f144c0a921mr7929449lfh.55.1684175898847; Mon, 15
 May 2023 11:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-11-andrii@kernel.org>
 <CAADnVQJWbXvHqy4wdP3iC+UcewQNJbJ_rbGGLX5+sOUJ1+yeyg@mail.gmail.com> <CAEf4BzbxfvUQrjuo9XxP0TYm4F1Ek77RJ2qioLmAK5XczWLmvA@mail.gmail.com>
In-Reply-To: <CAEf4BzbxfvUQrjuo9XxP0TYm4F1Ek77RJ2qioLmAK5XczWLmvA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 May 2023 11:38:07 -0700
Message-ID: <CAADnVQ+EisyEtx-TPd_Wv2P-jV1Z1_4XuUoE0y=99SF7_HO5dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/10] bpf: consistenly use program's recorded
 capabilities in BPF verifier
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 15, 2023 at 9:42=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 11, 2023 at 9:21=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, May 2, 2023 at 4:09=E2=80=AFPM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >
> > > @@ -18878,7 +18882,12 @@ int bpf_check(struct bpf_prog **prog, union =
bpf_attr *attr, bpfptr_t uattr, __u3
> > >         env->prog =3D *prog;
> > >         env->ops =3D bpf_verifier_ops[env->prog->type];
> > >         env->fd_array =3D make_bpfptr(attr->fd_array, uattr.is_kernel=
);
> > > -       is_priv =3D bpf_capable();
> > > +
> > > +       env->allow_ptr_leaks =3D bpf_allow_ptr_leaks(*prog);
> > > +       env->allow_uninit_stack =3D bpf_allow_uninit_stack(*prog);
> > > +       env->bypass_spec_v1 =3D bpf_bypass_spec_v1(*prog);
> > > +       env->bypass_spec_v4 =3D bpf_bypass_spec_v4(*prog);
> > > +       env->bpf_capable =3D is_priv =3D (*prog)->aux->bpf_capable;
> >
> > Just remembered that moving all CAP* checks early
> > (before they actually needed)
> > might be problematic.
> > See
> > https://lore.kernel.org/all/20230511142535.732324-10-cgzones@googlemail=
.com/
> >
> > This patch set is reducing the number of cap* checks which is
> > a good thing from audit pov, but it calls them early before the cap
> > is actually needed and that part is misleading for audit.
> > I'm afraid we cannot do one big switch for all map types after bpf_capa=
ble.
> > The bpf_capable for maps needs to be done on demand.
> > For progs we should also do it on demand too.
> > socket_filter and cg_skb should proceed without cap* checks.
>
> Ok, fair enough. With BPF token approach this shouldn't be a big deal any=
ways.
>
> Does patch #5 ("bpf: drop unnecessary bpf_capable() check in
> BPF_MAP_FREEZE command") look good? I think it makes sense to land
> either way, given any other map-related operation isn't privileged
> once user has map FD. I'll send it separately.

Yeah. I think the whole cleanup makes sense, just need to make
sure we do on-demand cap checks. I hope the patches won't change much.

