Return-Path: <bpf+bounces-44678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44719C64C5
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 00:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B611F2521E
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 23:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1B121B457;
	Tue, 12 Nov 2024 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy9jSCEY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD01D21A6F3
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 23:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452606; cv=none; b=Y0JYcuslN2iY+KPpFXfhWX7xNvJRiBGdG5GUvQ4ZRYUAY5KaTry3A583okgvB5R7flk9NIVBavxIJJUd+9a9t4UP/ORFdkpZbO7Z4FRpV2J9nP3bK5HbkrQUlX/QQf3Ttvw1yelMGlaWYf4wbXfDkQpmzKn+QyGme+mGSb0V8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452606; c=relaxed/simple;
	bh=C69do44Y6CPXa9qM42rROUMKRetiWAaNbVY/wGziF28=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OhVVixj420GB5d75nnyqnLvzm/m6UBAmxtxSQxVUGYJLxHczk2OmTLo8TAeeqhLthxDx7TCiecRsOKvZuoTEQR/b3kevUQL2J6/eG2YFWPbg6A/bSZqlBK3eGFdE81WofjrNOxDl6RpKtdPsmZscfCejrAYoMgLq5NRFLWrOCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy9jSCEY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so4612110a12.0
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 15:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731452604; x=1732057404; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YuiEpADpImsrCR4exqTMJIH0ZxxdD3/tNotZLR0mHDY=;
        b=Fy9jSCEYN3fJOdrausZgMbzZuTeOom0Ykr9X91TFA83SnauWhJSdTp8wUWAwywCsMG
         aA//1CKRMtfLPOyCUqMhNqyUrTzd81sq2TMNXowAK8dbpLIiEIfPgX+Y2JaF5bNY+XnG
         0kefyNFgeoSTOJp0AlW2BysoJLrk/wngtRlZgBZLJTz5CvLJLFFd+yybxs9CLRgRqA4a
         LV8YxbMl2fV+dVFJfvQh4b9nwuhomD1LYUmaEhSekPzx1GveICLV9cf6Uj/aZoYVRoGJ
         U1Vcz/3p1JCRRNPFHuUvze0K/1BMK6xRzKDzFgPMupxbNK7+Tsdax/2poC9y5Cbg8lbE
         byuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452604; x=1732057404;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuiEpADpImsrCR4exqTMJIH0ZxxdD3/tNotZLR0mHDY=;
        b=bnqVM6e1WDcGn8hEW+H2QI2b3rl4wS3bfAR7428NvHpgb27DU7GzHr5vAjGySp17Kw
         d42fiMP7PKIaVLljI6tIELw/NpUMG181lK3NBAZBBdhhrbbPBoIUE9cZlUyM4C2U2otL
         qboBlNpsd30U5WX0IC27pBNqdrpC+GGb/fPbHQlfYkFyhmHE+EpJwuAnTboc5mL373xD
         figgzUrBf16S9sgL3mfHzrW8mdt+aX0V5mO/92gwkSRZweQd1VS8s2orBPpwDrCpOjtu
         Pp85V4RJpvA//XsxKfrhp2Ngwj4w7hmdGBu+13Cx93fU+lMSSBwxVGP2bzRMoHrQeAMb
         ewYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8G/j7MJ+BWeAVo9rcdqWvvc4Pk993hLpPA3jroCVIotHGqQfCfyZGF8XHpT/xats7XRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG1P3O9LLhynGKOaRZYBJRR9FFexPRM57D/bCNB0WrU/igsF7J
	eMNiTtwN4Btv97v0i3CzAY2u1MJxfaIux/bgohRujOd0tQrWTu2A
X-Google-Smtp-Source: AGHT+IEXhCSJBH2wJKKlD/Lgfa/+nrOwtJsf8cb09w3e9KWZojgkQwi5/w09FJdQg998mWGVmtGrng==
X-Received: by 2002:a05:6a21:99aa:b0:1db:ec5c:cae7 with SMTP id adf61e73a8af0-1dc22b35024mr28502038637.40.1731452603995;
        Tue, 12 Nov 2024 15:03:23 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f4895fesm11039547a12.12.2024.11.12.15.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:03:23 -0800 (PST)
Message-ID: <fae6da7518ff75fefb9b237af368093a848bfd08.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 2/4] bpf: add bpf_cpu_cycles_to_ns helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,  Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Mykola Lysenko <mykolal@fb.com>, Jakub
 Kicinski <kuba@kernel.org>
Cc: x86@kernel.org, bpf@vger.kernel.org, Martin KaFai Lau
 <martin.lau@linux.dev>
Date: Tue, 12 Nov 2024 15:03:18 -0800
In-Reply-To: <20241109004158.2259301-2-vadfed@meta.com>
References: <20241109004158.2259301-1-vadfed@meta.com>
	 <20241109004158.2259301-2-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-08 at 16:41 -0800, Vadim Fedorenko wrote:
> The new helper should be used to convert cycles received by
> bpf_get_cpu_cycle() into nanoseconds.
>=20
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---

Tried this with and without invtsc flag for qemu,
the switch between call / inlined version occurs as expected.

In the off-list discussion Vadim explained that:
- mult and shift constants are not updated after boot if constant_tsc
  feature is present for CPU.
- despite gettimeofday.h:vdso_calc_ns() doing more complex
  calculations to avoid negative time motion, we again assume that
  this is not needed for BPF use-case (two measurements close in time).
  (If there would be a v6, it would be nice to have a comment about
   these differences, I think).

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


