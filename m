Return-Path: <bpf+bounces-43727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5D69B90C2
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 12:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E92281FE1
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 11:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA519F12D;
	Fri,  1 Nov 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4QhVeSD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE519DF8E
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462140; cv=none; b=R9eqx8Hh5q+5UAG087XBttDbJodJd6kTj4A55TiMtEti8+FF9JDs85TQamX72+lQKyEYJRMw1g+DmjrpdqMTIynn60xAfwH5vELg/D/ytsdD1LgzO7CuSbRuyomprCrwiujaEpoJGC/AKXhIf3zPyz7WuMHTB6bPOV7MEVqhnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462140; c=relaxed/simple;
	bh=rLQ4GXrsRTWIucVhLiNMXbTmVHbjcN4k1ofxkLMQ4Hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W5T+FublczKQ2xO6rJs0SzHUsq39Qz8lPlaWzwHeWz0K/gv2oV20GTRAToJRiiiDFXf5xBuwdNCy7XN51dGTzvfaRPm7F2beGo6T/lyWDgkB4zJ+lXE25HQmjbQQ4qe0/pYm6dLC8DXeibLUXcr/RtK8T29xVHhEEfVQHAgYl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4QhVeSD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730462137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLQ4GXrsRTWIucVhLiNMXbTmVHbjcN4k1ofxkLMQ4Hs=;
	b=b4QhVeSDWYtWQmZwadUb1VqcP91qljukyt/1t25cHq2n9yVibD1L0vqqi6C9iN/bhE/BGj
	5HmVveWjcI/Zxy9v8q/QjQVSaiKZzvnJgpw3rKbWjTjA4B41zH/4hdefIK2yagLHxaIl3C
	8297sGTt5w68kRj+79gZnFOVp8gqNhA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-DuXA5tHiPJiJwv7_0QCiJA-1; Fri, 01 Nov 2024 07:55:36 -0400
X-MC-Unique: DuXA5tHiPJiJwv7_0QCiJA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43163a40ee0so12624335e9.0
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2024 04:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462135; x=1731066935;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLQ4GXrsRTWIucVhLiNMXbTmVHbjcN4k1ofxkLMQ4Hs=;
        b=O5m0vKHh+IJyfzuNt5LRGOaOl/t11bZwYv68gnw5MvTZtmsrHGWo7fXESEHBcw/T3f
         b6LJboNvlLbB52PmOgzkYGT1GLwNol4XIGuyZ0AaJOW8Zg0EednS3TqycU3bD5MqokKS
         ypqnAHM7q0IRGkP5MrBuMYxoBfusqSGiXumpgbzUw1aFt1jbe27JErL7NbNmGcMRVH5L
         MUrpEafr/DxJy2JBNCbVYy9PINtoWYhWnTOTtdt0qfVDrjFCnKfhbxw19OWCJ26YfUp3
         Dpdhjt1ep/05u3r8tWKvFGHMO5Ozve1PFWlrnQou1xeibX6ftlTWdIcBDd/KG7p/9hWA
         ZHMw==
X-Forwarded-Encrypted: i=1; AJvYcCVMlewbM1PjLmKZeFfg2JzevZQmdOlk/mRT6+lkQKlIhWM4sIb0cggLfvb9jeWgsqQ1nYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8Qg/DSKBaFhjMffzhg7+sn+Ekt9QJX+k96vCVSzRLzgvC3Ec
	3QUxiOVQ1TQH0aS03xtUcwuM9wkBGVdwpt2wjf7OczuKEdUsIf+1iAeKN0U/q0LxguePCJuYxSm
	7X4hJIbIcJtcm9+3LKU/u110sdyllR5d6c/2ncv4x1V8oZC5xNg==
X-Received: by 2002:a05:600c:44c7:b0:432:7c30:abe6 with SMTP id 5b1f17b1804b1-4327c30aceemr55975935e9.21.1730462134941;
        Fri, 01 Nov 2024 04:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXdZQxj5mJ15uEy0W+r4kOyT+V+7YgqEIK5DabkPt4xJ6deLsXNknYU9o2vdqVUwG8HD9SXg==
X-Received: by 2002:a05:600c:44c7:b0:432:7c30:abe6 with SMTP id 5b1f17b1804b1-4327c30aceemr55975735e9.21.1730462134490;
        Fri, 01 Nov 2024 04:55:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947c03sm88091215e9.28.2024.11.01.04.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:55:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C2940164B952; Fri, 01 Nov 2024 12:55:32 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 08/18] page_pool: make
 page_pool_put_page_bulk() actually handle array of pages
In-Reply-To: <20241030165201.442301-9-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-9-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 12:55:32 +0100
Message-ID: <87o72z9nij.fsf@toke.dk>
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
> page_pool_put_page_bulk() converts them back.
> Make page_pool_put_page_bulk() actually handle array of pages. Pass
> frags directly and use virt_to_page() when freeing xdpf->data, so that
> the PP core will then get the compound head and take care of the rest.
>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


