Return-Path: <bpf+bounces-65470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED03B23BC5
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 00:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18B67AF768
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC072D0630;
	Tue, 12 Aug 2025 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7umXRCJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B4253920;
	Tue, 12 Aug 2025 22:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037371; cv=none; b=tAK110HgDKzfd1sGlPUijwj7B3qfACj211ychLNefVR3yumqMYfk3smdoqzyfJPvSNlYsrZev7SY/yycELGN/q3XcXc20n4I6DdKqNfW5zUAKejAYfIdWmKPGGn+UajujuGnMrfdNSs0Ovy4rsgg80reZPavzL77obT/+bBZhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037371; c=relaxed/simple;
	bh=fsL9gm/UU5H6MiqTJ2u+JJmkXs8Bx+VLiIbUFMzdxd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbS/J+SrGPc/Gt+j1tvrpCE0CxK2rLNeJGhfQ8BtlzImylqtul2S4WuI+G0lot68BEpowuLlPAqb1RfCA/DV/nmnW2fSeVods05Sk5iiUdrYjDTEARz37QwpQkvFURITvi64q+Qm49HEHzwHW4Ut9akQQx/ca4EDjmGzsAKqrac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7umXRCJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so291782b3a.0;
        Tue, 12 Aug 2025 15:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755037369; x=1755642169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx01xdN820vT2a9N+Sn66p244VqZcFfFLxQv/h8Nbcw=;
        b=B7umXRCJUgYlCzyHaWcYKiC4ThfAw+dBKXgkUzyYZbCPwOpb34amoBQAaa1gW2Y0wd
         EaMCj7uzCw5Y3ejRXIW7jnWlrkUqhAEn4yx0mpfmuXZK3z3UQNoMAJpx1zEdErOlzrg6
         Ph0LJnctl/pS8Tw9CqBN5V3oVU3+M8Sz6LNFe6XwUZf9Bbw+VjZsEigxWkJLJBHKm5Id
         uSPzqe9LzhYKFTZGDYCLKf4YdPNRHVoch/svkN16K+SeGgJMDxNcM+X8xdmN7xN1JRCw
         6tUs+DSspMsieBoVAKIoy7fggFSKQFMFi0ZIDFQ+WV1qZ7jMfCDx07Mhvp9CMC8U7TkY
         V3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755037369; x=1755642169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wx01xdN820vT2a9N+Sn66p244VqZcFfFLxQv/h8Nbcw=;
        b=HXh+DlFBVuBplIg5/EZX5V+SfBJCb8Rp1jCi8DlrtGnG/Iek+O/E6fb9oVFSejk+x6
         Ymi6r4qaYEKY6Lhv0Snt+I/Oint2ThJCGlmx8Uaaf3n6A5mHJG1Fe+m1Lzyh6AI4ke4M
         RvqQXo5yPIDXWa5OVOTJkLHmFP09j7Rg5Rv9xbZOoznVlnSTTEJiq+mCeFc8mGQBlUhw
         1bJzyAUhI+vnw5FbbzIEKeO2oYHMZyAXucDhCcjfD5zJFie/ANLrKIptCev8JVWeyTw4
         K4YM3xAngWLc9fq5yNnqAFnIbWcDe6ZqYtCn+59Q6ezUAe/YpbkxX45h44KR4fFwJvt0
         vUqA==
X-Forwarded-Encrypted: i=1; AJvYcCVJOYcRaXvsYx9HFiLU8phofhAnNLH0SF+EqP0vJCv9XtYz4r8hGl+KqdNgZXfebMYduCIe1IHtJgo=@vger.kernel.org, AJvYcCW1dPUX/Ftt4V0PYDJfYdVO/NElXxyeTTxmdz0U4H8lNzTzk9mflIt1DiEKSeysWCz3PLA=@vger.kernel.org, AJvYcCWeNVZ393jNjGrDKfe5g8XiW03aovyZg5FqTsfg4o6779I3GcwESSYhWbQwYLpOp5Fsw/1WP0i2UTBGsdTh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/JJyRrXvrA3Gga7BRaCG52cx31/PmskJ0pPdVeIKBL63ufY6Z
	CjnlTRfmg+tLiFMYJHXkb/8wpx/yW4QH4cfA5ddwuVEWoWer2bqwP3ksR/jcskQ0HVgGTwLxj95
	clGb50LBfT8uRY5dgEoBJ8+3Tgqcm/fc=
X-Gm-Gg: ASbGncvm0XsXRDormPy/v2a0dJV8zrEGoLEhln/326XjTN6CeYNQBFO5AHzWp1EKI17
	Rj/iDjrZvSccF6hk2yCPRbUm5JII9JoDTJieNiuAxZHI1PDgog3fTq6hpWuOuoJWBG8m/XcefBZ
	xwG04wQYT4sFHPOVRN+eY0Fj5HMX1FRlbRjblQ6arL8D2ncCEp4gXn/uje3ysHA2QGIGcFvugso
	tedWbP/duq1abeQSoOMlW2ExKlsRi/53g==
X-Google-Smtp-Source: AGHT+IGrYamR6p5V39B746QqNByUyKz6Pdz4QXmCxydKMUWNie09u6mfNVYITzqhkvvgG4w6a4Pj677mvaplsO/9PfQ=
X-Received: by 2002:a17:902:ec82:b0:23f:fa47:f933 with SMTP id
 d9443c01a7336-2430e96adcemr3421365ad.8.1755037369244; Tue, 12 Aug 2025
 15:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606214840.3165754-1-andrii@kernel.org> <CANiq72kDA3MPpjMzX+LutOoLgKqm9uz8xAT_-iBzhR3pFC+L_Q@mail.gmail.com>
 <CAEf4BzZDkkjRxp4rL7mMvjEOiwb_jhQLP2Y2YgyUO=O-FksDiQ@mail.gmail.com>
 <CAEf4BzbJpTZ9P-Deo7Oeikyd3vW953goAw3gYvTPzvDfEWj2hw@mail.gmail.com> <20250812221424.GA488781@ax162>
In-Reply-To: <20250812221424.GA488781@ax162>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Aug 2025 15:22:35 -0700
X-Gm-Features: Ac12FXx-YcUDQQIf5l4-2kjTCO_ycxphViRaLrLxA5TYLEbY2hoft5DCz4MQRMw
Message-ID: <CAEf4Bzb4gDq1Erj6m1tjZCUqasCEb+BH_M-73u0L6uVdohL7yw@mail.gmail.com>
Subject: Re: [PATCH v2] .gitignore: ignore compile_commands.json globally
To: Nathan Chancellor <nathan@kernel.org>
Cc: masahiroy@kernel.org, Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, ojeda@kernel.org, bpf@vger.kernel.org, 
	kernel-team@meta.com, linux-pm@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 3:14=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Andrii,
>
> On Tue, Aug 12, 2025 at 02:55:22PM -0700, Andrii Nakryiko wrote:
> > Seems like this has fallen through the cracks... I guess we can take
> > it through the bpf-next tree, if there is no better home for this?
>
> Masahiro recently turned over maintenance of the Kbuild build tree as of
> commit 8d6841d5cb20 ("MAINTAINERS: hand over Kbuild maintenance"). I am
> happy to pick this up in the new Kbuild tree but I have no objections to
> you taking it via BPF with
>
>   Acked-by: Nathan Chancellor <nathan@kernel.org>
>
> if you would like to. I suspect it matters most to the BPF folks anyways.

I think the Kbuild tree makes most sense, as there is nothing BPF
specific here. I'm just carrying my custom compile_commands.json for
libbpf project and being careful about not accidentally committing it
(so far I managed), so I only want this to *eventually* make its way
into the kernel repo. Not urgent, though.

Please take it through the Kbuild tree then, thanks!

>
> Cheers,
> Nathan

