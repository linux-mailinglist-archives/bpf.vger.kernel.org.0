Return-Path: <bpf+bounces-52380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546CDA4273F
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 17:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCCB18896C3
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 16:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC95261568;
	Mon, 24 Feb 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgpVRP+J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22468261392;
	Mon, 24 Feb 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412809; cv=none; b=eTOO+rajlfwpTYexoIduexXDSBHHyxnjCaW1fvgf5US4BsSRBJ2kufiyIGmJU7pJ8fVB/LvGtPEYfiyZTXQSTiYYKPz3ABQzJz+5RuXbAmkiu5SgMBXmQx+IqNv2Ey/FDEtwlhTR6zxTLNMpH2JYeFj91M6v24/BqHwR0ULR8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412809; c=relaxed/simple;
	bh=ppEdmYP18PRG+dGtFmSiXSQicDUWD6N3dqE1/BkXmyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuKVckYi2w+yDI9Hc/k61YsNkewm5i2JtCypbJPl35qsAJlVOCnqW1P1kS9Ep/wtxRdQOnj2dFvm6Yt+J3gbgCx6IBuV5zm9g8wGMDQUtsxOONgx+z5Xqbv8rB5RSTb1lsnE1tHErT5UfbAM5wU8oAnydCWxNkPUmdDlXf5TIBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgpVRP+J; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22128b7d587so88260485ad.3;
        Mon, 24 Feb 2025 08:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740412807; x=1741017607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJSyJJHLWe5L0dnjVOukO5eRCR7RyAx2z7yzwd10tbE=;
        b=JgpVRP+JGb8hhomczVBoR7pFQb0PzSswgPRWJHx+mYiZ9Ijd5ywtiB8dqIZS0XN2yc
         Zowo+ZEqoAIOoNaPvE0PQ7SwNvZLycAoRxAgLR2lwHjiDFAB1AwQIrK7H+yVvL88mLYH
         A/0OUklkLBdzY3ytCwqL7T+UR/t506WMUR1p6gXZ4Oe0DL/kXTcyuWRI7uPFg4vk/QGs
         CAv6yTBmC+KMz2beiWTfjuzoqqJTkgjzSHdCUbfc/uu0QzwhTA1MzruNZL0aEER8SoPR
         +zG8luyR9POsyix4dpjAybaS6FbjVPh1PSjoR4TwEHdCeeAN0leRveTwy2um3Qe/ahzE
         tBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740412807; x=1741017607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJSyJJHLWe5L0dnjVOukO5eRCR7RyAx2z7yzwd10tbE=;
        b=ZjO1V2TKPnNALa3d1P18stN0u2WbYIT4rk6ysmGxf76Fkf4yMJWCWyDD4auO37aBKC
         qMnzdzl2q6ObivPMo+lWMaMOJt3djXgYIpdCHA7+2Ca2l2CuVg+Q0FNDJpJGsg5kwMTf
         xlTFahg+VYm68cp6xcC5RxxU92b0lssoJHuJSis+w6lQzQBh5fUC62QlIH+TYYZCIIx8
         n1GlTV/5OA68VXl/mb0wMVJx8quJOfUKaj7JPGWZlPJHpmvQsvXsSQC2TC6ywTOgbK+Y
         EDRQBK4o44SLwBJzyZ0tweCWseeau1eZBtQVVRoDKGjd8MVmdrfIJCNrRdEPBnUlK0hh
         3rMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq3oun6JgwYxMlCPRUrTv0vQnkjPA5T1yXJM9JNJbRgIC+77oH/8JQANK5kpnhW4qznrM=@vger.kernel.org, AJvYcCWqQaZWx2ukEBGCHw5y2yzuCLi6ndiB5KujCWnV8fX5YoJNdSHNA3kTWgRCC2kyHdHEIeAp1EiA@vger.kernel.org, AJvYcCX6zQsySyRFYP6gAen2qqL+jUq3xjDRdpu5ZNHjOhHpe2pa1gMLjcZXskAVnvzJaMIGP2O1YZRaZqhoAQ0Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQHI+vL8C1avFt/OvvR//LZa4GQ0VzL8mMRfLH7NrRhfJ5wnF
	+lF/igyO88UQZUTjdeKqhTmXkuJXrjkvkk+T7YvjuMG29uilr6ocFVT9
X-Gm-Gg: ASbGncuuKSKfQcH6jbPc7FPIrmqLYDTZuF8xXQ2lkhuPmeEp/PyVcSce0hHK/B6/mUO
	He5nJPONJRH7J9xwpLAwB2SIcom4FF/Mlvc5oyxGPzG6nPDrUgpy3AoYOD39cmVezUbwmgeQDti
	i9RV0Y33JnUZKZfMtnU5y4mhVwX+Ff0RDcM5GzPujSK6eLVNc+icNzQkOpawruNMpgtXsUmr1V6
	XX2Ji4eb6Blc4yQ6ZAegEJyZCK1DDNe7MeBMiekg9AZEiYQ9sjVNMqAQf6AuEFH81KJ+HI8MOPd
	dbtUaD7K1fp8sDKVDUg7g+txqQ==
X-Google-Smtp-Source: AGHT+IGOcR/OrIIpcSGp09qJ+wMTXvY1EEIfwdy+SXIugvE/nOGnXjJstK2HBNEnI0W6I/4mejx+6A==
X-Received: by 2002:a17:903:191:b0:220:c2a8:6fbc with SMTP id d9443c01a7336-2219ffd21afmr253042135ad.34.1740412805689;
        Mon, 24 Feb 2025 08:00:05 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d545d016sm179712775ad.146.2025.02.24.08.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:00:05 -0800 (PST)
Date: Mon, 24 Feb 2025 08:00:04 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Wang Liang <wangliang74@huawei.com>, bjorn@kernel.org,
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] xsk: fix __xsk_generic_xmit() error code when cq is
 full
Message-ID: <Z7yXhHezJTgYh76T@mini-arch>
References: <20250222093007.3607691-1-wangliang74@huawei.com>
 <CAJ8uoz1fZ3zYVKergPn-QYRQEpPfC_jNgtY3wzoxxJWFF22LKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ8uoz1fZ3zYVKergPn-QYRQEpPfC_jNgtY3wzoxxJWFF22LKA@mail.gmail.com>

On 02/24, Magnus Karlsson wrote:
> On Sat, 22 Feb 2025 at 10:18, Wang Liang <wangliang74@huawei.com> wrote:
> >
> > When the cq reservation is failed, the error code is not set which is
> > initialized to zero in __xsk_generic_xmit(). That means the packet is not
> > send successfully but sendto() return ok.
> >
> > Set the error code and make xskq_prod_reserve_addr()/xskq_prod_reserve()
> > return values more meaningful when the queue is full.
> 
> Hi Wang,
> 
> I agree that this would have been a really good idea if it was
> implemented from day one, but now I do not dare to change this since
> it would be changing the uapi. Let us say you have the following quite
> common code snippet for sending a packet with AF_XDP in skb mode:
> 
> err = sendmsg();
> if (err && err != -EAGAIN && err != -EBUSY)
>     goto die_due_to_error;
> continue with code
> 
> This code would with your change go and die suddenly when the
> completion ring is full instead of working. Maybe there is a piece of
> code that cleans the completion ring after these lines of code and
> next time sendmsg() is called, the packet will get sent, so the
> application used to work.
> 
> So I say: let us not do this. But if anyone has another opinion, please share.

Can we return -EBUSY from this 'if (xsk_cq_reserve_addr_locked())' case as
well?

