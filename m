Return-Path: <bpf+bounces-55183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFCEA7976D
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 23:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3864016C204
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B0D1DF975;
	Wed,  2 Apr 2025 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SoGBM4zf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863671EA7E1
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 21:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628568; cv=none; b=Hz+VkqQ4rugBsh3Qq1/lsJuxFzEhPZ616TSwSZQ/KGxBd4oTLAJoGYlryGQjt/+Ny5/+77AY4F7yruKfV6mXdluf9JL2VDcMVrj8cTJNZnvDNTanQqSPvv9dQaYrda7wYP//y0aU6ny7FivSlDdUSdGzGvS1ezqYbxk2358oLzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628568; c=relaxed/simple;
	bh=yMtg/5bd9WuFFPh1QUVVbVzPyQ8PxgEFM//QPDYEqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCvXWkMLwQ3zh+QOGZ2gBF/OZpaOuuSf+zgZftxXW9aD778ghZ0KCwwB2zCTdjpcRgimlu+ChwELDkVV3uDBGisGV3EPpGDX03Y/OAeH+eJKp+Gs1JY33ikw44apm/VaU8A0lgKF753WlBiCmadOiekFGjxcF6D8FJyfB+jiSjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SoGBM4zf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so433877a12.1
        for <bpf@vger.kernel.org>; Wed, 02 Apr 2025 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743628564; x=1744233364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=SoGBM4zfeK14QaTmaLNZqIonP2hWtcDaY324dZPRRROn221sMHC6qvznCrqMCnHnQE
         6+xmRk6M1OTdYQZXx0qASSUJ4fi4vHDa5ux9JtD7TsPrR9xJV5+Pk41BreceIFDCWCJj
         pmT+arCJH/Qv7QUEv+HbaitBxn7UokVA689VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628564; x=1744233364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=Lvs7h2PKGZRIAuOQiWbAbu6d6FVjuLCnCPNqugLNf4En/2lHH+XMixJXWc1c7QAmIn
         rXQ9Fa92fMc99dpPWGYoVnzAaCO0LC6y8wwOvb6+pgY/3A8h+3+iLYtaJPf0u2CV8oxj
         Vb3b+ajdSiAtyXPeUVYSzK2KUXiAglGjC4ZIIo8Heo15SAlHJpUsQI+VWVQkoFkWv8oB
         14708TtqdVcVyEt/ZJP6uSkV8YB25b0288Ku86RD7FVZiJFBBM4FFuli/hBWwOC0gELz
         NrleCK8H2/OthsP+Hz4ERLFdsQniPEXzTu44qh7djxEZ9ujqlgRpB36S5X0rGn8XdZNw
         eZxA==
X-Forwarded-Encrypted: i=1; AJvYcCXq5BmHMjpDigFVWc3Em7IBrXeyFWiZ/4IBLNTBeRA4nIBev8/mGv3ak1Y2f7+rUqW1qa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrqeaiMJYQTssyK0xBdQN5c6k40tJNRGydQSMUtzYyTQANyiF4
	iDpqIRg+LrJZsfo9VUdP/w0QFXLHC0cVo9sKuMahXR3BW1sN9KzcEJ8M18BzSqvhbETEFpZ4jgp
	L1hcYzQ==
X-Gm-Gg: ASbGncuq5dZxxlKKGCBv7Hlu2z0Z5v8HgDXOJKQ+zy5XdFQ6CzdJ2WBimqlNjlhGvod
	YdX3jv5tIBovMjS+WmmR09cVoxLbupUDmj2qt3VbNb0v++SfD3dAo3PGsOfPmJxq5G/pzEhTgt1
	5/pDGoY5bockcJ7y1jF9nZYjWnQu4m4I4O+GICX6RGLLHE7n/wExg+kxXL36CuRBcexaEaU8EvO
	fjlB1u+qZtG3bfbeVtb044GrL2cCkTl0H+360Xxq67/P3uh9Z8zU9DA516oO184DjuxhCkHGkEQ
	/EUMDRamKSNp1sMYFoZRYBkjkJo7BlEsUQsDttya89caOEuKzP11jDaKXmmXPlcEyDlYEibAY8r
	ysFf2oF3E58ar5wnK0b+DE7OfqBVfMQ==
X-Google-Smtp-Source: AGHT+IHDTtp+zthWGYr2fpUDAafHXRk0DTX/RA7izpZuMVF1xpr08VoAvlMnXNPPLmLZM/zAAPrpEA==
X-Received: by 2002:a05:6402:5207:b0:5e6:1842:1346 with SMTP id 4fb4d7f45d1cf-5f087221295mr63904a12.30.1743628564542;
        Wed, 02 Apr 2025 14:16:04 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae6fsm8944011a12.16.2025.04.02.14.16.03
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:16:03 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac298c8fa50so36578066b.1
        for <bpf@vger.kernel.org>; Wed, 02 Apr 2025 14:16:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+tyn8Z7uxqFNvkcObLxT7BfWHuS9iq/c800Y5bLEF/PV8eFGBDzvBlFCm6djRkSl+BBM=@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-ac7bc126208mr19593966b.27.1743628091735; Wed, 02 Apr 2025
 14:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-sDc-0qyfPZz9lv@mini-arch> <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org> <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com> <Z-wKI1rQGSgrsjbl@mini-arch> <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch> <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin> <Z-1Hgv4ImjWOW8X2@mini-arch> <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <20250402214638.0b5eed55@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 14:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
X-Gm-Features: AQ5f1JpKVAIlc4pALP5yKNCr8F3ijIqVBIOCCdqoIfNZomenel-ajZbKWJ5EdvE
Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Stefan Metzmacher <metze@samba.org>, 
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The problem is that the generic code has to deal with all the 'wild stuff'.
> It is also common to do non-sequential accesses - so iov_iter doesn't match
> at all.
> There also isn't a requirement for scatter-gather.

Note that the generic code has special cases for the simple stuff,
which is all that the sockopt code would need.

Now, that's _particularly_ true for the "single user address range"
thing, where there's a special ITER_UBUF thing.

We don't actually have a "single kernel range" version of that, but
ITER_KVEC is simple to use, and the sockopt code could say "I only
ever look at the first buffer".

It's ok to just not handle all the cases, and you don't *have* to use
the generic "copy_from_iter()" routines if you don't want to.

In fact, I would expect that something like sockopt generally wouldn't
want to use the normal iter copying routines, since those are
basically all geared towards "copy and update the iter".

           Linus

