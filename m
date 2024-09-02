Return-Path: <bpf+bounces-38708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BA3968BB1
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0FD1F235F5
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6FE1A304E;
	Mon,  2 Sep 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsA1r4U9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA71A3029;
	Mon,  2 Sep 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725293478; cv=none; b=HRIdSp4gvkzSaPvtFj4NrIgVP8kBrepG8R36u/UH+u218imF6Im4TYRrimFfwWBso8gF5gEZnLZBdwGxF9dY4tRxhA9fb1r6JQ746s+eZt0kDccsziJuytMsUALbb66SxL6F0R1dVaIxSj8FmIelaQep1Bo4BaQx38pa/zz05Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725293478; c=relaxed/simple;
	bh=wk7mJjx0Xs0Q7CfUTyDNU+Eh3I4XTXvSQzWkhmeVDwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6QCZwnT/Tz0TapfWSE9foHPxImbE63lv8ws+URsj7JmmLpEnreaZTD7QiHvJdycY3kDw1Lfr+n58NYiGa+q71tV/wKUx6zcZkz7b6KDG1WKL8Ze/jHDh2CMEcTuPWj8M1egPk+Vb4plfxoh8cqh2kJ855lqzWbou5U9zbwYYOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsA1r4U9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d42c59df79so723053a91.1;
        Mon, 02 Sep 2024 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725293476; x=1725898276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk7mJjx0Xs0Q7CfUTyDNU+Eh3I4XTXvSQzWkhmeVDwY=;
        b=bsA1r4U9bkRj2ayNmnFpAm1V99ya6TFLF6NRGlB2a0zEUorcR/cwEfJmEQVsbSDxHb
         uA8h3G7KLfi8C+jL9ROyMRSceaqsNJZ54qJLqJxgaLFcYQQQSFA6LJ9WDaRsjLFR/ZXr
         LBRAZHILeZ/va75y7efmZRGuewtfGh66ibuuMOxI0bUtqEGgomGUAQ9PTXcMM/tHAjND
         tiQyJUHW5IvT8HuDCmqx1a3DsCu3/sPfTHJaO+0mNL9gMlzltA7M7ZfuCMUIVLaadAlV
         LHYHJZczAwhBH73S2nbokZ0k2pGCME/PUB9K0MvE2E1OrtllXwvyyfVO8PgZeOGVg9da
         xT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725293476; x=1725898276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk7mJjx0Xs0Q7CfUTyDNU+Eh3I4XTXvSQzWkhmeVDwY=;
        b=YqavNTCkHB+yW3Jk48yI6Z5AIjk8aP1Y9Lu0i97Z3VQrdOzWaSPf5dSAgIJHyghlS8
         aLMfzJ7umrHkuNz/nVi5NbSBFdaU5UCZ8Cl89QhUmxOuKaFUmLuemU5tdl5gpdyg3rQb
         /W5WnqHfF5oV9h3KA0fS6Rxt9k4D4hhq9L4lj7+XQcCa/LOhyNTH9Su35xcXrlYPBzRc
         86bIskU+WueoUL87LhErZz3/irGT2QGD71p+FukpWWw7ppRIwbzajCpiyCna1+GlS1r3
         Uk+GvHUjPv/H+meXByVH4nKkd2VBswP8UBOCl0Ztpz1Y8ZclMOz1DWf2vGqqF/X2p/Ck
         Oh7w==
X-Forwarded-Encrypted: i=1; AJvYcCUTFwGahhsmqmSk4Mq8/3SMZyVH/XMH0+RWLRL6aj4BmH+Q5nE103ooYNU4jhuBSFGEqnNNvd3Uf/qJNj/Z@vger.kernel.org, AJvYcCUxtVo88ntOe/T3lB2BAcMGuZRIXTmZd0D0y7R2m+kBrsat9Er1DLyXsuav0OFFcgMXJM1vPpkVJB2OeUei@vger.kernel.org, AJvYcCWB2ay0K/JCz6xf7hkd2Jxila6L+ZWrgOZPoG6UwEf6U1b+Bff0xM4Q0n0n9HOzC9CvfsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3wrxI4k2NwQZ+XGSFuxBbQsLC8i/vw8EkxlEN9H5KnZz3m6P
	lVnHQzX84weVtumsjmLmHlCaC8P4KTUiu2PmjUJ+oVw+YwEs2aKX+FBab/cOy/1haBmBifLUphw
	bC3xDauszHD462tnDPzSn1/5yELQ=
X-Google-Smtp-Source: AGHT+IHuwEJDhCc4s+mmfVcupdQTMg6prAW9eGXQCrQq50fzIiiapvtm80hin/j+dLtZBzIECbJiloot8yiAcR4eJR0=
X-Received: by 2002:a17:902:e303:b0:205:40f5:d1a with SMTP id
 d9443c01a7336-20540f50db1mr48362355ad.6.1725293476345; Mon, 02 Sep 2024
 09:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728125527.690726-1-ojeda@kernel.org> <CAK7LNARhR=GGZ2Vr-SSog1yjnjh6iT7cCEe4mpYg889GhJnO9g@mail.gmail.com>
 <ZsiV0V5-UYFGkxPE@bergen> <CANiq72khCDjCVbU=t+vpR+EfJucNBpYhZkW2VVjnXbD9S77C0A@mail.gmail.com>
 <CAK7LNARJjM2t_sqE-MePzEEF3D3SznNYh99F5bM003N_xGFpug@mail.gmail.com>
In-Reply-To: <CAK7LNARJjM2t_sqE-MePzEEF3D3SznNYh99F5bM003N_xGFpug@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Sep 2024 18:11:04 +0200
Message-ID: <CANiq72=3V2XYgmFME3kab9VMrT1yBi9nr99X6CMrqUjvTVMTtA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pahole-version: avoid errors if executing fails
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 4:15=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> Ensuring this should be easy.
> Why don't we fix it properly while we are here?

That is great, I would prefer that.

Sent v2: https://lore.kernel.org/all/20240902160828.1092891-1-ojeda@kernel.=
org/

Cheers,
Miguel

