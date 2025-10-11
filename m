Return-Path: <bpf+bounces-70783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04765BCF859
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 18:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6A0D4E43B8
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4060027E7F0;
	Sat, 11 Oct 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce6+TVFK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1132AD0D
	for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760200313; cv=none; b=n0geg0MqbjqJwdY38v02x27ZZzEztOg+s4PFpKU8SO2YCr61gTvlVHPh7XOUKe4QuXhaQE/tLphbOQVxrrriHnn3F1phpYMddLQ3N5Sq8D/IBBWj1R9XiAqt8hDrBoCgQGrxRPZiEMIYoZ0J7nBU/L3af3apJDkb8rOdLrdkc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760200313; c=relaxed/simple;
	bh=lrO38iizk7wcb60GtWW7Ez8BBgT1YYBpDU8DRQBxMlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ26ZAbvRdHSZAfCJCLYrFjhKB6lG7WBzHM7fv0VAY0GasGiTw7ggSLFcxBt5gD2dreoajhT4S4TftJ1/leWpYMewY3pXF6vagB6dIXk53ePci/Dxz7bAr62P9dgUNCB/WWIJIlaaMwfu0VSIAaFJan+LKutm8Pv/kzEU5TKiOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce6+TVFK; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42568669606so2160448f8f.2
        for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760200310; x=1760805110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrO38iizk7wcb60GtWW7Ez8BBgT1YYBpDU8DRQBxMlg=;
        b=ce6+TVFK8A1SQ2AFHCH3TzRKM08YXJLDNIirmQoL1DNG4cA/TkCaBjQAt+dcQ/wDwV
         n/BLAHCgtOGNEZigOBSJbHJlRnTKqfR0eEBh73tgslry5ZfiJgFk0HsCMzScJtmU0Nxe
         1mF4IWMAep5maZDxhNwI4nS5ZetmfLF0kcg1KBNkcjYilacG6bvlE6K/4YQsuxDzqmjJ
         HG8bLZuCTn9Na077/KcCHBU9iaADMDM5iIlwJLR75rqsj4aG5i6kSfk64wfvpHAFmKlP
         EvDl/Y7iMku4XTAJEHQry7i5yyuC2dtZLi3d8XYhJm+aGAu1+k0E2jGJj9Lm5hJ/aoxJ
         N0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760200310; x=1760805110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrO38iizk7wcb60GtWW7Ez8BBgT1YYBpDU8DRQBxMlg=;
        b=P9m3kxHeHndd054RHYh0bd8+6X0pvjeBg6Lg97tqcr/g8wWWf5ERm1cN/U3MwzaNO7
         7AsMKVMuVjzd3x5udc89BNEjJapkdmf3Yl080wVH8DuAPWcLSyPENmOMkeIPcOcwyr6E
         KgDPo19dbq1QAxnyuS6v73HALMlmPKTw6LR79/3SQrN4khIw6YW22AkiU4itue6pojjt
         4E0xhgDu1Dut9ASVuMb/1VguvKP61KMgGrNwDfAqHwqhfaZkOp8JuIFDIzHH/V2Fm42W
         GUIwaez7CBZCzwiFuZObIIdaQmxB5Cwy6Nc+RwzcPQwM3FmpQpeWRn1lp7c9XwuX7hru
         UMHg==
X-Forwarded-Encrypted: i=1; AJvYcCWPtm5rlKXtnxKy7e+B9uumjOrTvcX4bgeM4zwzRHRB/7GZcIjecnTkDJGPi8byTsXJ3/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YypuopGtOqVEkOQL5zVgdg5lxBVsNNjzxNIMUsTUPxQA64t7s73
	O/jTVdo5Vgltk/pHe9/mkhqUAo1sFz73uoFqwcFj/zqVWYGHjhV/ffxflg91aqe/uEHZUQWG47l
	ZTTzXAsj446wkYnM3rIEaksCPwouJElE=
X-Gm-Gg: ASbGncvKaFRxI1/DHmlLh+/W5cRpYEO+fphoOfipKPTIhpu3Cny7o7BTQjk+mIeCjQp
	hayb4JOfjfGKUiyXADEK4NWhkTrPZjRA2xMm5qtGOH0ujgpa8coL4JuZJhfkksZNgKzpvGmHy1p
	SHrmBI5d/KYWyY43p2yLiWBsFVyEpYP7+1bMiG3HiETNuDu68L0nxuhFZ2rrAoRdB271MjxIIDj
	CLBhookzWAlco7goGxASFdb8IYQJNClP+WOAcFkIEfHycO62J81mv6E4FU=
X-Google-Smtp-Source: AGHT+IFVktQDOHQUp45HLbylL/L1w5pNMbDmebDxa1LOU0GO1YCl7c+TW2wjKLQi1lKbRufqpRFVi7GVoYl4plbBD0U=
X-Received: by 2002:a05:6000:26c9:b0:425:74e1:25f7 with SMTP id
 ffacd0b85a97d-4266e8e6d0amr9983408f8f.62.1760200310238; Sat, 11 Oct 2025
 09:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929213520.1821223-1-bboscaccy@linux.microsoft.com>
 <CAHC9VhTQ_DR=ANzoDBjcCtrimV7XcCZVUsANPt=TjcvM4d-vjg@mail.gmail.com>
 <CACYkzJ4yG1d8ujZ8PVzsRr_PWpyr6goD9DezQTu8ydaf-skn6g@mail.gmail.com>
 <CAHC9VhR2Ab8Rw8RBm9je9-Ss++wufstxh4fB3zrZXnBoZpSi_Q@mail.gmail.com>
 <CACYkzJ7u_wRyknFjhkzRxgpt29znoTWzz+ZMwmYEE-msc2GSUw@mail.gmail.com>
 <CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAmuuLT_i--GskQ@mail.gmail.com>
 <CACYkzJ4mJ6eJBzTLgbPG9A6i_dN2e0B=1WNp6XkAr-WmaEyzkA@mail.gmail.com>
 <CAHC9VhRyG9ooMz6wVA17WKA9xkDy=UEPVkD4zOJf5mqrANMR9g@mail.gmail.com>
 <CAADnVQLfyh=qby02AFe+MfJYr2sPExEU0YGCLV9jJk=cLoZoaA@mail.gmail.com>
 <88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com>
 <CAADnVQKdsF5_9Vb_J+z27y5Of3P6J3gPNZ=hXKFi=APm6AHX3w@mail.gmail.com> <42bc677e031ed3df4f379cd3d6c9b3e1e8fadd87.camel@HansenPartnership.com>
In-Reply-To: <42bc677e031ed3df4f379cd3d6c9b3e1e8fadd87.camel@HansenPartnership.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 11 Oct 2025 09:31:39 -0700
X-Gm-Features: AS18NWAkyavqKGn5fC6sLEvcq-QIRJm3Tkt5oPLRbq6OvYCP9hqMJkQoQjx0Eo0
Message-ID: <CAADnVQ+M+_zLaqmd6As0z95A5BwGR8n8oFto-X-i4BgMvuhrXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] BPF signature hash chains
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, wufan@linux.microsoft.com, 
	Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 7:52=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> It doesn't need to, once we check both the loader and the map, the
> integrity is verified and the loader can be trusted to run and relocate
> the map into the bpf program

You should read KP's cover letter again and then research trusted
hash chains. Here is a quote from the first googled link:

"A trusted hash chain is a cryptographic process used to verify the
integrity and authenticity of data by creating a sequence of hash
values, where each hash is linked to the next".

In addition KP's algorithm was vetted by various security teams.
There is nothing novel here. It's a classic algorithm used
to verify integrity and that's what was implemented.

> > You need to realize that single loader plus single map is
> > an implementation choice of tools/lib/bpf/gen_loader.c.
> > It can do the same job with a single prog and no additional map.
>
> Yes, and if the light skeleton scheme embedded the relocation and the
> program itself into prog->insnsi then we wouldn't need the additional
> map verification before the load hook because the pkcs7 signature check
> would fully verify the integrity.

I'm fine if you want to hack gen_loader.c to produce the loader prog
without a map, but we're not going to pollute the kernel with
pointless apis, because you don't understand hash chains.

