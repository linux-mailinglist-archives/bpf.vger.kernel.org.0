Return-Path: <bpf+bounces-43800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2659B9B93
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 01:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EBA1F21FBA
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 00:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB78F77;
	Sat,  2 Nov 2024 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGbBl9Hn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE9191
	for <bpf@vger.kernel.org>; Sat,  2 Nov 2024 00:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730507566; cv=none; b=Weul8zJhSzmCqKbdvaG6iGvQv+jZUIH8G/UKqvvbeFc3Bkgnu75g1qOdlMxOyI+3CJHTdayLkqipsHHMEKEZNWnF7YqUM/qKDm4JzOaDZOvyGTA5VO9pRwgZvzhRACpzYWaCitrAYrsqaqg/GPbIxliXwWX8BfypT87GIGJnHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730507566; c=relaxed/simple;
	bh=IpSZBnCMKIcH6BQd4vnV3sM9teZF461FzbVk7rJAUtQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPLaXDyy2jdgpLTPghw4LPhGN9M26B27xor0dthhB6iiF1Z2gIfYPkP/3h2Oe4REv7tPGSZgTIL7sucZtclfJNydnECLK5TYHHZ+bGAT69qlYeYM0N/z5oz8OIc6GXy0M2EPwSpRAdVkfuAcDbmke8QdFP0BYuF0BqXJPLWDT5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGbBl9Hn; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso1651657a12.1
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 17:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730507565; x=1731112365; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IpSZBnCMKIcH6BQd4vnV3sM9teZF461FzbVk7rJAUtQ=;
        b=WGbBl9HnumT9dRp4E6bqReOsDDmREOJCzw00RWfSOGg+39HLqGty6Xt0G+PMIjF7wj
         u+5CLaoubqy+JdhulzcGgx6jy5rgEck6i99yS/rfVgZSAo2baraiLx0Uy0XTYiDjzTKP
         9zTJGXO1JZ4pf+aJNynbGPfOOf7W7u7YEcTs8Xsnx1Ji5qnp/TVkdJSyLInCHr3of948
         UBfz6G+wz1AVpNxBfj0s97iEfdtm9h0YvIIFcu6lCOQfi59AzVGKyyhsX6DjFyyb23vf
         XCTJtXxz3bDjXD72c9z9aY+JOIQQ2+EMF5mm1x7Vf+IkzJl1UPsjzGAyLsjECSAipm/Q
         ExGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730507565; x=1731112365;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IpSZBnCMKIcH6BQd4vnV3sM9teZF461FzbVk7rJAUtQ=;
        b=g9+sdDRMu43xfgfdcujDX06H3oI41wdylJ9U1fDwnCeqsFAK8SDm5Qu1aS+DO2Qhpj
         3zpsofkfVL80cARXWft4IgPjc3QJif75gC0wgXFWxR2d9zuhEVM++H+7ClE99qMHQq8z
         iq9mc5/sTwIL5T+PM/5BN+EnKXql9qi38IbnlOEOxHmz6hVd7MOLpNBl0D7lEkqg5zLT
         285LBjAhJftX8rkZGztf+yXx636OFFpiCsjg5J3Pt03xsZD8UJIlLDusTPtqoMQ3lV5k
         QeUg4vHWaATP1fQd7rZWS61wczjJxPOY99ZhLoe83oeyKUWVveyZeei8VEMPLP4tLiOp
         gWUg==
X-Forwarded-Encrypted: i=1; AJvYcCXEcNeEMtc/SkAnuimM9eqMrLZWV9dxOM1FHys6eReMUQU2URBi/lPEX/2YrkA6I/K7jOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7FB4NzgR+TypguAAf+V3Nc5CBViLP+MojX62q9gC/QjVKyeuU
	9qPrAnlY0CcbkoNJEcVYOSMeBW7zjs9rWU3orTINTVNAODArDr5U
X-Google-Smtp-Source: AGHT+IG+/2/duswVNRMQPqi7dJBxLOjHFRg2OMC+UJsgcyBymW1Xe8Lm0+fYreIzmeXCFdYIZbELMg==
X-Received: by 2002:a17:903:244d:b0:20c:bb35:dae2 with SMTP id d9443c01a7336-210c69e1c8emr316138265ad.28.1730507564784;
        Fri, 01 Nov 2024 17:32:44 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a6592sm26890295ad.166.2024.11.01.17.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:32:44 -0700 (PDT)
Message-ID: <57dfdda6a89819b65be8960c3c6953bb9b8ceed3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/2] Handle possible NULL trusted raw_tp
 arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Puranjay Mohan
	 <puranjay@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
	 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Song Liu
	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Steven Rostedt
	 <rostedt@goodmis.org>, Jiri Olsa <olsajiri@gmail.com>, Juri Lelli
	 <juri.lelli@redhat.com>, Kernel Team <kernel-team@fb.com>
Date: Fri, 01 Nov 2024 17:32:39 -0700
In-Reply-To: <CAADnVQLZ9oj4+en43UZVOOLNHfHGq2aEcR9pYwLKLeMh1rJN-w@mail.gmail.com>
References: <20241101000017.3424165-1-memxor@gmail.com>
	 <CAP01T75OUeE8E-Lw9df84dm8ag2YmHW619f1DmPSVZ5_O89+Bg@mail.gmail.com>
	 <c3f7ee7790c6f53a572ff2857433f534f4972189.camel@gmail.com>
	 <CAADnVQLZ9oj4+en43UZVOOLNHfHGq2aEcR9pYwLKLeMh1rJN-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-01 at 17:29 -0700, Alexei Starovoitov wrote:

[...]

> Hmm.
> Puranjay touched it last with extra logic.
>=20
> And before that David Vernet tried to address flakiness
> in commit 4a54de65964d.
> Yonghong also noticed lockups in paravirt
> and added workaround 7015843afc.
>=20
> Your additional timeout/workaround makes sense to me,
> but would be good to bisect whether Puranjay's change caused it.

I'll debug what's going on some time later today or on Sat.


