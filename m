Return-Path: <bpf+bounces-19616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D39A82F294
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 17:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841B21C23479
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6111C6AB;
	Tue, 16 Jan 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaRpGFRh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9019118E06;
	Tue, 16 Jan 2024 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc226dca91aso722543276.2;
        Tue, 16 Jan 2024 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705423729; x=1706028529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D0TMKULcW7shsmS9YGoPaXfQ5EhcN/xDlG/ssZSxT4=;
        b=EaRpGFRhe1/NDjC99qZdXyxqjtTZp9XU7MIzrf2d+JvY4RLyrfEHnrrtPDO/AJXFnZ
         ltOApXwkjPoPsMgL6Ul5N/Q15m8yaztXVa0vnqZp1qHrqDJjdfS8O4f1EhwqIFnNXZK+
         4NrQ8LtlPxLERfpafzljH/S02kKgo7SOKilP2c9hacVhiMA1gv2ODH3k3shTzc5mQGuk
         Rq1KZ2VtH2abtSxBTKatdggkfV8KeUkDaxHbf9i9cgTj9pndB2YQpDtDjHTO3w06P3uD
         E/ja6qhc0K11TxXA73KgiipYf/BUQJL+KqsmS1X1BIfrupzr1Q2JT427ZaOksiiAiD8I
         fPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705423729; x=1706028529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D0TMKULcW7shsmS9YGoPaXfQ5EhcN/xDlG/ssZSxT4=;
        b=cpHqvNPFDw4lsx4KJRp6cgf6ddXew4PFTQ+l1zn/Rr2G0qhNvacAvoE7Gf2HwhtpSe
         YYdZQfNR9Bl+dVK/5EJNaaUHW7P164OZ7WrBC6ypthSfTw53uDrGC6rCRL+SYqaidOek
         1kELQy5JGQ9lSNZTE9cgVAu44GLjUA+Sp3OY8bzQKsSg9Srfy6sRqa8QHFVynwojWpwe
         KeBgezD26X8ahkC86dtuFgGksb9AalkUcLMP2A+qP6bChK2PMvjAzJr0I5mihpnVJqZE
         czcsg6gprEsI5rNFEBFmKRIde12D27KJpUSBWSkk8VAizA1qHRE8xqwZuOchNS/4bid6
         n4ag==
X-Gm-Message-State: AOJu0Yzmlk2+xjF9Az8/v6rGTYmhoRn1CgEiM8oHyEuMSdrWsmtTg9MP
	gheaFi9ocvEY97c44yCyZC0aLHZ3k0eG+Odv5g==
X-Google-Smtp-Source: AGHT+IGs+u1mE8vGPkyvP0ludW6a4HcjeQGxNTlp7GV0XIK2lTCnRTsLLbcRVX3pWg3hNIqii6ldLQ5LLybNmit2rzU=
X-Received: by 2002:a05:6902:1026:b0:dbf:11e:d09e with SMTP id
 x6-20020a056902102600b00dbf011ed09emr5137880ybt.54.1705423729478; Tue, 16 Jan
 2024 08:48:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115082028.9992-1-sunhao.th@gmail.com> <20240115082028.9992-2-sunhao.th@gmail.com>
 <3c69823d-1e46-60f4-5a41-d6a2983af532@iogearbox.net>
In-Reply-To: <3c69823d-1e46-60f4-5a41-d6a2983af532@iogearbox.net>
From: Hao Sun <sunhao.th@gmail.com>
Date: Tue, 16 Jan 2024 17:48:38 +0100
Message-ID: <CACkBjsYDDNtnws6afjkRWAg4Z6YkBU4m6Ywy-Wr3fjUB2Lic9Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] selftests/bpf: Add test for alu on PTR_TO_FLOW_KEYS
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, willemb@google.com, ast@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 5:20=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 1/15/24 9:20 AM, Hao Sun wrote:
> > Add a test case for PTR_TO_FLOW_KEYS alu. Testing if alu with
> > variable offset on flow_keys is rejected.
> >
> > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
>
> Thanks applied, I've also added a note that we already have coverage
> on the success case. Do you plan to follow up with checking the
> remaining pointer types as Eduard suggested earlier?
>

Yes, will do it in the following days.

