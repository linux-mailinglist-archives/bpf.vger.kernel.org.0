Return-Path: <bpf+bounces-73370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C65C2D998
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 19:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C2104EC8DA
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 18:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE14031B132;
	Mon,  3 Nov 2025 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnKrqmyv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890821E0BB
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193369; cv=none; b=I7f+MsnJRgCmn7Aq7yrSGE2aQtLOSZf3uolQsIYymKHkJmCACJ0uBAAOFS6PD6YFt41LciqB89CZqrgPriSeEGTGKnKVCi2H8DI72zsTYni/s0IEoUTFIsZx6dv//vvvWxdJy1UIBt7C5qJsQiglbr9b1K8aSadcU8WQNeWJHNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193369; c=relaxed/simple;
	bh=dSZOek6ygkyM8kMLRCDVZKMdCPYWkaopn/XnCYI/Vb8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WUavSwq0lvwC9faf/rpbgLaWMtLMteda7r96R4QKuf8wLUgYjI3TFc+jtJ5NZk8D4lCdLrfN9J1tbHUvWUwSqq22BvceS1PAYBjSaSs7Dv21a6xtVYhUiD+pTUP5LVFGVVRpNHh+3Qj8Fgm98FcYCKdSNC1yKTbFaqa7YVlMXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnKrqmyv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29599f08202so19121975ad.3
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 10:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762193367; x=1762798167; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6GMq24IVk2F3a28aOoFMSN6wPIMIYmOKkHFdluZNlp8=;
        b=UnKrqmyvy6DUp++piPtr188PfaI7oNGWMAM7vbHHUoa8Z9eZ0AnIrrEfDDpRdehICM
         SoAstZCyWWNpzruPp7eFAMTwRquJwBlqtZL56KudJ8l8Kb3l90Nkx4vxII++gEAjpC90
         wkr+DtJr11CPMuL+LYZFP70v+H3ETgpNRqooepuWnrSZlFGu3OuFUkfcYWLnM9hNW+QU
         S8XAKoQ9pJq4TB+PeDtcBwoAZGrKV9T6HI3AJx2PPG1HqBz4Yhd8M0NDjAeDYdhdFIqr
         wJBRtfK87pOqOYL5EnjZWVoBQrCIMbKE/PacszEDIpNKzu2Yrs7zQOMPSNXizjJtOZQB
         mwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762193367; x=1762798167;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GMq24IVk2F3a28aOoFMSN6wPIMIYmOKkHFdluZNlp8=;
        b=NtUsQpRI5gez/hVmGkNpLy/qDbDWZVxxw7QcLeA8bptNEzjsC71dsRWQJ8caOOmxg9
         dB5cn5CbZJeWpzUPXZIml2Sz28sktWYnBhSdHQ/e+Pma0GKQmxp9JpsO+GAYUd3LxzR5
         LiTUkap7SWS2W4rEe80ZVOS9Q9gufK7gqIl3h5MNFiBl5KoGeuKBjH0R3/5peI7sQd2h
         RT6yk3iDXmn7Nf7cTk5OAj6/rktPpgT967zcYUm3HpiGKy8cKwpTZq3CkacnF9G505v0
         /SUrJKO0n7JX5HPbfppkslJmWrqdBp2IpbRXJihJ7mPfRLp3+OiJSX31AGYq+ZCUVsF6
         mPNw==
X-Forwarded-Encrypted: i=1; AJvYcCUUxvt9HyTyggPy+Rxy3dyGjLOce+2osR0rn3vqHqTIP48FPSnW0B0YW2ITqNAhf6pWNXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6J2vFtpDveSysRJOxWTwIK9ZqmV59Rz6uqI91lW5xak/E+8g
	JdTL2aCI+di2rGez6GJflJ5Jl9oIjZITRHMNUh4HdvLPrRU3jbeLMx4s
X-Gm-Gg: ASbGncvV0xlHAA+cQLZ6yJ/UqClIO3kFTHYwYK3T6h8sUXEagDlLbVoOK/jJ7i5G5ne
	qxU5hYi3nFEKdmeXshbs7XOzwVZf1MPOjDd/lZo6NtgtOnSCwe3cynmr/JDbIp5+lZNKdqTmnzH
	tuFNwJsgmmFF9v3fv0CmgderWCgSklKGTocuBu++LdGuR7JV1zCYmXdXYhe6GnPNh5/T8DspDAR
	brGnBrqC1aUOy+IOBy4ULrj/9HoH6JGM19myxgASC/0chqS78CezQ3TNwjqunNetOwwthUOCKSh
	bEg1tqIHuCfIpTwjivxsczzuNq9kWb8pGuFh4X9YMDyKxbhlJQNSO5mbUmytSP20m3PENOWK9OE
	B0hftIHf+i1IiDnWZGZ7/p40o1qh9FULeVAnIURa3QO13U7vhJOa7nMWl1ZXWYZ6zOTuSb1lf43
	FTYL0n1p8kkKK+mrNdXX7JLbchxA==
X-Google-Smtp-Source: AGHT+IGZrfXVBo54SYedR/Q9MDC4tdP/p2CLo6tbKfTLBQnHa03b/gxt/4AS9fp/eW4cLQ/lJm333A==
X-Received: by 2002:a17:902:da87:b0:290:c94b:8381 with SMTP id d9443c01a7336-2951a3905e9mr148631275ad.7.1762193367176;
        Mon, 03 Nov 2025 10:09:27 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3eb6:963c:67a2:5992? ([2620:10d:c090:500::5:d721])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341760c9476sm14136a91.4.2025.11.03.10.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:09:26 -0800 (PST)
Message-ID: <a584d6e00a7b78927debb828f252280777d2da6a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same scalar register
From: Eduard Zingerman <eddyz87@gmail.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, shuah@kernel.org,
 paul.chaignon@gmail.com, m.shachnai@gmail.com, 
	harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>
Date: Mon, 03 Nov 2025 10:09:23 -0800
In-Reply-To: <20251103063108.1111764-2-kafai.wan@linux.dev>
References: <20251103063108.1111764-1-kafai.wan@linux.dev>
	 <20251103063108.1111764-2-kafai.wan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 14:31 +0800, KaFai Wan wrote:
> When conditional jumps are performed on the same scalar register
> (e.g., r0 <=3D r0, r0 > r0, r0 < r0), the BPF verifier incorrectly
> attempts to adjust the register's min/max bounds. This leads to
> invalid range bounds and triggers a BUG warning.
>=20
> The problematic BPF program:
>    0: call bpf_get_prandom_u32
>    1: w8 =3D 0x80000000
>    2: r0 &=3D r8
>    3: if r0 > r0 goto <exit>
>=20
> The instruction 3 triggers kernel warning:
>    3: if r0 > r0 goto <exit>
>    true_reg1: range bounds violation u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u3=
2=3D[0x1, 0x0] s32=3D[0x1, 0x0] var_off=3D(0x0, 0x0)
>    true_reg2: const tnum out of sync with range bounds u64=3D[0x0, 0xffff=
ffffffffffff] s64=3D[0x8000000000000000, 0x7fffffffffffffff] var_off=3D(0x0=
, 0x0)
>=20
> Comparing a register with itself should not change its bounds and
> for most comparison operations, comparing a register with itself has
> a known result (e.g., r0 =3D=3D r0 is always true, r0 < r0 is always fals=
e).
>=20
> Fix this by:
> 1. Enhance is_scalar_branch_taken() to properly handle branch direction
>    computation for same register comparisons across all BPF jump operatio=
ns
> 2. Adds early return in reg_set_min_max() to avoid bounds adjustment
>    for unknown branch directions (e.g., BPF_JSET) on the same register
>=20
> The fix ensures that unnecessary bounds adjustments are skipped, preventi=
ng
> the verifier bug while maintaining correct branch direction analysis.
>=20
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail.k=
aiyanm@hust.edu.cn/
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

