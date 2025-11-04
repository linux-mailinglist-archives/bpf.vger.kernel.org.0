Return-Path: <bpf+bounces-73490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9944CC32B30
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 19:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253E51899817
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4F231BCAA;
	Tue,  4 Nov 2025 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7xbQROM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E31E89C
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281963; cv=none; b=Jsgivc/R9dWbrUM2DEAaR2B9Ue3p9SZfq3OR7G5aNDhz2Gtr9becyqtgqGgXs5v9i1GYSV1/bz7LO3QsILMnK+wj/Go8w1b2T+kc6j7+paR6VRCZOPhc6F0ujBrKZTTfl4V21IjYn88j3hgc9xbcWDI14FT809rUVlxG9GLQbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281963; c=relaxed/simple;
	bh=i9ZNiQpnaHMjkM4LhU5E3sJODB0VDFWaZt7kbXasisE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DPYzROfg55gmzlBWwJCx1hq2ewhY0uy1MFNge3HENCcYJ6apdAxm8pHbhsjIN8FtJHtiKNY9Fds495WWjobhhgICLaESvbUAHfct15IXmAz2p4CcBKB/CS3UZ5YKQPTyHPIDnl+QHCEKpifXUTP9gl47oFE4xYpkFHaLx4EDLOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7xbQROM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29599f08202so34158285ad.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 10:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762281962; x=1762886762; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i9ZNiQpnaHMjkM4LhU5E3sJODB0VDFWaZt7kbXasisE=;
        b=b7xbQROMrBP3neQhZFAsRItnUwyzxsG1Ch/vt/hye3Ch+YlFskxjcmrZRHPZWzzMDS
         bOCUsweSunWN2GNmpOl8b1+EDKvdFFUzShO1Tl0QZG6UIoLYJrJUdudhLmWS/mVlKk6c
         PfvYOvswi0yWvARM1pOKf1lG2ucGxwss8dikx2PHyC5zfvOU8t5HqIfNaIhWUuczvN1F
         bgatuDdMDsnt8LiYLhtRBCDyPor6s8wUZt8MYba8DYGWoFh4/aVopuI2N+IE6FB1KCYd
         73wJp6igD6MgUtwUIgy8Q+VXouZcNrAjrZ1JmiPHOgLKYbgsZ4lcnf6Pcxh1u/oR35cb
         vEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762281962; x=1762886762;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9ZNiQpnaHMjkM4LhU5E3sJODB0VDFWaZt7kbXasisE=;
        b=eYM80d7bmf6Esxst/gKGJH3x0x01xBqN9ZCZHNX8Zo6fpVjTIESFcixawZ4am2nUJC
         V2ghknmNa6lXDn+MZGHJ+G1EWDg59S7LVFjclq4ZeAOC1+G16T3EBBEngfjhALvlTlk8
         Z3r+kYWzenwbAT/xHmjIofKyJysqEKrXxhdc3oWbs85RxjT826OIqaLkchkgzyaMUbnb
         NFSIuSa0xyDLQccPRJ3/vZMUS33RYsw2Fw3Q5lmEqF/C2mZ7nWCqw3Xrk93qfqaHmwSJ
         0cJSYgbSriHJXK+RNL//j2IBJ8iQ98a2YuMgA6vGGqyuCZq8UHHugmIoirq25DkecPK2
         mh2A==
X-Forwarded-Encrypted: i=1; AJvYcCV4scuPDIOXeTqfQHSuFLOxiaaCwoPbErU1idaPe9DP3FgMCIEAlvP5bEdwn1J3mvsWI1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXqWBbTrD+B7PzRlZAohMSqeOj4+mL4tZ+x6OX85alCzoOOR/
	8/qeuwIAfhO7OcSMo+FjKL1/QN+xaHARzxcNph3NE/r3lGHU1k7gjOoH
X-Gm-Gg: ASbGncsq4eu6ybA7faEAxlwGzBpmkxKDlIiCjaK3RlDUJvSkBc49icXxPKb9hQ953Ot
	ireBenOoueGEJ8xSHWlXaJ83GLInKJ69j8SXSjmCNO0m8bomGWNUr3JyQltqCwDcUxrK0fb6kei
	jqk0BPzU3LqjCF2FALVKMDcKSSOfkStu7paPMwWzPOEF0jsK/3vV9mEWZqTO0eOCtFz3VfO08g4
	ulxRqQCRmA9oI2Pient0mlklFV11WySaeoVXFl5gBPTrjP6NEB4kWqe/gKYJ+G7kNkg7iyPlpye
	/jKkNVPN/VgAosCj4El7MqTOlrMkYm3Jo5uVG8+0zgLLSvcD40iqK/7oh7TCbAwfCvZpS4JvDeA
	E2Gth1xIYnBX76s7M1fNUIjkICPAA3ItOX1ruufilN8siXcrgjcV5ZoeF+Dx/P+/3mCuhilfSWz
	7Y9KcNu48SUUtoaXft3M4JEAE=
X-Google-Smtp-Source: AGHT+IGBg8kzSUU2e6hR9FidY3bCieUGG50bp2LmPZICTA0q7K/M7dZ96BUAtu0sdAVdIUBCA++Aug==
X-Received: by 2002:a17:902:e807:b0:290:c5e5:4d90 with SMTP id d9443c01a7336-2962adb4beamr7249845ad.42.1762281961607;
        Tue, 04 Nov 2025 10:46:01 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972826sm34497375ad.11.2025.11.04.10.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:46:01 -0800 (PST)
Message-ID: <eca029222d6084f15089ff91b31f35d8657cf417.camel@gmail.com>
Subject: Re: [PATCH RFC v1 3/5] bpf: factor out timer deletion helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 04 Nov 2025 10:45:59 -0800
In-Reply-To: <20251031-timer_nolock-v1-3-bf8266d2fb20@meta.com>
References: <20251031-timer_nolock-v1-0-bf8266d2fb20@meta.com>
	 <20251031-timer_nolock-v1-3-bf8266d2fb20@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-31 at 21:58 +0000, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Move the timer deletion logic into a dedicated bpf_timer_delete()
> helper so it can be reused by later patches.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

