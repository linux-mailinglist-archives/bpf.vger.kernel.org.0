Return-Path: <bpf+bounces-30889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D26008D4409
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 05:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF17A1C20FC6
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 03:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93CD47F60;
	Thu, 30 May 2024 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2cIO98S"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AE9548E0
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039431; cv=none; b=VZz98UmncSMNy3PCI7gEW9znlzvKj5TVGTSdI4hlv/ZClvdtpbqexfD8lE4gRUEdAuacIbw14ZbDYfHSBpQ1ihvpJp3g3ivjcv6nLxFbUIxScnsyVmws9SXHh8JG5FdpUYkV+9h/7qysTSGgy3mKdfJ9lK+yL/ycFsYbe3hCfnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039431; c=relaxed/simple;
	bh=bOawJWWTPL3Lez7ujH/FSWgQkqRVTx64+xBiVlZ20hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1xXHoz3WtUhvUpvf/XeGxQsBXzityZsr9QZrtiZ8A23ASssQuRF3qJ0/RFfGF/jp5DvrUl4faIGwvzv2BcpEllwGJ8A2uXkwVg1JpAHGp9aJOUvlkePxU2f+/HC4EG3seRxaM4j1V3dd+01zRhCGG/aCmFzfIjoeN4Hvmh7Hq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2cIO98S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717039427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOawJWWTPL3Lez7ujH/FSWgQkqRVTx64+xBiVlZ20hg=;
	b=J2cIO98SLNcIdpkw8738hSI/ua6Sm6XNVaSsJtBcLn1k2rXGCmy07VSyo3zJaNS7NL5kHO
	iGzfZiDcB4L7qn0c0ox08eD2O7gd/8SaLIQEGynON5/7DIDjal3puWENK//0WhI18L6APx
	FF8DQofOU6tuwu5Ir5WC+bHXRTN8HjU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-PWVgmqtVM7OYMtUvRY1Aiw-1; Wed, 29 May 2024 23:23:46 -0400
X-MC-Unique: PWVgmqtVM7OYMtUvRY1Aiw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2bf9410c954so395298a91.3
        for <bpf@vger.kernel.org>; Wed, 29 May 2024 20:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717039425; x=1717644225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOawJWWTPL3Lez7ujH/FSWgQkqRVTx64+xBiVlZ20hg=;
        b=aNGF4frcl0DPvqVA3aCVAPXbMiUbVwrd6RbVRA5sdgjG2TMS8Xb3uPIXbR+CbBAdWG
         AhEXEpqvOazBiJKly6o7RpVl1WZ2skV+lAh/dUicjSJYWmJB7SG9/N4EVYXw+dNskE3H
         xMVv1SrdLTGfIJZA+VZgfic0iBjNugqfCNZtyI/uxv7NzR+jsQkzpB1k/fBqusAjP0Nc
         60IDx9hByT6V11cnKJcMmSfss0UkpjYKpyHWFKlaD+yG3KtX9GKQ6+14h7kdRVrQ49ZV
         jcovVFvWXT5K6toWVL0xSkhqw4Q/JG0BZ23tC9FHGERX+H6jRgy0VP5NeZtgU7S61N8d
         VUWw==
X-Forwarded-Encrypted: i=1; AJvYcCWciXNnggy1ux/IKCmG3lRLiOiTpmuaWJ8ychfzS7QHLbzMHVt8ea6kS/yTPQZHBh3OLjgcG7Hzn/MkDmPzWViaxonm
X-Gm-Message-State: AOJu0Yy9vMVTZfkQVrY15RLMyj9KBWcusnMKVmXQXpmauPM1+OgdCZ7+
	niK1M4JFc1G9yzomq1VmjqhGJUnjbY0NetTyyrRS4dapBGLVHFUgjhREdhJCRNT3t5kVdG6i+dW
	nhaJttQ7D0jsgNBku08HMkm5zn2CxVsZPGBvnBruGC+IwxRdyQqhxo1e/tPXGbTJglR4f28qz2V
	iEH6JwXbQvwxN7rgTJhuwO62pK
X-Received: by 2002:a17:90a:ce90:b0:2c0:3400:df40 with SMTP id 98e67ed59e1d1-2c1aabe9d88mr1616330a91.0.1717039425063;
        Wed, 29 May 2024 20:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY/pYUq0iajDlnpjMsBnh48kBWVYBIbXgSvQ/hOOE6EMpOmk07gTWNTuhtCbRp58KyXGCVbg/V7IP9Yi+YZlE=
X-Received: by 2002:a17:90a:ce90:b0:2c0:3400:df40 with SMTP id
 98e67ed59e1d1-2c1aabe9d88mr1616307a91.0.1717039424645; Wed, 29 May 2024
 20:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com> <20240508080514.99458-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240508080514.99458-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 May 2024 11:23:33 +0800
Message-ID: <CACGkMEvjaY1B6tG0M6HjLDPNZkFsvdgXNA-O4GrjyXomQiBmEQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/7] virtio_net: add prefix virtnet to all struct
 inside virtio_net.h
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 4:05=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> We move some structures to the header file, but these structures do not
> prefixed with virtnet. This patch adds virtnet for these.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


