Return-Path: <bpf+bounces-13742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2D97DD5C8
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 19:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D993AB20CD8
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1897D21354;
	Tue, 31 Oct 2023 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMD7K5H/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AB199A3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:07:10 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A56A2
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:07:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32dc918d454so3789249f8f.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 11:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698775628; x=1699380428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RUHs+Gkr7vwPCfhl0MJm5ELSvHF9844/n0968IWYsk=;
        b=GMD7K5H/NQT0cFA0Yug1Tts9dR1L3n6Rqo1/svxioplk2Q/teBQ8uEOOjmdxmFlXZE
         Sfk/KCwvpcuzbEhGjTrfQMZurc+FyoslwnUjUaMwyH0aURAM3d7vcOOQmBHZMrg+SMMT
         gNML14KYUP1x08QMY5/89lZRZpSDp8sqDL2cEvf/Dr4CfMi3ykRKEA14muAxqcBztd58
         uZ0SDwtiQVuFwPehZMDBXkGb5jGc6nDG2VvLE/FaYm9hK4Lq7pHRoXe04Ar53tXTahKJ
         JURT1Es4ST+/aGg6rvqpl4zYV+W5+xEHFl7GBxuLAIj39G577enwpRp6SUTi+OZYU/1J
         n+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698775628; x=1699380428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RUHs+Gkr7vwPCfhl0MJm5ELSvHF9844/n0968IWYsk=;
        b=Oi0v+Umk5ffvfxTKpeF3qq2/yHoQHNW4PbCDc3aIeFQEeVJjZoUquU3/uTbGOZIBBL
         5FgW2IA3C9DV008TD8JXBSr0QFeV0CGRW69kSA30n9VG/Ut5ObPuSRJEXnQwZozoQHed
         b1fWDVOItO/uXqf/sNwlUbzCSOtVJXMwiR187nsNytU0NLwdP7uS4Munfruu2ZGs9Uel
         2ADMSrENDcNbb5ReHSacTLZpvNWw9Q6q11pEBb5JhKNp8xo+2jSw5KDvXP+n9TRexWwT
         eX2bauu2nLSuJjTRVXZPrLMMfdi0UOf1HqZS3gy04+g6dYdiIw4ZLlkuLHBomiiM6Zyu
         p6EQ==
X-Gm-Message-State: AOJu0Yw0qcEBh3oC9hw0ShRiy3CqZ4jQ50tW6QqtzeFeIPVvD8Ku0qJL
	jmot4WhzxXHqYbZ48QpQSq9y3clQRyjIgeY4ya0lT62e
X-Google-Smtp-Source: AGHT+IGnRtErdvD1B/hm7GM/67xN40SqpVtBcKzPmSxuxu06+l2FMln4wfc5l40H2gDUH2Ul/qcPPp1KeHl2RcZk6ao=
X-Received: by 2002:adf:f40b:0:b0:32d:87c8:b548 with SMTP id
 g11-20020adff40b000000b0032d87c8b548mr8061072wro.21.1698775627677; Tue, 31
 Oct 2023 11:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027181346.4019398-1-andrii@kernel.org> <20231027181346.4019398-21-andrii@kernel.org>
 <20231031022033.536yvwc5vcc4toh2@MacBook-Pro-49.local> <CAEf4BzZC3NYUZu2uK+Mi3GgMrLOqe=ShXpkQpor-dLZxbjM-Tw@mail.gmail.com>
 <CAADnVQ+a-39-Gppmh3VgVaEYfnpHg9v9+mjPGEbX4PoSqaeMLw@mail.gmail.com> <CAEf4Bzb6jNpXr6LGHHrW17zaM_H1aDR-hY+eQg5dZUF0ZboufA@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6jNpXr6LGHHrW17zaM_H1aDR-hY+eQg5dZUF0ZboufA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 31 Oct 2023 11:06:56 -0700
Message-ID: <CAADnVQLHXeyrNvercxNVq2mrREk-g0cKhKF30KMhFhDa9KyN4Q@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 20/23] bpf: enhance BPF_JEQ/BPF_JNE
 is_branch_taken logic
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 11:04=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 31, 2023 at 9:36=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Oct 30, 2023 at 11:16=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Oct 30, 2023 at 7:20=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Oct 27, 2023 at 11:13:43AM -0700, Andrii Nakryiko wrote:
> > > > > Use 32-bit subranges to prune some 64-bit BPF_JEQ/BPF_JNE conditi=
ons
> > > > > that otherwise would be "inconclusive" (i.e., is_branch_taken() w=
ould
> > > > > return -1). This can happen, for example, when registers are init=
ialized
> > > > > as 64-bit u64/s64, then compared for inequality as 32-bit subregi=
sters,
> > > > > and then followed by 64-bit equality/inequality check. That 32-bi=
t
> > > > > inequality can establish some pattern for lower 32 bits of a regi=
ster
> > > > > (e.g., s< 0 condition determines whether the bit #31 is zero or n=
ot),
> > > > > while overall 64-bit value could be anything (according to a valu=
e range
> > > > > representation).
> > > > >
> > > > > This is not a fancy quirky special case, but actually a handling =
that's
> > > > > necessary to prevent correctness issue with BPF verifier's range
> > > > > tracking: set_range_min_max() assumes that register ranges are
> > > > > non-overlapping, and if that condition is not guaranteed by
> > > > > is_branch_taken() we can end up with invalid ranges, where min > =
max.
> > > >
> > > > This is_scalar_branch_taken() logic makes sense,
> > > > but if set_range_min_max() is delicate, it should have its own sani=
ty
> > > > check for ranges.
> > > > Shouldn't be difficult to check for that dangerous overlap case.
> > >
> > > So let me clarify. As far as I'm concerned, is_branch_taken() is such
> > > a check for set_reg_min_max, and so duplicating such checks in
> > > set_reg_min_max() is just that a duplication of code and logic, and
> > > just a chance for more typos and subtle bugs.
> > >
> > > But the concern about invalid ranges is valid, so I don't know,
> > > perhaps we should just do a quick check after adjustment to validate
> > > that umin<=3Dumax and so on? E.g., we can do that outside of
> > > reg_set_min_max(), to keep reg_set_min_max() non-failing. WDYT?
> >
> > Sounds like a good option too.
> > Just trying to minimize breakage in the future.
> > Sanity check before or after should catch it.
>
> Sounds good, I'll have a separate register state sanity check and will
> see what minimal amount of places where we should call it.
>
> I'm assuming we are ok with returning -EFAULT and failing validation
> whenever we detect violation, right?

Yep and I'll take back WARN suggestion. Let's not add any WARN to avoid
triggering panic_on_warn.

