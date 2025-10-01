Return-Path: <bpf+bounces-70164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCF3BB1E76
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 00:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5419C2ED1
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 22:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33B4237163;
	Wed,  1 Oct 2025 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La3mmQbQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CDB2B9B9
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356192; cv=none; b=WcNezhrCa89mXxQFzbqtHPxXkw89FPnU7hSvQ8KtnP7jtei2ZGnU1bPPEYA0cR9yIVIeAREOE/t/wmh9pGo0BEqQwAohxLsXyDTVcSCLaaGzgerop0Idqn2RrvKrtTKgTi7ee1wEFIgbV3CgNpHbDgjfWxCKbA68hJbuxf0Yr68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356192; c=relaxed/simple;
	bh=tAlVNEkolJWVUTWYOYLwdNeOeCrLCshPDZ+lnRyRSII=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LHFWHlW1c/6pkaBJJas1yGLcjEALW6jxaYSWKTcsBX4EyBOnQH1pcuv4narIWAyAxlf1VXiLPIISy5+gKkk4QASDCLe0dM/n8nX8/ZrjbgSuhdnFIXplMZWB6UymGTLcWNoMNp0s4p4ebIXSVAIU1pg9cVURUH60cmGV+CQKSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La3mmQbQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so598781a91.2
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 15:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759356189; x=1759960989; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAlVNEkolJWVUTWYOYLwdNeOeCrLCshPDZ+lnRyRSII=;
        b=La3mmQbQVxLaZW8uE2RjOCsJ0Ek4uWKVId/Okg3xEnfs8/Z5F3orqOna3MKyYCjTuJ
         5sWAB8N7zIEv5H3FqipYCQvQ5YqvAMsaQ2S32nEKSsruOrdKva6TutRP7PndjANPFniA
         zh+wDMBMn13XvjbC1vhZL8WvyXX9okvIyd3I8ohLKgjXvUqe/1EXhvIQRotwpOUNx0kt
         Dg7aQzah/qK98QsOZXl23R3ZnsjLHPQT5PkhlaCTkwXUaPwO7wp0SmHSHI2qZ/BKbwu+
         2zGouEud6Sglt6wHpF9PIU8eW63IyenmsaFm570LAOQ+ZRGAANeYyMd3ntVZgxbTDy++
         7uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356189; x=1759960989;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAlVNEkolJWVUTWYOYLwdNeOeCrLCshPDZ+lnRyRSII=;
        b=iJNLPloWpmE8yjxWkOUhkojSkyPsywQ8RihamwDBBlgcaV5VhQLW36tuyk+8F2pj+V
         LTgdZ0PK3aJsg+2VHYntQjxu/CPOal0C9EcYVLZP42jMrOk7BGWqMS6zMCrux9uEN/w/
         kv66r5iEGi1SMk78gK9jeu60NBDFDi/53H5m/qQzraQz2Zt16JKIsYLp6CUIIr+aZhli
         jtjdYBhEtL2+qdARGXDfqxRQ8sxl36Yfc4aylcoGwPxfMiIBg3FLqnGUnmzaGoMVg+GZ
         W5+5jIg0vMjpvuHhOuTTd6ihdeDmJDSpTV/0LfL68/vBi8fN/ZoAB9shD0e4C2th1Lxo
         ECog==
X-Forwarded-Encrypted: i=1; AJvYcCUCPTn6dWXWGPRb2dFXa8NZOExul8J1wE0U5sTuDl1ihAbb8eTTNv4YxYBTTpbwSz0Nhug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC7NNUJ9+HIUxgrqE87I9eLgwkd8m4iJAkPH96DWpGcnh0Og5j
	ILWDvnKFlCYd+BuBZVplLCCx0JLX50Y/NlOrXIKBqGjA9mqn3XfhcAr6
X-Gm-Gg: ASbGncv1wCN0HFWxUV3dGUovaeP2iX0YAlvuzqAqWGrhjCp6zZlK+Qg1iAMK6knDkHZ
	Sb8F4jdB985vC8d9wLC66XriV4l0qbZhlh4kwi2KZsHh7jPbWDPwa40dqt0L38qHoW5Oz/Sv3lj
	B2nyQEodZKsDZp6dRtmJcbJeKYb0hBgXcBAu/GtRPQnSgMHUjFDTj83oftrowkl1oaJc7RWJkzF
	DlLw5tTiC9izdZfdLXvRWrQSyyqpcxbuxAdGO3h7yo/038JyGCuAAEp14vW/ExywbeCqBh1F6Bo
	6aXFrFUUAr31pLEtkKRs7H0A9cWwexUyXZhrbVsK3LByYJTRXuMfMrHWbovyO3yRBZ+8T4w/bZu
	/jtHQ7Vj5MrLSP/RjtwZHptheg0r+HIChv1oRkz8AqcEDWbsLzqeti90NWpYO3qJ9R6ccKf4=
X-Google-Smtp-Source: AGHT+IGnx443duojp5p5PgG2RE/KL19s7YLnOBIre5rYipWNe8r3Te0orUwTFHtGyt7wzB4pDv9Jcw==
X-Received: by 2002:a17:90b:4d08:b0:330:6d5e:f174 with SMTP id 98e67ed59e1d1-339a6f06b08mr5823283a91.20.1759356189131;
        Wed, 01 Oct 2025 15:03:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4f550fesm669025a91.22.2025.10.01.15.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 15:03:08 -0700 (PDT)
Message-ID: <8a71fd65cf8450efe09925f4f5f271bca3b9da40.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 08/15] bpf, x86: allow indirect jumps to
 r8...r15
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 01 Oct 2025 15:03:07 -0700
In-Reply-To: <20250930125111.1269861-9-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-9-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> Currently the emit_indirect_jump() function only accepts one of the
> RAX, RCX, ..., RBP registers as the destination. Make it to accept
> R8, R9, ..., R15 as well, and make callers to pass BPF registers, not
> native registers. This is required to enable indirect jumps support
> in eBPF.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

