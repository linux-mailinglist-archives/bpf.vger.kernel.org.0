Return-Path: <bpf+bounces-59309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9DDAC8185
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 19:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26A150281E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1EE22F155;
	Thu, 29 May 2025 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5x6RAB5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F49622DF97;
	Thu, 29 May 2025 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538702; cv=none; b=rLMGg7zHFeaXe0QDzoGBKnSwApNGAetk1Ij+DHiT0I1wmSp40HVxF1kdBgo4jkiBk+9cvbPs96oKtiCXkF/JxKjrYRPTAabZMG4n+Hq3Uj0een5aByhqnQ/eQKGg39ZL1aDiV5n/JWfnfWjb9d3QARxDycGel7sud6mgsNx6h24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538702; c=relaxed/simple;
	bh=UGG8vparqy07o1+6smtpNiEl1tPiawOred5ZAVfO68k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmJVZdhVEuo9zd/4MIg+6MVZNeV8eGPFQTMWxtVRd+5lw8/eV1eyVqqyGhXlhAsColOlZEArkBcdNlAPtbr25Bz9Se12vPuzpfDfzbs0D4roZDcmzpxXOQ/vS0UtmLxNf41STNC+r5yUfA6YKrU4GdzEMcOjlkRLI6Pnho/MSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5x6RAB5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442ea341570so8239375e9.1;
        Thu, 29 May 2025 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748538699; x=1749143499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcxRGkknHlmO89+OI4WQ5Gv1s0uYNEV56LYQ/5eeYmc=;
        b=C5x6RAB5rZlVylGAdMJcvyQG7koQV4yck+c6xefYiGk27sroVR5VDUM/VXIiuLY9oY
         a7ivixd4iGn1OJ5Zr7vd17th0Dk1RTCh7Ohc9dV+QcbgmuCDm5w0FReC35X2rUoh530B
         5AqKwvJYgn8UKEd7JZn6NpBzMLq42FOZKk5sb5vu0/6RZ03PUaCecTmkyTwD0XYqlt74
         amsN2WchSIMcCir/VpzYJbkVyN80JfV4XUv49aHxz7mlXE3cKc7vRylCKyCCXbJOmCBV
         632MGucyupEvq7r39tgd7imDDFP9RSusJ0d6jdAmsyMSZyxIoy6kjUfb0GzB9Hv5Nsvf
         Ry/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748538699; x=1749143499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcxRGkknHlmO89+OI4WQ5Gv1s0uYNEV56LYQ/5eeYmc=;
        b=nTtnBCpinWtuVFEdkQsKkJHkqsDHgZT7KMkZiA92Qc/f9LFLifAQdJarfrGD69ZxNB
         E2nP+6uvmDl4lXEUqR3ykPKVr9k1eZ0Rs5RAx/6Bw2hau3+fyQoYpWXj1qzOmHf2xmeJ
         fEYy0xh9A0p7DaNZEGbedq85Flva5riNMJqTPNyWSx10Q7OL6rIRg8GXLpi+bDr5p4gp
         92IH/DS0TZgAkJ0I+XQGBGgbMBMBUWVQ7UW+lGyb+3rM28rye/XewdaXMHq+8A7P7uIS
         6iTlSgg32DdS1QD5LXh+i2FLAWk3l2nhYaspY4VBPNPnd6diKQ9VfSwhZ/2b2HfCVOI7
         IUzA==
X-Forwarded-Encrypted: i=1; AJvYcCW6m42J395F7Iz1tubh55YEKXaaOc1IFzBw1dDBW8EuGG035jkVwiPJ2B39FeSOE6MLqFI=@vger.kernel.org, AJvYcCXRbMa9X/FDYEcm+sP6TNE9uaa4zxafPcqd65jugelYu4TdhlfTVLskxQ++SDCSdh0kQRyi1YdpVCMw8SJC@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNUqd5FD7BILl3swwAcNn79Lpj9MC2HfaWubXq9s9nk62NQlh
	UZAP/oEDAAZNdGqikKDsKG5v3zrWifHTFrVwwdxXSVXNSPBM4kTZABgKwv3DS/j9Gh2mQQ3Vw2y
	7eJ0KmGF9hGkq7tFReB+OMvsevrpkA7jSXlkoz2I=
X-Gm-Gg: ASbGncsaAjmLQOIRF+CfOK2y9aTxaGVz0dLQ1GQTCI9cFRCsvrTIDtR11IoNqqULSJn
	QFAbBA49ZjwFrFzmIaiixqQ310do3lgAkmlmqZe3E3BdzPo3trWW85ikzYBkRS1f7iuFVFoGKdS
	WQTTolQQRInGkfIXBixkc1DGUQNxIzGraxXbIK7wOncRtHRMQu
X-Google-Smtp-Source: AGHT+IEZP4hA1hHWNy6nkogPWv/E7bIr+wWkOHEhFt2PXAi0aunsQJPFNpgXr30zNtckMdCgIbXWdf4GYhW/AnNWVO8=
X-Received: by 2002:a05:6000:144b:b0:3a4:f024:6717 with SMTP id
 ffacd0b85a97d-3a4f7ab1482mr45445f8f.53.1748538699468; Thu, 29 May 2025
 10:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529165759.2536245-1-chen.dylane@linux.dev> <20250529165759.2536245-3-chen.dylane@linux.dev>
In-Reply-To: <20250529165759.2536245-3-chen.dylane@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 May 2025 10:11:28 -0700
X-Gm-Features: AX0GCFsem3dNWwgsvHPzq79iBP4n64GkCxcULbbU_P1i8ossVZYTzddUy7TXsDM
Message-ID: <CAADnVQJVFffjzgZ0o_gAGJHwHHXn+UjawhAwknaTfgdQpjY3xA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpftool: Display cookie for raw_tp link probe
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Quentin Monnet <qmo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 10:01=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> Display cookie for raw_tp link probe, in plain mode:
>
>  #bpftool link
>
> 22: raw_tracepoint  prog 14
>         tp 'sys_enter'  cookie 23925373020405760
>         pids test_progs(176)

Curious number.
What 0x55000000000000 was used for ?

