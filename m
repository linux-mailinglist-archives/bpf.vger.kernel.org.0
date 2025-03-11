Return-Path: <bpf+bounces-53850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE2A5CC7A
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 18:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B929D1890B42
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 17:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6877262D32;
	Tue, 11 Mar 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nX2K1N1o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A0262813
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715030; cv=none; b=YeWFz/ejc4c8UHRZi6dIqrCfl+ZlEiee3V+1iQdLHvg76u9njiqrEoK+IF6ecEXwt02Kyzljqadve2QNFCbn2hSecNEpZ7pIN7vzgoP0Noh6+dwqSz8y5iRb8jhijptnXHDCsg49JW37H/6jfMb2qfXflWVe8SX2QzwqWS6imMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715030; c=relaxed/simple;
	bh=EQl4dUNKBuFC7zbSrPP76MIS/Z+D9SSCgDh8o7M/MnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9n+u4x0UHZu2EE8g25djAHNHufNhuYTKWUWtjkMBp+r99XA/6T04sStqkt6xxjMwVxe0WpDzoYNjW+PVoQFzRr9hDkqwabFkG9Es1cQnbKs5XrsRRfCieiwQARuW5iNEU8xMV3fE7soMX18FOa4uCs9idiUzZMbxdbn2pI5xkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nX2K1N1o; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240aad70f2so19105ad.0
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741715028; x=1742319828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zBetAADtGq5no7Asi5NUaHqM/jf+sKjCRdS42kjY9w=;
        b=nX2K1N1ot0CkVZqZdrr0VUvwpY8ct+RAKhgf86kTDQdfrM9FVjfrD6GTpQAosIUcne
         vptZU9K7G0h+E0sGmX9JaxnQi9QERk2QosipZIeZuCw0m2uFUOMOBJkTcWYn8o0ey8ei
         Z3vYH2ePKdmAZLNMyTPDbK2x28i/MrIB3N+fMF7Ddl7gFQYC8naDEHwF73CVQLhWdi/R
         crHSMRrcRfLlbKgEporM22RIn1eypRTNS01xWnqBpYlqMbyo8XzaF0bgt9aStWUH2HES
         C8XCvpgIVIYJV3nbdcltHqOJdNPhqNi7Sh6+W92oiovYIW6IC+bJyAFdqoqv9ZsrkhLt
         6UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715028; x=1742319828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zBetAADtGq5no7Asi5NUaHqM/jf+sKjCRdS42kjY9w=;
        b=YQVsVQHkjuj4rmKyYmVFmzFgbYTer3204Xt6JT3Xg4O/oIpWkBPoefS9YeszoFAc6h
         lpkhMUDQaoZY3yHraXgnMrGKTA05LFBLWs5bEcw/VRLZ+3eo8m8XlmT2ESZyKVw1dWDU
         kh0r2cW/o7ecncwVK5AkBgqfFImX+OYaa6l6QhVERC++cy8FGC+t7R2q5fyzgMImNun1
         tbiVk7bE4JZN3YOpTnrXg7vlBhncENA6NTkrNReeskPUp81g58WpCDJAbRJYMliVuF+t
         5cbhA0rTUHqImbrMhCBo5Fvw2wwOv4gyttPlnhIJJhWzjUBze+v6/D3PtOrZGc/iacx1
         2qbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYon2gSQ3fkMp7a0kK08AQ/DvAX/NFa7NdDfF19s4BsgpYD+uaSJe/nKiQJOAMXx3Pspk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2opXFNuDHnhjIq/kJJj33jkRayj40WW4n0kCsdwaVn9WE9jh+
	9eN2Rf/JRfSKq0m+ZaV+Scxwy825L/9Hwiwz77lmXD15sXGt8N5/4SoarGb9StzzsiQtHASZ9Mu
	GrC+R7guWNlOnS/KxYGNCJ1ym8gBedDSY1kpYP5VDXZC7A3e5wpYb
X-Gm-Gg: ASbGncvSQeaH4WtBgqowFstmp8DgL7ZPuaWC9WhprwJU+TxX1k/12NORg20Fbc3e1QO
	8+HxY2+hUVB2bbdf4Hi0JwyzczlN6lHOaUl4bcWNkbpmfd86H8/8uCOkvpLc40yrQlEbQEUGVEh
	WpJnCanfjSc/S2VuShsdPvoDZMOljya/QVjFzKp1UdLEkqWhEOWqZmNEuy
X-Google-Smtp-Source: AGHT+IG0viV7k+r1zScsboY01e9GThEa/poGwvNx4ZuHaRhrTfDB+LGfpmAHiQC3xjjOmSE4ORjJUE4LPtb24/XlsQA=
X-Received: by 2002:a17:903:2343:b0:224:6c8:8d84 with SMTP id
 d9443c01a7336-225a92cdfe6mr98565ad.4.1741715027691; Tue, 11 Mar 2025 10:43:47
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-2-aleksander.lobakin@intel.com> <CAHS8izNnNJZsEXwZ07zhpn8AjxhGGcm9vyt8uFos1rVvn66qsQ@mail.gmail.com>
 <049ed5bc-5ee8-4fb3-944f-bd2a2116ba21@intel.com>
In-Reply-To: <049ed5bc-5ee8-4fb3-944f-bd2a2116ba21@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 11 Mar 2025 10:43:35 -0700
X-Gm-Features: AQ5f1JrQeLwEPlomx4CbFBeAsPZ2XW-LcXUnzDj2_KAaO2f2uYG6U3XD3Y7zk7w
Message-ID: <CAHS8izOCgFhNRfJwyfr9hT0hCee3yH3hJ53F7Y29c8wnp-pzyg@mail.gmail.com>
Subject: Re: [PATCH net-next 01/16] libeth: convert to netmem
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Michal Kubiak <michal.kubiak@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 10:23=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Mina Almasry <almasrymina@google.com>
> Date: Wed, 5 Mar 2025 16:13:32 -0800
>
> > On Wed, Mar 5, 2025 at 8:23=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> Back when the libeth Rx core was initially written, devmem was a draft
> >> and netmem_ref didn't exist in the mainline. Now that it's here, make
> >> libeth MP-agnostic before introducing any new code or any new library
> >> users.
>
> [...]
>
> >>         /* Very rare, but possible case. The most common reason:
> >>          * the last fragment contained FCS only, which was then
> >>          * stripped by the HW.
> >>          */
> >>         if (unlikely(!len)) {
> >> -               libeth_rx_recycle_slow(page);
> >> +               libeth_rx_recycle_slow(netmem);
> >
> > I think before this patch this would have expanded to:
> >
> > page_pool_put_full_page(pool, page, true);
> >
> > But now I think it expands to:
> >
> > page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
> >
> > Is the switch from true to false intentional? Is this a slow path so
> > it doesn't matter?
>
> Intentional. unlikely() means it's slowpath already. libeth_rx_recycle()
> is inline, while _slow() is not. I don't want slowpath to be inlined.
> While I was originally writing the code changed here, I didn't pay much
> attention to that, but since then I altered my approach and now try to
> put anything slow out of line to not waste object code.
>
> Also, some time ago I changed PP's approach to decide whether it can
> recycle buffers directly or not. Previously, if that `allow_direct` was
> false, it was always falling back to ptr_ring, but now if `allow_direct`
> is false, it still checks whether it can be recycled directly.
>

Thanks, yes I forgot about that.

> [...]
>
> >> @@ -3122,16 +3122,20 @@ static u32 idpf_rx_hsplit_wa(const struct libe=
th_fqe *hdr,
> >>                              struct libeth_fqe *buf, u32 data_len)
> >>  {
> >>         u32 copy =3D data_len <=3D L1_CACHE_BYTES ? data_len : ETH_HLE=
N;
> >> +       struct page *hdr_page, *buf_page;
> >>         const void *src;
> >>         void *dst;
> >>
> >> -       if (!libeth_rx_sync_for_cpu(buf, copy))
> >> +       if (unlikely(netmem_is_net_iov(buf->netmem)) ||
> >> +           !libeth_rx_sync_for_cpu(buf, copy))
> >>                 return 0;
> >>
> >
> > I could not immediately understand why you need a netmem_is_net_iov
> > check here. libeth_rx_sync_for_cpu will delegate to
> > page_pool_dma_sync_netmem_for_cpu which should do the right thing
> > regardless of whether the netmem is a page or net_iov, right? Is this
> > to save some cycles?
>
> If the payload buffer is net_iov, the kernel doesn't have access to it.
> This means, this W/A can't be performed (see memcpy() below the check).
> That's why I exit early explicitly.
> libeth_rx_sync_for_cpu() returns false only if the size is zero.
>
> netmem_is_net_iov() is under unlikely() here, because when using devmem,
> you explicitly configure flow steering, so that only TCP/UDP/whatever
> frames will land on this queue. Such frames are split correctly by
> idpf's HW.
> I need this WA because let's say unfortunately this HW places the whole
> frame to the payload buffer when it's not TCP/UDP/... (see the comment
> above this function).
> For example, it even does so for ICMP, although HW is fully aware of the
> ICMP format. If I was a HW designer of this NIC, I'd instead try putting
> the whole frame to the header buffer, not the payload one. And in
> general, do header split for all known packet types, not just TCP/UDP/..
> But meh... A different story.
>

Makes sense. FWIW:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

