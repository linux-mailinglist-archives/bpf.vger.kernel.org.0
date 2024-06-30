Return-Path: <bpf+bounces-33457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4AF91D4B1
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 01:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5451F21286
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 23:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8759C57333;
	Sun, 30 Jun 2024 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ67fB2r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1583D388
	for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719789058; cv=none; b=TUpF3Kdjz4FVKJTL3TYd+GGtQsPKF75+vCUCbOjjnmCGfRbh+ojzwDPgUZF+560Mmu0XSh/5+QmWSl3pXcTolxIkplovd6uDe8mioM3QMrkxek+XPqyD/6iV5+KznDDEanwX+yJdJaz8CkO24DpniXC0pNGhfQnQwSSB2RjPnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719789058; c=relaxed/simple;
	bh=TTRudG4OfoK1soa87zkivi6mW95UIWG9iuTgMHdEIGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAa+PJwcdXhdxztEXTJ9FpJggjsVcke6KRvrremFyRVNNpzrnyLb4E4D5QatPsGOo0ZDZoaqoZFeFbbxlvCZLgz884m9CHxjNhODMuIGYPoSCtkZ5HDEfeBJG6PSHCRe+bYTk9TdHEzwlel6Es2b1g8tiEECLhO4kiOxNwkGXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ67fB2r; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee4ab5958dso29580011fa.1
        for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719789055; x=1720393855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TTRudG4OfoK1soa87zkivi6mW95UIWG9iuTgMHdEIGQ=;
        b=BJ67fB2rnvu20Xkry4jmnvxDqTp0mVE1yYQRYeaxTncZTefYsf6g3O1cGpif9buoi5
         2x4VC4SOs/6TmG4OZgyMQnG+dTpa/ZfOELt8Fw7CxBXEoEDPELu0gk1mNN0HKEoH9GqW
         nq8cZ6AN5JnKmYqXMz73YBeDdUbuAjwZhGDWDM9kVEhArN3niu6K87DGUBD/Z/2H4LUa
         sYfDKoAp6zwI/JVp1kpUwMXiTmzu1UPCwp/r+8IeRn7cJR5pzyG9DF1NMfi0TKsf87UO
         ARhmd9eLqFXwPPF3M87ihrHYwkUk4bmSVtZyYoaDjQIgUerVkcox0d+51JecyL5ADZTE
         HOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719789055; x=1720393855;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTRudG4OfoK1soa87zkivi6mW95UIWG9iuTgMHdEIGQ=;
        b=ZWDiBuvtEqofH2e7zd5BBotE5ZhCzrmj4vlKRZqa9tuwnlJXkE6JMZdqjF7SNGhINC
         a9oyoZ3Fcpu+K9uXhKmLawHTsZebPOrT0rdG12hGyXqD1Mh9zrg0+3o/+kdHkAYFqb7f
         tDLBPYL3oQwAy3leN0Yo1g3L1wklOtadtDMf6AaxNlLO6R70VcJVPlUZCf9HEhtO6HxG
         +5NO28ktAMAeIouRnAin5Qhazk3JdpQZlXkMnpQuqseRsYopW5rY3lilH0u1sxObIn6N
         F1eSFz0s11hTy03DZZMzgpjrcU7tHbNJws5/+hLQ6AvSh8sWRWA7XY+hv+F5U/bvrxg/
         ictw==
X-Forwarded-Encrypted: i=1; AJvYcCWQgKFEesZ8vSPtt5Ki74/hRTgdPJccByP0ds9fD+Ix3EerYYFQ+HyQwMFs90yXSZzIqJNt8VYtlm+xgKfb15+9Hnng
X-Gm-Message-State: AOJu0YxZ1DDbepCReVwTyRYCK4mndaBqnjOhg1RKVPi3N/ofKmIgTix8
	xZlGbH6VVmIl00fj+T97U3td6u4vAdDc733C6ipLmfLsC7GsfP+Pl2zD3PDQV7OBIzi9qGe9RAG
	+WkeBXkxJpESj9kfo3ThaI1coTpw=
X-Google-Smtp-Source: AGHT+IFG8kz5Bhj9UYahwomQgb2PbMKz779PCQ5QXwD9QXiaAY3FkHrbDm6cyHeyLxeo1iWTgQHqZ8c7MYbR5BiGzoc=
X-Received: by 2002:a2e:9c87:0:b0:2ec:5324:805c with SMTP id
 38308e7fff4ca-2ee5e37fa63mr10595251fa.11.1719789054360; Sun, 30 Jun 2024
 16:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUU71k9kh3GGc8w=F4rdJeBc3LOPH-gNXrjTTUicnufe5g@mail.gmail.com>
 <CA+icZUXJj10358cBqxGo_zdR-JncbwPmBRAxiow3KRrVyHJjEQ@mail.gmail.com>
 <4622dacf-9141-4b06-a3cb-8e65b157c568@oracle.com> <CA+icZUVZnG3Mp83ZZzDCMMH_7+LBhrmbHO7b0E_0UYt63ymByA@mail.gmail.com>
In-Reply-To: <CA+icZUVZnG3Mp83ZZzDCMMH_7+LBhrmbHO7b0E_0UYt63ymByA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 1 Jul 2024 01:10:16 +0200
Message-ID: <CA+icZUXgYjxnuF9j_moT6goiR+TZT0X1X0n=z9_h5KwktEC8bQ@mail.gmail.com>
Subject: Re: [Linux-v6.9.7] BTF/pahole issue with LLVM/Clang ThinLTO
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, 
	Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"

> Later, I will open two bug-reports in ClangBuiltLinux issue-tracker.
>

https://github.com/ClangBuiltLinux/linux/issues/2034

https://github.com/ClangBuiltLinux/linux/issues/2035

