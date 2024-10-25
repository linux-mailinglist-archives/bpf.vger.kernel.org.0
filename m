Return-Path: <bpf+bounces-43171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF09B0977
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDF51C22E0F
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8201EF92E;
	Fri, 25 Oct 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVRs8eK7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A018B462
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872878; cv=none; b=p9La2RyBb9VqynP/4txsljamXn7ZMdmkQzA3xksQu293vcYhqdr4PBECRVOr5mtXHSUHHEOYkf/IdoNS92lASlqXfqor/klb468mRNzJBbKZDkjCSv365W5FT5ziepazWY2TqTtmVYBBHEEaKleoADe4OPJN7eMTYKVRPEz0IJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872878; c=relaxed/simple;
	bh=Bh4NDT/QNxr4yZ2Dba5HoMSb1kjqRRHZiiRckLPovNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBkytZWmqDWccaOB4YcI5P3ix16RIrupJHR8h9zxiBSzBoZLJlMtzghHZf3tPCX8ZIGkdOsFYItNYzYvy/wJ76c9b2Z3tCzrDjAuEletrEvqw4j6+dl0LTj9//WgYZOs82LwrjQdaA3ofwRFi8EHx8vI6BAoUjsd9MdP0aAQCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVRs8eK7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so22045995e9.0
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729872875; x=1730477675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kw0aTUHQ4qphDnDZ9A9MinwfgDh4wLPub3RUFzkGABc=;
        b=NVRs8eK7v3p1dGaOzhLyXEygTioZtqgtUuRK5UYEBE4bWT8+kzzEC5ddv6oLxrtbOV
         kBHoxj81MxiAk28txI0XMsZ7BZdPqBngWC/JjVQamLHmKUQ0hJNmu2rh8K0FSHQG26kR
         16lr6MgzoyPElG4QVE7AtseawwIfPoWISbJS08eVg9v6Qr4uVEXDWqijTXOo2+DdoTxY
         7xa77JPw8WCLGJlNNcTx107Yd+ohOrGRQDZlFQKWjwzkAri1D0HKqnNZOkkQlmQzydVQ
         4fZRd5HjnJ/D/7vGUyS0F7Y/qCE2rHvMyDGeIPFakgHjlWtGPIE0PPJq+0G9B9MW2Jre
         5lnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729872875; x=1730477675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kw0aTUHQ4qphDnDZ9A9MinwfgDh4wLPub3RUFzkGABc=;
        b=w7/7JbdvgPtq5SNGfbD1raYCMtN6K+9Dd3larLUOUa4EnsWXEpShUYPi0fPCP7G4gd
         hHAgxl96FpDlkjJbyb9NpwS3xtTYQYzTaAfw0JYxkDj6M4Dy6POsZJFRARvP5OfV6LBa
         ZWn1ZQfuOI6i4dIBzahfXUGiPtCBkjhgI0F2S1oDEvABTOiL4FVUOaaeRcAIMNtdqnQ4
         yz3ADW826VukyngP+ZpOHznbpWhB13cv1m3ki/Q/2mr+UE0M3eqrd+5ZVHmNYZbyJAUT
         5Dpqd+MTMe2zrGP19hybUeq5Di/JrmwBqxPRYKm82XyY5YvYEifXarRnW+aC7zFVmDGa
         cKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxVHl8Sv2wfwiPr/FTz0wJrr6mjaUeAPRN5uHbyS/IWyX9MgerL/2oGfXSzhvDPqi1ukk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz51kEKCLa6rgepdwRhoJo2iE1n6CM9ami2xvl0TftC4hR3zOy1
	WnnKkubQeBhaKcGvAPRjAJEACIUANtGnM0rJiF/sFGtrmxVVqq53JMH7tWVyZ7Ib6Z3gWVHaMyf
	rkia59FlSVQvfIrMdtQUkX4YirU0=
X-Google-Smtp-Source: AGHT+IGKnr9Pu9Z4Ealf9HNTMj3hh0RZl/mgpjL/tjyKBNMbMYLbs1DwG/W5bjm1C+X0K9XnET9g22i9Iy/5LIo6J1E=
X-Received: by 2002:a05:600c:4f14:b0:426:66a2:b200 with SMTP id
 5b1f17b1804b1-43184091a8bmr90289965e9.0.1729872874996; Fri, 25 Oct 2024
 09:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025153850.1791761-1-alan.maguire@oracle.com>
In-Reply-To: <20241025153850.1791761-1-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Oct 2024 09:14:24 -0700
Message-ID: <CAADnVQJkR4jikUJ2FKANro0yfBTBNNBU-mzd6bxy1DYn79ifww@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Add description of .BTF.base section
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 8:39=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
> +
> +.BTF.base sections will be generated automatically for out-of-tree kerne=
l module
> +builds - i.e. where KBUILD_EXTMOD is set (as it would be for "make M=3Dp=
ath/2/mod"
> +cases).  .BTF.base generation requires pahole support for the "distilled=
_base"
> +BTF feature; this is available in pahole v1.28 and later.

1.28 ?

module-pahole-flags-$(call test-ge, $(pahole-ver), 126) +=3D
--btf_features=3Ddistilled_base

