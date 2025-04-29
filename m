Return-Path: <bpf+bounces-56962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A891FAA10A4
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D0B1BA11EF
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E80226CF8;
	Tue, 29 Apr 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaU/RjCz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE0A226D02;
	Tue, 29 Apr 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941154; cv=none; b=DKGa8KTKCipOf3Yxg/bBLysmW/keor7dLkyfj6FEQMMEGbODTPMQd3vL2vJ3PVQC/iFRv68fYwIQUQ+v4fepTGziBNHbJgVjBvkPRwsXCOGE5ZbMcXEderVDfGbLK6WTt7oMDY8XQzZqjFkXkMRxYVlCo+W12sQV5x+OfKY4O0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941154; c=relaxed/simple;
	bh=QhFPVaf4amAKFUGFo+zlluLEqsyqJjY7i+9JLGQ9+YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwyR4mjXKfwKhKFMQZjQBFYt2eDMsqpNJVnWC8VcWWJ714g7pbqJFnHbWqMffQnb5RVnFwkqxcG+UOSdxd0F//WoqowP5RhhAl37m1Ds9sshzdjP49K3UM2uQNS3cRzonh0HUnSKKsVZATuJtRNptab2SzyhaYWpL6eL1sS4kfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaU/RjCz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7398d65476eso4929119b3a.1;
        Tue, 29 Apr 2025 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745941152; x=1746545952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhFPVaf4amAKFUGFo+zlluLEqsyqJjY7i+9JLGQ9+YY=;
        b=KaU/RjCzUV/cO8tWYDQ2O0rCozWI0KWY8e5cytaIcEjC3ImdZ17vuwAL3cOpPVvSl4
         DjROl2AkvibiWKXMRdArrPO1+DuA5GXofxFlGa3sRkvvJAD+T8JkkjmlKmOw6KNDq0ES
         NOaJrqOChUCXUlKFPSKe3/JYqGybrtgZL+mfJEHxrrbtI6DTB/rfaFh18Sa/AIzOYnFA
         cPRuEohP0D7biIQYi2ADbkgPbbIjh0/CvkTYFAGZPiFxTBe7VVUXx28U/m1QY6BI7NLr
         FI1Tc7ya28APh12bWmSHx64nn+anyr9Pa18oSBf1c1OnTzbdwpI8XuR2uVfaXPhTU0Jl
         Zvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941152; x=1746545952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhFPVaf4amAKFUGFo+zlluLEqsyqJjY7i+9JLGQ9+YY=;
        b=ldxWh193S8PyBTMBro50kr/k8bC3SILkbgYei5+twN7vvfUK09jgHgutjjmTfKz/tA
         35YcU/hTj1GX7nbFMjqf3e5IE7hLvoKkAFkl9kzLaZSampzZmfKgt1IhevgJyQ4vnLbo
         fHgXm9XOrckveNLzKXQNEC86wGi6nkLaEdTAkkn5Gsc59oYND0YYrI+kXhTHjqgh7x1V
         zSPoGzGLFcx6cwp/HV1IEb6AFf960yh63MoXXvGFVcCGiyTis8JaIA+tXS8JgO9ULYWX
         9cX6tzsLzINLqIaLjIpwrT9OSt7NMyEo5g0B7LDDHBw0fYDJZW25Sjh8rQs9U6/ekOpt
         e7hg==
X-Forwarded-Encrypted: i=1; AJvYcCVeH1m5knaO4yKv3gekMTqP7UTLXjKf4DINEEmYQIM3CJwgxouVp/xbFwy3DiRmdYY+vwA=@vger.kernel.org, AJvYcCXVToEUCn6WsE4yE6iHd1RP0FRHWjGegYT+hx8IMOf7j/srRzlWd3SQEVhqKiwCNL632MKnEa8FC1n+xNfV@vger.kernel.org
X-Gm-Message-State: AOJu0YzAHbZ2fb7rlwhLcZhp/WTx3BMWX3QqNVHObDASCuwe3KSaSEVT
	0a1sR9TSt/7tc0f8KRvTd5z+6H5Enh+A9o5d892cPoyv1z0ewD7OpS1je5CH7Lq/LYtumsrc1AC
	+joEQ36n/F+ngQDEHtmLtfpylp9A=
X-Gm-Gg: ASbGncs+ZAP5G4MwYQXiyKGNo8FOY8KMqDdhQr+6c3bGxEDtJH9Vt5NECU8zto3xkW7
	6sX8GWvpCeW5NAeqDHQeZeH7EXauFPBOl7m6Y/Hw/9cBEcoMipQyUt5JW0hdtYeSNGEFpiPw7Bi
	IQVYLlCs53hkupZVHSV+sZDAE5b+x+VI6aPP0FAQ==
X-Google-Smtp-Source: AGHT+IFyqBmaS2dGSanUgSTQWaeJyclP2LYpd2raqBEFUZwtbBCXKxuWIZr/jVuBUx3pCBPzl+w/Cgeno47Z7y91Td0=
X-Received: by 2002:a05:6a00:1310:b0:736:5969:2b6f with SMTP id
 d2e1a72fcca58-74028a3d42bmr4656093b3a.6.1745941151880; Tue, 29 Apr 2025
 08:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423163901.2983689-1-chen.dylane@linux.dev>
 <0a25f585-de46-4e3e-8ec2-47df25947df1@linux.dev> <CALOAHbBUaSw=LYYYPwqM+HQz_8t5_g43Y7ARdvMZ-7rBTvS+Aw@mail.gmail.com>
In-Reply-To: <CALOAHbBUaSw=LYYYPwqM+HQz_8t5_g43Y7ARdvMZ-7rBTvS+Aw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Apr 2025 08:38:58 -0700
X-Gm-Features: ATxdqUHRmH32NAWB2RwKq8pPP4h6dJ1sU7iW-pVcfqUpbO9Zgm6wdjCsH95Q1-g
Message-ID: <CAEf4BzaJ1dbnkabR19qK_bpRp=v369vEYeB63FbVUiv_2P5SKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: remove sample_period init in perf_buffer
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:19=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Tue, Apr 29, 2025 at 1:48=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> =
wrote:
> >
> > =E5=9C=A8 2025/4/24 00:39, Tao Chen =E5=86=99=E9=81=93:
> >
> > ping...
>
> The patch has already been accepted and merged into bpf-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?=
id=3D64821d25f05ac468d435e61669ae745ce5a633ea
>
> Interestingly, patchwork-bot+netdevbpf@kernel.org didn't send a
> notification about this.

Yeah, we had a day or two of patchwork not working. The patch was
applied. Sorry, I forgot to reply manually to let everyone know.

>
> You can check the current status of your patches on Patchwork:
> https://patchwork.kernel.org/project/netdevbpf/list/?delegate=3D121173&st=
ate=3D*
>
>
> --
> Regards
> Yafang

