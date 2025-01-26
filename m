Return-Path: <bpf+bounces-49829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F42A1C852
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 15:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EEF3A64D7
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71635155333;
	Sun, 26 Jan 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="H2WWdMxT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37F149C55
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900736; cv=none; b=CKQ8CKcbNpx0U14YzStPp0+SeusA+Zc/qMImEfGfrSxuTgWNMpppXlITuekqPdiNpIWL/EEirZ9/uSF+A4YlLZVXEIUH/XO/nnt7UqHUlzkJloDAluWIn7mO1jnDTzIhcKXb/QE/AAGPb/yyXeMJaOHOH/xEzuhpMzR72jkKb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900736; c=relaxed/simple;
	bh=da9YorvvFk4UIYAefIerEYb4xCuivSVbVedCiCnFYfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7J9epO0wpNgg0Z5dRAUiSYVmoNdHkkbKeEFppFzOrevhwWsS6rKPlmnAaUAyiw9fFsEbU0DzH/vBiIxRMGPWAaUkZq/RWbjVsWp5EbUeGUcvArz5JVkTBNs6Fc2LPYT5QOsFJ6gzYqTmTaVhjaGwdkOr+jkCatHZoNGnKwKfMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=H2WWdMxT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso8030269a12.0
        for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737900732; x=1738505532; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=da9YorvvFk4UIYAefIerEYb4xCuivSVbVedCiCnFYfA=;
        b=H2WWdMxTEBWu8YzCIX7u2/9XZXqzo1mKYjwVtSD3h4/dByN4Z6N2UrMXOqxljunCje
         Pqh52tYfxCAWMjPAeGKyyGiJNWpmEwGStY9IMMTuJnR7NuVVQboZTdD+xrquWP7rs2yf
         U0j0tEdnklmUatLiNIx/OGwo1mgYooIBdN3LeeJEDJ5pD600aUBuwLsa/WRkSB9CKRdd
         No8jyYnX/TWy747D808Bo8tsxezlEsWuJ7d/6mYbg8+pQy39bsesQR6+cEVOensfdC9L
         GbVB/w1wrt+4nvBs1BkRlEtDmbfc1f2HUZaBvvbewkFR4ZQYYbsyhibrrHZN4nO4a+kX
         JMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900732; x=1738505532;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da9YorvvFk4UIYAefIerEYb4xCuivSVbVedCiCnFYfA=;
        b=FVtkz3U7iXWuHIwNI1eXapJ/J8maw0wCdHUxGjUPCFI7CyhW8afLIZg1yyXva6OiDg
         w4WBqXixskbscz9/rouJu2XzyNqR4uMyYtlCT1ERkpwycHr9rXAAWxyiFIyLt22G/eIk
         S0LL463Fif8MhuX1LfAJBSL9fcwArrEOrz9hRbRb7dSXVbAPFjtHghlXsWgnABrMvXHz
         dy6EQgH1RN4JtC1VxB1ry+rdOqrQfLoDy5WVWWaaXP98T9ki/+u3rT2Qcr5pRlKkQZ67
         NWpHDSQGuaJ9yDgnf8hgk6rGE4Dwk2SqnQonfU64WZYyG1CHSHK3qDj/JPSCVL3Ke7Pl
         uTRA==
X-Gm-Message-State: AOJu0YwqTNsu3BkAjKhl8FG2Y22AXRi6NJrVAJwV47oOkrIksb/lvK1o
	Lv3HKBgu6MJA8jKNVJxkX79IugDPlvy+u/3nYWGhcI6ImI3aUzbPRiydxepyLNk=
X-Gm-Gg: ASbGnct638AiecAC2yopRDwGp3ImHIf3+2YpLAyi9yu4K4Q0nLwZUxI1Zm/ILf+UJdY
	ZEAIkufHJSjb10/ngCpUiYkn89eEyWKX9+b//TF7qJW0tqZRyzrrRlRTiPZ51X0eZH5ZTKscY5D
	cc40nhwQ7Pxw8thteEUiwDyUYb7A+LCVLVuLE59o7EuXnUlEPif1Vri6LIZOcjED8E5+r24uVL3
	hQd8i3MAcL1ejQtaGqkZp6oIo+dwPr6audUkIqHSlc1GtAzT3kHfeIvpFxbdgCdSGn+tEm4/Q==
X-Google-Smtp-Source: AGHT+IGBKFasEkaDtZZ5CWcrV1Bxnz3k+ijYYsGxkH5Dhoqoj3FM7YBEen0VjurFTCvcD+kWOyT5Vw==
X-Received: by 2002:a05:6402:3509:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5db7d2d9958mr37213488a12.6.1737900732189;
        Sun, 26 Jan 2025 06:12:12 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc1863a1fasm3986231a12.37.2025.01.26.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:12:10 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 4/5] selftests/bpf: fix invalid flag of recv()
In-Reply-To: <20250122100917.49845-5-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:16 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
	<20250122100917.49845-5-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:12:08 +0100
Message-ID: <87frl5d5qf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> SOCK_NONBLOCK flag is only effective during socket creation, not during
> recv. Use MSG_DONTWAIT instead.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

