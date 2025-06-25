Return-Path: <bpf+bounces-61579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F20AE8FB6
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 22:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E67AE44E
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDD320E00B;
	Wed, 25 Jun 2025 20:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K826rGaN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2D1202963
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750885030; cv=none; b=B/Ry+kz00T1bPiNx0JSnZC5CBCdjozg55YQI6Tg5uwsZrJHg+uLeKV6/K78wQ2GWTeyVhx+YN50SYCTXdbeNgjY1xSLvuzmu0DaSR8vDd71H019u5UP+i6eEClnECKsmVPUMEB7T+6S2tAExyHc6RLKA1MgoLLk1uDbLe6d3JiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750885030; c=relaxed/simple;
	bh=JZIC4k4/lHD7qkgrekEeCxwyqyrNA1ayx+SD8KE4zuw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uu0Egp7iKfLjizCg2UpeVpDFrPS/RJLg30KJaVPbjweLxCd63r4BDaO05oSkRhf8LDFEl0xNbyb3wncolY3Kx2F1y/a3dMqdm/yRX0qZI3RBonPrihCkcCMb+9nt+QFFWiIG3Q4Qg/Q86rLlURe/aFHCsHpdAmckjHxE0mBmJAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K826rGaN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235d6de331fso4998075ad.3
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 13:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750885028; x=1751489828; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JZIC4k4/lHD7qkgrekEeCxwyqyrNA1ayx+SD8KE4zuw=;
        b=K826rGaNbONBa/SbFWOORwd2VpRjhrcWyQ7jKcYJW7BrTeVXHDh+sua1gNKs2vGl26
         VT2WmB05CojgK9cOebODj1v0UdKMVZqbaf/ADuTqMXJjNigmCUvJXZm07WPcjAiVEVVA
         DNgNfVQtvJDgM8dHQ0kw6wdnWG3DwyeCX6TblbW/yVrk0N8wtdsK6to+3ANqW7br+U2m
         NJreXkjF7LqocKlGSx8OzhR2Q1TtB7NprdluK7xYp3Hd86nhyxIicCKMo9ukkqhWP0hx
         klAj2ml61eYk+H3pz+6w7HuU1vbBEaRGhZkyzWrRb50P1DVla5r9WLXOd3J4ZKYoFMwm
         zy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750885028; x=1751489828;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZIC4k4/lHD7qkgrekEeCxwyqyrNA1ayx+SD8KE4zuw=;
        b=raU73UNfYrmCX49bymVxokA5UJwqYnpFx8U+le58gYAFKi1ku1d9r5P2gy8U/GwSTt
         ObdyhqCyO8M/iie6hTDv1ZrH0JZ/CI5rz8Fky4dBqX+z2U61N8icisRI+tIclaA5+BOZ
         p1jv9NwOq6rz666mwEg4u8HCGl5Tcllr+aJWcfDwbx7tfbFcBV5lYqrGkxL6csUWepJk
         CfYQGKI/R8cuLQOBl+FkDYWbMYIuTwLhsCPhgHzOscTrJ8Hq2nBCQLoPScYSt847RkRp
         7MteBgLy009RQmnHkZ4OFH3xWXPXz8xKYGjKF5C3BbR10blYGhI+e/wKefBO0LiSlswO
         DrrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTa2yXfIC9SFfehEe13NCFR+vz4tw6lYxB9hbl/3syQMjeQfuZhN2PL8CEdlbCEMtvLC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+ZFGLYk4sCRnexMSRGsBFSgTq8v1o+IstUnwx3Qf/FB7DzOj
	YlwDbgTGvbIxMWON2fprNlIxPB1m2xAIl6PhGd+/VKXMMQvwQucjMPEbDEVE1mG5JFo=
X-Gm-Gg: ASbGncvj/tfaYu387I6unPDN8AV9Mhyd6L5D9Uk8X5Mu6JYluJXlZqDVhOPgPaALAv3
	j+GZp32D5nYniXVOQXn5PhHq80FRpcPKXgSkKNV3klxdTq6JCx0VNpzuCzJTML2ykCuo48AAakF
	ziHNy75KFIqx2CrHjYcfu6fX6fCh7b2eXTUa98hTI+EkU04128KhO1n/FSyqTUp2Ii7u2uG1bsE
	FV67vbBJASRFvFNshSUso7+wgCPAV0hMCp1vOKZvNlR8F5uW9hEPFYvXiKM6mFl3tFvqWl5WaK+
	O/TelgB9vw3pxZTT5vIKMXjusWNoTU669Zgwll2TlXAlztRVvCeAaW1vNJk5UaNniQjhNRJEMfM
	K/Sg5PLO21Jo=
X-Google-Smtp-Source: AGHT+IGQGeM6UL+kQ9JKE55lE8xXLcYIvxaA1XPaDlc44BIqYUEa88vJA4Acx5tNPYN/XHa9SEo74A==
X-Received: by 2002:a17:903:2a87:b0:235:711:f810 with SMTP id d9443c01a7336-23823fe4dd9mr80382635ad.23.1750885027810;
        Wed, 25 Jun 2025 13:57:07 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2bd4:b3aa:7cc1:1d78? ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83fc120sm139194345ad.87.2025.06.25.13.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 13:57:07 -0700 (PDT)
Message-ID: <91c433611054e3cbb3ba0116127437c9d45a1f93.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: test array presets in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 25 Jun 2025 13:57:06 -0700
In-Reply-To: <20250625165904.87820-4-mykyta.yatsenko5@gmail.com>
References: <20250625165904.87820-1-mykyta.yatsenko5@gmail.com>
	 <20250625165904.87820-4-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-25 at 17:59 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Modify existing veristat tests to verify that array presets are applied
> as expected.
> Introduce few negative tests as well to check that common error modes
> are handled.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Please don't drop acks, it helps to navigating the series, e.g. for
this one I had to diff the diffs to figure out if it is the same I've
acked in v4.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

