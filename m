Return-Path: <bpf+bounces-35432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4859693A8E0
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 23:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C8A2831E4
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 21:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8931482EE;
	Tue, 23 Jul 2024 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fyfp56ZR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94566145FE9
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721771392; cv=none; b=cWMeXRn7RxCi0ONb+/pSYhrGhDyHg9865TusD9PqaezRo9YnVZnz2y9H20lP9WWprJgP/HaPYsNKVzaTBWX5fRbxSiuByCR7GmaIlRqhLazrQvkuI/UZZvIEUrrnyF8uoOAL14P2c1lSxJ2JK5JWQGj3qV678C4lcSp0ClAW0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721771392; c=relaxed/simple;
	bh=2SPyJdYRw87M7kH/eiezDyPqKNLNQ+jlKjgodNew6rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6mc419trT9bl943AotccOgGjDxT/WGQcBbx8jYhhIsNSKw4raMjw0/tubOHV/uH1LowW2RJ+Z+OBqMmTQd6TpfZVY44gVjCDuGpHnT5ASWoJf9+O9i4+F/3JDA3sTuexZrso1G1WrF9Dpk6OQgBSqeMoKE826Ke8CeRzuTgOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fyfp56ZR; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0354459844so5689212276.3
        for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721771388; x=1722376188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF33mP3g3PVeShTJgLfx3fwdjlEE8z1s+DJQDSjcr+Y=;
        b=Fyfp56ZR1ESGsr5WcO9ANtOIhEqOM3JSjZfk33f5RdokqN6GS9KYDSotLO4rDc3quS
         RjaSdEa0xexo57qp/8eaJFSf+zj5XZipWjYU5j75zimicvyKmO6rnpXwNNJR6lYmWmJk
         SG8Xxr9K0V+ggX/45/VWRKhbVNl7RGpR5nqlxjZgEbAojfKUDkcdkYwfHCzinB3T4Wye
         jU2Gr6XsGMiaC47jaEWYclfWUf4OEtEWFLohdXMcuV2HfjZSalRjbdEiMVf9YPTCh+7y
         F4XQxmwOHpl+ni2pn+YZF4mTb/UoJS4vHc26G62cqtXWxBfuopA2MLJPu0kXOMGaDy+R
         Ijxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721771388; x=1722376188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yF33mP3g3PVeShTJgLfx3fwdjlEE8z1s+DJQDSjcr+Y=;
        b=UD4+VspTVxiyG0lO1b7O8jwIgD0Fohf/0AnEZ7+nCNvpCnFiurjbA+SUUcKiAmE8sx
         Y5mG5sjuNAUSJnbX2jgSz1g7G1t5VpqgzXn+GRuGLkMojO3EsNaVMQYiu4AcdY0uxX8v
         LZTvpsktLdRLpTN962R05o5e7zAqpW/urP0Yo9gVgtmOFeqklnBDCOunFP75HJfjnEtK
         w7H5sVdFyTsBxJZLyzMZrs9Yw9EErsfQmidPdv7xJ7l318V0BzIHWpETUgn5eQfcUwNo
         cX6cYLEaLCWfmSlfS3bS07mIcWW5HhJsrJ3f0jZ23Iv6Xlsx7aO6BcNAV7FKyp16LM4S
         hwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIXmPoBvn5isF9gP6J50Kskj3rhm5R8CfD/k7Q6M2UOgptFwKKgZ2l1iXvSCdY3tLSU5G7Vj81fw1mFW1TBtni814x
X-Gm-Message-State: AOJu0YxH2dhoJ9/J3c64SQhWyBK6cvdQlgvOoOmlzwpQ2l0QbztWXz9L
	pf3uvoz0XToUSebEc95wzR3rCc95sh4mpTnHZuEp9eVcgX+7sOn2t4/hDnX1bp67OXRQQt2fPDx
	UpjhvaNE65A7qWD4N6UucoxHrZ5weiJBjzeKl
X-Google-Smtp-Source: AGHT+IH5JJRTlNbepSdsOAGPfU8tDz3MNG4de1Wtf/RZgU4beT2V9Y9SRFjNnPwNA1SLBZA82p/Z63pCaOnO/csApGk=
X-Received: by 2002:a05:6902:1108:b0:e08:7607:bbf3 with SMTP id
 3f1490d57ef6-e0b097d5744mr1316657276.34.1721771388342; Tue, 23 Jul 2024
 14:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-4-almasrymina@google.com> <CAMArcTUqqxam+BPwGExOFOLVi3t=dwA-5sSagKC5dndv07GDLQ@mail.gmail.com>
 <CAHS8izNS5jZjPfc-sARbHV7mzqzH+UhHfAtCTKRRTfSAdhY4Cw@mail.gmail.com> <CAMArcTUdCxOBYGF3vpbq=eBvqZfnc44KBaQTN7H-wqdUxZdziw@mail.gmail.com>
In-Reply-To: <CAMArcTUdCxOBYGF3vpbq=eBvqZfnc44KBaQTN7H-wqdUxZdziw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 23 Jul 2024 14:49:34 -0700
Message-ID: <CAHS8izMTGgZ+4fOKegUDLqAoxrdVEb+nqjQEt8bP0WLBV=FfrQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 03/14] netdev: support binding dma-buf to netdevice
To: Taehee Yoo <ap420073@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:37=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
...
> Reproducer:
> ./ncdevmem -f <interface name> -l -p 5201 -v 7 -t 0 -q 2 &
> sleep 10
> modprobe -rv bnxt_en
> killall ncdevmem
>
> I think it's a devmemTCP core bug so this issue would be reproduced
> with other drivers.

Sorry for the late reply. I was out at netdev.

I'm also having trouble reproducing this, not because the bug doesn't
exist, but quirks with my test setup that I need to figure out. AFAICT
this diff should fix the issue. If you have time to confirm, let me
know if it doesn't work for you. It should apply on top of v16:

commit 795b8ff01906d ("fix for release issue")
Author: Mina Almasry <almasrymina@google.com>
Date:   Tue Jul 23 00:18:23 2024 +0000

    fix for release issue

    Change-Id: Ib45a0aa6cba2918db5f7ba535414ffa860911fa4



diff --git a/include/net/devmem.h b/include/net/devmem.h
index 51b25ba193c96..df52526bb516a 100644
--- a/include/net/devmem.h
+++ b/include/net/devmem.h
@@ -68,6 +68,9 @@ net_devmem_bind_dmabuf(struct net_device *dev,
unsigned int dmabuf_fd);
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding);
 int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
                                    struct net_devmem_dmabuf_binding *bindi=
ng);
+
+void dev_dmabuf_uninstall(struct net_device *dev);
+
 struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
 void net_devmem_free_dmabuf(struct net_iov *ppiov);
diff --git a/net/core/dev.c b/net/core/dev.c
index 5882ddc3f8592..7be084e4936e4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11320,6 +11320,7 @@ void unregister_netdevice_many_notify(struct
list_head *head,
                dev_tcx_uninstall(dev);
                dev_xdp_uninstall(dev);
                bpf_dev_bound_netdev_unregister(dev);
+               dev_dmabuf_uninstall(dev);

                netdev_offload_xstats_disable_all(dev);

diff --git a/net/core/devmem.c b/net/core/devmem.c
index e75057ecfa6de..227bcb1070ec0 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -362,4 +362,20 @@ bool mp_dmabuf_devmem_release_page(struct
page_pool *pool, netmem_ref netmem)
        return false;
 }

+void dev_dmabuf_uninstall(struct net_device *dev)
+{
+       unsigned int i, count =3D dev->num_rx_queues;
+       struct net_devmem_dmabuf_binding *binding;
+       struct netdev_rx_queue *rxq;
+       unsigned long xa_idx;
+
+       for (i =3D 0; i < count; i++) {
+               binding =3D dev->_rx[i].mp_params.mp_priv;
+               if (binding)
+                       xa_for_each(&binding->bound_rxqs, xa_idx, rxq)
+                               if (rxq =3D=3D &dev->_rx[i])
+                                       xa_erase(&binding->bound_rxqs, xa_i=
dx);
+       }
+}
+
 #endif

--=20
Thanks,
Mina

