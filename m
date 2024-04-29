Return-Path: <bpf+bounces-28149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B8C8B62FB
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2941A2821EF
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 19:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAF113F439;
	Mon, 29 Apr 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6SisbN3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439D13C3D3;
	Mon, 29 Apr 2024 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420693; cv=none; b=gC335b8tLuzEHWRxDEDwlwk5a24RiSVcJfVlNB6xrMtf4PwBj9s4S3ges1iDQ0w083b3GYwFZs8EqfomOFgAovG+btPKphkwgkHse1kVa89i0m9n293+BH/tJoa11cGiVqyy9hF6VJD+KUIzrQLh0JBkySifjRhQ+GwEmpgcy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420693; c=relaxed/simple;
	bh=uarQwPLkIzrmtboAHMQub7EbDIvk4lc3rgqCGLvSJhY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gdCUqV7pniD9l1IdyVMH1mcKDwzBw6yqO55DEiZTOS6MF/5AqUgBOFPrex7foYXxOI8FhybFwt0UTqao6cZNJ2MEsDg3v3J8yKWj7pwsiOxHlNSU4j2nmSUWdS4sffM/aypz9z/X4erWY0UVCOnFJOamRLZGBfzFDiXLdkbGxjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6SisbN3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ece8991654so4590079b3a.3;
        Mon, 29 Apr 2024 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714420691; x=1715025491; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uarQwPLkIzrmtboAHMQub7EbDIvk4lc3rgqCGLvSJhY=;
        b=i6SisbN3ENSIZZkCwiWt4Ic5wQ31oDPkKiXdqbolwEolF1k1ZvvjygcKUyh5kWsO+v
         u3m5PTZeyo+n1RXhSfFsEHuHC5AfdsQAjN9MLyc5ge7Pt3UxnAowy0vRgjseatywWHIV
         otyWbSnedWBMlPDSvch8antQAsRgmmzEBv/aEhgTZAn/rbyJDf2Xq53oELxRU/zC1onV
         06FHmCHc832dQZNURlkfJfABpiA7wDJkonOpGLsUiHEfpEG5aUiXojlz40MH8b7W2ltD
         YRoUCzz0WnjhofKq48SvGFfPR3EqAjq1Yqc4cFMFTCJPWBtew5IPOChORVpoh9DpxZFH
         pmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420691; x=1715025491;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uarQwPLkIzrmtboAHMQub7EbDIvk4lc3rgqCGLvSJhY=;
        b=YppQRqSaTPb6kozByxWTpv8eR3bgYJZygxHIqaZgchCvZSpmydSh4q5mhoJwVcgBQw
         m8Ir5gw/ejHP69Q79GruRpCUXRaja+/ooK13UPKdKpKvys2oNAn6CGv4zaL1Wj533Caf
         2C+dADGt1dw9NklVQDtbw2ze7wTLmX9z2HMz+X1Qwr5erKydWvoE3RpA6w38Se0ziHy0
         mhNixbstK+iMdyaLpx6qbr/tRdFgpHzePNrcpZ4zXYTk2xvMaRL7JmO+4W7Z4gyHMa9M
         6R3sVnn1SG8V/drIaROj9Ltd+UAa2dmW5V3L2kHf8TW9paeEQ1oUtId0wrecFRgQgo0C
         J4vA==
X-Forwarded-Encrypted: i=1; AJvYcCXyLy70Tc/+cZs2Th5obh66W/Cgm1jeEAjjLpSK2I+alEYXYzvShK1EodU0jfYLz4TEcTcyLslurPrtXu4mCGyI+1kJlPnVMKmUYFsqf+tXff8dEh1/QzOYMhP2
X-Gm-Message-State: AOJu0YzYwioQyrB7pv2G+Eeln1EAi3eCXLd3SSqHQB3AUmCthQQRNbLl
	ZUhH3AaamB67g5/UPt4lIpcPK778ZN1eRvZxoAa+66CfD2JG8J9Q
X-Google-Smtp-Source: AGHT+IEPfmB4SjZ76nyXE/HvH55UAdeNhhgyHpiEyrFWyGcvBgornzH01bcIOFrQQikdaYu9riyKtw==
X-Received: by 2002:a05:6a00:23cb:b0:6ea:e841:5889 with SMTP id g11-20020a056a0023cb00b006eae8415889mr15492752pfc.33.1714420691623;
        Mon, 29 Apr 2024 12:58:11 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:a18e:a67:fdb6:1a18? ([2604:3d08:9880:5900:a18e:a67:fdb6:1a18])
        by smtp.gmail.com with ESMTPSA id r3-20020aa79883000000b006f3fc8f143asm2952372pfl.139.2024.04.29.12.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:58:10 -0700 (PDT)
Message-ID: <13e873af1e2397fa7a9c3e19989784dccab27dcb.camel@gmail.com>
Subject: Re: [PATCH bpf 3/3] selftests/bpf: Add sockopt case to verify
 prog_type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev,  song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,  haoluo@google.com,
 jolsa@kernel.org
Date: Mon, 29 Apr 2024 12:58:09 -0700
In-Reply-To: <20240426231621.2716876-4-sdf@google.com>
References: <20240426231621.2716876-1-sdf@google.com>
	 <20240426231621.2716876-4-sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 16:16 -0700, Stanislav Fomichev wrote:
> Make sure only sockopt programs can be attached to the setsockopt
> and getsockopt hooks.
>=20
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

