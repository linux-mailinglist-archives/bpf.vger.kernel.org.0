Return-Path: <bpf+bounces-75769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F40C94925
	for <lists+bpf@lfdr.de>; Sun, 30 Nov 2025 00:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32A03A673E
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 23:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3104326A1BB;
	Sat, 29 Nov 2025 23:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="V/aKHTiE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72943A937
	for <bpf@vger.kernel.org>; Sat, 29 Nov 2025 23:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764459896; cv=none; b=RJ0XIDc2zu3A61KFC2wAjdDDlsaPMQYDC9wLhO9zRSwpu+PFS/bx9DUj66wOuZrnfAYlY3TQKTToS9/5hGMd0hWVA0j78ApWN3k3zkK9Y6Mcz/5hy1i1twf5jqUZ31K2To59zflk/W5R1xTPSIPDWmMYhgWcN/ieC4SxeuUsHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764459896; c=relaxed/simple;
	bh=TcFe4KjHhjJAZNK86sm2Nn6dfia+T2WxXomYLGjz9cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+Zs4379T+TWYc4fRJ8wJE1QMc7n1Kx0z1MPSampeZsC2gX1eAY9AmH9c/cdCrQ+I3q22E38evjJAjEyFT/CQiQVHKxf1fHj2bUS4GmVwLuvhY/avpk4IrGNHqvaocF/mDBokVK0UZaNSVXzYoGcns8SmCvTKgsxXa56j48vBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=V/aKHTiE; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-343ea89896eso3013072a91.2
        for <bpf@vger.kernel.org>; Sat, 29 Nov 2025 15:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1764459892; x=1765064692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TcFe4KjHhjJAZNK86sm2Nn6dfia+T2WxXomYLGjz9cI=;
        b=V/aKHTiEctvyUJa66f0RhjJztFrDVFUbTZs/He+m1wofGtz8Kcw0AkPDhIzL0zT7zH
         CCn9fRiYJAkWC52ptIDrMt+vOUfaA+skg2qcFAVVWzIunK+sSmwMhzPX6jY2a4tm05aY
         BaMhJdx/QnOf9zthb61jefMaDBEaNuLPhbTK41ZMxTxxXxBLe0U5tXLERWE2GJ94bmJb
         0PHl0/3+w4WwF4P9UcC6g6a2nS1jYtIhramuFG0iJOUV1tuVvhaZVyyEWRXPz5/Y/Iu8
         SFfQzru088K8e9N/zGhnUJU3HO2KgNbEXb1ss1CBdZRmCVV4QnPEmzuOf/5cpWMAI5E9
         xvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764459892; x=1765064692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcFe4KjHhjJAZNK86sm2Nn6dfia+T2WxXomYLGjz9cI=;
        b=QOsttpyhqtnX2Vvuwbf6TOfnU2Q+B5B8QkBdG+azn55UQs4/fT686MCg8V+04+08Hn
         0GVucdKuThNS1DIy7Sl6ld9WHrM+zJWbr9O3Zv4HJ6Ym559tH3nsT6YncB8+HmLpgZcN
         a23nI6rzvWjhUO1lBBxc2FyfUkVc0+jYcroFAzzmEAptbon4PfdtsosbH6dSS8FN879p
         LYvutBgSZWvTFh/VFMa7PnGRO/bdnRKEmMXik0bapjUG7JJy99yx+Sgxo3lTasB+EOvN
         YKHgI/FOTmgbMX7u2zaXfNguf17Am0kzxrA/iRN8EEgChsrtGXepAqW+cHXoPHbMj5uI
         EfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCURQyr3Oxv9ZDhElB4wl2srrXggM4XfdLu2I/ampD12rQyAdNqS7RlaNToxqKo+4/tlRrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PptwiopUcY/9EGR2RkJZoC1JYh3zyizC07FG5MGYvJCjgsyi
	9I2F7NBXCCyXyjFbgUAxWdNXRBl6ukm3Dkr48yjBiT/L/GLIAltGXzu8+byZ4OQ8KmgsIyTOH5B
	A0wrfP8TjcEVDTuFYA5CDNnXeDOrOj2bFJHCHFNGHzQ==
X-Gm-Gg: ASbGncscMbSwsKVgxv7wrqWg1LAyLxAm29c0MCOVLHDoPoWlnXC08zF0WzBePUAiFEA
	L+Ry50QwniwPWc1JwsPpRhBrq2YVeD3SWZTLTfEiQcp+ZedMOpWhR1XI4tOiFn5Wi+FY7hcQI1T
	GuKRdtWvJDURw09GJac4wpCCX/FJ0XAIZc0OzHAy1eSEkcf4uNoNhnqh0Kwekp3GLb27E4z2OsJ
	VVsOkN81yVQtZOmfPlEH/98LMLc9sJ3sYko1FFb6G0fz3UmbFXGGxeckk6juoEuIgZn1cD5ZJGJ
	07xRpxU=
X-Google-Smtp-Source: AGHT+IGVRBacDJINPBJrquNFp9SnM9ZNVtktF9w5ckFkswpbAOCcpYyPNzjvs0i5ky/ATW23ULUs1Nz2XiXjTjuvEv0=
X-Received: by 2002:a17:90a:d40e:b0:341:abdc:8ea2 with SMTP id
 98e67ed59e1d1-34733f3f838mr34693429a91.37.1764459892389; Sat, 29 Nov 2025
 15:44:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBTjG+N=+GGwcpOUbeDN563oz4iVcU3rbse68egp9wj9_A@mail.gmail.com>
 <CAADnVQLXJyMhfqr=ZEUWsov3TC155OkGvuaOHL5j+aK5Pv=F7A@mail.gmail.com>
 <CAH6OuBTXwW9WKHRNS53kRgZ3Y5GdH3n0EY4YogOGGSTGnYL9og@mail.gmail.com>
 <CAADnVQ+DycJQ7eW_FDE59Qc1SzJseYy2f8yniqh0C354ruLdCw@mail.gmail.com>
 <CAH6OuBRtCyRhvn4E3yQSqpynoqRiB+sYbiZP1ATqXE4LQDTQmA@mail.gmail.com>
 <CAP01T776rsC_aNF4AijRGDqZRfmeKDbSfFmGYPTYh+zaOuwrWw@mail.gmail.com>
 <CAH6OuBQ3UY7AHHp1ZMacMO6zq4YFsi=ycqE_FPSZGBm0FRnuVg@mail.gmail.com>
 <CAADnVQ+F8v3f+aOJG6AsV9EO+Mp=-uY4OzigNR6jh=SoT+KTFA@mail.gmail.com>
 <CAP01T77z4h2QhQxgDxLPxzGZVase3xPSqSHq0v_3VWK5sjvqqw@mail.gmail.com>
 <CAH6OuBQXcKsVDnFAY_8sKF6snsMurV_KkmmyeKb0dxFOjhfF=w@mail.gmail.com> <CAP01T74Bh2HKPY5i226oHEASWz=qaHiNPPcCXQuHgTE8yHv1oA@mail.gmail.com>
In-Reply-To: <CAP01T74Bh2HKPY5i226oHEASWz=qaHiNPPcCXQuHgTE8yHv1oA@mail.gmail.com>
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Sun, 30 Nov 2025 00:44:41 +0100
X-Gm-Features: AWmQ_blX5JxtWGPgYZI2Cf0sKqks1zlvUQjR9m0nQ6iqByyHDqxu_XfIAyC2wFs
Message-ID: <CAH6OuBSEBwNcFxZm+iCvs5=Ssj03ZBtid74wCDK7JQYrDiXK+Q@mail.gmail.com>
Subject: Re: bpf: system freezes due to recursive lock in bpf_ringbuf_reserve()
 caused by commit a650d38 ("bpf: Convert ringbuf map to rqspinlock")
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"

> I've posted tentative fixes that aim to resolve all ms delays, and I
> no longer see NMI warnings with them for various combinations that I
> tried.
> It would be great if you can report on what you see with the patch
> series applied on your tree.
>
> https://lore.kernel.org/bpf/20251128231543.890923-1-memxor@gmail.com

The v2 patch series didn't apply to the Fedora kernel version I was on
(6.17.9), so I had to switch to bpf-next. I first tested a clean,
unmodified version of that tree against my reproducer to verify the
different issues were still present (they obviously were).

Then I applied your patch and tried the reproducer again: it works
perfectly. There are no system freezes, nor any NMI handler warnings
in dmesg. I also tested the original production code that this issue
originally showed up in, which also works. As far as I'm able to tell,
this series fixes all issues discussed in this thread.

Thanks for your work on this!

