Return-Path: <bpf+bounces-68250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C568B555A8
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 19:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A915C0AEF
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 17:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8248932A3F2;
	Fri, 12 Sep 2025 17:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSN3kVvJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039A311C20
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699741; cv=none; b=OsvLXrRdflJNOGPWVn0jYmU3VsLPmKzKuD29te1pgk4Suil/WM2svBqGwhnDV+cnKAD2qxt8SQ3ZGNtoFfmUcz6KZauBEJVx34mIG8x6dGSmlTzvZjriA1Yu2qZVCIoNhOh62lTABs3ik2Q3EIDhIF6sDUX6dwpH/+5/tVDLork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699741; c=relaxed/simple;
	bh=21udc6JLttU/l5KykgHLGN6cnqZbUcu6oJMFH12Gbc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoxWPu+DIWYKyTNJfvSADkWBj/YbC9liJLXsQcJFAFXK8XpH49vBeha1CjUR2FPgdBMbou/2zBOKVSFP9IvBxbOwKvxca8DNdm+op4j+cKtZ4Zz6xTfH6nr+LgdeC4GGOMZuywxgGucMm7hNp4eSCh5ExG9zz+Aw6vCZouzI8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSN3kVvJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3e77e917eefso759090f8f.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 10:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757699738; x=1758304538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1hqm75GbQcmUVjrwGt63wYxMp0L1ujfuRL7MiRNqrs=;
        b=XSN3kVvJRH5ItNq2CO3DlPwO5D+SEi2EvI22vyF6fgjL+J4+DykHkhPn8ye+UDIJ1b
         jKr7uJaYWJSfPfBQXLkWk4w/DqtkKP9p6rIJoG8MP5iVm0sypCbTyVeJR025OjqP5QLZ
         150Md+okjlmJu7r6PQlvMvX2rDiSs3OE7abFFd9UJfsH97t4DeKWqD/knKeOxsOD0V6L
         rgYdTCgLx91yZK6Yd2xnFC9OzfbL/uIuFiDZ1VMGvZ5aJJUNDWKgNtUj/2dDP1twW5X6
         ha0pW4NM0j0WI/AhGKHc/OvMfUSdMXt7SgQmYZORrfWDe0jYmfKxev3jfnKh7kBfAE1s
         HEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757699738; x=1758304538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1hqm75GbQcmUVjrwGt63wYxMp0L1ujfuRL7MiRNqrs=;
        b=uDztgyB45y9mcnDNmbznXb+SmOiIEiYpRlePNvtQHD07sNzUvCeoHMwu9bQx4D1/RY
         AF3jDrtIlfS27DaNk4Ozq8MdNFQxCtqYzM5M2WheSVK+g23A7pifVHabEb5a2VbLDHwG
         YGwzR3lu0WBsltT5EBrM0Fz+1fuut1dajz8eLI6riDrhRqDHzVr5lSh7PqEnbQWxGL9K
         G719BPKgmuGoWDKNF3lLZ9YsYSUhXHUFmKUiHVw8FFxkvjSX8ybJKuPUSAZfEv4fwm5k
         kzf9bV/XDsI+IqMx1SwxRbfpSWYDaXOz8fW9FAs6BfbIVAZeHI+/0fU5f6S86VGIZVVf
         zEzw==
X-Forwarded-Encrypted: i=1; AJvYcCUUGt8M+GV05Aw7kIu24py2bjKJw4FsXallE8M13CtnMD++HwjYJ8IqQZhZnA2Qp/1bVAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTN4NlChm6hUbiP1S6aOxkylt64E3WVevdE6gSin0B3pKKZN9
	0vkMKYiZHcsa/W1D2+D3E8GbEqpM7X+cBdPORMLbe8NLelbqwEZdhXud4tgyNjjSvypfeo8UHxx
	kiQcElHXErhy1Q6Lpc9cJYpNedaLJBjI=
X-Gm-Gg: ASbGncvuxsIiNb2a49zKU3CtHRvOe/45MFK6hfFb20JDqMkwhAzEi855q95do2hBdSt
	xJDRljoVHx5VTyMWvRpJBwZ5NdG+gXxBRTPV6vmUWGiC5/ugcg+6Qzn3kyWZLe0gU5Qve6LFG6R
	byCdTQI+tqAihzYC93h+LfU7hXyBgan1MdlatZ+BiXa8Z8mH6pJldXDlEueYPHnNmrp/ij20xis
	2bO4BKwqXr/e//be+9FXt1rZ8/uGpNyeR1bFwofYKiXWYQ=
X-Google-Smtp-Source: AGHT+IGkgj6IrkdGUDNbAf51bRnusq5rydfcWtBFKBRkglsxY7vTPHWpp7JaetFcOJOedb2SaAMVrhhCP6B4H3UnkTM=
X-Received: by 2002:a5d:5d09:0:b0:3e7:17d4:389b with SMTP id
 ffacd0b85a97d-3e765a1b499mr4151861f8f.52.1757699737563; Fri, 12 Sep 2025
 10:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912124059.0428127b@canb.auug.org.au>
In-Reply-To: <20250912124059.0428127b@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Sep 2025 10:55:26 -0700
X-Gm-Features: AS18NWD5ST2IJKM1utHYQwt-Xxi_J7BVpfEK88PJRAO0c4SRtSvsWIsTf6DJ07M
Message-ID: <CAADnVQ++ULXeQQ=oLTXvoo98QSrk-afc=H5Lq9Pm_LyH3X=sCw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiawei Zhao <phoenix500526@163.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:41=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the tip tree got a conflict in:
>
>   tools/testing/selftests/bpf/prog_tests/usdt.c
>
> between commit:
>
>   69424097ee10 ("selftests/bpf: Enrich subtest_basic_usdt case in selftes=
ts to cover SIB handling logic")
>
> from the bpf-next tree and commit:
>
>   875e1705ad99 ("selftests/bpf: Add optimized usdt variant for basic usdt=
 test")
>
> from the tip tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for headsup. Looks good.

