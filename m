Return-Path: <bpf+bounces-18765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDE9821B49
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 13:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFE11C21ED9
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 12:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DA0EED2;
	Tue,  2 Jan 2024 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BifrM9SY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A053EADC
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a27cc46d40bso208645066b.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 04:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1704196843; x=1704801643; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=dnCxUVtVjpzBF7YctwpdCYGWvJvwHg6sAKEy+0Mp1gk=;
        b=BifrM9SYT2Dz7D2ZRvcs3WIQjqN8WK6FwRwud48W2dT9qKfxZvGgAPPzh796gSkczK
         Pk44Yk4aIlwL3lA+cIc8G4X6tGo3+/N/M5MukREoK0JWrAvv41ahB2Q5y/yuv3O/shg+
         8v3jXLi5ZBeVgeUxMPc6Ds24Rd0O/OWBaadCVuLdEv7C1JaFwLjcZJPnnkWfPGhd32qK
         KO8TKJXEZnUCckbkHSeeihZlii3CjtP0mHWrFu5nIJPWXa8R8crzkFisowpy1ugQqAtd
         DmfHbWEdXY8zVM9uqsnx0W42S/vG2MGY09QnA+1CL+1hh+G22JJR8+JYjxrSne4gExgS
         vB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704196843; x=1704801643;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnCxUVtVjpzBF7YctwpdCYGWvJvwHg6sAKEy+0Mp1gk=;
        b=MS8PgU9HzYFSt3N5GkJ5lH73ADX2xjcMZcrfL8NQ7nQ4E7H0QmD8m+efW6jcGklEWs
         9s7SB3dj207dDwFS1kqZ3VUWW9JvUqA9lhnI0GRsr/yE9qUUOWkVWN4PaQtCyHtZKgHG
         trhRSez6+Oe1bJ4wCG8M5wssVmChOv+bzpn1pzUfjiEBhqEcNsoqlQPSs3kcrW7DHxXK
         5nQBvhem74fkm6TC+tyhXfccnaDNV1cdibfiN3uhzEkU60TGDKhll6D4t73Pn291Fff0
         dab2vtOlMJxmogkbIOiQjlJU9OIwduw4+CLaGmzyltzLjz7dHZ9yOoid62bsBSx7KV3v
         QA7A==
X-Gm-Message-State: AOJu0YzgaCa6VsVkv+PxVUaj1O7r3zDU0xYglF/fGZsrhv1ydA43wotu
	H/Jr2SI2P25CKJzX8YNVFV+xrXeprPzPCg==
X-Google-Smtp-Source: AGHT+IGVPcPW7VLmjeIh6+rVAYDnm+MKSRLALNuSrnUQT0jpy+aU7mmHE0nP3Rzfo1ZU5SMrJH5tsw==
X-Received: by 2002:a17:906:aec4:b0:a23:6084:419f with SMTP id me4-20020a170906aec400b00a236084419fmr5037517ejb.130.1704196843540;
        Tue, 02 Jan 2024 04:00:43 -0800 (PST)
Received: from cloudflare.com (79.191.62.110.ipv4.supernova.orange.pl. [79.191.62.110])
        by smtp.gmail.com with ESMTPSA id fw34-20020a170907502200b00a27aabff0dcsm3553563ejc.179.2024.01.02.04.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 04:00:42 -0800 (PST)
References: <20231221232327.43678-1-john.fastabend@gmail.com>
 <20231221232327.43678-2-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: rivendell7@gmail.com, kuniyu@amazon.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf 1/5] bpf: sockmap, fix proto update hook to avoid
 dup calls
Date: Tue, 02 Jan 2024 13:00:09 +0100
In-reply-to: <20231221232327.43678-2-john.fastabend@gmail.com>
Message-ID: <87zfxoueqe.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 21, 2023 at 03:23 PM -08, John Fastabend wrote:
> When sockets are added to a sockmap or sockhash we allocate and init a
> psock. Then update the proto ops with sock_map_init_proto the flow is
>
>   sock_hash_update_common
>     sock_map_link
>       psock = sock_map_psock_get_checked() <-returns existing psock
>       sock_map_init_proto(sk, psock)       <- updates sk_proto
>
> If the socket is already in a map this results in the sock_map_init_proto
> being called multiple times on the same socket. We do this because when
> a socket is added to multiple maps this might result in a new set of BPF
> programs being attached to the socket requiring an updated ops struct.
>
> This creates a rule where it must be safe to call psock_update_sk_prot
> multiple times. When we added a fix for UAF through unix sockets in patch
> 4dd9a38a753fc we broke this rule by adding a sock_hold in that path
> to ensure the sock is not released. The result is if a af_unix stream sock
> is placed in multiple maps it results in a memory leak because we call
> sock_hold multiple times with only a single sock_put on it.
>
> Fixes: 4dd9a38a753fc ("bpf: sockmap, fix proto update hook to avoid dup calls")
> Rebported-by: Xingwei Lee <xrivendell7@gmail.com>

Nit: Typo ^

> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

[...]

