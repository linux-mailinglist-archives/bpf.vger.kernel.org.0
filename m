Return-Path: <bpf+bounces-70743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA4BCD80E
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47FD834B1D8
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0752F3618;
	Fri, 10 Oct 2025 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gCs3Xs3j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60216A956
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106242; cv=none; b=GIMh9jdbLIF8rFUlYD3NWIWBQzpDrAQGp+lnH7OzPw0G11BtYdS7+C7/7CdBYlLLnw6uEf5c22Pp5+HSYIA4dSRF7nlz5vHZBKGLw68DmFfZoeQfnuClF7u9WN310Pj/O+FpUAmA4k5H9evneCrAVgWi2aoLgrFYm3hcsyUO5e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106242; c=relaxed/simple;
	bh=728Pg4sn3XA6HHuow/YpDlQqrnEkY+wYm3DVQHrsDtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nj4syp8OZ9b+mbRYsrHcwlsmTaKJ+es6Qh/ovaU3RitfjN53aeaPcZL1Bb/06LkObiiL81fOCW86PQphB80TPeugIy6fVLAnNRS2FCJe7zzo2JncYUn7tTzFvATAs7NK4Wurs2PKmqZJgaKNDBs8t+cYMe3V7cZNXbBLAZ/jqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gCs3Xs3j; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-780fe76f457so16313657b3.0
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 07:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760106239; x=1760711039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ep8vBwkncVq2/IyBnp2z8KCBLEvYE8o7QIrmGoze/68=;
        b=gCs3Xs3jeXyGap8ELqMKwYCt9LvFOgdRd1sBWvHq/SQ1xXCEP7sIy+BehNcP9KVnd0
         RJ/pz17JXVV8RYbJIkrzv+SVlwm/TSaCSJsJBIC1LJfjzOqFPQM5nfxKSYqnUZAsvBW9
         ypYXAWFvul/ffm5Xshlj6LqeNAXQJ9tQGQ74W8VkPw5muRv7CTXczU/oD6OKsrXszPeU
         grnsoV+2XQ4c1o4Lnzo7POsVvopsuQmDEr9dxFvddNkooJlT1I7rHKJptFAF9TkMt9LX
         kTfYnb9/h7T40FNZ5MXm+hGb4B6/6z821ZhjUp+11DUiInqSvCGdeXOwlNZ9EuJ+Mcrs
         oOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760106239; x=1760711039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ep8vBwkncVq2/IyBnp2z8KCBLEvYE8o7QIrmGoze/68=;
        b=M6wPi7rzfg3MqVjwnWfHHLLHAYx982ZUygGPFOfw3uJoNyw8JNo+5uVaTf0cw2YF+j
         81yeoRu+ojYu6uSyveiSnejv6e6jz8lC7Ap7WsS8g6hfVgA+/nKFM/RIq3lvBaAjZZzp
         57RrdPuD1XyvN7pmGtNDH2P4wRXx+8hBUI3YCoan+Ccdo6DWuZO2k5Ucd/XRduAHcSX2
         vqi3w7DkMMyjj54VSyuh28bIlaY79V2z6n186ocDXzH3XkgI8NldcIFdXknU7kc2s+th
         BxzIxKi/SUAgk5I3cEJPDUINYHbeeLX0FEOO/3SQzc0DV9XtXT38GcBBTXOWv52GiI4e
         +7PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvY1jBl4bQ6XuEhN2PbArNHnBm2sUIDEBDz72OXFUu61lIpsQlMXfx+KAWI6QaB/AR/N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxrIk+FPNsSpu+2GGF9YNgUgT3Rc68FZXiWdiGH03d14nXfsl
	VKqht4IT2FvPysVTYyntpaMbvKx7te0MqCoBUtaeYcZi3Pl+/vhHB/kpyrcCKsOMfr517Txy3b9
	rt/gvEhm1ixDBSP2I4YhAzoim3vd1LJTxiiJtUg8k
X-Gm-Gg: ASbGnctTerNIhZF5KiJ0lALx2aF5RgfZdlbMvWiWr79Pp/3Kqcs2Qd+wPcnKqW7VTC8
	CcZsR2/wZ11hwKLhUF+TC1KgZEOJYfH846gbkPneMlX8lsE6bJdIdgyt7TbHft0cvGzQGb23MYu
	gMNIWaao2Jges0U/y9X2KMHP2HGvqYUW2JmvuJlhPYb5s28RWqZpDABVH7m8VCf1hAoLqpbOadX
	mIo767Nwsd8xRTp91lNrz37MGXPSeheMvtA7WFIjDEP
X-Google-Smtp-Source: AGHT+IFXUmNhceZhgJjwPY/VRP9jDGszxMq44Rpe9q3p1bI1zOHVpEFQvHQpi/tuqUftv/YFXc8YNDVTdg5ozI7vO+Y=
X-Received: by 2002:a05:690c:e0a:b0:781:64f:2b16 with SMTP id
 00721157ae682-781064f3482mr52227047b3.56.1760106238542; Fri, 10 Oct 2025
 07:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com> <20251007001120.2661442-3-kuniyu@google.com>
In-Reply-To: <20251007001120.2661442-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Oct 2025 07:23:47 -0700
X-Gm-Features: AS18NWDQf2ogI7PP3DWUgSD8qvpKvGg_Iu4VbjufziD2iUPvf_knUOrdlfOrzSs
Message-ID: <CANn89iJYv-ei-0yKzveLF7teyNpMUwTCf8YmOUzxZcyhowsTUQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next/net 2/6] net: Allow opt-out from global protocol
 memory accounting.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 5:11=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
>
> Sometimes, system processes do not want that limitation.  For a similar
> purpose, there is SO_RESERVE_MEM for sockets under memcg.
>
> Also, by opting out of the per-protocol accounting, sockets under memcg
> can avoid paying costs for two orthogonal memory accounting mechanisms.
> A microbenchmark result is in the subsequent bpf patch.
>
> Let's allow opt-out from the per-protocol memory accounting if
> sk->sk_bypass_prot_mem is true.
>
> sk->sk_bypass_prot_mem and sk->sk_prot are placed in the same cache
> line, and sk_has_account() always fetches sk->sk_prot before accessing
> sk->sk_bypass_prot_mem, so there is no extra cache miss for this patch.
>
> The following patches will set sk->sk_bypass_prot_mem to true, and
> then, the per-protocol memory accounting will be skipped.
>
> Note that this does NOT disable memcg, but rather the per-protocol one.
>
> Another option not to use the hole in struct sock_common is create
> sk_prot variants like tcp_prot_bypass, but this would complicate
> SOCKMAP logic, tcp_bpf_prots etc.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

