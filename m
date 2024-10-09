Return-Path: <bpf+bounces-41317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C011995C4E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 02:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86AC1F24CB9
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 00:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669118F6B;
	Wed,  9 Oct 2024 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8/kDqQt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972CE801;
	Wed,  9 Oct 2024 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728433853; cv=none; b=StLDPrA4ofQ0oK7thULj8mvoFPjnBmRqvpMH0olsSBnFsoEGEQsuCxo8so7JOg+yF0QaNhCk2UiZU+TtDuyj4Kk8yH3Dfg834FDaJT3T4xJT19nazdWWbiyiEuQNgeZgkZsni5tDy0CMmeXyTMDbV2LZffPF/dBFMfh6GQED+Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728433853; c=relaxed/simple;
	bh=+QliM0UUrYZqHAIBSLYWldrbBlkyXYbK71IOcVVD4Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+Ur+pMhCzpVLmS1u5buTc57frmZkDg5pGdlgkk4wTDyEVdLYtEpmYny+4bufGVdiivIy8f7SvQkYS/r+aDTUprEkFCRjX8a6Ap50X1dV96I1awMSrkA7IRqayavYA1Lj1I5oF1wmKP1MREiJazxx/y0+FSERgTTV74ogA8jxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8/kDqQt; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82cdada0f21so227943139f.3;
        Tue, 08 Oct 2024 17:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728433851; x=1729038651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EEaU3HMo1APSS/3Hz+M+9yrYh3YnNIg1TIbpRiHaSM=;
        b=H8/kDqQtIzdebw+fEg9Rnm/NxZKBDQ52ZMPR265E17sTQRk9tIMewPXlgUSC3aFI9O
         +/GBFoaYtcwZjxcVZdj9zTwsxgGXxUzaWqLuzjLFrvJHXyvVG0sReQozZKAuNzJWZNET
         2m4rc0Gpglr3Ba37hlPagKuhzR/T933FNhwSsNz1NG0OtymhuGSelpuc2pYAGVwBgEQv
         G2FZ+i/AYk3y9eOfyv/31efj7x90Bqs2MyVecFeQ3y0Gq7FMbm7crvFksHFEgMR/GGJ3
         eNYr8gwfmONMNrNO+JtRNyulIpY3d4NWZ+tyaD9ErDvMHTztUpO/hiqcVGkUPAzen/qb
         vy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728433851; x=1729038651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EEaU3HMo1APSS/3Hz+M+9yrYh3YnNIg1TIbpRiHaSM=;
        b=MrHtZYsLp41FL1Ecc0ZdWei6DFPr0CU4wo38t86zxxgpguk1MHYGTmBKEI3Jg9PI2M
         eg9K8lhfxY25nn4GOP+myIj4MAm7GtsdsdMewYLFDw/FV0aJ3KpjIkIXY/UAYAfzyp0p
         HXNvDR9SLBzU1a5KU+8fxDEQk8PTwe6hcOvtipH4KVPgEr1ly4KV4UkMM6OQOUu8vh1Y
         p5Xv8aVGcNsMKU8qHM/Oj3bSDbc+IYkx+M4UJBfqgxFp1SMSU6k5G+JEeW14s/1VKRwo
         piJL0pha4JDDW4GGruOJcVxGdxq9lxIs+Dgzz/NvvdYMBdjwSx7GKvt0YXdK/5j8I1aC
         T9MA==
X-Forwarded-Encrypted: i=1; AJvYcCWtWsPtXKti8KG2n/ovRmfijGYbFVpym/PkvDLBIHjkt1mKYl3FIlISBYOvOL97v5PZs7uL3toS@vger.kernel.org, AJvYcCXMy7epZjLFeJtXyZtc9u5eae3A90hhzeWmE6qUYMDmKmXfP69LWIEoELU1kbECEuEfXB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpVQt8TZ1hkZapkzbuLLeV03JtxTLpw5NVYxpqLgkNAKzuKC5Y
	R/51OPo88gDHS8MEKJd6CZX0r+DG15gSIgaNgRK3iHuBBNIH7+pISIdP2+Y3ZL9k7G0OG2fhQ2i
	oErGOYS8ql7Mv7pbTwOst0CRmj8w=
X-Google-Smtp-Source: AGHT+IFTFXp7d4KBsLqLDYOq6uxN5XkSsrAh67sHwtAz3yCWoh/CVSA6odMpODLSnxl3LfUDFuzqhpI6reF0M1jIDak=
X-Received: by 2002:a92:c26b:0:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a397cf6a12mr7746925ab.7.1728433850629; Tue, 08 Oct 2024
 17:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-9-kerneljasonxing@gmail.com> <20241008172216.6f7b5697@kernel.org>
In-Reply-To: <20241008172216.6f7b5697@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 08:30:14 +0800
Message-ID: <CAL+tcoAASzQsBrNuDyS-yvocyqRVutaX4McJUu6rxmPGkvt4LQ@mail.gmail.com>
Subject: Re: [PATCH net-next 8/9] net-timestamp: add bpf framework for rx timestamps
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, willemdebruijn.kernel@gmail.com, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:22=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  8 Oct 2024 17:51:08 +0800 Jason Xing wrote:
> > +static bool tcp_bpf_recv_timestamp(struct sock *sk, struct scm_timesta=
mping_internal *tss)
> > +{
> > +     struct tcp_sock *tp =3D tcp_sk(sk);
> > +
> > +     if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_C=
B_FLAG))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >  /* Similar to __sock_recv_timestamp, but does not require an skb */
> >  void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
> >                       struct scm_timestamping_internal *tss)
> > @@ -2284,6 +2294,9 @@ void tcp_recv_timestamp(struct msghdr *msg, const=
 struct sock *sk,
> >       u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> >       bool has_timestamping =3D false;
> >
> > +     if (tcp_bpf_recv_timestamp(sk, tss))
>
> net/ipv4/tcp.c:2297:29: error: passing 'const struct sock *' to parameter=
 of type 'struct sock *' discards qualifiers [-Werror,-Wincompatible-pointe=
r-types-discards-qualifiers]
>  2297 |         if (tcp_bpf_recv_timestamp(sk, tss))
>       |                                    ^~
> net/ipv4/tcp.c:2279:49: note: passing argument to parameter 'sk' here
>  2279 | static bool tcp_bpf_recv_timestamp(struct sock *sk, struct scm_ti=
mestamping_internal *tss)
>       |                                                 ^

Thanks, I will fix this.

