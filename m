Return-Path: <bpf+bounces-26361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA189EA5E
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 08:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9B3287203
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F44219E2;
	Wed, 10 Apr 2024 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJLM5oMU"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAEB1CAA9
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729365; cv=none; b=Av1blgPKNGE2g0Y0hnhjUak9HVT2pPH9GwxBS9u7gH6L/iqLD0u6o6YvrXFhRN7XEOV6Zl79Exnz0H2/lPDcrvpuTzPTsaU9eoHqQvcHg5RPsXxhLtY7SgeUUIb94PsgBTqSK2IhS8Pi1r+6e+PL9ZyRRuXi6QOaABiAXw2ezdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729365; c=relaxed/simple;
	bh=pdL+Y7ykVNlw9tRl/D3HqOcFigRQwSpgo5w487bNlaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzJ/k11v3QEcyDefjS+APcnEiueAtzXcUBm/5HWP9M8E8Vd36wpuUnFHYtxasUgiytakZFxgkGMo9fVC0qBi5CLuoeNOr/ctYoTFxdU9FHm2iDAt5ufPVeOCWuOflHzIhW9Xqh5meHqKFb9F0B+9SozqyOWc7hh4w02jcBJ3aQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJLM5oMU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712729362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdL+Y7ykVNlw9tRl/D3HqOcFigRQwSpgo5w487bNlaM=;
	b=dJLM5oMUkCUFDXCjCuTf0mWTjQtKFu7RP/kKUjRPDg663N2iWcRAU+dtW/9ZhvG0KCzhM8
	NCu5A9UmSmLRntS+XbFB1p5SD1TuMCZ71zSyzjENMay374dEpy7umMxNDgnPba3siRBmOJ
	fndvdRSZePfb4uN1YTIv55CpmQkSfUo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-PW5a4LuNOa6T-wSSuc-iPg-1; Wed, 10 Apr 2024 02:09:20 -0400
X-MC-Unique: PW5a4LuNOa6T-wSSuc-iPg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ed4203cafdso1980458b3a.0
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 23:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712729359; x=1713334159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdL+Y7ykVNlw9tRl/D3HqOcFigRQwSpgo5w487bNlaM=;
        b=wByGrlO1XKbmnitLZ/aAcU1HjXem0rsQq4Nadv8QiY5ub7htrmk04Ap53nTiN37O8J
         olO1kRhpLs2DkJeg6LXUqJbg3gaNcgWSZiCkOtoPueA4Vo+sdlRCtUH783Hjub5E7xir
         CCdTdEy06YDZOJF9RewluVwyaGEZj1VJg3tCH1SbRgJ9eBApGVEMkUvVpKzIDl6Dmw6I
         QOXlXkb+1xo8kdVgWtICCZkiVqjyPVtJ1q0FhQg9fA1Ov8/YIqDG82egg/k8SoyhTfjN
         Hf0k1eIl/rKnl1idx9IJzVO5omJTc6lzn1qDf9zOM4SDSGdxV5btHq55Q7rwuC7jQkXb
         d0sA==
X-Forwarded-Encrypted: i=1; AJvYcCVfwhAkEaZRdsQMnaE7NcjjQfiEy72UroSObbT7uHWr9YM+cu26ws2WBvHXrlhCIKuGX6Z5KqyXeA/HO5Rw26Vf/X/h
X-Gm-Message-State: AOJu0YyqtKbcljUNsuAp3d1IM/A/DI9bZQcjqzBfebqUzvPvXeAUzlyA
	fs7/oOR8wzfTKLa/O2b0KjvgxziG6WGzfBA1YIMsKLrzzrKGt88gKfNWymuzHnOuptVLwnCdlL1
	rhuxxUZWsRH7cCrZtRcIP3JWOu6RpgVKJj4M15p8UhzcA5bkbm5ri28yk4YPD7A9ll0GPBopPi3
	lZUncWVH5P+gAx0sqK6FYNDeL3
X-Received: by 2002:a05:6a21:1707:b0:1a7:af88:486 with SMTP id nv7-20020a056a21170700b001a7af880486mr1953129pzb.9.1712729359653;
        Tue, 09 Apr 2024 23:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExWA7dtfa6ijnoDUCu1UfmNatwKbyCe84k67lqsG0ruoxaZc3zh2CUgoM4nLptDf+SMRE8btzrFCMB+Gqw878=
X-Received: by 2002:a05:6a21:1707:b0:1a7:af88:486 with SMTP id
 nv7-20020a056a21170700b001a7af880486mr1953106pzb.9.1712729359357; Tue, 09 Apr
 2024 23:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com> <20240318110602.37166-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 14:09:08 +0800
Message-ID: <CACGkMEsVeCS0ABNeDfSvRa0GVqFN9EhrB-47LJG0_NnsDN_mpg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/9] virtio_net: introduce device stats
 feature and structures
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The virtio-net device stats spec:
>
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd=
243291ab0064f82
>
> We introduce the relative feature and structures.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


