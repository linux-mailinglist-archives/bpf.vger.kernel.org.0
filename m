Return-Path: <bpf+bounces-73223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C30C276D2
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 04:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BEF3B1995
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 03:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D29258EE1;
	Sat,  1 Nov 2025 03:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2ozUdWu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162D21CFFD
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 03:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761967730; cv=none; b=oLH7X5SiHCJgh+nKNxwaCSV13eEfNGn4bFrwf7IMFwtWdr7JCF3N2JUX0UxEaGyRMUkFk8vHWqqueb1HRYpAu8lMgnAb+cOo5qcnLiOfpYbtn/1WWpmTW5iQzop9kDrqsW+epEnmODTOTj+F/nnNahMAiYlTwCaA3gpg8oOdPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761967730; c=relaxed/simple;
	bh=wjnNkEV6LUs78Y+5OZbnzxMl17pcnxKfgCEpP4WCa1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCbQv5wNNDx6gD79PYBmDxmiVza/2tG+C2V6BldbpqcNQcDU7/VnBHInzk8yM8HVeLcEjllJeq2JUPMhXMA0X/gGWTCIGmoZ/4wF5PpdzhujHjQRnfTsiB+LanBcMvN8MHHF+HNJ19BkWDJcVQhwHriTjqc/649Kxjh8XZso760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2ozUdWu; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-26d0fbe238bso23716785ad.3
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 20:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761967728; x=1762572528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjnNkEV6LUs78Y+5OZbnzxMl17pcnxKfgCEpP4WCa1s=;
        b=m2ozUdWu2M/KATEC6ioNMaU0OpyeXNDytFm0q825ZlsDNsdguk0rj6QqPO0F1kPexW
         OnKco0o9+l8FEMUzP/qaCHFtIxCsWjSeUoHFcHAoQZe7jKZViRSq1cHDbEYcbkIoB6iA
         TxuIqAyFflfpMt5Vq9cR/w2ObnTq4ZR2hcMUvEx0xEtquqWurbiqAuQY7brcvXZ+YJmn
         oA8IHK0IF1v+CNBafE9678k8LgJ4YVWyHErLPFDShuLIg9EttisKtRkWsHJzhWPm3wGa
         /Zh3N27KMHRcnuRJb887K9AGH8Cjpxh4gniP9mRqbdfLcSYafgmLoekqUkmOc/Qd0jXt
         ZNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761967728; x=1762572528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjnNkEV6LUs78Y+5OZbnzxMl17pcnxKfgCEpP4WCa1s=;
        b=Sv26xlILFe0JzCpD3IE6numJoPGndyHaRlSVACmAQc7cjCfXaNJRUJzoMMsdFOrJUX
         MAMePdSVdYYZr+Y5aPwz2qJ9SVQWZwhwd1rSJjVz/uQP7J3qHtkuVZB4p6/T3zbdJYVm
         irj/zK56crUwX/S7XEOYwLsSFz8I7Q5TxDUu7szs9O816skI6kJ1tNCW/CodHiOLcwKl
         2JfELcEESIHz0YTw4no5MzQtERBJOMs6gMSjuvaYt+x/+Im9z9Lhr3ykPZFqPmyTDRqs
         SM68nG2CeH/eRuC4ZbTTtdQ4ZymKM8gkM2RuBLaWKFMydNMmcJ+hLso8i+FFtbum8GyH
         W2JA==
X-Gm-Message-State: AOJu0YxbGIpfTNKTA3f5gn8++9AuqfXo/8Os58CjQ0a3kHlP3YUSpSGj
	Kswb2kSM7M2vimCuaJaaInoAc/HczmGlGDbs8993QtCDRGMG0h6TIV5yAZDQgqdDV5nq7X4wi4M
	gFPFpcxtdR5lilLtFAEekkmgV0Vy9XJE=
X-Gm-Gg: ASbGncvaVLIJ3RDtwivfgOkxKAvLc7UO9rDg58MzHshsqoA9SY58iY2V0dzfJ62ZMM8
	5DtL2/0xoUVvoD8ZheS9nZ7BoagyF8YvIOnIOPIS9DMZ9alnmWFmJghyA6jchGu9ohy1QAy/Ecu
	KrYygolWp/tbZu+724I47SGR060anjQlhrQLWE+qHsbkSGtTqtAIu2hEaIC7THfIje7yC4cDRex
	to6nyr/4ftrkfoEBgETn5jeLwA2BFT1DTHiTEsFNc+hE7c2byNA7oA8ftddDpZzN0T31V1D9ICU
	a3kxlg==
X-Google-Smtp-Source: AGHT+IGWgaD4PX5lKseZPf0pThlXZ/JawYKt97AqtJa/6i0YIuP8oftmS/jTEcFBxmHyFCuk5eCcQemB2BsQUDEOdms=
X-Received: by 2002:a17:902:cec4:b0:294:f70d:5e33 with SMTP id
 d9443c01a7336-2951a3a6503mr78206555ad.12.1761967728338; Fri, 31 Oct 2025
 20:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031032627.1414462-1-jianyungao89@gmail.com> <CAADnVQKzF=jrJ84es2=Ko-WdcNxQnBWErb06huFyZs6-HuhowA@mail.gmail.com>
In-Reply-To: <CAADnVQKzF=jrJ84es2=Ko-WdcNxQnBWErb06huFyZs6-HuhowA@mail.gmail.com>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Sat, 1 Nov 2025 11:28:37 +0800
X-Gm-Features: AWmQ_bmCdOpwYJv6p5xTcj_08DXLN3HgDmDTP-aMN7MVR_ZSgQKsBIGPN31PcsM
Message-ID: <CAHP3+4AwtFNF_RifNw5XrpsFpBZ_dssZPLPqc_264y0G4OksFA@mail.gmail.com>
Subject: Re: [PATCH 0/5] libbpf: add Doxygen docs for public LIBBPF_API APIs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm not an AI !

Although the Doxygen docs added in this patch series were assisted by
AI, they were still checked by myself.
You know, this is also a tedious task. The reason why I wanted to do
this job is that I think adding these documentation-style comments is
meaningful and can help some beginners.

However, if you don't like it, I will stop.

Anyway, thank you for your prompt reply.

Thanks
Jianyun

On Fri, Oct 31, 2025 at 10:30=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 30, 2025 at 8:26=E2=80=AFPM Jianyun Gao <jianyungao89@gmail.c=
om> wrote:
> >
> > Hi,
> >
> > Background:
> > While consulting libbpf's online documentation at https://libbpf.readth=
edocs.io/
> > I noticed that many public LIBBPF_API helpers in tools/lib/bpf/bpf.h ei=
ther
>
> You or AI ?
> The whole thing looks like AI generated garbage.
> Sorry, but no.
>
> pw-bot: cr

