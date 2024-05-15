Return-Path: <bpf+bounces-29741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E38C60C4
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 08:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF58B21873
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 06:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA13BBEF;
	Wed, 15 May 2024 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdcrR6x9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766F1E869;
	Wed, 15 May 2024 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754394; cv=none; b=BsL72DDtN1BGZmnB3dGaklJpnvCYJ2IZjFQuhFzY8km0ZKViU0SSt72NlKHYXrP7CR4M9G4XiEV1Uc5NjBrlNbV48Kac+sgnjOWpfRXFLZSqUonnFFiHEp2AfCg2TjnaJOKo4Rhor6ENaEZ7eqnNkL3P2lGxI6tENOzl5/LXotg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754394; c=relaxed/simple;
	bh=wEmn7uinhHT5RrRKL1/oFUCkOWbFeSQCbSn3qfR9dns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXXwuBJgbdujSCOBRz4nv5lowe2DZ5c7xIRlURj7gMg6iv7HktA366ER2VXiXxNpiUru4/+oBB5Fk14kxoJQNQT1vh5ESNhppIEdlMOObTWIMgnatL96Y4wCp8uyLiv8a8oo1+hOzbNSa+yvcF2Sz4I7uYoRABm2IpxCsOs934Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdcrR6x9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dca1efad59so4858469a12.2;
        Tue, 14 May 2024 23:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715754392; x=1716359192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNSS98dUDgaOW4gwnCppO+ukaIIrb3BrPgBTEKeKqig=;
        b=GdcrR6x9xSz8T2/Opqlm2yTxt6khZ2ndshOHMQWbAJE6b4iGFJ6krmCN/fRykOeDme
         XX8n93Mf2d+2wqi316cScc8T7D7gX6hOQDppNRLq7Ka6xiI3r70TV8L1J4wHiD+9aPAc
         ry0A8ZmW9ulzaDchTfGcFWIoGfERKtKSOcGOVUVqeNcvMR/4Wl5OrPPoPQw+bkiK/XWB
         pIN0l+qbr123/xaTK+61o1fvx0vQB+GR7lL0Rg3sBwqJDBttP1opfrqPCp9mnILv4jAR
         T5ygsWAelHa6CIzUC8VgvasIIKVzR4lx5TJ7IBnTXNIcBeXCWvPOMtzZX8qT13AIJu9C
         g2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715754392; x=1716359192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNSS98dUDgaOW4gwnCppO+ukaIIrb3BrPgBTEKeKqig=;
        b=EAWOc+YNIWey21qvOG2uCSRxpLb+W1XcB3r80w+vpgpLtEdt6/ZXxLWa8bdo8LvEm3
         5uRIGLrBcF0NC1RwsxdsbM2w9h0Md3VGPsYxoRwWNvHcsZKLQqkwyp3L4lNAuKPl6h6p
         zpCwFZr6C6u4Bs6SnqGTpHWwnQnLcJ0WwaF9syROzWcfRm/BeP4WTaBtv6p8EDYP66Wz
         QRGfIIFaT3ruTomcH7Y4q8rMakMFWdyZHKtXAam0oD4m3P2Vf+Tz/NJ+yqt+0jfGhPfl
         QGOa90/ORabt/XalAIB99YKrBQJacBuy5GYVpyCusJM1wRv6SDMzDdtUjUyIFYv+EAPu
         wWow==
X-Forwarded-Encrypted: i=1; AJvYcCW6O5gDrSRuCdx1LYU7SOMzpvIu1K7+lMXQMaqJwdXSB67BVaG2l2H+q56q2oOUrSD8w0dnDg4S4jVoWhU3S44Rts6kPn57n9Z/djFSHN27WfQxRzwlz8QfXx0ORgKnEUTuv9RjWWvUk4ZEHATrzc7bnTYoARM/fkXR
X-Gm-Message-State: AOJu0YyFd24wmQR+RWEG1w2F7VS909h/xOin3kQcBztp3wUyz9gHiag7
	vqKUeVyIPU6Om1Gt1v9tmbmDtDKhwjvjF7Bz/CK1fghE9G2/ggNckeUUSB83LBnBJBhOyG4ynEd
	aUDbhn42MjjEZJefqDJpzURdlzXv/tw==
X-Google-Smtp-Source: AGHT+IGS5QQgMT/E9JYxOpB3OzRVvnPrjXGJ9zhz/XOe6dI0duHI2p45UY6BO9cyTr9ZWdHU0vv3hgdcIxELbYosh+g=
X-Received: by 2002:a05:6a20:6f89:b0:1af:cdc5:dfbd with SMTP id
 adf61e73a8af0-1afde0d230cmr13773821637.14.1715754392207; Tue, 14 May 2024
 23:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514231155.1004295-1-kuba@kernel.org> <CAHk-=wiSiGppp-J25Ww-gN6qgpc7gZRb_cP+dn3Q8_zdntzgYQ@mail.gmail.com>
 <CAHk-=wj2ZJ_YE2CWJ6TXNQoOm+Q6H5LpQNLWmfft+SO21PW5Bg@mail.gmail.com>
In-Reply-To: <CAHk-=wj2ZJ_YE2CWJ6TXNQoOm+Q6H5LpQNLWmfft+SO21PW5Bg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 15 May 2024 00:26:20 -0600
Message-ID: <CAEf4BzbysejYpfcdRrpYc0yHTgZ2YcnGdyWQ-13qmJeDzVNS_g@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:06=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 14 May 2024 at 20:32, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Why does it do that disgusting
> >
> >         struct bpf_array *array =3D container_of(map, struct bpf_array,=
 map);
> >         ...
> >                 *insn++ =3D BPF_ALU32_IMM(BPF_AND, BPF_REG_0, array->in=
dex_mask);
> >
> > thing? As far as I can tell, a bpf map can be embedded in many
> > different structures, not just that 'bpf_array' thing.
>
> Bah. It still needs to do that array->elem_size, so it's not just the
> spectre-v1 code that needs that 'bpf_array' thing.
>
> And the non-percpu case seems to do all the same contortions, so I
> don't know why the new percpu array would show issues.

There is a special check for non-percpu arrays (ops =3D=3D &array_map_ops
check), which was missed and not updated for percpu arrays,
unfortunately. I've added more map-in-map combinations to our tests so
this can be caught sooner. Good thing Jakub tested in our production
setup so we could catch this sooner!

>
> Oh well. I guess the bpf people will figure it out once they come back
> from "partying at LSFMM" as you put it.

Not much partying today, but the day was still quite hectic, sorry for
delays. Just sent out the fix (rebased on top of the latest
net-next/main).

>
>            Linus
>

