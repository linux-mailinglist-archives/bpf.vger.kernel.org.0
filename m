Return-Path: <bpf+bounces-35264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45F93946A
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 21:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF5E2826A4
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 19:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3ED171089;
	Mon, 22 Jul 2024 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsgyjRlR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C91CF96;
	Mon, 22 Jul 2024 19:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721677554; cv=none; b=fG/Hh3IumkHvdqKO7/QWpH3cQbmY5TBMGhoT7Dv01wLF7w4oLTNBX67BzYY42SFFYGE+Mc8hTGLlBjeVz3G0YJbPp/BORnwm6MzrArsqPu6TyugHur7hyMNcmbKKaW4NWzcZ+Srt1ZyT11fXczT+09T9ekQFUz9ACzdLNTHXCUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721677554; c=relaxed/simple;
	bh=rpdx/mWodmZ0SquEDYR1BpH3cwDFg+Q/X5PmcRsZPB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZNpK2dqoCTwjnUQ4US72o7lKDSHT2X9UL77B3Jfofj2baeRyP/cFzdzq3VrFIQOoyHLbrWXb9T2kwVWonwg0YQxeKjSKwreF8QMXK2rrwiZDLbS5oDKhQuKqD8+ofaZ35BhvsX0X1t2u4wAFb9OKPzVxzr4LCALSZ0XfFHZEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsgyjRlR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4279c924ca7so34277205e9.2;
        Mon, 22 Jul 2024 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721677551; x=1722282351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smN6Rc/Wck+72a9Qb+Cz7GteVisu31AXXjjg751Q1qc=;
        b=OsgyjRlRBDT9rvY4MwZct6fASdHU40+ryp0DMRs2fsnuktJYphAp/gZrGwS9RVHqmc
         HfzJqJfQ0FAoevXyQ9m4n3e6w00aXOkPmmKTWZn6A1F6tG7prrb6DEW2EJzzaQ5EbKWn
         K7p+s5xMad4+R02MIOxFCKoqWxoImyfjOeiPiWIKOnOub8SAiZT9FgtdQakSZH3iqgzK
         sSr8qEAP3lIyFMX3CyReu3xCOwlaKPd6z+/pgd5z1A3Nv5NZXNFRLHh5Oqe7sVTdcFjQ
         iGG35iDaGWpCuHczQTNG5/aZhgy4DmUAY/L2fM3YzisMvXR00P/vpKb/w4EhseUHcO/Q
         CtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721677551; x=1722282351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smN6Rc/Wck+72a9Qb+Cz7GteVisu31AXXjjg751Q1qc=;
        b=WOE+E/osEVl9axC4OUw2NBwB6fDQlltbO0E5JBvAyCIMUBt98z6p0yILIH1eiU3ekg
         NeLhJichR2FrmE4Ub3s/W86TuRJMF+uKPeaIaV+cDWAF7grYhYOP58TsDn7k1cI+m1yy
         30aagS5siV+uPRbteAjUKwz68iu1nObVpBRuYMGcTH83g8szlUzh440qekUgNCh5vTMK
         UkHjgYXYMi3wDFm5O7AqEY3/D1OoJbrPI7X6PEZHd39flO/4e6i0XLLpMKm5TCF0EMq+
         3bxR34/+IupEuNMypndbOr8sWOr1QWl8b6ZXPfSrCW2xP1Qr2MstwLxFfK2JN2d3pi/x
         cBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBa76Gs6SKMcz0HGM+FVPF+poTCJKNBY5A7ab0cUCpsSXojRKzjFDUbfYJ+pFmH0uOYIZdY63/STMKE+1dbA0hib7FIUrf9YIH3bg89Xb6T/eRSB+cQlP6VJQuVB+nifU29YadrVrdCMjezitDv/LAzNMvpWF1Oqg+
X-Gm-Message-State: AOJu0Yxf5bYf5y4zKbrbRy6DTfa4sm6nUWbLdvAYjjHWIfVfN6CXVplo
	RBC4i2hBIeznInDtGwuvSYWku0bC1Z9cUa2zLNXPVLrZ5RAJY7TVdCexvrdHlPud+A5BdtHupub
	/OgmIFClRrISPqKSCS0fTll986Xk=
X-Google-Smtp-Source: AGHT+IFB/23bqT5w6z+MqT9W5rGgUi4Zxideu4fV6SpRq3sISzra3CZorN9+OPY4XxheppI8c569qtj9ZvD2tNRfOys=
X-Received: by 2002:a05:600c:3594:b0:426:627d:5542 with SMTP id
 5b1f17b1804b1-427dc568ee3mr45870465e9.28.1721677551330; Mon, 22 Jul 2024
 12:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <005ef8ac-d48e-304f-65c5-97a17d83fd86@iogearbox.net> <20240722135253.3298964-1-asavkov@redhat.com>
In-Reply-To: <20240722135253.3298964-1-asavkov@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jul 2024 12:45:40 -0700
Message-ID: <CAADnVQKE1Xmjhx3Xwdidmmn=BGzjgc89i+UMhHR7=6HupPQZSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
To: Artem Savkov <asavkov@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 6:53=E2=80=AFAM Artem Savkov <asavkov@redhat.com> w=
rote:
>
>  bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *o=
pts,
>                        u32 opts__sz) __ksym;
> @@ -745,7 +756,7 @@ SEC("tc")
>  int ipip_gue_set_tunnel(struct __sk_buff *skb)
>  {
>         struct bpf_tunnel_key key =3D {};
> -       struct bpf_fou_encap encap =3D {};
> +       struct bpf_fou_encap___local encap =3D {};
>         void *data =3D (void *)(long)skb->data;
>         struct iphdr *iph =3D data;
>         void *data_end =3D (void *)(long)skb->data_end;
> @@ -769,7 +780,7 @@ int ipip_gue_set_tunnel(struct __sk_buff *skb)
>         encap.sport =3D 0;
>         encap.dport =3D bpf_htons(5555);
>
> -       ret =3D bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE);
> +       ret =3D bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE___lo=
cal);

> Casting won't work as the compiler still have no idea about struct
> bpf_fou_encap.


struct bpf_fou_encap;

(struct bpf_fou_encap *)&encap

works just fine.

pw-bot: cr

