Return-Path: <bpf+bounces-34040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E72929C0D
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 08:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706242819AE
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 06:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6213ACC;
	Mon,  8 Jul 2024 06:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeAfpR6K"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0DF12E7F
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419519; cv=none; b=GNpNivFc4S6go2ZspCM3DvC+hh13wMzsM1ef2ttRN4fwGNgqCVE/rTIcF7vPj5S8XH6D6gMd2541cRZ2vKn+j7VrMNy61TRLAqoDE+T/LKh+c2S0p1SI+x9IucB5B0QRlhu7eOPcFTj6sEMTqf4UdOQAIXJYwTg7ulJAxmCSHfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419519; c=relaxed/simple;
	bh=OJyMS4iuI2rFPim2v94RCi0s1Q/QgRPRXzwYukaZDmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYNnFzYOwigmThicBhX+MT+Wh34htNeL7OtPg24YEx3jrtX6Cygh/weExSwt2iNtm6yp+Pe+hvYPUqaqN9c1uBabUe1FNqzyFCqtJvlyn4UQwn5uDIhMb6N/Q7VS4jLs9CTzKHUdrcsWIRWoUjZwRf/M259tYROyNUway2GYJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeAfpR6K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720419517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJyMS4iuI2rFPim2v94RCi0s1Q/QgRPRXzwYukaZDmA=;
	b=UeAfpR6KNzLH12S/gAmVLsazWnHY6TzVrQNfnsKv/495oZA/Su2G/lncwUcye6dcGM8bYp
	ZIzI/EQzjJZ5SImw4LsoQUA1+e9WHbegxtPhm1IjqpnyN1s2bg2I/wICSuuHtYcW8dE5ZM
	r2okiIwY3CkoKl/DETNmjKYhAblkplg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-reO2AMyGOuymleKs434brw-1; Mon, 08 Jul 2024 02:18:35 -0400
X-MC-Unique: reO2AMyGOuymleKs434brw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1fb4e7cc5d5so10231215ad.0
        for <bpf@vger.kernel.org>; Sun, 07 Jul 2024 23:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419514; x=1721024314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJyMS4iuI2rFPim2v94RCi0s1Q/QgRPRXzwYukaZDmA=;
        b=syY+qjouL0EE/ArItg1HhNcxkJiuCBE4M3SEQCiRklZ4+d8x7wKmu9SLTe1sH2KcHx
         69GqGPkvJI35nfPwuTqTTeahbIyx05S4gHhU2uTzJFrObm+y03fiq2+6HFKTwbEUDN4p
         CIa6GbkfX7GBSYfeBHF+XlimI2KRZIlR2BfFmNAk1eFi9MQ3I9OjokzR8WRAb9RQnCcP
         gWygUE0atwDaAYHdLk+khBW08HSANR72uirMfE1NiQeYT6x6gEXhKGppi+4MBV7mZlYW
         MqLvm+V8iLkqcqqFb/OJuQEHARS/seI4T6Wh5/3kWBitiNPw/KGzg7NhoceXEnAGmuSM
         ktyg==
X-Forwarded-Encrypted: i=1; AJvYcCVpYdxbqbtGV4jMgn0U3jXR6mbo3QeIjfQPZ9LarWwR2Xe4Z4OddYdOoGzo2s869M/kYC7iwkX6bzYeUdSqdYtZihJG
X-Gm-Message-State: AOJu0YzGJf7+OOzjN+U9wH6lZTW5AAgVKBNbTSDF8BiSeso3v04iRK3q
	Z62apdKi9/n5IgOyD6uVrMt5DmlFaKl5tMXeoxMytgIaVP4BqpL61or+FcQBy5dq46GUDJm374b
	grwgTKjR0nMJ0MYIF84jXt6xPAgEvAHThBcF8TUHqUACmDXjmnFrGqWeWlF/Icm8tcE3+iyIN+z
	u3LwjjXIAFI4SqeTEwEx9JaP5W
X-Received: by 2002:a05:6a20:2d10:b0:1bd:4bc4:754 with SMTP id adf61e73a8af0-1c0cc74d964mr8965809637.27.1720419514336;
        Sun, 07 Jul 2024 23:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFayZpPEg9Vaky5HR/PLqBUvW+SazsbNfG/BvLurCEgyFqG4nbfYr5z1CFXGnmN81flNu6bpN0+rmCr78Y+LjM=
X-Received: by 2002:a05:6a20:2d10:b0:1bd:4bc4:754 with SMTP id
 adf61e73a8af0-1c0cc74d964mr8965797637.27.1720419513986; Sun, 07 Jul 2024
 23:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 14:18:22 +0800
Message-ID: <CACGkMEvr4QYNBX0fQAkXYUuKn0JvZ2dZtwsqh+0SCJBCsxMVnw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 01/10] virtio_net: replace VIRTIO_XDP_HEADROOM
 by XDP_PACKET_HEADROOM
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
> virtio net has VIRTIO_XDP_HEADROOM that is equal to
> XDP_PACKET_HEADROOM to calculate the headroom for xdp.
>
> But here we should use the macro XDP_PACKET_HEADROOM from bpf.h to
> calculate the headroom for xdp. So here we remove the
> VIRTIO_XDP_HEADROOM, and use the XDP_PACKET_HEADROOM to replace it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


