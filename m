Return-Path: <bpf+bounces-30081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 846DD8CA5F2
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 03:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E4A5B211D1
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE28FBEA;
	Tue, 21 May 2024 01:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je08O0xr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334C848A;
	Tue, 21 May 2024 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716255915; cv=none; b=kZt7QNpaS9pSKV/sdGKXOGWtPhwBfcmZWGumJ8yGMn8rEuIRCA36xLfLG90cxM+SiQtWQQXijXZDCspagfN9svxoWul6QAQW3dcv8J/zkWK2FJpYAHvz0vPk7lC6vp9XHmX/cW4IyeVl49qTkaQ4QDkyIoRJZczUFlNfDM3jdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716255915; c=relaxed/simple;
	bh=nYJ6ohX56xTSoxHh+136A500XOjiqdHDWmcMcyDFuos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6lRvus3Mwj8T/i6eszq4Ts5e5qMwOXFeV8y4vR/guUPv9+BVKfaba9WToteRXPC8ZHSGYmXPPaFwr6MuGWThL7Hbujfvc9MhFPpAgfReXD/dNtoWWrq1GYmQ73hXPcAn2uBip0ukxoK55qyG19bfDBh/2vmJsK6SWvRGpC1SkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je08O0xr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-351ae94323aso2472681f8f.0;
        Mon, 20 May 2024 18:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716255912; x=1716860712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C3KCpd8ggBuxZPJIwx9XN0w1n7QWEhCXo3/tudXqb4=;
        b=Je08O0xrt4Gm+nES70xq2+/dGpIqQ7I3Nfc+SUThv1rogU+6PZjx70Uph+uoRVn+Jw
         wFQaBwKQGPNFKs/PHJq9j9X8kjoVT1ldodSlINV2N7lYW8iNvf629SxiI7r36c98RRIH
         fUrjzkgkT4Swf5WPFrWIb5Xt5t8uPO8OCo4OzpouZoMqckBhh1ik+KCsAGt83UvUOUP2
         3i54h+Sg2UIPwFXUs0Sv+w6uLjV+B1GqsnzUcfv691htuyfvBg/g2bZgHBZGgAxbTuPS
         4X7VWp9z/u1wMJ61LG4q/2H/lU/7IC5UT2VLhpTjOhCq2ToseXhsQbMbeUunc6LBK7cL
         yqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716255912; x=1716860712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C3KCpd8ggBuxZPJIwx9XN0w1n7QWEhCXo3/tudXqb4=;
        b=WiHiF7xueaoc8a5yA5GPcjy0KmD955/FN8YK/1IglGFPNysTgfPRd2BasQ8CDDy9iI
         /tVoTkO+JMYu9kmy4l8o3IN25JP70e5nEF2C/7nuxgYIvGbV2YK9Wh0u5RjOey8UBv3F
         d5xRFP3Rcp5qR4uWGk3u/PMOVfhuAZ82QNoiNI2mv5EmAVTjVeNZqNoQKW40L0zKJ2r0
         dnjHIRkkXaf6lKnbd1c7R+CG0XE54LOcUWVFFgkPwb5ioumKBgshgO5+wNSM/spFIlJ5
         3YCL1LSHDNhWphxZFaou08WtQKD27XQAA3QnP+Pmd/NlsyygLgxl8p0qo82EifLECacB
         tyCg==
X-Forwarded-Encrypted: i=1; AJvYcCUjKUYqybjSg67FY7p7ErxgHFQf5Rw/EqV15SSBwVbY3ppThUqWlJEWsdRXXztO//gGUwJm7J9wlCYaim02jcM7ptRwLKNf78PUkQxUlXlIWZmx2drCSZ6ui02wr5SEm6pux5ctrtvg
X-Gm-Message-State: AOJu0YwNNzBHPCOsMgoau2yTsUKAa6gTu2x6ZB5QzDnBqgJdBkhGKaUk
	VPq4BdK7up4OcgEmJpCoYpXRD1XpfKd8+ewWpb8uewnrrK3UayLGL8cvE3pq4JGfrsgeMzzvH4u
	eBY/4UTIKdDIByv7E/B5TtSDfko+jaA==
X-Google-Smtp-Source: AGHT+IF3nx15+9RDSgQQTFHFfV+rnjufSpqAUtxzRidsx+tpGjFlFdupQCBDtG9zEF4VjZ55ApLK/ww1KQhC0b9MIj0=
X-Received: by 2002:adf:fe92:0:b0:354:be7c:954 with SMTP id
 ffacd0b85a97d-354be7c0c11mr4671482f8f.15.1716255911450; Mon, 20 May 2024
 18:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716026761.git.lorenzo@kernel.org> <8b9e194a4cb04af838035183694c85242f78e626.1716026761.git.lorenzo@kernel.org>
In-Reply-To: <8b9e194a4cb04af838035183694c85242f78e626.1716026761.git.lorenzo@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 May 2024 18:45:00 -0700
Message-ID: <CAADnVQLV4=mQ3+2baLhfJi_m6A72khNxUhcgPuv+sdQqE7skgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] samples/bpf: Add bpf sample to offload
 flowtable traffic to xdp
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netfilter-devel <netfilter-devel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Florian Westphal <fw@strlen.de>, Jesper Dangaard Brouer <hawk@kernel.org>, Simon Horman <horms@kernel.org>, donhunte@redhat.com, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 3:13=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> Introduce xdp_flowtable_offload bpf sample to offload sw flowtable logic
> in xdp layer if hw flowtable is not available or does not support a
> specific kind of traffic.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  samples/bpf/Makefile                     |   7 +-
>  samples/bpf/xdp_flowtable_offload.bpf.c  | 591 +++++++++++++++++++++++
>  samples/bpf/xdp_flowtable_offload_user.c | 128 +++++
>  3 files changed, 725 insertions(+), 1 deletion(-)
>  create mode 100644 samples/bpf/xdp_flowtable_offload.bpf.c
>  create mode 100644 samples/bpf/xdp_flowtable_offload_user.c

I feel this sample code is dead on arrival.
Make selftest more real if you want people to use it as an example,
but samples dir is just a dumping ground.
We shouldn't be adding anything to it.

