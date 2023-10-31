Return-Path: <bpf+bounces-13741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 893647DD5C4
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96991C20CF6
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F92111E;
	Tue, 31 Oct 2023 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7aefBte"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323AF199A3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:06:23 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8A0F7
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:06:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso9878695a12.3
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698775580; x=1699380380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLjjzg0TslzUjnoC13hjgfhS/eXJuGr95yzpMA0wsr8=;
        b=O7aefBteh5eqBg1ikvD6Suyh+TzssdiajtD1nADN0ynybknjcN04TWY22lG5kpCZ/4
         ewKHwn/G4eBTZMNck1mNPbjzp6BovI9IxES1O9f//pNyeqYC7eX6BbFY+rw8S8g0Oq9n
         kSssNyV0jxgL47eCfkul1xG9v59IvKGLhZekmRknUdNDYs6IfZ4mWdTsTB5E4DDM8kow
         m9fuSeHjbrPV//NP9oAFgW3uzRs6GVwu/L8t3kQn059FlwegDJrWzVFnjm/BLGjViyYu
         YrAcr/b37/aXTF0PjvsKBPkt3NFHXHHQMvzGeV0Sia2HcYnTwSUismb2559JiaTQJgRf
         3UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698775580; x=1699380380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLjjzg0TslzUjnoC13hjgfhS/eXJuGr95yzpMA0wsr8=;
        b=rOvZcexfHZhjQlOU9ImNu86a0dwbbetMNLKnJBX1M1rvNvfIDlVElhqe7sh9b0t/nR
         B4oll3w3t+r17aKaI6rW55fl19iNS7ixkCAiDowYFYO5j+YyeyFj0WqXtdw7sguGPxbt
         Ru1dtezjD6ntIHPJIYMvORSZCSS7CZXfwWrNqpUfjbhWFlbVtaK+r8lE9EKxuqfjVjTU
         4QmwWR/tLnAg0NBA3KYgFmkJ2MHpzADck2X+9QEFTOZJ26LgF+StfskQHo1Deaw8OFOx
         Rdm9bPbbB3XwOBMnSoI83QWgXinLvqWatoekL8s3laEqcz96dyT6oxjA1AItnR4cWhQW
         FdwQ==
X-Gm-Message-State: AOJu0YwPFgV+nhvvqSuDJoG89ZKgkmlnObCq4tyhB4YZEJILwim9FeOF
	8BfxIVeykmtD155Fu9n17SJ6hPfPPTxbQtietT2tC22z
X-Google-Smtp-Source: AGHT+IFqE0Fm3cL+aJwDdd1p2rqQCU9e71O1CUZkzKi7s06G63UPpipdWuyXhYu4+LrXDjbyADVGI+wbvymRuOL7HN4=
X-Received: by 2002:a17:906:794d:b0:9b2:b2ad:2a76 with SMTP id
 l13-20020a170906794d00b009b2b2ad2a76mr124423ejo.16.1698775579857; Tue, 31 Oct
 2023 11:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-18-andrii@kernel.org>
 <20231031020248.uo54fkisydzwzgvn@MacBook-Pro-49.local> <CAEf4BzbZT11cYbinnGaqGZPiX2Mq5Taksx=VWOMhpuKEj8cXcA@mail.gmail.com>
 <CAADnVQLADK67wpesGfn=9EoAnXcHV8inBqOt79hjpSdvNS=yiQ@mail.gmail.com>
 <CAEf4BzbTc9wv=QU_ziG+TGcpHkLoQe_0NicKZF83KXgiCfqJFQ@mail.gmail.com>
 <CAEf4BzbZDdgLPkD3UaD2JCE6hV7X0ZHfYC0ToPnRQe0+9J3MfA@mail.gmail.com> <CAADnVQ+8m0OggW=eO5bHiFMpafV04ZSvBP6SNtjHN22bmSZ5CQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+8m0OggW=eO5bHiFMpafV04ZSvBP6SNtjHN22bmSZ5CQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 31 Oct 2023 11:06:08 -0700
Message-ID: <CAEf4BzY=txHiLjJYLVq+hD1O2vRs1o=WR-btthsX0OwjUmt8hA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 17/23] bpf: generalize reg_set_min_max() to
 handle two sets of two registers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 11:04=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 31, 2023 at 10:56=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > I don't see a code path where reg_set_min_max() is called
> > > > with pointers. At least not in the current code base.
> > > > Are you saying somewhere in your later patch it happens?
> > > >
> > >
> > > Hm.. no, it's all in this patch. Check check_cond_jmp_op(). We at
> > > least allow `(reg_is_pkt_pointer_any(dst_reg) &&
> > > reg_is_pkt_pointer_any(src_reg)` case to get into is_branch_taken(),
> > > which, btw, does handle pointer x pointer, pointer x scalar, and
> > > scalar x scalar cases. Then, we go straight to reg_set_min_max(), bot=
h
> > > for BPF_X and BPF_K cases. So reg_set_min_max() has to guard itself
> > > against pointers.
> >
> > Correction, BPF_K branch does check for dst_reg->type =3D=3D SCALAR_VAL=
UE.
> > But BPF_X doesn't. I stared at this code for so long that I don't even
> > notice those checks anymore :(
> >
> > I'd rather drop this SCALAR check for the BPF_K case and keep
> > reg_set_min_max() as generic as is_branch_taken(), if that's ok. I
> > think it's less error-prone and a more consistent approach.
>
> Ahh. Now I see that the patch is doing reg_set_min_max()
> right after BPF_X check.
> So before the patch all !scalar checks were done outside
> and extra __is_pointer_value() inside was useless (reserved for future).
> With this change the !scalar change inside is necessary.
> Makes sense now. Commit log could have explained that bit
> and avoided this back and forth ;)

Ok, I'll call this out in the commit message, np.

>
> And yeah dropping !scalar from BPF_K path makes sense as well.

Done.

