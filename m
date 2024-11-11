Return-Path: <bpf+bounces-44490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC59C35EA
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 02:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8131F2821A3
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 01:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26DA1E515;
	Mon, 11 Nov 2024 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDtmrKDi"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47AF1BF58
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288495; cv=none; b=tHMgatzvVCyQ8hH49f/VoylpJf72tDZKkFjxnWPxaa4SKO/dm/Z6SJqQi2OLfxpIwZVdZJMkG4rSWkKJnPAJyY2FKyxF94bJ1ex00mA/ng6SUbbC3fABIyItu8fPiSaCromLVoOvH343B3iYGy97wc2kMyUifXuoAZ5iqJ9RM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288495; c=relaxed/simple;
	bh=leuZ8/a/9iCo5dLFBQyoF8wApHzQfSfOMnYUkefVFyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8XWT7oGFt0BMdBam5rIXV7/iA1XUnAO4BDVKjZNsq4e2DPgXJ6tOPQrLIfjpXsE/gqq57Qzap0oqOC3jEZvmRx2Jdr3AKDHmxHSHK9vfqnZ2c1VGl04UPKSiI2fEZMmwRE/O4FtZrXSjkEqOW3oWfLIEYUSIHofKpkUgisQ20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDtmrKDi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwodJjCIiLaOTp/teX5ZAIKMeNbNjhKNfqQerM1sSEU=;
	b=LDtmrKDiLdu0QAoU0nlGMwgjgA24X0IGmlMDoOR+dZ1poWh74w3Vau0N3Y45fp4LZCGmqz
	G+V6CNQyRshzwLUYzECWxml5XiywZqcrc1mdf5lX3cPzmyKnrS3y6lrhAy8I9ZienDgLMq
	wD3tuhgoif/MebOymqI3XPYQctUTVRI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-UCXK9P1kNhixIRD9OS8B1Q-1; Sun, 10 Nov 2024 20:28:11 -0500
X-MC-Unique: UCXK9P1kNhixIRD9OS8B1Q-1
X-Mimecast-MFC-AGG-ID: UCXK9P1kNhixIRD9OS8B1Q
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7edb8c3e743so2431508a12.1
        for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 17:28:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288490; x=1731893290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwodJjCIiLaOTp/teX5ZAIKMeNbNjhKNfqQerM1sSEU=;
        b=br+fpEbuuUotVz2emmL56R4FJcIf1ibI8Q2sy4qNmlHgCbXnQVkYNTgc8kiVZ4mRN8
         Cd1mIiF0fdnOzXptq8gORaraJL7tDCDGJiOG2NCENID8TmF1Jhln4njbUlHzkmfQxYNZ
         7B8ZikdQN9q4tuMrycecsCsOTAhyy2XHFL0taHIEhCKpCuOi7qK0IDmKdD43ogIwqWHh
         CWmyDo3iELxc+TZX2bd4w0P1TIIKcYiTQChOBp/CHE5cy+J2sontwoQ99fIiWfy3Wg73
         e1+T9aGQBgpjEcQDlQHLgUFyu7A8mq/5fXU+8y3X48L5ryOGQs3iuaryoiDZNDOxYkmW
         fapA==
X-Forwarded-Encrypted: i=1; AJvYcCX5an9Sy+UdqyaIV3T+iUxrcuEq8KuEIT1ds7+rH9JYN6qAYnUxc+SPG/ozIHKdFWypP70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2o2AfHZaRMheW+k22PSyRnsPL+gqtUaG2nhfJ3ztUL7CfllN
	lBBj4yH7n+rZks7wyr0q7iWL0F3H2alTM9qqjHFfsAMgjl12EEin+LmBgKrXXjEFZ0zg4Ai031x
	suYhlXv7tQjgu2eoUxix2WLKF0oQk+cGcIpJg/0SBArrPsViavzVhQZyO1Zs7ojMe5Gg+be3zGq
	kTtbnFW9oCw/fU+Cu3VN1tM/B8
X-Received: by 2002:a17:903:283:b0:20c:5cdd:a91 with SMTP id d9443c01a7336-211835d8f94mr142388585ad.41.1731288490276;
        Sun, 10 Nov 2024 17:28:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuUCilvl9/AQUv5pwsQJymlBnNl61KLcmkZ6nTf847m+d7BJWajr8P0LsOKCdKulbZKSlsGGD20yUrsvXzwVg=
X-Received: by 2002:a17:903:283:b0:20c:5cdd:a91 with SMTP id
 d9443c01a7336-211835d8f94mr142388255ad.41.1731288489838; Sun, 10 Nov 2024
 17:28:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
 <20241030082453.97310-3-xuanzhuo@linux.alibaba.com> <CACGkMEtP7tdxxLOtDArNCqO5b=A=a7X2NimK8be2aWuaKG6Xfw@mail.gmail.com>
 <1730789499.0809722-1-xuanzhuo@linux.alibaba.com> <CACGkMEt4HfEAyUGe8CL3eLJmbrcz9Uz1rhCo7_j4aShzLa4iEQ@mail.gmail.com>
 <20241106024153-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241106024153-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:27:58 +0800
Message-ID: <CACGkMEtbkPmikN3r2+kBpSq1UsbD-CcHF2GdfX+1zSSkt6X9sw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/13] virtio_ring: split: record extras for
 indirect buffers
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Nov 06, 2024 at 09:44:39AM +0800, Jason Wang wrote:
> > > > >         while (vq->split.vring.desc[i].flags & nextflag) {
> > > > > -               vring_unmap_one_split(vq, i);
> > > > > +               vring_unmap_one_split(vq, &extra[i]);
> > > >
> > > > Not sure if I've asked this before. But this part seems to deserve =
an
> > > > independent fix for -stable.
> > >
> > > What fix?
> >
> > I meant for hardening we need to check the flags stored in the extra
> > instead of the descriptor itself as it could be mangled by the device.
> >
> > Thanks
>
> Good point. Jason, want to cook up a patch?

Will do.

Thanks

>
> --
> MST
>


