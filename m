Return-Path: <bpf+bounces-47060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 373589F3949
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 19:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6806B7A1FBB
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A83207666;
	Mon, 16 Dec 2024 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCOuMtop"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA01126C08
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375030; cv=none; b=bbhw/HvXcpqT9vFvej94pPriK4q32TtFJUlmRbtlsmU8lzfOp6xY7cZ6XNbcNq9MeEJ8ixZLquLlRqf0JJsO1umW3TWHXvrVptMdCy7CmfmmloXrjjHd9VkGTcoDKD7gERuLcAju+uIBF6a6pGO2oA+2/CEMoGel94zUemqQm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375030; c=relaxed/simple;
	bh=axKVFhxxqLPPlJ/1l34DA1zpKiRzXBPkPYSuthI/6xY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FSUHcs4NAub4psvozj1v/xEsXmLcdKtlwC4HSUVbFMvooN2zCw7gsxIpm1MIoUFebTus3QOthioQuQU+sqqBJkOp2aSoQg6UrxtwPmoYg064v3IPyKA2/sr4nCzCFAIEURFgIs2DO/qn1deG1txdtlI6K/Uf6gsbGwvpLLAXLyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCOuMtop; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166651f752so47262505ad.3
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 10:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734375025; x=1734979825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0hPRwPG3gRYsrCNiiarbD4e4/KCOAp8klEY5VdzH9QI=;
        b=SCOuMtopZ2ntzrBpwrf472skTiEmK35aMew75bKlYrF58bf/6j19AL1BVP/Kd221/f
         TlD9j+8fdJ3GU+7SpyEZAOEzsbohSWTPgUkSZMTjILmXBW0eYGXqEk+9EhEjdEc9dwjg
         HfagGyeBKWbGWl36wEefMmTt3YutBN1yKdHd7G61j3WTxKy1YxNjjwRFLnKEAEvN/dO/
         rilhH74YHo2MXVH2rfbTf1v+C8vyHlJK+dnypW9hiv6z6WWl0AddUgZgb87bZwWv5+6m
         2/8Y4jGkCv/JwM+zfvpaJzaOgcecT+Cm0YHR6eZ2nSac2fcEF1PG4szN6kCfMXd1N1Zr
         80LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734375025; x=1734979825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hPRwPG3gRYsrCNiiarbD4e4/KCOAp8klEY5VdzH9QI=;
        b=oMDPeyeT57V28KBwPd5sa+Knp3zopXOfqmpCd7q3IYzWJBKbbc80Z974lZ+X41tH7H
         xLJcIU9RIAYrT2zJAE44X9X1ENvxF7swSMziP/WlfeUFERcTrvRh080wOF+F+tah9c0Y
         sNvkDMYqaGpcSuqg0TXIs1K0xuNdiNwkNQKrBpf5Xz7ratnuJaZcxUqH7V9Ii9u7G/J5
         yE+gYWvBPNjaDtnXPu79DXjQZAw6OAuT9Rv6U0EPWS/XmEfHiluMBWEy4kwd2DKm73VL
         kDyeljVXrrX3pItjIab4SQSzDwu0ysj12TRr46xK2G4PD3QSDhH6yyM16do8b22YNcXZ
         nldA==
X-Gm-Message-State: AOJu0YzJf+LMr1lqMxmp2LDsH3POf3VULSQmSY3jp5ihXAcfpPTSLKSZ
	/a7z5HYenPJuhdsEXhJWXbhgQTlspnfJhfHrV8DGJcCsrjFiJ33Y
X-Gm-Gg: ASbGncvufkVIbm8wezIpkKypYTD+xqhJvE9mBVqKJPdoE9TQfqVBVgLr9bGosfK7qKk
	7xiwbZmFabhXxXJuoN7RKkjJttX1BgBY2y8dkq6hoiKfq9UsGurf8SNLBWk2Nq6Xuxz0HiViSWl
	Uc1iGy+HQ8C7JBhvavshbemeoYePyT5wWbfPP36G1s2Q5o7cToOVDImRiaGbuxQtX13OpAx6/QI
	IS8XBFH6juKsShciJ7qsg0htpIjesRDCgtoJ+tsTKAMaVqgD0cIdw==
X-Google-Smtp-Source: AGHT+IG1Kwu+w9p1o6aa3dZhvdzlG9sxyfnnVu6npOyRyebCHUpf7PD2y2nXGCX3hw/tPUgMYustpA==
X-Received: by 2002:a17:90b:2e48:b0:2ee:6736:8512 with SMTP id 98e67ed59e1d1-2f28fb6f983mr26001358a91.12.1734375025644;
        Mon, 16 Dec 2024 10:50:25 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a1ebba00sm5671477a91.26.2024.12.16.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:50:25 -0800 (PST)
Message-ID: <ed827bde40ab18be536add38c4237d949a752b2d.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test r0 bounds after BPF to
 BPF call with abnormal return
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Arthur Fabre
	 <afabre@cloudflare.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko	 <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu	 <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, kernel-team	 <kernel-team@cloudflare.com>
Date: Mon, 16 Dec 2024 10:50:20 -0800
In-Reply-To: <CAADnVQ++HfXeobY2XoJfDWXZGrF4_kR5kOK7asFRpBN=qmXU8Q@mail.gmail.com>
References: <20241213212717.1830565-1-afabre@cloudflare.com>
	 <20241213212717.1830565-3-afabre@cloudflare.com>
	 <76401f4502366c2d9221758f9034aa7bb2d831a3.camel@gmail.com>
	 <D6DB4NCLQZC9.I7DUNKR9RORW@bobby>
	 <CAADnVQ++HfXeobY2XoJfDWXZGrF4_kR5kOK7asFRpBN=qmXU8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-16 at 10:05 -0800, Alexei Starovoitov wrote:

[...]

> > Thanks for the review! Good point, I'll try to write them in C.
> >=20
> > It might not be possible to do them both entirely: clang also doesn't
> > know that bpf_tail_call() can return, so it assumes the callee() will
> > return a constant r0. It sometimes optimizes branches / loads out
> > because of this.
>
> I wonder whether we should tell llvm that it's similar to longjmp()
> with __attribute__((noreturn)) or some other attribute.

GCC documents it as follows [1]:

  > The noreturn keyword tells the compiler to assume that fatal
  > cannot reaturn. It can then optimize without regard to what would
  > happen if fatal ever did return. This makes slightly better code.
  > More importantly, it helps avoid spurious warnings of
  > uninitialized variables.

But the bpf_tail_call could return if MAX_TAIL_CALL_CNT limit is exceeded,
or programs map index is out of bounds.

[1] https://gcc.gnu.org/onlinedocs/gcc-14.2.0/gcc/Common-Function-Attribute=
s.html#index-noreturn-function-attribute




