Return-Path: <bpf+bounces-74352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884BDC560B3
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 08:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C253A8C2D
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 07:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9C322A2A;
	Thu, 13 Nov 2025 07:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwjUu1tP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D726E703
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018742; cv=none; b=R7LSRKegs0I4xPqrJqktALSn7Lb72z7EQnwk+6Ja8fxuwSGQ+TmwocvRpdOu6RBG+80v9MFeMglmIyhFInmp6Ad1u0kODwdjPTPZ3KYs7HE/TjqK16fCHGGrrW58aH2Xt8EqfwfhhKPj5L4RWog+aOZu7gdthqELSQLrVE7NPdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018742; c=relaxed/simple;
	bh=XLDYQdPOQQu7I+nB+wICmxnlWnxh5nzKRwi69X1Hpq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wu0vNs3bZGXHnAgKVNj0Mfcljmh3CF1ixh2VY9mXQbpbC3LfmEcDfAP6hEHG6kla6qbF3e3andFXZ7qKBG0D1m4a0C0Lv3OqV9lV9s+N47jlmgX78RMy0yTIC9heNjto4OQxum5WlS3lz5waKLlfLC9SchUZUdYdOpF5GZu+cRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwjUu1tP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C027AC113D0
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 07:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763018741;
	bh=XLDYQdPOQQu7I+nB+wICmxnlWnxh5nzKRwi69X1Hpq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rwjUu1tPQxIh3XYgsHyq+dr2g+3k7mKsxB8wUFVCVp3QMVtRm/+kjE4Myt7A0rbmT
	 nKaPMmYeW9wTZ2J+jfNbc3Ok9UOIXFZADWZBMSV3Vri0E2qKpn1Kg/JWlgkqRF5SIU
	 gLWIik62dq/Ob+pM+g3BfOLQZMVBtmQqYu/DpwxCgVQz8n84UCYUv4sVC5hWZinKRo
	 2cmukKcMWj4kDgZZnOHcYW84yiyCewYTrTF8LzgumzGIMRY33uvEm9gZeBR/PLVXU7
	 qga0wqmXjuEZyWH7TlK2upMR3QL0NQDQknkYFuiTg8QMrizOvCi1EoPo7gnv2iu/Fv
	 N+eqGYlsr6crg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso4226961fa.0
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 23:25:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhMNKSjsVwJirtbSIr3hQ6OUowQqyd8WbvLrW5rKujwqU9hKWf4HXL/H7+LKH2Ke8Cc3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwERM6J4YSnS0B6R40ksV/bEFniPiKC8eRwbN+eX8n+4wTjIf0z
	EXqqDcypg+cAYv3aGNRdG8VlSqJFrl60FD/n72h3LKtTKMlHSQFZqK9nIV3Pm+ujEqS8gSfq4DA
	6oj/Bjwqu6qhwpR8CltGoGymDDgxKz1g=
X-Google-Smtp-Source: AGHT+IEmZFz9W2ntlg7FrJCD38t6lX7yLM9cXTbgDaYgbksctFv3eF/YtsefxQSgSb1AfMk9CYOoXLZGRPy/+mkf5E4=
X-Received: by 2002:a05:6512:ac4:b0:592:faf7:2a0 with SMTP id
 2adb3069b0e04-59576e23e98mr1948792e87.33.1763018740071; Wed, 12 Nov 2025
 23:25:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929194648.145585-1-ebiggers@kernel.org> <20251112121212.66e15a2d@phoenix>
In-Reply-To: <20251112121212.66e15a2d@phoenix>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Nov 2025 08:25:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEM62YLP2oLEA447hCFidTqE0E76XrTO02B373=sa0Jkw@mail.gmail.com>
X-Gm-Features: AWmQ_bkp6VC7iF3JHTvtIdRD0oqnGXw55BKW7fE61KwN1gek7oki8xM5m_DyMVU
Message-ID: <CAMj1kXEM62YLP2oLEA447hCFidTqE0E76XrTO02B373=sa0Jkw@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1 code
 instead of AF_ALG
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Nov 2025 at 21:12, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 29 Sep 2025 12:46:48 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
>
> > diff --git a/lib/sha1.c b/lib/sha1.c
> > new file mode 100644
> > index 00000000..1aa8fd83
> > --- /dev/null
> > +++ b/lib/sha1.c
> > @@ -0,0 +1,108 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * SHA-1 message digest algorithm
> > + *
> > + * Copyright 2025 Google LLC
> > + */
>
> Not a big fan of having actual crypto in iproute2.
> It creates even more technical debt.

I understand your position, and I agree with it in principle.

However, the usual motivation for not re-inventing/re-implementing
your own crypto is the risk associated with getting it wrong, or with
failing to keep up with bug fixes etc. Given that SHA-1 is already
considered broken beyond repair for its original purpose, and is now
merely a glorified checksumming algorithm that is only kept around to
retain backward compatibility, I'd argue that the situation is a bit
different here.

Also, I strongly agree with Eric that a syscall interface to perform
crypto s/w arithmetic that could easily execute in user space is
something that should have never been added, and creates portability
concerns for no good reason.

