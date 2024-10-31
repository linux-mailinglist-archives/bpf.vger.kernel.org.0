Return-Path: <bpf+bounces-43660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4499B7FD5
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 17:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9711C21A8F
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661441BBBDA;
	Thu, 31 Oct 2024 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="el+SnhpX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ACF1B86CF
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391549; cv=none; b=peVcrbHckHQOGCfLCGgKoik9l3NQDQRMt0VrCsjTRyXm/idSKO+fi7EPVbXQTlPcCumayCHj1wHqRi81+vlyMVNSnS+d3MrjHKzn4cgexXGU/ecfmGu+bN1PXXSANKCbvsQ7euAtxKTTydHWDOn7Eh6Y6DHhoKGDSBGah5EQfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391549; c=relaxed/simple;
	bh=yFWSmwfok6oEYTTLTKkQ9rZWC2l0aHvY4z6ZJ+NQcCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=polCnB+oDeI0cNIIIBWaMBjX+w5vphqJLpw/pGojgfBEWS5F2GP06wO8A9utKLCzd+kO7+YUer2y9OPs6HPRbif+cZrE6gqkydZokdNwkueoMpLBUD5iQIApRHBgZxkcDbAU4y1i+A/72NlasutAr62nyvd0IZcnFWnXmBZA0kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=el+SnhpX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c83c2e967so1363975ad.1
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730391546; x=1730996346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjLvyMXm9JZDYRseN0Kp+gNlDM9ARjQNJ6AjRKfsYIw=;
        b=el+SnhpXLGdThIHmAg93So/sSCsGkGv3wbCgcL4qXSNxrkCCwKDN0XBaayxDiPwGXc
         YOovLShvH38oOAPN5+vNWRYfZu3yly/29Yf+bIh/1A9PMXVdG8wYmKy1i6QCs89oPlOy
         LscWrPSFBaenATWRLIVMP6ZK3obt1MK0/dWqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730391546; x=1730996346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjLvyMXm9JZDYRseN0Kp+gNlDM9ARjQNJ6AjRKfsYIw=;
        b=aOFUqBc/GE+VUockpvy6nmBZTJEbDfl3VOFVb7G0Q4TqSSPPKVEiLotb4hEtHHYCNi
         FDKw9VEh5WdKNAfnYr35VSIqcVfQdRz7ALOkHIa201v4Ppai1NKW/cgzawMvu10O7D9O
         3B/bZRr4ljis3NJ4U3IMWAn4/PrkiRnV0AjnrTJO4gyUb3pNu0zLMTQ2NrNPuoEJ9Z10
         yEMaYJ95WYHZeroaWZPbeLV5MGRor/XyH4RIvqdYQXl3eQaQdup+vBvJ9Dc6QpvGsqa2
         Dpvea0YTjqPMqVF8eG4dbFEQ8nJ3u+0/d4gT6Jr0sN+aeyhlZlwO1ll37aAJbpQg0ixt
         A1JA==
X-Forwarded-Encrypted: i=1; AJvYcCUCON6LxjU3gJy8zKSomQAwUozbM7GGqQtJ4zCYV3RqeZvp5jIZK+LEnBqODQqSTmottPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWM2ZySPBNZyCbGX37uIAAbB+5NXKpC+ruJnrem3rWBJBB62sK
	OI5a1C1AS+2EWfzrVliEXH0ASTnmlOeWkBPAvU5xYMOc+JK/LWHP8E7i/NO1uV4wsgLPk5pxz9b
	v1nWzl9N1O1Q5LWE7nQgggFnnzeOxo9nkVTu4
X-Google-Smtp-Source: AGHT+IEYEulEG8uwOdZ6nHWVRi6xht4GwFzjK7BexdW1RrCf5iD6UAW7Vc5bcQ9XIli0/7HCgS3q1a8Cpyo8PwB8l68=
X-Received: by 2002:a17:903:1104:b0:20b:99cd:c27e with SMTP id
 d9443c01a7336-210c68866afmr117631165ad.3.1730391546355; Thu, 31 Oct 2024
 09:19:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028195343.2104-1-rabbelkin@mail.ru> <20241028195343.2104-3-rabbelkin@mail.ru>
 <b5aed7cd-3a1b-4d0a-a9fe-e8a2a7778cdd@linux.dev>
In-Reply-To: <b5aed7cd-3a1b-4d0a-a9fe-e8a2a7778cdd@linux.dev>
From: Florent Revest <revest@chromium.org>
Date: Thu, 31 Oct 2024 17:18:55 +0100
Message-ID: <CABRcYmKyrDEwGiwWiixsjc49g9ypkVVBQAYEsHu-QifiFSvWLw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test cases for various
 pointer specifiers
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ilya Shchipletsov <rabbelkin@mail.ru>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Nikita Marushkin <hfggklm@gmail.com>, lvc-project@linuxtesting.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

Acked-by: Florent Revest <revest@chromium.org>

On Tue, Oct 29, 2024 at 7:19=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 10/28/24 12:53 PM, Ilya Shchipletsov wrote:
> > Extend snprintf negative tests to cover pointer specifiers to prevent p=
ossible
> > invalid handling of %p% from happening again.
> >
> >   ./test_progs -t snprintf
> >   #302/1   snprintf/snprintf_positive:OK
> >   #302/2   snprintf/snprintf_negative:OK
> >   #302     snprintf:OK
> >   #303     snprintf_btf:OK
> >   Summary: 2/2 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
> > Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
> > Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>

