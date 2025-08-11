Return-Path: <bpf+bounces-65399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6A5B2183E
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 00:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A024D1A22B20
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F212E5B34;
	Mon, 11 Aug 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7c98SqJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FBE2DBF47
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950698; cv=none; b=IY1pRuwPwrbafcDsEBAsIm21gq5dr1xSQySKmZpWxzDuqlE6W2TN+K8wK3VexR/ZOPvOQhtQN9KDKU5GYnFyQjfjFe8LSiPlrLne4bD5/XScMlod/W7cwpBLaoegXReWTWfZFt6Yu+MmHTKTvR8wwbcZbUEZS6ij7WP+E2ZUygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950698; c=relaxed/simple;
	bh=AwbGPzNmPVary/J6WIksxD7TIbFp54DCEPmfitu2QsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH/fuuWTpO3ozATNQcvxNLs8Ie4tjuWfURhFSMo9KsMIhZImHBrMR8VbbSoitISYPW8zuLodk9D/cpmhtAea+SHWGn1/TQA3hC9q65UA11YthKSB7fn4tr7zD1CNKcmXNm4BZFRBiNFk0bTqdtpAbJVYW+kBfkM8e42K7qhOLlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7c98SqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EF0C4CEF6
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 22:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754950697;
	bh=AwbGPzNmPVary/J6WIksxD7TIbFp54DCEPmfitu2QsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N7c98SqJz39enRf6Gnq2xH8SEJWkOJ5RdrfhRyu4qxBm6+BOMpuD3mPlGvMhPUdhT
	 5wsD2jOz6ZKdJJueqsn2mNv62Rg+5lbywtNMe6JFQPuZKg/J5de4tAJcjSTcOpW845
	 I0Tx8uCI9FkyRyWcSJ/f7/mNmLgKZ/SCZ0rTC0UTyFd+F8fdzSGli3w27Bzol9yMPE
	 Q9noPRoEdY+6/b+Xd8RuTw9onmOu+f+gJq8DfmLCyLXQwbmtLVPFo075pDqDt5dvtF
	 osGB2IIKsLZAfGKJlDYufgeXEJYVJZwTRAaYGQw8x59X5D5oUr53F2vuB0sqNYVUjd
	 KlaeVW+Lqh8uQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so5855962a12.1
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 15:18:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YzPrDnnSK5KVRWSUWdaatjNk6rgWHH5FH8VVfCJEVo1fm/1QZgN
	2f0jDKw0ZVSrbi4sR3Wt7NQq4Xz0KNHVEmN9gcR2lDsZ8OD+aAPmo/uz1QuK9lE+WSPSreBSxvw
	gPVCIeKJETCw6wX7ns0Dw6uPb3WfIRpYHzp4aeuQP
X-Google-Smtp-Source: AGHT+IGxEOUErs45f9i192mdKIA62vfUhxTEw7FwSHJfH2LtzH12m9XGbkQCFPu20+bdBssNq4CMoIqkcAKHbidY5A4=
X-Received: by 2002:a05:6402:5246:b0:618:30f3:1d7d with SMTP id
 4fb4d7f45d1cf-6184ea28edamr758767a12.2.1754950696469; Mon, 11 Aug 2025
 15:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-5-kpsingh@kernel.org>
 <CAADnVQJ=8Y_k=JtbNQuhTTCJn33iAniAEh6MLN1BfTZ6pmP=WA@mail.gmail.com>
In-Reply-To: <CAADnVQJ=8Y_k=JtbNQuhTTCJn33iAniAEh6MLN1BfTZ6pmP=WA@mail.gmail.com>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 12 Aug 2025 00:18:05 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5kCZ6Wy7J3oWpAGBO61adf5+oy-1Ay7TEifyp75LbSRA@mail.gmail.com>
X-Gm-Features: Ac12FXxPEr7GuGFOSuuMZBu8hJQ_1aUCiKIKmCwNxV7tEA7e__L_wPOBvTdFzRM
Message-ID: <CACYkzJ5kCZ6Wy7J3oWpAGBO61adf5+oy-1Ay7TEifyp75LbSRA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] libbpf: Support exclusive map creation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 4:25=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 21, 2025 at 2:20=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> >
> >
> > +/**
> > + * @brief **bpf_map__get_exclusive_program()** returns the exclusive p=
rogram
> > + * that is registered with the map (if any).
> > + * @param map BPF map to which the exclusive program is registered.
> > + * @return the registered exclusive program.
> > + */
> > +LIBBPF_API struct bpf_program *bpf_map__get_exclusive_program(struct b=
pf_map *map);
>
> I couldn't find patches where it's used.
> Do we actually need it?

Andrii asked me to add the getter along with the setter in:

http://lore.kernel.org/bpf/CAEf4BzZghpnHaV+z2GYDNCApzLuxMW6_=3D4afgpO+D7AG-=
zTSFQ@mail.gmail.com/

