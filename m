Return-Path: <bpf+bounces-61637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973A4AE9451
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 04:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18FB3B4C2B
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501A212B31;
	Thu, 26 Jun 2025 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2KIrxMQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97E2135D7
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905546; cv=none; b=t4nm7QNKLNOWanF+AfDJOgCDEw8rqhN7Wkod1DBsyuhvG6VcXIzalWfLMdUFpp5hgb8jVIhiHvrNIDtdcn44sfLzRalI7LbwHxGewfOTwcJI4ErDcvb0iW92KB6Tvb+KzklaBlWJWpdENDFh9ko1PeoRVqMyuXqqJ0+NBo2iuM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905546; c=relaxed/simple;
	bh=PtV+hGmWzCGGAq8XJTGqpjrx3hzHcShvqveug29QiX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjNOBZQ09MTaLa9507/XTPXxJmVB4ihTKYQa8rr/0t/n6lNlGLzCp9adHwVOk5uDn6NuPFFA/8QflwfO33nTShaj6VLT0nB+Uyc59w6IcD6CWJ8WFNz7o11bzPS9yOgNZNtKRn6oPXiXot0PJTdAl5sfE6+n+X0SOrLIR3ycwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2KIrxMQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750905544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtV+hGmWzCGGAq8XJTGqpjrx3hzHcShvqveug29QiX8=;
	b=G2KIrxMQGGQ4I+9fbrd100V1VpyeI2uwZOSCGSMmXw0SW7OqI/5spDU60JD6RjjOpPY/Is
	Jv+M09iOBufVqXGh48jO1aIVCNK1xAdQvY3WaRJ+zt/xBukYbsUvPumIX+GQKStKGsKJb2
	JBS04S3CJ7+BtsCKc2QIrj52lHsNccU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-xUG0mkVTMgi_CMHHFgy_RA-1; Wed, 25 Jun 2025 22:39:00 -0400
X-MC-Unique: xUG0mkVTMgi_CMHHFgy_RA-1
X-Mimecast-MFC-AGG-ID: xUG0mkVTMgi_CMHHFgy_RA_1750905539
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31cc625817so1281940a12.0
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 19:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750905539; x=1751510339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtV+hGmWzCGGAq8XJTGqpjrx3hzHcShvqveug29QiX8=;
        b=Byqr3Ry4Vnd3YI9We420mimrbOYW59j8Sxl8XhPiszffAa6xcBXIBFgmfEMQA26Fuq
         RjaD8n49HWrZeKN5ZSULIHPLJv0CyJcMNkVI/NtlCO7HIJB0uX9kAQh1k8k3hNNgfxg6
         MCZ2yj3PSMMqAXa9v4MelCiK/pRVJ0t6tWbsfh+Oa+2UnIYsIFv786y6HZGeRYFvFGJn
         zjI/nqGDfduL+j1RfJwzeyKz2ulMpX8hRkw+mBJzafl21uqREymnlEZCtuT4VU6acLy7
         XLCSuo3nTp6sPgRQmXsp/76YJibm22aqjDaUT8S8S135YK0nk1zRPDAfoWZM0lkImVkX
         KVCg==
X-Forwarded-Encrypted: i=1; AJvYcCXCaP++y+4HfCmILN3/ELxCpwl+qjtTcGGwY9XSx5Juyh3VoJ6KC/IiGhk0nPiKeKLaB1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wGZcpqIO8LjfH2/b3EdAt80yHea99yv6NoEihgxbkryWM4dO
	I0xqr53bXqDHYCSxMR0rXpaT3n3xEhfZvaCy2UYGzcAN10j4hDhIoP7J3bALjz5PwvnUzx0LOgV
	WdOLDsVGMFEy60xNqd4PNmiq+JNoepef/vIWk4VppV6ZnX2eJVi4Hu+43RKQo6+45VjhQCdVIT2
	hHsdfdy9gxVrVIN2dKxwJRuIEkjfHP
X-Gm-Gg: ASbGncvuCHVWQMpntJRU+fS9skFRJj6Xu96yLFQoTcc7itoseb33svn2Zr6EOPOoa5H
	w0LCyKYDYtpQ1BBNSnMAIEfTUwPyVqc1AS5IPGcAdTEH5/rqYf0EcjP4Cn6fOrJ7HANIURn7H6X
	B5Pm6+
X-Received: by 2002:a17:903:3c6b:b0:237:f757:9ad8 with SMTP id d9443c01a7336-238e9e06b68mr26264455ad.1.1750905539243;
        Wed, 25 Jun 2025 19:38:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeb7cSsXZgQCsbZuX3BxI9ea2eoF1dmzDHFHzV2vn7oWQ24AkuEOzAXNT7eLnpup8aMyphvstnn6ceEBYA5HM=
X-Received: by 2002:a17:903:3c6b:b0:237:f757:9ad8 with SMTP id
 d9443c01a7336-238e9e06b68mr26264205ad.1.1750905538830; Wed, 25 Jun 2025
 19:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com> <20250625160849.61344-4-minhquangbui99@gmail.com>
In-Reply-To: <20250625160849.61344-4-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Jun 2025 10:38:47 +0800
X-Gm-Features: Ac12FXzGBspfM0xNLFV6s_nJRqcVgjaFcF2_Hcvm4OR2ygauzrYWua0l6j8T7wo
Message-ID: <CACGkMEvY9pvvfq3Ok=55O1t3+689RCfqQJqaWjLcduHJ79CDWA@mail.gmail.com>
Subject: Re: [PATCH net 3/4] virtio-net: create a helper to check received
 mergeable buffer's length
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Currently, we have repeated code to check the received mergeable buffer's
> length with allocated size. This commit creates a helper to do that and
> converts current code to use it.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

I think it would be better to introduce this as patch 1, so a
mergeable XDP path can use that directly.

This will have a smaller changeset.

Thanks


