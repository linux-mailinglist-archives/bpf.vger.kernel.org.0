Return-Path: <bpf+bounces-61311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66589AE4D47
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 21:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB629189CEF7
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951AA2D4B4F;
	Mon, 23 Jun 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iarOq283"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66C25F785
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705765; cv=none; b=M2zco1k0ewcowA1Bhil6lNwHcATY+uIeoTNCyEzWz1GqYfgckRxmIMEoCE95C+03SmlPUISGxeIZaxGEaZzGnfWHHsd2k+LDt4Gv697mk4sSBWgFXu6wvf0D8djgGiOzktSK1aCJtPO8CM6FWvNzugyDYyz8IOrqKwjM+A5FRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705765; c=relaxed/simple;
	bh=tH3eSBTG6tbTZzapgRbeJfffzzypj/6/QYNfupAEtkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1lDehMmVxPoUNvPpWgCqangfGLwhoWP8VCoMt8zLbC4UEFt/fBK+7vaKri0+yz4NXBHGCi1nuBtmVy+BmDuou6wAOul7cPdCpI/NHtZ08klxxBh6cgn/3ofz1GR6QmuHbUwczdc/B6gJNglRXhSalmKRBOirSL1AqcAMvDRWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iarOq283; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235e389599fso46415ad.0
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750705763; x=1751310563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cp/0chDgm2snxzxzq95eP+vthqt+mdAU4GERCYRoDSo=;
        b=iarOq283A+lGOwRY14zh7T4XNo+d4ywWBZL79etz5yP8MOUIm5q/u2k6u9wit31SVg
         UyzkcYRDvtOgmkdfGg60oGYhBmaHyQBPAMtlNUSwr7BVCnqxsmsPvf33S380tFv5qLiC
         YlFvahde1iBEHaMrTb7s6O/tX6gIcQXeZLCyZNK3VlbnW05UUUglXjtgo3c9YzJFabPM
         8Ht+vt58wZtH1fb6jne+Rcob6VaGqS6807gcly13IHhNtY/Ujl19BoX2w6tatkdHIRI3
         c9OBhyJafjKO/XuJPkM9VehSR3ThlyE8CG6/C4g/SLjjnyHc1beLnVpvUQqzl2Op+/NW
         hCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750705763; x=1751310563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp/0chDgm2snxzxzq95eP+vthqt+mdAU4GERCYRoDSo=;
        b=EwF0E2BQK8HsTo8hL/tlp1IFOZoaHPrWrGLtUNZtEIVK2SNkEi+M6M7obiU9outUUz
         W7Gp3dJ9LubTaTbmCDWlDFL1TVCdpBUIAJnrsO91ik+nS01duSDgHhCv6x3q7DpSgGNc
         GVps5W55LMd/OlPV9S2UEOv3Huuh1+UJQ44+avbdOHcMCkUWdCfeMPUQUoba9zq3fvHE
         CRNI8QfvhP7Keou9REeeK4umdca3wgvPSzF75tECTpLidEZ3noz4qvkEA9uU2mUANta0
         z86/XO048U/9sOviaqzJ6YmzuwQZkL8vdxyyLdx1h9PtsNCDhasEdSmLrXGl6EpH1vNi
         ZYhw==
X-Forwarded-Encrypted: i=1; AJvYcCWm6AYTOgOCL3+onduycAqbKBE+KAJ6PU8T/rTuzqS6xvsJ13z+xjkzwRMXfub9/55c8sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZFuYhF5CbhdYUtwIxigmE1M4EdzCavLgH+DiEa0bbLbSaWdF
	mEaTyzWhbbSHTXlCMsQJiYYw1TmLfDy8V4I/Sjt38AvKYeZdH2Rzjk4PgihTlMPd5cLhz0qb42d
	DLfywI/IWsnBxKBThoYB3MWva/yCMw76RDKj768Sl
X-Gm-Gg: ASbGncsB0/fjSRkl82K0+0LJBGAHq9WlUuV0uOOzBEp6WNl2yQgzIU0zY9fx3GAUZCK
	zDzXopbTaUW++Dr0mQhohn7rHh+8y3QwgdH+U6lQdw5Y7VZw0h5EG98mhkVIQfq+oiaEbq1MxrI
	2/2iS5uZJWefOkkbx1T1PIM7LlwXLJzaeoU/2G3w3bduBRd2nrbPFDT8jbBgvdRCOciUY9w9xR3
	A==
X-Google-Smtp-Source: AGHT+IEP6CbJSMMIjAaNAJ9rOrnxvip7xFCbKZZbgsFvTLW3kA7gzinjehuUnzT5TsDabxmVW7mRkxDk9owGN0VC6EQ=
X-Received: by 2002:a17:903:41cc:b0:234:b2bf:e67e with SMTP id
 d9443c01a7336-23802c66acdmr344235ad.13.1750705762491; Mon, 23 Jun 2025
 12:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620041224.46646-1-byungchul@sk.com> <20250620041224.46646-2-byungchul@sk.com>
 <8eaf52bf-4c3c-4007-afe5-a22da9f228f9@redhat.com> <20250623102821.GC3199@system.software.com>
 <aFlGCam4_FnkGQYT@hyeyoo>
In-Reply-To: <aFlGCam4_FnkGQYT@hyeyoo>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 23 Jun 2025 12:09:09 -0700
X-Gm-Features: AX0GCFuS5sYOE7MPEWKATp8YxIxvbHC-ghHV1COC2m3qIITA4p4mPOlFQEJRPtU
Message-ID: <CAHS8izMbtp0dN3+PZsivFD4Zg1DqaL5BJ4cw4jGjs=wCXAns3A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Byungchul Park <byungchul@sk.com>, David Hildenbrand <david@redhat.com>, willy@infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org, 
	hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net, 
	john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com, 
	toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, 
	saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 5:18=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Mon, Jun 23, 2025 at 07:28:21PM +0900, Byungchul Park wrote:
> > On Mon, Jun 23, 2025 at 11:32:16AM +0200, David Hildenbrand wrote:
> > > On 20.06.25 06:12, Byungchul Park wrote:
> > > > To simplify struct page, the page pool members of struct page shoul=
d be
> > > > moved to other, allowing these members to be removed from struct pa=
ge.
> > > >
> > > > Introduce a network memory descriptor to store the members, struct
> > > > netmem_desc, and make it union'ed with the existing fields in struc=
t
> > > > net_iov, allowing to organize the fields of struct net_iov.
> > >
> > > It would be great adding some result from the previous discussions in
> > > here, such as that the layout of "struct net_iov" can be changed beca=
use
> > > it is not a "struct page" overlay, what the next steps based on this
> >
> > I think the network folks already know how to use and interpret their
> > data struct, struct net_iov for sure.. but I will add the comment if it
> > you think is needed.  Thanks for the comment.
>
> I agree with David - it's not immediately obvious at first glance.
> That was my feedback on the previous version as well :)
>
> I think it'd be great to add that explanation, since this is where MM and
> networking intersect.
>

I think a lot of people are now saying the same thing: (1) lets keep
net_iov and page/netmem_desc separate, and (2) lets add comments
explaining their relation so this intersection between MM and
networking is not confused in the long term .

For #1, concretely I would recommend removing the union inside struct
net_iov? And also revert all the changes to net_iov for that matter.
They are all to bring netmem_desc and net_iov closer together, but the
feedback is that we should keep them separate, and I kinda agree with
that. The fact that net_iov includes a netmem_desc in your patch makes
readers think they're very closely related.

For #2, add this comment (roughly) on top of struct net_iov? Untested
with kdoc and spell checker:

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 7a1dafa3f080..8fb2b294e5f2 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -30,6 +30,25 @@ enum net_iov_type {
        NET_IOV_MAX =3D ULONG_MAX
 };

+/* A memory descriptor representing abstract networking I/O vectors.
+ *
+ * net_iovs are allocated by networking code, and generally represent some
+ * abstract form of non-paged memory used by the networking stack. The siz=
e
+ * of the chunk is PAGE_SIZE.
+ *
+ * This memory can be any form of non-struct paged memory. Examples includ=
e
+ * imported dmabuf memory and imported io_uring memory. See
net_iov_type for all
+ * the supported types.
+ *
+ * @type: the type of the memory. Different types of net_iovs are supporte=
d.
+ * @pp_magic: pp field, similar to the one in struct page/struct netmem_de=
sc.
+ * @pp: the pp this net_iov belongs to, if any.
+ * @owner: the net_iov_area this net_iov belongs to, if any.
+ * @dma_addr: the dma addrs of the net_iov. Needed for the network card to
+ * send/receive this net_iov.
+ * @pp_ref_count:  the pp ref count of this net_iov, exactly the same usag=
e as
+ * struct page/struct netmem_desc.
+ */





--
Thanks,
Mina

