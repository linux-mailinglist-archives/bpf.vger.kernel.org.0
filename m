Return-Path: <bpf+bounces-46243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFA69E6544
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 05:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AE6283D14
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 04:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AE119343B;
	Fri,  6 Dec 2024 04:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ms6W7Nt1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8A118CBFE
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 04:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458043; cv=none; b=LGDdiv8Uxt5RA2sqfNOLg82tilfLTTctUpuQsjDxm6fTqzHMDg+yW6a1YgPyIAYxL6GCtrOHwX7ax4kva7kmNZXIYq2Wg/HltWAgXhQBU03ObyiOAqmJC+yrSK/WPBL2pUgdSbk4XOf9Va8uwUp1CSIBesH/lI24egRVmiVWL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458043; c=relaxed/simple;
	bh=zc8IKYC4bYs7JFUcgXSE+xqzD66zSoP3UvAGErf24aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfRptZ+paZhzDhCiyimRnOWl81E1vYXKkarou/qJM7TTrbpGlg9swU9MCsthdAky+lNzwMJcnyKXrgTs5OkTUp4P38E8lXboEkBEquVNfjb75jzsQ7P2ptBJhMPsWBzs7nSeMq8AK+gO3gLgJ7g41coGW7DNdTaQdPDBMicV3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ms6W7Nt1; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-466ab386254so81511cf.1
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 20:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733458041; x=1734062841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc8IKYC4bYs7JFUcgXSE+xqzD66zSoP3UvAGErf24aM=;
        b=ms6W7Nt1Q1vlBgN16gSsKtMcq0emGF+BAiCn9qzdJsSQ5olN2tl0KhqGW1UlYLtOVU
         RH87GhLhqX/08quaAuhQACOai7SbI+/qY7mnKBZH0NRDLS75ZgpXg5MB4v96R6CTe7Sd
         1j4HQw9L+C72cbNRX5WHwFc5vm1ZrTLQQ0pIm2M67TWiyNj9p0UvlgZFsuuK54brP/9a
         j5p+7iftxC3HC4nG2CikY+B2gr8p+mZFhLYrftL+rP2NLM175ifDR2ym97lD9QJPqZry
         A4UX3iD2zBOouvJTkKKrwxZY8me+GKMuSLKBkVeMNFrVXycFVo+XpCZ/z2YM7Sk8qBqo
         LqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458041; x=1734062841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zc8IKYC4bYs7JFUcgXSE+xqzD66zSoP3UvAGErf24aM=;
        b=v25o+dEdSOd0svpstb38ypfBSJuGIp8aHbUgjWQwbGNNz+eibai62kUx7fJsV3nP6b
         TlmruDzAKT60K0vGV7LkZQXgBjBmecisotfJHmLxiGmnXbEWrE1dv6jImMzZtZG/4rw6
         ozNg74v/BsM9IxnJM+ABMRkVPhfvFRmxJdIKr8jT9vgAnY8fPgRENOz5zQTWUrlCqTWm
         8uUjCjUTNv67hNuMQiAYs39pRUpkxKgRASni20vXY92cJkZ20J/68O6nj0GRyV88E7ib
         klUYy4y293Tbj2kXSCIe3/ZWKI65U3xK4rRWklzW47cX0Q/aVSutGkgePsf71BjxrBwE
         o7EA==
X-Forwarded-Encrypted: i=1; AJvYcCUNpUShMtgPS6FBx0CIohnQN/17oGN6MRvwzACblozP7CbpsW7MFJGjGji/irUBqtPyKfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9rfRsAGJaJSBDW0VqjUuNiBcVcgvEb8rjMb2XFp8lgbMYT1x
	4mKIglYRtYWdVPk8rbrds0VbB+x8Q/+7ALQgY/0DXO2fHLVJCM8Nucv2t54V0D74k70asBTY9kj
	683+u1o33CEJ2bfXKOOuPWk0sr7Evw5TE5Gar
X-Gm-Gg: ASbGncvWf7LU6nrmtuXwI1emBkxzzQWqypCV5K92YNAaJx9HNIskow3XxvVzvg/S3Xf
	jogdWzNdD0wzaBggNjFvqoCxROfUTQdU=
X-Google-Smtp-Source: AGHT+IFhNufgJHHhaY4RGILgttSTB6KCwdR4rnZG6VizGxTFxIQRMw1S9EFuvWf4IcRYE183tm/6FiRSsYge13kTuAU=
X-Received: by 2002:a05:622a:4d0e:b0:461:679f:f1ba with SMTP id
 d75a77b69052e-4673567465amr2080011cf.20.1733458040480; Thu, 05 Dec 2024
 20:07:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com> <20241203173733.3181246-9-aleksander.lobakin@intel.com>
In-Reply-To: <20241203173733.3181246-9-aleksander.lobakin@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Dec 2024 20:07:08 -0800
Message-ID: <CAHS8izNV7u_opjXvf+WE__qDDxbUiGorodOeihS2EOxjoc2J-g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/10] page_pool: make page_pool_put_page_bulk()
 handle array of netmems
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 9:43=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Currently, page_pool_put_page_bulk() indeed takes an array of pointers
> to the data, not pages, despite the name. As one side effect, when
> you're freeing frags from &skb_shared_info, xdp_return_frame_bulk()
> converts page pointers to virtual addresses and then
> page_pool_put_page_bulk() converts them back. Moreover, data pointers
> assume every frag is placed in the host memory, making this function
> non-universal.
> Make page_pool_put_page_bulk() handle array of netmems. Pass frag
> netmems directly and use virt_to_netmem() when freeing xdpf->data,
> so that the PP core will then get the compound netmem and take care
> of the rest.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thank you very much. There are a handful of page_pool APIs that don't
yet have netmem replacements/equivalents. Thanks for taking up this
one as you look into XDP.

Reviewed-by: Mina Almasry <almasrymina@google.com>

