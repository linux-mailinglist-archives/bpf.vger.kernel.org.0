Return-Path: <bpf+bounces-13738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB557DD5BD
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223361C20C97
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0551B210FC;
	Tue, 31 Oct 2023 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfP9muaG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3749208CF
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:04:20 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B4EA3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:04:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so442065e9.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698775458; x=1699380258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvP4jsyCDeeGbvwBWcIFxSJQK5NHnF9De2+rMRp2p6U=;
        b=SfP9muaGPiTEuywjZ9WT8EHcDdcafnL2D1qi6mCqW6MY0O4LYE2rmr3/94dH5KC7XW
         Uj3H4NWQKT0S9WJbfxG/5fP5MD9SUAJLx2pZ9oG21y8u5GzgfF00gd4A4ZTEQY+PkdtV
         j4bKW+teO9tgnvyoBbkcagbbECz1ykfL8jKs52/534XEbKUVtLY/ruBSilzx5MFFv61K
         T1AONPx4QIkgjfEaxjoxPVhHHSE2TlCCPO5BOwkOtPjVUJguqF3KmbeP46x4vSNCXQE9
         Os0XtHwfmta79NmH0M44aco3lVWRUc0db7F/FdJnRHfnNUNjzsdfCzBO0CMUMbQWo6Kv
         Qihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698775458; x=1699380258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvP4jsyCDeeGbvwBWcIFxSJQK5NHnF9De2+rMRp2p6U=;
        b=RiM6RDqjoMrbBeVg0f7qPGIKRjEsISim8kxRUgMjeW8AKXApWVLV17EaSDtqPbE+5O
         BmEdakbFRDfVmbUxYg+u5JkyDLJNGeFvxAWmzFfpk9lhNH3s/nmIa4xTU6x7mUfzSGqR
         sgSjtv9tblOw+A0bvL+xb3Iaiom/Ihse7F/+WRoiNJf6Qh7qwe8Qlrw6mveQAMjI3SXa
         fl1z3xmwZrwGuuBHkZZfWVnlvOgFwVRX6I6/Ygnj+z5eB4/+uEBMYoYKUckAqxBX8Gtl
         mktx+CguI6Nmsj0QiJVTEh8bMm4MGNp0b5yrrop8snN+sSfPVLlhr+F+vKCytcdfsMwl
         q7VA==
X-Gm-Message-State: AOJu0YxiYmzU9Sz9eEfCwqBcT1h18K1YFmNDdHyAVKSbLQqCFZLJvvrb
	4jNkHuR/BSdO4DG9hbZP7w39o3f0Hwpb+ix31NY=
X-Google-Smtp-Source: AGHT+IHd31G5ZU0Hmww7cTnyLGhTgoq9fxFj/PgHfMm692OD4mjETJRVtJfmic1K7IUiXECAE8PgUO7YHufDDiMr4OE=
X-Received: by 2002:a05:6000:1845:b0:32d:a431:9045 with SMTP id
 c5-20020a056000184500b0032da4319045mr335677wri.30.1698775457540; Tue, 31 Oct
 2023 11:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-18-andrii@kernel.org>
 <20231031020248.uo54fkisydzwzgvn@MacBook-Pro-49.local> <CAEf4BzbZT11cYbinnGaqGZPiX2Mq5Taksx=VWOMhpuKEj8cXcA@mail.gmail.com>
 <CAADnVQLADK67wpesGfn=9EoAnXcHV8inBqOt79hjpSdvNS=yiQ@mail.gmail.com>
 <CAEf4BzbTc9wv=QU_ziG+TGcpHkLoQe_0NicKZF83KXgiCfqJFQ@mail.gmail.com> <CAEf4BzbZDdgLPkD3UaD2JCE6hV7X0ZHfYC0ToPnRQe0+9J3MfA@mail.gmail.com>
In-Reply-To: <CAEf4BzbZDdgLPkD3UaD2JCE6hV7X0ZHfYC0ToPnRQe0+9J3MfA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Oct 2023 11:04:06 -0700
Message-ID: <CAADnVQ+8m0OggW=eO5bHiFMpafV04ZSvBP6SNtjHN22bmSZ5CQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 17/23] bpf: generalize reg_set_min_max() to
 handle two sets of two registers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 10:56=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > >
> > > I don't see a code path where reg_set_min_max() is called
> > > with pointers. At least not in the current code base.
> > > Are you saying somewhere in your later patch it happens?
> > >
> >
> > Hm.. no, it's all in this patch. Check check_cond_jmp_op(). We at
> > least allow `(reg_is_pkt_pointer_any(dst_reg) &&
> > reg_is_pkt_pointer_any(src_reg)` case to get into is_branch_taken(),
> > which, btw, does handle pointer x pointer, pointer x scalar, and
> > scalar x scalar cases. Then, we go straight to reg_set_min_max(), both
> > for BPF_X and BPF_K cases. So reg_set_min_max() has to guard itself
> > against pointers.
>
> Correction, BPF_K branch does check for dst_reg->type =3D=3D SCALAR_VALUE=
.
> But BPF_X doesn't. I stared at this code for so long that I don't even
> notice those checks anymore :(
>
> I'd rather drop this SCALAR check for the BPF_K case and keep
> reg_set_min_max() as generic as is_branch_taken(), if that's ok. I
> think it's less error-prone and a more consistent approach.

Ahh. Now I see that the patch is doing reg_set_min_max()
right after BPF_X check.
So before the patch all !scalar checks were done outside
and extra __is_pointer_value() inside was useless (reserved for future).
With this change the !scalar change inside is necessary.
Makes sense now. Commit log could have explained that bit
and avoided this back and forth ;)

And yeah dropping !scalar from BPF_K path makes sense as well.

