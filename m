Return-Path: <bpf+bounces-61951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D98C9AEF643
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 13:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97171C01834
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 11:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0586D272813;
	Tue,  1 Jul 2025 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eSvTxrrG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59591DED52
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368422; cv=none; b=AkBcDeGi4a/rEwa1+wbyW4kBIwcin7Jx0QzK5MHWKmrQTxIotTWnvLIp+G6YfeUds5AKJUUxFKuUbvr20fJdBXUgiWTRdk60tqQ2pn9/3aJ7rNP9V0UGdUwZJzw3qkoGXVjlmzFLz/BnlHk4D9eORxAMfoIctbJdilzLtEazSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368422; c=relaxed/simple;
	bh=8jDBnTO4KAeg7BWMwqi5hx2TF6/XIeEmV7vlcXF5FVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Frm0ahPv9bp+JSoGrTN4D+Ba/5sW4wtvz69eVooYu3x86XdiK/2lQWwM8lg4ejyP5sKxgHABjqUZhNiGSYmjUjt+xTRg3zufdzoeER1EL+621D+O3JwnOfQ5eitLkyVkOZjbDLR+QLl2PZ8qJBwnEIiuQDcjaLisWSNbEkxM9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eSvTxrrG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so10450451a12.2
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751368419; x=1751973219; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RNW7caVwKhgGVodSQGEfKDOFvOt0nWsTUGnawMeLUPI=;
        b=eSvTxrrGiiM4WD29qyqcewLjbEQgcoLgNIP6VKB5uAMX2vvciNcTrev3wphPfVzoSD
         TqSme+333VSnKjW7lpforxyIt3lis1G1X5y8RYUBbxjbHtsEVHmCrwW3use68w0mZKlk
         vSKMLmjOj++UDAWWpRHWE/6H+qJeUqjhRAZVGqmk8FQVhyuh2tigfojXo0HSQ0C/NGZu
         h+cEyNo7ik0XSkAwa9a5GvRQMSCXdp1Apcem8vfT5m2EiLe+QWrlVoAhN7IlVNR8Viv2
         sVp9V9lGCjyvM403BhmQEg/d5aLHzDvaogI2+v+O13qBAD6kVg8+c/Dyyj5qELbgE1sw
         2QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751368419; x=1751973219;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNW7caVwKhgGVodSQGEfKDOFvOt0nWsTUGnawMeLUPI=;
        b=TQ/H66lqqb2yflQV4fWbnvoZZL+YNbgNV+amS+zzXaU8eeM19so3qXJm7YCiHlwg03
         OCnlUenTRw0leZTs2RnANMk3K79ZGh3GjBRGU4kYG8/fCOHiruc4a7c2BLZ+EmdLnCZi
         +FIoeWq8DbvSPQe5usX2GOFlO/c0/4+TDfALiU7/02N4lAKtaCwTdLJQ+nl1FGYvLpAY
         tzKzrwWJvZbIUg4FSlmCBCgKhUHS8ZdKm2hDMEYl305Nb27RnpojhPOqO1yB78GalHMJ
         YDAA3pzRbkXojApQc5lHa2kzADFTxncWIdBGSHs8ZUYJahHJqMvlHcQ0Gof3akXhnfHx
         JRpQ==
X-Gm-Message-State: AOJu0YyzZ9QwUJgdgCYxg+aFu267di1eOmIy2ZWMBIwVKpgRYpN6HZQy
	wqdRL8JAelzU5F+YoW8W8nojdwKUP4/RNe7TLDjm0leFAYnjvGqcEE7KQ2sQDPfGk+o=
X-Gm-Gg: ASbGncu7meVD4H86TVUmIQtUJrlyAm4xulOIzWctXtD2BEwPCGwBGyPpbuou8Zi3qiu
	YzVYbYvD+VBvp5X1EZU1ZQD9fW509KcfZwTLS5aFll39umUFX34WqQFc6ElSJbMehVGKUefXv72
	S50moH2dzGaDMl0sNhd2bTDha3GT4cvEegUMyVSyk4xuhZzd8RDt31wZPrlXO3CpRxVBnZYqUH1
	TM6aKcVisGFwKP4TqXxPOH47+qCWkzJ6nUZF3a8EDbBAezBqRZsBdV20OpjjkJcoaLqNP85L8jc
	LKE/x3B7OAEpIN5j4EbycqAh5flakySo0p9LFfIILl4JTjimQzdrNsf3+zHJSgx9
X-Google-Smtp-Source: AGHT+IGvBYigzda5z3S/KyAtKqMZgrtoNPrhpPSo3Xu3AtEfuPsxhlo4U3j9SMiIgVPvUL9uq9r0ig==
X-Received: by 2002:a17:907:3e87:b0:add:f189:1214 with SMTP id a640c23a62f3a-ae34fee2af8mr1390797166b.24.1751368418911;
        Tue, 01 Jul 2025 04:13:38 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:21c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bc08sm842446366b.131.2025.07.01.04.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:13:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: kernel test robot <lkp@intel.com>
Cc: bpf@vger.kernel.org,  oe-kbuild-all@lists.linux.dev,  Alexei Starovoitov
 <ast@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Jesper Dangaard
 Brouer <hawk@kernel.org>,  Jesse Brandeburg <jbrandeburg@cloudflare.com>,
  Joanne Koong <joannelkoong@gmail.com>,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?=
 <thoiland@redhat.com>,  Yan
 Zhai <yan@cloudflare.com>,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com,  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next 02/13] bpf: Helpers for skb dynptr
 read/write/slice
In-Reply-To: <202507010904.MkxDYPdY-lkp@intel.com> (kernel test robot's
	message of "Tue, 1 Jul 2025 10:03:30 +0800")
References: <20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8@cloudflare.com>
	<202507010904.MkxDYPdY-lkp@intel.com>
Date: Tue, 01 Jul 2025 13:13:37 +0200
Message-ID: <87frfgnoym.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 01, 2025 at 10:03 AM +08, kernel test robot wrote:
> Hi Jakub,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Sitnicki/bpf-Ignore-dynptr-offset-in-skb-data-access/20250630-225941
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20250630-skb-metadata-thru-dynptr-v1-2-f17da13625d8%40cloudflare.com
> patch subject: [PATCH bpf-next 02/13] bpf: Helpers for skb dynptr read/write/slice
> config: microblaze-allnoconfig (https://download.01.org/0day-ci/archive/20250701/202507010904.MkxDYPdY-lkp@intel.com/config)
> compiler: microblaze-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250701/202507010904.MkxDYPdY-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507010904.MkxDYPdY-lkp@intel.com/
>
> All error/warnings (new ones prefixed by >>):
>
>    In file included from kernel/sysctl.c:29:
>>> include/linux/filter.h:1788:1: error: expected identifier or '(' before '{' token
>     1788 | {
>          | ^
>    include/linux/filter.h:1795:1: error: expected identifier or '(' before '{' token
>     1795 | {
>          | ^
>>> include/linux/filter.h:1785:19: warning: 'bpf_dynptr_skb_write' declared 'static' but never defined [-Wunused-function]
>     1785 | static inline int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst,
>          |                   ^~~~~~~~~~~~~~~~~~~~
>>> include/linux/filter.h:1792:21: warning: 'bpf_dynptr_skb_slice' declared 'static' but never defined [-Wunused-function]
>     1792 | static inline void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr,
>          |                     ^~~~~~~~~~~~~~~~~~~~
>
>
> vim +1788 include/linux/filter.h
>
> b5964b968ac64c Joanne Koong   2023-03-01  1784  
> e8b34e67737d71 Jakub Sitnicki 2025-06-30 @1785  static inline int bpf_dynptr_skb_write(const struct bpf_dynptr_kern *dst,
> e8b34e67737d71 Jakub Sitnicki 2025-06-30  1786  				       u32 offset, const void *src, u32 len,
> e8b34e67737d71 Jakub Sitnicki 2025-06-30  1787  				       u64 flags);
> b5964b968ac64c Joanne Koong   2023-03-01 @1788  {
> b5964b968ac64c Joanne Koong   2023-03-01  1789  	return -EOPNOTSUPP;
> b5964b968ac64c Joanne Koong   2023-03-01  1790  }
> 05421aecd4ed65 Joanne Koong   2023-03-01  1791  
> e8b34e67737d71 Jakub Sitnicki 2025-06-30 @1792  static inline void *bpf_dynptr_skb_slice(const struct bpf_dynptr_kern *ptr,
> e8b34e67737d71 Jakub Sitnicki 2025-06-30  1793  					 u32 offset, void *buf, u32 len);
> e8b34e67737d71 Jakub Sitnicki 2025-06-30  1794  

Copy-paste mistake - extra ';' in the stub definition when
CONFIG_NET=n. My bad.

Will fix and respin once people had more time to review.

