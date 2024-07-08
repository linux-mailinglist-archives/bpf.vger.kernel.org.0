Return-Path: <bpf+bounces-34134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D30F92AA5F
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310391C21B4F
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 20:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A327514D6FC;
	Mon,  8 Jul 2024 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nvt70lDq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BD22E416
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720469301; cv=none; b=hIpwgx+kVeLp6S3tZmVgOjblAGto34K+0twN9ZHkf571q9YdbbcNwDM8KnfC8lc6Unl3dArVjKFT6ICK8+lhLcgzWt02aKIxFoTFp9GpT/JGbaObFrt1NOKqeXxPH6gmicfvCJyXI2zLOFO6SB1NfayzTbWxYt0v51+FHJsMJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720469301; c=relaxed/simple;
	bh=ZRZU9TG8IKJPir335kv6uvmf5/6XvlnF0lVWn7S/s+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANSHtwMZLFLKyyjPAlgmmj5NlkKTtGJCfmGkgwd+yhlmRPnIwZWA01rlocO4+UAaAzakLpc22J+jx1uGSk4/MmBcjoPlSc5d4zBG+Qywx3NYbwJJssFtxmFuTov5r813AsldL6cj9h2iTw/MAOOFE5G1GKH/RBDQNA+cWmOxtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nvt70lDq; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-79f16c85da0so45892685a.2
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720469297; x=1721074097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ef8kYUavZDQKnlAolqYPRC/e9sM3ztTKFUbqIbLKTok=;
        b=Nvt70lDqisNpfwC9Q3U8CpMPR/mXlio5gK5xUUEULro9iTsTMaVhWouG0PNbjJ764Z
         XmuqOmW4OjLY/v8ncqtpAZLDqReczDacqRUd29wMBjK/Pl4UMDLOac/fYtgDxnPuoJuk
         IvS6KFzrbX1CnMTF0cH7coo7IaDMyw1XZt115Qc3Z1r/aqwK4LbCLyhPxSQ+MKzH0BRY
         su7qtvbvu/b/Gm6/C3zgPrrezPL6pUG/2KhsGXdSNhifEyjUHDw42lqBmvOsllSmGx37
         m7jNmIPpAZLTMJS3tYsSuWUEADMiOD8uidBdDgUGHbJGi7yFwJGzzteXip+0OASqNo2g
         7E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720469297; x=1721074097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ef8kYUavZDQKnlAolqYPRC/e9sM3ztTKFUbqIbLKTok=;
        b=bFzhUWTydPWfLataP8DYZ3wyzpoWS+oq09ZmHgPBCiJbAfnVpIQS+a5omdDdtQEtVt
         LHl02JmMvbbVXhRNgHRteXZUFLKBzsXtdXmigPfYCJRJxN8oDUwJattwkiTYMziaeUlZ
         akhlB/GdOL2aSy5juDHxbONQ4NAcXYBFciiqYfCdoj5JFSJxHll6AIjEq05clLgy6VXJ
         FKgkMwyyJsQnLZa84o1/uDLCiNhxGWCW1B4eE6Yz8Q9pJArVwmXVkvDL6EPGyACXzfER
         YpoqBlAqYewndNm9SN+US8hytdTvXsmHVlnvFsk0b4iO7vv3KV6jD7xAFbF9hTBQDtTg
         nlQw==
X-Forwarded-Encrypted: i=1; AJvYcCVglut9iplGhUkAlXHZ4Gif2w0Bp6+V0wCFV1PkExhV010gli4/IYyJZbuDwkfe7jQpsknUSuqvgkSFAAxt+gYXbrO8
X-Gm-Message-State: AOJu0YxBYoxm4kKXigZPlCrUDNErLH9HzGWsxcIAXh5ypNwcs7YUvI45
	Xz+mrVJzven39+MvhUaxnvudR8VLrfQQcWzbTThkq5aHwDuiNkrDJaqaNsc5oGw9R5iPdN72YRh
	0Q81XEE6AWW7MXAiCXMOTVJliQSKgin1RNb6o
X-Google-Smtp-Source: AGHT+IHB+Sby5xb3KQY4fJme46cOICuiSOSK7oxUno8JfmvAwWNnn3nyYgyDJgtIcLGc/wIzDrQoP+07XuveT6i0qf0=
X-Received: by 2002:a05:6214:c44:b0:6b4:b179:8eeb with SMTP id
 6a1803df08f44-6b61c230e3fmr8398346d6.63.1720469296819; Mon, 08 Jul 2024
 13:08:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-4-almasrymina@google.com> <CAMArcTUqqxam+BPwGExOFOLVi3t=dwA-5sSagKC5dndv07GDLQ@mail.gmail.com>
In-Reply-To: <CAMArcTUqqxam+BPwGExOFOLVi3t=dwA-5sSagKC5dndv07GDLQ@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 8 Jul 2024 13:08:01 -0700
Message-ID: <CAHS8izNS5jZjPfc-sARbHV7mzqzH+UhHfAtCTKRRTfSAdhY4Cw@mail.gmail.com>
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

On Thu, Jul 4, 2024 at 10:57=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> I found several locking warnings while testing.
>

Thanks for Testing Taehee! And sorry for the late reply. I was off for
a couple of days. With some minor tweaks to my test setup I was able
to reproduce and fix all 3 warnings.

> [ 1135.125874] WARNING: CPU: 1 PID: 1644 at
> drivers/dma-buf/dma-buf.c:1123 dma_buf_map_attachment+0x164/0x2f0
...
> [ 1136.178258] WARNING: CPU: 1 PID: 1644 at
> drivers/dma-buf/dma-buf.c:1226 dma_buf_unmap_attachment+0x267/0x320

Both of these are warnings that dma->resv is not locked when calling
dma_buf_[un]map_attachment(). As far as I can tell so far, this can be
resolved by using the unlocked versions:
dma_buf_[un]map_attachment_unlocked() which is correct here for this
static importer.

...

> [ 1135.709313] WARNING: CPU: 3 PID: 1644 at
> net/core/netdev_rx_queue.c:18 netdev_rx_queue_restart+0x3f4/0x5a0

This is due to rtnl_lock() actually not being acquired in the unbind
path, when the netlink socket is closed. Sorry about that. This is
fixed by obtaining rtnl_lock() in the unbind path.

With the fixes below all the warnings disappear. I'm planning to
squash them to the next version. Let me know if those don't work for
you. Thanks!

diff --git a/net/core/devmem.c b/net/core/devmem.c
index e52bca1a55c7c..a6ef1485b80f2 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -46,8 +46,8 @@ void __net_devmem_dmabuf_binding_free(struct
net_devmem_dmabuf_binding *binding)
                  size, avail))
                gen_pool_destroy(binding->chunk_pool);

-       dma_buf_unmap_attachment(binding->attachment, binding->sgt,
-                                DMA_FROM_DEVICE);
+       dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt=
,
+                                         DMA_FROM_DEVICE);
        dma_buf_detach(binding->dmabuf, binding->attachment);
        dma_buf_put(binding->dmabuf);
        xa_destroy(&binding->bound_rxqs);
@@ -157,8 +157,8 @@ struct net_devmem_dmabuf_binding
*net_devmem_bind_dmabuf(struct net_device *dev,
                goto err_free_id;
        }

-       binding->sgt =3D
-               dma_buf_map_attachment(binding->attachment, DMA_FROM_DEVICE=
);
+       binding->sgt =3D dma_buf_map_attachment_unlocked(binding->attachmen=
t,
+                                                      DMA_FROM_DEVICE);
        if (IS_ERR(binding->sgt)) {
                err =3D PTR_ERR(binding->sgt);
                goto err_detach;
@@ -225,8 +225,8 @@ struct net_devmem_dmabuf_binding
*net_devmem_bind_dmabuf(struct net_device *dev,
                                net_devmem_dmabuf_free_chunk_owner, NULL);
        gen_pool_destroy(binding->chunk_pool);
 err_unmap:
-       dma_buf_unmap_attachment(binding->attachment, binding->sgt,
-                                DMA_FROM_DEVICE);
+       dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt=
,
+                                         DMA_FROM_DEVICE);
 err_detach:
        dma_buf_detach(dmabuf, binding->attachment);
 err_free_id:
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 4b16b3ad2ec5b..33bb20c143997 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -861,6 +861,9 @@ void netdev_nl_sock_priv_destroy(struct list_head *priv=
)
        struct net_devmem_dmabuf_binding *binding;
        struct net_devmem_dmabuf_binding *temp;

-       list_for_each_entry_safe(binding, temp, priv, list)
+       list_for_each_entry_safe(binding, temp, priv, list) {
+               rtnl_lock();
                net_devmem_unbind_dmabuf(binding);
+               rtnl_unlock();
+       }
 }



--
Thanks,
Mina

