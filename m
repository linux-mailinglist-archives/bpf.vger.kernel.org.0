Return-Path: <bpf+bounces-19816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C146E831BA0
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 15:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7193F2843A6
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3E7658;
	Thu, 18 Jan 2024 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihQUjAHC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2857D28DA9;
	Thu, 18 Jan 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588723; cv=none; b=sqAeerGA69HmWYKP5SjlWYnSkDrPQ++nofQRpHMP4LrUic2SF2eKdLVhxVIGEBrgd2eJA9SXSJm6gY/BzEDFamPpOYmHEMvtAptwzJYQSjJEH9nZQ9irED2UBREle6uS5nn1kk9L/FpeJsphpm/dW+aYZJnB+mo1szTJNm+/9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588723; c=relaxed/simple;
	bh=f94H6g/C+eTYj2vDHQb/a3kDRJg+rVDN6zrIsfqqwAA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Autocrypt:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version; b=crjks2SkcZxu5uS4L46jwFalwJDAPZ9cXdHxWqPOQUFzKHR4iMtxA3aV7oQx/KlbYxVXftlnUCCJAssTtaUmMkst7hAv+j4Dp/6/EKdNGBCcuN6U75951txK/yn5UCAuoaaTJu5aKYBGjV7Cy+PyDF1CG2J6fycFZjYKrESjSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihQUjAHC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e95375c40so4828825e9.2;
        Thu, 18 Jan 2024 06:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705588720; x=1706193520; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K5bSxL8Hw0zjbw/s9YC+zGVjnfdVF7SOSRACUBPSqcI=;
        b=ihQUjAHCZOjzYxXA237Z2omfFpBv8ZRRV7xHENnKekj1xRzDFGD4XoLc4kfDd8CEvA
         dSGNHtPMZVL9cbZVf7SkItOxinZ2d/wRJPa+F7BZ7iO9cj+UdBMUxoisepb/8TogQTN4
         AXVO4XopBH8nn4dpiPmjYy4S3uvEhGrfXQLSxNNize0cV1EOozQDgAFm0lKnJTVHjSo6
         yhS9e5iI4KLkzqAukoGAmDGuDmuPhv8yCIL/BTI6NOxH+lb2rW0QbE/J9t2NYFhH9A1j
         AJDVFnSxBj2LDrzXDwkdPns+pa9AYk2kZsMQWLXlMM265YB6GKIWnu1QEn/TKH2VMFEZ
         HWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705588720; x=1706193520;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5bSxL8Hw0zjbw/s9YC+zGVjnfdVF7SOSRACUBPSqcI=;
        b=nH1SbP1tfWptYdcHtjOWfEVaB4M/LnnG/jFoN+lAg61Dkbz0tKd5mTty/AtiCU46rl
         XXFrWSZ2qP2hB4KihbT9vrmbNraDQ/ZFwWZQNXVJhSwuYa6u6oLDxaBanuTGqvQXcw7A
         B6hOYgtApusszN9Y7tXOiv9PSiASVZHHr5drOS8aMUumz+YI71yJsrnPRFYTXkLNIf1P
         54o9jvzf17sbY6fnbgmfjvh0rYzEVthWtSJxCP4WWeYsZKuUWLvDR7NQ51raR9evx6f4
         tKYWet2xFfLHHWTanOJ+8z9WlFLVPi/VOZ3Ni4gV6GCsoWftWOWM6X8ZEW4r0QnexC8Z
         1gdw==
X-Gm-Message-State: AOJu0YylSRZjBqrx9FD4h6VFkUq9XOFJBXZLBtJW/RxRMQwZzJaAQs1f
	4YIR2Ffio25jPbD3uP85JtxMVikrhPRl0KaveXoDaG91nkvWUl4x6me07Pcq
X-Google-Smtp-Source: AGHT+IG9P9TNbaQbSYB2UT8Pf3qNaR9MNL9X6aliUCh680mz2SXIMVw+Kmn+ZET4xAmaltkfeFdG1Q==
X-Received: by 2002:a7b:c041:0:b0:40e:4bef:f24f with SMTP id u1-20020a7bc041000000b0040e4beff24fmr405975wmc.120.1705588720178;
        Thu, 18 Jan 2024 06:38:40 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0040e53f24ceasm25979258wmq.16.2024.01.18.06.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 06:38:39 -0800 (PST)
Message-ID: <6db75915cae66ab64921c2a8aab2f1653a22ec97.camel@gmail.com>
Subject: Re: [PATCH] bpf: Refactor ptr alu checking rules to allow alu
 explicitly
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	linux-kernel@vger.kernel.org
Date: Thu, 18 Jan 2024 16:38:38 +0200
In-Reply-To: <20240117094012.36798-1-sunhao.th@gmail.com>
References: <20240117094012.36798-1-sunhao.th@gmail.com>
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

On Wed, 2024-01-17 at 10:40 +0100, Hao Sun wrote:
> Current checking rules are structured to disallow alu on particular ptr
> types explicitly, so default cases are allowed implicitly. This may lead
> to newly added ptr types being allowed unexpectedly. So restruture it to
> allow alu explicitly. The tradeoff is mainly a bit more cases added in
> the switch. The following table from Eduard summarizes the rules:
>=20
>         | Pointer type        | Arithmetics allowed |
>         |---------------------+---------------------|
>         | PTR_TO_CTX          | yes                 |
>         | CONST_PTR_TO_MAP    | conditionally       |
>         | PTR_TO_MAP_VALUE    | yes                 |
>         | PTR_TO_MAP_KEY      | yes                 |
>         | PTR_TO_STACK        | yes                 |
>         | PTR_TO_PACKET_META  | yes                 |
>         | PTR_TO_PACKET       | yes                 |
>         | PTR_TO_PACKET_END   | no                  |
>         | PTR_TO_FLOW_KEYS    | conditionally       |
>         | PTR_TO_SOCKET       | no                  |
>         | PTR_TO_SOCK_COMMON  | no                  |
>         | PTR_TO_TCP_SOCK     | no                  |
>         | PTR_TO_TP_BUFFER    | yes                 |
>         | PTR_TO_XDP_SOCK     | no                  |
>         | PTR_TO_BTF_ID       | yes                 |
>         | PTR_TO_MEM          | yes                 |
>         | PTR_TO_BUF          | yes                 |
>         | PTR_TO_FUNC         | yes                 |
>         | CONST_PTR_TO_DYNPTR | yes                 |
>=20
> The refactored rules are equivalent to the original one. Note that
> PTR_TO_FUNC and CONST_PTR_TO_DYNPTR are not reject here because: (1)
> check_mem_access() rejects load/store on those ptrs, and those ptrs
> with offset passing to calls are rejected check_func_arg_reg_off();
> (2) someone may rely on the verifier not rejecting programs earily.
>=20
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> ---

Tried this on top of "Reject variable offset alu on PTR_TO_FLOW_KEYS",
all seems to be ok.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

