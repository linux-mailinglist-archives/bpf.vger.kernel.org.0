Return-Path: <bpf+bounces-41336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073B995D32
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 03:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3099F1C235E5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE923BB22;
	Wed,  9 Oct 2024 01:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK3opr2W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A77F18643;
	Wed,  9 Oct 2024 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438280; cv=none; b=ZOajbWn9zc5VZkS9x/k/K3+CDrgM2E7jYyYWwTCt93bGSB9N4N9yF5TE5U829zUFLgFYYMtn9tcTMJTiXX67/oWn2Fm+NyyTpAQ9ts+FkXTVtmgbpuoMkklF2KUggIoQgXvJYIcwitiP56w18VS+tjZe1L2gQYCZCxRT2kyiK50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438280; c=relaxed/simple;
	bh=cBvMuRHTwaNQxrgi9SNhniAL2ly3EzXQM86FwhhIbZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxM9Nd9NoyBvE9RHWhlKcs0ep3hTpVhmaKeP4WnSWP43l+DipmVMKTk+WwsUh6KoxCQN9WWYo07PJoSkL55Yl482PQpIVeypKtPCxLdC9k9Ad5mTVDUoKtnEyHBjQlSvcL+oaHDao+QVj0flZfV2eIIlPr+DgkBPqaekob0D6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UK3opr2W; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5c89e66012aso8219040a12.2;
        Tue, 08 Oct 2024 18:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728438277; x=1729043077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBvMuRHTwaNQxrgi9SNhniAL2ly3EzXQM86FwhhIbZg=;
        b=UK3opr2WQh0oiDiWFxwPvoGLQSqBhw7VdHLGatiayaEJCKAW/YUlirdHNXSiBt+vDn
         hEvgRFpYl5b77PSKAH8YR5c3XgEuN/uikaIj3jS0VD1FTpJA5ImtwJm4mFbDVgQrlZP2
         mf0JTO2Fm886DF1fz3uxMQZAdCMR9uEplQnul1K6blfsMRrbYVZ9QwaTOGcLug5qwWBl
         IjviBqdNtj/0W2yCsktbf50R4+jgIydhgpjPTDbaMrhdZdwuF8GL5jzmpsEj0kyLG31L
         pVzvB679OHIpiw/V/U492zyIMK4iF58xKyP7af22XdV9/fwHVgP6g8s15xuLdS5iGZca
         TOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728438277; x=1729043077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBvMuRHTwaNQxrgi9SNhniAL2ly3EzXQM86FwhhIbZg=;
        b=KYRo/1qTZAkuGmhoW7CHsIuBZIC6k6h8magWheLaPXdzilTkr6iRBnijtKT5Mpei9b
         03ag9cwjjiUpfCTNhU+CH/7ByZKFKoOGOTkB5nSsz2rcKGHiq5NfVOqMmhvKBz1FoqQL
         cc5nVon3nVvpA+aS7ZnORNqjczoiDv+gwuuvCO/asA1+qBtsfrHJGgxc6HNLCjOu5M13
         4tLMe4TQ/8vP/uQAhPR8J0oZH3OcQbQJ6jrW5uECRfFXfyFYL5iEpDEQQPV1ESJKdApq
         sJxCYP1/Vks8GOyUIUNXRnI7qPBp6p4qo3m0dyrVwUl/sTnX8gVoZTMCb+FSYXJEjQU2
         8F9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHnLjStsATABa5WLyZ47Lyxyjx3Oq6fkZxEkBbfKy2uvX5SB3aE7Fy/1/ygaZEpvI0mOA=@vger.kernel.org, AJvYcCXec+rd8JcPnwUyIakFSUg0xAPQit8aMLdGzzX+hqjv/w81tshLUXHFYl4CU/Dxzir16+u4Q4dQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5i2FBZVHSWIwQu0+RfduugZD0P1jk/HIPSPZffy2dEBv7TcC
	G6z4QqT5CTyNeMtIQW9QKUaCWFgY17tLI1iNYv+1HoFqjYsM9g+sJR8vHaa1DqXWVO4UJVMD9y4
	pXfd8P+gLqaMg9sG51lPytgWCv1E=
X-Google-Smtp-Source: AGHT+IErUilpqX74e5OvYYBWwxBYIrjGJCD9zfy9m4einp+6FNXbtnUTrQBW99E+N9TYLOxYdK2mCff2y54G0sz5GX0=
X-Received: by 2002:a05:6402:5383:b0:5c7:2182:a43b with SMTP id
 4fb4d7f45d1cf-5c91d58c474mr544265a12.11.1728438277133; Tue, 08 Oct 2024
 18:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-3-dfefd9aa4318@redhat.com>
In-Reply-To: <20241008-fix-kfunc-btf-caching-for-modules-v1-3-dfefd9aa4318@redhat.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 9 Oct 2024 03:44:01 +0200
Message-ID: <CAP01T77PBWREsbcSe9DaXU-qrNWkU4yhoHqnZu-VdHyu0ro5EA@mail.gmail.com>
Subject: Re: [PATCH bpf 3/4] selftests/bpf: Provide a generic [un]load_module helper
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Oct 2024 at 12:35, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.=
com> wrote:
>
> From: Simon Sundberg <simon.sundberg@kau.se>
>
> Generalize the previous [un]load_bpf_testmod() helpers (in
> testing_helpers.c) to the more generic [un]load_module(), which can
> load an arbitrary kernel module by name. This allows future selftests
> to more easily load custom kernel modules other than bpf_testmod.ko.
> Refactor [un]load_bpf_testmod() to wrap this new helper.
>
> Signed-off-by: Simon Sundberg <simon.sundberg@kau.se>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

