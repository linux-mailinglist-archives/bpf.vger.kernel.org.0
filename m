Return-Path: <bpf+bounces-38485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF9A9651B6
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 23:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C126C2864A1
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 21:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1EF1BB6AB;
	Thu, 29 Aug 2024 21:17:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12E18CBEA;
	Thu, 29 Aug 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724966249; cv=none; b=s/bPA3vmfnEMi+oIE6pBRIJcj/ilQm6AZVgCbGKA+VIJznx63qWb0rMHLKX/ur4MMuKYpalxZ9oxFWg0EHSkfTMrkYe4yWINX/tZV/sMZzkVD71x1un3p+lGKE7n2ZzugBVciCnoZ/J9N+jl6CuWXnp5Ok5uGFzeLvzFkKlDdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724966249; c=relaxed/simple;
	bh=vr1BIY5aOTRq3ZcSKRC4tYM5sncuLo0dljE0qJOzFJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSEb0Jz87IiYCzbvtP46UAZvtWEApwrWVs9xqf1xAxmL+Q5ICme8gVRFOxxF4EJgWUbpR3oYLjGqkcmPbr+v2IMLASyjXRltqZdSG3QRj0hrpUv6jGVwid8oz25Ro3jR78CMPcEdhX8OwtIWbokGeEKi1ErVAczbz4oWGBg22Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2050b059357so9327715ad.2;
        Thu, 29 Aug 2024 14:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724966247; x=1725571047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GndQKVk36+RGE2NEB/3qDnOCLPazoF0Tm0qv61A28Ao=;
        b=kXgXBiuiB0AxqmfuuG1gQLM6yy5LjetfVdJqM7YlygGkY5g4auETksPZ0zrlIKNt//
         ikaIU38FSYe/Q5oB8+KWsgjMQrPpanqPwvup2fdPgFGPfCDUtQYOV27Sn1gFCqy9k3vU
         7bQr04iAki+0lKlPNhAFDTtlcueNJLyqk4Z0XKiFHJBYubRZLHhuRu7zd44IBH6qI4il
         ZR2sx7I9+8jy12oQXBN7sHdgCqtw2Hu/9y+FCQJ6aMqMLVxzRDhF8UZls3qhOJkiUgfo
         SUd2rzikxT+pW7C1AGrrqb197U3I79T5WJOaDBJuNxulgKycoHIfNQXaM9IOlLAVpV4I
         MM7A==
X-Forwarded-Encrypted: i=1; AJvYcCUSnHx3HttwU/J0JsNDIyU3Kijpixb/1Bp2ABSYRrHyha6aO4Sm7PCaxCCibUg/5q/8y/Q=@vger.kernel.org, AJvYcCXDHh1MByBCXMbKqCXfMY43mOrqC5mnp3q1Zm1zDkJlZGPAHpjgzpa0wybD7ET2BVkAy+WijASD@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfrHxVuBL2FhKxq7OzQ4lLOEumbtACg57g/D0rykkZlHsxzm8
	YJuq1Gh74SzVlrp/6bieYtuZwA4rVLZRsiAvXXm6YKDqiRBfLeM=
X-Google-Smtp-Source: AGHT+IFB2XnbF0Qeic1xShexhNejX7eHMLQ4zvTZCIIZIdHvrLG7N0gdJ2ZEOXjNgaemE/wWiXjA8w==
X-Received: by 2002:a17:902:ea0f:b0:203:a209:c5b3 with SMTP id d9443c01a7336-2050c372479mr45847015ad.6.1724966247441;
        Thu, 29 Aug 2024 14:17:27 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515551e79sm15584215ad.248.2024.08.29.14.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:17:26 -0700 (PDT)
Date: Thu, 29 Aug 2024 14:17:26 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Simon Horman <horms@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, sockmap: Correct spelling skmsg.c
Message-ID: <ZtDlZtUj2Xzp6ARQ@mini-arch>
References: <20240829-sockmap-spell-v1-1-a614d76564cc@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829-sockmap-spell-v1-1-a614d76564cc@kernel.org>

On 08/29, Simon Horman wrote:
> Correct spelling in skmsg.c.
> As reported by codespell.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Although I bet there is so much more spelling errors :D
I have a spell check enabled for the code comments, and I'm almost ready
to disable it because half of the screen is usually red.

