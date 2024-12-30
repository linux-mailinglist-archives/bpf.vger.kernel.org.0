Return-Path: <bpf+bounces-47707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEF69FEAB2
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 21:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD28188281A
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 20:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F1D19B5A3;
	Mon, 30 Dec 2024 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmnEVAcV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8819924E
	for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735591800; cv=none; b=FEfQTnJJIMJ48diGJUwRRCWJD41idNXxZuj5PV4p1P/G4nNlkpsyouTfOUhYj53hLCGQeloiP+l//iVMbgZ4I0E+bgejSkE/8NLBIUojrKiPxPvnsCAIGTknKsQ9Ap6C8MlhMKYEYwDfegdVkcrjglcqmsP8oqfjlBZEj9QLL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735591800; c=relaxed/simple;
	bh=DWenXRDGK1wCceXKr0nBauWRWuKqqzYqQLR1jMCUKmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkXUer+MGCzfmG1JN+LJBjxvM/AxLvOD0KwlBQsG4v+Cib2LgiIgn2UMCl+Uv7jlv7Nfw9Otfp7XI4iW2KgHi1uY/g0X5xg/l2df3E3/sLeOEnTearGJOira82N0geLXXwrPshtDTOhPvIlxXytSne47N2I+7RltIrfFQJAxzlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmnEVAcV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43626213fffso62140855e9.1
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 12:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735591797; x=1736196597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWenXRDGK1wCceXKr0nBauWRWuKqqzYqQLR1jMCUKmA=;
        b=AmnEVAcVek8Asc9lf42eVXEo8FIGm8TGEykVy3ZMIdQe8igtFT4721YKZRhyZcH7Dv
         oaIQ5fFWXGRbWE3BAJXJkWCknLCmxcmfl3omyQZQqBa1ueNev36xEHhxYPuwvtiTyL+J
         4oS9O5etJxQfwzzN570pVhwfes1MZM5/Pr2HGTy5mHnEUy7dhwFoxRX66XWFlWKJV/3g
         69QSceKTAX7J+U7/Aw/gFeMVtIyNZP/juFvg3cd8LiyAJYaz+ZrwP30/z/gBPFxuAnvH
         ubVwKEFYyQJCa0Ni6MjBfJjOzTozHYKW33RtToaj4sGRXB4zeieztRlNoW/Makkw5dJb
         VG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735591797; x=1736196597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWenXRDGK1wCceXKr0nBauWRWuKqqzYqQLR1jMCUKmA=;
        b=NBKHDBorTRl40faLCmoTLNlof/JrjFXFWgPMGrSlsbgmf+XxsikyXhKIRrqv8qvAr6
         RV9CKbqv+EXoe5sq0rZJkOLyZDMsyfPo3DJwdAn0ihaSq/JrAE2KvSnoBLbRRn28nneM
         XT0CjA3LnPTN7jKOiSjJUDsW7QZ5zLwFzPneBpin/a0DLdKapF26ctE5qnSKM34Tpwfb
         4bY9jOD8crvtCiB2KfwG3nja2E1L7Ff4zopl4S2f/Zhf3LyHAzaVCQAQJl8UJB2NvraS
         BMnp7nPPnQj/otULRiHxvHLalpGPMvWkdXQmb3uZqeceaaoZZO8cZjPX+LP5IN6b1IIz
         fS6Q==
X-Gm-Message-State: AOJu0YxcZrhruSgvJFya4DACaivb+XIvsEuFyXijoivmVp9jaZjzsuJs
	ddycMQfi2hBiU7mN7kg8sKeVx7oyxziFAAu+mWuJj1D8PS1vEqFRN0faHK9C7LlQLBxktItEqU/
	Aoy603Kb7VB3l89VRmiRLCdUTKsk=
X-Gm-Gg: ASbGncvcUU3LP/msnoG0k9Jf3KujsCSOec5xJp4cV5cezN3xPAFrAVNVhzIIJ5Ghyhr
	zrFjkTGVHoI+iTvXe1Jbn68nnfwF+5Y4QNvvbBnn/ovGDit32OqiSmBtVt2VP7fUaq9ScGA==
X-Google-Smtp-Source: AGHT+IFyeVEY/2reORdtML4as2QjPPmSkWHBsvp/gKLcFkGHRTFU6OZaqG8orNW4MP7gthDeFSrjAUt5eBFWIXcuEAQ=
X-Received: by 2002:a5d:47c3:0:b0:386:4a2c:3908 with SMTP id
 ffacd0b85a97d-38a22a1aa5bmr27729430f8f.17.1735591796682; Mon, 30 Dec 2024
 12:49:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pv3zr55lja6lumu7iilsdtbujd6yq6qxsrxssifeqh6tmcmzii@5kkyaajllr65>
In-Reply-To: <pv3zr55lja6lumu7iilsdtbujd6yq6qxsrxssifeqh6tmcmzii@5kkyaajllr65>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Dec 2024 12:49:45 -0800
Message-ID: <CAADnVQJra9fJ5v4oB2zkfoqnk25w0u-gfC-0yesx0ZNP-BXyjA@mail.gmail.com>
Subject: Re: d_path() truncates at front of path?
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 12:46=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi,
>
> I was poking around bpftrace test suite and noticed that our d_path()
> wrapper is truncating at the beginning of the path. See [0] for an
> example.
>
> bpftrace codegen doesn't do anything fancy here. And I see in the kernel
> d_path() implementation there's some prepend logic going on.
>
> I wanted to confirm this is the expected behavior. And if so, whether it
> should be documented.

This is expected behavior when the buffer is too small.
bpftrace may react to the -ENAMETOOLONG error code in such a case.

