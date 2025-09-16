Return-Path: <bpf+bounces-68567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D76C9B7EB31
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1231889253
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168E829B20D;
	Tue, 16 Sep 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rozeolhu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02C1C84A6
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758062754; cv=none; b=n2xDU7C4K2b24BIAhNMFXo8GcGlPqOF1JIZOXD6IKFgKjGH64DFrobk7tKuxcPlzzt0avB18LYa8ODwBrthoYf1qWWujvj5Hwt8/Zd8gVhDbCp3BGvYze+Toeu1qk+smqVvO3RHXrebydDaL4atqBqNRJBKbmr3jp2T8kiMhenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758062754; c=relaxed/simple;
	bh=CVGQSejNM0kqDxvi5CCnLuXhIXZU8Q7NsqgYZHQR4mA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CtCh8wDPc4vIT8TMsg2kc3vu+At7nkup4DqLONZRDKADUCoE0Yi5U06zTq7t39axPHioN9oDt2TqF2Jm3RpiBE1rgWJrikjXD4wIxayG4NOR+thW3lx1Nc89YsBmxVo9A1BVl0szydwjuCpXxGrRFNRcYug/HW35hE+E9AeQWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rozeolhu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-25669596955so62018785ad.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758062752; x=1758667552; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sFpkXuJ44WWuUXPKFCvaa4NH4gkZQ5KGZfr9yDw0adg=;
        b=Rozeolhu3C0rUFT3T+i9Xzqy16QwNH8f8LmGqCtYVwF08ysK3/OM5GKEJc8fZjBAqP
         Kh5X0booPu/5oopsfPec9b6w3guoNg/ADX6LvLVHKfhVGy2WQEtv+Gl/5Huv2U1GTWI+
         lhnegVzMHmylVTvvZmB4NGLHVrEcl61rgSB3waVuo/xpoTOzh20IwLB91zKC6z6keXhj
         lInfIWHSG4P6XmefjSymnDCm69opFGdLO7l7qLJAj2SGz2Uwhz+uTYWesQpV1s07KtWE
         38HNloW7wsbuZw8kutEdoaa16DMq2bfTwK7nBKrHy2uUDpOfDLH0n0N4nyCVC3LHo7ZD
         bdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758062752; x=1758667552;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFpkXuJ44WWuUXPKFCvaa4NH4gkZQ5KGZfr9yDw0adg=;
        b=uSvzwVReichD9K2N4gUDrD1YhPaO4NxqPwS9H3DQi/FBMkMDN7efQMvnWfKSC+n+t/
         QHrOjuwUJc15nBqJo5B+6Dzgg6f+T4ckHY2OKZ2/qcIfQzr2FZsBbV5TnWESSKXrlzuI
         z/Aju7Iwt4ZXaVv1NV4IkiQlkIBuTZ/Tae41xdZma1IgKqRgtawhwGhdCfHEeJAte7EO
         Xp1KHw+j3ct3MAoz2bDVNSoTcDjehYs0iXFkYi/krqvKO1UBajITx7uPM9IgSP6jnZyp
         Ax3MmGIirEFILLerhCye5m49L8e6OT2njFa7EuL4ilbJA0ZpLG0wXLW8attISiOJmKAz
         Ax0A==
X-Forwarded-Encrypted: i=1; AJvYcCXz8VNW2M9tFXfs5ccGxzW1QZWLhvEr2t2xNoMYOEkgbVnxH6vfRIJw2LZ/JSDXSxN255A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJSAR+v4yGU2zWLfHBIrlIDXXnwAIuPumJP0qlevEUKQ8aB7J/
	22GhuoyZIgmDBFzTbE9IcFe3CQsLsTWx1LoCR5fi/AyS9liCMhXS3lzN+Dzbknm5
X-Gm-Gg: ASbGncsQO4l0DfFLiyWuytpAhjcGH+McZaRsVq1bcXuKMwYAJPVhypI6JLez1MGcOL2
	XHoJhF9OjuGAAIRa63yEE6IXVv6NDTAcD3h+PyShDbM+cudimtWfCnl2cfKrCKTPFTNHNZYUHf+
	KjyYfsGAUmN3OvKmfmfBkWhIDjaLAcsj9vT5jt8KK32B9AA/YC1PM4+T/xTSpN1Qkpb7mjgmOD2
	DajA9VcQaT8Q0scw9svrJZZlMa8S+Jz6COr/QmFQ1MeqH31yw90Q7vMkzJ4Hn/C8Oj/JoGNZ3kr
	X50RV1qb0NAgA3FbdqPqRl1XhrbDdo8S/0tUcY3v9R+kTwy3mFCOYt98ISfrww1y/fs7PXkn0We
	4gCW+yUQ8PMoEPCBNx8yM+dyFS7PnVZtkND0f5lfhMW38FaY9gk7f0ifz
X-Google-Smtp-Source: AGHT+IHBJVSTvQR+gblCcfnW/VZ1OIUs7DFC3wAOo44AFOmHWLUbc+BwuOqlIJmBa7r347vIi6Plqg==
X-Received: by 2002:a17:902:dac4:b0:265:9878:4852 with SMTP id d9443c01a7336-26598784d45mr122072675ad.15.1758062752439;
        Tue, 16 Sep 2025 15:45:52 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a1:9747:e67f:953a? ([2620:10d:c090:500::4:432])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25d49093074sm144754485ad.149.2025.09.16.15.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:45:52 -0700 (PDT)
Message-ID: <f746dce74aeb5de06fc25905523becccb88c55d9.camel@gmail.com>
Subject: Re: [PATCH bpf 1/3] bpf: Explicitly check accesses to bpf_sock_addr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>
Date: Tue, 16 Sep 2025 15:45:51 -0700
In-Reply-To: <f5310453da29debecc28fe487cd5638e0b9ae268.1758032885.git.paul.chaignon@gmail.com>
References: 
	<f5310453da29debecc28fe487cd5638e0b9ae268.1758032885.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 17:17 +0200, Paul Chaignon wrote:
> Syzkaller found a kernel warning on the following sock_addr program:
>=20
>     0: r0 =3D 0
>     1: r2 =3D *(u32 *)(r1 +60)
>     2: exit
>=20
> which triggers:
>=20
>     verifier bug: error during ctx access conversion (0)
>=20
> This is happening because offset 60 in bpf_sock_addr corresponds to an
> implicit padding of 4 bytes, right after msg_src_ip4. Access to this
> padding isn't rejected in sock_addr_is_valid_access and it thus later
> fails to convert the access.
>=20
> This patch fixes it by explicitly checking the various fields of
> bpf_sock_addr in sock_addr_is_valid_access.
>=20
> I checked the other ctx structures and is_valid_access functions and
> didn't find any other similar cases. Other cases of (properly handled)
> padding are covered in new tests in a subsequent patch.
>=20
> Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
> Reported-by: syzbot+136ca59d411f92e821b7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D136ca59d411f92e821b7
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Double checked other context types with holes and paddings:
- bpf_sk_lookup
- bpf_sock
- __sk_buff
- sk_reuseport_md

And agree with Paul's conclusion.
(Note, however, that bpf_sock and __sk_buff explicitly refer to
 padding offsets).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

