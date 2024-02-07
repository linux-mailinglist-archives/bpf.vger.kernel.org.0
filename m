Return-Path: <bpf+bounces-21426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718784D1D1
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 19:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8D4B25737
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 18:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF412A149;
	Wed,  7 Feb 2024 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="FQGUMbpA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA612A167
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331883; cv=none; b=VvAprIF8ZBBfvbURvXSe7iiSsx/m+yJufXu9VbVtsiKH+vjdX90eiD8L3vJwdBynVyJDUfjkfatT8U8K+fvzVa2i12PF81iYSYKA8Hw+xrfkL+t6ZefeC0nA4zAN426317J9hz1Qp9Rv7KTVtWVm2CmuP8mSLkbf/LAPt0cr2eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331883; c=relaxed/simple;
	bh=Cr1WqFGCgFqGLRMPTF/Fs1GQZPIuRUPNacsYnSq4hrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nce1Jl+TFA38Shyot7yYqYCdU87C8pv3/o6raOeGz89AgdKLQN4eiel1QiyGMoajWelwc/M+yaRX5vFX9u363C/zuyEGOGwnA20GZQKGg1wIWaKSeOI2fvNOjbdOcIi0zC4H6EtG4ZE0eqgSY3/6b84pFIaTuAPsDNca+jG3q6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=FQGUMbpA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ffd94a707so9343225e9.1
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 10:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1707331879; x=1707936679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr1WqFGCgFqGLRMPTF/Fs1GQZPIuRUPNacsYnSq4hrs=;
        b=FQGUMbpAkTbsO+kx22m88cp4KX7lLSg4BRy6kY71VzWmm/4sqnM7GXMGuH4MN7TE2I
         jNMusKFQYXxb/u7zxdzWiCXbIBe0PW9a7Nvrr68cbPIP2uCxsFaHH6SHHsb04TJrw8l7
         MZr2yDujxh/QrVPicJv1RkovHnwGPhvmX45xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331879; x=1707936679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr1WqFGCgFqGLRMPTF/Fs1GQZPIuRUPNacsYnSq4hrs=;
        b=PEyO6P9fpzMN4oCLWXXs+DQ35Ps6fuE/FXMZ79kPEuGr/SeByIN3lz3+9cvMi8YIKg
         aHc6GYcZVpraswqgtYpichVeos5m5AG+uUngsneK81jkqI+4iqk/OUtuIoZ+etL7h9EF
         L/OUcE48fdZLzNASvKa3r257ek4YCRPkGluH3TTYvosAcMk5eE7kpkTI+QcSFaZ4qB8o
         DxkYAPm0EZOv5HcV3OvGpqyUHewRLtYfr3agiWCrYq5xxaOSeKCz2eHqEt2T1WKao9wK
         WzUyXtJK1g11VAPdApXtvlPsPi/1ev/sRXiM2TZi4PzZj1xcB0cHqw7XSCTFIYx3COkA
         MYqA==
X-Gm-Message-State: AOJu0YwdHxN5AIgeS5zTAIOkMSGQ+VztuZ4xeQoYCgjQfuFTiffoqklx
	iBoz2cbwPmAGhSGWSnDKW92ZIFilKbNnpKkSmLL3sNU1Mc10IG7exX7fzL2mLQBEZvxo+IpvhiW
	OCfLls7IO3jQLwGvsfhAoo5moJbiXh9e6H51aYQ==
X-Google-Smtp-Source: AGHT+IGxZYgnp05fSRIX7DtxXcqxIdu/hvMpBCOCJCXmLoNQP5yXI3KpKwvIsrq3eaHoHes4uTBlN+K2Q4ZEV2mNuKo=
X-Received: by 2002:a05:600c:4f08:b0:40f:d598:bdbb with SMTP id
 l8-20020a05600c4f0800b0040fd598bdbbmr4661255wmq.11.1707331879405; Wed, 07 Feb
 2024 10:51:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130230510.791-1-git@brycekahle.com> <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
 <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
 <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com>
 <dfcd6c3b-dbaa-4e72-acc5-89aed8a836f9@app.fastmail.com> <CAEf4BzZMmbV4H2vLeYO0tm50VV9evLDnUTM69=P7z41v1jY7gw@mail.gmail.com>
In-Reply-To: <CAEf4BzZMmbV4H2vLeYO0tm50VV9evLDnUTM69=P7z41v1jY7gw@mail.gmail.com>
From: Bryce Kahle <bryce.kahle@datadoghq.com>
Date: Wed, 7 Feb 2024 10:51:08 -0800
Message-ID: <CALvGib8LtTY8qBN+tvZTzb_GKNOX4R9YEUxkOL0ghuQmjG8Yqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen min_core_btf
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bryce Kahle <git@brycekahle.com>, Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 10:21=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> 3) btf__dedup() will deduplicate everything, so that only unique type
> definitions remain.
>

Since minimization only keeps used struct and union members, couldn't
you have two internal types from different modules which conflict and
end up using the wrong offset?

Example:
in module M:
struct S {
... // other unused members
int x; // offset 12 (for example)
}

in module N:
struct S {
... // other unused members
int x; // offset 20 (something different from S.x in module M)
}

