Return-Path: <bpf+bounces-73220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B03ACC275A5
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 02:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 365CA3502AE
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 01:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669AF242D89;
	Sat,  1 Nov 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZTa4f9A+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698B1F584C
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761961632; cv=none; b=XRa0g22L1j/z/XDnCfq/qRbQsXtXVYsRZGxyO0lfPwD3rnziA0wkEB63OdfsEunVD1858W2oG2WhhFc0RcA2z7JaXTlsBgb6+XqAvIZ7Ppin02NAlxX9FkCZlk1yIhyLj7S4hVECyVG8iE6A/ihW3WGGxELn0UlJp/Vlr2GzBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761961632; c=relaxed/simple;
	bh=s6Tx1HbbG4MIYOF38SEAEcTrXcjzNpIOy97bRofYLto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWOvO7tUcCu51xVcffoNylLRFBvRRjO92TqVlh8ar7OH9ThcvXoPpfRWLg219+vjvsVELcAqgUidk1m1Cl8wqIVWsMKO9m88bjCFeR2vDuiJWKMPcxaoGM7nKAcrLC4lZSt/frETfWYnYom/qwAvSUMBnbw2G2NuFIPERDKPOEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZTa4f9A+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d5e04e0d3so536406366b.2
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 18:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761961628; x=1762566428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ki9Lbe3Y8TCICPmXARZQO7wrrkrGwMclP5BRQYwnnQc=;
        b=ZTa4f9A+NIQtaeJ7m/FiZMxxRgB6fiLb+HkPyOy0sIFx4pGUngwMlJ8ZVrjWtwLYGe
         /di7cAnD0mf1oIsNN8y6vJcbDN+/Are4XOBU4sdk80I3HBKno/gnqcBXN9LwmYXR6ZyQ
         pesL3WUVPNOrX6J3iqCBELU2v0pdD2gDeanCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761961628; x=1762566428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki9Lbe3Y8TCICPmXARZQO7wrrkrGwMclP5BRQYwnnQc=;
        b=TZQl7JMcR/1pxcdhdQpKzfs5rfrpMk+iBopQqtz6GpdUuN3KY1CtvQ4VvZji1HeZNM
         M9unSWxv8Xqq1bgR0tdyRGyUPh4juv+Y86/VIkgdweVMhGqNguGWMAyW9Y+yn3fdYq7E
         t0ILrXIBzNuSrADMYcpW5y3x4ul/U+zIMDeVYijss8rhWkk5i7zw5BDjJDL9lG1/YWyq
         E03cjOf9PORCBDw3koZwIAILW0P3Flro+IZCmRa6IcEoOk54+7Jihji2bs+Q94vvBfg0
         db2BidTPBapY81VWdIZVcN2gSqve3BBhp93UY55rtSIssTGGSxbl2zzPV1pIeOL0bAdJ
         SR2A==
X-Gm-Message-State: AOJu0Yw1HTyDjGCZrxLYfzKwJ7CEwRw04KWlksU9mOL/BVQO0XaWMbgc
	5DTxJoDuEqe6c+Fi6etTxD7XdZb9GVZ5yCXsReSljD/vbkuS0vkD0ac0E6/uLX+bdEnWQFbcU4L
	xPkR0rdw=
X-Gm-Gg: ASbGnctAblVcbELNGhvZeVoYHd5dNX5d80T9uxljoRmZVmcaJpXGiNdlpxE0hHboErw
	APQ9S8rHqjnXYGOECpWytGAMoCcaJNLGPOXpPr/ayquvfFNB6m/wSrKuKp7uCyCvKMBey8rDr0d
	lrwBwYtpTEava1wVu/wevqnWIUCgEBCeHoKPfgwObwmjNiyag/l9QmZyWWYReaPuqOZYXp6LTfS
	zVmkD+s9f55FbzgaLz2sWnDD+DD/ubmNzyZfCUOu74UrGO+myCNWk7hPyw4zTQyMwyD5PpNNePy
	YbJp5cvcLLT/SpAvVCPWaJhnQh8QQk2z3q2APsPtoQb6MNoGPLp6Qnf+OM9Np+EEhcrHZ9/niZI
	38f3gOuUp11Z31LpMR+ujVJdj1Hbpz2KTd7mmENsCrADM/rbAnmqsGNio7ioJXhgzC/lxb7IxlW
	40sgVS1OjPoYf/Wo0frtZIeYg2ujKJhthzIZxFDwefg6ZuqUFEzQ==
X-Google-Smtp-Source: AGHT+IH8Lz8HJJODLzLiVulOmKnWTWo16I9ujqRz8m0fAgeCNhkwb+Rvaj8+shROKifKt1tj1/CYig==
X-Received: by 2002:a17:907:1c93:b0:b40:8deb:9cbe with SMTP id a640c23a62f3a-b70700bad7dmr634695166b.2.1761961628490;
        Fri, 31 Oct 2025 18:47:08 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975d77sm323350266b.9.2025.10.31.18.47.06
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 18:47:07 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c2d72582cso4644817a12.1
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 18:47:06 -0700 (PDT)
X-Received: by 2002:a05:6402:34d6:b0:640:948e:7da4 with SMTP id
 4fb4d7f45d1cf-640948e8068mr931419a12.29.1761961626085; Fri, 31 Oct 2025
 18:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101004014.80682-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20251101004014.80682-1-alexei.starovoitov@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Oct 2025 18:46:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whL4iSY6kzZ+usiPHyBqf-soqJc8JhFdq1wgZkh4WPZBQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnIefsiMW9QWJbNhkEad8U4JAkwrPbSaCjtDOmUKFiwjPBAwH4NBDrR7UM
Message-ID: <CAHk-=whL4iSY6kzZ+usiPHyBqf-soqJc8JhFdq1wgZkh4WPZBQ@mail.gmail.com>
Subject: Re: [GIT PULL] BPF fixes for 6.18-rc4
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org
Content-Type: text/plain; charset="UTF-8"

()",

On Fri, 31 Oct 2025 at 17:40, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> - Mark migrate_disable/enable() as always_inline to avoid issues with
>   partial inlining (Yonghong Song)

Well, that still calls "__migrate_disable()" which is still just a
plain "inline".

Apparently the __always_inline on just the caller fixes this in
practice, but I get the feeling that the fix might just have pushed
the same problem down the line...

But maybe there's some documented semantics for this that says that it
affects inlining decisions deeper in the chain too?

              Linus

