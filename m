Return-Path: <bpf+bounces-45801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F09DB1AD
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3986FB21DE0
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 03:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238D84A2F;
	Thu, 28 Nov 2024 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiW3jA7C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C5481B1;
	Thu, 28 Nov 2024 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763235; cv=none; b=cDLskMX9D1GLaPyIxb25Js2J7ot4p3DGCcoeiejPfQDCAmo7EweamUGbiMrL3k/piuZTKLeVFZsIpKDNTYOfaVABTqVFo2Aqmdb1lopPXnuAX3hBIZuE556h8ANalf+aYrOj7+jZfVrJFafy9IEZWfz70o63P5ZX2oeyhqfJFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763235; c=relaxed/simple;
	bh=zCzHNML24fwwwfQRsuYZIWIfqPOgJJ4wQ45QZixXoE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2/Le38FiAeSWxsCfrhXVGOHb91nXEEQRyJYqWtjo52+kuSMMEdrHEDBMqnMM21tDmFMgBbvfqh9pEjQ4NePdP4/LnvCdvg+cuFO/G7nu91ptGBT8zCWKsqSWYkSbT4bUg84raRnEmGMs/kadTSwp8iIoTRwihNFPM9b0dKBCyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiW3jA7C; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso2787685e9.3;
        Wed, 27 Nov 2024 19:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732763232; x=1733368032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCzHNML24fwwwfQRsuYZIWIfqPOgJJ4wQ45QZixXoE8=;
        b=OiW3jA7C6I5V1kRSuaeVItXv1/jfzyAD+80AG2g9UUhH5LT0qlqAj51UKDEQnnGB/7
         NCZ+99b1ibhvSSeT/+B6vfkGyeE1A/+UeF+uEbBHSztXMmZ3VrjAjQhg65YxhXmysr8t
         1E8eH+vCsMXwzJL6W8dVa/Xf2k2k70B7eS+/ZGv5Xsd6N+JaiK4YRYl5xCRu+mDZxvtE
         hoSB+XgBxsEjhK+8g+o/p11ZIFYl7jw1lJ+yvyTIHCt8r6Jz2CATQP2lAFaoOv2exSOa
         e+5EeSwoZSmUBNlqBZJmyb/Egz1aUM2jXPSZq5fZ//Nzjqj5+/PdhXwXoRQRZJQaHsxA
         Xeqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732763232; x=1733368032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCzHNML24fwwwfQRsuYZIWIfqPOgJJ4wQ45QZixXoE8=;
        b=Lb03HFuA7Xqwibj2Vk+4ymNVHIw91SkjckKQyfvl9403RKQP0DhYK3H0s/cTfCDRJY
         wxudKYm5dBBwW5RIW+y4bfZTVvTU3MHYaTN9xnUNply8wkKDJ6DMrY4eAHouuekE//Ox
         UsCGEErKV+NdGjQ51zvHFuBgNpgdTSeMQSfejy4mLxoITV6ptugGVCS1jK3fQqaHy3t2
         Ns4bsDareUWmujN6OIu2wNlaQB0it62tvaOj476gFSzX+/YjdhaL/W3PmcerVitIf/NN
         akMQbFE2z5987/2ntui3r/VA6YCqDJgPwJYvu7DvuSdZowy8J46Coqe5lgEXR2nWEI4b
         Ry/A==
X-Forwarded-Encrypted: i=1; AJvYcCW+iyTni+CqxQXzUM5GFkrHhe6uI0imtzPsD3rQna4R6xl3c1ZO/UQD2ZlXyVGKu66aVz6f5oLWurqW7/oS@vger.kernel.org, AJvYcCWTAjL7sv4MYAwLFaByPgMGzW8N4qVFeO09RHjNxV5iiG54Ap88ZZ6yoDJyK+E+pyqxoTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE3U5Ydv/WsZNto6lcO0MtQhNlxz6yTkjlNdQkYxtrwqfiIM2j
	s2eI6ivLB49xLi6xjHqGu0NVaAzz3b3IsEB9o8hq79mUldBO/3xPML1CWomteLBMIPbro5XyEia
	QA02eYSxgWtM2A9WnrG/35q7ZRzE=
X-Gm-Gg: ASbGnctrKZ1lsOvxd46A0I14wGjiS886e8yHai+fqBEpCvRdfYJtGkdoGMDRFgNCqFV
	kRDEjXx2dz3U9LxjJViwXzQqPgEiPWw==
X-Google-Smtp-Source: AGHT+IEgMijHSbISe4Ozvh5PoPj8L4nj4B8S6+hCqTt3KPE1Ffz6Eijo5AqokjNkUmijHiWHJ0Fu5OgdnxA1ORctRBM=
X-Received: by 2002:a5d:64cb:0:b0:382:4a9d:28fb with SMTP id
 ffacd0b85a97d-385c6ee12c3mr3328586f8f.49.1732763232514; Wed, 27 Nov 2024
 19:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128024717.2719-1-liujing@cmss.chinamobile.com>
In-Reply-To: <20241128024717.2719-1-liujing@cmss.chinamobile.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Nov 2024 19:07:01 -0800
Message-ID: <CAADnVQKHAbzMjRUT+OY=CO65dhuf6wTH=CxpHCfRP=oXNrnwmQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Optimize resource leakage problems
To: liujing <liujing@cmss.chinamobile.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 6:47=E2=80=AFPM liujing <liujing@cmss.chinamobile.c=
om> wrote:
>
> If fopen executes successfully in the main function, it does
> not close the open file stream before the end of the function.
>
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

Same issue.

pw-bot: cr

