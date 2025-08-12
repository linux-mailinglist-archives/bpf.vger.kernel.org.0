Return-Path: <bpf+bounces-65456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9293B23B57
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 23:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A25A6E5A6D
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 21:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18652D9ECF;
	Tue, 12 Aug 2025 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUnSU3IO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB72626E15D;
	Tue, 12 Aug 2025 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035741; cv=none; b=Ue7N4d9RCXLqRFQPIzvXEopNHRF6sIswm/9mmFYaktTympBe4VwLiLu39uZ85Lv2ctYxm33CQMAYRTp4CXOMH/UvSDGyQhn80FQobd7ar6REQTggR+d/Mfptmr2dy95ZFz8MaudvMZfX6mISTYOwhWOmVfnnE4MqlkLoIg3YxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035741; c=relaxed/simple;
	bh=vlPefp1oJsAKGAOojGDRq6vH3BmPpc0aY3nMS24jLyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByTLX5v+NvBlCS/I44JasbdoFuWpDN7h0X2vPaYj8GmWvS8Tq3Sx5Q3rDwnzECqzdWgUg0ixVl0P14EIJ75dP0GQtPCCaHamt1jeKwP112rCyjqwEEEWHQb3sPuyU5MSRV3kcnC9CUMaGG20X3+BMZuiMkA5ez6Q7j/Ykr4Bhxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUnSU3IO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31f017262d9so4777969a91.1;
        Tue, 12 Aug 2025 14:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755035737; x=1755640537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0a3A0bYbvr9lrCrhrUFhqF9xvhHYsqGk1nSj17rg8s=;
        b=GUnSU3IOXFeZjhrIlVHBdPQfw4KaWQ8WZMpcvn1RmJ8XNjwNkAhSaw/XEDfvCsDBT/
         o0US7YQuYWcqtdowrAGkyod3JLi1y/VCAsy1w8sJN54Cl5cgALAgybgu/FLelU1x3798
         HUXYmisRgspNKmvXr/+rf+6bCXCqMpvteoJkY0ynuoW3sdGV0+cztrEUiqUhy90wdcRC
         90MfeaV8Id3ADSQDXe4Dp7UKPyQDtVH45nAHMOQvoy1zDD7DOYAw+8mAve/cz36VOPfB
         YsVabwRWcJcA3fKAkdEYBKotry1DqMMyUp+HNDo01rKjm2yUM3TJpzaZmRHj9o4GYVsL
         G+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035737; x=1755640537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0a3A0bYbvr9lrCrhrUFhqF9xvhHYsqGk1nSj17rg8s=;
        b=NUChDNoo7ekJhQzeRtv4/3nxQXEJp8UP7s2rZk4qlWpX+5yp1adlR/21a8lB7mPK/P
         nvLPzkD5WPNOzvE3ZSfiIcrU6JB6+a+JH+Tx89tefeWEv2T7FU9IFoM6VpvlybhDALkY
         7D6XzDFZWP4h1Cw/14JG8OZRGafxTa2IkZxz9QwSpjJPaAdKXrCasjsPXLaVE4GwxdVJ
         +tyD5RlqceVLFBr8fg4FrVvu/yYrUEqw0SOVuHnX0ftQrp6R6WEYK8fxi28Xh8rYNBAU
         f6b6dXCqD+SfvK9dMpH12FxgaJmYfqrUKp73y+TRvkNUmVUb5JHuY7c/m+TCOcpkFnqi
         5RBA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Duz1BSa/fChGckVcEBqkZLOsynm8httgaL4NsGdHetMDfeN3BOx3Na81zqGyaXODUzlQj+HBORM=@vger.kernel.org, AJvYcCWjtlQQGmBL+fuIaqkq/C4bGzV0IZ/p7GuXs5o5cH+ug2lQS1kDEcNdij9oNJ4Xbo6rUYtM+acGnQOEvI7e@vger.kernel.org, AJvYcCXu1Ap9pNHv3blToqUSkeOvVFdcPomUNypcBfmLGMDzZk/N1uK/tuHeZ2941sKzwAusDgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTej5zISjdXZ5MSA323TZ+kmNtBEy0iFtGwbLt6rvHIWoSW2oE
	uk1JRwvWdgE1HhJDtJQDBEKi2auQVBrRSAY1Cl3hRGeBWWs1OErCCsul6w106v3ddASltuDuEZa
	orhZki7pOmrS5fhj49QE5Gd+0LeLFBE2A6w==
X-Gm-Gg: ASbGncs6+d5J00/iYQutanCOKHsXfz1R1H8+8mCKMZWNY1JH+YrBXWFZQlju0Smbvfm
	bspRw6YO1ZsIOiQSTP2fuGtONandpxfYdkKEFcZRWlUbZz8CunEmY7yshjgDW9Qw+dJbcQzlWMo
	YqghpGAk9frvK1hi7G3yGysJ8X3CW0wkIEFRR+RrMMEJVm576GQFppX1nABgde/Eu/Ai3gwII9x
	e6SQCsrY9b6BNUOOt13+WNdYK6Va0Havw==
X-Google-Smtp-Source: AGHT+IFaPXMEYoH/8Y9uBZvh0p6g9dH3lnj9wGZ7dtr40iitEllxWZXunkd+SEwcDZfkFJXnJu5CYYiF2lxSt5D88vU=
X-Received: by 2002:a17:90b:3c4c:b0:311:c5d9:2c70 with SMTP id
 98e67ed59e1d1-321d0dad433mr834251a91.15.1755035736863; Tue, 12 Aug 2025
 14:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606214840.3165754-1-andrii@kernel.org> <CANiq72kDA3MPpjMzX+LutOoLgKqm9uz8xAT_-iBzhR3pFC+L_Q@mail.gmail.com>
 <CAEf4BzZDkkjRxp4rL7mMvjEOiwb_jhQLP2Y2YgyUO=O-FksDiQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZDkkjRxp4rL7mMvjEOiwb_jhQLP2Y2YgyUO=O-FksDiQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Aug 2025 14:55:22 -0700
X-Gm-Features: Ac12FXz9QwA7PXP_msQVt6NhM-rD51DduktihmN0bHfoNoTRNMAHnFaoRjTBdEg
Message-ID: <CAEf4BzbJpTZ9P-Deo7Oeikyd3vW953goAw3gYvTPzvDfEWj2hw@mail.gmail.com>
Subject: Re: [PATCH v2] .gitignore: ignore compile_commands.json globally
To: masahiroy@kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, ojeda@kernel.org, nathan@kernel.org, 
	bpf@vger.kernel.org, kernel-team@meta.com, linux-pm@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 1:28=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Jun 7, 2025 at 2:27=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Fri, Jun 6, 2025 at 11:48=E2=80=AFPM Andrii Nakryiko <andrii@kernel.=
org> wrote:
> > >
> > > compile_commands.json can be used with clangd to enable language serv=
er
> > > protocol-based assistance. For kernel itself this can be built with
> > > scripts/gen_compile_commands.py, but other projects (e.g., libbpf, or
> > > BPF selftests) can benefit from their own compilation database file,
> > > which can be generated successfully using external tools, like bear [=
0].
> > >
> > > So, instead of adding compile_commands.json to .gitignore in respecti=
ve
> > > individual projects, let's just ignore it globally anywhere in Linux =
repo.
> > >
> > > While at it, remove exactly such a local .gitignore rule under
> > > tools/power/cpupower.
> > >
> > >   [0] https://github.com/rizsotto/Bear
> > >
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >
> > Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> >
>
> Masahiro,
>
> Would you be able to pick this up? Or where should we route this
> through, in your opinion? Thanks!
>

Seems like this has fallen through the cracks... I guess we can take
it through the bpf-next tree, if there is no better home for this?

> > Thanks!
> >
> > Cheers,
> > Miguel

