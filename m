Return-Path: <bpf+bounces-46068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14759E37E0
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96489169652
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C91B0F18;
	Wed,  4 Dec 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KB7E5aLB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFDB1AC448
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309419; cv=none; b=mSjEfWCo90bW5H2xUeVN44odW7LkcJhzqiMQqG+jvPKL7ak8FVPLaWy5GNYfjlHhZUO6+WJwS8H4PqJHxXmz+8e8r2bfj65sO/07esrq8fVxyuF0532hDGZzspcqU1imrMvZap53VEK6/8ISQzNQsC4wAZvCs+JfmGEOlq1TK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309419; c=relaxed/simple;
	bh=O7AAxs6vW2+RO41dDnaUkO1eKDddNfEdy9sdkaeIrj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WTgivnopc5LLOP1/sCMpJg/h+ESCljecSKz95xElMNn10EfOVk/0LLraAwPsx+Yb8I6JlhpKsJycUAxj5Qx4Pe3cORxlpM+CMIvAq1SZGY+X1zqC4+Wd6WNMsiIH9K23AB0lu9G7nI+sX1s024tIaH+jWbCQ3IeP4WgRIPDu79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KB7E5aLB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733309416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7AAxs6vW2+RO41dDnaUkO1eKDddNfEdy9sdkaeIrj8=;
	b=KB7E5aLBHCgKZ3EpzCB0MaC385AS7BbH7BQDPDAcssAqALFvp96GjBXUYSXq6WMa1bdQOA
	JfjldVgQaXsYWP7Yb7hvkPzv9vj6VY/W3DBCDZk3fFdEIb1bwulnXH+XzbXJ3mv45ta2dM
	+6jWQ/5w/deqLhY4Qg/Xf0BlJ2gAXpg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-Ht5P6XP7NMu3oPq2UjCecg-1; Wed, 04 Dec 2024 05:50:15 -0500
X-MC-Unique: Ht5P6XP7NMu3oPq2UjCecg-1
X-Mimecast-MFC-AGG-ID: Ht5P6XP7NMu3oPq2UjCecg
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-300182b93easo4588101fa.2
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 02:50:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309414; x=1733914214;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7AAxs6vW2+RO41dDnaUkO1eKDddNfEdy9sdkaeIrj8=;
        b=kbFG0dCCDQsgc+n8QRqPGXJpvUU3nOUPvh4Fxso2IDCziMz0fvOYy3re48YfToR1Ny
         yDZj5uusr1UJ1YvU/GbCw8xyxwlygQY/HIGEUCUTMs3STigodToKWXLs0gxlJ/ngDPS9
         CvKFTVOSsI2ZNO3cEHEERBO4Uy7RHRJU+JB+FU3t6CbDv1ldf7STb6pFIqQ2UFL5wGEc
         eDNV8bgiWNVFuqMt3GrNpZh2i+pSGXKQxFvVzDzy8n0ahBDNwpfbwSdqNELYKhg9o3uz
         aANVMDRX6XwDTFtotyLbGz7SxrW5J7OEylx1YZ77B94PKcsYLj3rEVZjCHqWi6Q79D21
         ac/A==
X-Forwarded-Encrypted: i=1; AJvYcCWseR6e0enVNv/KJWWZkzdCMjdp9UOWQKYaEAkkSH7KNXJifVSrOxWWOY3d30b8aFyugIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSnW/NDfflLwh26X2G70xB8JvXzg8zAso5YSe/oKmiZ7KR+eg4
	Vp32Tt1JV5VKKK6AiTFKnfQYVZ79UoOBnAIYW4vqAmrJ8a5U+1/uCH5P/5nI+YNUhxWTMgg84LD
	h/t1jZhdwV0I3qp+pKZf2pnnsNevGaAAGJioFWDBrADUrz3odgA==
X-Gm-Gg: ASbGncumiEqqYdNR+Sw+pCKIpLf3xcIhQrhCWSSKa5OWWZygtTPUzJTpXjgzjnV/VyJ
	oMz4eQU+qcIzmE0IGkuZrYF17RZtWPoDQn9MlYOszz50uejFKO5qyzt6CzEXiL4Yr88OlfPglo+
	LhKmNfVYp0L3ToiFIuKwGNf4FtYWqK/4cJrGnKEVmcegL5LTIkgglfwF7Nl88fehqLHoKbvMfb6
	jJSDTSSXI1aXBd93FR4+9QVmmyqwT4WuUQs/S+ABG78Yqw=
X-Received: by 2002:a2e:a58e:0:b0:2ff:d7e8:bbbc with SMTP id 38308e7fff4ca-30009ce0bacmr53657451fa.27.1733309413920;
        Wed, 04 Dec 2024 02:50:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfxB9/ZapzifOSM+BxHGW3corqQgL/f1b34L8O3QJCLkSmKjBpOXgMxOQShubXYhGxcR45sA==
X-Received: by 2002:a2e:a58e:0:b0:2ff:d7e8:bbbc with SMTP id 38308e7fff4ca-30009ce0bacmr53657081fa.27.1733309413497;
        Wed, 04 Dec 2024 02:50:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599973202sm712069266b.198.2024.12.04.02.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:50:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F2BBA16BD10E; Wed, 04 Dec 2024 11:50:11 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 08/10] page_pool: make
 page_pool_put_page_bulk() handle array of netmems
In-Reply-To: <20241203173733.3181246-9-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
 <20241203173733.3181246-9-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Dec 2024 11:50:11 +0100
Message-ID: <87r06nafj0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Currently, page_pool_put_page_bulk() indeed takes an array of pointers
> to the data, not pages, despite the name. As one side effect, when
> you're freeing frags from &skb_shared_info, xdp_return_frame_bulk()
> converts page pointers to virtual addresses and then
> page_pool_put_page_bulk() converts them back. Moreover, data pointers
> assume every frag is placed in the host memory, making this function
> non-universal.
> Make page_pool_put_page_bulk() handle array of netmems. Pass frag
> netmems directly and use virt_to_netmem() when freeing xdpf->data,
> so that the PP core will then get the compound netmem and take care
> of the rest.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


