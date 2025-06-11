Return-Path: <bpf+bounces-60392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54331AD61B0
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 23:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458E6163B81
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7BB24468A;
	Wed, 11 Jun 2025 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkWumd8D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BDD235BF0;
	Wed, 11 Jun 2025 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678185; cv=none; b=WBkXncj+VB3DPAnCpbBc3eWoRVWirSjhs6lIBdLDmKBb7kVlyQFUiSk/02HqFfEE4OvMqv7iNUvX3wLJe+2/bmTxZStZqs+33xRXcMJ7SCQjTtAAlyyA4dJGjddNqVGxrwwvsRF8oKaU5BGeVhLeSVCRNIUkZ0eA9e71+OSUSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678185; c=relaxed/simple;
	bh=QzSnrwxD5RBc2moPyOQ2yaX9end4w5bq4+MvEWyWQg8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EiR5As3n3JAHzRbXFJSV+BzYhXHJwngEclTH0SjRyi8+T8d0iturrqKGDruXNbmHx2cHXp1cRZ30rSW1a8jKsi7C3KQhny9tCaEVNQUCF+cYsqP8zVXyknzKxI0yVQkCi5hJGHgiOka3Zv8ghCKdPG+DFvCR6mCShoJMXV8XqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkWumd8D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23636167afeso3207785ad.3;
        Wed, 11 Jun 2025 14:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749678183; x=1750282983; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QzSnrwxD5RBc2moPyOQ2yaX9end4w5bq4+MvEWyWQg8=;
        b=WkWumd8DHfNOti1IY4JSmXVywnmC9uJ97SVEvstMT/CBPgz47ckP2GgijgX/oj5Jb3
         ZIzN147JkLKahX9f55kr1hTn3gD8RKw5TaubmMsxhBFojk1pqxERDkRi3WS+h6xo++M4
         PHMTcBezCxuR85ldzAW11iuVCLBFjU73ct1LtGFtL8H747DfjrDncKC3p/qB8PkvtpNB
         dgIs8wnj9/7t9CEpQQomCDjFvSvIB6m5dIdVyG7Uksj3Km38ql7ePrJJuHofVc1YSmIL
         W+4k/LEPXjKfOBTND5ymINkPZ1bHNyjr5bIq1jyBUTnD0Qn7u5nhwZfKxl5lgv9N0WEW
         8wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749678183; x=1750282983;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QzSnrwxD5RBc2moPyOQ2yaX9end4w5bq4+MvEWyWQg8=;
        b=HQvuOmeXEFagoLCqfgOZBGRLb1e0C37p+9hg41Gq0rGv3AmdJPM/ZpyJoFU+KHK9a7
         pjB7YLY19ra9tNnU4ptnfLAJDrackuoJmz/vh1i+Orne4C8K9qyH3+XBiTou9+fz58Zo
         mOpEb8nKefTWNT7NXY4CZzHXNbOVLkzDu7D6hEiAViA1oBcWqe7Ob5khWBXQ1hLtFTFT
         WrkBIML/MEU3Ya6mQ0xKX0yCJlWcNtV07b/rslGzXOdhX0tTJE6+LE9o7BEQgPaLv3U5
         duGsd5w1wwWq7020/+pqbey/WcT1TMeq9Mce2qxbv7Z2R+pwcP0oqfVb4OugqS3rOmHm
         zDpw==
X-Forwarded-Encrypted: i=1; AJvYcCUoP0a6UK5+wp9PJxwvbcAfs2k1U9gTr5VpvSweD/23zJT7HASm/ZLhQf66pOCaAFgmaeI=@vger.kernel.org, AJvYcCW6Sm2f7p2P2Iv4e/eUc3MMbOJ1PiQGn1O1QMlq7tPGXZXTuJtux1g8e8ZNA/zEPp9kSLArDr3KB4aJlISU@vger.kernel.org
X-Gm-Message-State: AOJu0YyWlAoD+37nd6nv5WAAqAZLQ/PLxjKuFT+/CBKesng73b6alWbR
	mlKCXnrboaFd+xclgzpzakJfzS78zZ0vASWcLVpb7IfgXvb+g9BSTF2b
X-Gm-Gg: ASbGnctZv0ugN3TKLxqyKOBRmiO++fhwoPtxaoGNf39Do6oewmHSwrFP3m468gdx/Ib
	9gdKICsnFcpkjQkKdzshmoDpy0krOC31MxceuIUjlJk8RYvBYUXFzQN4DgwB2+G+jfycLi8cBK2
	FMxI+1AaYCsr836mfTDrVGiWnvv8/SGInirt4Wi9vK+9HXFpRRMYLgakQdu/aFp1WuA4gw039yM
	Mf/nq77kygoNr2rR+4fSuVbzTi7wMdgUyXD97qZcafIlkJufPRq3NFVIz7tgoOhUdAeQcXLaYUx
	/v0gRQaqZGRpgKIbf8yaTBeyEPmsl7Ip9s76Hd0KJ82oXJQuwz+faUThB+MKIVAl/HHTZd9uvxy
	KZNyzi1zBbg==
X-Google-Smtp-Source: AGHT+IEArqzIQI/ChT0ea2asTVnoKOmnvkRv00pPZbiEMFF+SKhHO0m1qzURqZJn29J/e8WMfAs06w==
X-Received: by 2002:a17:902:d543:b0:22e:4d50:4f58 with SMTP id d9443c01a7336-2364d8ba3c3mr10041015ad.31.1749678182686;
        Wed, 11 Jun 2025 14:43:02 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b1d2:545:de25:d977? ([2620:10d:c090:500::7:d234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e719620sm370675ad.217.2025.06.11.14.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:43:02 -0700 (PDT)
Message-ID: <70fa837f583c0d9c0b7685dfe128ec3dea46d43a.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in do_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Date: Wed, 11 Jun 2025 14:43:00 -0700
In-Reply-To: <87plfa3qxi.fsf@fau.de>
References: <68497853.050a0220.33aa0e.036a.GAE@google.com>
		<38862a832b91382cddb083dddd92643bed0723b8.camel@gmail.com>
		<87frg6gysw.fsf@fau.de>
		<b6931bd0dd72327c55287862f821ca6c4c3eb69a.camel@gmail.com>
	 <87plfa3qxi.fsf@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-11 at 23:32 +0200, Luis Gerhorst wrote:

[...]

> I sent the fix [1], let me know if it is as desired.

Thank you for the patches, I'll take a look shortly.
For now I asked syzbot to test "bpf: Fix state use-after-free on push_stack=
() err"
(hope I did it correctly).

[...]

