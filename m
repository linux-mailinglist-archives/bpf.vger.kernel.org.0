Return-Path: <bpf+bounces-64369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C534B11DFA
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 13:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6DF7AFAE3
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 11:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0B12E764E;
	Fri, 25 Jul 2025 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mycq4hNY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3E2D131A;
	Fri, 25 Jul 2025 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444549; cv=none; b=Bwk7a1vZJmBnqY0EWZg0serTru3U0agjmEudg1lbZ9AkVYG/TDudnn3TLly4jn2Z3pKqx1bVAqGUnNcsld9XJ/QJ6F+gZroaeTJpSs9kY7gPawAM2zVHdYPX7Gkm9/IuuMTAh54s5Z4a09DrJQWK/JNp1/vbjRrI4bz7HiLo4tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444549; c=relaxed/simple;
	bh=EW3/RZewc04Z4GAtT/t6/g9e88MWqG2n6qtKS4h8eos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqsn2R6RT6ktZdwFrog89QNdwvsZ6sM4YvT7OApBwhlFytY7kV+Hp0bS28Cca3fs9O9ntN5Grnoiaz2ZL3K5qUQilr9RK9rWiAtbHXMvyeajij3bCQ73MXERo5F5l876RQBSWnSTPK23d9klHRDyTi6jFzDGySKQeyr3OTLSxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mycq4hNY; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b50f357ecso18697031fa.2;
        Fri, 25 Jul 2025 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753444546; x=1754049346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW3/RZewc04Z4GAtT/t6/g9e88MWqG2n6qtKS4h8eos=;
        b=Mycq4hNY49z2HwhyEKNvj+RhUAalp/UnOc2f/XM+niRM9BBy2u+Lk0Jbsaqzly3Tyy
         JT6eIsyBTchQYQkwgcmUIXYMRj+9Z7Tm8/kTFYkFgypI71kSa2bo8d+0MJzqccq21YTA
         8ybUx7pqVMANI+Uq6BWDo5Kvz4a9MZsjAQgT+J5jkKW5aBfYseKudMugFz9DCXi+C0ky
         dPDRoWBqYrvqhqeBxo0VfrlieZt03zxfHZG4to5vF4z+ZxZrnxgjbEOx1dhG/9ep/0r6
         +uapPyMCSEhPSXN7bqT5eHY2b9lxo4HyGF/bf6p2+Hqn/ONFMFCYjGTJf6h2JxOoQVK3
         QtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444546; x=1754049346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EW3/RZewc04Z4GAtT/t6/g9e88MWqG2n6qtKS4h8eos=;
        b=Kin8htooZXKNESx3A++JKNj1UssISo3d2zQ1HtE5dQxUuOe4cyvNlyAn1UzIuhM0fK
         AVIDwJkzx/tla5vPMs2y4HoXSkZmrCXVQ7AFSmA+zYCyxoTszZKWOR8NmS1aiyeLuf4a
         KzqCxByIjcMuYv6JsMBXA6PxjRzHtD0iakPJYtGQXQ14nVQZbnBtUY7ny1uJlh4FQaqg
         D71JjU+uFO2nUv3RyjhCvKGmPkanaUSUxxdgY5ITsVfsr0JgsNKf1TndYU568URWUrI9
         wva+Mto+now1tmwBrO9Y/F2oRBsyVuPLnL6Y2+XjDnF70Aedlpa+KbqEqdi+LkaFkaHF
         vRSw==
X-Forwarded-Encrypted: i=1; AJvYcCVlKWV/siZ+JZk84vCqMCN27hVKu5pjUxIFz7+qCGXkprd/CjaMorkuV6VUw5H2KVPVw59HA2rd3qF4dm9d@vger.kernel.org, AJvYcCWMmdbm4kgMN/IoxcO/wxfWnhjEcDIj7Igij7TqXuOzAE4xUxS6XXWDFpxYHQJAqjSsnJ4=@vger.kernel.org, AJvYcCWbvAxAA75Edsddd8PLAj3XDryO9hcdk9gpmeDznHvC620l+Dy0B36WpSFaVasJFdNrXLhccdd2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw33AQNdiocz0vV4Dc7mq7PsOAi2szGsYQWu8NYR/RtPr5q5rA/
	weg5E77o7cQcYfamYK6twL75KtSuFT4pe6p0UEo25XqEX9aB+D+CRKzfZSasJExF85xppdLD2/P
	9S/ZYCVB8hRe0eDigGnaqRms0/WQiC4o=
X-Gm-Gg: ASbGnct99cE035Prz/AgOTtMEoBJ//ruYCgA7c+7AJffrOk1sGrlPfdv8dvdjCsd+1i
	hQu/06ob+oo8K031L6G731AXL56hJOibt1zRU4/UUF79vSSBbp5EnPAAcyyXmJIRCnOxP+pE8Ax
	LWFbPwyfr0qrvCADNlKspMFh9fLsNIqy+hLSFNCo9OYq2nVCXVRhkKfYgLnFu0UYiLr/YkMtWWK
	y0vXVWFI0PrxlcaMsnpOrkUfYoL04FLAr1gXez3wg==
X-Google-Smtp-Source: AGHT+IFQLSGhteolx/BhOZh7kHImhRPByLeZr3SrV0xHcjeohc1TolIS9Rf5FAEeQLC7LR/UZZU7aU/rJ0/IuqEp9es=
X-Received: by 2002:a2e:bc04:0:b0:331:f04d:e689 with SMTP id
 38308e7fff4ca-331f04de9c8mr3170771fa.41.1753444545646; Fri, 25 Jul 2025
 04:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715081158.7651-1-pranav.tyagi03@gmail.com> <0f6e9770-1c79-418e-9135-df692f495a91@redhat.com>
In-Reply-To: <0f6e9770-1c79-418e-9135-df692f495a91@redhat.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Fri, 25 Jul 2025 17:25:34 +0530
X-Gm-Features: Ac12FXz-wWa5xMiQLJyLbW0dhFUU7-B1JQL6vLwtj-BbP0qyqr7vZXvi1e48OKk
Message-ID: <CAH4c4jK9nYf2n51m=eaS4gtx9+cjzhXDAb741BA+burmQtD28w@mail.gmail.com>
Subject: Re: [PATCH] net: skmsg: fix NULL pointer dereference in sk_msg_recvmsg()
To: Paolo Abeni <pabeni@redhat.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, ast@kernel.org, cong.wang@bytedance.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 4:40=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/15/25 10:11 AM, Pranav Tyagi wrote:
> > A NULL page from sg_page() in sk_msg_recvmsg() can reach
> > __kmap_local_page_prot() and crash the kernel. Add a check for the page
> > before calling copy_page_to_iter() and fail early with -EFAULT to
> > prevent the crash.
>
> Interesting. I thought the sge in this case are build from the kernel, I
> did not expect a null page to be possible. Can you describe in the
> commit message how such bad sges are created?
>
> >
> > Reported-by: syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Db18872ea9631b5dcef3b
> > Fixes: 2bc793e3272a ("skmsg: Extract __tcp_bpf_recvmsg() and tcp_bpf_wa=
it_data()")
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
>
> Does not apply to net. Please rebase and resend, adding the target tree
> in the subj prefix and specifying a revision number.
>
> Thanks,
>
> Paolo
>
>

Hi Paolo,

Apologies for a delayed response. I will send a v2 of the patch with all th=
e
required changes shortly. Also, as I am a beginner at kernel work, my initi=
al
intention was to just fix the bug and (honestly) I did not think about
the cause of
bad sges. But, I will definitely take a deep dive and try my level best
to look for a suitable explanation for the same.

Thanks for the feedback.

Regards
Pranav Tyagi

