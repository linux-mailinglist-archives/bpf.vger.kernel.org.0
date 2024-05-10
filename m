Return-Path: <bpf+bounces-29491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 845488C2981
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0CC1F23361
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 17:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4C20309;
	Fri, 10 May 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jfuFEdBq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BE1BDC8
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363105; cv=none; b=n0Gw7MdWmMsbgpzoDLUjivdWj9YoGOoytBQ3GX2DX651O1h+CuKYVWdLDwiSUZQUSXjkrGzCDVVqFU8uUTuYzIVNvYUZi9Ta68UFibLFChgPKHpskcypXKYsL5EQpSmSLJ80YGkMrLg+4X48RQeNg108FRCT6G0GnBP/K13Hheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363105; c=relaxed/simple;
	bh=77jCAZN4T1MnK/eg9Dn9s0HYNi5Gbz3bp+wgywtPJ8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5L0cIHeYols9wm02m9xLE16euOsUcve4R6divldA+CPxadT8I5Us4HCe4Ml37N+RfARACh+pJr3Zh5GTRSQpPEgvGUOK5+PU6/mHTSZHcnowy1R9az+WlvJn40KypUiCHDhVb3Gem4jWtzzzuqqaCGZHrUxvVoTLTbYjKguDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jfuFEdBq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f467fb2e66so2090722b3a.1
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715363103; x=1715967903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RH25751FQUD9IraRYi3Ng4hTjnmqYgAtJrim8UnR4Lw=;
        b=jfuFEdBq40eHLbgJonwdgyHWGexUVHfl/U2WW3h9qOJOjLZNjcnA4rmlz3LsW3PY9l
         lLHdaQ/U7kZ89eZzT6755BvDnteknBtwwOq7Ax64FoSWW4B+//LtSTSThtqsdIR8FVtB
         2SCa3WkY0z3T2hVv21Ck9YMQUsl+7up5H4s4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715363103; x=1715967903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH25751FQUD9IraRYi3Ng4hTjnmqYgAtJrim8UnR4Lw=;
        b=SQrYsIYT3VMKvzDRe4UCRSX3FF/TbmgNnb3opHhC7xRD+zJ+jjMmR5c5ie+8r93NoY
         Yh9ATnMHZL98Gt79k8QlBCtpuQliDNDS31VsT8KCtnE37T/0hibf22Gfwlgi3t3nREux
         Qj5Y4oYHgp4uEgWWwEumBWzxRso7XijdBJqqbY/fgxiWTYWAhXv2GVPbG2N4pBoNwceH
         hAqwPVEHY9QCRAxLKO0FNnJbHDN6WErUw7UFgC5EzWvwVkBVzZgkxUPTC0qoKcwBhZFy
         wBCuBH01holEgzGV4JqEmn4pLmaH8CXM8TNJ1Y2PsZmqqajVCwH70fIb4EfEZtv69u3p
         QN1A==
X-Forwarded-Encrypted: i=1; AJvYcCV/qT31ydOkZ+0/SRxEJiE8uq71j0KKq4dV4JTcQad+L4uMjfAp+7PpXxaxNi7586BDZ3vEpBuubfNTs2dvf3+seHxK
X-Gm-Message-State: AOJu0YxKNg72X8NNH3TMnKwoyOq23I36aw58RVXmb8dzPbkkYEf/AkdQ
	J7qr2yp1N+loy5x168rCclCwjvBTUbb8Mr0q6C2McIjlxAWouyJ5HE5W5ThIag==
X-Google-Smtp-Source: AGHT+IGGFWmKinmr/BozpgZxQxrIJHVGNpMfgrtBUBSomrJR7j5qbTiNJokxk2pPxp48vFhrBfY0LA==
X-Received: by 2002:a05:6a21:3405:b0:1a8:e79a:2b0a with SMTP id adf61e73a8af0-1afddf036eemr3785881637.0.1715363103156;
        Fri, 10 May 2024 10:45:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6341134706asm2937275a12.86.2024.05.10.10.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 10:45:02 -0700 (PDT)
Date: Fri, 10 May 2024 10:45:02 -0700
From: Kees Cook <keescook@chromium.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com,
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
	John Hubbard <jhubbard@nvidia.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v4 55/66] selftests/seccomp: Drop define _GNU_SOURCE
Message-ID: <202405101044.DB260BB@keescook>
References: <20240510000842.410729-1-edliaw@google.com>
 <20240510000842.410729-56-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510000842.410729-56-edliaw@google.com>

On Fri, May 10, 2024 at 12:07:12AM +0000, Edward Liaw wrote:
> _GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
> redefinition warnings.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

