Return-Path: <bpf+bounces-35468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C7F93ABAC
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 05:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70301C226EB
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 03:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCDF208A9;
	Wed, 24 Jul 2024 03:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDtn8+/x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F0210FB
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721793178; cv=none; b=FNo530XqEZcpgahxJCVyxB4qQriTxJB45uvFLoLwJzyW9bzziHezfmbbVWaR+rIuVGaiBQrKHU++JjPlpjtCKr7Ld+F/NWxKuyHjSMb7bqWc1KjjOlnWTIoYk5Rt8WAgPTM7AokG1yOLZTc7Lr+ln6jVf+XNAMzBmXXcgdiGHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721793178; c=relaxed/simple;
	bh=mg847i7vZJvYG1vbZVExaJCuiH70S5NJaS0sSS/8vTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbnZiJ4t2/n75+0UwXUXY6xBdIpyTiWlI3XyY1pxmZFt2r8JT8+M27oMik5oRPpE6K9ETfjAvkviPDo+WU1NKYkFv3fPsSDV9NtWkeR8Af8rWkBVz03fh6LDtRZq5pCBS0Z1x6Y2uCiI3wkXyDotuBMioN2YZTDwPZ/fq5iMuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDtn8+/x; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-368440b073bso250196f8f.0
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 20:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721793175; x=1722397975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg847i7vZJvYG1vbZVExaJCuiH70S5NJaS0sSS/8vTs=;
        b=HDtn8+/xp1vSVFVnd59afKzGfUD6aEWjmbrPnnckGlsC1l04Sws0sGvTkFeUTP3BVR
         xIhl+iibjJqJqWDaQnLLZs6DIb7Z7U64u0SGuPp1AwtblfwnHr9PvGy1k1WyT/p7aClr
         Wu86Tq9hKAOzuTNv/eXhk1l9svcQIpnCRGrsfJ1RTGI35fynCPPow0pHWiL/HAAoOYGp
         DgTOPKJN7b8JsbzXfgdosNNXoVi5LZKtEqCMaKd6ixB98KYDx+zDmcvmMSrUN6UG6tF2
         i1OAwKIMIVsFzPMEUB5nYF3HHFvAnwbB4KMzWlX8ed3DRUYGIwYEqox2kQGQKbHcBYbi
         maWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721793175; x=1722397975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mg847i7vZJvYG1vbZVExaJCuiH70S5NJaS0sSS/8vTs=;
        b=vYyQVaWFm4xx/QBk9k52NmHI2aM8JctnJJ0KaEFvJVusSA6PYQjVQ0O8RiO2n6S7at
         MgYhCa+ue++lJ/wnaZctfltt1Lqv8IKdQdI4t6/IoXUpnM8uPMbEFeCUCXQotQ4gI8tg
         NIIO7rkk9U+8U8ms+Kao5V6C0JPzR1rsLYVBdVS2pCZxmfQZyXmgFvqueb1xCsy9RUc5
         g7K5Tif8LxkT0Kd3PL2aoab/cFIVhzZbSzIDgmQh5ahoqRMKoyfbsJXP0m4nB0Vdnqzk
         vtw1CMDMpS7CdBr1EOh7DWemgZR2RQL2Tk99zOiYdWBHj7895t5JRMX2LFyj+SShoy47
         4Qhg==
X-Gm-Message-State: AOJu0YwOs6dV1yddQvcYn5Aekk4UY+Lv6ggYb9McHBChNRc6hACbRa6m
	qFEefRpNwbowsqc7tqshvQ6ZplpFxYHjh1t8oPCs5BQl92SeVw2y//S4QO+RrGwHklovjYBUqg9
	hKCe3zwtdUvYrKFRMFlQNw+3Pu4I=
X-Google-Smtp-Source: AGHT+IEfwoLATrXNMix4rHJYLZq3y3uUAijOk5PDgIzbvyZN7yClfPWPlLz4JnWz2XLKQk1jAt0uUiBgKfLTc1I+6u0=
X-Received: by 2002:a5d:4984:0:b0:366:e308:f9a1 with SMTP id
 ffacd0b85a97d-369f66f02d9mr321258f8f.23.1721793174737; Tue, 23 Jul 2024
 20:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722233844.1406874-1-eddyz87@gmail.com>
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Jul 2024 20:52:43 -0700
Message-ID: <CAADnVQL800=P3FthZXFQpF0g9b_438pNuV4tg=XRBxg-S3NmSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/10] no_caller_saved_registers attribute for
 helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 4:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> Corresponding clang/llvm changes are available in [2].
..
> [2] https://github.com/eddyz87/llvm-project/tree/bpf-no-caller-saved-regi=
sters

Applied kernel bits. Thanks!

Pls cleanup llvm diff and prepare it for landing.

Though we simplified kernel support quite a bit I feel
we may hit unexpected corner cases once llvm part lands.
So the sooner the better.

