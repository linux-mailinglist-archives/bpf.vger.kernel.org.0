Return-Path: <bpf+bounces-60243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301F5AD45A5
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 00:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C4B17D822
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 22:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF05285401;
	Tue, 10 Jun 2025 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCwltYqj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A4E242D7D
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593229; cv=none; b=TvnXk6i1JhU903+i6UdiZCyR4YubNK2vSX12gkWAQcdVoCdE95ixEydOgybpy6Td5VyjJDBOTbrJL3qwjZnYj9m+NioPInTl3KvAm7V08COozy26ybNEY2kIbjUp1avi0p1M+DglBbV55zWoFpqsKgpGgI+ast7RVozelD9zv1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593229; c=relaxed/simple;
	bh=PZvRaVCE7okIo2tgpW5k522S63hTARZDWLPBWXq472Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGTUZ7jtmLVbjK9QYQZVLF8lzLQE+XXJNgD1G4qsiLFhI68xsCYuB1AxzZ+TBsseimqkAqrSmbiQMKAnSmQy6Cjz+zoA1+jq24vb18FdC59Uswqbd5fEEdOyVFYQCEV+1W8F1CxTi8r4UP9KJxGtv3KiNNgb/pBf9b8TKhzSSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCwltYqj; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-401f6513cb2so176696b6e.0
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749593227; x=1750198027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PZvRaVCE7okIo2tgpW5k522S63hTARZDWLPBWXq472Y=;
        b=TCwltYqjlnXVpesK3UlirdWovVk7lm1eXlnZPT/rzXEtosX3XnV3qgNb58wOTErzDD
         fxZIEaQ9a565eqTW1hmFqN9UIYLs72TG/2F4zsAFRMvdtNrEbx4ga6lT5lkjICvsKCF5
         sKO0DiRNLuH22ey+weMj7bwT1FDruTwpLAKHKF+RB9DHz+VJDy/dimY5rCRSafDTZhIU
         ax/AY/Bh574aGwz2j6MTdk+0CAmNHa6GvfFfurqDM1XUWz6oJKvvGfCnMpaVvpO2dmXr
         WomGG+o0+DEcBXfuiKQBvSxoLYPmBEPMJqdZQ73yEy59kRhhpq1V3xF9qGt98jWDyYl2
         EtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593227; x=1750198027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZvRaVCE7okIo2tgpW5k522S63hTARZDWLPBWXq472Y=;
        b=Nu6nzJksPZuN5Pl8QpY6J1OaXpdj+uLVZwlHKN45/7RVN3rwbZHly2D2pR2OgWUwWr
         TAcMjqCGV+zL8qmOsDea40C10KEqJAGUujo4CSuzMa4MjkqY2GLn8wAkm/ym53IxQrFH
         PbphI+AHA2LVERBet368o6d7CXl5Tu3c7Kzo4WRdljyiET6Q263tjO3wX/7hBYB02TBE
         SLXtfLnS0GSypIfWS74gG69wnjGODDUwu2DvbA4qfdF/R0tDMkX8KwD/2TN4EPjeH371
         /YdhD+5sPKNJ0Qbc0731T2cR3IacHkRn2+h+apMfPDjTZLRvmd3c4DCr/tXJMqp3gzwh
         U4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUo0CCjchuzhG4c2INQ5OkkIJo58ZfLCQBxjxYe/BicTEgelyiZH2ppcn4qg6R9UQfDQC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIaGvJcmPVth5Vo3q4BIrDKi/H2gkcC1pSm8PG7l5NeAiPeqU4
	vL+orO3hYLSs1joa/uX2DPMfdaGhsQarlTuTV8LBYH+sV2GFvyEIAXjVszuIIHwpdOQwGACFFdS
	yDL/L2EP/DBTwjoZ97RrVfWrExDg3fx62PRde
X-Gm-Gg: ASbGncuKUBS3rMmK5PLwyTfBQwHvFik6CgowPLEYYnuCZFl7pJNxpNRBkuMQa7GexRH
	Dai+85RiXi2zJd++vb3i8DR8F1ng1YO0VeL+FQkIeDkFZk5OKF2pV9Ms1BkFkmmkbywOjaOHAUG
	+3kRUkY1wdqjukijTfNFxWR+rPzGmvsQQreCD/LKHy/ILSvGnozMMXvJUPRtw0P9pAnS+OddC2c
	F2w
X-Google-Smtp-Source: AGHT+IEfko8L3PvJSWqlRrAv5vgDddDXt2zKplWebsJkcnWReTSqKinwMysugOAlz/WcPU///JLjhthO2m+jvS3JEco=
X-Received: by 2002:a05:6122:1314:b0:524:2fe0:61bc with SMTP id
 71dfb90a1353d-53121e69f35mr1706848e0c.5.1749593216288; Tue, 10 Jun 2025
 15:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <20250420105524.2115690-4-rjsu26@gmail.com>
 <m27c2l1ihl.fsf@gmail.com> <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
 <CAE5sdEh3NuXUcjScj4Auvtc2701NAS6fu0hpzLGVnaoQ7ESnfg@mail.gmail.com>
 <CAADnVQKX2=jYfs5TBBKdKxHPi_ssUvrSuxbr22-dmYoP_e3=dA@mail.gmail.com>
 <CAM6KYssQwOnOqQT6TxHuu1_vDmmuw+OtFB=FwPLqbFcv+QdVrg@mail.gmail.com>
 <CAADnVQLFM9s_Ss7eqyx47tiY8i2b2dt=RMPHMC_s67Ang1rNBw@mail.gmail.com>
 <CAM6KYsuVe10f39kfaJaQEUGGA7xjmkALxjRSQxJRcGKAw4KtGQ@mail.gmail.com> <CAADnVQ+qS2V4j8ADCK+6GoUXcDnS+6+t3yLiTQY-GQ=Kmj0ymQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+qS2V4j8ADCK+6GoUXcDnS+6+t3yLiTQY-GQ=Kmj0ymQ@mail.gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Tue, 10 Jun 2025 15:06:44 -0700
X-Gm-Features: AX0GCFuUVLmLA3i8UW_hk9UEAW6ZmausDk4VJ-IxrDQ5J74TjQxSCVpcSCj10Ek
Message-ID: <CAE5sdEgmDBkQYnv2qReOW8fYBpK09VpZigLkAe_GObRXOpgZAw@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Raj Sahu <rjsu26@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"

<SNIP>

> > > text_poke_bp() takes care of that.
> > > That's what the "_bp" suffix signifies. It's modifying live text
> > > via 'bp' (breakpoint). It has a multistep process to make it safe.
> >

We are almost there with our next iteration, but we are stuck with a
WARNING that is getting triggered when calling
smp_text_poke_batch_patch which internally call


smp_call_function_many_cond during a watchdog callback trigger.
https://elixir.bootlin.com/linux/v6.15.1/source/kernel/smp.c#L815

Please let us know if you have any suggestions around this?

