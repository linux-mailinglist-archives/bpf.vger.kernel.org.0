Return-Path: <bpf+bounces-19247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC9A827CCB
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 03:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294541C232DA
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 02:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2828B23B1;
	Tue,  9 Jan 2024 02:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngIwQDas"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8820F2
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d8902da73so23170835e9.2
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 18:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704766574; x=1705371374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05GnswnOa3fKI8+mtz6RQjawxWXtRaMDdItsI0uqcyc=;
        b=ngIwQDasp0ymGBPb322vj5Y+Bm0/uREchjNSqCKvHRPKFvM+vvPfUUNeru01r2V4rE
         KIAoHlME/zJtAsPYQDCmaISxccGzYwVCunYyAiO82imUFOvWJPcndv/jl55zUlzaDurH
         MKd3exnGMapIoELlgDlpsTlYCc+4s2SYTaqA9wgguC8mbK0I338FdpgCfZZqrOUZrSNw
         K4KkvlwvAWOXcumKMMbAsZCrKa6LrRWkr7T6VUAKWuW06cna0AnQSq8U3zXmmuprD6mh
         ez8QaYyQ5WOtLZaLNMPYCPgai6LV7sxAqyUroVcLyaxO4y6wW7w3x3Vc3qNca+YHrP9X
         k0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704766574; x=1705371374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05GnswnOa3fKI8+mtz6RQjawxWXtRaMDdItsI0uqcyc=;
        b=ihm1wU8YV77DgxQ/7Osen1rUN/6xulyKnIxL7AcI0nq26MTuPzCGwwWPE4aiUo4rSS
         v82ByJDwJsF6UyUAIqT7d9e/z2U1Hhkgx/X5vyBS2M0g96RV9yrymF+yeReffmq/JULZ
         sZTsCF+IZyy0cs/Nd6iy203dD+6KwgoXzt9CelbeS9HVFoh3k4BtyWZtZOtdhbdcTzTi
         4+gtIoJCSvYVmV/JYu31LZM7v9npzVsDe9UP6R9/ja5KLpCEaWQ6OqwSHrm9f0SleSJ+
         kZ1SEoi+4UBzfhi1kLp+2uPyVg2PfAd1i5qWzDDT1I/SE0XsHq4MlpvZpUfZn1tfAUmE
         jEAA==
X-Gm-Message-State: AOJu0Yx/uaKgH7TLsN6IvqK9uSFbGVnfSC8Lm1yMIVCvxWKcyhMd21uv
	aoq4jokUM7nv1ybOw5uhpeD1tsRpHtQDeEZcyh1SXPda
X-Google-Smtp-Source: AGHT+IEEIJ9TAUJSJ7ymIiOcJUTyD7Cky7S9ewyqqmyZRT65dKu1c/kk9E6Ty9DKui4OH00bNSJ36afgZYiBNUwfp3A=
X-Received: by 2002:a05:600c:2049:b0:40d:5cea:895f with SMTP id
 p9-20020a05600c204900b0040d5cea895fmr2586700wmg.115.1704766574125; Mon, 08
 Jan 2024 18:16:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108214231.5280-1-dthaler1968@gmail.com>
In-Reply-To: <20240108214231.5280-1-dthaler1968@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jan 2024 18:16:03 -0800
Message-ID: <CAADnVQ+93dhSwOWUPDa3E5d6CPzBoNVoEsaCEq0PfWrxPYFDAw@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] Introduce concept of conformance groups
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 1:42=E2=80=AFPM Dave Thaler
<dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
>
> The discussion of what the actual conformance groups should be
> is still in progress, so this is just part 1 which only uses
> "legacy" for deprecated instructions and "basic" for everything
> else.  Subsequent patches will add more groups as discussion
> continues.
>
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>

Nice start. lgtm.
Waiting for acks...

