Return-Path: <bpf+bounces-61111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F20AE0CF2
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 20:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BF81C21BD6
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 18:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31BB2EA17F;
	Thu, 19 Jun 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxfTlwwl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE6295DA6
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750357052; cv=none; b=fwzHZpVsbjQf+Wc2gxHQaoMX4cyfO8I+tIqvvB5qgxh4UPwAgyDkwXWldd/SA8W/J7z+ehvit/XXQshiutOhu3F3vv+XEFFqYHAYp5Jyever6RjkPG8HaByitL4/k15f0GgigjP7BfdZl2rYLbibYBlhGBxp7JO9GNZt/4E820Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750357052; c=relaxed/simple;
	bh=Ii+Ny27ZsB36JoC+NPNSAMF099s7oQ6gy4u2Oi6Ovw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4Hg9bILGIF1WPmOYIyqK+xer7PqbI2OQJgM3EEMV/29W3zR0+YQEE4snQYwoBu3Sqgk25DQUP2LXF10w5OsVrEL8Rznz3UObOFsAx+oxterWfYbci9opBrsH08z2QBX3LT85qIcEO+7FFeRH1r22vka7KAoRods6CnUUV+nk5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxfTlwwl; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso780846a91.1
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750357050; x=1750961850; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ii+Ny27ZsB36JoC+NPNSAMF099s7oQ6gy4u2Oi6Ovw8=;
        b=YxfTlwwldVY4IUD5yvojLnR91tWD9SqnpprJwVtxpspCs+kvNLeqvaY4UUKNXHRzSl
         biz/mtgslgykXiIhrsos1tGzeYADEyCXBJiGIRrTWML/m2VewywiHNsk6fCuUjXZnWSH
         0zOLpYUhE2oVPY5p9KIeHrGV8FKmd1QJf4vayRBZpq1aKgRrjV2M+ZofQlLH/7c2HyGF
         wMgb4OoYqmQr+YZMqb+1zHmQnaY7ueLPrwsYGh82VOGid0DAEZmzC7EyL+8RGVLI7u+S
         7crSDUY4uZaUFVelFc/sZ0PDX7cD2U9CSo/KX9n3nps2V/OF9Pkhx4X2hbE+aj3oF9Av
         HAEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750357050; x=1750961850;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ii+Ny27ZsB36JoC+NPNSAMF099s7oQ6gy4u2Oi6Ovw8=;
        b=TEaGSmkJaYsk7VSaViiWhj/XZYn1Vb4w4XyyXLrRFmm/rsP3hGR4F2qBa3hcgHG6b3
         x8//yFiE1bhUHDN1+muzgxOZ63vn6+6erZuKAYgsZSer3DHwVqrdRuL5xlleI9YlHtMz
         dvZPJYgNiwhJ8F6kFzuPyx+2EiUXNIyY3GdAaNFPnDUkoeK9irgbplx8VyjyU2var3Po
         TQjZ5cNN0vrIUCUiZdD5kBxrXWb6d9S8qbyNyEpFZDlWFGq7C5lhcI7QVdBA6Di9nYo0
         4UOKqmTAbmOxJk9OGGx51wpQBSSehALKtfIpPJvCzmaW29ot6yRfl/IudHt7CySeU27f
         hpfg==
X-Gm-Message-State: AOJu0Yw7OuK92UULHsSdko0klxLdeIjEiKJ4MCHcDAqS5nm9y+WonzRK
	7Db/EJYRVdTzmyRLp10T2q4Jef5o75qeXzxFZIJgPixoGxCAXx1E+Wio
X-Gm-Gg: ASbGncvbek+dq2TsW3TA4ehQe+WH6rTND7TPvU7hm0QHCwRit+qPYLg/7Ezgt20yuaE
	PszFTJPFzx9EPt6QQMk/M4IwFxDfUCVEGQuYhDWgiLh0+YOEllUij2z5p9EtQAPI1nRB2u8W+Jq
	MUbtkfV7wrj2gw25cdeEnCZCEWAbr/F5pJCgCF3rlR+wbbQKU9gJjczNnV+Xrk+qBYKspVB3xFc
	53q30i4DAKvGCMHGFOuOHFeVq8+oJ6i0foCAXMN2A/Tyibkd8j4GglLVQPNsC4BHSq9I7rdHTxH
	1zjoDkd0F2rc0A+qSPMTXNKmwa9hIJnwv0zZ3aWKzN6+PJ8Rz5O16zki3d5lZYXGuPMl
X-Google-Smtp-Source: AGHT+IF/YZ/2t7LboLU3N/Bl2pd91K18XS9wwtMnOQm40kQrxatU+CBPU4DWJc9i41sQCDX9UxnCfQ==
X-Received: by 2002:a17:90b:268a:b0:311:ea13:2e63 with SMTP id 98e67ed59e1d1-3159d648368mr327701a91.13.1750357049549;
        Thu, 19 Jun 2025 11:17:29 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2f31ddsm2813586a91.31.2025.06.19.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 11:17:29 -0700 (PDT)
Message-ID: <a64d331ff474e9896c7d6c071e027c34fc8c2966.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_dynptr_memset() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 mykolal@fb.com, 	kernel-team@meta.com
Date: Thu, 19 Jun 2025 11:17:27 -0700
In-Reply-To: <51cbadb3cabbb0b2479e5087618e1015c25b4f26.camel@gmail.com>
References: <20250618223310.3684760-1-isolodrai@meta.com>
		 <b35ce32e-a5e7-4589-ab16-d931194a32bb@gmail.com>
		 <45390c6c-bd2a-4962-8222-1ad346f9908c@linux.dev>
		 <7852f30ba177dc5b811bb0840ca0f301df2a8b58.camel@gmail.com>
		 <7e7e4056-e2b8-41a5-a6b2-a2fbe0a94f4c@linux.dev>
		 <50c2f252620107b6fa6642e281a91db444b032c5.camel@gmail.com>
		 <c8540b80-2903-4e31-a4ee-93278475d232@linux.dev>
	 <51cbadb3cabbb0b2479e5087618e1015c25b4f26.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-19 at 11:13 -0700, Eduard Zingerman wrote:

[...]

> Also, what's the plan if you'd like to memset only a fragment of the
> memory pointed-to by dynptr?

Oh, I see, there is bpf_dynptr_adjust(), sorry for the noise.


