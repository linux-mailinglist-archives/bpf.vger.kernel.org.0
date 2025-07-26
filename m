Return-Path: <bpf+bounces-64453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F43B12C2D
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 22:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1854954215D
	for <lists+bpf@lfdr.de>; Sat, 26 Jul 2025 20:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA8D21883F;
	Sat, 26 Jul 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJaahnJa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF821E9B31;
	Sat, 26 Jul 2025 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753561275; cv=none; b=rfRy9GdvbnrWckuqKKVgCUOTiSXpiiOoQURlSaLsxt/DWVPF6hKFCn7xPeymxN4WjqFXJwCwfq+n8Nw7cE7jVOFllQ98Xvmi49OIowgSGf+F3k04cgGhlRCLYHyepX/SlHV/lUANqzAz4EMn1cbUNx5ucrsTpU/WjXzBRWynQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753561275; c=relaxed/simple;
	bh=d+vV1+uKtYMWXcbh44yagActClKJSUheJd8jSiDKL+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSOOT3VWHeLS3IM+X0+ny7cdQ9YMDgJqB7kfdK4KVWOd6w7Ohndwu0YZiFxYpFcNsOVQF7pPkrj/ddlqM/eHOO7X3aegI2XS7fvhH0bFED8x4MdGCj/IDpltMClYjn0L2vLSxDc2vOcOJGeYZaG8/Ek7SMrWJWdQ5GR53+n74Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJaahnJa; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-88ba15145ebso3479241.3;
        Sat, 26 Jul 2025 13:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753561272; x=1754166072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXLBNhhIuqv2H8ECnNNfixwBrZQbdtcl0QtjSkHV3yc=;
        b=LJaahnJaMz2thxtOUN9vV11Noev/+R7UShpfkemKPq/C2Xu5JO0XReec3FWXUmkkAn
         atZOcBt7lSBenzwxUwz22ejpTQ+t6LCLCd0bJd5EEBu1Q+C0F7YBKfHIWQmf0qIM3gi8
         2/IRDnp1fgLutyicSEAdd+Pw6rvDvGcmoBXXa8QrDwVp1WUq9YYjPxmrMbWcLHFJ+w7X
         EYdFQFEjxSd72tPqMEybgFiJFwqsE8mRrqaklE4B5+RaMoGLb6Ysx7l4FMI1FyiwBi3j
         dam7jYcj5LhvuV58SqHGa4UuqZMjm6H4T9uRxIpkLYB3BVhEotMx025MArfUEfPFpZEq
         +LQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753561272; x=1754166072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXLBNhhIuqv2H8ECnNNfixwBrZQbdtcl0QtjSkHV3yc=;
        b=p7Svql6lAXFuJ+9IPgQEfvwrpMTCwSVzlBJy7XsRRxZrx1Sfpo84Y6/wLtXiHkeYvg
         CSQo0OUPIzjRVq98zcX0q42rBkM7blebgtgo2R83PBENMt7HdOzqdU+k3DypfBhJJ4rZ
         GgavvUda0S5AohpJSRXM6/z5nQkHq36oLisp2iv9y4jn8zowwM4NcFg+jbvEO2pjCC4N
         J7V7mzFOHer2VFzHcrubSpqif1CuDm47ja7MvWo1esSpEb6lz00yfvtD9LVTjkADrRSZ
         Xvk0kt6ADhDkFhJ5oTecf8MaIDMRpZdIk8BqPIH/ma6f3WNdd6Smd1HC8hYNLIUo3OBI
         tMag==
X-Forwarded-Encrypted: i=1; AJvYcCWEmZNy2bHBQFobvAsojFtXVbpipqsp1SJWuzysiITTCC62mhN0Jm1irEN8sywcwGoxa7nTOX6R@vger.kernel.org, AJvYcCXu/APrf7YW9W8pOe5TKgTiXLh5Gvlza1HITvvUWEZCqzUpkQS4O1xIiPop+WJX+wH37M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGVK9r+Tc8ThGzcMEsB7kgaCVU7SXyVJHr/VrJFoOZl9ovZW8Q
	4tYXatIhMoPcMMvESvGHyhcaeueu5PmPV+iGCrgOt0hTL9lYvmChQEIfzWbBywV27MZ/fqBMipE
	i13ESAW94Q6cA7wfYhdJ4NqzDhHgcGfLFRr4=
X-Gm-Gg: ASbGncvL88iTJ6xxnAr74/vdPUsUxjLXdrsqjJHg5OqOlXi2oNpeZdLXL5bLm4GIcA/
	dlzu0X3gOnDvXEtNDMaYNCIZXiHRsEh3bDxBbzgP5M9hU/6paBRWUkgUMAncX8+Op7SBVzKjF5s
	QhMqQKUbP5IubmCnsPXkjzcf42P09qsT8kKuT+va17+NerHNVbP019tCp5Rf5aHIB2fU9Zvscr4
	BQIDZnDFcNpzHXuzinhOYkGAzpzj1kGakejj8g=
X-Google-Smtp-Source: AGHT+IFNLNMDTQWY4EvOAlwWXTUT6KX8JXIB4fcRrEIADD/aI5lf2ybeDeP2tJyVUvOtFWNH6H2kJwAZdltYUL1t7BQ=
X-Received: by 2002:a05:6102:3750:b0:4ec:c510:e014 with SMTP id
 ada2fe7eead31-4fa3f7ed87amr977132137.0.1753561271666; Sat, 26 Jul 2025
 13:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723003243.1245357-1-chenyuan0y@gmail.com>
 <CH0PR18MB43399E06C1EDC7DE70AE7170CD5FA@CH0PR18MB4339.namprd18.prod.outlook.com>
 <CH0PR18MB4339EE7E08DBD7A4F6E3EA72CD5FA@CH0PR18MB4339.namprd18.prod.outlook.com>
 <77ce8301-38e5-4d13-9b76-0d731f8b6a7e@redhat.com>
In-Reply-To: <77ce8301-38e5-4d13-9b76-0d731f8b6a7e@redhat.com>
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Sat, 26 Jul 2025 13:21:00 -0700
X-Gm-Features: Ac12FXxZ6pVQjpRhqcV4h6SdOY9AloO0UjbjNUhKYKzbM-CYTWDy9-t80fd4-qE
Message-ID: <CALGdzuq5D9=HFBwVDxpJm2MULo-Q4qkQuUfZmEHBrpnNJpefXw@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by xdp_convert_buff_to_frame()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Geethasowjanya Akula <gakula@marvell.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>, 
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>, Hariprasad Kelam <hkelam@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org" <hawk@kernel.org>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	Suman Ghosh <sumang@marvell.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "zzjas98@gmail.com" <zzjas98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 3:11=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/23/25 5:36 AM, Geethasowjanya Akula wrote:
> >> -----Original Message-----
> >> From: Geethasowjanya Akula
> >> Sent: Wednesday, July 23, 2025 8:59 AM
> >> To: Chenyuan Yang <chenyuan0y@gmail.com>; Sunil Kovvuri Goutham
> >> <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> >> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; Bharat
> >> Bhushan <bbhushan2@marvell.com>; andrew+netdev@lunn.ch;
> >> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> >> pabeni@redhat.com; ast@kernel.org; daniel@iogearbox.net;
> >> hawk@kernel.org; john.fastabend@gmail.com; sdf@fomichev.me; Suman
> >> Ghosh <sumang@marvell.com>
> >> Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; zzjas98@gmail.com
> >> Subject: RE: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
> >> xdp_convert_buff_to_frame()
> >>
> >>
> >>
> >>> -----Original Message-----
> >>> From: Chenyuan Yang <chenyuan0y@gmail.com>
> >>> Sent: Wednesday, July 23, 2025 6:03 AM
> >>> To: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya
> >> Akula
> >>> <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
> >>> Hariprasad Kelam <hkelam@marvell.com>; Bharat Bhushan
> >>> <bbhushan2@marvell.com>; andrew+netdev@lunn.ch;
> >> davem@davemloft.net;
> >>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> >>> ast@kernel.org; daniel@iogearbox.net; hawk@kernel.org;
> >>> john.fastabend@gmail.com; sdf@fomichev.me; Suman Ghosh
> >>> <sumang@marvell.com>
> >>> Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; zzjas98@gmail.com;
> >>> Chenyuan Yang <chenyuan0y@gmail.com>
> >>> Subject: [EXTERNAL] [PATCH] net: otx2: handle NULL returned by
> >>> xdp_convert_buff_to_frame()
> >>>
> >>> The xdp_convert_buff_to_frame() function can return NULL when there i=
s
> >>> insufficient headroom in the buffer to store the xdp_frame structure =
or
> >>> when the driver didn't reserve enough tailroom for skb_shared_info.
> >>>
> >>> Currently, the otx2 driver does not check for this NULL return value =
in
> >>> two critical paths within otx2_xdp_rcv_pkt_handler():
> >>>
> >>> 1. XDP_TX case: Passes potentially NULL xdpf to otx2_xdp_sq_append_pk=
t()
> >> 2.
> >>> XDP_REDIRECT error path: Calls xdp_return_frame() with potentially NU=
LL
> >>>
> >>> This can lead to kernel crashes due to NULL pointer dereference.
> >>>
> >>> Fix by adding proper NULL checks in both paths. For XDP_TX, return
> >>> false to indicate packet should be dropped. For XDP_REDIRECT error
> >>> path, only call
> >>> xdp_return_frame() if conversion succeeded, otherwise manually free t=
he
> >>> page.
> >>>
> >>> Please correct me if any error path is incorrect.
> >>>
> >>> This is similar to the commit cc3628dcd851
> >>> ("xen-netfront: handle NULL returned by xdp_convert_buff_to_frame()")=
.
> >>>
> >>> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> >>> Fixes: 94c80f748873 ("octeontx2-pf: use xdp_return_frame() to free xd=
p
> >>> buffers")
> >>> ---
> >>> drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 8 +++++++-
> >>> 1 file changed, 7 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> >>> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> >>> index 99ace381cc78..0c4c050b174a 100644
> >>> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> >>> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> >>> @@ -1534,6 +1534,9 @@ static bool otx2_xdp_rcv_pkt_handler(struct
> >>> otx2_nic *pfvf,
> >>>             qidx +=3D pfvf->hw.tx_queues;
> >>>             cq->pool_ptrs++;
> >>>             xdpf =3D xdp_convert_buff_to_frame(&xdp);
> >>> +           if (unlikely(!xdpf))
> >>> +                   return false;
> >>> +
> >>>             return otx2_xdp_sq_append_pkt(pfvf, xdpf,
> >>>                                           cqe->sg.seg_addr,
> >>>                                           cqe->sg.seg_size,
> >>> @@ -1558,7 +1561,10 @@ static bool otx2_xdp_rcv_pkt_handler(struct
> >>> otx2_nic *pfvf,
> >>>             otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
> >>>                                 DMA_FROM_DEVICE);
> >>>             xdpf =3D xdp_convert_buff_to_frame(&xdp);
> >>> -           xdp_return_frame(xdpf);
> >>> +           if (likely(xdpf))
> >>> +                   xdp_return_frame(xdpf);
> >>> +           else
> >>> +                   put_page(page);
> >> Thanks for the fix. Given that the page is already freed, returning tr=
ue in this
> >> case makes sense.
> > This change might not be directly related to the current patch, though.=
 You can either
> > include it here or we can submit a follow-up patch to address it.
>
> If I read correctly, returning false as the current patch is doing, will
> make the later code in otx2_rcv_pkt_handler() unconditionally use the
> just freed page.
>
> I think returning true after put_page() is strictly necessary.

Thanks for the review and for catching that issue. You're right,
returning false would cause a use-after-free, as the caller would
proceed to use the already freed page.

I've updated the patch to return true in the XDP_TX failure case. I
also adjusted the XDP_REDIRECT error path to do the same after calling
put_page(), preventing a fall-through.

Does the updated patch below look correct? If so, I'll send out a formal v2=
.

---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 99ace381cc78..4e1b9a3f6e51 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -1534,6 +1534,9 @@ static bool otx2_xdp_rcv_pkt_handler(struct
otx2_nic *pfvf,
  qidx +=3D pfvf->hw.tx_queues;
  cq->pool_ptrs++;
  xdpf =3D xdp_convert_buff_to_frame(&xdp);
+ if (unlikely(!xdpf))
+ return true;
+
  return otx2_xdp_sq_append_pkt(pfvf, xdpf,
        cqe->sg.seg_addr,
        cqe->sg.seg_size,
@@ -1558,7 +1561,12 @@ static bool otx2_xdp_rcv_pkt_handler(struct
otx2_nic *pfvf,
  otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
      DMA_FROM_DEVICE);
  xdpf =3D xdp_convert_buff_to_frame(&xdp);
- xdp_return_frame(xdpf);
+ if (likely(xdpf)) {
+ xdp_return_frame(xdpf);
+ } else {
+ put_page(page);
+ return true;
+ }
  break;
  default:
  bpf_warn_invalid_xdp_action(pfvf->netdev, prog, act);
---


> /P
>

