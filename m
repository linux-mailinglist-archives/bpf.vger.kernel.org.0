Return-Path: <bpf+bounces-42715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC609A9525
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 02:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EF51C22BEB
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFB713E03A;
	Tue, 22 Oct 2024 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPkidXvz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2647A15A
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729558072; cv=none; b=NQReONa6vk1AvnDgbJYGVI2jEVndXFHfDJPsG5HKVvY7kLPrEHxufmFtO1a5VXAj2NKZkzSy1AMhDiK3lB6EmhhclpMs6NPrSW83SfjkFmSoSCvyaj8ZKD1+OAmVGLaENj53anp6yS+L4hwdiorY8EXGnNGXPQziE4XbVq0a8dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729558072; c=relaxed/simple;
	bh=rzfSxQcRt4KHPt9bmGbKzIMWwjgNWJEOiXO3fEqfw98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acLc8iyS9THmEG/EHkD1v44iY1fOOfxKeF6ulr9ytI9P5VC15kZp7YI1pRvRoQxgxfq5JT1ZEuGWqHwH6gr/x7hf7l0eY2J/pCJd8Wv4ZZ+fURWCj7lZJBlfYEROKGKuDCu8MCLm/fQweKKicZRoSDgeGHmOPtSoC6UM6bDdmsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPkidXvz; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so2783859a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729558069; x=1730162869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BPT0Wt5TQapoLC2JpZpQROc2AtDhnXrygQ6i8I6BPpg=;
        b=DPkidXvzn8ruucEb2pjy1x5p8VedUbAtPKW31ajGyb3jIZOjYG9+AA3sgMxOBeDIoE
         kAEusa03gV5vKsyn3vkGBuLnVkzp9HO4Yck59h04ssC71daV4np4xyDT1ghD586jXRJg
         n9nOIhYvhbA1xKCdBZHJRl0sMyFlQZarknBL7SzjEk4vmbeC/vBcAbe2Coz5RWQJWTrY
         TFk0L0qz/j9aFTPqmZFJnlsH/k7Bv3VsTLvAEqh5wP8QaT60d1rSwqKHNfbn7xlzQRIV
         +WsS0QuRx33vFNlGKNbTYr99Y3Eky+L0QfVh0KlfNQDIfOy1/EDxcOEL8GFJ8wOceHgq
         b8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729558069; x=1730162869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPT0Wt5TQapoLC2JpZpQROc2AtDhnXrygQ6i8I6BPpg=;
        b=k/7cAalbfHhzid/1yQP8m/TwGFUolnecLvMnto779a4/6Hcnair4EhGkgB3UJ4la6y
         RaiK++u9B68WJsGSEcPIV1k6x9nIgCYbpXefSO6Ku5fGMNpjsHTz8/KPY+tcxQ/s3hU+
         q8WzINsSgXDv0HLzgpdHXc0XN8qX4rsKP+0lnQj4enxwrDmWWEA0QlKq1JtPL6lznwvU
         bSc2OGMY3kE+COseKUHEh5FPMceZziVtZ65EWURYM6LED3SZj6b4hCodMRSPFXX3bngt
         r1/dca5mUN2t9PlXsvT4dHo4ehavaNkPmdZiLEGu1jyB47YZHxcAj/d8F9VocGeAL5fb
         74nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfNZWQdBne85aECnONM4APheIodBfYhoxuf4dFzLUT/lD9eDame8TQGk9RQZvm69FHdfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNIXW11+1NYXgy51MUxYyOMPHBkVHM7Nh93dsEJ6/IqcrZTrB7
	I6b36HxxUXhJ5UW0/FrHhM5J+ik0NQVMbmQ8Q2LOdnfs1yMIBVUxJ7Hw2m4uk++dtMsq83KrHUw
	J+2mxrytG1kMyj0/mZ8qt4dw6eFY=
X-Google-Smtp-Source: AGHT+IEW+PkhX+KD1WtmQTWriemI0P7gdszH1P36kdb8Ij2hr+Ih6P8pdIPGV5XdZiVktG4VueF48rRQnpAZdAdbKJ0=
X-Received: by 2002:a05:6402:3224:b0:5ca:18bc:8358 with SMTP id
 4fb4d7f45d1cf-5ca18bc83bfmr8989734a12.24.1729558069214; Mon, 21 Oct 2024
 17:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021152809.33343-1-daniel@iogearbox.net> <20241021152809.33343-4-daniel@iogearbox.net>
In-Reply-To: <20241021152809.33343-4-daniel@iogearbox.net>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Oct 2024 02:47:13 +0200
Message-ID: <CAP01T77_cOwnxJDXMz5-AW_5ikpgt8tgAxKyvXaot57zZybacw@mail.gmail.com>
Subject: Re: [PATCH bpf 4/5] selftests/bpf: Add test for writes to .rodata
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, kongln9170@gmail.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 17:28, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Add a small test to write a (verification-time) fixed vs unknown but
> bounded-sized buffer into .rodata BPF map and assert that both get
> rejected.
>
>   # ./vmtest.sh -- ./test_progs -t verifier_const
>   [...]
>   ./test_progs -t verifier_const
>   [    1.418717] tsc: Refined TSC clocksource calibration: 3407.994 MHz
>   [    1.419113] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fcde90a1, max_idle_ns: 440795222066 ns
>   [    1.419972] clocksource: Switched to clocksource tsc
>   [    1.449596] bpf_testmod: loading out-of-tree module taints kernel.
>   [    1.449958] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>   #475/1   verifier_const/rodata/strtol: write rejected:OK
>   #475/2   verifier_const/bss/strtol: write accepted:OK
>   #475/3   verifier_const/data/strtol: write accepted:OK
>   #475/4   verifier_const/rodata/mtu: write rejected:OK
>   #475/5   verifier_const/bss/mtu: write accepted:OK
>   #475/6   verifier_const/data/mtu: write accepted:OK
>   #475/7   verifier_const/rodata/mark: write with unknown reg rejected:OK
>   #475/8   verifier_const/rodata/mark: write with unknown reg rejected:OK
>   #475     verifier_const:OK
>   #476/1   verifier_const_or/constant register |= constant should keep constant type:OK
>   #476/2   verifier_const_or/constant register |= constant should not bypass stack boundary checks:OK
>   #476/3   verifier_const_or/constant register |= constant register should keep constant type:OK
>   #476/4   verifier_const_or/constant register |= constant register should not bypass stack boundary checks:OK
>   #476     verifier_const_or:OK
>   Summary: 2/12 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

