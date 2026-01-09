Return-Path: <bpf+bounces-78375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81138D0C1FA
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 20:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FBFD3023547
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 19:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9035536405B;
	Fri,  9 Jan 2026 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbL+P9+V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F535BDDC
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988507; cv=none; b=mnVTsDM13sCK+GbZl2e3SNjpbnDz6Q9v1NZmKoahHyb/gnK64ZCNf7nku87L9U1xt2H3m4Dn5IqWt/8hPD0MWC+H4v3tsjIGdomCQ1m0TUSmt/WYSUWQnVD44OHNVrG4CzWFy2D5TvAc55f5LEv3BnX+pZKk/8weoCp8HZhJ8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988507; c=relaxed/simple;
	bh=MhElfQne+j9lBSOteOTAImcd5y7CE11SkL50jXSh4kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy5o7t7VCndrqH0yPEgosktmNEleX4mclBq9Y5Fj1FoMyP9ewDDPUUa8HGLJN3cSyCHpI5/PthgkayN+/SUD7gXc5bDIumFF9E70SiUI9gy4RlnTMov/FzUXdUtY15ACMH3kM/S5dKoYNn/nkXBa9cmZgoFrvMHA/8RpTNY+uLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbL+P9+V; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso30083105e9.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767988504; x=1768593304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBkPDONatTuGPl5aY/TAYsLDoFrF+bCOUtSOi52c1ug=;
        b=HbL+P9+Vu+AP48NnxDibxx1pXF0lVyU/Yxl3kHBFVXvXt7lGuTeRhuvz6Dq3pUJfIU
         vPBJZ6tRKNSBxsHUWkueuWRelxppmLfn1QYLWj/H7dOvNkQTJgCUyjvPaeNHBnCv136V
         k48RIdjk9bzj7nLQaCkr23M8CAsiKMuDF/uvJtsiwlv7gs4BIigx/XiYHg176viPJJFp
         XKS1vJsiRwl+enjWRxXglhF64zkuryr8GdlxAS+E7JyPJcuoK5F2TwpkA2z+rRkofSrF
         pazZ5MA+yAMq5s35vhBQ5vOWZt9x5SLp1M3uxcHs4YDbAHeJ241jBsmQvkldavv1jrq2
         xkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767988504; x=1768593304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jBkPDONatTuGPl5aY/TAYsLDoFrF+bCOUtSOi52c1ug=;
        b=coUqCtvel3BjN3kYaA4m5eISoSbMHrd3LvRSxZYtyTBEbobXsQbRDd+VFzQb8WUYIs
         Zf2dHOZXSqeCnHMD5VgX+FsEYibY0XHgH2cbDT982oyfATqsD0Z1ukr1Nq/iEZtCw1NB
         TA4j4Fdd9VdosvYW0E29f46GNldyEbOlKWumwgGkfTisz88Z8jM1UcCNTR3v1RAEVNcr
         HbGdtxguYS9RWgDadv+wl08lJTltgvWxDCGet4ROH8bw6OLV7PJQudLmk4RtrUr118tG
         bnxffrMLsGLqICg1S2CODQF3aAnXTAnATNXjnxqEPNkC6g1LGmGjrMoYDYYpoXXvqVJ3
         5m9g==
X-Forwarded-Encrypted: i=1; AJvYcCUbxCtpGmBZN5Txe8NA8hVtp36uDpkL2uQ56KxIkk/2Mgr7nHx+ZYQvdo9BWGCVXMWI9MU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1uTtJb0TDKmJ13sfBYoHAszBlAViIEghrBFqvljOReoCrjE9L
	Rje47BkECitTzMC6UYCdIkr9nHgzcKIh5qyK5q6K0kt2FiqhK2kV4ngJZfHAboycbWH4u1wcx33
	iiBH7sF5POg6jTB7AiERHw0HVIL1K9d0=
X-Gm-Gg: AY/fxX4DM7pA+DUs86FaZph2SNufRzKv4dagp/vBM4VgYSRYUFXgyyn5F3WT8YekHe+
	rtYODMZAu8apyNjuDx1HVJqcbAvWMguTRjCaiJ2kt5drFJnfGtPTkAk8ID7ZwqlqjUdVQCnSd9q
	3cz14KGJqWHDhdViocHZmpvVO37+aued34ALy+V7Cf3BTHRL4gl/3A8ryorf0/ARRO2U9dMN57G
	R7rsy3sYFUTiX1ZBUyFTxR7LH+lXFFIMKygxoWGoCXwmR4/M8PZDME3KAoM1c82LIcxdNShgKyj
	aZz4E0UO0f+iMZAlZMb1PYPdhgei
X-Google-Smtp-Source: AGHT+IG/EZRLQONxvapFw3RQndcGZicYBoimPYye5AFD2yn9qZIvRV/9nvD07Us9CjbpRX96Rtf3b1sKeTS6kQdLu+M=
X-Received: by 2002:a05:6000:2f81:b0:401:5ad1:682 with SMTP id
 ffacd0b85a97d-432c377c19emr13483755f8f.14.1767988503788; Fri, 09 Jan 2026
 11:55:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev> <20260109184852.1089786-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260109184852.1089786-4-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 11:54:52 -0800
X-Gm-Features: AZwV_QgQhMZNtddtaPEGfXd-u2d00hNwXFesS-EHcJxSG5vDE12dKLQL2hWx4Io
Message-ID: <CAADnVQKAfFe3=1-D9heEsya-v+bX-GnUbaqe_nYf0tkZNde_pA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 03/10] bpf: Verifier support for KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:49=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> +       if (unlikely(kfunc_flags && KF_IMPLICIT_ARGS & *kfunc_flags))

Please add extra () around &

that's the style we use elsewhere. Like:
if (!first && (env->log.level & BPF_LOG_LEVEL2))

> +               if (unlikely(KF_IMPLICIT_ARGS & meta.kfunc_flags
> +                               && is_kfunc_arg_implicit(desc_btf, &args[=
i])))

same

pw-bot: cr

