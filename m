Return-Path: <bpf+bounces-77716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C30CEF560
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 22:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B56300ACCF
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 21:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D7326F2A8;
	Fri,  2 Jan 2026 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T49e5ifW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021EB3A1C9
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767387830; cv=none; b=DTljTpx+FpiCadQqGmrbgZWKaZycKNpliyBr7yer+DMgAKpRKeoVXPCynHHTq4Z1ibkK03WEbPT8GbQ01TTAde4ZhlA78qUP8sU08LflJFLB3/hmfve1vKEVhkzMlFmXOBT4AFlj+eD8adzFfVsSyRaNcVK+J6stmjRA5O1uRgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767387830; c=relaxed/simple;
	bh=83qcuf0EMWV1a3Far5f+s9xO8CCX9uktV7+qF/tfMi8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HUzkg/wjK7ovVeN0a3Hdd7lIcQoDhcopSCY8dsyXlKRow7Z8e9cJvCETLLo8116C52Y0zYZevmKHsJbR4jswVhNHLyXzd1K2D3GSLz1rxsFmNx8YYIZt1qdxXDnT1K5LawSwr4uc4ocxBUkZTus4nR8+OHJkkpIwu/LrVTQBR0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T49e5ifW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0d6f647e2so200737635ad.1
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 13:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767387828; x=1767992628; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=83qcuf0EMWV1a3Far5f+s9xO8CCX9uktV7+qF/tfMi8=;
        b=T49e5ifWGJKRtyhzROUoXmWNAjw5ltTRsKrCLeSfMrmsSkfPu65O82hWP5dadRxDQA
         oURCrl/nHT3JWVU0n5Bw9Fyp5C2veBL5m4+LAOYqgGI1PjCeldn7R2JB7EHKY6LdzUeu
         NCK60vOvHOPHcquYd5Oi/J5P8UyU6n0Gpl1Z0CD2WOJnFB5A9LQrHyS/2OZLGKF0D+p7
         iOU0ssB8rCTk6eslcI8BA4/lXVbO1zE/pwc9PgPUxlq78hN65opF1HOHYsYaxYkcTT5S
         nS9PKEd2g174eQOgla8qhlk1/gUKrnISRxwoA9HfasTVbn6uqsAf0/2V9Bkbl5Y+EDp1
         aLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767387828; x=1767992628;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83qcuf0EMWV1a3Far5f+s9xO8CCX9uktV7+qF/tfMi8=;
        b=qyfLNomoXi6bmGwoZ65yKSpxejMEZun/pPsv6YbKh7B+TdQoKOzfEj2thplwbTdMvI
         argdD8VXtQvuPKnM5dDUdAnzkTFoGFYU7aE18oGMY+WHPbYiV1+zUjcIfjHcfRllFKKK
         lRtPiyhJiwVJhRPhOER89ISXKnS23Swfrwpr/KzytsjHjJpmpzUrUW8pw4TZajP/8VRm
         9YBq8MuiBXbgC/dNd01K6gPwDXQwV+Hq+7FjeFQGgvPRhDXE8jIkgBZGs6AVDyiEpqMb
         eTsaU6Ke4a+TEM6yB5vhqktyA/pZyM4utEE0jj+hiqY6/9PVmmVJvuPh02gUlICG+b9k
         EkIw==
X-Forwarded-Encrypted: i=1; AJvYcCVaI0SCr0IgcgWRzOMUKbpUSeuQqkB2KqgktS7tnS/bMLnJacIj3hvoDdfHbdC36mUxQ1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzli0reYtxw4LKKz+5yvIY765KDyDdIqqJKbF/IeowWhcH7HEuo
	Nayn0bu4TaBWSZUtMuWKrSGOHY8NAfYQPUw5BcpCTKcReg37OMLyip1P
X-Gm-Gg: AY/fxX7gUZCzDUflAKJlvgd6DjhKIOaVkDlw1anQHTzwfhkX8PRLMnLQToNUicroQ0y
	P92rEBjW6zwIzkHSY0v1CHIjfbaP/eGKP/wuPImghtg6Krpkaa9NB/YZGTLfscaFAWzvTA0WijM
	eHp+tf8ghdSKlhD80XDm0af88cEwZ39+GFUbQpL4dFriaTLOFWDGS7OxvDc4GnmUsNYljAyQdQR
	PFbqvd4UT6z67ijqxuRq+8xVit89pjXNWxLnaFkn4h7C6rHt61s+6LxkXLR6cO7qTO9pUdmCbL/
	ZiMGN8tBQEId8TRSEY1szh6O5u4peQhF8Dye96cmzMy5Cc7pR2GyfGoQGcCH/YhuFAnFOsJ+lv5
	z/EXUBAfl2Qbl20XK6BElhAGt+xH7xwCM3QGxZC8CaL3KISIg24sFcInDioeBw20cTHxhBuzHcG
	thOIHvmhVisorduUZPMw==
X-Google-Smtp-Source: AGHT+IG+SKaJOm1w1KH0JiqbkcdK09u247QeX+9VFIhk65hzA3yM2aSF0+9OiQhJkalUCoIFzkf85A==
X-Received: by 2002:a17:903:244b:b0:295:586d:677f with SMTP id d9443c01a7336-2a2f220a650mr365478205ad.10.1767387828104;
        Fri, 02 Jan 2026 13:03:48 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c8279esm378436425ad.28.2026.01.02.13.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 13:03:47 -0800 (PST)
Message-ID: <ec04d110c596af4020d831d3c602371ecf4f3cac.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Replace __opt annotation with __nullable
 for kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Fri, 02 Jan 2026 13:03:45 -0800
In-Reply-To: <20251231232623.2713255-1-puranjay@kernel.org>
References: <20251231232623.2713255-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-31 at 15:26 -0800, Puranjay Mohan wrote:
> The __opt annotation was originally introduced specifically for
> buffer/size argument pairs in bpf_dynptr_slice() and
> bpf_dynptr_slice_rdwr(), allowing the buffer pointer to be NULL while
> still validating the size as a constant.=C2=A0 The __nullable annotation
> serves the same purpose but is more general and is already used
> throughout the BPF subsystem for raw tracepoints, struct_ops, and other
> kfuncs.
>=20
> This patch unifies the two annotations by replacing __opt with
> __nullable.=C2=A0 The key change is in the verifier's
> get_kfunc_ptr_arg_type() function, where mem/size pair detection is now
> performed before the nullable check.=C2=A0 This ensures that buffer/size
> pairs are correctly classified as KF_ARG_PTR_TO_MEM_SIZE even when the
> buffer is nullable, while adding an !arg_mem_size condition to the
> nullable check prevents interference with mem/size pair handling.
>=20
> When processing KF_ARG_PTR_TO_MEM_SIZE arguments, the verifier now uses
> is_kfunc_arg_nullable() instead of the removed is_kfunc_arg_optional()
> to determine whether to skip size validation for NULL buffers.
>=20
> This is the first documentation added for the __nullable annotation,
> which has been in use since it was introduced but was previously
> undocumented.
>=20
> No functional changes to verifier behavior - nullable buffer/size pairs
> continue to work exactly as before.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

Lgtm, thank you for the quick turnaround.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

