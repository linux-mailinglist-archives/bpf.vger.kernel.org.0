Return-Path: <bpf+bounces-19317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F07829606
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 10:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7501F26E9F
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 09:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B2D3E472;
	Wed, 10 Jan 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEhML+gG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1B93D0C3
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a28b9b87013so458154966b.0
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 01:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704878112; x=1705482912; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22meeCLCLk1sr+ZeBgBSyZzfHRxkkpMLTBZ1RKzMp7A=;
        b=WEhML+gGbJxSrenA9eLRKjZ2KY/fNPoUWSxHR4Y941VVr5FmdKrnEkJhVZxvmFubD/
         OMxvAvEHo/w1xuxRI8nQIYBpalGDHSNnqPsqZ5KDCAbKL6Xo8gJl23yvR6fqRwY0nmru
         JzRUp7GaoulXOt+vdJ8K3NxDyOHa/fZU9mqAlFR/yuAbeFB9Ob1vywbAinI67cKnhDwl
         jA+XtdBKj+BMxMcoxhQKlY0Ht8gYNVivF9nyxH71hrrrB0f85iJRCySX+pkryPRILHCZ
         9zRfiYreNbhhI9NSchkDxB6GfufcwXt24rgUuq8LBSqtWdrHmguTXYJaMZUILcwJvou6
         rbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704878112; x=1705482912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22meeCLCLk1sr+ZeBgBSyZzfHRxkkpMLTBZ1RKzMp7A=;
        b=QOtc3vwmmoMH1qAg3GucAX6uQ2UrmFEfl4KFAoJMVQyTOp8XhBb0wWcQZ7YMN8OTZF
         Bj4mKBGKyG3lG1wEm5EyE/v21Yl/eFA7OGeCOFZVkn6vof3hC0AqqbVVhmSvaCwIthGF
         pznjrH4RY33hVaxRLcwhtAgC7rEr/ZRFQS37mv72UKBcYxhl+kHXoQL1ikibAOhjV2Vg
         /j/tr7NlQ5d3Np0dvRHY6R4kDSsYv0wpeXDQh6k5EJI+Nt/GtI7d6BLgvrWtTxM3zw4v
         f7Ym6rmPQPx4gElWDWaZcNOYn1CPwNpi6S8s+pNmx0S8/uOBkn/YZl4WZWKpwXAMPnFM
         YeOA==
X-Gm-Message-State: AOJu0YwZz3OoKHBgMlm4xtnwTlvSY7yu74Fz2S/V76SORr9w3bOJnsTY
	qjiH1gbso1ikCbBVCTDgauuchg7dS9ry5X4C/Q==
X-Google-Smtp-Source: AGHT+IHM8JuNl/FzfRgv7kFNtWTX/Dshz79l5nmXtz4XHV7Kd5Q8CYGVBOXDaIntaQbKbitkmYqtlcdcPDY=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:8a0f:76e:1832:6c58])
 (user=nogikh job=sendgmr) by 2002:a17:906:36cf:b0:a28:e1a4:ae3e with SMTP id
 b15-20020a17090636cf00b00a28e1a4ae3emr22935ejc.0.1704878112336; Wed, 10 Jan
 2024 01:15:12 -0800 (PST)
Date: Wed, 10 Jan 2024 10:15:09 +0100
In-Reply-To: <CAEf4BzYMx_TbBY4yeK_iJqq65XHY5V3yQQ1PzfOh6OMQwyz5cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAEf4BzYMx_TbBY4yeK_iJqq65XHY5V3yQQ1PzfOh6OMQwyz5cA@mail.gmail.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110091509.1155824-1-nogikh@google.com>
Subject: Re: Re: [syzbot] [bpf?] WARNING in __mark_chain_precision (3)
From: Aleksandr Nogikh <nogikh@google.com>
To: andrii.nakryiko@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzbot+4d6330e14407721955eb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"


> #syz fix: 482d548d bpf: handle fake register spill to stack with
> BPF_ST_MEM instruction

It needs to stay on one line, otherwise only part of the title
is considered.

#syz fix: bpf: handle fake register spill to stack with BPF_ST_MEM instruction

