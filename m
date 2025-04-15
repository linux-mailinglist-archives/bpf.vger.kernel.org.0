Return-Path: <bpf+bounces-56002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19868A8A696
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 20:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B3C7A5DE2
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 18:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7E922CBE6;
	Tue, 15 Apr 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtOsYuse"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7222A7F7;
	Tue, 15 Apr 2025 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741042; cv=none; b=YdHXvVJWIjBT2mgux6+UEvesEnDV/CMa4x7Lgx6+g8RfsHSledosN+nsJxg0XWgZombjG0gOCEP5wHlXB/YJXXc50DDyVXWG34HeHbSLRMQB1xO+AzO6HqGsbnY8Ggn6i7dffIxX0wsLDFCzLeDFj/Xw/VR9j7McnSgZgG9h2aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741042; c=relaxed/simple;
	bh=ocZJph6L/u2MKqtDpqm+Vh7hmxUOZLPnUYeuK1ve9x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfowyCkpK/oDYQ1313UXTP+15y3l4Wc7M90Dx7lil0mYypCgdnFkpz+Wn162VKBdDAvvYxeF44FwrAKoLcF43B3SQVm8P0GNcgl1K3RKHV5aZ/68frH2n8GRUmQj2Ebx0FtTHUJZfBpadGL50q1f1IWYFT0sqlJGu2dfc8a91ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtOsYuse; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ede096d73so41897615e9.2;
        Tue, 15 Apr 2025 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744741037; x=1745345837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67Er+XwXxGLlCnVI0d56CAbjX4LYeyJfbgsjLuh/a0E=;
        b=EtOsYusecOYZ3DxoE6bdj+IllhWNsyW1L0yCkDOCmtRk2PdXvUj4wXdMe7cmQa7UzZ
         Tfvp8feOoN1ut9iNtdOOjf4hVsSHJx7tzziD5J8Of+OmG1cbXnrmt7GHcky7MdB8eCrT
         JLd87k0XfLSa1LkRtlC93qh6MyxtasBHflm9tm29EsW7zIJk7vw+DRTd3f7kBH9F2iD5
         7mV3xSoKupIkka+hYoR7hZvImXYgEo7+fJ9sD+0Y5Tw7G2JjoHTodAgg0wHO0UN4AW+g
         vA7RwX86+TaVt3W5bKvmVU/XTrQrWrkpd2oSBoABjhjuQvwmyDMcM9amfeVN+Ca2MgL/
         Nb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744741037; x=1745345837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67Er+XwXxGLlCnVI0d56CAbjX4LYeyJfbgsjLuh/a0E=;
        b=phJNA6KntKM+jwk7Hh57/b0lCAWwQrkAsj2IS59mvIAWa+uwNLHgf8lGia0FEdV6ob
         59l8Cw8oudhHR4vRkz5pUIJYsVJ8lUAfXhsgnAO1kUcXS1WRb+R/Z1tMzhBfqnJku8Rk
         C3HILPJ++BRGjxW3y9CggmJiuZbKetUurvIUQMnfDmGXmnPypE6C+GNvCJu0/hz+QwD8
         kgFJusTA5BWMwzgM0nTEVfYui4MDpkUyzkR/zfO0zCZ+IKuOAoshNAbECldDKVne7P2I
         Z8mWsgVof+i6yJBgcDHKystKLyzbCmtvxyXm3lo1jvfEoKWyMQP9/DrVZE6jq4JbKdND
         OEUg==
X-Forwarded-Encrypted: i=1; AJvYcCWOLERdf/0S8H2I8jWCSkT0sUYRGtX0VeFDvEGmmVHHwQGpOXgnvMrJYSVi/nJatJ+kR84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk3B9HjcQSi9d36OkeIUdUs03Ic4N75SnvF2ZNv8zZ/fSJXIkm
	g6/kxIAb6iEOHk8OAk26GiIaKshsXRfhXhF3paQ966d2DNw5QRPrbCCN28L1DPvumP+YzTqf8IQ
	2H10GBIGzGNOsv+714Kbqw+O4+g0=
X-Gm-Gg: ASbGncsYHclYZ/kZRa9ecQjwmpFeu2i3xuojpHTH4Jh1NrRm/Yk8BZ7IyE8u5pb+2Te
	7CB+Tlgzd4fw1DDh4xR6iRab/PqlMF03xa0DaOUvKlG3Xsoc2A90Nhob2KfUxTLj3hNTem1gTUs
	cPMItGMpwy0FcKYizS0FWVnLuaNpRojbMyj8bb
X-Google-Smtp-Source: AGHT+IGjXUU+FWaYsIt2bC7ab1iLCywdS1jGO6qOlpOLSwxmnPADfhfvREYDAL2blyOXLy4l1c+ebYnERKB73ONZWN4=
X-Received: by 2002:a05:6000:420d:b0:39a:e71d:ef3f with SMTP id
 ffacd0b85a97d-39ee2729ed1mr400036f8f.5.1744741036515; Tue, 15 Apr 2025
 11:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415173239.39781-1-justin.iurman@uliege.be>
In-Reply-To: <20250415173239.39781-1-justin.iurman@uliege.be>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Apr 2025 11:17:04 -0700
X-Gm-Features: ATxdqUHki9UjGURAVBx6GgD3zroPc6PGRy2UZ-sOY23ukpl4qvcO0AbDRwBXAU4
Message-ID: <CAADnVQ+podS1f4taEg3tFdpp3qDEKmSs5XAU7S+u8-ztMMp=wA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: lwtunnel: disable BHs when required
To: Justin Iurman <justin.iurman@uliege.be>
Cc: Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrea Mayer <andrea.mayer@uniroma2.it>, Stefano Salsano <stefano.salsano@uniroma2.it>, 
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 10:33=E2=80=AFAM Justin Iurman <justin.iurman@ulieg=
e.be> wrote:
>                 goto drop;
>         }
> -       lwtstate =3D dst->lwtstate;
>
> +       lwtstate =3D dst->lwtstate;
>         if (lwtstate->type =3D=3D LWTUNNEL_ENCAP_NONE ||
>             lwtstate->type > LWTUNNEL_ENCAP_MAX)
>                 return 0;
> @@ -460,10 +469,8 @@ int lwtunnel_input(struct sk_buff *skb)
>                 goto drop;
>
>         return ret;
> -
>  drop:
>         kfree_skb(skb);
> -

Don't see the point of seemingly random cleanups, but overall lgtm.

