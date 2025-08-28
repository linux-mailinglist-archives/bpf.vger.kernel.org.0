Return-Path: <bpf+bounces-66885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36A0B3ABEB
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 22:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CDB3A54B3
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 20:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C3F283682;
	Thu, 28 Aug 2025 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PuxUaO9h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14C0258EF5
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414108; cv=none; b=s3YC5vEmJC6h7jUpIUgVR2SJYzEDVoeOj7lLKAxxmugNiGcxW+tMC16JFi0jF0/GZb4G3QHORyOL4qMGEa0c8V/Q6XSL+wV61G4VumVrjFPnGipFqxFPpciAjQXSNSVIvOxOPWJi1biwvY9zyhPdLc7nhs4n5fgAZY8xm25s+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414108; c=relaxed/simple;
	bh=61464PJI4DWr8JkU7InPmzajWChIA2O3MGIoKRnsdwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzg9JVRBZojE02LZoh0barItDSonZvfyL1UkefcxGongosrTEjqa8PPPpxtoanKS0CSy5dyL+84KIC6uPvFoPpkzZtR2CoHayR9djtc+JwRo1aTBnr5CJ6Zl1QhM5spOXwZdZ0dsCiHu5I6lYNcG/TF6O2Li4Tgo0jOw39IzQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PuxUaO9h; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afead3cf280so183207766b.1
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756414105; x=1757018905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yGc1B4o6TX250gyAUYjD7hu3uwBxPYd8xYyFmYM2QfE=;
        b=PuxUaO9h6Bem+37dEXMMW7UuxVqQcIvvNGqLtry1FMzUY/8pE2zEyym3z2/trunI4N
         u2nj2tsFXeChKqYe7tKJG9J0cfrvvXkO0KFFcnOt9iFNLAxgbuB0vEQxnMBJE/lHB6DL
         AHn0dB/18WxUnmpZr92/ip+tRxGCtvIxlzOcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414105; x=1757018905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGc1B4o6TX250gyAUYjD7hu3uwBxPYd8xYyFmYM2QfE=;
        b=CzSQ2aa5McxztwxCg6hOPrVCjGyeYBCEJoPq5v3jnQ+SX/CchylwfjF2DhDpdUFGPy
         ayRQS8OJol9GzLGDBfRa0aaRmweDWrZp/omKBcInthuJxiizG5/QRL7Kix0fNWREp2U+
         n9oKPgWdx6+7plAyaASX9+RtSf21hQQKc9ICyT7Wr+Go1xwif8itePxiR7ZDf7VUeLvn
         JhTnpkRoUpEx2mmoogxakOhOgwtui6nMcm3b0CznoVCnc2opBrpgq5eqN6CZNWflsCFp
         RKMYqfLSxEOafJMSUiXWq0CQ709D7GD+0Mnw5amKMjTxYfBk8TABbmqdQEuWmvp0zcke
         T6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXowkxUXN64xGyTLMZPz91OL5kaYvPBcQMH8ugojPmBnTB96RO0lA/hNx5zHV4BVPRgZus=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/cv3mmybvQa/lYosAdBy6c2aH5r5bf8gAhFa1mCxRjke2x0H
	ofe6zPxF8JGqju8F9XWWNc6SNWoSXMiJliSKvq8hSBlPKnPkVtm9tFrNfAZfKmWuqOwgc0QUC1u
	ReNEq284=
X-Gm-Gg: ASbGncucQ212YxvRT88lRW1sOxz9LPaRayFvZd4Mm2fkQYLapdBr8DMmMDmWwbh/4ZJ
	i+8nOSDlYLc2JmEisZrsZoNqUJjJBDmW8my2fQf/+2BYKhPFc+6v5tn0KVINoHFjU9cASbR93L1
	mHMzYIm5t4RuvYGF7JUxU0j6sOsZmCYMVS6xYb7+Ask7oPsko/nEYKLP8uzJ1ipDvdL1Biw//Q8
	WMfBCctmTwI0j9P5y3GWzs+TgJLsvEnA1586NKDg1+ckmQwU1BCmVTELyB0NociNs7ztWNPknG4
	BBPuFHONvE9E5W7TXmUZfva70wRsIs74/NcHOmILW5dtAXAKZwNMe3g+rXH4JSOvmOT5Z3qs7aV
	+wd+Urn5mD/sPzOwiYd4QxRUEt43m70VvkbKiCdKB1yf4Mas+/nE8/Xn/g0bMHpl+VaU4BbStbI
	XS3Y0mxaI=
X-Google-Smtp-Source: AGHT+IEWwP5HQTmuWnA9HhHg/rePnrnXjIeD221exf4AqkmorafnSm0Ccj7ma9t4i/wMmT4N31E8BA==
X-Received: by 2002:a17:907:720f:b0:afe:b9e3:2a19 with SMTP id a640c23a62f3a-afeb9e337a9mr839456766b.19.1756414104556;
        Thu, 28 Aug 2025 13:48:24 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c713sm38380966b.82.2025.08.28.13.48.24
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:48:24 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afe84202bb6so176472666b.2
        for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 13:48:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCtNi4vS8dFsm9n4hZpLmCZ9o6hfp6rA51/BzKYwc5AJS3xDpBJCNVX02kXdGSLVl+600=@vger.kernel.org
X-Received: by 2002:a17:907:da2:b0:ae3:f16a:c165 with SMTP id
 a640c23a62f3a-afe290466e3mr2506319066b.31.1756413753770; Thu, 28 Aug 2025
 13:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com>
In-Reply-To: <583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 13:42:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTUP7Xogf+owMM_J7GOR4O2RUbiQiL6gdwrKobhD-N=A@mail.gmail.com>
X-Gm-Features: Ac12FXw_0KhKfihCzO_aKUdUYEG3s81RDFh7edU8NIuCUQQEYmMIvEmP-xmYRFk
Message-ID: <CAHk-=wjTUP7Xogf+owMM_J7GOR4O2RUbiQiL6gdwrKobhD-N=A@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 13:27, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> The path name is a nice to have detail, but a content based hash is what we want, no?

No.

We want something easy and quick to compute because this is looked up
at stacktrace time. That's the primary issue.

You can do the mapping to some build-id - if it even exists - later.

               Linus

