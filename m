Return-Path: <bpf+bounces-45778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848169DB0AB
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292DB163E2D
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C821CA81;
	Thu, 28 Nov 2024 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKAZ9mhP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710717753
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732756899; cv=none; b=EscOYf6mDf1yoDEr/UCEUNMWY4H8fFXCLVNfUpFnESO69u04i6hyhQkbyL9Xbftn1/dNihdAMahpQMxVk12Z/b9Nyk5iZZKg9uVqUEkzZGpNurITVAxR/1I4yQxZ4/X2rq0I0RAkeDSFWDm5x8KqBCJ/qEC0OpOWO+Xq/b56nEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732756899; c=relaxed/simple;
	bh=LHCttBKVmGiEFkDuvVyh6qvB1fy9K0/NgDEKYG5fDPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R73qe2MkchtzVmobThMaKdF4l+l/35RdmstlrW7VyYaWgasTgS2zh7GMfY2uG7pciSCNNbO1vlRyzNWrydTokp5ef2tLxibNa/hz2teF2bS7wctgXChO4n8O+E0029NlbMdm3DlQF8DSEaMMAbl/ZrIIErEb1KgSL6uVPIdNVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKAZ9mhP; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7fbc29b3145so1101660a12.0
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 17:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732756897; x=1733361697; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNxkVZ+Q09hml3KpYdRFKKixrbV7shjxA5HH7/nIg9c=;
        b=CKAZ9mhP2XwLMTvKFsoXZjyOm7CwteY1WbBGZXGpcZmLOKgQkhHu0sD3/6zeXoeqE5
         9Nimw6UEuzfB9nYM1gkym0njmByPwmfoGgN9HqKWLi5hG2MdqDr1foRLtXp7VnT8b3nE
         2Hma1lOudmk+PN1EBtoxE0YOL8ZSXm4xspLXh0R/kb0DTFOEF2gNLZyLRb73vA65HE7j
         T55M8+zAReNj8GWW/KCKthJDfrmcGZ5Q8OnwzNZbIx2BkdXpD5a/3og4LRmAJR0fvxh6
         mWCuU0lAU0cNu1PLqxsDTBN/OG3easp5r8lz5Q1uO2yQ3rus7YHt28t4kR2lOqvRl8GL
         WzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732756897; x=1733361697;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNxkVZ+Q09hml3KpYdRFKKixrbV7shjxA5HH7/nIg9c=;
        b=lyVznzrY/k7J5BBj/gdqOadA+Ynp47M0gtsrcLjy/FkOVzxXVNquwJ5oDfqFTv+dcc
         zEI9S0/knKPzIPHVqzWhjN3Qf34mmeQUfAMUGcAeK6Tq4tT0wABQ+ThBOBIUfPWW44QM
         4/wjDJWVUtWki5HZHsb3s9qw4zBnVMeCY9GEbyXvvQuVC6iYxZsHNqlsPzKsOnpJNRSm
         Z/+E2tA+/HYMOVV23km9pC/vz6pDM9QiyHh0GfWujRGeZWGDJINFbhEbCuZxA56UTx5S
         AJJZ+aAIO1VUo/mKwqxJcS0pmZpTxElZsXfY9eAxvrscSc3x+yb54aTv2vyPmkIOAPwM
         dfdw==
X-Forwarded-Encrypted: i=1; AJvYcCVfiyOmyYnk/Y47AeKatGgjhlqNcYsZxHhv2x7DFKH2XoTrDxRr+MfFqqn3B/ZRY9C3K0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVt2OXFW6IhD2NieNie29A1jsaSNbleCCRQvC+2flBG5+uiXpa
	Sx/v1Dcnrt7p8NZ9HTKob0DxIZS3hAo1/M0dqA0tD8EKlchCjC6Z
X-Gm-Gg: ASbGnctbuxr9bunCzHY379E6M7dtSFPpXJoNsbvwjJ5xLyVNdxz/SQJUDPdVAfy+XMQ
	L4Mstl0aCXznZbsk24czqWttNJnYxwqy3p7DhQEGrNFwsy+BW7bWT4Xt35vAbKdM6e+xVr5B1pm
	S/O9/9oaxVmey0IGxahR8pfhuWryFl+1WkxgL9dggX87vFh1TMzPhHz7gZl1xVR2CVAWyzT+dxr
	qaA5av9ITvwlB0+l/qfSTNZlXZldwKk6bZQ1PJcYVkPw0k=
X-Google-Smtp-Source: AGHT+IGkAIrj4OTnCyiXGwz8Ndgl/ntv9MrAVNEG/hiB+b2x1fKmDlOWxLvoDEpDts2L0DVQGnOVFA==
X-Received: by 2002:a05:6a20:2590:b0:1e0:c99e:1f41 with SMTP id adf61e73a8af0-1e0ec80bc72mr2328093637.8.1732756897036;
        Wed, 27 Nov 2024 17:21:37 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3a320asm171943a12.83.2024.11.27.17.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 17:21:36 -0800 (PST)
Message-ID: <e7d21c0bf31f8e45ca5c80749ad1b417c96e4ada.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Fix narrow scalar spill onto
 64-bit spilled scalar slots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Tao Lyu <tao.lyu@epfl.ch>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@kernel.org>, Mathias Payer
 <mathias.payer@nebelwelt.net>, Meng Xu	 <meng.xu.cs@uwaterloo.ca>, Sanidhya
 Kashyap <sanidhya.kashyap@epfl.ch>
Date: Wed, 27 Nov 2024 17:21:31 -0800
In-Reply-To: <20241127212026.3580542-3-memxor@gmail.com>
References: <20241127212026.3580542-1-memxor@gmail.com>
	 <20241127212026.3580542-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 13:20 -0800, Kumar Kartikeya Dwivedi wrote:
> From: Tao Lyu <tao.lyu@epfl.ch>
>=20
> When CAP_PERFMON and CAP_SYS_ADMIN (allow_ptr_leaks) are disabled, the
> verifier aims to reject partial overwrite on an 8-byte stack slot that
> contains a spilled pointer.
>=20
> However, in such a scenario, it rejects all partial stack overwrites as
> long as the targeted stack slot is a spilled register, because it does
> not check if the stack slot is a spilled pointer.
>=20
> Incomplete checks will result in the rejection of valid programs, which
> spill narrower scalar values onto scalar slots, as shown below.
>=20
> 0: R1=3Dctx() R10=3Dfp0
> ; asm volatile ( @ repro.bpf.c:679
> 0: (7a) *(u64 *)(r10 -8) =3D 1          ; R10=3Dfp0 fp-8_w=3D1
> 1: (62) *(u32 *)(r10 -8) =3D 1
> attempt to corrupt spilled pointer on stack
> processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0.
>=20
> Fix this by expanding the check to not consider spilled scalar registers
> when rejecting the write into the stack.
>=20
> Previous discussion on this patch is at link [0].
>=20
>   [0]: https://lore.kernel.org/bpf/20240403202409.2615469-1-tao.lyu@epfl.=
ch
>=20
> Fixes: ab125ed3ec1c ("bpf: fix check for attempt to corrupt spilled point=
er")
> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


