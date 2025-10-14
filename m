Return-Path: <bpf+bounces-70947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D1BBDBC97
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 01:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF0042817B
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 23:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960662E7BB6;
	Tue, 14 Oct 2025 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kR1laidB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6FE2E54A1
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484277; cv=none; b=f4eS75uJzC7awlYcQ7JXeraQcpNU7UyKGRqMxpk7bsN4p00GoEuc6TGZdFj437AIQJqoXGCxrt7ZYf4k560XqLt05PuAHefOtGmAgEEWs330uYds0DtDo9HQ+rjRm1iTGXZFBGCQUyikV1Fx50IH8rvfle8WjihSzNgEKdaCKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484277; c=relaxed/simple;
	bh=kiJC0GGrjUGms2YmTUxbNpq/go1d7s+Ez52g8Z8xl6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OH4JmZvbJfX39yovHY6ULRjHZy20afDG527j9Ug7wkPvCmoMxNrXelnVecX9mRIjz5j8gNEj2LxMAH6D0B1W/k5+AqI2EoMAzoMwbaEFJMAHuLMtDP41EqK+uTF7uZ03/0ZNGnOuRoBBpgKUcr+EZy4sXePthHRpvaERO/KJKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kR1laidB; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b62ed9c3e79so3800031a12.0
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 16:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760484275; x=1761089075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7TIhqXV7nyCjqHrRl5BCr2/HD6G/fxdsV961HPkTjw=;
        b=kR1laidBWrNlicCne0h+JfhK39i2EwmEeCOlnrHNIwAUobfUNII5tXP7hPzuR6pzF2
         8HNTt+DrAzMkzS1C8I6lt6yJzI5Zdw3gB3JMK9pCm0XFulFg343RpdG8DdzSeE5M0dVV
         TVkXxu8IsTyb1VrkLJcoXm75wT77oIgETFUNT7kTgpsdvpV5OHDxc2hAbVI0ZtjVL7Co
         eDwnT2dbfsuzsi9EM4o7EQurUullVdsYPs3nPS7nzUobkHw0T+9Ul1oR1asjcwoZ8ffC
         vJ0lO69Z0cuaB1ph+ACPlJUqAFhvoPlfxz9XZtjF+h+OC/l4t0mAeX8NVSpwBDaiwsbb
         LPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760484275; x=1761089075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7TIhqXV7nyCjqHrRl5BCr2/HD6G/fxdsV961HPkTjw=;
        b=QdjDoq0V1S1i+xarRwS6/3Xrv8z4B7+jnGhDFweX6wKchsl7bL4CBuFFdSmDBrDwKI
         /4/NBF3OTSudVNS95SB846C3yQCJbk2kpuriD/MQ51uTOREgp3AEZXtYUbGDz8I8jPJZ
         o2XEcmUN3JTtmxRwZNsmltx3c1e2n7jLIxuE3PpFqS3KSFJgVXj3jEHIGkPjOeFMNN5q
         hfEBVj8Dl03KY/glVn20fWsKqCvsQJsQBD4KyZfzdsi0dkB9khwZSYaOjP26TiKyf6Ww
         gEv+dbStvZ6Bqx54ue+CKsc9xXgepxy6jkMK4b2jQ4YL+WFwQQXTz49o7oHmSS3HpNe4
         IVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOIRD4vPkHmL2M7BP4dz8Pkuz1EYLaz1B5dTBfjdq39rpBgyDLpIgCMsefC9CYpJpiLmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHdwWEuXXb9LJavmN1Y01WSUp+DAo/+p7deRjHwOzj7+duaGw
	xZrYePl7JhYpqAqGbpDKoVd92yUCsjco0lY4iiwv7LMP/RoFCgJ7EuTp7WaPu/nXchEhJk2xRfk
	Uo9wtMbFr41/773oD+n9QuySpyGJmMnmIejODqRRQ
X-Gm-Gg: ASbGnctwJubkUCZ7pAwu904KcOTq8vzcQuoNYXxPqgTzGkDi290zQVfw/aA8ASr5MGG
	6wCUh7yqrUbk/rVtFWtMbVsC5zxJ+HSqMz8T/cSuLy17yuyQiMYzON36gbvyFBp7FJk4ipv6FoY
	d35FH0LvbyM2D/RmlPVNwLHFz8gbYq1pfR+7AQj12AQyRxOC+MMz1uyFgC5IbqFQkLm8d2NOWeO
	x3N02OTvVcK7L9z4sCaqHLYkPt8fICHCvWqc97bCLeyNtwcQwAZIz77/Emhj4XCuo12zgxI
X-Google-Smtp-Source: AGHT+IGc1KM3mbxXZ6dfhiL9QYClCGPxZGiTope37uxNVhCU0VY54MLQNeSzqY8YVb6/W1JT70WAZjUFLSA5f5xXFQ4=
X-Received: by 2002:a17:902:e806:b0:261:6d61:f28d with SMTP id
 d9443c01a7336-290273ffe94mr306903575ad.50.1760484274713; Tue, 14 Oct 2025
 16:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com> <20251007001120.2661442-3-kuniyu@google.com>
 <c05e9b2c-ae5f-4607-821e-37f71b1dd1bb@linux.dev>
In-Reply-To: <c05e9b2c-ae5f-4607-821e-37f71b1dd1bb@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 16:24:23 -0700
X-Gm-Features: AS18NWBwtj94rvxpkhE-Wyp4KF2FtxfRgfjVzWlkKU22uXsiYqudAhvelk59_mA
Message-ID: <CAAVpQUB=mNuSE4dNWFHZjv2-R37z=2NkNmn3Nv8uwz_3Z-=Nbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next/net 2/6] net: Allow opt-out from global protocol
 memory accounting.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 4:12=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/6/25 5:07 PM, Kuniyuki Iwashima wrote:
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 60bcb13f045c..5cf8de6b6bf2 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -118,6 +118,7 @@ typedef __u64 __bitwise __addrpair;
> >    *  @skc_reuseport: %SO_REUSEPORT setting
> >    *  @skc_ipv6only: socket is IPV6 only
> >    *  @skc_net_refcnt: socket is using net ref counting
> > + *   @skc_bypass_prot_mem:
>
> While it needs a respin, maybe useful to add comment on "@skc_bypass_prot=
_mem"

Ah, I forgot to fill the placeholder, will fix it.

Thanks!

>
> >    *  @skc_bound_dev_if: bound device index if !=3D 0
> >    *  @skc_bind_node: bind hash linkage for various protocol lookup tab=
les
> >    *  @skc_portaddr_node: second hash linkage for UDP/UDP-Lite protocol
> > @@ -174,6 +175,7 @@ struct sock_common {
> >       unsigned char           skc_reuseport:1;
> >       unsigned char           skc_ipv6only:1;
> >       unsigned char           skc_net_refcnt:1;
> > +     unsigned char           skc_bypass_prot_mem:1;
> >       int                     skc_bound_dev_if;
> >       union {
> >               struct hlist_node       skc_bind_node;
>
>

