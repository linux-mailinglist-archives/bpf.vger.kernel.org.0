Return-Path: <bpf+bounces-56167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C72A92C8B
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647AE1B656BE
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 21:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD6E20A5CA;
	Thu, 17 Apr 2025 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYIvBW0V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B07F9EC
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924265; cv=none; b=OOjrEHeJktG0UmoZzuYG80S8KyszTkuRt6egPja03Pl3Y0FszrQHQw2VnFHM4zZ/3J2kDVtkyz0mZOmB6eAq/0wKG8nndOGkzTv3iyeJsWtq8qTTtdl/tQ/dyTZ7Th40zNu4qQpdONnUV0brY9GCVfH88OixPjJfBc67YlLqcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924265; c=relaxed/simple;
	bh=LLDPGDZ8oAK5c/DJ2M5+HyzckE5WkbFq8/oS7/7bf5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJjAbGXxGs4u37TKV//NGp3p2nFMIGghs0j1woW9kxmvF4RMZZ0ZMoip+BsRYh+tq01X2A0/gPx9vWaSc17RWJjBYlKVMSFmmS0DN+yux9BYGNT+YffSXEJbIS4kTWhV7m1aucGDGRl6OVTrxDjxdYJwmZsr+/u4evI+RhnfK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYIvBW0V; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so231549066b.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744924262; x=1745529062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LLDPGDZ8oAK5c/DJ2M5+HyzckE5WkbFq8/oS7/7bf5M=;
        b=WYIvBW0V/w76xA9Axe9pW+UYFUYug3yORu+lrmwf9BcL1SBKiHoA1WEA2DkFHaN49I
         TH4IyCZE5Btan9b1HWCBl1RNSffTLopezT7CoDihWRrxq2511191gzAzsjuoAugV3Xb5
         8Xo3kJDi+WbLfQCdW46wVhaXcXFUhwrNAoQ2fD9WfMY+H116Tg8xPc++rJhQhiT6Jlk8
         wShHSJ3IedJ/uYU8ns2u4mj06kEsiP1dEF5PKAILBPzbblPT0RBeTZuT8zfmAcMdFJJq
         OuKUlA6YrGkgl/9VyMlDUtCf4Oy6vvZdAbHqUkZykea4S/DbkATkvGK+CipONqcIqPpe
         YtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744924262; x=1745529062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLDPGDZ8oAK5c/DJ2M5+HyzckE5WkbFq8/oS7/7bf5M=;
        b=OfxePDZy2Lm9jMVYhHFo/ULb5RcLEHX0KU3vB+KM5AjeMMUmSZbGypXBF2XOS0t90Z
         DbkXUCrVB4ORkO0hWHjJFCfvNYWNUGEjncpCp0PjVQgq/tLb/D6eEHz/9OoF9cOGgyxQ
         EBmzig1vRt/rAbmN1ApM7C6wm4TESGEMwpApbMJJYNOkCR9kZa2/mmJmZ8fJuPjMDTUT
         qs2MSaQoFpMMWKXIei0K8BQ8+EMSmiUJsSsFU36vbx98F+b/WSCrLTbLDpDV8xHYZt1/
         rt+wbek70p5g8byoC1cxHwlS6YPxLOHteph/UjoyQoBrXnYzmrG+vrbrClF+k9j5NhEd
         zxKg==
X-Gm-Message-State: AOJu0YyD5ITxj7+FpbsVYMbDQ9ZzBba4EUwSwSscJzLQCltgDn71tyDC
	qUNerWtIBTxfuyFxVVsZWU9e7tTgBe2PR6mL35ZHUr8ettjiUkj6zsx826fkOrCMK7Nt5O+InfU
	LUBNpCFg62OiTyKeXd6giJyMrQGtIH2uC
X-Gm-Gg: ASbGnct7O4/y756B/G8I/Q60qddnoXuzZr0TsIk4EMRAHU5TeHAPLDjdzo/t8tCdvCv
	ffEOXArEEPJyDL525KTQ7Zee5MfaClUb6+4/5QkoCXTkCvTvPgw1WS2E/sogTriwSdZWgEOHY4f
	rnSVDyZejcQ929hc09fdnDqBrRiHwBGodMS3lZkKRXcTrL0/5fNDUcfw==
X-Google-Smtp-Source: AGHT+IFkf8KHe+mlsBTB9lM18wE9RwtKvH1yIsYY0WFldYA4ANrtk/CqOJfeCHw2FwlS0MnVS/Lk+9/HIU9O0WtTrv4=
X-Received: by 2002:a17:906:f591:b0:aca:db46:f9a6 with SMTP id
 a640c23a62f3a-acb74e52fb1mr20216766b.59.1744924261618; Thu, 17 Apr 2025
 14:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-5-memxor@gmail.com>
 <87a58g1otz.fsf@gmail.com> <CAP01T74a=65hrUUO6kNqomBPf0Yu+iP_bVrTCqFtdPO2KPeQdA@mail.gmail.com>
 <m2jz7itt4x.fsf@gmail.com>
In-Reply-To: <m2jz7itt4x.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 17 Apr 2025 23:10:25 +0200
X-Gm-Features: ATxdqUERcxK0J3xbsnd-A8xfSfVeiWpAoe5zy67n0u-HyoOMcYQIqlRYdGkf0fA
Message-ID: <CAP01T74hV+Xq4YW2hP4p-BE3E40ef-h3fcrF51XD=_ao+YpuVA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 04/13] selftests/bpf: Add tests for
 dynptr source object interaction
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 22:45, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> [...]
>
> > I struggled to have more than two callbacks automatically working with
> > RUN_TESTS and struct_ops, so I guess I will do explicit loading and
> > failure checks.
>
> Could you please clarify the use-case a bit?
> In theory two RUN_TESTS should be independent.

I meant I see strange behavior when I have both .enqueue and .dequeue and
do RUN_TESTS, for the second callback, I see unexpected load success.
When keeping one of the callbacks, everything is ok.
I didn't dig further the other day before sending it out.

>
> [...]

