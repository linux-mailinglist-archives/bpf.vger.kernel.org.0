Return-Path: <bpf+bounces-13032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5CD7D3D2F
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 19:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B72B20DC2
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 17:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE801E52C;
	Mon, 23 Oct 2023 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBzGVGY/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430E1F92D
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:14:52 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E7310A
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:14:50 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4084095722aso28964745e9.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698081289; x=1698686089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5VC0PFlhf8zKxbot/jMCXpuGWjTbGl7t6ZFTny5bV8=;
        b=PBzGVGY/OVOkhstkh5IuZAh5GDDfruvuk3pu3upgj7F5v/KyMuRCTBg/dSn+Nbvtnq
         u0vV1WYRbPxYT81WASO/FmHt8Uh3iCeZXO89EGGFpf3RHhq5Dyg8i2QT0Hv6IOd4hjx4
         jiv7hgp1UDLVvkyqo+QuzNt4Ae7DEnidIrUqcJUM5MnY8WIi9k+VPDvs2Y17N9SsPNmV
         0OBZ7aRcS6xMnAhTRdhSnhWxy8IaiHAisMIr7BS4DED9zq/KjnDZ3X5J7I+B4CKKZ5OE
         5ERqq4Mt3CtSbbwd0qmJm1eVAL/8AiffCZ6hYWZnq3AmEMq9GaHB1Gh1ynxLzwuh02iX
         wB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698081289; x=1698686089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5VC0PFlhf8zKxbot/jMCXpuGWjTbGl7t6ZFTny5bV8=;
        b=we77llX3Dm+8CmGYKJ5+IRevfRtHnGKjBbbriT5eKQADhIb6Gk4DqEBI8R9PcZiwER
         rVYh/Dpy+RwHSMWUe9b1bCxv2h8ZnbVOQAbdR31Uf50DLPCZXdIxyLbZ4M0k0oHdIOMp
         1kWAk4+o9cUwVgzwrjVcFTEk79pJVKbE5RBDuJGRVwLCq0jjfah0BuwQjpQXWBgo+Nl1
         KqM1B8/ikoZf7c3kcAsH4gwQvvKUxSANWHwNQNYZSW3W8/9u6OOBTuxzK3PAHhCDI0LZ
         3/aWv60lZFV7XuHHppZlUgL4T7FgvSL5nOhBzlf4dmrLFRPTUeoe1JhRxG9YrakuzOdx
         3GQA==
X-Gm-Message-State: AOJu0YwqrF1AJGDpSwQBvEOiRYK2z/LCqUQHYk8pL6WD2Jw8P66/sA4F
	CMT/7AUqqOTKO1x+HBqVj+scSSGUa7pwYaGxxSv7KQPq39Q=
X-Google-Smtp-Source: AGHT+IHx1wShJO6cKfFCub99FCD5mb3B/32pqp8/+bD0IZl7/AjNtpZ/XdiIP8GZ18Vfk4nGORs0iAROw7HcJQZElEA=
X-Received: by 2002:a05:600c:4f12:b0:405:37bb:d940 with SMTP id
 l18-20020a05600c4f1200b0040537bbd940mr7471402wmq.0.1698081288857; Mon, 23 Oct
 2023 10:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022154527.229117-1-zhouchuyi@bytedance.com>
 <20231022154527.229117-3-zhouchuyi@bytedance.com> <CAADnVQLGwn_x9CZmYX5K_6K5Y0SB7EjU5wfRUHRMdXhAvKEJVw@mail.gmail.com>
 <cfaf3363-51b9-40af-8993-9718d7edbaf7@bytedance.com>
In-Reply-To: <cfaf3363-51b9-40af-8993-9718d7edbaf7@bytedance.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Oct 2023 10:14:37 -0700
Message-ID: <CAADnVQLcw36TiEYXaoYDhEinygCQ86U5AKg-rJPsQj=KUu7Y2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for css_task iter
 combining with cgroup iter
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 6:50=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
>
> R1_w=3Dptr_task_struct(off=3D0,imm=3D0) R7_w=3Dptr_task_struct(off=3D0,im=
m=3D0)
> 18: (85) call bpf_task_acquire#26990
> R1 must be a rcu pointer
>
> I will try to figure out it.

Thanks. That would be great.
So far it looks like a regression.
I'm guessing __bpf_md_ptr wrapping is confusing the verifier.

Since it's more complicated than I thought, please respin
the current set with fixes to patch 1 and leave the patch 2 as-is.
That can be another follow up.

