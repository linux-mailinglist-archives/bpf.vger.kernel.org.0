Return-Path: <bpf+bounces-71493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DA6BF53C1
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 10:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F303AF8F0
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C47303C81;
	Tue, 21 Oct 2025 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAxoEHRc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71226E71C
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035489; cv=none; b=If/mkSSsqcWT1TA0WTyz4pK6T4z2YwyfaPnGfHpcENQ4f8RmRq87L+KSaf6VyfcxHPdiVyWJXrCp0fvz98SoZ7Njf1xefxlIbjsDlIBlq6u8ZnDFy4FWhH7U2xGWVbWdNwnWLF/0/gdTAS5Gb9nPeYowoDg2at/HXryxjhvK4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035489; c=relaxed/simple;
	bh=kZFjKIEcnkK+8h+RXTYyyktt7Hh5oNWxVgN0IiKcNTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2jT/8iQb9IqTwY90PnttefT0bGNcJgOeA80cW3xqZzyzqBaRg3r7im85YV01Ux4gfh1eo6nFJ4L60rD86NQQWAUFy0X9fkyNdhgWA+oCYnx3h8wMLX0L3l6KFTHRQ5b4tTG8MugPPz9jbHAOeVTsPtM/E76ki5UFMmweyCJexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAxoEHRc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1188007566b.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761035485; x=1761640285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRTE5Pag0LzIfawiXpHT76EYKoTRi1+EVw3LVXs3RXU=;
        b=eAxoEHRc0llHF7PUdbCFzuxmeJI4eEmtj5j3Eh5xDuOy3+Vmahw4u6f7KbhnRnnaBR
         4kYHMd6AJm3Ro1pC6JNKyZTea06HhVhT1IscgYJehu/T4EL357u5JJOyAadoRh0/pWh9
         lKc/Pvf391aw5MYhp0SfJk/w7sbTqYBOeR5y70ko7Z7mDgXaz8VdBHlIYDLyJ7ftMIDl
         UDEHDasS15N/kWu9YYskwKAO0LvFCYpY+zrWJhP9XxkKdzMQ0X8WV7HjYbkfx+H8JZT1
         fcVCwxQfjO8tt9+hf2BZoV7G3Kz8riAZZ+00BcUZaW+R7lb7hDa9M1Bvbrn2tjePk4Sd
         EXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035485; x=1761640285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRTE5Pag0LzIfawiXpHT76EYKoTRi1+EVw3LVXs3RXU=;
        b=azuzSbyLfnzMFX3mjcMENGvuAD6lAJ4Tm2bma7Mp42iCql+6HmuWffZM5QVMNrInnM
         hzNjyfyGrlF/K6ADCMaAT0gUlaqHVvlAnaV2XLi+ROpPfVy4CseaggKdcSpF0Bn15jGQ
         zz8Bc/UQCxpVvibV50p9YWWkLYUot6GXxGg5VBLUZDpQO/FDVp1n9v0gpdKr+oNrkD1m
         u6F8X+LbiWXaBM1xWhvi3caHmILFdkVrWQuAuDsxFBnK+KTT2lpiZ/EL5pVMafIlpAJC
         491wcRPE8GLLZAyeo+XwVu4f5ff5CdQ3m1f/kYbw0IJxJFu8LHQ1q0daDMAUCxPC20OU
         2HiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDyixCaFvv/hJs0kYH0E0pt8lvyBwZss19G/VJkTXaOyYe+8SXyx0j6yMHCkirg6HGmMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBkR6TpqXlGrOgDxmwAZD878I6FMzVZbggN9iO2zBem63bPiP
	QqX5aGaLFOSbxH6JspCOW+BVnXe+2zKI00Hzr1XmQNefppe/sYipabxbD3CBheg0V1SlZgPRrQX
	L3qmhhcVzgAMXjXU9ofp90f0JlAaZEzE=
X-Gm-Gg: ASbGncvSgZLBZ/EG3QXWiXDs7rcC3kgg81FB5nNAEs8pFuUUp9fDKcDlfcW6XR3G7y0
	2ErR8kGnSt2jjttmWtY19a5lRDfeRYaq7XTyACwaB6Won348/qfQcUCpzaPZtnxg2U4ofusYcfP
	tpRx5mi51clWS9Y6QSVrYXi9LMyNXZj/YA9Su1rmdOhEuHjHiQ4uvTwexJUKgLZrwrIb634oFvW
	wAwlZe9808Nkw5fusPOaV2IGoYMW9TMozof7FmvfbJEbX3wqicoXebeLLQ+EA==
X-Google-Smtp-Source: AGHT+IFdZlBla3o+1d56zY2FWC5VJxuhXSeOUtlMWami7zo43RDALaBdxTKy7BK6sgH7dr2GmAOIyoWD0yR7ffvi+7U=
X-Received: by 2002:a17:907:3da6:b0:b5f:c2f6:a172 with SMTP id
 a640c23a62f3a-b6473b51d50mr1965498566b.30.1761035485271; Tue, 21 Oct 2025
 01:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-2-dolinux.peng@gmail.com> <76e2860403e1bed66f76688132ffe71316f28445.camel@gmail.com>
In-Reply-To: <76e2860403e1bed66f76688132ffe71316f28445.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 21 Oct 2025 16:31:13 +0800
X-Gm-Features: AS18NWAIKqzH5h7jsu58rm_kdFAE4-AHv8xbavdE_JL2YTnu5uqCVNy3TYbyJ74
Message-ID: <CAErzpmvLR8tc0bfYg6mG82gqMSXHq_qXeMsssSDuzirxkSt-Rg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] btf: search local BTF before base BTF
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 9:06=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > Change btf_find_by_name_kind() to search the local BTF first,
> > then fall back to the base BTF. This can skip traversing the large
> > vmlinux BTF when the target type resides in a kernel module's BTF,
> > thereby significantly improving lookup performance.
> >
> > In a test searching for the btf_type of function ext2_new_inode
> > located in the ext2 kernel module:
> >
> > Before: 408631 ns
> > After:     499 ns
> >
> > Performance improvement: ~819x faster
>
> [...]
>
> > ---
>
> The flip makes sense, but are we sure that there are no implicit
> expectations to return base type in case of a name conflict?
>
> E.g. kernel/bpf/btf.c:btf_parse_struct_metas() takes a pointer to
> `btf` instance and looks for types in alloc_obj_fields array by name
> (e.g. "bpf_spin_lock"). This will get confused if module declares a
> type with the same name. Probably not a problem in this particular
> case, but did you inspect other uses?

Thank you for pointing this out. I haven't checked other use cases yet,
and you're right that this could indeed become a real issue if there are
name conflicts between local and base types. It seems difficult to
prevent this behavior entirely. Do you have any suggestions on how we
should handle such potential conflicts?

