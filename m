Return-Path: <bpf+bounces-77444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 544FCCDE32A
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 02:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C368300A1D7
	for <lists+bpf@lfdr.de>; Fri, 26 Dec 2025 01:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E01D1A76DE;
	Fri, 26 Dec 2025 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yni7qfB7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3jn9EfH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079A91799F
	for <bpf@vger.kernel.org>; Fri, 26 Dec 2025 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766712705; cv=none; b=NKjgj0HnLqTZKesoEfDUlSKMzOmNAWfVDlq03gSKDzBFLSWQySKw95RaV3ZTdwx8zRG+TAXPI7F7QzRpijB3FsFrXZ/vKVN3cy8Fs4iLOXM4a8ajZnJXvCn0kaSBUipRpJuJbTL5B88FNgN42K7WDUN561Nz5jKCc1EvkSrriDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766712705; c=relaxed/simple;
	bh=EEJ0crxTC9rZ7Z/JWyJ1blAZ+MavApQb1iFxiRM/QeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkfSbHSmktX93WUemqgx+55UMHRBbHpvUz++gpQUrOp0dtFKd/NpPH8G3BVj6AGf2XdEpHQU+GtPVBiTo/6hPTWvVtIDGwgkVjg+N/Z0kBZScb/qyYFMFBC1Mpj7820o5l1Wd6Xu1YLgcj4O8dFl2Oa+fjmfTXpjQyq3pN2RWsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yni7qfB7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3jn9EfH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766712701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6vEHwSPLbMYTon6GIevS+ZEJhvcN0whZXuCpRgpcdQ=;
	b=Yni7qfB7m9OA3MXAhQYUDHf1O0/ax45Bd0cmOZpqoqrFYQbUIoV6l89HcPjwldAjU2qO4u
	Rf4qIiCb/nBa7QxEqBdz07AVdfyLBMtjKKK/Fi2jbBom5HqmvvZR40i1ndsb7vJS3QGdSq
	v2uE11ZBH3vyQ7mathg9Z86ZiNvdMWg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-SiCJMceSMz-pj1NbojzJZw-1; Thu, 25 Dec 2025 20:31:39 -0500
X-MC-Unique: SiCJMceSMz-pj1NbojzJZw-1
X-Mimecast-MFC-AGG-ID: SiCJMceSMz-pj1NbojzJZw_1766712699
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34c5d203988so14647679a91.3
        for <bpf@vger.kernel.org>; Thu, 25 Dec 2025 17:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766712698; x=1767317498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6vEHwSPLbMYTon6GIevS+ZEJhvcN0whZXuCpRgpcdQ=;
        b=H3jn9EfHyqO5+PVetWDV6hMTQXC0GoQof5e4PKnFu9nc24rTvnfdteYD11vAXdrDsN
         fBjnpZ0kuLouxnxtTB8TQzNyjHvfp4gvGfqw8MoOlplYFmMjMdqMQ8ixqIGeoXR6gjVU
         V0Y18U0T161qkOiyk7eSw87q8I2ZqHAmHDo4ni1PKVd520bHVUAER5BoA7KUwz69G5Ze
         1G0LGHIqg804xSQ5xY4cSRCP2jzolJSIPdHEFoWcR09uENOOmE5rqEvsvmOsm2oYUqmy
         GcyEU69gUP++KHoti+sVDbwpTX+pitx4wnfzTYXwD6HPGWQ1UFmmagiCVxGTSsc9BZcZ
         ebWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766712698; x=1767317498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F6vEHwSPLbMYTon6GIevS+ZEJhvcN0whZXuCpRgpcdQ=;
        b=mfTHegJroRqRjeZUd1gotikBOg56f3sfr0MUTryHFvFAt04GLdZZG9HvGLIjlUle9D
         JSHv8hgDU+cQIxcbzkYSoZ+YEQFrxPYlGTh9QSLGxgbtWiYuLoyWwjVQktbJ2MPyecWC
         +ikxW0O0Qo08tFiVv9iIRwdYyfwy1gUpmzBiyKSJkgpE/yZcCpDo3oUWIrvZJtv+FYRC
         yeD8kOOd/WTvPebgJGTmyYPb3EjyJKWH0fYruFLkiURP92bguCKcAsTn4Ip57iukmppt
         mHenRQs7t4vN+yrdS76UzOu6X0FgKHOPdMWimq6RhA4AlyNP/Jq5gm4LyLgaK7yNCc94
         yIcw==
X-Forwarded-Encrypted: i=1; AJvYcCXpBbQsxhA4kMcrsQlZwWewLa20mBBYgipaQ0h5ZNAK5b/SSIg0lEIz645eaQDF8t360ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxglaGVRjwnXDiPm5uq55o5FaprjDWJLZ1f1V06EXNtZd/PaMms
	xbRakrmNy1D2eSeE0/6DI9JbFQ6iRIZGT5eFAMINI+7/64GfvbIwc2lYRR7to5FWzR1oSZmKDB2
	8l8MvWMDZuWNfXKU/X5kBOILAvG0vXQrCcPp1qLXeHtpvYCHURadPjV4nv7W7F07MJ0EoNs9oNU
	5U+D55g8BMPbykQVsJ5XJfsANI5AulzdwvLm/NRjU=
X-Gm-Gg: AY/fxX5+/OSAYptfl/kbHGN+PDBN8qwxp/soJ3/rDfRk9g5K4Db40g0TbhklWZFHMR2
	hm5M9mN9wY3jUOKVxQd3tBzIEC2mdcipI1GUX5qurEgpzj/tPS2vMxBszVYiSmfnSZgEmFFFVlf
	UznrLwxSKI1WqL1jr6R4cWPJ0J080PeyNaMlW28e3WHr8lXku7ptZTAYLQ6v8ekXx1CunM
X-Received: by 2002:a17:90b:28ce:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-34e921448b2mr19061596a91.12.1766712698354;
        Thu, 25 Dec 2025 17:31:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfDLUNXaA4vnS159ahikBffjf95vdU5q9+k7UAJ9SZruAaAPrDNmu7aJdwlO54UokDbplRgWPYJOEMbtGxl40=
X-Received: by 2002:a17:90b:28ce:b0:340:c64d:38d3 with SMTP id
 98e67ed59e1d1-34e921448b2mr19061568a91.12.1766712697950; Thu, 25 Dec 2025
 17:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com> <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com> <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com> <20251225112729-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251225112729-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Dec 2025 09:31:26 +0800
X-Gm-Features: AQt7F2qcDC83KcLofPp3_PLoz1EWH_p2ikDpQkczGnwan7bSlzvlAkicGkB6Jgs
Message-ID: <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Bui Quang Minh <minhquangbui99@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 12:27=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> > On Wed, Dec 24, 2025 at 9:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > >
> > > > Hi Jason,
> > > >
> > > > I'm wondering why we even need this refill work. Why not simply let=
 NAPI retry
> > > > the refill on its next run if the refill fails? That would seem muc=
h simpler.
> > > > This refill work complicates maintenance and often introduces a lot=
 of
> > > > concurrency issues and races.
> > > >
> > > > Thanks.
> > >
> > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > >
> > > And if GFP_ATOMIC failed, aggressively retrying might not be a great =
idea.
> >
> > Btw, I see some drivers are doing things as Xuan said. E.g
> > mlx5e_napi_poll() did:
> >
> > busy |=3D INDIRECT_CALL_2(rq->post_wqes,
> >                                 mlx5e_post_rx_mpwqes,
> >                                 mlx5e_post_rx_wqes,
> >
> > ...
> >
> > if (busy) {
> >          if (likely(mlx5e_channel_no_affinity_change(c))) {
> >                 work_done =3D budget;
> >                 goto out;
> > ...
>
>
> is busy a GFP_ATOMIC allocation failure?

Yes, and I think the logic here is to fallback to ksoftirqd if the
allocation fails too much.

Thanks

>
> > >
> > > Not saying refill work is a great hack, but that is the reason for it=
.
> > > --
> > > MST
> > >
> >
> > Thanks
>


