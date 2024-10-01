Return-Path: <bpf+bounces-40712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DFF98C659
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 21:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B571F24A45
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D101CDA3E;
	Tue,  1 Oct 2024 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LUjGAJR/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B619D894
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812475; cv=none; b=ff+ZNPj1OLqAd9BUcEZ7ZDJ993iX4ScTbBfQ1gsuR4ix+Ok7T8LhF+O9KMltzzS4wLKFeAJBBR6DTJdUSKOVM1LzC3MYIphYZVEzJf0VvUiHagaeS6OG8hCGNwfhmh5HnzCGiC19KQYGzprJU9RjomK6WZUKCJgJQP7boiDIebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812475; c=relaxed/simple;
	bh=Hzd1CYs/FrsI3FgAZU4AamzqW+G5SazFReNfaDDYD+A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rvv4iTmrmBzPf2ag7ZvYY9k/+J/b3Yp1/HI2/aEQMc4KYC/TjqLrTOSgEnjt5WmscOG1TwWwAulIhrlkMY/4dBYO6SCScITBl4xwpdR2wwfOHQbvZXIpbfJcjF9DMr2tYxGjTsSCWdCl2xdA0fJHga3ncmb2FwLZVFoSguIpBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LUjGAJR/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b7a4336easo20208425ad.3
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 12:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727812473; x=1728417273; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TuGoJk9ECvqTkdhRfL58HMyKOI+yVlMGcPqLYre0Ahc=;
        b=LUjGAJR/a60HMHVtm5tQdtt7S5/HNaSrBFHYxOKCEggctre9n9gwtUFSUTGr78VP+Z
         meFuhHDrI8gNAO7sutiXTP78X30HkzBsQzxPCPoZZhnau14tcnPWpZyPLgOkCsoQhN9y
         93U+gSFPYPpFIStwgnQHY4bOWfH2ywmCDxSbNvsFvLtyI2PL5ZghihYVn5sCYVeWPHp/
         1rO4IqNlm5fsgKqP5J4hQfgGA5VwCTlUtMsgR4wymRqWb/8PVYIHqVfybfcRCq0XP857
         5XXywuw4tbDGOp/SaR6XQUdyKqE8R7NTX+2euOfCL1bYUAOINNRfROH0jGpACNEGrhec
         RheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727812473; x=1728417273;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TuGoJk9ECvqTkdhRfL58HMyKOI+yVlMGcPqLYre0Ahc=;
        b=KQjKKxrQLLTSv1vQpOJIeZfrDzJmWCULNe+vWdREh9inGfyZXCjctGXpz8fA+tpsAi
         tjHVKMdTQM6K4X40dRfHgs74Ta22FY2VrtBLs8nebiwYb1wYwKCxPM9Wwge9jxbzGqBp
         /Rmi8yqAr3N7dfl5w/Ia3iCjAL3m6wc/33w/Zy7LnicQtKDR34C8b+yOtTzMuEZJAomX
         VLXb3L61XD4qO1ITR0vmiVYe4yFBQQ6ntX65MENwreKvGiDCWLtkq5Ddrka+KftncZbZ
         w2EIHzQYOaq8ARIPnD6OvJiNK0+WNLSo4APIKAgec2LKXGu/pQGfISXYN5Y5XOuTHxtW
         gWfg==
X-Gm-Message-State: AOJu0Yw2ZcEW/LQyyCgS9tHeywsOx4+6fC0riU9Uwje0F6/xaNaosTSy
	bjJDnWFf4w0bJUx7Fja/CJzN8tcK0BFZC6n5oQ/BeXqlNvuQl5XT
X-Google-Smtp-Source: AGHT+IFVhbB/nL9ZYL1sIb+zR/pBa2OyC8tXDQL0EL3nGOyvlR4VqOEyMLN/BUeXrKLcnwyn+SiONw==
X-Received: by 2002:a17:903:1103:b0:20b:9078:707b with SMTP id d9443c01a7336-20bc5a10233mr8891435ad.30.1727812473077;
        Tue, 01 Oct 2024 12:54:33 -0700 (PDT)
Received: from ArmidaleLaptop ([2601:600:877f:ae0f:f8cf:32cf:647d:b56e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d89297sm73751755ad.71.2024.10.01.12.54.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2024 12:54:32 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: "Dave Thaler" <dthaler1968@gmail.com>
To: "'Yonghong Song'" <yonghong.song@linux.dev>,
	"'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
	<bpf@ietf.org>
Cc: "'bpf'" <bpf@vger.kernel.org>,
	"'Alexei Starovoitov'" <ast@kernel.org>,
	"'Andrii Nakryiko'" <andrii@kernel.org>,
	"'Daniel Borkmann'" <daniel@iogearbox.net>,
	"'Martin KaFai Lau'" <martin.lau@kernel.org>
References: <20240927033904.2702474-1-yonghong.song@linux.dev> <CAADnVQJZLRnT3J31CLB85by=SmC2UY1pmUZX0kkyePtVdTdy9A@mail.gmail.com> <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
In-Reply-To: <e93729b5-199f-4809-84f5-7efdf7c8aaf3@linux.dev>
Subject: RE: [PATCH bpf-next] docs/bpf: Document some special sdiv/smod operations
Date: Tue, 1 Oct 2024 12:54:27 -0700
Message-ID: <181301db143b$ba6fd9c0$2f4f8d40$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKzqMffW8FFfWCd3ulEKsb+gfc3egGOkjXjAfqQ6mmwpNlrgA==
Content-Language: en-us

Yonghong Song <yonghong.song@linux.dev> wrote:=20
> On 9/30/24 6:50 PM, Alexei Starovoitov wrote:
> > On Thu, Sep 26, 2024 at 8:39=E2=80=AFPM Yonghong Song =
<yonghong.song@linux.dev>
> wrote:
> >> Patch [1] fixed possible kernel crash due to specific sdiv/smod
> >> operations in bpf program. The following are related operations and
> >> the expected results of those operations:
> >>    - LLONG_MIN/-1 =3D LLONG_MIN
> >>    - INT_MIN/-1 =3D INT_MIN
> >>    - LLONG_MIN%-1 =3D 0
> >>    - INT_MIN%-1 =3D 0
> >>
> >> Those operations are replaced with codes which won't cause kernel
> >> crash. This patch documents what operations may cause exception and
> >> what replacement operations are.
> >>
> >>    [1]
> >> =
https://lore.kernel.org/all/20240913150326.1187788-1-yonghong.song@li
> >> nux.dev/
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   .../bpf/standardization/instruction-set.rst   | 25 =
+++++++++++++++----
> >>   1 file changed, 20 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/Documentation/bpf/standardization/instruction-set.rst
> >> b/Documentation/bpf/standardization/instruction-set.rst
> >> index ab820d565052..d150c1d7ad3b 100644
> >> --- a/Documentation/bpf/standardization/instruction-set.rst
> >> +++ b/Documentation/bpf/standardization/instruction-set.rst
> >> @@ -347,11 +347,26 @@ register.
> >>     =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D
> >> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >>   Underflow and overflow are allowed during arithmetic operations,
> >> meaning -the 64-bit or 32-bit value will wrap. If BPF program
> >> execution would -result in division by zero, the destination =
register is instead set
> to zero.
> >> -If execution would result in modulo by zero, for ``ALU64`` the =
value of
> >> -the destination register is unchanged whereas for ``ALU`` the =
upper
> >> -32 bits of the destination register are zeroed.
> >> +the 64-bit or 32-bit value will wrap. There are also a few
> >> +arithmetic operations which may cause exception for certain
> >> +architectures. Since crashing the kernel is not an option, those =
operations are
> replaced with alternative operations.
> >> +
> >> +.. table:: Arithmetic operations with possible exceptions
> >> +
> >> +  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> +  name   class       original                       replacement
> >> +  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >> +  DIV    ALU64/ALU   dst /=3D 0                       dst =3D 0
> >> +  SDIV   ALU64/ALU   dst s/=3D 0                      dst =3D 0
> >> +  MOD    ALU64       dst %=3D 0                       dst =3D dst =
(no replacement)
> >> +  MOD    ALU         dst %=3D 0                       dst =3D =
(u32)dst
> >> +  SMOD   ALU64       dst s%=3D 0                      dst =3D dst =
(no replacement)
> >> +  SMOD   ALU         dst s%=3D 0                      dst =3D =
(u32)dst

All of the above are already covered in existing Table 5 and in my =
opinion
don't need to be repeated.

That is, the "original" is not what Table 5 has, so just introduces =
confusion
in the document in my opinion.

> >> +  SDIV   ALU64       dst s/=3D -1 (dst =3D LLONG_MIN)   dst =3D =
LLONG_MIN
> >> +  SDIV   ALU         dst s/=3D -1 (dst =3D INT_MIN)     dst =3D =
(u32)INT_MIN
> >> +  SMOD   ALU64       dst s%=3D -1 (dst =3D LLONG_MIN)   dst =3D 0
> >> +  SMOD   ALU         dst s%=3D -1 (dst =3D INT_MIN)     dst =3D 0

The above four are the new ones and I'd prefer a solution that modifies
existing table 5.  E.g. table 5 has now for SMOD:

dst =3D (src !=3D 0) ? (dst s% src) : dst

and could have something like this:

dst =3D (src =3D=3D 0) ? dst : ((src =3D=3D -1 && dst =3D=3D INT_MIN) ? =
0 : (dst s% src))

> > This is a great addition to the doc, but this file is currently =
being
> > used as a base for IETF standard which is in its final "edit" stage
> > which may require few patches, so we cannot land any changes to
> > instruction-set.rst not related to standardization until RFC number =
is
> > issued and it becomes immutable. After that the same
> > instruction-set.rst file can be reused for future revisions on the
> > standard.
> > Hopefully the draft will clear the final hurdle in a couple weeks.
> > Until then:
> > pw-bot: cr
>=20
> Sure. No problem. Will resubmit once the RFC number is issued.

I'm adding bpf@ietf.org to the To line since all changes in the =
standardization
directory should include that mailing list.

The WG should discuss whether any changes should be done via a new RFC
that obsoletes the first one, or as RFCs that Update and just describe =
deltas
(additions, etc.).

There are precedents both ways and I don't have a strong preference, but =
I
have a weak preference for delta-based ones since they're shorter and =
are
less likely to re-open discussion on previously resolved issues, thus =
often
saving the WG time.

Also FYI to Linux kernel folks:
With WG and AD approval, it's also possible (but not ideal) to take =
changes
at AUTH48.  That'd be up to the chairs and AD to decide though, and =
normally
that's just for purely editorial clarifications, e.g., to confusion =
called out by the
RFC editor pass.

Dave


