Return-Path: <bpf+bounces-77552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F70CEAF70
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 01:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ED32301410C
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 00:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931491A9F82;
	Wed, 31 Dec 2025 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0qkH1VY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7419E819
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767140986; cv=none; b=IF93oUXn+iz+RptONOZKqwp7ri4r9vHe+cHn1K/LHpt6ljl3YrSPas0gmq+WqiQKjvNYuc7PK0K+hnSfMB0TJB64onNuLdeDqXXuk2SnpDIl75CBSkQu55/+Hzhk9S1xnIgnS+RjTwy4xY188PL94Fnnmp0BB8kTgjzG7fVQ8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767140986; c=relaxed/simple;
	bh=cbwVjZ3L9v/puuEL10BeRxRmS8Ykjomj9yP/+9r+Tnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lOcjEEsxAYKJkD8D3wBL2B3yeIXL2VX+6vEC+xZoi0E9OvB9QYV0LCZ0PqP8UY63T89JxF/OPi25Uv/y/PTPo4nkqCE6uMGys+4J/CMUTKMzbL/HnFTxzY6gAqBNZuv1PqOgwi6SpG169vWb1zJKWtP3omqMAfSg9txB93EB628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0qkH1VY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0ac29fca1so88206755ad.2
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 16:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767140984; x=1767745784; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cbwVjZ3L9v/puuEL10BeRxRmS8Ykjomj9yP/+9r+Tnc=;
        b=A0qkH1VYCH/oFvkg62yh4htv52eidKGHdoz4CjoJCmkrtxYoO/16XWXo6L56sbYMSF
         NY7nlOkUanxxXrj1NDx3bqG6hDZqIpac5VyB0gCg6TvU1i16seyKn/GS9mVWtEXtxgpX
         3+9lvjjEx3o6R7EkfW7duXMiT+VaELBGodPMURiguiaicA86AByrhTHtRSzlr6nBeWDG
         FBXmhj82zjCo+i5V2YLOjeCw9Wp5zvvpgdBrabT13bI1UJR0cPK946lnEGOcM86t2cPG
         oxaMxCx71E81WjGWwB0nnj16iDUUotFWDEVuiXON3c8oGfSWFDKgkjEDaiODP7TZsyop
         xF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767140984; x=1767745784;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbwVjZ3L9v/puuEL10BeRxRmS8Ykjomj9yP/+9r+Tnc=;
        b=FYtdvPWHHyB4B16UHflAi/5iGW/GBt0wEwCgEchSFGKNO26iKvigB3y+GusUlrFrcA
         Yrmb8OLVeZGEXmO3OuIqd2IcvcKZ5hOiuzLD/JaeSzPo2UsVyLWzkFh3oW6Razq9ixl/
         Ape8DxUuW6NzpI4qNz30U9DTjKuzy9vrWPK8F6Pkaz2iLyqIKaITwMOYJ8Ev7cg+5uuY
         e8RJ0xggCUMAOXpI/RXP7xq0glYIq9A3P8Q/6mACfcaBJ0N2bpJNeeIc1rN5cQEsqFrI
         8w0DPmrF9FBDdEchR/NgnCmNmLIJ3wawJrCnzD4IEBnf7HAK51SXHTLrI0BkFO4O3qq9
         Qi1Q==
X-Gm-Message-State: AOJu0YyH+TuuxvrqlEL48uxoYKYyWGPEyMMq9z+/DvxuglH9NXpy7xjW
	oSqhravqBRBRE3ABx+FQ3ZvGhMjbL8ZpMxRKZn4dt6TsG50CKLoI/D4g
X-Gm-Gg: AY/fxX7cI6kG0RNVD9T7YPftRRv/ulLnKJgDGbG0xElNYEP9jRwgeDObTkZpZXPkxxf
	wTCKSwiBQFiDqdlYJaRUTvYXFiK27a7PuYsC7PTJVn/eokIV8cxFOK1dTTDl9BT036YtgUIAZL/
	JXdnc9ymuYP393lKO2Ow1W1T4LbeU5g4iJFpgPWz7PIx1KQeCOO9bCa8V9v8nzsGKSWzMpETyNo
	VjEJx5zkQZDJGZ2h/uD3lN13TbAJcJSqJF1QT1Iiu/+vpEnyI52De60Bjjb9kipyLHE1pi+iUpW
	tTV6LyqnC1A3hcYxMyiwDUfnX+ej4CYJkIumYbAT1xN+AgoigNJwElLXpL9Z9xzAx821zqW1g61
	dL0tdQTmfGQ9G9Spz5sxxa18OOWV+Rwfg+ib7TCyC89txolihhYyqafXHcQBNIImG9emxExeffu
	bVB4FBEQMM
X-Google-Smtp-Source: AGHT+IGdw/5gRs2kGSX6ky+TLopCstFwqadA4fYBa1MsSX3chvgA+4pcWWLtFHqGxizE215efGIGfw==
X-Received: by 2002:a17:902:f60e:b0:2a0:9028:11af with SMTP id d9443c01a7336-2a2f2a41622mr346875655ad.59.1767140984030;
        Tue, 30 Dec 2025 16:29:44 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c6b7b0sm312570405ad.16.2025.12.30.16.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 16:29:43 -0800 (PST)
Message-ID: <6d032492af465929e1e02c53a479f71ef8964d76.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Make KF_TRUSTED_ARGS the default for
 all kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, 	kernel-team@meta.com
Date: Tue, 30 Dec 2025 16:29:40 -0800
In-Reply-To: <CANk7y0g6s5C-mLTPUpGyvJC=ZA=v9WawYzbeVgocbsf4dcXJHw@mail.gmail.com>
References: <20251224192448.3176531-1-puranjay@kernel.org>
	 <20251224192448.3176531-2-puranjay@kernel.org>
	 <4cb72b4808c333156552374c5f3912260097af43.camel@gmail.com>
	 <CANk7y0g6s5C-mLTPUpGyvJC=ZA=v9WawYzbeVgocbsf4dcXJHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 00:08 +0000, Puranjay Mohan wrote:

[...]

> I wish to do a full review of all kfuncs and make
> sure either they are tagged with correct __nullable, __opt annotation
> or fixed to make sure they are doing the right thing. But currently I
> just made sure all selftests pass, some of the kfuncs might not have
> self tests and would need manual analysis and I will have to do that.

Ack, sounds like a plan.

> Some kfuncs will have breaking changes, I am not sure how to work
> around that case, for example css_rstat_updated() could be
> successfully called from fentry programs like the selftest fixed in
> Patch 7, it worked because css_rstat_updated() doesn't mark the
> parameters with KF_TRUSTED_ARGS, but now KF_TRUSTED_ARGS is the
> default so this kfunc can't be called from fentry programs as fentry's
> parameters are not marked as trusted.
>=20
>=20
> Looking at the code of css_rstat_updated() it seems that it assumes
> the parameters to be trusted and therefore not allowing it to be
> called from fentry would be the right thing to do,
> but it could break perfectly working BPF programs.

Indeed, it expects 'css' to be not NULL as it dereferences the
pointer immediately.

