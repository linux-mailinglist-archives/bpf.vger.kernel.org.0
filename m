Return-Path: <bpf+bounces-27640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A68B003A
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 05:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0829B255B6
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 03:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9552A143C48;
	Wed, 24 Apr 2024 03:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mn9PKEjP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EF143C49
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930743; cv=none; b=nfpt7XjIbseCyEWVnHXBwPZHA9Ml+iDWAx8N9KWrbyhIYTQqORvnQzo8uCgpedAvOHQpciZ9/BZFua8rcPYhd82fS6LMCRVnhlxxTmsd/1Qt5pHJyBon/WXQwkb6+VNjZU9cBUf6+oHxhONzXCUQpOYrVyNIUTE2NiynwDujqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930743; c=relaxed/simple;
	bh=PmFXyGv9ORkds1kmwcp/v+wglJVZcoPaTmT0j8rNGkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5Szbc5TEv58EykEIer+rb/VrgSo39yOtCP8eG6vfzbFJNZgQRpJtTIbChv3DdPdthA6NhOScebJ8jfonwEakl5YWEBSi3pVfTnwHQ3/LBYHWvZVXUbZsG0KLW9VjoSc2TsG1jw9dSFzh6AKNhAp+/RQ1TqhULFg1kkaKVrEkgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mn9PKEjP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713930740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmFXyGv9ORkds1kmwcp/v+wglJVZcoPaTmT0j8rNGkw=;
	b=Mn9PKEjPujTOkUV0ei0eKsZpRseijEy+HhoCaNsxPtDg8D8f2FzI8iISj1sBzbezpZBqb0
	Bm2TpxDG/m3/QrSUaT3k0FqJyhnP7aG2QrI4xxdSYAmyYilRfD7fC4dDyuvOEDyFAW36YD
	ixUAg8l6RXhY9FlySRfz5mdpKgeTtXE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-B43SDNymO326w-tf4V_-YA-1; Tue, 23 Apr 2024 23:52:19 -0400
X-MC-Unique: B43SDNymO326w-tf4V_-YA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2adb84b10c1so405799a91.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 20:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713930738; x=1714535538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmFXyGv9ORkds1kmwcp/v+wglJVZcoPaTmT0j8rNGkw=;
        b=gNQOPS6nZaB58mdnylFWgFt4vByS7RzWrwX+x2eESxU8uRT5459FPfN7HfpVk1hGBN
         BCdX+koDhNwTTMMR3kXlQII1sYPehrPigXKz4alnk/Gz4LFzbeS+uPtHoZrlGGvrcjlj
         xMMmgm4m8hZEMc+G4qJ1yYcky1q5GGjJeMypgzuGMxu2VSbCuS8DrsMQ3QsZSFQsO4lB
         IXOLR8rpUkib3lrdluCdMyD4pr3zykFaF4tciKmDuKEXy8YsJM2pvNttjve4iAt+4/Fj
         OX6sIdfifDSxD6NXcZ57yBngzUZFeqPEwrFgzzmouJNsZelJlhf1qD6X0i+RgOIdE0Yl
         2J0g==
X-Forwarded-Encrypted: i=1; AJvYcCWN0bliW5NtVBMfsjophIDR0c9/yrNGfA2OlG2LsCDYGYF2pnlLCp7rq5egsevgMA90mmCQwmTsDOarfEXyEbbJ9rOn
X-Gm-Message-State: AOJu0Yx5qbHl5OCjbhs+GoRYd86y4RD1Ia2gq0qpVctyNimq0a0j5UVu
	uaKn6js3esnB/BkwLQlD6QQD1sZv6aIIt6vjfm9nrivHEyHN22md6qTPB/iwODeh4FLtThBGlQq
	OjhUmsUQtL9ZelVxl6dvbKaOEQ4J9JCRqGYIviEngXN/0kOxnngfUVIpuHrerdkRDDZ/HpqS7E2
	vx4urg7eoTlzSh86i1dGPnSrA0
X-Received: by 2002:a17:90a:5513:b0:2a5:be1a:6831 with SMTP id b19-20020a17090a551300b002a5be1a6831mr6312910pji.19.1713930738068;
        Tue, 23 Apr 2024 20:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFLrt3g5mDa/U40wi6cTIapOPrwgf/9zjhcS2nWoXd7w7CUZDb45+Ebxt0xxbOVlMJuued25HbftoqyRRiNhs=
X-Received: by 2002:a17:90a:5513:b0:2a5:be1a:6831 with SMTP id
 b19-20020a17090a551300b002a5be1a6831mr6312888pji.19.1713930737759; Tue, 23
 Apr 2024 20:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com> <20240423113141.1752-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240423113141.1752-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 11:52:06 +0800
Message-ID: <CACGkMEv5di6XvjbgSq2Qz1f_SBK-sTiCyTRer8CvoMkuAWkaaw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/8] virtio_net: device stats helpers support
 driver stats
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

On Tue, Apr 23, 2024 at 7:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> In the last commit, we introduced some helpers for device stats.
> And the drivers stats are realized by the open code.
> This commit make the helpers to support driver stats.
> Then we can have the unify helper for device and driver stats.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


