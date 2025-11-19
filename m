Return-Path: <bpf+bounces-75015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D58DC6C1B2
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 01:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 54D4F2B278
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 00:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121535CDF1;
	Wed, 19 Nov 2025 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzVUyY5W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F211F42AA9
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763511223; cv=none; b=RH5avvTH2jygI8/71ZLXT+5KziQS90bkpMWHHVQ7RXhtoZTrim8/oWpLznMP35vjBSBb26xkpul7u+8CckDmOQr3vBdujGVqif2BsYIk1DGA1EvjgWX4uc/2/1rjG3JBSLk1WoF1ldCBNBPU7oYnW3ol//2jojGZqzQenK+nzVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763511223; c=relaxed/simple;
	bh=yQgK45XY84r0D/c5Y3azFOwqSFZ/UYOcB9Pt/YKe4zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APEfv4+jRsyc5LdEkWUWnzFCF/TdmQ3qs5EHOvFz7LqtVjAp0+XHcHKedbs71N8do7XcysI2tyCiDxrCSqGQwejH6JOkQvMCDEjmUY/WHxsLsrHyrwuaNxOMBq6bMFsmZ/MgwCT3AIG2fH4zfI7kP8h9PfAzQZJkY/1K8AIlQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzVUyY5W; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so40696785e9.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 16:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763511220; x=1764116020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQgK45XY84r0D/c5Y3azFOwqSFZ/UYOcB9Pt/YKe4zM=;
        b=DzVUyY5WjlNCWozxeQeYQBErZtk2x0irFcyOPKrOxcHmarT2yYSQuJRGBaakOktpTZ
         fRw2ZZKRyJLWYbUKALFY//iNo998lllXMOC3FO8oy0EVXJMnFDfFj7UP2mLJBySIAOJx
         v884mAJAY1eaMq3Ichvpc/gTuTG+Wy+aec8VvfB+HZ5cdsF/BE9MagW7bqlv4Gnc9yPe
         6CgLVLjIleey53aaZ+nLcEg5zZfeCn4TwSHveWyKnlo0puKI8u8u1btguc6gyO61TrFj
         NPT14DEcpizRZsBU434sC9LEN2dhrcNbMOpdLB2/o/bJEqysG8TvIndBEoyNvtQSdWaM
         SSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763511220; x=1764116020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yQgK45XY84r0D/c5Y3azFOwqSFZ/UYOcB9Pt/YKe4zM=;
        b=u313wU3sOVSwCmCqZIezQ0MIjMfXQmMPlqWPpSYMrD7oW0b8ouZh1dARJW9iZ7ofhF
         w7dgXHmA3j8/dYTOlm1X0x5AeXZ1jjJswckX74XXGfUVyiZ04TbCQrFlP9mA/td4jxCo
         OWAbPzIEbP4luhHnP/CmB1wcCmOrzJRdRzPoywO6csRKEPUw+dAHYJRplj3ieMMhfqFQ
         rwJnJfimGW2guVozKgT5ReSneM0aZ3LZ2wKb473glECD8Q9zHNjwOqEr0tUvLjBYJkFb
         sOnIBJ0e32gYtvMHuLGfaLbYfgtCikmsK/ZHce3vxEff4QL+5QorpP1EjsryL2522hol
         IA6w==
X-Forwarded-Encrypted: i=1; AJvYcCWttyJ782JWCYQJmES9PkhvXlzGLimMVjhq1DaH9ovXepyLFT65AEtS5MBj0BHb6xRdO8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1/eyzYiNawk3ui0MdGtiqvndtQHdxw5gvtyLEIVQVXA/pJb2v
	tISgH2PK7ko1s7exTdNGCBe/1sqz2mmQDaqcguvItinQsEY7dM+p63ic8gN2cPDO5q3cR53sOTg
	Z12TScPDAVz4YGdo5gNTbZ/QIIFs9rNQ=
X-Gm-Gg: ASbGncvtxOK+pdQw13lo1U7aiKSUH6FyKVUUKC69ZmARcl7z5yV/ydPz+P03IWa/L+m
	J3gd4yCRkM6cVfSp20clYK555akzXZmDexxvXYyaxt227/Sn3f8UGtDcnpMOJOe3KKmRlZDi0Ry
	SzdrvlvRyfqQudlSyQaAR/eVVzaCKeMyq2K1pz6fHoB4c2zhDYPggF0gc3jltVhC69TGQlAyZ05
	wXjpBd2Y8AP0BJjI7JKRreiflmdjwEiV+XVzSYb8ZcCkRr8gyKHLqULS+pFcgz14Jnc2VG9hMeF
	WCJPE6wIxzITTLJi44b3QUxGERzbHHzg
X-Google-Smtp-Source: AGHT+IGeoGTz5tb5KgNns21zCnPIGBlziKKpYxE4klXMYfw1z8n269wP2ZQT6gdSNz90Ekt5YUfW6GyONZBskkZV1uM=
X-Received: by 2002:a05:6000:1848:b0:42b:5603:3d03 with SMTP id
 ffacd0b85a97d-42b5934dea3mr19240763f8f.25.1763511220014; Tue, 18 Nov 2025
 16:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
 <20251118133944.979865-5-martin.teichmann@xfel.eu> <21961a5ba6f9e3c08a1b0386ca98ffca07e18068.camel@gmail.com>
In-Reply-To: <21961a5ba6f9e3c08a1b0386ca98ffca07e18068.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Nov 2025 16:13:29 -0800
X-Gm-Features: AWmQ_bmKbUifEX0Ra7eu6IyCc1qLMFLF0szt2Fl0P1zU5ZDR_Cpy92W6H51_BP4
Message-ID: <CAADnVQJ=_4bOUC4C-QRANWQ4FWk2ViXUnaDX56Sftr0tuXNTKA@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 4/4] bpf: test the correct stack liveness of
 tail calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin Teichmann <martin.teichmann@xfel.eu>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 2:55=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-11-18 at 14:39 +0100, Martin Teichmann wrote:
> > A new test is added: caller_stack_write_tail_call tests that the live
> > stack is correctly tracked for a tail call.
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Same here, please add signed-off-by.

Martin,

small process comment.
If you want to give authorship to Eduard, please
use his name in 'From:', then add his SOB,
and add your SOB afterwards.
If it's too complicated, just use your From, your SOB
and Co-developed-by: Eduard

Sounds like Eduard doesn't pay attention to patch count :)
Which is a good thing. Really.

