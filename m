Return-Path: <bpf+bounces-61114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFB1AE0D32
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 20:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FED23B9E6A
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FF421FF5D;
	Thu, 19 Jun 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly4GS9Yt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0E30E833
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750359341; cv=none; b=QFJ3Rlau70aP4qHDJYPTtNvH6bQLHZQl0lAwvLzCrRU8AXUyi5kOOG9V4zgL0FrydVtC3rLio9VRuNYjB7w5I6bQmwbFDiknGFiYM5ScQiayqoCkeLVj+OhBWDsRTR/hf9MwqWbXSNddYwRCe3Hm/mCcztaJkFRtEbdG8VUPk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750359341; c=relaxed/simple;
	bh=Bb0FfdrcTeNx8rDJG9FdY2MgsIAvDson77v+PZDvNyA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HInRGGKOGid22Qc3TtBGVhqMCwaD6wiaClsw8c8g10t5VuAFHwumiXzkexvJdOtbwKgPEz1uu3M/9rx3q4p+HqoM5iwZP8CFNiu74b1O3uW+Q8y6aDxjZflfj6ZOjr9VnaB7h7X34yP3KeVCvPuQESyxp80HlDypTiazZr0blc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly4GS9Yt; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so972450a12.2
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750359339; x=1750964139; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IHA+DFXOpNj6jlk5Hup38sui3/Oii+KCOTEjKRY7y9I=;
        b=Ly4GS9Ytbxt1AZgcOrXja9OBF8vtHKeUD/wi3EEovn6jrRdnarp/Vx9CBN46XNbK72
         pzAkcl2xo5gUe9luP/BBuZEawI2N7ebuTG1To1Ld/mKZw/4bCi7u2Gr+vhX7+vGtVlEs
         RTYiXkCvi032Fr0YXZPJnFytRMwYAHOKFVOWnYftsgyoW+3tpZLkfF+8dXCu9IRlHmWt
         5b2nF+CEzKCX5Bw9o4HkT9Em8u6Yk0nFPxk7aHnuhw6LHHOhevsyNFN0LfORIs4C/XNn
         U1luklD6doyhshQMQR30rvD6XARTfkhHA5EkSu01JIJgdTZ156j9lR764jSqeptFuHV3
         DxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750359339; x=1750964139;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHA+DFXOpNj6jlk5Hup38sui3/Oii+KCOTEjKRY7y9I=;
        b=uE4wiuu1b59zrYMq9E4QzzLy0A7pdoZqHfBHLx0v5a5AsaRNv0r1QDmwbLzuVEu6yV
         crPG46ofFO4cXlqR7bG0xE1rRRvfpe8tHZ888l2zhvOE+IYHqdii7DZQs8E2JgDj2JAP
         36saipvhgbJpzlsRIYc6E4idWMr6IKsmsVAuaaS2l95fNOib+sHgQyy6xIfClFzmgcr/
         Vef3JKoQCG62WlQsoJYl/ezrLbLEZVDsaGUZnUM/VvppzC+3ILKbxpBHrzgWUidaU4bJ
         ABf4SzUhD9h+lY/YzMvL449dYsATZJt6O3+sbfaD2h/y/4faHaORAjGiPbPviM3cJX8f
         bBuQ==
X-Gm-Message-State: AOJu0YwO8q8dsXuSpZH6qQMZWFBb/t9ShATDzxlzyO9Vajhp4TCJfhSN
	EZYEM7/UKuobvMbwbss4lRh37OIlig8QtbjNbYGWFhgzhb/YN8wff7M8
X-Gm-Gg: ASbGncssWhn7c4ifjO3JE9XHbiMj7X8IrNc+sJgfjmXGYLOtznjYk/5tyetnvspTeb5
	n2oBqF6MON1t9GTkmBErEsjMHpWO0XeELKr9Niq9NIl45MQnr+HBP2IO2OHC6GJqK7pw6vtC2sq
	Sdcf7u+Q8CW/B9n6VrW4896L9Rygz8B2rs8+4Kn84I7OX3IH1YSyfKiHbpP9ZrKc2yREwsQ/rwL
	HZnIIdkaHTSCAVJB/OB/oGrX4AGPlgBtSlxvnCk7/WswUj5abZldgHUdkX1/d6CkwDysd/JhVKZ
	Kw98Y5eM1F9JnmydfjuUVqQvQdyCOkVqaU4vhmm5r+mSV0zFX8Syb+48tg==
X-Google-Smtp-Source: AGHT+IEpDC2tkUhD2CimMcxDWaJxVrw7LBoMUBThBknDxbU8Yj8Ifu9hv9PvtTO+0qKa1CcVjIqBKg==
X-Received: by 2002:a17:90b:3e81:b0:313:1ea2:a577 with SMTP id 98e67ed59e1d1-3159d8d16c2mr441205a91.29.1750359339520;
        Thu, 19 Jun 2025 11:55:39 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a23e19bsm2593943a91.12.2025.06.19.11.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 11:55:39 -0700 (PDT)
Message-ID: <8ff2059d38afbd49eccb4bb3fd5ba741fefc5b57.camel@gmail.com>
Subject: Re: [RFC bpf-next 2/9] bpf, x86: add new map type: instructions set
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Thu, 19 Jun 2025 11:55:36 -0700
In-Reply-To: <aFRdGxqIfB8SO4Xt@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
	 <20250615085943.3871208-3-a.s.protopopov@gmail.com>
	 <7edb47e73baa46705119a23c6bf4af26517a640f.camel@gmail.com>
	 <aFRdGxqIfB8SO4Xt@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-19 at 18:55 +0000, Anton Protopopov wrote:

[...]

> > I think such maps would be a bit more ergonomic it original
> > instruction index would be saved as well, e.g:
> >=20
> >   (original_offset, xlated_offset, jitted_offset)
> >=20
> > Otherwise user would have to recover original offset from some
> > external mapping. This information is stored in orig_xlated_off
> > anyway.
>=20
> I do agree that this might be convenient to have the original_offset.
> But the only use case I see here is "BPF debuggers". Such programs
> will be able to build this mapping themselves.
>=20
> I would add it as is, the only obstacle I see now is map key size.
> Now from BPF point of view and from userspace point of view it is 8.
> Userspace sees (u32 xlated, u32 jitted), and BPF sees *ip. I haven't
> looked at how much work it is to have different key sizes for
> userspace and BPF, and if this breaks things too much.

Uh-oh, I haven't thought about key size being different for kernel/user,
might be a conundrum indeed.

[...]


