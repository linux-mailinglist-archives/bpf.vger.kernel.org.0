Return-Path: <bpf+bounces-52557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6299CA449D5
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 19:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D38B424AE3
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B504819DF7A;
	Tue, 25 Feb 2025 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qb9jmgxC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921C19AA58
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507054; cv=none; b=C+NMJpEIRIusc17lpbwkRCObh41WK5tOGekNkamEhOLV/MNTiAPftt7CdeqZtT4FQs2a5CT7TUYFbxSY/pjZUiga5zIcX8x6Sz1F2WCx9dJ73lV3LFXPlHhpm1Fq0aTfYJNcXscnpWA+TmDll8sYSJPAYc8mxu6OxyPZs98SoDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507054; c=relaxed/simple;
	bh=kjWMAzTgcXz9lqDxqrMdi7XS8vWBWajX2O8PFs7oAP8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lKPyS5hUlOCLMFK4zJMgUl2neaY4xx0LrwuQpS5XqtbQQbbsSXJu3mRZYvRChS+LbpgHOyLoM3ra+SyQgI+cMpBE5zCEAg7Jsjxgar5E1fet+1AM+NVy+hMofGhxOqPzTdZLDnYrOk5e/3ffaR3Y1T9P4hW2kiSV0EctB4ce5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qb9jmgxC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22114b800f7so119833035ad.2
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 10:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740507052; x=1741111852; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kjWMAzTgcXz9lqDxqrMdi7XS8vWBWajX2O8PFs7oAP8=;
        b=Qb9jmgxCXE7OulKzLFDLG6c9/ENxsKMzvKWdX0OeesrnudGnpX419dTCh18kK58OB9
         nFlzQLcSEk2RY9kYX9GMgBuIW+NSRHbAfRtTjKtTZzx3AeKeE3ESGJCGNaLdlbhHHYxY
         pGrMNWzMEIjQim5zIPyXA+rr8Wb5hOAPsGST6NWBuexrGQh+71iCJ6fVoHzxEOdbIDeY
         jtBTMX0CoCjQCo6/eGhNj6qRRNXD6hwzEw8FVhUgLgYm4cQHoZWuLCHexax5ECJW3iwE
         exQgiaslUFDHnsScg2mYtGv6xf3AJR31wlNiNsqi0N1qdtscEZSraA9yXhJZHzTFn9C1
         YYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507052; x=1741111852;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjWMAzTgcXz9lqDxqrMdi7XS8vWBWajX2O8PFs7oAP8=;
        b=IaJSq00tefDGeQN32REhpm0H1UuXWPZOboawMjXAXqJSN8JPK1vEcCA+5Q5nOYTHuz
         AHLRv9XC8kmpzizVjqJyGINZZey9EBI2Z3yJKe3Onl2qvoHSbuWzFKDqh+ZtUnlqLi9c
         izqKfheNyW9rE80VCRfCes/UQWr/2ekq7RJJ3BRysdk+WWMJ67t+7cLphRVAgMP2KYRz
         7JAAHCBBaKSZURCfMhAjTwMO7XHvsjhQYuaah4i0g7hEb5jO8eukDAC0i1zfZNashqNC
         iz0cnfZdhrpGr4hzzoJI9CO2s35WRwC3Mvo7u35tcfrSP1HgSAnkQxCe9pAMexM2rlEk
         7ecA==
X-Forwarded-Encrypted: i=1; AJvYcCXaJIrvoIoNrMYB0oJeyugzVd7RglU9JmjD5SUbxmYwgK6OSAEItaag8bSGmSjqECKWYhs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/eeOVHhSNWBox6Xw16kAkyfkKAAKLrUN/riIVBS5w84pe4yuk
	gdmug+TK+gNrKd3MgsN9KDCXleq7xo4UAtquzgJ3vxY5ABz7u29Ws4hzsA==
X-Gm-Gg: ASbGncsrKHeec+ZsI4i1uE/57x0YNi/QTwGJDO5VRcdR7pbLCh17PZJlF1c8QM1O5NR
	UnItR29+4Q7SdtZHtuDBP2nYGCh+tejhBvov8kqVN38cHhBTM832Rxzz+mMHPo/Ls3lLuGgvYVj
	hgsXXPHYw1CqREK2mMjkCalTgJcpqS+wumlhhbY7HaoSXAcsvysQPIzgX5A3+OcAlv4+qpqcl5P
	FUp29rc1zW+m7zzeXlIB8uRQxKgbi+iK4pIL8Qnmw0zGCpskulYw8dDBvTIu0Xj291UAKGLRmOg
	uaYnICL005c5jmX4JosKjAA=
X-Google-Smtp-Source: AGHT+IHDdD5MkHD/9uIWma9DTauf7uNScOrVPYcwUXWVuyvWftl6txfW8S/yxiL+JjcV+xRLuTyUcQ==
X-Received: by 2002:a05:6a00:b46:b0:732:288b:c049 with SMTP id d2e1a72fcca58-7348bd91343mr507235b3a.1.1740507051964;
        Tue, 25 Feb 2025 10:10:51 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81bafesm1825068b3a.126.2025.02.25.10.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 10:10:51 -0800 (PST)
Message-ID: <9d5998c9ad76feb76555447b1a4560a2d740d18c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: introduce veristat test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 25 Feb 2025 10:10:47 -0800
In-Reply-To: <20250225163101.121043-3-mykyta.yatsenko5@gmail.com>
References: <20250225163101.121043-1-mykyta.yatsenko5@gmail.com>
	 <20250225163101.121043-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-25 at 16:31 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Introducing test for veristat, part of test_progs.
> Test cases cover functionality of setting global variables in BPF
> program.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Please don't drop acks.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


