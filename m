Return-Path: <bpf+bounces-51459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98492A34CE4
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 19:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDED164145
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 18:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376C1266B54;
	Thu, 13 Feb 2025 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK0UNSaO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4462661BD
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739469793; cv=none; b=b2VrxcM4RlHI9osLcRbgmUbnQZ3as3GgDOsVB3Lay7GaHfO/zEUqp/mmBz4AR65jfLQBs5Oihik+LZ1Q5MbLpv2Aco/ba7XAHlsY+86G85GBZE1Ep2WCj6AB8/fajZI23fBu7FT4gB0roQvmOt4ZaShRbXh10560Qi6qhdcyC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739469793; c=relaxed/simple;
	bh=C++JTqEp/sKyuf3qLjUy0xqdKWOzLHj/plTCDv9AimM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azYigxqWiZ5jsUztfvJ5ztZ4oeE+0efILO5pGELZMrA343wD/yVz5zl2l4d9pJBsg2lE2xDD+47xgjyDZFTAOOLu0ns3J1Oa2ixst4h3ZEM/hjuT8bgP/ApoEVN0howlC/E6xXsTF9oPNNbbv44IAsIwTwiugqK94gHcI3NCdTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK0UNSaO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7f838b92eso211818766b.2
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 10:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739469790; x=1740074590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C++JTqEp/sKyuf3qLjUy0xqdKWOzLHj/plTCDv9AimM=;
        b=FK0UNSaOK7HRlxHXYLcQNiX/twFML8Qr/EstisVjUQS0/UNBpjhd40nmwE43PJbpp9
         goLNbYvMg5MMF/5ch6rw2jwTJYR62tPJfDrgO6tw4qtXGI3N1pofBHwx0XIqt0TbSI5x
         VPlw5bINNJM3a7/WVi5nTlSOmJJPOKYOjK9VFCA8KIlBg4sNuWKZbMmBURJ68x6ZyRY7
         +EjGqwapOn9YLFbIoa3/e95Q5cO9Bx7kwt3gAIqs8452iIl1WT2OqhQvMnNV5xjazBav
         dqY1JNNbH6DGLTf8kXWaRp63zbbxej+ccFvALwWNCDs+Rx8ZAJpbyM9tZzr0113UUmig
         zZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739469790; x=1740074590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C++JTqEp/sKyuf3qLjUy0xqdKWOzLHj/plTCDv9AimM=;
        b=Chhgv6e4SrLJQzl2T5vwClZLjDuzcyPfFHSUjUbSGeuKFsNTU5JoZASz4Z5nznVaHk
         YgrMYRABa/Km3dsS/4N8+UBJSnSf0ksRPCVJvEhaixqU+43qO9bD2iu4oHTmY0GhWRgQ
         1SqheqbqCkA4r0dQRTR2ZE5Ax5WKl3QvI4+KFEznYXjnzh+c2Ej8g/WUxwaJ4nF7K154
         TPTFdZOvmvbalF3uhbsVMQ0OYKLIaFbKOFBRGYarVB1NvwTj59r+DBUxxyXtr0hNGAdR
         MRn6WJOjT/bKFtdxChpBxefHviHn0GlT3TZZ6B8Nr+3CMqPDSQNP/bQ8BgH91YPyhK3E
         viKQ==
X-Gm-Message-State: AOJu0YwsDqH6y9SMCiAk6Sij8J4/coo31C4H+885otIvHpH2vuL/R2Kx
	VRduvt7RkFiwxx1Zo4Dp18ELgv2Yjs8iG6WCOLvhTtEVDW3z2OOzY5bh9DM9nmWOhJABZdCHiHw
	Duq/e/gE/dw62iGSYPasU9JO48RWhtrr0
X-Gm-Gg: ASbGnctbdJ5wA0t0Q63IVqUkPHmY80BDvCNEZ6jrfXuhWrwMIgB6pH1tZE9CHlcosCL
	kFxS6GN8rxmqOgQN4jKLkDZP0LgSK0UT8CX47zJbvwf4jbKDOD46EYmH57M/Jrr6yrpiQn44vCm
	XavZihAyDq9dgkWdNdF10HF7qRn6+h
X-Google-Smtp-Source: AGHT+IEMiLONo83h6Sep2bcf3cyHZXHmACQ7DTSRBhZLgO1mx8VWWr3MCukHg6iVnRmWwkR1D8MvbVOPZ8XrSPwts8k=
X-Received: by 2002:a17:906:79d7:b0:ab7:d73b:ae23 with SMTP id
 a640c23a62f3a-aba501bce39mr363384466b.54.1739469789919; Thu, 13 Feb 2025
 10:03:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125111109.732718-1-houtao@huaweicloud.com> <20250125111109.732718-8-houtao@huaweicloud.com>
In-Reply-To: <20250125111109.732718-8-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Feb 2025 10:02:58 -0800
X-Gm-Features: AWEUYZmeHqHIGCd75J1cwngujgJWcLFYa2i7pqIkAky06jwtkPtEl2SKF09vdkM
Message-ID: <CAADnVQ+D+eZzLX02XmKCGDFvnxCM_za9pKiCzwkrgzUCShCGTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/20] bpf: Use map_extra to indicate the max
 data size of dynptrs in map key
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 2:59=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> For map with dynptr key support, it needs to use map_extra to specify
> the maximum data length of these dynptrs. The implementation of the map
> will check whether map_extra is smaller than the limitation imposed by
> memory allocation during map creation. It may also use map_extra to
> optimize the memory allocation for dynptr.

Why limit it?
The only piece of code I could find is:

uptr->size > map->map_extra

and it doesn't look necessary.
Let it consume whatever necessary ?

