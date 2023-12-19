Return-Path: <bpf+bounces-18304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFE8818B25
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 16:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA83B1C248A5
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCA51D130;
	Tue, 19 Dec 2023 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXg/R5O7"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFA1CA91
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702999444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqy3wtKu2RpMhAf44zdAjTFEaoDT5QKe4xFKMUw3+5k=;
	b=WXg/R5O7SFEfxPiOR2XNRTBVZJZwLd5TtZ4za1nk0U1CxkZesjv8ykVrOXPm9IQBQpc8KL
	vgTPXQL3Fa42P1Bfd4zzh5uCkPSyyCFN4lXvOHgVXfGWctCRSHwdMikBTbAxyhl34QDO81
	jREUvt4fCsuVEiZTtv5WldcFytximmY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-8OP-JsTSO0StuF2cO9M7yA-1; Tue, 19 Dec 2023 10:24:02 -0500
X-MC-Unique: 8OP-JsTSO0StuF2cO9M7yA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a236e1a1720so11383066b.0
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 07:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999441; x=1703604241;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qqy3wtKu2RpMhAf44zdAjTFEaoDT5QKe4xFKMUw3+5k=;
        b=GhEO8Y4TGDe4eZZohDeIxpm1atylVntxiDQLaqYd24cVbU2vkcvoWVn2cSPYdqcGTe
         fOejd8EL29Cb6NcT+AgTeSohdQPErGIf1vpc9y3tBoBZLKwC3O8Aii9cymwT/+15tMxs
         BhiGpfkQxSXzX+sl+w4MzK2LuOgnoLGH8dTEroDTEaqYCqJRvPmx8XODJZVegtem2zH0
         n4l8X/lqBruJUUcNV06Ax+BtHj0dGlWw0+I24eluhNWHU6deDSfRqrVGlOsBbJN7EGa9
         BXUYzOKKDO4o6YDhbcmortXxhbby5sX/nsyeT/eJjsZa9YyjfuT5tx31PWHm/KONDV10
         BbNw==
X-Gm-Message-State: AOJu0YwQdzmYKhyX9HLZmc6r1L1a5v9Ra92aTAUnMUpwBfbnAc2//ABW
	1UrvD8hqFqJMVnidWyyz0wyVGdSXyt+cxY2XK4RQ7Lwh3Wp06lngOVjfz9VMCLuJFHyzR+UXsJn
	qVkBAjlUfrY/v
X-Received: by 2002:a17:906:354e:b0:a23:58f9:e1e3 with SMTP id s14-20020a170906354e00b00a2358f9e1e3mr3600145eja.2.1702999441095;
        Tue, 19 Dec 2023 07:24:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd0dgWBJVckg8y4NbbSgoLWG04HdfE6jM/KTshFzIrCjgjsrKQx/VS4FbrtGGixICTTdPZ4w==
X-Received: by 2002:a17:906:354e:b0:a23:58f9:e1e3 with SMTP id s14-20020a170906354e00b00a2358f9e1e3mr3600131eja.2.1702999440790;
        Tue, 19 Dec 2023 07:24:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id jw11-20020a17090776ab00b00a2358b0fa03sm2574203ejc.194.2023.12.19.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 07:24:00 -0800 (PST)
Message-ID: <c49124012f186e06a4a379b060c85e4cca1a9d53.camel@redhat.com>
Subject: Re: [PATCH v5 net-next 1/3] net: introduce page_pool pointer in
 softnet_data percpu struct
From: Paolo Abeni <pabeni@redhat.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, hawk@kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, bpf@vger.kernel.org, toke@redhat.com, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com, 
	netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 19 Dec 2023 16:23:58 +0100
In-Reply-To: <b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
References: <cover.1702563810.git.lorenzo@kernel.org>
	 <b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 15:29 +0100, Lorenzo Bianconi wrote:
> Allocate percpu page_pools in softnet_data.
> Moreover add cpuid filed in page_pool struct in order to recycle the
> page in the page_pool "hot" cache if napi_pp_put_page() is running on
> the same cpu.
> This is a preliminary patch to add xdp multi-buff support for xdp running
> in generic mode.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/linux/netdevice.h       |  1 +
>  include/net/page_pool/helpers.h |  5 +++++
>  include/net/page_pool/types.h   |  1 +
>  net/core/dev.c                  | 39 ++++++++++++++++++++++++++++++++-
>  net/core/page_pool.c            |  5 +++++
>  net/core/skbuff.c               |  5 +++--
>  6 files changed, 53 insertions(+), 3 deletions(-)

@Jesper, @Ilias: could you please have a look at the pp bits?

Thanks!

Paolo


