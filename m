Return-Path: <bpf+bounces-71141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA00BE514A
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EA51A6705D
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F3D2356C9;
	Thu, 16 Oct 2025 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7RkPGwX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E9262A6
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639981; cv=none; b=OmEFV4dPG04GoSiJIRGpFY+N5StFK8ltpTwPp8C53ouI85ImkKiIGVwo6In7oWKyAOavwlv5337Vq2hOiprJ9sE6qOLooJkbSDs8+M3gdeLB1cHiMa1re2u8yVI4apMUd2oLcLwEpTm6U8mCqNQbF7WtJok1xXxwKot9bvHpk0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639981; c=relaxed/simple;
	bh=QRhqvZsPHSyIbZizAkea/pLrLeCYDtxSLVQMM6cujG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1/Rd+0aNSly4Mdw8kvyupunRrckkomL6BbtZBdmhOZ3GQDiqk58xXdqgxjwGCpABrtJUE7NhjrZanACJ7c7I5s6YJW5M5NdwYqEkpX9IsfVHhOUpSGscDWcru9oY16SdpGl0AVGZwtjDp7m/zrIHsb8QR8LWTQGt8YTWjYNXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7RkPGwX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33b9df47d7dso1527240a91.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639979; x=1761244779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4S6Msi8IqXtWhPntVGALSKa4i/sNrY03hHQ7TfNOwI=;
        b=S7RkPGwXlNXRph97BL4z0DkmTWBpZZ740A64otB+IfxEAawhAz6pRhR2YrCnMRiI4P
         xgKrzF8wnTLI7qIdQK5MvOInkk02E4QazjwbEYG8hB9ngwkm/fwJ/YfgG45xAqjl5ZEH
         XgupZ+O4Au7qtR/3JcT0Ucz/jHfqI6vLw3CMI1DFS5vCsDvQEKtUu9/Se/RFCYXen5HV
         3MIYnEdJfCbrdwkv/XUFOiBBMZtEXUus8Fjg+bSJNNnxUoD8p1+vLlFxCsaHhuRn0RPl
         /oGAchyTW5XuIg2fwqo/8xuz1r3xjfjJsMbXrCsjuYOpayuJ0i4v0754FKQD9RDDw9pS
         xzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639979; x=1761244779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4S6Msi8IqXtWhPntVGALSKa4i/sNrY03hHQ7TfNOwI=;
        b=hSoUHjeeZnaNs58Xm0CxDdzRSLu03ooi+DsDU3eePmQDISVpfY23Mp5Bc27avegk0P
         b9qepUQYEvrmqn/1zSNjc3ZBUXd4np9KFK5JIsCVehwSsGHo0wklS8iDI9uOE2PF6/5u
         c0PXbI4C1PIRPuNxTF3oq45oRhOP/TIrmir9bhYfFXs1NbA6bIwdSDlNXxWXj8VO2poz
         J8WLGMQuQ9uYp3deuMDek7MPFJiuPShKRdG2JpWbQVS2emMFcKtRoM/YHQ8vLRZfDAP+
         UXI6MhW82ODn/a4F4bCXI/qeJ5CwfdVr55XpDBfYjblUP35Nc0+PezDFkMJ3eUouAUwx
         nKQg==
X-Forwarded-Encrypted: i=1; AJvYcCVd0Ih3DspJZpzvhrlIy1iuakPdY6Uw65TpnyqExj7HeGf2HAfG2HH71vRokV0/DgIV+x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/xMKmG7ZPKFF28+XGOcHMXomqMW5tUZB1AJkuVYcVw0LIkmBJ
	DSRmwXemaehR9AyyJZ/GsQnr/ieDN2OzQA4OxrBf2tXXrZqFjtG8YrHSI5dR83tvRSNyAKg/eXJ
	rSG6px6e/HPjHp25r6F1Vs+GIe1mcFgPSHw==
X-Gm-Gg: ASbGncvvCrI05ViGvqcVp0cdp2eOA/Jbki6Nn8FoCW2Q+XApjSGsAlv+1tpXH6hcHaJ
	X6CHV7Mp/0VEaZTYGeaGNtPHY7k4zdQzbRgHgzhPlGNNZKiVxLVvAxr+39n9ELW+NiBF/I6uMCh
	aFK8Sdqb8RLI5YTGlZ0vSR9HG12Mr6xjMizDFeTOoTh60NlbVo7PiX6PiKDCorGpOpTE+yDMXdG
	8hwz2+R+tg88NrSDZpAZx+3U62Lam+RnQeyqeRPCEeNtQkqNltEPPBF+lmOMF1mWwJqsoUK/rNu
X-Google-Smtp-Source: AGHT+IELR2ktuwxHhZzA0l9WVW4/r2tawqmznML5o3EJ01Xkz+XEdmEqKeDeogqPLdQkrkGy3hpyJtBCYHI+FQrq8Zo=
X-Received: by 2002:a17:90b:4ccd:b0:339:ec9c:b26d with SMTP id
 98e67ed59e1d1-33bcf85d2b6mr986405a91.8.1760639979473; Thu, 16 Oct 2025
 11:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com> <20251008173512.731801-4-alan.maguire@oracle.com>
In-Reply-To: <20251008173512.731801-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Oct 2025 11:39:24 -0700
X-Gm-Features: AS18NWC-v18J31pRGKSph5YZUSo8VP7gY86AyWT9Zkllj3BTm0CLEqH6HOTdCAg
Message-ID: <CAEf4BzZHS8w8On8W2Ez-r+pmdurw+w=4Yo2bA0fxeYhKhqE7bA@mail.gmail.com>
Subject: Re: [RFC bpf-next 03/15] libbpf: Add option to retrieve map from
 old->new ids from btf__dedup()
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 10:35=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> When creating split BTF for the .BTF.extra section to record location
> information, we need to add function prototypes that refer to base BTF
> (vmlinux) types.  However since .BTF.extra is split BTF we have a
> problem; since collecting those type ids for the parameters, the base
> vmlinux BTF has been deduplicated so the type ids are stale.  As a
> result it is valuable to be able to access the map from old->new type
> ids that is constructed as part of deduplication.  This allows us to
> update the out-of-date type ids in the FUNC_PROTOs.
>
> In order to pass the map back, we need to fill out all of the hypot
> map mappings; as an optimization normal dedup only computes type id
> mappings needed in existing BTF type id references.

I probably should look at pahole patches to find out myself, but I'm
going to be lazy here. ;) Wouldn't you want to generate .BTF.extra
after base BTF was generated and deduped? Or is it too inconvenient?
Can you please elaborate a bit with more info?

>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/btf.h |  5 ++++-
>  2 files changed, 38 insertions(+), 2 deletions(-)
>

[...]

