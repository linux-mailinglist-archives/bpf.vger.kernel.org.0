Return-Path: <bpf+bounces-71966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F6C03357
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 21:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F205E3A85A4
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 19:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB08334D91E;
	Thu, 23 Oct 2025 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGiw1PLt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1E30E0F9
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761248413; cv=none; b=mww/zircw7/IrkYUIXlM18bkKgCRdqWvVLF/EAkg0l22czKFqrN4wPakRAEtIE2S1oishget4kW2qJAq9YHFKktDepooT/U2rVu6wrnBru9+xi+BdJl4Xh6b0p2LVCgNxpA0iWb89IJVXt/QJLJ7kE5he5LlUr//0JPydgKakOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761248413; c=relaxed/simple;
	bh=LVSTUEbnkLIAzj9Vx2EvlgOAnsoNEFWZI7Re6Fq/m9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agYyP/tdUJZSMIWtDK80ew06EXwYrNAbUYA54Vz9VjXxAjiBDrgmHwa1TjL/SJQdiitx/ILOT1m9KDFgAx5YHHsPT6ulLG0VFaRfFEfdP/oea3tnm/e7QyXjW1nobRMVgVbKYtnLZjjyvWewT7ukSUx+wAYfZnYvFNCXFx7lOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGiw1PLt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27ee41e0798so16288035ad.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761248411; x=1761853211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVSTUEbnkLIAzj9Vx2EvlgOAnsoNEFWZI7Re6Fq/m9U=;
        b=MGiw1PLt2FiiYONIpQvOVqvLQuIVbbJQ6q1IXmfj09Sga9l/64PLynicJmhPrehJM4
         CKqEIp19MJbpvwFyM00phSeggso+QJuSZ4vs8bBhAKU156viYEnMIJrTxRZX/7oxKAgh
         fLneuqe4Uvx4M9wOL/Hv1AtDrhYfd1jlCF24KQXAvbnDk6PrRQNjbuNnSLzYxZiHNnXr
         AjWN+i6qh5riSdqJgqpisV5OwF0h/g9vxZwOsd6CfD3Q7ys4CW/G5BOpu4cB1lJu+zNw
         6/K3wTQpS6LcPTyZqLCP4oTlLuDGSYSTxRRWVaCRE6pNAbdDCLJmEYmPlYfhE/XlyBaC
         Mu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761248411; x=1761853211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVSTUEbnkLIAzj9Vx2EvlgOAnsoNEFWZI7Re6Fq/m9U=;
        b=JWgTgzRLIpadfAluqqO2ShKo9kMRaVpRTKLlKc13/Xw7mgG0L7Yu5JhtLkwuLfsh4H
         idQMY9vnihm82fP6frsW41do1MQo89IxehIbc32IqbXlootNtvQRBVkB7bXoF2ZHMLue
         vslZ7aLsAtqwbYKcSnZuy0iEiMzriOOyciculMyL4R1fGTsun/nkiq4xglW/QzGcbN+L
         aaRzNE//9NA2mBbEaVbeFx70BuhKf2WT3+uXK1PCclZUqIUUlwfYZAXssRK/HoU4TXee
         h3+svz31gkLreqxSkGS6S0nl8G4HP3dIw+qBN6rtL73RHb201tEme3qRXMXFRYxcxQHu
         spLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs+nZFlsgqIdS4azF1h0wlrCilomGeD2pY0Ghx54uWmbyhJSRPLEHuo+aXbbH02moxeZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6YQZoQlkorDNYywMki6itzG8Pc64ncZbrsROSMtfdasqE1Y3
	msGdZIaJ/fE7vP8qWhTbpx7gCbXkCsGng7WUakSD+oAJIAM9doIUXsUm8Fq2+r8maLFbwL3vjnk
	1HVd86mxZqhIZA08HNoz/oRoFBFbTWIE=
X-Gm-Gg: ASbGnctBHhbk3owgCFHnPtE9wdWqdQ1gaKDLJdWiSTWLRAqbGV/i0pG/zRx8RyUP4iG
	1ThPSn2yj9VZxEhVowPrIo9t/JNrGO6lRPne1ILukJAyccK5QAz7gdaqsslpco43cbQaP+mba8t
	KJ58NaQEQ2jnwjL/W74AEeSHYH5oIlSlft7Zk5H/mmadvHKgzfGgE5o1XcSuPBDwMPGQPLxZO2t
	+V6CUQHflcVedbVXqCPZ5hsQXKCgxJ14xfWS/brykmU2X9MDDwOMJBgsTK3bKjSEPLm9tOqSOt6
	rfGTqhdAzzE=
X-Google-Smtp-Source: AGHT+IEhuZTV8ezLGcrth8HESSqDZMBIJHnHiqqsyIHltjqbCmhOwj0sR/LSVQ/PCaZxbA7uEuZRcIOOcvol27U+RHg=
X-Received: by 2002:a17:903:1a0e:b0:26a:23c7:68da with SMTP id
 d9443c01a7336-290ca02353emr310880525ad.25.1761248411250; Thu, 23 Oct 2025
 12:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
 <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
 <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
 <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com>
 <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com> <CAADnVQJG_tK18oxmjW37cbrxF2zPKPk_dvqXUTnOjUue7J0tLQ@mail.gmail.com>
In-Reply-To: <CAADnVQJG_tK18oxmjW37cbrxF2zPKPk_dvqXUTnOjUue7J0tLQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Oct 2025 12:39:57 -0700
X-Gm-Features: AS18NWCi5yLjTclZEFhU1VH8SOuBSBCDx6iFebw-WC4t6DXqtoN0O0_X7B7k0LM
Message-ID: <CAEf4BzYLyi6=Fyz9ziOAwkFOjUPyJmTj4c6g247XBwgwJ8m-qw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:37=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 23, 2025 at 9:28=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> >
> > Speaking of flags, though. I think adding BTF_F_SORTED flag to
> > btf_header->flags seems useful, as that would allow libbpf (and user
> > space apps working with BTF in general) to use more optimal
> > find_by_name implementation. The only gotcha is that old kernels
> > enforce this btf_header->flags to be zero, so pahole would need to
> > know not to emit this when building BTF for old kernels (or, rather,
> > we'll just teach pahole_flags in kernel build scripts to add this
> > going forward). This is not very important for kernel, because kernel
> > has to validate all this anyways, but would allow saving time for user
> > space.
>
> Thinking more about it... I don't think it's worth it.
> It's an operational headache. I'd rather have newer pahole sort it
> without on/off flags and detection, so that people can upgrade
> pahole and build older kernels.
> Also BTF_F_SORTED doesn't spell out the way it's sorted.
> Things may change and we will need a new flag and so on.
> I think it's easier to check in the kernel and libbpf whether
> BTF is sorted the way they want it.
> The check is simple, fast and done once. Then both (kernel and libbpf) ca=
n
> set an internal flag and use different functions to search
> within a given BTF.

I guess that's fine. libbpf can do this check lazily on the first
btf__find_by_name() to avoid unnecessary overhead. Agreed.

