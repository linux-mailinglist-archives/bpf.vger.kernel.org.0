Return-Path: <bpf+bounces-39879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A39978C77
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 03:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBC81C25427
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 01:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEF39450;
	Sat, 14 Sep 2024 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2TVcyaP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1390E138E;
	Sat, 14 Sep 2024 01:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726278750; cv=none; b=iuKYSZRIw+HEmj4bYEFo0OZt91gP4qogxJVS5a5zfdf+wh+YZhesBSQsdYWpiWA4e4lGBzzjvI6bN3xtaWtxH8CMycqaQ5sPAv19XgdweIaS7mceOsyv6lYfFx9nbOa5tq+XxHUj86YHRaUJRy5J+uOxmvdoda6UxwwpVBv2RT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726278750; c=relaxed/simple;
	bh=3lYHPUFNPVO3EH5x9/6hnIUD3ddA0HbpprKzvp5MpzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOJJSOjHKt71K6WAz3QhrS58NFl76Y2e1htn0Cq9VuLTGJ2X91DjOOBK8+1unR9KNW9DqJi/QFKumqQkEtTKbLXdEABK97He2H6T2sPqclbZpuoBL1KFa86cuCLfy3jF03+3sylFc4JRolW93kAiT2mATx9vJ/Z4AKleZyyCd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2TVcyaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD78C4CEC5;
	Sat, 14 Sep 2024 01:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726278749;
	bh=3lYHPUFNPVO3EH5x9/6hnIUD3ddA0HbpprKzvp5MpzQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V2TVcyaPg9D6OETpnlTM7pyF4CV14WhcbPohhRMss0nEZhTkyb39GbWiEiigCnueO
	 0LcuXjALHrzgNHgMROLY3Z0+PU8DIxQuGb9E1/FXVvnzH3crzddlnYFyvhZanYFbFN
	 ALbUVbLwlTlKbVPieDGU1NE7M2WYGn2ksmiaAlWgU8IddgJd8s+KN3lVir4JWRcOcY
	 Kd5z+BRsrFEyIUxca+I70eu5EwANJuAUmQLzmjnTj3N7CcTIlpWNxiLlf6v68SdwiF
	 /AAbKta2679+i9ZpieJa2LupkvAR4t1A6B03IPHPLIrduAsjj0DLFdZYOTwiKP66X2
	 MJVyezifQnmhA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365c512b00so3511835e87.3;
        Fri, 13 Sep 2024 18:52:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUM2sTwdNWWVlom8u6F+ZccXEaU5g0mKaiEUJMk5REZP2D0DPRkfgpSr4Gwp1XyX+dgHkM=@vger.kernel.org, AJvYcCV0i7W5plC6h669DxlwcQSzuuiGt3zgnhAw/l/tqui0PlgtNpqnXiyp6gkdHa+cX9w51q60hD4tdJ/5UFZ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+n6zemked18b7oLgfngoMDy9s2qVhEe5SqwGGgtbCv/n8toiT
	jDdklRup+3c40HiSPj3sDufGtuIVopEBXejb+AnEDnBHRk0+ZF3etSHIvAa6RUI0LjrIzzCYsgZ
	CYqSSQu/S3uDjQNi4Tir7aG5ltKo=
X-Google-Smtp-Source: AGHT+IFVSvkiObq+ygXX7QoZ5nmqHIpSZAR+IGn8/e9mnzefRkOopHwGW7ldU8TW1Vuv07llP6ZjNpWDdsXAVqDHldw=
X-Received: by 2002:ac2:4c41:0:b0:52e:f58b:65ee with SMTP id
 2adb3069b0e04-53678ff48ebmr5431290e87.57.1726278748492; Fri, 13 Sep 2024
 18:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913173759.1316390-1-masahiroy@kernel.org> <CAEf4Bzawf_EgHyHB+-=2U6eyJtBDVHVQ+Nx1JFw+TTbNSqSmuA@mail.gmail.com>
In-Reply-To: <CAEf4Bzawf_EgHyHB+-=2U6eyJtBDVHVQ+Nx1JFw+TTbNSqSmuA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 14 Sep 2024 10:51:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATurz9J-w+Vbc4FJ+r2Pov028+G+q8SrF12GjjZb1irtQ@mail.gmail.com>
Message-ID: <CAK7LNATurz9J-w+Vbc4FJ+r2Pov028+G+q8SrF12GjjZb1irtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] btf: remove redundant CONFIG_BPF test in scripts/link-vmlinux.sh
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 14, 2024 at 7:26=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 13, 2024 at 10:38=E2=80=AFAM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > CONFIG_DEBUG_INFO_BTF depends on CONFIG_BPF_SYSCALL, which in turn
> > selects CONFIG_BPF.
> >
> > When CONFIG_DEBUG_INFO_BTF=3Dy, CONFIG_BPF=3Dy is always met.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >
>
> Masahiro,
>
> Are you planning to take this through your tree, or you'd prefer us
> routing it through bpf-next?

Hi,

If possible, could you apply it to bpf-next
for the upcoming MW?







--=20
Best Regards
Masahiro Yamada

