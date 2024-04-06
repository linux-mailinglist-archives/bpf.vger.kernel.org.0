Return-Path: <bpf+bounces-26095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2342489AC09
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 18:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE1C1C20AE9
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6872E400;
	Sat,  6 Apr 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9giWW7n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7CC107B3
	for <bpf@vger.kernel.org>; Sat,  6 Apr 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421245; cv=none; b=OlLzmYo7Fm4XZ3eLbQneJ7AtmmGx18yCGErTRkhNT7dZJbMp62IerQYzYN/273+gMEJoPVi6lGN9t5QNiik0dfUOjAjfYgscDADQG+TM/4MMTmr5Sa+XP7qoiZxRaPZ9vrloHorQGkgUQqcxqzxo0C6xXoHBZDSsSJ+tjz9ynm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421245; c=relaxed/simple;
	bh=jp7DxysFYgmi1UpHSdSAEmYHI3mYVu8UqH4d5qSOsEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KTJxQnICdyNBQRX6iNQq1C8bbzW+6n02M4V8meXLG9RlswL72Zj5Y+9XTEvPVCf9QnF1WITM/eWUYG9S0NRwAYESpIr0VVGiNW8NHNr/v3pFflKhVkusFYrvjvehaM5QGLMdlIzJGzMF1/tIFKu33Jkkae5j5HepJHjeNrdgEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9giWW7n; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so48755351fa.0
        for <bpf@vger.kernel.org>; Sat, 06 Apr 2024 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712421241; x=1713026041; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jp7DxysFYgmi1UpHSdSAEmYHI3mYVu8UqH4d5qSOsEI=;
        b=E9giWW7nzMylI7WunzCuiXHdODjRr+CqLh8qQNg0YHGK1UbsuQ/vorvxLyo2lI3Mjv
         42UvU+Hr5svgaem1kb+vVAkSsStzXg+klevLiaB6JoTcazmVlXfoNH6H7RwvS9w98q8U
         clPnGdEbf5P127QLGoHIv3oe4f0P6Lk7CG4FRrghFPuDFmIrWQjzg4ftJaFYuYPx3SI8
         yf7rR5r09IviZUXgLwL6ksvdGgsNpPWQ4a5+zxcTRHip1QVAltGdoC1Hkj/Dr3wy5vgM
         MhN4LFe8johlW/yT1DUtIb8ceblJRv6n3cqBYY/oSVwTxiHjwnJOnj0jGEKi9AofAvJ3
         2Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712421241; x=1713026041;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jp7DxysFYgmi1UpHSdSAEmYHI3mYVu8UqH4d5qSOsEI=;
        b=IjoPdxcZI2Ev1pXadxUc8QTi0r/98/tFYJmNuz9T51D4v55DRjx+idh4QbLMmQfan4
         7NrNvjPvqH4Ehlxg4/FfD+J+/Ks07fwipgru4CEhsXm0aOXFK8egDpGQakhsfYAkfMNY
         PqViBhc9hkFj8Y1fBODgrsouRFd3d7wcubl+kIvlGc0lWH1VN+8LWGdTekLCdr5ReYwg
         n6rEe7Lm7bEU9mgt2qYiOtbiRO41YXUyUSlrn3OQgM7wa38zbtIE5fi0a4k2k2vluLc3
         rwr8dcEWaxFjiiZPx2wTwxp+VpYxtCPAdUrXhhj9cUThmuuIRSWjSULEBBo8fqoV2iLS
         ABIg==
X-Forwarded-Encrypted: i=1; AJvYcCUwrfDe0ZauPl8Rs3OoPGx3MI++Hc6TTBlQf1U2iJ86PkTstyygNpwgFwuuq+4OzY3GzFpim1JbBHDeRHPaAD1ZNWW1
X-Gm-Message-State: AOJu0YxEDmQUOpL7ojpAMgQJRZhXoXEwslL5lh8ymhyCyMCNzXtHzrNz
	B0bWWviRPxX/F+179tkhOjQ6+99uCNE1fcWFg7Xsj7AejjzGaxOc4bHjl1xtlMs=
X-Google-Smtp-Source: AGHT+IGRhB2dXPzPDjIIyRt2zlHiDUuYwQoE0I5H3JRzPOAg630meYL3ve06qs7iLH/O0I/tva5ynw==
X-Received: by 2002:a05:651c:60e:b0:2d6:c1a3:8ead with SMTP id k14-20020a05651c060e00b002d6c1a38eadmr2910746lje.23.1712421241300;
        Sat, 06 Apr 2024 09:34:01 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c351600b0041562a58b75sm7022153wmq.13.2024.04.06.09.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 09:34:00 -0700 (PDT)
Message-ID: <0573ff3ad7773415c5e896c3a624a9c2ed75ce11.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add support for certain atomics in
 bpf_arena to x86 JIT
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, puranjay@kernel.org, kernel-team@fb.com
Date: Sat, 06 Apr 2024 19:33:59 +0300
In-Reply-To: <20240405231134.17274-1-alexei.starovoitov@gmail.com>
References: <20240405231134.17274-1-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-05 at 16:11 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Support atomics in bpf_arena that can be JITed as a single x86 instructio=
n.
> Instructions that are JITed as loops are not supported at the moment,
> since they require more complex extable and loop logic.
>=20
> JITs can choose to do smarter things with bpf_jit_supports_insn().
> Like arm64 may decide to support all bpf atomics instructions
> when emit_lse_atomic is available and none in ll_sc mode.
>=20
> bpf_jit_supports_percpu_insn(), bpf_jit_supports_ptr_xchg() and
> other such callbacks can be replaced with bpf_jit_supports_insn()
> in the future.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM, instruction encodings seem to be correct.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

