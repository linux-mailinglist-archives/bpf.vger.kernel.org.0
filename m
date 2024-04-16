Return-Path: <bpf+bounces-26927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823DC8A679A
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 12:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0172848DD
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 10:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D1C86AC9;
	Tue, 16 Apr 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYYSc3i2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278D786250
	for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261752; cv=none; b=dYC07jrcGpmPHqiRvdVeRYb7eMoTt5Tk3kUCsKvOSVfEtDszNxF2Lpx94As9Vd2W0bboJzYksDvdLRaG+SDCk8xVn2+TrvtdzSyRhQS3EFrfZ9Scuw8pneWzTcYtTY3Jwf/cOy8tg1NUzt6htPxz2CAEqqZ4asSXdoUfaWedD/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261752; c=relaxed/simple;
	bh=0fE/VMonhsMc1dW+XazZoo2OBOGVcuVypEOL9zkOmOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZ44fEj9QDge2yRSa4a3TO9Juh7pSwwoRy0fGSgXfT8fiiXKu6l6QMv+vkFWyzfTxmMTtiQ9upGlLcoSiTUIKrqtOIARs3lFrNcOWAoNHe89Ml8995WJuBsnYNC9UFTQtFI/g+x5cFNrb2lryL5VxmQeORG0VxTqbTk6mdwaW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYYSc3i2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so9187a12.0
        for <bpf@vger.kernel.org>; Tue, 16 Apr 2024 03:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713261749; x=1713866549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lf8bF6U681NwQZFKLhFXBr9aeMUC3JYfqtexpmqcE0=;
        b=fYYSc3i2LxYm0/B/rVMkBOhJn1ni5Nw9i4SkytuaxejK+BA5p9kpm3UHf8WhWItCOl
         S81wvM99uKa+0/HEqHEY3Gu0+JdolBfyRt4P70HJn+it5I0pa6kzMuhz/mogSWHcAyCQ
         HDxVigwunEVn1Z0rpsidzFqrTvsYPV7W/66kxbxpqbr+74Fw4QRGmgxBkhdIsaEVLWF1
         DfnnPgf/eWrVZPvfmCCdJdb+BLkivy/YNub+lF9F+ALwKIbHhZ5XYKiNjg3lff2Zz0x6
         H2fy4wTw+wbnDS6UOK180ohMBsCa2cwg+wovY+fPUU9l3SgCmHDnH1UX0ABVesROpYmZ
         cDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261749; x=1713866549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lf8bF6U681NwQZFKLhFXBr9aeMUC3JYfqtexpmqcE0=;
        b=moCanzkHn6KA8jYf4VqedFGV2NSFQRBjXtumwb2N8olE6NuJHa6dIxNuwFmOpq9ClW
         9p+Yn7aqf1BY2Tbu0XCzzc4BM7FiW+zMDeFYWWNHtaeMcQJKo5KNLCiv8RWiqSRAwisb
         o24sf50XV08/SypSq5AXUwWZXO1KWM1cZniL4t3BJHY7z3dngI1JetoeirupDGno28op
         8N4LynoVlkhWjnCVl9YV5G9Ro3ViE6TKdxAJP+oMwXAzaGS1DQaoGoDLwuirlKQwQU2I
         9EPQc0WHs4jxCprqtLKQE2+5ZWMomEZ4jeUq4EyC3TV4IF9zCauDmbllqMUDxHVURs4i
         YcMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnYEbr0/BVub8QJ83TPkVL/xIM5AlpsnIHkrOu/W+9zL4G9PwJ2luunI+pIpaAPBqe4OaETfhMb1NfIBtWSuqjS2yr
X-Gm-Message-State: AOJu0Yxmn37n+MyLtxso1br+VzCYeZv6/iXNclQWbbeEzk2AHNVOOKSP
	JpN8xbzFYgd9K+FBFZ7BEO8WtyMxqzRecZIM9cmtY1EznGuq2PEC4itpPBTFhqtttnr0McfA9AE
	U3K+SSBinwkogrKVdjTiI8HkeUyT0ZEcAw51qiWEY950RJzzT/Kmy
X-Google-Smtp-Source: AGHT+IE4EoyQ2SwBTr3x/A8c2To5OIJhKtFzI1BqcRUumFAcmElXAUCnXlNIdGq8GdgccD2jNAcInNjJ/ZVz64n6aNg=
X-Received: by 2002:aa7:ccd5:0:b0:570:2ec6:56b5 with SMTP id
 y21-20020aa7ccd5000000b005702ec656b5mr153930edt.4.1713261749077; Tue, 16 Apr
 2024 03:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416095343.540-1-lizheng043@gmail.com>
In-Reply-To: <20240416095343.540-1-lizheng043@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Apr 2024 12:02:18 +0200
Message-ID: <CANn89i+TKbGbmy0JJbyhUxQ9Zc_jj=EHv=bYXT5dUvQY7hw12g@mail.gmail.com>
Subject: Re: [PATCH] neighbour: guarantee the localhost connections be
 established successfully even the ARP table is full
To: Zheng Li <lizheng043@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	jmorris@namei.org, pabeni@redhat.com, kuba@kernel.org, James.Z.Li@dell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:54=E2=80=AFAM Zheng Li <lizheng043@gmail.com> wr=
ote:
>
> From: Zheng Li <James.Z.Li@Dell.com>
>
> Inter-process communication on localhost should be established successful=
ly
> even the ARP table is full, many processes on server machine use the
> localhost to communicate such as command-line interface (CLI),
> servers hope all CLI commands can be executed successfully even the arp
> table is full. Right now CLI commands got timeout when the arp table is
> full. Set the parameter of exempt_from_gc to be true for LOOPBACK net
> device to keep localhost neigh in arp table, not removed by gc.
>
> the steps of reproduced:
> server with "gc_thresh3 =3D 1024" setting, ping server from more than 102=
4
> same netmask Lan IPv4 addresses, run "ssh localhost" on console interface=
,
> then the command will get timeout.
>
> Signed-off-by: Zheng Li <James.Z.Li@Dell.com>
> ---
>  net/core/neighbour.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 552719c3bbc3..47d07b122f7a 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -734,7 +734,9 @@ ___neigh_create(struct neigh_table *tbl, const void *=
pkey,
>  struct neighbour *__neigh_create(struct neigh_table *tbl, const void *pk=
ey,
>                                  struct net_device *dev, bool want_ref)
>  {
> -       return ___neigh_create(tbl, pkey, dev, 0, false, want_ref);
> +       bool exempt_from_gc =3D !!(dev->flags & IFF_LOOPBACK);
> +
> +       return ___neigh_create(tbl, pkey, dev, 0, exempt_from_gc, want_re=
f);
>  }
>  EXPORT_SYMBOL(__neigh_create);
>

Hmmm...

Loopback IPv4 can hold 2^24 different addresses, that is 16384 * 1024

