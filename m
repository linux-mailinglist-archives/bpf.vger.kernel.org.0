Return-Path: <bpf+bounces-39576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A852974923
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 06:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC961F26A3E
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 04:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD92640862;
	Wed, 11 Sep 2024 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8WRrZ1U"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63436AF5
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029193; cv=none; b=Hb035jwov1W4dwhy/OKfmzkVJuUVzy2eqJmO4376PKkxslaloFr9NJp5YjykbMEyRhu7d5b2Ms49lK4j0J86P6nZYAhTy2QexEELUXijy83W0fEFgK8bBny/F4hjLR0RTiCoO8LAcWh3e9hk1Vh50zoBxDhqIG8GDxLebOqy4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029193; c=relaxed/simple;
	bh=rfzZIkklezBZEG1xUOnHXwLSJxefSSjl3alc4/QPdLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs8zL1bWSYw52iGMN8X2CPYPA13gkoE9nqxuqB3X5mW3yn0gMfkeHXQeWvo7G207P8odeyKNYSrDvvHCqTT8kZLvEmn9BRTL/woDcIVrPvH5SGYWsGZe4Y6k2xitqp6cAzFU1tc+xKW4WyWKSNQAcAunuk3WQujkixGmyRcSSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N8WRrZ1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726029190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfzZIkklezBZEG1xUOnHXwLSJxefSSjl3alc4/QPdLU=;
	b=N8WRrZ1Ul7NBqGMo4TnXJ/ObIoArT+SN02wj1VvP9ikvTE/uuVN6tie7RXbOj9liGFZwV3
	0YHFRSeVVC4kg4gQU5zn6wg611uRDSuJs/Fjr7BUeulnZajfd/+zmpCnbrWkVsER8oZLRR
	pwuFIRBVxDFQ155UotuEmf/zz1i56ok=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-0_LAh5NcM5ekQ6I_S_YoKA-1; Wed, 11 Sep 2024 00:33:07 -0400
X-MC-Unique: 0_LAh5NcM5ekQ6I_S_YoKA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d89b31e942so6447883a91.1
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 21:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726029186; x=1726633986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfzZIkklezBZEG1xUOnHXwLSJxefSSjl3alc4/QPdLU=;
        b=bQIZTU5YCfNWyYpJgc+mJr0Yjoj9yPpvz1HjtrvEeTHxrmYlSj86Wk55KdM+MqCFBD
         2Q5Oa1W920Jh4+39k+ITI4uuFv98ZXCK4zWSHk+RZtZAVnX0QHq+Pj45JznWEx5wQ0yA
         +5WnYMHxf2jwGLEku5WHXX3Wn5hDNfd4F4mKKOxz3ZbNSYhG0J8K8jXhqG0m+AaQfJh+
         CjVRNNDLxtdXNq6I1ch12QO7WC8a97Sd/msLpF9cLN608h4ptjPMsbQrm4YVOJKTN23L
         6pR2yZwMgFD2X/gltO63nQpA+/VKfuGwe50oikSo6ntRXpaQX3sPy/4/9vGADlW1xrwg
         ZO4A==
X-Forwarded-Encrypted: i=1; AJvYcCUzzHjz+TMH7emitKOMavDIeRCbrp0P9+aoUZW7E4zvzLt2SmoxaaV+cVfYVioXCyghi34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5jkbDAp3FxlVCxPN0Cu4GKsOAEPou2Bz/Q9KJbFGfP3G0LAJ/
	tCzeFWETag9prVPro8SI454dbqMXF2h1tzL36jFb3QUMQVlXdru6SWfayyxQZpQHCItqSPldVyQ
	Rbcoq/V/PzQ1FWEBRfK8MlthmKEXpVv16rpX+w0XCVamCdUsYvcu1uJVcfaStP14mKAlAqcPEXA
	pA+HByg4L82AGwOy3audATJcem
X-Received: by 2002:a17:90b:1092:b0:2d3:ce99:44b6 with SMTP id 98e67ed59e1d1-2dad517f7afmr15824627a91.29.1726029186405;
        Tue, 10 Sep 2024 21:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3GVsn/LMGACZj1UXWZbjl/jqpQUo45nERNKW3tBta8SrZSl+483DwLY/qxFy+Bc3SjR46sSWGjFODet9XREc=
X-Received: by 2002:a17:90b:1092:b0:2d3:ce99:44b6 with SMTP id
 98e67ed59e1d1-2dad517f7afmr15824604a91.29.1726029186020; Tue, 10 Sep 2024
 21:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-12-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 12:32:54 +0800
Message-ID: <CACGkMEvvKsypiOmdhWKjNhXJ9fS5SVYQFzK=KtTr1DdyMOv8mw@mail.gmail.com>
Subject: Re: [PATCH net-next 11/13] virtio_net: xsk: tx: handle the
 transmitted xsk buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:34=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
> buffer) by the last bits of the pointer.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

I suggest squashing this into the previous patch which looks more
logical and complete.

Thanks


