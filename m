Return-Path: <bpf+bounces-30156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1218CB46B
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 21:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E5F1F2348F
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 19:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A82148FF1;
	Tue, 21 May 2024 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7ix+HRG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6253A208DA
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320915; cv=none; b=DU0qqkxSqRPbZgFe2qOFGWOp4tpY1KLONy9BKzp9RV+jflBY5DDORMCFAzOJMi2TKr8sxy+iohoLdu32uw1gQfzTYzMLUTtJO4gOnWSlDW1Xfxu61mPvkOLHj+zHc9zPAiCdO1cQ6r+28CgCUP5eMr3Vpu625VqHF93VNwx7ib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320915; c=relaxed/simple;
	bh=XGNmuR5JLkdaAM0dS7VkdSEoIxfzyTT4/Ww5VlUq3cw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J/d+a4OJljcJFXiGSA712HAw7Ne1tThsLD28r5aPsuMTA2UiiNVbTp4VJjT1CUL3XMwYQPyPVaTr0RdR7dOaK0wBLlqa9hEj6YgLtgzE6YDE7m+txOb8tyGKytXWajfdGfgiAMUDzR0MRZhhv6iUTeRnaHxRubzxxcuzio5YzGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7ix+HRG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f3105f3597so16985805ad.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 12:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716320914; x=1716925714; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XGNmuR5JLkdaAM0dS7VkdSEoIxfzyTT4/Ww5VlUq3cw=;
        b=Z7ix+HRGNr+jfG9Pp64ppA+JJIAdZjKkb5842/qmlXyKOxs+eFZjYFcakBZm/2LjUG
         niFE/db9Zv/Y4E2NfHVM1LYxWZKCV8MFKXbpEWY9PJveGr1iivNwTHCX8yuoRdHUrkI/
         r2ah2rfAi62zP0K1gqcQccZefa8EAajnln6M4qnXz17uZf7bCJ4S24UgjI1fXEFeH02Q
         yd9K26BJcnWyC6RSn70vO2J6E+H/kjQWCWTrSm4EH1NXPv1i4kkdMQrStcgqerUifSwm
         OAkcw60AY7W2Jyvv452y8O6UJlpZumEkCgz6WcnMRtptnO38D8JICGM6cwRBPHYjNH/4
         BZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716320914; x=1716925714;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGNmuR5JLkdaAM0dS7VkdSEoIxfzyTT4/Ww5VlUq3cw=;
        b=mx7fO8+Ts6FVAIayd7h6LSDvyleL+vDkNQVb2QexHQEgxvvIV1SfeKAM7Y740bi90f
         NZ2LnPwFXshPnfTngjmOq08QAB2apjQQy+bzh6ygZSFTAqa6BvlyDkAZgmyDMobIzycW
         tSlKOukPx8dQr2fgqsAlfUH6mVTeqkbA1g0iJFIY3daTo6Yl51xLo1WtMgrQ4T0zL6Eb
         VMIqI/oPHqZ6CJU4RmqX2fmDVPL5xvRMsFJbyGPs2FzaGcM0zvUHZJduW1dG9lkLVHj4
         pE6k7e8cATm1WIMpQwWq6CAH/GcTw4xBFSD1ErKa7QE8nQeD6Nubc2lUrV9ASXiBua7u
         Ga9Q==
X-Gm-Message-State: AOJu0YzCPkFbBxARvkUQx0ePYkxCv9klE7hcZUDUnrZgTqEfBfcQyyhN
	bKzvhRGAXclyC2tJ2yQEP7m+wVF+m4bXboljJ87DRMhbL0YTCbljVXAwIKmI
X-Google-Smtp-Source: AGHT+IHFOy/UXs41UJLi+dBwuWOaLtyubE41zcInIdOxs0MM0EofVyy8aWpC3turgA0F/Xhkv8iDVQ==
X-Received: by 2002:a17:902:7248:b0:1ee:2a58:cb7c with SMTP id d9443c01a7336-1ef43e26586mr319055425ad.35.1716320913651;
        Tue, 21 May 2024 12:48:33 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f310957fc5sm15026975ad.139.2024.05.21.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:48:33 -0700 (PDT)
Message-ID: <9e85057c1300c6ff2895f84580eb7e758b4459cb.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: crypto: make state and IV dynptr
 nullable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>,  Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org
Date: Tue, 21 May 2024 12:48:32 -0700
In-Reply-To: <20240510122823.1530682-3-vadfed@meta.com>
References: <20240510122823.1530682-1-vadfed@meta.com>
	 <20240510122823.1530682-3-vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 05:28 -0700, Vadim Fedorenko wrote:
> Some ciphers do not require state and IV buffer, but with current
> implementation 0-sized dynptr is always needed. With adjustment to
> verifier we can provide NULL instead of 0-sized dynptr. Make crypto
> kfuncs ready for this.
>=20
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

