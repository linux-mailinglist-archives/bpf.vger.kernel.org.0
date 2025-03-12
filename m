Return-Path: <bpf+bounces-53873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEBCA5D494
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 04:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387EE18963EE
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 03:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D59198E76;
	Wed, 12 Mar 2025 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="o3xvLH7Q"
X-Original-To: bpf@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1223DE;
	Wed, 12 Mar 2025 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741748634; cv=none; b=CUH6CG/KlnfpUQ42CI5E3OqDt7fMgknxDu+YJQ+3PFgTo1gBiPMISzsEWG8jPQpdcY8ca+65/HrqTSttmcWftqfA50EqBZfkg1zIiuQxdPcVtamlcruW4l5QDDCA+0jvoSWGNkH8Z1dtmOY5ZvHuMJ/UWUtQlJ6UAuRuaz7kxs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741748634; c=relaxed/simple;
	bh=hfB6LmlNXRiXOFa6y6EEyyq6AJIU3mlhZ8TjPoU66kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt5exvs2LJcqtrJFLJOW8weVvPnZaEPY4qYG+GA8ih5GXH3TzjTzpJGYFkHx8nRWf19BPzYEOX4M1DyjqVsR8DCQOyevXpV4Rhz8BF13UNMD7sLdVVn4gB5TSMEPPwGPdCzxRIS9SKjTnsRBFYnw9K4DlWd/V9hkI4NdU1HiP/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=o3xvLH7Q; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741748618;
	bh=fWfXLtt/2BULxNvCvOu79qbQYocRmAcLwiJSdNZqkqw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=o3xvLH7Q6zRyexRGL2FUOlU7prvmwkmBvP9EHWHAhLrHoNF6XjKaKyS0He/gRy5TJ
	 4v0XPOWh9zrwhyPZzj/8ZoUlbsmY5A1YHnru7q+GRAG0I8KbufFEhNw4akB6UxaZAZ
	 yx27Yo+LbVJuLrg7/l70jUqfEWqrR3yiKxT1VsPo=
X-QQ-mid: bizesmtpsz1t1741748612tpbdy52
X-QQ-Originating-IP: 7fgsV5KrbksIUApRUS3a/spzhlTIJo2BCkd+jKCx6ck=
Received: from mail-yw1-f178.google.com ( [209.85.128.178])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Mar 2025 11:03:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 798136978951380909
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6febbd3b75cso50774187b3.0;
        Tue, 11 Mar 2025 20:03:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJj1EDwYRTkbEyT8HXkWywx/cxvfA/2Kf0T9pJLT46x/EBzgnoYjhLAfZGI+bJmenuq+Q=@vger.kernel.org, AJvYcCWMbpn+DPg/LPcfDDTck0kO9W35kSnWscTo5TsaKTDWhr0X1ewZSGWYoEtb3NG8MlxHcuPJBg6H@vger.kernel.org, AJvYcCXjVTYFKi7k+4i3g+gjWOlXH35NRTv0fyOIfBMQaKF6TQELV1jHIrQ/8TqO7OOiEp+5+2xxI5lvpaK6isZ8@vger.kernel.org
X-Gm-Message-State: AOJu0YxZPVWK7w0qGIZ9ynh6d4gesqw2ai6VWhh4BpxTqorZAWDjt3sA
	PMiWOUzbwqPyjKR3Z+wymNQP3SVrXbNiXxN/un5gM0t3vQE2pc+ii2dpD6tNZdl3hAKG8mV7lIS
	MnwfCv6TahunbiFAgyy6YMLbxObQ=
X-Google-Smtp-Source: AGHT+IG8fzoRTgm+mPO00duGbFaQhdqA80HYU+jOry8PomyyzZFcQNqA3X4BezEcdEnxxa5v6r1H1PMn5ii4SzoB6uE=
X-Received: by 2002:a05:690c:6c02:b0:6fd:3727:6471 with SMTP id
 00721157ae682-6febf2a7db2mr295754987b3.6.1741748609898; Tue, 11 Mar 2025
 20:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05D0A9F7DE394601+20250311100555.310788-2-chenlinxuan@deepin.org> <2025031100-impromptu-pastrami-925c@gregkh>
In-Reply-To: <2025031100-impromptu-pastrami-925c@gregkh>
From: Chen Linxuan <chenlinxuan@deepin.org>
Date: Wed, 12 Mar 2025 11:03:18 +0800
X-Gmail-Original-Message-ID: <CDBA93EAD84C1583+CAC1kPDOXget0yMYPfQWbYPKrnSXL5RZ0f20Q8VmvT2zUTMBsNg@mail.gmail.com>
X-Gm-Features: AQ5f1JqQVMl5MMY5tXg5YSS_HFN32cnbvkGJw6pL-RFnEJ8qfHj38hUDE-ogGL4
Message-ID: <CAC1kPDOXget0yMYPfQWbYPKrnSXL5RZ0f20Q8VmvT2zUTMBsNg@mail.gmail.com>
Subject: Re: [PATCH stable 6.6] lib/buildid: Handle memfd_secret() files in build_id_parse()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chen Linxuan <chenlinxuan@deepin.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Sasha Levin <sashal@kernel.org>, Jann Horn <jannh@google.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, stable@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: NEuxXjgkfD8wXbdnVy+MiOVveXMA+NSoQYdPPfa/rLIyVO8CmZ0VGCzO
	9Yj6+R4lpgVqtPiMXoElcp0J5vXIZr8u24BkLx9Iv1xUGJYf9jTxjjD0aPkptsMuL8Q+2R2
	cpwGPGSGnK7cTEK5+2yYwsS/t4Ey44nN/qTWBYOj8S0dbpF2JZP2ATTYMs473u1D1u8vKXu
	6gDYuDjalHgBX7+z0n1hCEFoynOwgHp/QPWlw5CHXgJXv7LyrhH//zo3ozyzTFzsnDpoceJ
	Cl7bH+SRSbBUz6cTaG4XgansIHvHHxgsGdMJxEyIjNxSHhiX1z626nUYAcOnh/7jLAc6MAY
	HOzN65Aonsab8bf0Er01/EncUacv58NxsIAlLtm/KjlRf9nivM+fZY2/cmNi9gcFSRcCLGq
	RZfayYRHBDyvKZTzncgMY1YDCVanm0XcGarEEBq7SrMk3aVsr52Mgja7DeYR8GXUtrlAQ6y
	Z8+mK5socpWEBgMUPuKt2sZRdNaBT+VT5qeEe4wCmchnnfLLvYq81YQ24CH+8iFjSCWWdnX
	zHTTQ6Mor5xKWki41y37HyNKDzs0rcLlTJBAt+JV7772E5ZN2wizxPJCKOsYhJo03ge3QM8
	tfv2Vuzmvsnb6au5B/zDtEETFJdnDszTun0RdE5c0XHaMK9u87tkB+/1ShLmR3C6Rd7qhii
	QunpR0vhPvbfFoG2wnatR2t6S3z4tA3B0Lrk2JrjfUWGcbQcYiyo0oCZvWlMmXyCxOjD/CU
	Oi/RiL1ilwObKi7uwMrJdWEvnUbRVFOMhgVOcWF5AeueOycdQ6NLOWEBdxdJ1KNdsksex1/
	dLMtY34o+kdB+u5GxzA3KbtOxcCqwRubA3YaCiIgs8yceg5tKZ4Agru7db3fVHeF73+y35Z
	M6NelGP8uHMocyPae6IDJRTs+qOk81W94xGWhBl6mgSjZBmsLMiv0z20VqXR+yhMS2qeWz1
	Q6msU1O5ghyB2GCV7xfAdwxjMotO9RgvqpEHjQ7UgnYEtvexAYprCL+t4
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2025=E5=B9=B43=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=BA=8C 19:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Mar 11, 2025 at 06:05:55PM +0800, Chen Linxuan wrote:
> > Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
> > Handle memfd_secret() files in build_id_parse()") to address an issue
> > where accessing secret memfd contents through build_id_parse() would
> > trigger faults.
> >
> > Original report and repro can be found in [0].
> >
> >   [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/
> >
> > This repro will cause BUG: unable to handle kernel paging request in
> > build_id_parse in 5.15/6.1/6.6.
> >
> > Some other discussions can be found in [1].
> >
> >   [1] https://lore.kernel.org/bpf/20241104175256.2327164-1-jolsa@kernel=
.org/T/#u
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> > Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
>
> You dropped all the original signed-off-by and changelog text.  Just

The original commit is based on commit de3ec364c3c3 ("lib/buildid: add
single folio-based file reader abstraction"). `git cherry-pick` result lots=
 of
conflicts. So I rewrite same logic on old code.

> provide a backport with all of the original information, and then if you
> had to do something "different", put that in the signed-off-by area.
> THere are loads of examples on the list for how that was done.

Do you means that I should:

1. Run git cherry-pick 5ac9b4e935df on stable branches;
2. Resolve conflicts by drop all changes then apply changes
   as I send in this email;
3. Note why content of this patch is different from the original
   one after original signed-off-by area, but before the --- separator.

I am not familiar with contributing to stable kernel tree.
Sorry for bothering.

>
> thanks,
>
> greg k-h
>
>

