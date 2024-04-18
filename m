Return-Path: <bpf+bounces-27088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB568A8FFD
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 02:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15108283163
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 00:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858715D1;
	Thu, 18 Apr 2024 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaJOztJx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67346FB2
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399864; cv=none; b=Lq37wmQgA2/xuLA6eGPM1Ue2lgdwjwAw9+jPMn6Kkpz1DcrUJ4Eu9oXJlexkzIJy+MmqrG1Bg+riW2CpEBM7fh76eYlboyNy92zfmPjyuVr9YvJI1G5gsmEsMD/249dT+OS49mQTklP/M7Ujyjp90lV+VRtfesGfZUZHnknSYVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399864; c=relaxed/simple;
	bh=6ygLYaCatgmj8esyzxPKSf1Vm5MNhsxUau+glf4fnUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfVMHsy5C6ssctLd+zC0RR81jxqE7WxM4Vt/TLJ4GMGJFNE2j9OD7hBOLyEuiMjlSAyyAmh0lNNsTaef9r5ODYbWARYMvGRd2xMWhrq+av24FFuLbwf3rsTF6c5Ihz4AGCpytVGPmOsd9rFO2VXZsNQ6kGtDE5YX3Jd50zucl8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaJOztJx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713399861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ygLYaCatgmj8esyzxPKSf1Vm5MNhsxUau+glf4fnUA=;
	b=FaJOztJxWilrvGbId2OC0hGs66ADdtZJ3vDoB0dRTECoX8yeNI6Mgtvl/ybBVkP7uA1/QH
	lE79zXmYRH/+GhuxpwWbMZkB7KQ/44xmlbjr8WOfOiUdUyPA9f6hukZ+1prMU0l3XCUHIx
	kPZxr0BM9ypjF89lVpRVYqSpIf50eT0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-LYHeuj9JNyKNRHUBM-eFBg-1; Wed, 17 Apr 2024 20:24:19 -0400
X-MC-Unique: LYHeuj9JNyKNRHUBM-eFBg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed4203cafdso351793b3a.0
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 17:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713399858; x=1714004658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ygLYaCatgmj8esyzxPKSf1Vm5MNhsxUau+glf4fnUA=;
        b=Moa7YF7mX5wERgeraeYC4NPOqfZL9/g5Hff/r+E/YK0e+FIgMFiANRKJFvgDhpzUAl
         gzQr9b60A3UZsp5mNbAanURvtB5zrjilVUgVEnGpL2oFa1SZeCqwpDswbLLcgaemfJwv
         OafiTgV6lGSFlRZlvn03HNXBMbE7n3pIVB3VUTehkd/sc2koVjldWb94yeDCmF9Y8GPK
         94aLWHsD2cvhXLk+tQhfnYkDc4jBcvKJT/l3HuzMxBj25WwraewVWpLhufKEk7J2O+yi
         5k2R+DadjQUuMu/aqzfMtJrLo6mufH5z209Y9Qq3gGaw31vZbMkLePm2F6CttPONw51c
         8S6g==
X-Forwarded-Encrypted: i=1; AJvYcCWD5hKE5311dd9efzy73/GTZ251hPIB2LJH6CGfO+1CLXPp4MU5LECLyXW9gMRYNACXrOlEHvMmfrZ8w0Asha2qlrjg
X-Gm-Message-State: AOJu0Yw6m5rhr5pVB6m1p/5BApQPEzToA5PKURj5dC7GastU80n9MuO8
	oHIMHeLcxyuVgv+8eJqElBUBtVckqyEasA/yPPbzvd+jfyTtG15ZYLzNmn39JMdByczFkGIKREx
	OHp5mYPZWF7WuaPWNBRfoDkGHpinCKQeGqdZrzBgf7SzfRyjUv/iD2BMnGBytX3tl1IKMhJa6eW
	KqQibaMo0aWgTV4pgBkH2cMlGv
X-Received: by 2002:a05:6a21:3a48:b0:1aa:9595:4261 with SMTP id zu8-20020a056a213a4800b001aa95954261mr870728pzb.22.1713399858443;
        Wed, 17 Apr 2024 17:24:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElOi+SwtyiWKoWx9Rs4yVtkTdu/i6pUpqiCyZiV2+/NEDFVMxkU8nklag1Drtb3Woi5q0BV46joIjy5ZPGPbE=
X-Received: by 2002:a05:6a21:3a48:b0:1aa:9595:4261 with SMTP id
 zu8-20020a056a213a4800b001aa95954261mr870713pzb.22.1713399858165; Wed, 17 Apr
 2024 17:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417071822.27831-1-liangchen.linux@gmail.com>
In-Reply-To: <20240417071822.27831-1-liangchen.linux@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 08:24:06 +0800
Message-ID: <CACGkMEuABgSn396Cfi1Pt42Q__fCsr-G3XJYZUH3CEOARZ5Opg@mail.gmail.com>
Subject: Re: [PATCH net-next v9] virtio_net: Support RX hash XDP hint
To: Liang Chen <liangchen.linux@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, hengqi@linux.alibaba.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 3:20=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> The RSS hash report is a feature that's part of the virtio specification.
> Currently, virtio backends like qemu, vdpa (mlx5), and potentially vhost
> (still a work in progress as per [1]) support this feature. While the
> capability to obtain the RSS hash has been enabled in the normal path,
> it's currently missing in the XDP path. Therefore, we are introducing
> XDP hints through kfuncs to allow XDP programs to access the RSS hash.
>
> 1.
> https://lore.kernel.org/all/20231015141644.260646-1-akihiko.odaki@daynix.=
com/#r
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


