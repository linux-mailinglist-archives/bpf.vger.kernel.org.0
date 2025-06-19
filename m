Return-Path: <bpf+bounces-61096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA991AE0AE8
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 17:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E161BC070E
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E727F166;
	Thu, 19 Jun 2025 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0uGFs3g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17D211712;
	Thu, 19 Jun 2025 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750348544; cv=none; b=a0AbplureaoF89uOC7C9BMq1xkn8u2vewHObqGGlkl5x7yDKrES5udK4uXT2YhxE/ruA42QPV8vfVDa8Ow/KGHdGsjIkygrf3H9OYU5JkzOgJYA8Mb2VIJfPMs+XLXs6iC4nlATnIeB+Xsq7RngpD9yf0bSPWSz1I2b2czYEbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750348544; c=relaxed/simple;
	bh=QIyUOZguIRDiWUeNLd3XC6ezHfJQ0hbQk0pmNBnUCQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxwYGIYcOoJ6yeQ103zrOJcSrIFkMl/1rfpbhSZs6ofqObg6VqqfIit+4XRYb3Nc/FwrY76kXhyYk2hbhb3bwkI8QwLLCOnGJnEJf4hTSkhv2X5HiELLq2IrQehJdLYZ4E19m4s0TI9znLAipnb+paV+ulqp88+prwGqFYGisRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0uGFs3g; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so7209175e9.1;
        Thu, 19 Jun 2025 08:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750348541; x=1750953341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIyUOZguIRDiWUeNLd3XC6ezHfJQ0hbQk0pmNBnUCQw=;
        b=G0uGFs3gzUkcf84xh5bsQgrhLO2spYNBoVgNbevQ2zhZCwMnGugxzc9SZhf9YDnix4
         07oglKYGrs/FkMA80rbSqypfvauw/t9v8bVZrFU+mhtvtiFis+9JcDRYL7eHl/0T/Kab
         ba/Fil5rojtQxFRdEAym90mXZKYEChJ+LMsl4MWR7FGBLu9smMdAFeC2W5X8PcXjrbLe
         93a1eUbuvU45DZutSe89/KzW4BB4DEYOHWrdjogH8yliDQED0AkAz1EDJymd566rtnHA
         07qAYVZJWwx2wBQQz7Jq7cKHAkaOnVgD17GZhSppQf17l7ocrxKhQmBnUggn0IkOecBH
         CupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750348541; x=1750953341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIyUOZguIRDiWUeNLd3XC6ezHfJQ0hbQk0pmNBnUCQw=;
        b=DmJEReY1QnsKe5HZMSk6TaQcYP/Rr9q/oDS0cCWktXv0PYwpM23ajXAI2rZRYUxGnS
         c8A8ighBiiQe53v+FhvfaiJcMvkaSi7fBtTR0AIWnn8hMmepG1lYWUbY+LuoRhAGezu1
         vm3VEhGADrqwnfNDz9zYW7wNaqNtQ70tdCMhtKQvxLb2mBLFyS8ik4LXLvym0hl2psrN
         8qw1UIMYpQV+pMVGZTc3iRlUGm1Zj2fysDAxkf4oqlia40AmyjpK4j/klstq+7DQosXU
         p+LXJ86LBry6npQ24go+o6Ut9KoHNXhgOmP8dnfkr4Sfe3g9QWgPcTMZNDEQehkACgDE
         8abw==
X-Forwarded-Encrypted: i=1; AJvYcCWpQuTfW1in9VeELXH7GGqWy+/NqSoDnBwN7rUg3cgsHUdUULQXtG5S/kuS8cGEuN5v36/s3g+5X0Oa9BPU@vger.kernel.org, AJvYcCXs9mP6jrr/vUXcXEH3d2IMzCQrj3aAR6444H04MjDk6C6tjOkt3EA/CNli54ncxuCGd9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiFlUZjZnFhm9yAcRSsbrHcoLEUyXaXCIca9EzhL9jHlXSAWxR
	xevB8Zif50419Z7dWEJzNBNmGOkDAN6Z997dWUKMv5RqxPdRej/iUp1BGHbdQEmgc6qbowcysHC
	CMa/Aijebuye7lUCQaERTZTzAlmyCB1g=
X-Gm-Gg: ASbGncudbBizFGPa7ZlLMXiC8CCoG6eBOdtUVVhD94aqnzZr8BUDfILXMU0ye2tD0eu
	JYZYRa/uKZsAYGq88VWs/MBeAq4hIGMKJL91Joi970wCu5EPVLgsPza5OzX4LCYXWCtoegng/Td
	GeQkOq+hMpH18Y4ZjH+23mIoIxX188KNijMYQWh33y2G2h2FhbfbOp2iru8RADyLX0W+DX9Jbe
X-Google-Smtp-Source: AGHT+IHW6a2KI+jp4VsHi0ZEYeDsT/Y2lsvjOD+03g22TJkwn9M0TZp4i9xmRa/8PBbab4dgGPUrkl78rFHpFFPWExM=
X-Received: by 2002:a05:6000:4305:b0:3a4:dbac:2db6 with SMTP id
 ffacd0b85a97d-3a572e553e0mr16687800f8f.49.1750348540954; Thu, 19 Jun 2025
 08:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619031037.39068-1-chenyuan_fl@163.com> <20250619065713.65824-1-chenyuan_fl@163.com>
In-Reply-To: <20250619065713.65824-1-chenyuan_fl@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Jun 2025 08:55:29 -0700
X-Gm-Features: Ac12FXyPM2W8dKJEqsk-s6P-7UGk9obNQXSmsZPocIJbzLPWkxFoVEMObfoUG5E
Message-ID: <CAADnVQLy0_FsjRLt2n9R0Rs90VvLQYbkSiji6usaoB_bf4+tYg@mail.gmail.com>
Subject: Re: [PATH v2] bpftool: Fix memory leak in dump_xx_nlmsg on realloc failure
To: chenyuan <chenyuan_fl@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, chenyuan <chenyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 11:57=E2=80=AFPM chenyuan <chenyuan_fl@163.com> wro=
te:
>
> From: chenyuan <chenyuan@kylinos.cn>
>
> In function dump_xx_nlmsg(), when realloc() fails to allocate memory,
> the original pointer to the buffer is overwritten with NULL. This causes
> a memory leak because the previously allocated buffer becomes unreachable
> without being freed.
>
> Fix: 7900efc19214 ("tools/bpf: bpftool: improve output format for bpftool=
 net")
> Signed-off-by: chenyuan <chenyuan@kylinos.cn>

SOB and Author field should have full name as "First Last".

pw-bot: cr

