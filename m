Return-Path: <bpf+bounces-34048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F62929E0C
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 10:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E111C1F21181
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 08:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8D83BBEB;
	Mon,  8 Jul 2024 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQG0abAP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A8849C
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426228; cv=none; b=FOiwsMVz36rX3XXeyoTj8yC2L4RXJTNOZkDWs+4ZCCuMnfir/X5+6JKSix12fjIQrfbGVRcac5N0JW1PA2/2+EbOmVDHOOkePHGD03iwa/Gs9HtAeyYJCKXWd2jq19Yo1EuU9sAR6v83pA2QnaDhk4Ua9yly0iu049g6cnDE78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426228; c=relaxed/simple;
	bh=yz3AnmlzZclWxsGCy4pIv9K/D6Ob1yWFKZV/+u2QXhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExQb5loqW3/OQqF5JUlcxkYa/sQZ071tH8ICX3wWDbcLDdMAAymDNDnyVhs4fAJo6J5LjTCLdt0hU6mx5GlYcERbx5zjyM4qAq7R5PuBdLtDJO5erv8PZVW3zKkYh8G74aHQcnhWA/0NO8KPawkkOU2ivzmMbpEi52XV90Uzcuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQG0abAP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720426226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yz3AnmlzZclWxsGCy4pIv9K/D6Ob1yWFKZV/+u2QXhk=;
	b=QQG0abAP1kheL195q/iBNr5dbuS62ghWKsYoadI9r50Yuo/gtEjzXcNnbrYL1fdkX36vfb
	1r0rW+sKZZJ1Dmc/QA7rnZwFxMNJ2ov6TnetYIbADQ72u0ecPwpp8NOsQ1h23eZsxVI+5y
	oi54qe1NwxnkNhEBpOCSUSeEk1Qrh40=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-m3WVTq4aMmSmRlM4ng9hEg-1; Mon, 08 Jul 2024 04:10:24 -0400
X-MC-Unique: m3WVTq4aMmSmRlM4ng9hEg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c9ad83844fso3194877a91.1
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 01:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720426223; x=1721031023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yz3AnmlzZclWxsGCy4pIv9K/D6Ob1yWFKZV/+u2QXhk=;
        b=JVOY6ReCi4MCnZlzdvm2BX0LQHeBZ2vRu4qyxV0cUE/RBEK79Lo2Fluj5UsGMAuhht
         bCj4U1bvdvVCf+YOB9tc2bCUd/v/HlFynsjXFGs2y6NFzJO1Uj4tR8d78n55klngD6Wb
         w3JdBe2+fSRwwPbpgKofs7RwzqWqP/v3DtO0zwyioNB+49XetSk6sgtWip5Uu4xAQU3M
         urFpSpx1v/MhZE+vvQdgl4nfkLFihI8tx1FeHDAehwhwUcvDUPC7H1h65WhEuxo8z6ut
         reoFNzudUoy1evUOrOuTPSJDSjUNSkWXOPtuV/Wc8RXXMeoeXiX5IGhl+R20rR2IDM6e
         FnuA==
X-Forwarded-Encrypted: i=1; AJvYcCXvQ1r7rRilg/beNaEIjAddIzppv4jLVeiPFibbSpZ17i1M4mlv65ekyt7Wdx8z1qaZ1S2lfidoZyVjwqoNAflUH/dI
X-Gm-Message-State: AOJu0YylbRyiQC1noaFJcLu4Gz6SGg2zYt+kI9syrjVJsZdcrEXD0LNk
	UbOM8YbBLayy08Yg/S9irokmfr49ICNmAh5Hpn720+8aDO9b4r4OUh4YXxgtq1JVntHKqnDolH9
	x80EgynrgoRLJx1WMGdQWWHgbQKbOwPLNgzCCqY8s3fS3EOPjUPhU7WMN957EEosItX6DV2lCLJ
	X/Fl4cmsMphfZ+ZhbAxqCgCdJy
X-Received: by 2002:a17:90b:23d6:b0:2c9:a151:490e with SMTP id 98e67ed59e1d1-2c9a15153dbmr8352854a91.18.1720426223154;
        Mon, 08 Jul 2024 01:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj3jzysrr8JPHGiFGX+E23ysYUxoH7WdqJzqCtsY1jBZGjVa2BZrehl9IuU0V6yjZwl3A3Ox61aacTd6khZXQ=
X-Received: by 2002:a17:90b:23d6:b0:2c9:a151:490e with SMTP id
 98e67ed59e1d1-2c9a15153dbmr8352833a91.18.1720426222760; Mon, 08 Jul 2024
 01:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 16:10:11 +0800
Message-ID: <CACGkMEsorUJC0fN=QWbb=K+_ShJcyqSGYRPV=omSJRe=SQfU5A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 10/10] virtio_net: xsk: rx: support recv merge mode
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

On Fri, Jul 5, 2024 at 3:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Support AF-XDP for merge mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


