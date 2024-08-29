Return-Path: <bpf+bounces-38364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EEE963B5D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5B2286487
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA511537CB;
	Thu, 29 Aug 2024 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKkeQHF2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6AD14C5A7
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912748; cv=none; b=V0xVobIb4kpgpxFHeLh9IBu1b8SORoA/mxJBoQqDizSEOrowS52sCoOGVkYsgCVdONJlB53FCi+GGrkt9Qnx5o9HNarZ0VVNLJToNyJvY3nkyJRHk9aRoklitmWn/mTh2PTpFkN3GLt+FSGoPIPyIilODxDCCDYyY22BFQSK+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912748; c=relaxed/simple;
	bh=Mhnd+MvzobaJdkzjSksn6RnfyRJEmp20fgosoNzctGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rrobv7+lMD8HZrgU3z9v0N9mo1RgtKbf5KJfe/Bvy+/HFIVnbfZVGzqvVRX6R/qZW+M8Nkfmns/rFViv6ifEvOnaEjctGqIwV2C9IB7JSTWttHZvMgNkbG6gYz1p+8RKEokjiiRDd0JLn+rt4/pi+JWE0CqPi2zke2xr6vCopgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKkeQHF2; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db157d3bb9so187839b6e.2
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724912746; x=1725517546; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mhnd+MvzobaJdkzjSksn6RnfyRJEmp20fgosoNzctGE=;
        b=AKkeQHF2KQUGR5W9uc7TjDzX4ShYYelbPGUE/gf2IBIj66dDsgpPm+3clQJ6CHsHvb
         oivQnzF/LKZj4BdzRyp7k4OcWfS6iMyc41cYyELUMwG0O7tXlLceoM/NSk/tXte28hDm
         pyNOWJePEHam58UEEDH5fQ3VXbuQuzOnueo3kcBi2idR5hCMC0HKd35PZJadmunS4XdV
         aJKef++MtipwaQ2Cn57Zt+MBwcuFz5D9XrkjLhdwMzRb+8mHIAnvZdr4itVUD589OrOg
         cISNlbFLw8l2ePO+t4g9zkEiDD/mhp6om8oASyVhRb3RBnTwgNYVOvL3vBJF12nEQzbQ
         jeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724912746; x=1725517546;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mhnd+MvzobaJdkzjSksn6RnfyRJEmp20fgosoNzctGE=;
        b=gk9Gp2SIX03dRY7n798M0Ku2hBqe3Vur/snyrSjFWUoTg7gZqT7ObWU2pvvKySPS2N
         5px/upkCz2ftm9wMWb0OkUpbsA29DO7R6iqJyGnqBW+bT1Y0dsByGji2q8ABOO5BolkA
         PqYo06YGyE3MWAyMeZfer3HFhUmYnlKCLvIH5aC9GrkCgBLGYEpin/vbv9BWCji22AVU
         1/nV+Kmf5GcAUyM/aDXH4gM2CVle4h0qaq2sUtQSP//bl5tAEISiTk48f9/cKWixVAtN
         8CHSh98zquJE8ilf5pQaN5DkI1uzBkk+5p6SwS0dnIxrDMcx7mQJsfNXo+LpXvNGHnxe
         VUwg==
X-Forwarded-Encrypted: i=1; AJvYcCUlXP20BGgI0hHyzZkVUMjaHLrkAIrXoJaBFd+7y0AXA/Kl6YYNdoXOQOFX8/bEN+J9dfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdrBYHeTyzwIZZmDjmtN1zfBAp09yQCnlFgoScvdS3GjKCaMG
	ZVSfxw+7jcvaUL7hNPhtMZc8phk61sfl7NBUaRbEc/4UIA+ECLw1PM6SCw==
X-Google-Smtp-Source: AGHT+IEUcKAi8miesB+cYap3FLF/klKNpojDrO6EQaGIfXGtsmxZ53M2x5hGrIDQKZo40Y+ELWAePw==
X-Received: by 2002:a05:6808:10cb:b0:3d5:5e18:cf32 with SMTP id 5614622812f47-3df05ef8d56mr2047003b6e.48.1724912745899;
        Wed, 28 Aug 2024 23:25:45 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9bf2dfsm409089a12.63.2024.08.28.23.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:25:45 -0700 (PDT)
Message-ID: <891c18a0c6dfaafc7d5bc4e910487191fcfb79e3.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 9/9] selftests/bpf: Test epilogue patching
 when the main prog has multiple BPF_EXIT
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Wed, 28 Aug 2024 23:25:40 -0700
In-Reply-To: <20240827194834.1423815-10-martin.lau@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
	 <20240827194834.1423815-10-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> This patch tests the epilogue patching when the main prog has
> multiple BPF_EXIT. The verifier should have patched the 2nd (and
> later) BPF_EXIT with a BPF_JA that goes back to the earlier
> patched epilogue instructions.
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


