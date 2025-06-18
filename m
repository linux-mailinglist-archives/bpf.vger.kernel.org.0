Return-Path: <bpf+bounces-60982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ADDADF562
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 20:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080123B9219
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E303085D5;
	Wed, 18 Jun 2025 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9uPZe2o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C603085C3;
	Wed, 18 Jun 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269482; cv=none; b=M76WpV65Zad7RrdfoPrRu0sVLo3EQn7KQjD65uR4YvRnyE+A03oP+BRpTCW1y9U6yolRbgi7SddOwF6Ty/hke+Ybj4V07c3dvWX2k0ZetKMV79ydYqOtIuHr0Q+3F77KS15lFWur9pYIdZwACxqwMvHEHW+NJuksDO13gVhFRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269482; c=relaxed/simple;
	bh=c/aCGg+9OCOFKYjo2js6T/dQdwcubZ23aRH2OSyNacU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=t+TjSlKDEpmsdtkaunYznXtqUrVDjpF8X/W53fTd+aLxgsrFf2h2uQ2dVUOSvvg7cxU77cfRf0pEhgrda4DtEPevXhQyALVAWpdOj2pn/WyUqyc4kiALuEKbJJhOeXG3Pax+OEFpO8vjrS/9GCYuA7mJKPVZRVY88qglwl9so+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9uPZe2o; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso6348009276.0;
        Wed, 18 Jun 2025 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750269480; x=1750874280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/aCGg+9OCOFKYjo2js6T/dQdwcubZ23aRH2OSyNacU=;
        b=b9uPZe2oXPRCYiRkuuU+oW94LVPQDehsQlQkOryK8BXYJLxsLUK3kgzJAJgSi01btA
         SVf2IDUpO/dQotdN/MXjxL6j2Lb6xpgPRJ1rCTB+rgVrIOSVd2piBUF1NE5Ovnz/Bchl
         EkPP8Rlvabg9h8TjJVSB4Bx/G8KfELMBOWrXjTpqHolTAlLRl1nMTWbU5AOCzRLFO+f8
         c4rTuVDcv7/rypqINZd8LaodmeaURnE87Rq4QiVf8brzBnijl/aL5xwdkL10o9QTOwtd
         DSr2fawNk6/1U1i6HR5S23nhW6zGqPLZCHQlGhqv28H0J154SW2LvGSCElD1djRLqbvW
         HrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750269480; x=1750874280;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c/aCGg+9OCOFKYjo2js6T/dQdwcubZ23aRH2OSyNacU=;
        b=lwHLXZMiXNXXh83gqREERhCl975mWMfoVXgdvg9iXJWUE+QLozCe35R8up20pWkykN
         xU82NADF/bhB4mNtZxvjrTE3xXYsnC4PAbAuGIT6GJrDkQVFZ+ScsZy2M2DdSeZXW4vp
         kXS+WyKZJu2u+G/XwdE4R5S5WmM0YP5feZVPLP8HgLV97G2fgIm1mI4p5ap11+ce1a8H
         DBEKq99mMGCRnfLs2+4Sfa/Y6ZNZYzOjnxSjP3yn084mf/TEaE26zZEdeiQwbT/Qc4ts
         e1eo5aYOiw5AAy/q2D8GYSWwJESWSuZKkNmSyOFkbrIgliRtTfhlgfKM0Bm19O0W73od
         NzOw==
X-Forwarded-Encrypted: i=1; AJvYcCUIWsrg8p5nzPk/cmELPfcA0BUeStKk6U9+b0VSrSE8JDCB1XUKZeBFI6XlXm+vihpmo2OgaRu/@vger.kernel.org, AJvYcCUvXk8F4X+eX017LGobJ1n7VFDlRDqSzX5rIVXOxNCj6gfovz8cKVI6FQ5Ttf8Wmay3R84=@vger.kernel.org
X-Gm-Message-State: AOJu0YyspgLN+sLy+In4W7KXX9MCpE5rKSrJDagaZxvAvzjkrFwp9Xl/
	2s94kqCznPq49WH28AOeLS78cCuW6qPPnDtZy57rJVrS/FNxMdRh2TUD
X-Gm-Gg: ASbGncvPQlzspCDboLi+6fASiXLcLQq7pvkcsikcpps6DaVPSGwkdwH4oRu/RUnPPY0
	raGZw/KzLewdPymDOvKgQJ1nEW0ywU8PuiAFa1CBW+2DKNodJwSUQ8gDDS2icdIMox7tlJ5oecF
	TnSR5q8hWLEYXdSLGyLBQfyd7GliAcRKc+1lRUg1RTlplSQwc/AyXfhHxtonl8/GI8RDcnfccID
	X7/IZOw70Yjw+AV7yBX3Aq9u6erFl770IbFY9DHpa1StEij+sM9mWorb61/yuWNuzQda9AbQKzT
	ql2QYAMefjCqIJZxJkTQrbCP/OcLUu01zN37hH4br7MaZzl35+IjaKzwz/44EOmqT1Rjj6LJH8g
	ycCAtZDz/9DT6q5sefuN20OIPVOxfvmw0nxrmbvUv3/tmlrzZ9fSE
X-Google-Smtp-Source: AGHT+IFFIYaOS8oRUaXCkW93JXYND3ykDp74PO4gJkgnYBK2Ta9Bbp8dbP4eQldnRfxcmZUHfKR9EQ==
X-Received: by 2002:a05:6902:1a44:b0:e82:1f55:eed0 with SMTP id 3f1490d57ef6-e822acab5a4mr24125746276.4.1750269479805;
        Wed, 18 Jun 2025 10:57:59 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e820e315dc9sm4381848276.39.2025.06.18.10.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 10:57:58 -0700 (PDT)
Date: Wed, 18 Jun 2025 13:57:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 bjorn@kernel.org, 
 magnus.karlsson@intel.com, 
 maciej.fijalkowski@intel.com, 
 jonathan.lemon@gmail.com, 
 sdf@fomichev.me, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <6852fe267553f_3471a129472@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDYiwH8nz5u=sUiYucJL+VkGx4M50q9Lc2jsPPupZ2bFg@mail.gmail.com>
References: <20250617002236.30557-1-kerneljasonxing@gmail.com>
 <aFDAwydw5HrCXAjd@mini-arch>
 <CAL+tcoDYiwH8nz5u=sUiYucJL+VkGx4M50q9Lc2jsPPupZ2bFg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: xsk: add two sysctl knobs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> Hi Stanislav,
> =

> On Tue, Jun 17, 2025 at 9:11=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> >
> > On 06/17, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Introduce a control method in the xsk path to let users have the ch=
ance
> > > to tune it manually.
> >
> > Can you expand more on why the defaults don't work for you?
> =

> We use a user-level tcp stack with xsk to transmit packets that have
> higher priorities than other normal kernel tcp flows. It turns out
> that enlarging the number can minimize times of triggering sendto
> sysctl, which contributes to faster transmission. it's very easy to
> hit the upper bound (namely, 32) if you log the return value of
> sendto. I mentioned a bit about this in the second patch, saying that
> we can have a similar knob already appearing in the qdisc layer.
> Furthermore, exposing important parameters can help applications
> complete their AI/auto-tuning to judge which one is the best fit in
> their production workload. That is also one of the promising
> tendencies :)

It would be informative to include this in the commit.

Or more broadly: suggestions for when and how to pick good settings
for these new tunables.

