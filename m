Return-Path: <bpf+bounces-76755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5CFCC5073
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 006BA303E02D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62E335553;
	Tue, 16 Dec 2025 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYSsXfcS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5A21C16E
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914142; cv=none; b=cxmYl+f2BLSIAzTuERjILrviuL+53wqz0yyvGW6PBVeB9IgnERNp/gNIDPBk8JistTYotKZ2PP85angqrZJrYceB8KLy2pd3nMiICvHCkoJjHgtPSa47h8yvHGAslhAehEjMg7tpfNFhWcLT9UqE162u36v+Lqzt0KjrxyLqIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914142; c=relaxed/simple;
	bh=cPtVNdPqXhwb/Q61nikUx5gAAtgCWlW7FY4jBpvK3Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crrJejYjkQlkhoYn1bI1XqW8kXX83VchLGGvpCRzpgKlxRU5ZtN/jWrhTEYO/GN71F0d6z+OmQe/WQZpcHWz38mguUhAm4DBIpLoFcXEdMevzFXWcX4S5AQyxl/T0thbLFeMdAqMrJe983l2HIBstnIDHUXK75iokTVgA996iik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYSsXfcS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c902f6845so3346818a91.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765914141; x=1766518941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCycMNbAuRdUgNR9UQ9PT1pwvNkgPkRBMbrhGTTXgas=;
        b=DYSsXfcSGdCszmTusJnAgIadaHzqUxgaHrc8h/jA6/Zz12/uocm/SCJsaLxPg+Ujc9
         VshCLngGPAD5m3951+9t31JYxH4XhwBA80XKL6WdxeVwA48vjMYluxq1zNSIZtPE8bOk
         4aqXpNXHUB3whJO+CKBi1j4HS2U/5CK0dkk/0Zx0p1G4ed10pQHadZT7HXERyHQhVBYs
         zNJyzlbmMNXdo3iPGIXkhRk06nYnQsydzWjHIQ75CPV1xV8fp9QxRAIR8FbDlZPp7Nsm
         ViXZz5t0zqChYSSukjogwnw2s4bg3HZwGbcydTrHBDDFzDg49U95Frmbq2ldIZLRNK3j
         +88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765914141; x=1766518941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCycMNbAuRdUgNR9UQ9PT1pwvNkgPkRBMbrhGTTXgas=;
        b=jM6rxkvSuKeJlB51+14cNzByAR/c0Gu/WlhvhJmMK0QhYIZofTUcHuOLjdL/QL8CKs
         B4vPi2YaKdm/orXUJ5lkbZt1bHIWEyTI62yoDKH/a3wbKJnM3hmgMewOEzbkgphvbEDI
         ntuhjZK1DUNxmKKN5+F7XjtzM1yceS+6BQz9PjWwY+BJucyFCPN5DhefgeumrRe+Xs0V
         GVyQpDL8S/7oJSeNbY4V6PGLeETCOUrZSpJNF/Owyvixdx0Ej61FpmtQ98LOUC5zpnsh
         cMe9FdGNkbmhPhYSf20weIPNBEZqBBcmjY4fkoFlTjZnKgNa2SVtveHz3FFfiEsXBFZQ
         rlmA==
X-Forwarded-Encrypted: i=1; AJvYcCXufLV1qJwuEDCv5TiM1Cd80dDjSO3F3J46bENoXUL1LcYJ24QyLFwHE3bj/Yr1Zl2ubJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW1hpgZGSoesQhbDpDLI7697+gHOnU0yDsrCREV0h96VJYxlG8
	8udwner9aifGV6ZRwU6y2K5UXmi7gNG0xy976ntSzSCHP3dsXLaldiDl9+BuHfF0q/X++kRqw8V
	ww11ZXpG8KrMXO7Ax7H1wfvZpNwu91RU=
X-Gm-Gg: AY/fxX7oH2YMhSQGRuuSkRshhmF4zY49B/1xm3QKiSsRcQlILj/9eUozXfRszOezA9i
	uw4Oo6lpx+PvFR4V9spXUY3gSEhestCCuZPoFQkMdqmMMV9ilBk1UAzjx1NHxcR7AaAk1v67g9M
	3+I40saQtLcPoimAjF4iV0Rma2baiiVB8P9gzwM/CJS39Hl8cnoON+5g+PIyZtP2UdKHpLURuo1
	r255iwKR1KPJeBm+fmNwsbhZA+QR273xrY6+wn1Esh8KBEzLAGSCy+l5ZnEeF9yqCX9sPASu7y9
	x6ne0a+ddtA=
X-Google-Smtp-Source: AGHT+IE98HH0sWGsmopHfn4Wqrnlr/3yWGvDmuci4U7bHyqeK/QS1/DmGsAQb3YlYpIvEyViguYX7plMu8rgcwClHpI=
X-Received: by 2002:a17:90b:5288:b0:343:5f43:933e with SMTP id
 98e67ed59e1d1-34abd78fcaemr14689282a91.19.1765914140761; Tue, 16 Dec 2025
 11:42:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-4-alan.maguire@oracle.com> <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
 <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com>
In-Reply-To: <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 11:42:08 -0800
X-Gm-Features: AQt7F2q6bGbgechN4dE6mcUeWwI2OIHgB9P0SBNUoJx5rCXpn36_EFvq4jBFUc8
Message-ID: <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 7:00=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 16/12/2025 06:07, Eduard Zingerman wrote:
> > On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> >
> > [...]
> >
> >> @@ -395,8 +416,7 @@ static int btf_type_size(const struct btf_type *t)
> >>      case BTF_KIND_DECL_TAG:
> >>              return base_size + sizeof(struct btf_decl_tag);
> >>      default:
> >> -            pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
> >> -            return -EINVAL;
> >> +            return btf_type_size_unknown(btf, t);
> >>      }
> >>  }
> >>
> >
> > That's a matter of personal preference, of-course, but it seems to me
> > that using `kind_layouts` table from your next patch for size
> > computation for all kinds would be a bit more elegant.
> >
> > Also, a question, should BTF validation check sizes for known kinds
> > and reject kind layout sections if those sizes differ from expected?
> >
>
> yeah, I'd say we'd need your second suggestion for the first to be safe,
> and it seems worthwhile doing both I think. Thanks!

... but we will just blindly trust layout for unknown kinds, though?
So it's a bit inconsistent. I'd say let's keep it simple and don't
overdo the checking? btf_sanity_check() will validate that all known
kinds are well-formed, isn't that sufficient to ensure that subsequent
use of BTF data in libbpf won't crash? If some tool generated a subtly
invalid layout section which otherwise preserves BTF data
correctness... I don't know, this seems fine. The goal of sanity
checking is just to prevent more checks in all different places that
will subsequently rely on IDs being valid, and stuff like that. If
layout info is wrong for known kinds, so be it, we are not using that
information anyways.

>
> > [...]
>

