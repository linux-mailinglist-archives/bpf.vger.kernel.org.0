Return-Path: <bpf+bounces-56072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4493A90EF3
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 00:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC3D173622
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD022475C3;
	Wed, 16 Apr 2025 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5/XzFrA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA5229B38
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843914; cv=none; b=blP7jHeTPahUUi1xIWLdXD01h0aXELbWgbWoSRPlwuTo9z7qkPTy150ZBRp2dKIViltkJC9j2gGQyQhNNLYyyEU+38Wy6FNDp/n3FxDCw0BIFBa2H/DTFxrs2kA1GfQRz/SHWWQtWMQDqn1cAjEuaV5ySQOyZnjo72cgrM6OwEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843914; c=relaxed/simple;
	bh=IoJJSCOlCHUpZacswypeEIdZhmajgDkZrYjCwe4+91k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmDRq10w1qM0BzRLyfhKtTYhg7H2cZr5Oo+XG58SRp1S0Z7HyVyJ1iE+TQ9fpc0iRaXkP4Pjuttm4cGF9O+mlXD3zrqW/j/VDd7QAzzfn291+h4+16bjt0DmrnYv8MqDusqBzkgM72zG8sj+6D1/vWbyVv5ZdrkKkB/ml8I7XbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5/XzFrA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d5f10e1aaso25645e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744843911; x=1745448711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgiFznxyXwNZAjYFXBtqbEchRNoGqLP4Udb3wMlePFc=;
        b=b5/XzFrAbTLxITj8fEBhq+9TXE7M2zoaCl27FWagkLvqpsGuFKZYBr15J8SQArMn2X
         PPpOgftSvgtG52poAdg86cS6H1cWhaioEbDgmCFtUH+VpMM0jtAnWrye9ZWXLodMfrDt
         wEJmXouc254BJfa7SMDIwU0fX7vg3dP2tRJpGteI+93EUDDTb/9Acy6KFUtYPRXv+MNr
         b0UCqUB9Via5KtkhSjK+63mulH9PocDSlsx2pV7hDJsl/vsiSerrSxBBIC+Lnizuyn9Z
         3MWviFf41F7XxykpbM6AzcywbT7pYwmQwkH9AGEiHG7Rh6aqxeqkAbScYAmQBqsmUs++
         pKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843911; x=1745448711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgiFznxyXwNZAjYFXBtqbEchRNoGqLP4Udb3wMlePFc=;
        b=M3GDkUmvfbs5rD1S424LKvCC7P1hvxz7pbXdPbRTSYppR4g5bE9YMYkNDJjp5ilDRl
         rjuzVV222mTxuLE6z2I4rmRT1kUDRIJjstY6MO1ONaJAlbJdgIPd+SmZ1xm1ED7Rrmgt
         eqOzEumx+fqqPLdFvF4lS8N7PHQpzNVm/FfZGOE92HWJtnquXwOv9sXB41ElCujvjf59
         7tQERbmb3HK5DYzt3cqXFrfW1nQyVE11zZJWf/FTWurnG39KXYfH7fi+2DhykFUrklZE
         OXHYkrGCKHNXkO+A/p6ZFaqsl6XumKrK7FdAg0gt7W4yYw1sPTzmKiB3JoHQraYOfhqZ
         Fo8w==
X-Forwarded-Encrypted: i=1; AJvYcCXjjhOzWu7Px7x7qNFQ65X5wguhBNNlozwCgPcafryhAuV4aYyN4j+ExJgCFuoUcR/jDY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IwieYrdLBAVTt0HJAmjvh0/Hozww1nJOCtIFPP5D+BLxNg+a
	QYO7DbSHoyQhKJ1kmUGM76m/jBbmNs0wSnQHsulp+QNRZ+OzgTdYNEnZRNBg7OY1oFtFmoEpho3
	1T3rVeF6ulhZ2pVLQJztIQ1Rhq0snIcNuqd14
X-Gm-Gg: ASbGnct2r0tNHcBSMRfRSAeGwP/e4hDH0dFmWXduLmXugrBC1cnhzo0AdkieANVzEx/
	MocrSTniBIs3HTE7+R3HbJXdSW2l6IwA626QuUhE0C5bRtSHxD+wcw3jpxPKlybhwPX6+BvP14p
	tx13Xzw/Tjt2PSlEzkZSqYgv+vpFNdg2wC+OeogydkP0J7JjoIiQnEBHTYI++n1w==
X-Google-Smtp-Source: AGHT+IHXWGWfGEo9AOua5ZBzOd3bdHf6i/F7EC52V5Mq1yV8M20CMUTcOJBN7M+4okB7URR+SAXHkZhutXlJ3SZFaXo=
X-Received: by 2002:a05:600c:3509:b0:43b:b106:bb1c with SMTP id
 5b1f17b1804b1-44062a3ef31mr505705e9.0.1744843910585; Wed, 16 Apr 2025
 15:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414225227.3642618-1-tjmercier@google.com>
 <20250414225227.3642618-3-tjmercier@google.com> <CAPhsuW6sgGvjeAcciskmGO7r6+eeDo_KVS3y7C8fCDPptzCebw@mail.gmail.com>
In-Reply-To: <CAPhsuW6sgGvjeAcciskmGO7r6+eeDo_KVS3y7C8fCDPptzCebw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 16 Apr 2025 15:51:38 -0700
X-Gm-Features: ATxdqUF2F5Lgo5RIa4ABADC_SqcPejYG0M9lcwCAu9guCcJWCuAb8fIDqfWHFPg
Message-ID: <CABdmKX0bgxZFYuvQvQPK0AnAHEE3FebY_eA1+Vo=ScH1MbfzMg@mail.gmail.com>
Subject: Re: [PATCH 2/4] bpf: Add dmabuf iterator
To: Song Liu <song@kernel.org>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 3:02=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Mon, Apr 14, 2025 at 3:53=E2=80=AFPM T.J. Mercier <tjmercier@google.co=
m> wrote:
> [...]
> > +
> > +BTF_ID_LIST_GLOBAL_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
> > +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_bu=
f *dmabuf)
> > +
> > +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
> > +{
> > +       struct dma_buf *dmabuf, *ret =3D NULL;
> > +
> > +       if (*pos) {
> > +               *pos =3D 0;
> > +               return NULL;
> > +       }
> > +       /* Look for the first buffer we can obtain a reference to.
> > +        * The list mutex does not protect a dmabuf's refcount, so it c=
an be
> > +        * zeroed while we are iterating. Therefore we cannot call get_=
dma_buf()
> > +        * since the caller of this program may not already own a refer=
ence to
> > +        * the buffer.
> > +        */
> > +       mutex_lock(&dmabuf_debugfs_list_mutex);
> > +       list_for_each_entry(dmabuf, &dmabuf_debugfs_list, list_node) {
> > +               if (file_ref_get(&dmabuf->file->f_ref)) {
> > +                       ret =3D dmabuf;
> > +                       break;
> > +               }
> > +       }
> > +       mutex_unlock(&dmabuf_debugfs_list_mutex);
>
> IIUC, the iterator simply traverses elements in a linked list. I feel it =
is
> an overkill to implement a new BPF iterator for it.

Like other BPF iterators such as kmem_cache_iter or task_iter.
Cgroup_iter iterates trees instead of lists. This is iterating over
kernel objects just like the docs say, "A BPF iterator is a type of
BPF program that allows users to iterate over specific types of kernel
objects". More complicated iteration should not be a requirement here.

> Maybe we simply
> use debugging tools like crash or drgn for this? The access with
> these tools will not be protected by the mutex. But from my personal
> experience, this is not a big issue for user space debugging tools.

drgn is *way* too slow, and even if it weren't the dependencies for
running it aren't available. crash needs debug symbols which also
aren't available on user builds. This is not just for manual
debugging, it's for reporting memory use in production. Or anything
else someone might care to extract like attachment info or refcounts.

> Thanks,
> Song
>
>
> > +
> > +       return ret;
> > +}

