Return-Path: <bpf+bounces-27969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5848B4017
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 21:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25E41C22668
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E7A14A96;
	Fri, 26 Apr 2024 19:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEQeltDN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606803FD4
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159318; cv=none; b=OLfYfcddACwr6OCPljpnddQbLb0InD4z4AMRjd2gak4D8TBprntGsv1EzOlQwWszL+6oDLs7XEVTqd2/SHf8cSNODc3ENMK86IfJvMqM13zqQWX5hetbL+YcbJj5ERNrxsqNn9K5cG9Ef/gUXC90iHy/jIYnHhvfA432EyHvzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159318; c=relaxed/simple;
	bh=AWJ/bLOIfX9i4GIZYyjUwkgN3p1VjeBeftjGm2AOMP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r43vJpVQMz6w9C1Nd2XGAJGWnGAXyYEXxDnglq+oknRjR076Qx4DspZT7vkYAFGOMwUgM4/Y7Sigsp74i0PPyNaaeCEFu/lwVoS09rVKOZvIp0Yd/ge4XRYjNnVqeGBsoXjB2X4u4M07VrT9JxS7E2ghoJ/gHjTUP7GYT0RrsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEQeltDN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34b1e35155aso2605199f8f.3
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 12:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714159315; x=1714764115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvXnIn/XDuJAQsm3VwD/VgmBSl2ZQcQJR0lrhNHqgko=;
        b=EEQeltDNAz27pDAcaOY4CW4m6GtliLuCabPrItwIgXTW/AK6z0KrODQ29KxXfFu7jB
         BxruO3+D5oRh3UF4qngPxutaEzrfJQvD3yKg165e9A9ikqI0M/QI+9eL/LgLegKcQLxp
         tnJFfa+ma0Z1JTz/UBBG40MeJKN4lnqo4kzXCukGQ+rQbT3Qs5BM7RCCj7HV5GBUId9L
         5xfHDGKmtnPeMHUfdmiP3IUzaKeH2wemIsbUrXJuagGioEjNBJI9TJ/dgskP6ZgMzMtr
         C5MR6prBZACz85tovB9PNicUxP87LdhZdKv0E9hFtyiTMNFe1lQGMRGZ8+eZyMexIQli
         IyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714159315; x=1714764115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvXnIn/XDuJAQsm3VwD/VgmBSl2ZQcQJR0lrhNHqgko=;
        b=vMCtnR/4iKqG6/uMrs2vXffOfmL9UiL64cLxIfCxwLCAUiiqFR6G9VY/2yoszy+K23
         bmsNpJDNvBoAH2Y+cQ/D6ACvg9NNLCnOpjDzOei507FW8IaFezMXwIX8jqFg8IJc2hLZ
         ABy4mb0PxrcKj8tfQYW8GWhWGLFkd4m7zuYToIIh3NyRRzfgN8vPdDif/8F8D6s3AELV
         tXRXLmcbYnWJi3Hhljo+pDX3umsZ6OszB6FU4GVv6sIc2Wa3QFOQKroqtH1egWbcai5r
         SUCZofr0+i3NrSHaWUMXueGvHCOM/aEXZJQhyKE44/T5wlp8qRDsGcYt/fo1OikIQm/j
         Sugw==
X-Gm-Message-State: AOJu0YzlxPKu6xtFLM4o7lfDf5zK94RzptYsRYJqSw9oMGvldOXCYYq0
	XkzIOQ+KBqeyXSUKpztDr1LXGMkfJrUyFulkqOmip0Clt9pWSaekgaIgOsQ/m98isJbqHfMs4G7
	sYcBtYQF69L4r5U9RpiwxVsPh+Fc=
X-Google-Smtp-Source: AGHT+IH0MLG0SVP4mrXSBuAu8KABnzQTBrtqHEbXi4UMP6EvI2jnDFoYCj5B9kf3O7PRo8R7RKIqh13ChOAsi9o5Vk0=
X-Received: by 2002:a5d:6306:0:b0:34c:7410:d6c8 with SMTP id
 i6-20020a5d6306000000b0034c7410d6c8mr1837093wru.49.1714159315386; Fri, 26 Apr
 2024 12:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426171103.3496-1-dthaler1968@gmail.com>
In-Reply-To: <20240426171103.3496-1-dthaler1968@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 26 Apr 2024 12:21:43 -0700
Message-ID: <CAADnVQLmu-v30D=JP75Cd0qBhDXm8izAnUnyZZ4-QwyM67nNww@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: Clarify PC use in instruction-set.rst
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 10:11=E2=80=AFAM Dave Thaler <dthaler1968@googlemai=
l.com> wrote:
>
> This patch elaborates on the use of PC by expanding the PC acronym,
> explaining the units, and the relative position to which the offset
> applies.
>
> Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index b44bdacd0..5592620cf 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -469,6 +469,11 @@ JSLT      0xc    any      PC +=3D offset if dst < sr=
c          signed
>  JSLE      0xd    any      PC +=3D offset if dst <=3D src         signed
>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>
> +where 'PC' denotes the program counter, and the offset to increment by
> +is in units of 64-bit instructions relative to the instruction following
> +the jump instruction.  Thus 'PC +=3D 1' results in the next instruction
> +to execute being two 64-bit instructions later.

The last part is confusing.
"two 64-bit instructions later"
I'm struggling to understand that.
Maybe say that 'PC +=3D 1' skips execution of the next insn?

