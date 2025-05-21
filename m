Return-Path: <bpf+bounces-58631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902E6ABE8D6
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 03:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8CB8A348E
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB0114830F;
	Wed, 21 May 2025 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWuP6I29"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EB381BA
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 01:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747789650; cv=none; b=LmsCTI0cEXiunZR7y85WXelSEaxk5R+2adhqogwXa+98aIi8iRS07P1FQfgZsG34JgN4W3VTf/swxYwPqI8Le7iAm/49gC1iTQpbGWIdi1XpO2mTfkWNF7ECQCBd34IQgwlxDXCUItybBmiPM7uYcuX/OyirJkHFkg5yf9tY/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747789650; c=relaxed/simple;
	bh=VD+r9HjeTnN8Vkgm7CFS3ntG6kPd9ZZCB/Y7pg8pgts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4ZaoXC3lzj5oK3M9oI/O+eOboXS8jFu86/0+NNwyXABkE/ipsdwatxDPimjzApnsjttZzQeD25E0fjMvSNK7tKupuRhFPycXnosOWG9kygd7/kZmNSTfkEXfv4Tk0XqA+6vWY8IrDUSQuTButiREJWgjwxrg2SIW3bzX79wzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWuP6I29; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so76583945e9.3
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 18:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747789647; x=1748394447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYeHP6battmahxDSs2HdNqIbhXYVd16XCi/geHswjRU=;
        b=OWuP6I29OwwwmyQifvlekvW88y2KH1kwrsdqbAWvjkLGBO6Snub/REas6oRqO3Onr/
         hLVwRq3UuSurjosibscsiwnc8vFxPLjUcOsmp/OMI/WzJIOpLXLg8c1/omuQJxie1Ywt
         qBgCh5Et3CrgUXG9TZ2sQWlws6Xx2jqqQrb2X61H/Uv5AUs8TJTVwt2Hv2Sx3XaSdVbw
         zdSBpOyG7SuOULj0spomVRfDw6hHlZD27JsQdtopKYuzMyHYh/LfRF+XrVvmPDo6klWY
         795hJqRl4weTucJy85vufrISGnNAj3SBY6+JYxSAJ25qNPNRwLZb4LYzEJMLXlBQkL+L
         94QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747789647; x=1748394447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYeHP6battmahxDSs2HdNqIbhXYVd16XCi/geHswjRU=;
        b=jLlHEtBbAhSvW+vg7VucYcBcQzPIwm85zS9MmioMJYqf+hQwQDX5ndXlMpq7DVIK7N
         GL+iimy4Yp4f+c5zzZkGGPW2f9X37suhrvZrwn5fJYqlyVV577HSoa+pm/BFJYZBYQs2
         xOe/ecHaKd+W5wcyT8u9ZCe3Xi8E2XsYsQJs6LdcAsIfXKyWGGj/QmddRZQmNqWa7/XY
         yhnZQimmZW0BIzWezwfMrXOAFJrDHLLUBs+2qnw+dar/gKhQVN4vPIFJo05VqYg3j3Gc
         A1/H0JRL1NcZx212ccLtnddUJyLDgQXPAby64lXCaGoAyGKUgUd24BE8EkadTcNda15G
         romw==
X-Gm-Message-State: AOJu0Ywup3OK4Srb7WqQTZEfb482nhGaPvQ+vRmqLsQxRMz9CdUrW/CE
	lQFlFZqBM1guOu5mngQh02hgMdsTK+cWe5TJi64+fHpM/029VMy3hUykOOgBNAPrnuLcQN2iel7
	ktfwov9kPrAT6pXmHhas44GAeh9jCSmUa2xMu
X-Gm-Gg: ASbGncvkEwMAHbFI8R8Gm4AoFxPZEto+yUSyVZwy5q+w75VaW21nDdpHidsHHCu8IIF
	Vrdvbuo9y1BCSGnYZ5UWSO6bHjDRAPEOTmAaXjUWaqoRwnbm9qtiANqV/N2reqkL2519MAJ7dd3
	9kPvbKWYfy11wUHshXFqgrYK878VLsN6f40Y7tC3G0aI+lmqkYeljnerr3QoH6KQ==
X-Google-Smtp-Source: AGHT+IGQL93OReVwlOg8HtI0Kn8CjyVfc750LRqNp7jat5DB/9AyQXJ7+xkZcSYQ/FvWRxSryuL6lQt8g4bS73x2O0c=
X-Received: by 2002:a05:600d:c:b0:442:ff8e:11ac with SMTP id
 5b1f17b1804b1-442ff8e1221mr150661135e9.12.1747789646484; Tue, 20 May 2025
 18:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aCz84JU60wd8etiT@mail.gmail.com>
In-Reply-To: <aCz84JU60wd8etiT@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 May 2025 18:07:15 -0700
X-Gm-Features: AX0GCFsKRvPUZH008t0aezbcszWD7-6aM72RE_MZITyTHzHV0iSiV4DCrcYSLhI
Message-ID: <CAADnVQL8zB_aC8hDDBVuW30mSwc1pu2=04yMiiOfZSZFcEgQEQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: Support L4 csum update for IPv6 address changes
To: Paul Chaignon <paul.chaignon@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 3:06=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> In Cilium, we use bpf_csum_diff + bpf_l4_csum_replace to, among other
> things, update the L4 checksum after reverse SNATing IPv6 packets. That
> use case is however not currently supported and leads to invalid
> skb->csum values in some cases. This patch adds support for IPv6 address
> changes in bpf_l4_csum_update via a new flag.
>
> When calling bpf_l4_csum_replace in Cilium, it ends up calling
> inet_proto_csum_replace_by_diff:
>
>     1:  void inet_proto_csum_replace_by_diff(__sum16 *sum, struct sk_buff=
 *skb,
>     2:                                       __wsum diff, bool pseudohdr)
>     3:  {
>     4:      if (skb->ip_summed !=3D CHECKSUM_PARTIAL) {
>     5:          csum_replace_by_diff(sum, diff);
>     6:          if (skb->ip_summed =3D=3D CHECKSUM_COMPLETE && pseudohdr)
>     7:              skb->csum =3D ~csum_sub(diff, skb->csum);
>     8:      } else if (pseudohdr) {
>     9:          *sum =3D ~csum_fold(csum_add(diff, csum_unfold(*sum)));
>     10:     }
>     11: }
>
> The bug happens when we're in the CHECKSUM_COMPLETE state. We've just
> updated one of the IPv6 addresses. The helper now updates the L4 header
> checksum on line 5. Next, it updates skb->csum on line 7. It shouldn't.
>
> For an IPv6 packet, the updates of the IPv6 address and of the L4
> checksum will cancel each other. The checksums are set such that
> computing a checksum over the packet including its checksum will result
> in a sum of 0. So the same is true here when we update the L4 checksum
> on line 5. We'll update it as to cancel the previous IPv6 address
> update. Hence skb->csum should remain untouched in this case.

Is ILA broken then?
net/ipv6/ila/ila_common.c is using
inet_proto_csum_replace_by_diff()

or is it simply doing it differently?

