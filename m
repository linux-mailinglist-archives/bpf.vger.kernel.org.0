Return-Path: <bpf+bounces-56977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE3BAA1C3D
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 22:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EC94A83CD
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 20:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29693267B78;
	Tue, 29 Apr 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgHM5bga"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55167267AFD;
	Tue, 29 Apr 2025 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958878; cv=none; b=s9BrSWP6GNx5ssuSL1CxfQBREIUITf4+Wd3Rmo0xOj52apV4l7PUXWBf9a1IymMz5qgHuBFvkPq4BWkRBHdFvwKP2wl5zEHKZtG2b3+OuSI6TXUbBAYCZFNP3khB5uIdqpPi26n+fa5alVZGYWuEeNolVRYjN8BTHGqRPcK9pf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958878; c=relaxed/simple;
	bh=eHj08UqL0uKoOOo+tyLPAriftqDq6XfJqUwsGrIdseU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FcmJQ6goCsGK57rdHsWeDvKs7dNi1qu4yP9MMoZfaTqrAWYB+EUeySzXMtcq0bhcG5yBd1xdEl/dKtYINJe02PCCFXXTjOi1vCqMuReMZBjjerfAeQ+z+okYVgIBZdtAxzpsFXDvUqn/TVn6bhGB+04EuV8YrqgJwlJCDbt7jzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgHM5bga; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b0b2d1f2845so4575786a12.3;
        Tue, 29 Apr 2025 13:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745958876; x=1746563676; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9V7yz4R1QEktpbgmRjim8ThciCwyUj2d9/ayixwAePM=;
        b=jgHM5bgabjGwBA1mLQcn7WYVLhPQskUPvyhT3Am7BLP7T0mWsXzS2RLZQmfrwpGliM
         PY7MPTo7uuxUjbS1WfDmK6A8OC6bDI3mSQjieYJ4wm9XLdN4LShU+T1uF3o+Qzfee2LV
         8+nj5QR5IoQQapnA2YJ/uIB1soB9JY1pK8lVn4CzM1wN1epm/7wMUeng67GZKoY9FJOX
         OLJVyZEHYOY45lmqs5wu3tHhJaA6gGo8Y5NLfYAIIIhUtXTt2geFIAIT/Abjgp8lDP8s
         JNDlEJmFqQJ481+xTRPr5Iw6XwrxKBhPCt3uEj9zhQzIMVwnl6aPhPmb1N1KtiVR+zNJ
         pt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745958876; x=1746563676;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V7yz4R1QEktpbgmRjim8ThciCwyUj2d9/ayixwAePM=;
        b=hwmP6r5YGiIpjS9E/KwN/CvqXSdCq4xQrGCKkaYXQap5YRjYWoxc4a0fKttLSDVhKA
         9sdDOAm1c+JF+vakzLPRL+x3vV1SLTNIHjNx1FT/idW0PyEgb+zQ0/eE+L0s0Gw59/l1
         scD0ub8ltbud2vdR/Hymv9IAYhPBhY/Tru4anep4z+sk+cSUSA7h1GhKSf2Psd6APzsL
         HQKBbTTN0E8PZldH2ENnIcVoDhRN+yCdA47aOTSJoEkzy3ozOTxrC7nZJ2mWk6a2g3UT
         NNjTqRl30pUFgimcThXmeKzI5bDP1EmJGmKzvQSrEhFS9whK0N5G/s3M7FQKHpM/b/kG
         yNlg==
X-Forwarded-Encrypted: i=1; AJvYcCUW9snH3emxWsIoXd0eC13yqlru2GEVeKNSU62li86/NAM9OQLbOKIe3seo0tvHfkzdM+LPGRMrQg==@vger.kernel.org, AJvYcCXVaY0a8U+JHZiEkk9cAd8y1IwQKtwdA/hJ7qiuHQ+u9Zz2IdmS0fQ738EDO8MDC+FEpV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwblbIK2WHPOneNJnc+SJQRwCwJFu12OjlsNTpkjoIHN1isPxu/
	ImifKztEW7SI7oNr7vk6SoqlVZ2lnxI0ndEserwlAQF3q446C1SuFWBH3KPy
X-Gm-Gg: ASbGncudH3giVM2Jtr+vPnLcQRejZzJu8gE937Khy/pS3VCycBwhWcuemagqtsxsvRr
	pic+r3U1Oa7582iUBb5jQdQipbzq3TTsh4oWLnPrg7YzurhuuBfV50BU51o2/DofMyxW05Ehr9u
	mLrxfAISI5wq9WMGJl6R/vk/y37R8uf8HP403fLvMSKQyU6tSeKoit1xr9v5ilgHOB1HcyrE/Zs
	Grj269HA/8mACOkipPwnRc1Ghj9BZJLgHCJ8vf4XJzC8F81grG3OtQAWAPDzpdh01i9RpNKmBEV
	w5DggC7Bg7bRpM+xgb0UIXmAkzDn1dkZ41jYb8BUnxxg
X-Google-Smtp-Source: AGHT+IEIBaG6Ht7ca5bCAmHOuQZEG+QYuVrRaoxUlCfyQifKHsZg3xgxBI9lgck78gTcfe6VucZfPg==
X-Received: by 2002:a17:90b:2b4e:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-30a33367f08mr620834a91.29.1745958876415;
        Tue, 29 Apr 2025 13:34:36 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:8cbd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef09985asm12929219a91.28.2025.04.29.13.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:34:35 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,  Arnaldo Carvalho de Melo
 <acme@kernel.org>,  Alexei Starovoitov <alexei.starovoitov@gmail.com>,
  Andrii Nakryiko <andrii@kernel.org>,  Ihor Solodrai
 <ihor.solodrai@linux.dev>,  bpf <bpf@vger.kernel.org>,
  dwarves@vger.kernel.org,  Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: pahole and gcc-14 issues
In-Reply-To: <CAEf4Bzb_-Wk8eWZyPc7_r2Oq_o_Tgg+2CE+nTom2wOhjcpDw4A@mail.gmail.com>
	(Andrii Nakryiko's message of "Tue, 29 Apr 2025 12:50:14 -0700")
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
	<076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com>
	<CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
	<4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com>
	<CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
	<c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com>
	<e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
	<CAADnVQKi4DARfzQJguZyDQsfXHq7A=QM2FwRwpZe-LJzj+Ujrg@mail.gmail.com>
	<CAEf4BzYt2sUxRPAR5AbAAXVcOeC2UqgkR24WDEZAAd+kEz=g-w@mail.gmail.com>
	<CAEf4Bzays+8g7kj4fNS0rBLPTQWzYb_maFkyHyij4ky1xm_GAg@mail.gmail.com>
	<CAEf4BzZgQMV+Gtiob_K-uuizyuqajyLjnGbKOJLyiGB=DxmY2Q@mail.gmail.com>
	<m2ldrihikq.fsf@gmail.com>
	<CAEf4Bzb_-Wk8eWZyPc7_r2Oq_o_Tgg+2CE+nTom2wOhjcpDw4A@mail.gmail.com>
Date: Tue, 29 Apr 2025 13:34:34 -0700
Message-ID: <m24iy6hfl1.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

[...]

>> Is that different from what happens already?
>
> yes, it's different, we don't follow pointers. that identical_structs
> recurse only for embedded/nested structs, not structs-by-pointer.
> idential_arrays also doesn't follow any references
>
> so it could lead to loop only if BTF is broken and we have one struct
> embedding another, while that other embeds its parent, which isn't
> legal in BTF and C (so whatever)

Missed that, thank you for explaining.

[...]

> And yes, "visited" marks are the solution, but I was thinking that if
> we implement a pre-processing deduplication step as we discussed
> offline, we won't need to do any of this, so didn't want to pursue
> this further.

From logical pov the pre-processing step would do the same thing, right?
Follow pointer/array/qualifier chains and merge structs that can be
trivially merged.

[...]

>   [0] https://gist.github.com/anakryiko/fd1c84dcad91141d27d8bd33453521d1

Thanks, I actually cleaned up and applied what you posted in email :)

