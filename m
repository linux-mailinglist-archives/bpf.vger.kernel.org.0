Return-Path: <bpf+bounces-61113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA25AE0D2C
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 20:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F664A3085
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 18:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DB61D5AB7;
	Thu, 19 Jun 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5ZOw0Fw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39317A30F
	for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750359091; cv=none; b=g4pQbgPbzHhDpWmEmqQEHbwptfaqGNjdLHpa6Tkf50DHDnzxo5Sk+x6/AX8wp9Qteej64fwa8Y2G4q2SEpxeY944gkZh/BocoY+KF9Ncj9tTjFs8lDDyraIqn+xM/AJJ+fQh+P3cp9Z6YJtA84cZNQE5YpVY3PZj81kiqf1jOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750359091; c=relaxed/simple;
	bh=mRqoRZdprKGI7wvotVYa1gQZ14LdlGaKtSL/Gjm5GQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE4YLXbl4HO56lF/e5dE6xM8ok7Bpb/9F3wCBaNhiTzLCQHJ8C9bX4xesNIAd0JAAFi9AVKW79zgqjcdh3gBVi0XAMAaTBYZIITphKFlM57tGziuzXHTE6CfhObQcdnZwWR4t4ofJf7cHSOsG0evDueZEujLAgw/sVpK8NbeQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5ZOw0Fw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450cfb79177so6017385e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Jun 2025 11:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750359088; x=1750963888; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YzVU0lnZZtokrDiI23uhLda0FtCELA40B+eIoLcWl20=;
        b=K5ZOw0FwCBC/Fa+8tjxxrw1Fq6vtDlM7vP9nXUX5luQdVavOLA2NxShe2e/BYLsUlB
         sCuCf+h7UPXeGa4ZErLUVBnwVjXQVXug7LLDHPO9Y3kcqbT7ZQ0kw5qmOW/qTvGFIol6
         4kyOC2XOIAPg2uGGMYE716I7SIgu3L6isDDOIl7o+qlmxYg6t208qXt7UX7XFzq/MFmK
         Z4fjAjWKi76jDl24hUkZv5vxqCVlqqfDTl0Dw97gNTCtIIAQkXOucGwjcNfb31+nlkNL
         P0YrQkrUnF2JpOheXjKpEyXQa2AEFinxEIc9KA6wY9oSc8RrlIZCkV6ZScSZ9QOJYFpt
         CakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750359088; x=1750963888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzVU0lnZZtokrDiI23uhLda0FtCELA40B+eIoLcWl20=;
        b=Cz4oWM/Y/m8dr6PcmtR3APBwnGF4K4e8bGHokXn8xft5e6L5Qg+T9j4AxSnAUOAb0o
         Ed74h7A9JlOdQ4Ek1xK8HMRoyoifc7YdpKkO4L3BcRt9tT5XZjm11swLFZ9lRCNEwF3y
         lbWUQ5B6L6+QLyY7oXGtFkCcHeKzvMOvCDLldjA37wibgKhk7lirQPMiUY/VqHKndOYN
         FlIZPnFXX5xBkSw8mdcW41I8mvn9b00fVlIYYeHRC+0pmIY9jrIF8E+iR2EZ/3T4P6VL
         AJUcLseEkL6JYPWLmWJ6kisDyluELviX+xThbWr2B4Eo9aMLD/lZcy8GM4ZrVFU0EAk2
         nezQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJWi7FCpUZsCiQBqa64eR9lSnpywo09qWf+ghdKGV5Yxx7m/zWzgZlTXjxfU/SsV2mA2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/R65QSb76xZXX2/cz9+soUrhRc5/VF42vaDr6Y8UyLGuYOkM
	OEwTO2tJ89AebWeO+DCqSIEu7NNGGMandS1qMNAZ94k7eoTqLrygvq1/8vjQPw==
X-Gm-Gg: ASbGncsS3F20nnSZ/JJ6rhCAmF3JXRkPtO5+O1XqS6wr4c0gb5Tj4TooPQziUlRFaWq
	SCbXk4fvtAgc3YJdCA1tmr2RckFaoZoHi3FJw8OjT2LHpYJdnKsnQZ5IJP1r5tXFWUFx6khNiYv
	W85xxjAqazNNbvXcCWP6EXuusd5RV5JMNsj8fMAABspEhH2t/61GofoOOyTvL7az/dM7qAFONC1
	CS6LtNqIWl8usHK9lZqhwPjPWPXsAY506qaMiWg1wduyFFLinxDUrDiKchVQjLdB39O8HIT92xA
	cP8w+lONoAQkgNT/KubnhLRO+Q7lQUfDdMi5dgpjva2kSkY9rOqnpD4NktZDKw2MdL8Pzq7dgw=
	=
X-Google-Smtp-Source: AGHT+IHFiyfxCpd2R+7qw9+NmhiAkpDgOakA8cpa8rjGxgbe9QRfJYWoCiOGSlXg/ftJauf7XE5wVg==
X-Received: by 2002:a05:600c:82c3:b0:450:cd50:3c66 with SMTP id 5b1f17b1804b1-4533caf10cbmr204925865e9.29.1750359087665;
        Thu, 19 Jun 2025 11:51:27 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646dc761sm2565105e9.17.2025.06.19.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 11:51:27 -0700 (PDT)
Date: Thu, 19 Jun 2025 18:57:08 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 2/9] bpf, x86: add new map type: instructions set
Message-ID: <aFRdhHHCos1iFWg7@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-3-a.s.protopopov@gmail.com>
 <7edb47e73baa46705119a23c6bf4af26517a640f.camel@gmail.com>
 <CAADnVQJyBBoYZE8M=GrghdPm3-ZjTEoiFDP5_Y00bPvKy_XEoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJyBBoYZE8M=GrghdPm3-ZjTEoiFDP5_Y00bPvKy_XEoQ@mail.gmail.com>

On 25/06/17 07:16PM, Alexei Starovoitov wrote:
> On Tue, Jun 17, 2025 at 5:57 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Sun, 2025-06-15 at 08:59 +0000, Anton Protopopov wrote:
> >
> > Meta: "instruction set" is a super confusing name, at-least for me the
> >       first thought is about actual set of instructions supported by
> >       some h/w. instruction_info? instruction_offset? just
> >       "iset"/"ioffset"?
> 
> BPF_MAP_TYPE_INSN_ARRAY ?
> 
> and in the code use either insn_array or iarray

Yes, thanks, "array" sounds better. Will reply here later if I have
any different ideas...

