Return-Path: <bpf+bounces-11505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C587BAF53
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id D57C4B209DA
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 23:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55AB43ABB;
	Thu,  5 Oct 2023 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwgKfqU5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126DD42BFF
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754DCC433CB
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 23:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696548657;
	bh=/IKGuVn44zln+z6P+rC2zzkGCZPVteXeViC0CIbqzpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bwgKfqU5zXLBbVN6T5Vj1XaHIQEFql499RGT4b1nqvJQVBi9ixGSUSLTceLkOrQxx
	 b/1vWwgD8c56yzyw+6r3C+ofqykt5sRsz/UX+Q/9ZQ8O9ujC/T27EWX+X2bIGv4lKN
	 MM4+r0AOfCzSOH/89ztbwFKI0S7s+t5bb+gQw3690ODIuzqCzFTCF17Yz5VgHTeVBD
	 hHOss9aDbur8gF2w7A72HknJLO167XWEKtrYZwJDZqB61NqB3h4jNmlV0SX//INUpx
	 oKCBwfWiJoTlG07Kz+s5GMuKOruI0eieNbLyKBnO6mqflUALrbrFJ9+0lLbJMK/b7E
	 7GiZM90CsevCA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9b64b98656bso273824066b.0
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 16:30:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YwMaOD0j8AOoEoy9vpDh3CEM08xSqv594EHEw7LKHsL5MfNTKyK
	yxuH8Hae3ICwjXl9liC9Lqb8ohOVHhN5fOO0eRnmaA==
X-Google-Smtp-Source: AGHT+IFuTAe9XP7yMORVUahponL1/YZn0xIGwYZbj5xLWPKNrMYsdeH3TKLmPyOUMxrMNq7CPSwcD98BGn1VYmRclV4=
X-Received: by 2002:a17:906:144:b0:9b6:5811:d990 with SMTP id
 4-20020a170906014400b009b65811d990mr5301696ejh.47.1696548655930; Thu, 05 Oct
 2023 16:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005084123.1338-1-laoar.shao@gmail.com> <CAPhsuW70-kKGT1RQRGYG0b6zixKTzaU_-SUfvhhrwO3y_WZcBw@mail.gmail.com>
In-Reply-To: <CAPhsuW70-kKGT1RQRGYG0b6zixKTzaU_-SUfvhhrwO3y_WZcBw@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Fri, 6 Oct 2023 01:30:45 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Yq4QXnosqVTAtfqssUiG_+rsHouy=-iwTOZd5oEXgBg@mail.gmail.com>
Message-ID: <CACYkzJ7Yq4QXnosqVTAtfqssUiG_+rsHouy=-iwTOZd5oEXgBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Inherit system settings for CPU security mitigations
To: Song Liu <song@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	yonghong.song@linux.dev, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, Luis Gerhorst <gerhorst@cs.fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 5, 2023 at 8:02=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Thu, Oct 5, 2023 at 1:41=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Currently, there exists a system-wide setting related to CPU security
> > mitigations, denoted as 'mitigations=3D'. When set to 'mitigations=3Dof=
f', it
> > deactivates all optional CPU mitigations. Therefore, if we implement a
> > system-wide 'mitigations=3Doff' setting, it should inherently bypass Sp=
ectre
> > v1 and Spectre v4 in the BPF subsystem.
> >
> > Please note that there is also a 'nospectre_v1' setting on x86 and ppc
> > architectures, though it is not currently exported. For the time being,
> > let's disregard it.
> >
> > This idea emerged during our discussion about potential Spectre v1 atta=
cks
> > with Luis[1].
> >
> > [1]. https://lore.kernel.org/bpf/b4fc15f7-b204-767e-ebb9-fdb4233961fb@i=
ogearbox.net/
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Luis Gerhorst <gerhorst@cs.fau.de>
>
> Acked-by: Song Liu <song@kernel.org>
>

Acked-by: KP Singh <kpsingh@kernel.org>

