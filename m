Return-Path: <bpf+bounces-59827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71276ACFB52
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 04:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB13C1897CB4
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 02:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE987081E;
	Fri,  6 Jun 2025 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPmsfDMk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E97FD
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177537; cv=none; b=euF1+vcezo7Zl4JmU6ueH3ezzgPeEMndNDr3mJUPc9xZ9ThrbW9yG2iTW6duHygFlvwMXU52mBXlubtLlVtSwrvhKDWrsRf4Sy96MUPh97BEfHjiFqRW/r0DRjxPpYqGGT9zrZcimbC0nDGY91u8hNbl7JpCfipPda++0YitYfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177537; c=relaxed/simple;
	bh=bESO2PSFaAmGa54BIe4R0M29N94dMigeRAClX0C81IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayMnezNybllmBTyG9M6vysbCIMO0pSL3G01JBnBzzsXTRtUH1lW4b5tmNvarBd0zM8OZcWqLSmZKyqizGc66Yv4utQfD3NkKmPocfWR2CrPn3TL/aTHP/VnJYQS0wV5AgptnM0hV/tLCbLYpIBZlyJDTsRbUx/ycsaYBTdE63B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPmsfDMk; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so18443635e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 19:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749177533; x=1749782333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bESO2PSFaAmGa54BIe4R0M29N94dMigeRAClX0C81IE=;
        b=SPmsfDMkvAn+yGv9VWsYKPNYzlBIpUpfdIVENCayn16Ad1Fd68Q5ZV1c2Z+HjwEuka
         yo9wEZKz/Y0c61m46Q+MO7sMKe4rYk+lTKdmAHupm3rPIWWfaypWIsYa2JRcYdQg2QrD
         /5vup99Ww+g/C60Pbfy54rM2awSMyuc4UHntyaCgMj15WdoP0sUin03NhtgKhhyr875M
         +aGaSkK11byXaXoI+ZW42Njxrtsrt6nrbqa7BCc9y8NbsLEAwWhwplHY1uYIdGmNFK5/
         aKDwzbNIPK8gHc+So0oJ6vRQii54zBufaAbevguXiNffu0p1nSmshVkCBqqmtPWeXu/A
         hhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749177533; x=1749782333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bESO2PSFaAmGa54BIe4R0M29N94dMigeRAClX0C81IE=;
        b=blNdedA7k4VTkxHFbG2/VA4+Ov3Trl5cM9MU/ZKZr5RxzpH7e0SqwPPP68IRq6AJBQ
         +79l4EwmHSpIXT3V08dju7VVAnmhDm+QslfnlKGQYR74KUB8qC3VLagM6lf+Dv+E9t/q
         U7+iqfnSZI3xI8/O7vpRxskTcJKsLOFfiCfamv/nyUUrm+9JP7YgwiGkxVUfd+cK1Dbh
         IpvpIQlxtwvdiNZ1m2+ZDFfGK+MeOPgUsYfh0TIvW2fRUmMlrRwh+RCh9CxZVYOCxi0G
         XZfFrcAfINzAljuZ13mXqlylnw6UnjZN1C38Bp5pTMHoVLDjbLyleZ42sdHhA2ss3ygC
         0vdA==
X-Gm-Message-State: AOJu0YwYvTqIQoh8xZiDyDWxWwdy26qlDYOiIHq247E7W94fyyVY/jO4
	9zok/qmbQVgICZv+0ZBpWeAppCh5nr7vSKcMB8nocovRPKzj1ILCjPokTCz/yrpRzU/RMpYlM6E
	hFbex+bG0Edcytsqs9BVzuyY7Zu0q3i0=
X-Gm-Gg: ASbGncs9XMXCIvWODpGEKKMTpJ15DaUbi/PVlDk8SSdMgmnVgyrB2sSdJrdm9kprN5L
	dOt37CtphFCoTZN3kV5H3Uy8PWINsMnVePUFD8MaDs9S7ITEpUNEgPxLFx7wNMAfoM2WIn0PdZn
	DxSHyVCzuAS4vvsEvXY1bufLRnuCMio1bF9W6nB+3Nd4iOCioZDainI9aMd4EPrzeAc11wmm5q
X-Google-Smtp-Source: AGHT+IHkAGnB6r/i6ezkJhv6tZKcxdkZJ/JywpUgpV1jQsIv6IR4++EWGECa4/Zha/oyQZsc87lz0l28IOkNDfdLQlo=
X-Received: by 2002:a05:600c:3b23:b0:442:e0e0:250 with SMTP id
 5b1f17b1804b1-4520141aaa4mr15882525e9.29.1749177532956; Thu, 05 Jun 2025
 19:38:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524191932.389444-1-eddyz87@gmail.com> <e8515c4c0df4857bbfdb8b8470421c73de67ffbe.camel@gmail.com>
In-Reply-To: <e8515c4c0df4857bbfdb8b8470421c73de67ffbe.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Jun 2025 19:38:41 -0700
X-Gm-Features: AX0GCFu-q5n0_5ZBUmHw6XNkgJbPgvzRJIkUKJtI36WkQjr7qACKiJP5UhyqoVA
Message-ID: <CAADnVQK-MSjYMB0WvwoHQ5+OJKy0binj4B554HF1Mw+tMU2iFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/11] bpf: propagate read/precision marks
 over state graph backedges
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 4:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> In an off-list discussion regarding this patch-set Alexei raised a
> question regarding actual memory consumption change. I developed a
> version of veristat that collects this statistics.
>
> Here is a comparison using master as in [1] and rebased version of
> this patch-set as in [2]. CSV files are attached to the email.

Thanks for doing the analysis.
Pls respin with that data in the commit log or cover letter.

