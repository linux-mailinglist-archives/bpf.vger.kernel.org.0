Return-Path: <bpf+bounces-45811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2F89DB234
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 05:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B44282710
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDC9126C08;
	Thu, 28 Nov 2024 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8r8zTYg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE016130499
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768477; cv=none; b=qBC0X/+S86WUtugWC+JGBM1cZZdfBMFfm7cvhTMDf4z5vFOSfZ35FDJGvU2tEJQRZ0EzLzXJ/ZGS80jVbGC+93k9gm+7qjxyyBKf1pmezxyyRPNuTJBkq4Apop7czhT46wz/DGrFKcGC1kNxgSb1o89C/D7ZFAi6uILjLPIi++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768477; c=relaxed/simple;
	bh=20pP+eh8s7POfgUe2p5N2AyVVCAImYGYFxRRQA/7AsA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tglldz0C30a/G3bWugQGh12sQ6wqVPvE7i1Gf/Ga/GS7mem3NPICKd+H51YsTYUm6xt75vB4vB0S3+OKapiMIKxbEWUDtcR5JnQ98OV880sa2Zx2VbFiWazfx2nC/gM7CD3V6Yn5JIHL2GqxhZvZsVvVP0hnhuVHWvKUuJI2AdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8r8zTYg; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-212776d6449so3833445ad.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 20:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732768475; x=1733373275; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=20pP+eh8s7POfgUe2p5N2AyVVCAImYGYFxRRQA/7AsA=;
        b=Y8r8zTYgDGLFUq5Psv3bLqQIubI2BiZXXaC3Q5CPd0RfiSkMNbqfuqcMv926rtey9p
         KYbYUX+wN5ejbm47TyZg2dLIimuNgJE7m6RQQLovuu9fDe7Bh8BJHODp9Q1MILZTELj9
         40LU5583qi16KDsQauCt6dZPlgsQynfp7zxEWhP92MzqWzz39CqJM3u0Yn08Hj006lWw
         c7PXF0LdgQwoWxKvGerSe+lITFZouHhVQbBNesg+wTxnB5kdXSH7VleulQCvnDq09I+9
         FoNHMmdBkVKzh/pb4zOZrRj8YI8o1vAAQ6IsoSUWWAj9+WaomvukxG7ihKLJaSNauXOw
         F0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732768475; x=1733373275;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20pP+eh8s7POfgUe2p5N2AyVVCAImYGYFxRRQA/7AsA=;
        b=cRfsAQabv6fJLHDJR+0PCkl1JKzbqjSuIfQOCLn9PNw0H+JboTcJ7YRRaQuPUbzlg1
         wc6vn5bjWbmsOj+CjhlJk/GiMEPTqWMzUTfSu0tXRcEC6GIuQycY42/O/aNeaIgJRYvw
         Idf9eLQU3qMJ9odRdo/uzqfoSDUXZCkse2S32LpvZVFijIrZcbpfK7NCm1eS45C2Yn9+
         s2Cnh81AY6yNkiD/mexzHZmkKQ7ByqTUk8fVVb93wXwz54ETo+1MyKvGuLPstRuGoD6l
         Qyxd86aDS1RRTd+pUm00r0NceSsnHwgKWvSGE0/4lAYuy4BBVqw7Us49krS5qYS1udKn
         AlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeOcXKHuiEKg+bu1t6MYgWU3+ObqjP68WAfx344uUqUG7qBAALFl2judvja0u09lC8krY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Kw17otk1iEDZCmvTO78YxIXLOdZqdUT5r6bIgLDPcmOJ6WWM
	k6K/CaL45f63qJbpdklZ5n7pCWNzQiFTSjrd3obvjwC21fG1C23L
X-Gm-Gg: ASbGncsmasMJSI2w079go8vTK/0xZI4pUysdK0+hCeWg8L8WNz4GxytEjm5C4XFvF00
	SrvAvHoXYK4ab0W6fzXMYL97pZv5lQ7Tf66RtOrLsk1wNF/yiHa4PVC6bRztElaMkQHOqvSAUd6
	VSxT/lxSpvvUIm541rHIu7ts6QaSApROdtKNeM0HUH4jumSHBiWjoz0ib3h/WqFO5+4c6E+//yA
	jmMCTipGvYtSEcYy4bMpRibG/jSxhDaIsTeaAswB3cJYa4=
X-Google-Smtp-Source: AGHT+IF1EV1R6de86ccIc8MNcipckN2TxZLkSDBbAS5mS/VOAf9gispEvKkjdf+6F7CDCb06Wcl+AA==
X-Received: by 2002:a17:902:ea12:b0:20b:b40b:3454 with SMTP id d9443c01a7336-21500fe71f9mr65143235ad.0.1732768474999;
        Wed, 27 Nov 2024 20:34:34 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219063afsm4047625ad.87.2024.11.27.20.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 20:34:34 -0800 (PST)
Message-ID: <0f52741bab36a5f2c4d1dc9963014a7b9d1dc0f5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/7] bpf: Improve verifier log for resource
 leak on exit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, kernel-team@fb.com
Date: Wed, 27 Nov 2024 20:34:29 -0800
In-Reply-To: <20241127165846.2001009-6-memxor@gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
	 <20241127165846.2001009-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 08:58 -0800, Kumar Kartikeya Dwivedi wrote:
> The verifier log when leaking resources on BPF_EXIT may be a bit
> confusing, as it's a problem only when finally existing from the main
> prog, not from any of the subprogs. Hence, update the verifier error
> string and the corresponding selftests matching on it.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


