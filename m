Return-Path: <bpf+bounces-76832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6116CC6529
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 07:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62E3D303E679
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 06:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC76335550;
	Wed, 17 Dec 2025 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZK7IV2V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC833509F
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765954740; cv=none; b=rFLYoQmmOciFPMrxdZ4wicfjt+EZsImSTc5cTvWyokuW0eb47SmzhghOkPTlI/5mOMhk43Eoz3WuGkohjfjtEsIs0YepLtQNglDsEP7kt9kW3QX2DQPPTaNFfUZR+C3iZEtTSaLWfUdWD7znCfDOnP5xD0drx62B/uG+iCAQWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765954740; c=relaxed/simple;
	bh=TMG8nxgQJJGY55IxuCHVO31lQlsO4XT3BzAZWxEV/6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DIWUc4jKvyGzyzQuU1V7O6UwEZh3sa0GSAjOdZkacy9FdmWqPR5nkyk5Ulf6NULDZrI7Qbst/z2cMqSoxZOnhjqaLnXI6ObdzU5zHt0eNlhkXvtHHKCOgCByy+eJ/znibIb101k8re8c5Ns+4ggAGElqWOtZ1YRPRLX1by/Hz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZK7IV2V; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c2f335681so3405286a91.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765954739; x=1766559539; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TMG8nxgQJJGY55IxuCHVO31lQlsO4XT3BzAZWxEV/6I=;
        b=TZK7IV2VoBIyRf+f0ZJpyIQ8Rhx8WC0uVdeXri5fTkvHJoQUqNaGWZ65maKyO1+8MK
         72KtCrE10aTBc0JlFgdVMqYzhjj8ARWM/N5zaRwp7NfFHv76vwiNbWJioQRK+NMWfQ76
         trQ8dwNnsZ7//fTmPcWVZRyU0jibcksMuzZ4//sMLZ6AmpiRdqejf9xtE3tXekfFpD8h
         4D5eGIoB7Bnr896FX4EhqUpCyvDX9WcgOVQBmCftVfVrCYNZvTlRq8WhBGMPaLDclCz5
         r4Rymp+R6FcT+DVSV5YludKsOTE5fyM/NxY0QATwHuFOH34/Z+EwfFwriNhV5qhl7c0y
         ueyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765954739; x=1766559539;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMG8nxgQJJGY55IxuCHVO31lQlsO4XT3BzAZWxEV/6I=;
        b=Vik3brY72ClQFGWzqNMO+GHcxg/sCGWYaZPqK0R9HjSvQ2zUQ5pIQo1IRpl5A3/qw5
         0qy0NnTwo27w4Vtgmr/Y9qfs4l1T5E5PYxSVPjGnUmYIuaT3R2QzkurhgQ5J9VLmD8yv
         D3Mii9M4RCRIWeSPd4r53HDqMcGmpZFzzsxKNKxRDQ1wlPo3PaAZ1xs8H4rkSdUjxGz+
         eq1xPHePk1Db679XuvPkqLcI9PZeiHF9KoEsL9zq7rD/yR6gQYZmqL2Bn5ngED/MEJ8U
         7beLU/0vBPZpGJ45IWWJjvTWfbATxJCKbMvloSOr8vGgSLBiJEmZJjem9q1QYQTshguf
         C8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdR+aCUisMor8FvKT+9IyquCJra4asWBT5Uh5qmpzNL+p8YjWTx2tOk8DlB3LV+WsWb7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1tAzZeirtyB8r5+J3CPhDB4yAIgTRKP33qO8grXAtT0/IXVls
	9+gC4HMH5Yey/bGTZD30kJSB+j/zy2iag26se45A2Y6Zh41Ux9y/nnVU
X-Gm-Gg: AY/fxX6gZEOusrq7NiU66XZ0qABlr2OSJCIZPgB6kvpdsbwSacWGqAFfC7n+nIEQhDR
	kHQmB4K/a6O52eqt13NO0sdLV3nj3lQedGOhJc6E7R3N75n7ZSHcACQ6sEqJBoGQhaGr21ZeGgP
	SbuonYK3oGssdVpOZmmEaq2OZYRCsoBO33MCkixDJSbQswU035qU26wzOxSGEK/fblYUK/tuqjD
	UEUY1NatN+Y7A8M8umw7gEeN0bnkcCIZAXuj8vUywMqdJ1Vmew+r4E9UO7KPrw0tmPtFG0gZzv2
	WL33tkRE4lWtTtCjzEo3tlEy2hZ42S/Fs2oJrMp5HBTysRXCsDDVoWmmdreRo8S+/RC3X7p87GX
	GIsOvocABQDxDGxYYwtk+7cJPwgJ2ZqC+MCVizO44+QQpYzNqQjfZtw+lsvzHBsuZk2TBqtkPNz
	R6ObJdBCdN
X-Google-Smtp-Source: AGHT+IFeArLoOzH3x1eOk4kiMFvyBwtJHxBz0FMA5XWWIY29iGgSIKFkDCVU3AZ8/XyqkjA+vbYKiQ==
X-Received: by 2002:a17:90b:1d4c:b0:340:54a1:d703 with SMTP id 98e67ed59e1d1-34abd8355f9mr14895617a91.35.1765954738586;
        Tue, 16 Dec 2025 22:58:58 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cfce5d3a3sm1370070a91.0.2025.12.16.22.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 22:58:58 -0800 (PST)
Message-ID: <d7c6325a12d0b0f56110a207f3881553849d60bb.camel@gmail.com>
Subject: Re: [PATCH bpf-next v9 09/10] bpf: Optimize the performance of
 find_bpffs_btf_enums
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, pengdonglin
	 <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Date: Tue, 16 Dec 2025 22:58:55 -0800
In-Reply-To: <20251208062353.1702672-10-dolinux.peng@gmail.com>
References: <20251208062353.1702672-1-dolinux.peng@gmail.com>
	 <20251208062353.1702672-10-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-08 at 14:23 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> Currently, vmlinux BTF is unconditionally sorted during
> the build phase. The function btf_find_by_name_kind
> executes the binary search branch, so find_bpffs_btf_enums
> can be optimized by using btf_find_by_name_kind.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

