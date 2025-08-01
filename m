Return-Path: <bpf+bounces-64860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B67B17A90
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 02:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D2A16C849
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 00:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E1AD4B;
	Fri,  1 Aug 2025 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTI220zo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D414A1E
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007634; cv=none; b=mTZMZIMSChZHenrqSTCEf0OFcTtR/99kyRbCV3Y1sWjSpReUPTMlvoK91nrV1tm7tQRdqFVTsm7PnAzdwUymWhqHW+QXPTh4dBG9hL4amDIcfZVzjq02ae/wnmW9Sma2JQBkWckSvWK6K+9WyJZF7DCVND+5pTlF7wtixtSgbiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007634; c=relaxed/simple;
	bh=pNB7Jz1zScMDFfs0rZoZMRdIEP+98i95rIMN/mYlt4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCVIbvsPOj9xqAHW1k3kgV1t9kb8DLBwTBHIIb8yf43Sav7duO8LHuX7xtHIF1Jxq9A6KJRu4hxiU1abtbWSWRxaZqw2euCRa5+nn2bg8qR5Xd35sSqgXoR6B27xoVn5a21zcYr2na8X5gdbCaTQPUQXqVugDVuP6+g5/egvtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTI220zo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24070ef9e2eso71585ad.0
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 17:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754007633; x=1754612433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNB7Jz1zScMDFfs0rZoZMRdIEP+98i95rIMN/mYlt4g=;
        b=XTI220zohvGiCsLMvom+pMEsfPFrOGPhjbsg0BFC3RCtvfC4pIEMERXKfdPDaZvST/
         vmFRe/pCuoCgYTZ5MZqcFgQrqv7/plOGlM8ENnFQRpwxULRZMozd/fts2xq7oRZOGbts
         jawNHQG65bToWkcRr2DYS8io0/v1E5MJwnCTSc2I81V2hLMGPlUGFXLOtwMfnZOASZVa
         VXnZuMzzQclRgJ8JbZ+tZIIghHWzDozvALCQpNVHgCYgOWPY3Z8hqyVuzlK7/Zvq4ehV
         VWFhwPTvZjI+4/jkeqToM4EgXCQgPJBLV50g4VCfSfCiF9Ul0X/Xa3D/d5RTdjZqNI6x
         W1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754007633; x=1754612433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNB7Jz1zScMDFfs0rZoZMRdIEP+98i95rIMN/mYlt4g=;
        b=h+fwA/Hp5pWo3DwFMKdXE/i68H7Vj8K+vJ76ZvVdDoqyMiMyKWI+Aj4n7JIagylJ/H
         Yo0bkFSdHpdWqAQwEp815kucOt3kxfWQ6cqNsQX/STycm5yUcvd0NZP5niUIpBaFa8Ih
         X01j1IxDbggAuYhqy2QJgBqx46gcnPDMig0HfgGMCtyxRrdZVvGjCIcvB2tCc+VJCMMm
         dC31rtGAqfmmSSr3Wg5N8wYHGQLmz47KTBfvw5/TH185aqAKd8mbFy80K1tJ/NhvXzJN
         +XkkEMZyU3yPnZxWsg+DcJPdI1lU7LOs7+88KgoMgobL9KZBhLMMjgGhJAYKiq+lYGqa
         3qYg==
X-Gm-Message-State: AOJu0YxwMOxQgGT9K+VK6uQBHH2P5qARnoHv6DzLkdskBQAr1FKIcNMd
	PpY+6RWEz5WyavoepWpN2dAfUODK/C+fUxE/KDQDbwsqmajCnimCYtDbaaKGWWDMM+NDNjNq8WX
	Ukv3Veyt2V60Ld1FnugNDGze3AAUm8KswNBYGhzRY
X-Gm-Gg: ASbGnctXxpyiYuX2BL2kzL1+T7MbmYiq11yyP68ujXEuSs8Heupc5ZBAbOD7DfcUzzR
	KjxBxpZAwVQnqEahhjdSXy+GVOL4Kfz8zLUR/VJXr3BlvKSRSkHk8k+F+cA3hAkbHBEuA/LUHEb
	KA28z9Hh4ON88+yPPOjNmrRm5k/ahEl2D4VpYCaBYcGof8SFY30Cob3osHXDEPwHrep3cUIulnu
	MB+
X-Google-Smtp-Source: AGHT+IGDNTpuGVYj629USNLNeLL0siDgIzRTNjyg8lKmShUIJzDxKbLaciUPqUZUh7MiGlrWcRaOPFqL3XPjnpsCEO0=
X-Received: by 2002:a17:902:f689:b0:234:bfa1:da3e with SMTP id
 d9443c01a7336-2422a3269f5mr903815ad.5.1754007632274; Thu, 31 Jul 2025
 17:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722205357.3347626-5-samitolvanen@google.com>
 <20250722205357.3347626-8-samitolvanen@google.com> <CAADnVQ+FeGjNAJFyvpF_POB8tZUMXDN3cz_oBFNZZS_jOMXSAQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+FeGjNAJFyvpF_POB8tZUMXDN3cz_oBFNZZS_jOMXSAQ@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 31 Jul 2025 17:19:55 -0700
X-Gm-Features: Ac12FXxGz4A0byvVJth-oygtQdLKvl3dv5m_3xt8Zj3SIwF40d5KdT8i3auolbs
Message-ID: <CABCJKudX80K5VazPgHAmVd7yBFVeNY7hRm_xF-i1JKaWs-4RXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v13 3/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Maxwell Bland <mbland@motorola.com>, Puranjay Mohan <puranjay12@gmail.com>, 
	Dao Huang <huangdao1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 31, 2025 at 11:39=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Unfortunately there is a conflict. Please respin.

Rebased: https://lore.kernel.org/bpf/20250801001004.1859976-5-samitolvanen@=
google.com/

Sami

