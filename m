Return-Path: <bpf+bounces-51121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC5FA305B3
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 09:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165D7161A50
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883421F03D4;
	Tue, 11 Feb 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJACzgLn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4A51F03C1;
	Tue, 11 Feb 2025 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262294; cv=none; b=hXQ1cs4C1QS1g/yM4LxJ93dfbAmEH1mxeY8tVoCOBQxmD2jqhEDAh3Y6SpgyFG/Ktwopq4hLZNt759G5LrXVGwt59M961+FdrslWuBXDjCC5jpW4tpPLzmwwRbTJy2yiSKwR6+lkyxnF5/eVMbzsBqAwj5ZyFJkaXl4BLbVh4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262294; c=relaxed/simple;
	bh=yM4yTu9AzIeqDLLA+9J5hzBkrcTTw8MubsNz4vj5f10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+eYuADQe31bUdhMromHQWBhIAgjo0VPV/1lHqUvxXV6F4CunIERa2DhgdJKgvSsD6N3BNp22tcz7aeesktyfZt7s5EHE5CUOfHYRBqEDCY1o7867iTb5VWq2rsF5w59aTbLpUt2eCotPVSqQKo+H4iQytfAkawpgSG55n08TnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJACzgLn; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d04932a36cso47422765ab.1;
        Tue, 11 Feb 2025 00:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739262291; x=1739867091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM4yTu9AzIeqDLLA+9J5hzBkrcTTw8MubsNz4vj5f10=;
        b=cJACzgLneuLhpP6MO/zdTQgccghBwjQ1+cAxxg9taKucx2inswBMqxUKkr5zxTOhlc
         1hd6paYOp2loieLBVN9cIloCG6JYzepJZgxkb71e2Y2+vistV8osSo23Pksxv0wYSyeM
         l8ZfTpsojdxTTz0jCUMj4VTu8mesnE/w1dmhWsR0+A1U/BvZ91H+dcHA/6H9NWr/HUNh
         LGmCwKM5ZLEHr2jwp5IQib3vwJ/Wbc+xJ+s1enAk7qvnJPvQave2zS44cUwhKr+SVQhR
         fZvH/ymVznWUzYmmJB5ER1RMiFjbXSUr8p0DIo/JFKxfhdnv6WBxyftmDJuaCsUbicD0
         Incw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739262291; x=1739867091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yM4yTu9AzIeqDLLA+9J5hzBkrcTTw8MubsNz4vj5f10=;
        b=iaQGqTGxtwD6aUDGE01TcR4eo1gMIq2vWGY6qEHWamNfxGEGBri/4jgQZzm2T3Yz3L
         DlIq+Nt6Y5IOd5sSc22Wl7ySjG3Qbe9LUeSYMoMoeVSELM+Va4n9oj9i9+4XB44YBDO4
         pnnsHk9XEwcPjuwpvpBD7Vw3xRTOm+RLegQhjLIKXgda8esssnKyWxypa8z3ymbsqpNc
         jyOe/8HszN+nOJNuhCS4WVW2yUjz8a57Bhz1FXYuHO0QWs8YqItkGP5gC31nwPCmT7Na
         cEGh8PIfnXNA4ywcEgRfyIEA+bFQhrA1mH1f4jjp+0iW2DOOQu8/x9D1f8Z2Ul6k6vpf
         Lmgg==
X-Forwarded-Encrypted: i=1; AJvYcCUtMDkK9ywh7vEuXmMxclwjhJsJfNlntjcOJpOJAN+IX78EvH3eOjZIryQP4dFUm2MbJ/Y=@vger.kernel.org, AJvYcCW5sL9X0SX5IjumRDtFUQAcjbLJR9fkUfFMv851nToS/xOPIMH777nlCZ6TKwPxyqoTEJKKxtha@vger.kernel.org
X-Gm-Message-State: AOJu0YxP1uVs20MbWas4vqzdE6QEw9KyzWxTg81Etl7mOFx8U8Z/jd3r
	AOSvtvLDRSgvZh29yoPWHL4vMi9SDwujY2c7gh7tVe9YU/q7je5mCZfCx5BwbS3eU38lX3vizi7
	Gtqzpquy0P0Jk7AvfATpLWodTDKs=
X-Gm-Gg: ASbGnct/3Tcdf5q6Y20oQWope+PM4md35p7tuAN/pDjugOGPsFG3y4cUdxraIz9WveU
	5oC2Es5Jpxzk7vMmoXsCxsNXOo6K6jiXR0HZzKBlny9DZXSKgV0OtyeobBNHJSKPCLO2Kr73N
X-Google-Smtp-Source: AGHT+IEeKgLVteP3YzhUtFi1M+X8sRBHB3OD+iBBf8Fqli+qCKqzWwCBV/CpzXmP7w79eGZTRPjaIDkZ7o3JdFvcSXA=
X-Received: by 2002:a05:6e02:174f:b0:3cf:ceac:37e1 with SMTP id
 e9e14a558f8ab-3d13dd4f257mr135523565ab.11.1739262291553; Tue, 11 Feb 2025
 00:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-5-kerneljasonxing@gmail.com> <787db122-d9d3-4ceb-b8c8-36ed9590b49b@linux.dev>
In-Reply-To: <787db122-d9d3-4ceb-b8c8-36ed9590b49b@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Feb 2025 16:24:14 +0800
X-Gm-Features: AWEUYZmSvcBJxaTGsiWKtEth1o6K44A-xORs7uzUlHL-QK103rd6b5k28jctxig
Message-ID: <CAL+tcoC0G0LB5ChzXMm=BGgjt=eGqf_jk89YyqQjydVWGuCtgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 04/12] bpf: stop calling some sock_op BPF
 CALLs in new timestamping callbacks
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:55=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/8/25 2:32 AM, Jason Xing wrote:
> > Considering the potential invalid access issues, calling
> > bpf_sock_ops_setsockopt/getsockopt, bpf_sock_ops_cb_flags_set,
> > and the bpf_sock_ops_load_hdr_opt in the new timestamping
> > callbacks will return -EOPNOTSUPP error value.
>
> The "why" part is mostly missing. Why they are not safe to be used in the=
 TX
> timestamping callbacks?
>
> >
> > It also prevents the UDP socket trying to access TCP fields in
> > the bpf extension for SO_TIMESTAMPING for the same consideration.
> Let's remove this UDP part to avoid confusion. UDP has very little to do =
with
> disabling the helpers here.
>
> "BPF_CALL" in the subject is not clear either. "BPF_CALL" can mean many t=
hings,
> such as calling BPF helpers, calling BPF kfuncs, or calling its own BPF
> subprograms, etc. In this case, it is the calling BPF helpers.
>
> (Subject)
> bpf: Disable unsafe helpers in TX timestamping callbacks
>
> (Why)
> New TX timestamping sock_ops callbacks will be added in the subsequent pa=
tch.
> Some of the existing BPF helpers will not be safe to be used in the TX
> timestamping callbacks.
>
> The bpf_sock_ops_setsockopt, bpf_sock_ops_getsockopt, and
> bpf_sock_ops_cb_flags_set require owning the sock lock. TX timestamping
> callbacks will not own the lock.
>
> The bpf_sock_ops_load_hdr_opt needs the skb->data pointing to the TCP hea=
der.
> This will not be true in the TX timestamping callbacks.
>
> (What and How)
> At the beginning of these helpers, this patch checks the bpf_sock->op to =
ensure
> these helpers are used by the existing sock_ops callbacks only.

Many thanks here! I will use them in the commit message.

Thanks,
Jason

