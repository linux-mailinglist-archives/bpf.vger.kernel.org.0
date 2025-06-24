Return-Path: <bpf+bounces-61455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2BDAE722D
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C117376E
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 22:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9B12505CE;
	Tue, 24 Jun 2025 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsSKpQFh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93703D3B8
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750803517; cv=none; b=BV4t1fo0dzuI7ejQAIR66Es2t+C9b0Psz1qbx7L1s5f+q+oVMMvj3nbXs5Ses8725bynptooAvphseckA840N81Qn+NG5Uj1BtQEdBCV4vH6DoPSfhFAsLqCSY89U1/G+EreQz+uH29F9aT/f7gXoD7SfZBMmjpD34fUx8XX+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750803517; c=relaxed/simple;
	bh=TghAdRQ65WxHodLiX8SSID0lUAanAHZKksxvdjhVnQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JK3BHeQq+DQdobgzRcpb1VqV1F2OWcqPUNwYMw1Fr7SWwbDKZ3g8Hp9pe3qCGFDBdCWr7hhevu4rHyMGfefEl/dtIG+bFbYH/g1kfpB8EJ26lKqJMFTd5aqv5FUMTQx8O2QKWgt0evApXWZs6hvY3jtLnxmqEy+uSGRXxB9/ZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsSKpQFh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-315c1b0623cso3158866a91.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750803515; x=1751408315; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k8VF+nWcFKncSWDDp5nWs0R6y3IcDnmwVUoZ7a9t/Cs=;
        b=EsSKpQFhm2KqBYw5WiWMZ7eUkhX/tLN1L4DtrIdCfXL9pSnzeTaqbc6SO0PS5CprZw
         ZVRFnjKjmYJHsK8ZASV+1Lf9EYIm8gM6pWwmKmbT1QWtPsOobe303WewOC2x+WGz0juR
         2fAqrcRXbqKuJwW5XVeYIUjbIOpD5dGTZZcBHQ8JPQOotcwS1B2I/C+tQP9dWShBE6Dr
         JQVYy/vLr6Qhb9gMHTajDQWMQ6nZ8mkW0cNef6ch1PJXBnboCEH+gDPcvu3HUgIGari6
         vQh2PEGEn/tGqIooEghNgLBqEZlI1GMc9UCe+ZYoiTDWdLYksG93kBPAyowCN1Vw3dEn
         WyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750803515; x=1751408315;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k8VF+nWcFKncSWDDp5nWs0R6y3IcDnmwVUoZ7a9t/Cs=;
        b=OZBS+C+BNCKMFa/00B6RdXVNrKNSuVKfFslLUwB0rxtaUSVTg/YIFuLfI3fXEoheZ4
         Wok8BMSj1vnN4Ij7OHyz2Qh4ofuxAYyJOhbF+GvwJGjPHd/id8UQCp29detdK5PPJ2QR
         mtxt0Huy7PKHL+whZ8DEv0CJODwT5F9jb7r93hp9MtIDZ2EDm10qDp5Mc9o5lQS4Zwbg
         6d2QLqdQezsNsmCHj0988jfSfRnXplV+IP+Q00YZ9jlBqO5h29CR15aNIHsXSOF6RbVc
         HajXYmsWvgc4BtWDyyS0X+BEWW5lWsdg9ockKF+iU2HIL7taZMo26gwmCAfemrkT7poG
         mNVg==
X-Forwarded-Encrypted: i=1; AJvYcCV4UHqn9nTn3YWZrvppVLOrTyWlcyUdrRC3zfxi9j/ndJrzv5k0XrIAI0UZhmJm90RdBpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGmYgnLxE5CI+O8ebudJaOreOXvU69GpVGovVVYPmO9yU2Qrfo
	+oKRz/C+sbfalN9YMYs8dPSBIle6oZplFmPEziAt+9kzarYhdLpx6oH5
X-Gm-Gg: ASbGnctLcHinzj8levFGaoJA1x7m0qOFU7h4CELgD/FNLegOk+S6Gx75Y1+6q3itLUf
	dBGeHD4i5vQVlJ9hyeFDCsjBzpD2mgVHBWku4FpY8cTIAtdEzLVx0N85FZMDjSSIVdLQJbHR1y9
	oC3RR9hMIiR8RfLprdj7XxQZuw1RJbbhcdhw2rgMmpqbVMEJFHYCp6h8ykclRQ+JUuOG36gYf3G
	ebdVrvVvtDy4/ICiSSj/wluKPEHk2a7x7KqUeCsKt8e75Q2mjMiRui6K80fe9DJCJfyRVcGdBIX
	rDCqwL/oo5BEEL75yFroPwNSB9au4Dc9f4SCWtkLu8CLsdLT4zlngoK5K3wy3S03JXeu/S/Bmwu
	Hq1FuBTqNKHZiaG38MYxx
X-Google-Smtp-Source: AGHT+IHSP0WskiSeB64rV3bpHyPwWWQDyc/3a7nQIcFdjQjBfON25EVwTaTYEuERBmlBTRo5Q7+J1A==
X-Received: by 2002:a17:90b:134b:b0:311:c939:c859 with SMTP id 98e67ed59e1d1-315f26c1c3bmr683807a91.30.1750803515257;
        Tue, 24 Jun 2025 15:18:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9b77:d425:d62:b7ce? ([2620:10d:c090:500::6:f262])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12584d6sm9492082a12.52.2025.06.24.15.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 15:18:35 -0700 (PDT)
Message-ID: <9c18fcc83b4fa0c5685519bfb80f102436bcd675.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add tests for BPF_NEG
 range tracking logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: kernel-team@meta.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev
Date: Tue, 24 Jun 2025 15:18:33 -0700
In-Reply-To: <20250624220038.656646-3-song@kernel.org>
References: <20250624220038.656646-1-song@kernel.org>
	 <20250624220038.656646-3-song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 15:00 -0700, Song Liu wrote:

[...]

> +SEC("lsm.s/socket_connect")
> +__success __log_level(2)
> +__msg("0: (b7) r0 =3D 1")
> +__msg("1: (84) w0 =3D -w0")

Sorry, my previous comment probably was ambiguous.
What I meant is that you can match verifier output for "w0 =3D -w0 ; R0=3D-=
1",
thus checking that inferred value for "w0".

> +__msg("mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 1: (84) w0 =3D -w=
0")
> +__msg("mark_precise: frame0: regs=3Dr0 stack=3D before 0: (b7) r0 =3D 1"=
)
> +__naked int bpf_neg_2(void)
> +{
> +	/*
> +	 * lsm.s/socket_connect requires a return value within [-4095, 0].
> +	 * Returning -1 is allowed
> +	 */
> +	asm volatile (
> +	"r0 =3D 1;"
> +	"w0 =3D -w0;"
> +	"exit;"
> +	::: __clobber_all);
> +}

[...]

