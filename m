Return-Path: <bpf+bounces-46544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA29EB9A8
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0F282C3B
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4723ED41;
	Tue, 10 Dec 2024 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ0eDZsB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808E1D6DD1
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856758; cv=none; b=U91CePBtgMKTDDmkttw7rdyab4xWTwYZkDcb0+pAmbfrNlWvq+dh+oTEbM75SViJcq3cKBTGkchNzgiS2HU2IulYOMIxJLctqnPwHxFEal/imsQlyibz1zvWXyOMJkEi8s2NYhN1shWIfzVfqoS1JHmDAuls7+sw7JXJJ/bPJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856758; c=relaxed/simple;
	bh=vnpngQV7LHuHUEBLDI+WyRB+WELelpkmvUL+As5vGXI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TKu4mExBrux/0thEaP4YGIfJCxPEEdYp7C5oagHtIuxJw6l/OGumGEghWduiq0ha8sGLpNf19DBFfkDr8YR4xA2hacJnM5bjTilUOM2Bef5zfhTyb/d+wge84Z5bIQpdsjWqPYQVpEKbnmUcvjSAxOJMoM3u5vMt1qSPY8TqQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ0eDZsB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725ee27e905so2749284b3a.2
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 10:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733856756; x=1734461556; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vnpngQV7LHuHUEBLDI+WyRB+WELelpkmvUL+As5vGXI=;
        b=FJ0eDZsBpgwbqANnaZPBONSk0G7RDwuwvsfMMIQ2YNNZJHXLlpqHgexOg7MqU9ZrDB
         kFUPcJ07nbAOntdAs9/61pnACzRoBZfpCoHan+6VHPkqLPLG4MODtu2ktSNUgIxRc7Vh
         e0KUSPn2z8gtclo6kfl6q/EMTXbODokQubwtRW8F1IAgszH9nhnhnYnh35LPZmtlp9bm
         8GpXzbQ+f9tvc1UvPFhUiU1k1AJkFcfvJGn7xb0R8P4pcXAaZRQZ5GfArVi8sBTjGt43
         eVDUam4+U+MfbW/9dCikhPJT/1ZMSC/jVqQeksdfl+WAGfFoJ2cyDgDEzRdKV3dJjF21
         D7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856756; x=1734461556;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnpngQV7LHuHUEBLDI+WyRB+WELelpkmvUL+As5vGXI=;
        b=r6ikE/JZ8uTKorOOIdNvi5NU6ATgukp7FQHX2JaQLNm+fAve7gUj+FiOMQEiISQZwT
         27WUKHsoKuFDLlRxaAN4FmyWsuj18RQTbkrty2ElKTNHdGhnSKdzCig+Gx++bFcstgO7
         3EKR5f398s7iF7cDCCfYbVppvL/FgD6Fm1ENkINmH7W2DttCJDlZpTQgnASsU2FriENU
         Z9dqNDKYl6xLZZ/d54gDSCxLgM0w34JKNDLDeIrgAxqKShJrHYB5CDmq23EmmiFlY2L1
         MECA73IHdEy/SLYrwilkjbj6UGhAl2M/lsQXTypSHlJgIJ1u4WxRvApmFCQHnvdkw5p9
         QLrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgfAf2+/vlmLqN0DiIhsiItMdnRk/6GSUzlZxgtM+VUzBK5JKj2Zrxd3Lc/dwGqhTLGcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7a1TXoaH84G7UjqSfF2pmjXO04utDjACrrCGlm2+Hc5sUuzke
	IByB9OKVAW+0RLbNbT0h8HgyqgTLMIXkgNcY/+9JciL2XiyNm64r
X-Gm-Gg: ASbGncs1Y2FvcbfUbyyFcttIKnwbMea15s7dga8WhDNnBwDnkUEWm8vRzaCU7rKHP3E
	o7lJ6BcODCr3TvH1ct4bzadGIK5YJRmKQUj1ydvydx/IJw20zcKU8oNkBT8QIeFXrc7avdz7OSe
	0Bj2JdE/TE2EZRt2b52xbBKWu80Di0wcYPTLXNLWKMGyD4AII0rTA12PF5ZvqcX+fSj2BGYymGx
	VdXzQctQ0mFths6evZH9jqxeBH/Sdmu0WgYYOUNHLYyxNNh49c=
X-Google-Smtp-Source: AGHT+IFnrsAg4YFpCTytgM6fjok4A53kQuntY+yu5jYq+AGjkdkzF7iK4UA6Mjh7Y8fapglYXw941Q==
X-Received: by 2002:a05:6a00:1895:b0:725:d1d5:6d86 with SMTP id d2e1a72fcca58-728ed48b9f0mr63409b3a.19.1733856756234;
        Tue, 10 Dec 2024 10:52:36 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e39882d2sm5051104b3a.79.2024.12.10.10.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:52:35 -0800 (PST)
Message-ID: <7bc3b90bc810df379f9463ebc62210c3819725bd.camel@gmail.com>
Subject: Re: [PATCH bpf v2 7/8] bpf: consider that tail calls invalidate
 packet pointers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@linux.dev>,
 Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 10 Dec 2024 10:52:30 -0800
In-Reply-To: <CAADnVQ+hsXZirUYJ6Dshn+K6XNJB7LC=cS5ZzHXiMQbot+SJ3w@mail.gmail.com>
References: <20241210041100.1898468-1-eddyz87@gmail.com>
	 <20241210041100.1898468-8-eddyz87@gmail.com>
	 <EC7AA65F-13D1-4CA2-A575-44DA02332A4E@gmail.com>
	 <CAADnVQKBmQrvnEYqqSpUL6xjmccBW9vnyzQKDktd3uvZUyY83A@mail.gmail.com>
	 <82110da58b8ee834798791039155074a9aaba7a0.camel@gmail.com>
	 <CAADnVQ+hsXZirUYJ6Dshn+K6XNJB7LC=cS5ZzHXiMQbot+SJ3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-10 at 10:31 -0800, Alexei Starovoitov wrote:

[...]

> > > > From an end-user perspective, the presented solution makes debuggin=
g
> > > > verifier errors harder. An error message doesn't tell which call
> > > > invalidated pointers. Whether verifier considers a particular sub
> > > > program as pointer-invalidating is not revealed. I foresee exciting
> > > > debugging sessions.
> > >=20
> > > There is such a risk.
> >=20
> > I can do a v4 and add a line in the log each time the packet pointers
> > are invalidated. Such lines would be presented in verification failure
> > logs. (Can also print every register/stack slot where packet pointer
> > is invalidated, but this may be too verbose).
>=20
> This is something to consider for bpf-next.
> For bpf we need a minimal fix. So I applied as-is.

I must admit, I'm not familiar with the way bpf/bpf-next interact.
Should I wait for certain merges to happen before posting a patch
to bpf-next?


