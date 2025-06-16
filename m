Return-Path: <bpf+bounces-60780-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E585ADBDC5
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04FB173039
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450D230BC9;
	Mon, 16 Jun 2025 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nN2JijGd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D71917FB
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750117235; cv=none; b=UwUoNHo5e0N90j7rnytf5+cgWp68j1KyB8EuvA19QHpfXjyDKVgrMh694ruQpEYUuqnuRdcrl9PeKh1neKwo7hPsqlN8qaeqsny715gKkNEUfB9UuTWIepEkdEofQH6on81Fq6R+AyvoJX+KUEyNkSydHpuxDe9kAocJIL5ZtUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750117235; c=relaxed/simple;
	bh=Cqx2QT4ZsXirJdKTudVAIg2y346l5voOnlraoudOTRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzyytC3xn+isqWqDVcdazavdZ+8R0WVxEC6IS0LUdatbfnO4bzS/7DXpeji2e7DyZCudL0or9iDILnFgyh34Lrs7zCajhAOl86M97bsL9qvXk+Mg8xu0MP8ObGhgUw7qvpD0WICt+jtFRdLiSmYrjNrYbeu/qRbz3niICL6nPn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nN2JijGd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAFAC4CEEE
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750117234;
	bh=Cqx2QT4ZsXirJdKTudVAIg2y346l5voOnlraoudOTRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nN2JijGdICG4D30yTh75WwpCFspAXFhmHzeygUf3+yT6IJHRXz90uMCIHGSXkDqTX
	 ZNiRh76K4uAvcbPrl6pzn4mVEjO+Ezo//gvc/0GjldZG0SfgbM8h7EY0t4hCrOO8vi
	 o7G+TkxYAQ7SDYJEnUTxaNamxRlEuHULE9YUjfuDkS3LhdqSVTKxkghdZGm5ABhxVD
	 IgRWfW4gI3U8xIm+b/cZFFeJnIr/0Q67mGMCcIFy3Ws/R3BMdFpCq/CT5YPNpdkB6G
	 Kg0XHWWz9CSbgsaBXhHjAcpBAuE+k83ekKS9k84r0GPorgKnZf4nsjxGg9qOkluQAF
	 4egNYhPhAPBjg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so8709610a12.3
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 16:40:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YwoM8ywZgm7S//cSvxmtyOnrQAX7eG2lkzsqOj8p9niJ3K3KKf8
	P8lBjo1X9U11zrEoBHQoABQ69eOarzy9MK7jKd7jTILndfzZwb/paDvi3L2kvl6ECu5/wR5Dm4H
	9qPC/3kqVvkSSyJ+8pOCoRpstyUubvHnzKlg4gC5N
X-Google-Smtp-Source: AGHT+IEDKpjHo/Gbzqa2z+WMURU979MQvH4IQ1L/if+Wo9grOi1yttcHgKXO9kDbkcFfKraMC00uUsb7OCjsl0FGxsY=
X-Received: by 2002:a05:6402:d0e:b0:602:36ce:d0e7 with SMTP id
 4fb4d7f45d1cf-608d08658cemr10162958a12.14.1750117233186; Mon, 16 Jun 2025
 16:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606232914.317094-1-kpsingh@kernel.org> <20250606232914.317094-2-kpsingh@kernel.org>
 <20250612190739.GC1283@sol>
In-Reply-To: <20250612190739.GC1283@sol>
From: KP Singh <kpsingh@kernel.org>
Date: Tue, 17 Jun 2025 01:40:22 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5NbpTjwtWKx6ehqy7wyENovcFQVQqjO0-m9XoAJP=-nw@mail.gmail.com>
X-Gm-Features: AX0GCFtvAwFa-JdmxRCygpF_xI6vbGUfQT6VZZXGn3k-VkViBMQLjbSQDgnQcXg
Message-ID: <CACYkzJ5NbpTjwtWKx6ehqy7wyENovcFQVQqjO0-m9XoAJP=-nw@mail.gmail.com>
Subject: Re: [PATCH 01/12] bpf: Implement an internal helper for SHA256 hashing
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bboscaccy@linux.microsoft.com, paul@paul-moore.com, kys@microsoft.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 9:08=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
[...]
>
> You're looking for sha256() from <crypto/sha2.h>.  Just use that instead.

I did look at it but my understanding is that it will always use the
non-accelerated version and in theory the program can be megabytes in
size, so might be worth using the accelerated crypto API. What do you
think?

- KP

>
> You'll just need to select CRYPTO_LIB_SHA256.
>
> - Eric

