Return-Path: <bpf+bounces-67086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FD6B3DE87
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 11:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2257918930F7
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED9B310652;
	Mon,  1 Sep 2025 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="L4Af9Udn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B430E84A
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718873; cv=none; b=Z2TLRfbACusvPyXGPjbBCSg+yduIAccE50Wjl6WUWjDLB2NdvFFsb7pP8caeKh8CXNaK4FF23TV2bXR7lsDWJne997NdKz+cAwp2rtUkrFyh9P9I9yPoNNgw6S2r0Ojuc057TjJatkQRo8uW6S0Jgwatne7BPd7tl31C0LGBuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718873; c=relaxed/simple;
	bh=pxQMSu6dX1cCKNbLSP+l++80EfmSBr72xvrQWh5zGbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uem6a+EheM/kT6c90wpyS5Sr2osYw+KqwK/oNu5YzEMx0dDyckwFhmJdkzjdMmY1KghpzgsUi8KQAB0aOJP2xUg9VOZEFEcaETKcGZEYd454QJ4ZgD5otDs+KTi0ynd4li5ZH5SazGtQvjKC9Jrs3QAB0MSuRsYRsyHFXyXvj6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=L4Af9Udn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b040df389easo253506066b.3
        for <bpf@vger.kernel.org>; Mon, 01 Sep 2025 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1756718869; x=1757323669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2bX7K172EAX0v9QdDM45QX7qnW31zLAa+k2k6RxGSg=;
        b=L4Af9UdnSkB/QeHYdU5JSGORvwf+xFrJ5vgyNi1fgQ8PEupgj1kPBO3OfT2DgEnuOc
         SGYn4ZP4yL/ktUVkIRfZlD2e/DoMx9D/KgCVLugVKBNEtbjbccHWLqD1I64AxlmwW3xW
         8kjG8+b/eWG6fylv4EOX2IGd6h6y5XstCWp+gSfmv189pOYpcYaNfk8ZEANDrV2wNXxJ
         rjiJhMJXkzaw7uzqi5ORFWHrqHmaukhcHmRLH2IAaduSMvnin+4xP2JPsdifbxutCmqY
         T/f1u1ix1+LPNg0Lr3Z6uQnz/WdrX+XggKmQBbhPsvO1JZvV+kfAlW0WAmABuxqePv3r
         CjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718869; x=1757323669;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2bX7K172EAX0v9QdDM45QX7qnW31zLAa+k2k6RxGSg=;
        b=e9857TnLtfWbyFyffOuvfNARrZZbVHsPdKXSyyUuzjjf9/xSaSnZGnqdZSeAzps11/
         3FLxHlV58AKuNP/kzhVK0+VbSAjz7+Bqto2jbSZ6+tqGxBTA8hrwo6nIgE/2MrHl5VCs
         rUT18txqUwsQBZuj0qr98fLuUZvdRvKPy8dUChCXmyf1TPRjmdzkZJoyTg/le3d4ZvcT
         89cGVVXZGIianoJ5YjPLOy0iZqw7oVR7GojJDDqH0Ezt37co80DKJuKswK+2d71aoRMQ
         DVaz+KTSWIMzFwaYDaDEod9DW24N8Hpr1W69Udo/khjYyGhH7mXQQyY8hFcYe/4xnD/D
         8s9w==
X-Gm-Message-State: AOJu0YwAQNcPqgsDhN6ilVHJYOGhMeq1HDsFI8vw1cmSAK1ODupMYT11
	piP/R/hrKeaUatBViwdw7rlEvqilFSmnHIW1F0MAQNmpy7O5wI6x3SIavkll7bFUFYQ=
X-Gm-Gg: ASbGncsVx1KWVuMBqehqMGIJEKRHtZhxfx5K+LEw7AAsHjz9vxS3pU5xodN8xG8+G6V
	jnp4q+FHITsd/PlP05Y0gQXffWw51QAS+gZaxiJ7I1ASP6qns5/O7/0GZveWQMSycgRndMPslmZ
	rKdqB3qTgs0vZgOzv+BDkEZvE6uGOxzTPtpobqkvt/ZyBUPKit/ZEV1r54rViMoaKDpA9R456Ks
	4s6SNCsVes8B1ap+3Q8WZqkL+AprSv5gn1mcd9I5OOlAzC7Je1CV0Gzftgi/Hbu8dhEX8mELOsI
	nbS5NC94W11mv365vgKTtT/nRAY95GRHnMAMc+UEMLTSdmTfYRI4Zf4sBq5XcMEAJ0LbyyNqVj2
	hnxYRSrca5otb3hENnpBMoHoq/g==
X-Google-Smtp-Source: AGHT+IG1Z7XOr1oPLlEpDF1RLiGTEBx087MJzn2tzoiyFYDQPnfivbRGt2IX7Taj3bVJGrG/hGOXqg==
X-Received: by 2002:a17:907:60d5:b0:afe:ef08:7638 with SMTP id a640c23a62f3a-b01d97544d6mr832308266b.33.1756718869394;
        Mon, 01 Sep 2025 02:27:49 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:295f::41f:42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042dcb9105sm186430166b.2.2025.09.01.02.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:27:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  kernel-team
 <kernel-team@cloudflare.com>,  Network Development
 <netdev@vger.kernel.org>,  kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] bpf: stub out skb metadata dynptr read/write
 ops when CONFIG_NET=n
In-Reply-To: <CAADnVQL_8guWC9io1P5jhTgnyD3u=0WvTnHM3DJFVvE_Sy7DBw@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 27 Aug 2025 09:05:06 -0700")
References: <20250827-dynptr-skb-meta-no-net-v1-1-42695c402b16@cloudflare.com>
	<CAADnVQL_8guWC9io1P5jhTgnyD3u=0WvTnHM3DJFVvE_Sy7DBw@mail.gmail.com>
Date: Mon, 01 Sep 2025 11:27:47 +0200
Message-ID: <87plca5xpo.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 09:05 AM -07, Alexei Starovoitov wrote:
> On Wed, Aug 27, 2025 at 3:48=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> Kernel Test Robot reported a compiler warning - a null pointer may be
>> passed to memmove in __bpf_dynptr_{read,write} when building without
>> networking support.
>>
>> The warning is correct from a static analysis standpoint, but not actual=
ly
>> reachable. Without CONFIG_NET, creating dynptrs to skb metadata is
>> impossible since the constructor kfunc is missing.
>>
>> Fix this the same way as for skb and xdp data dynptrs. Add wrappers for
>> loading and storing bytes to skb metadata, and stub them out to return an
>> error when CONFIG_NET=3Dn.
>>
>> Fixes: 6877cd392bae ("bpf: Enable read/write access to skb metadata thro=
ugh a dynptr")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202508212031.ir9b3B6Q-lkp@=
intel.com/
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  include/linux/filter.h | 26 ++++++++++++++++++++++++++
>>  kernel/bpf/helpers.c   |  6 ++----
>>  2 files changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 9092d8ea95c8..5b0d7c5824ac 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1779,6 +1779,20 @@ void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 o=
ffset, u32 len);
>>  void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off,
>>                       void *buf, unsigned long len, bool flush);
>>  void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset);
>> +
>> +static inline int __bpf_skb_meta_load_bytes(struct sk_buff *skb,
>> +                                           u32 offset, void *to, u32 le=
n)
>> +{
>> +       memmove(to, bpf_skb_meta_pointer(skb, offset), len);
>> +       return 0;
>> +}
>> +
>> +static inline int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 o=
ffset,
>> +                                            const void *from, u32 len)
>> +{
>> +       memmove(bpf_skb_meta_pointer(skb, offset), from, len);
>> +       return 0;
>> +}
>>  #else /* CONFIG_NET */
>>  static inline int __bpf_skb_load_bytes(const struct sk_buff *skb, u32 o=
ffset,
>>                                        void *to, u32 len)
>> @@ -1818,6 +1832,18 @@ static inline void *bpf_skb_meta_pointer(struct s=
k_buff *skb, u32 offset)
>>  {
>>         return NULL;
>>  }
>> +
>> +static inline int __bpf_skb_meta_load_bytes(struct sk_buff *skb, u32 of=
fset,
>> +                                           void *to, u32 len)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>> +
>> +static inline int __bpf_skb_meta_store_bytes(struct sk_buff *skb, u32 o=
ffset,
>> +                                            const void *from, u32 len)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>
> imo that's too much to shut up the warn.
> Maybe make:
> static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
> {
>         return NULL;
> }
>
> to return ERR_PTR(-EOPNOTSUPP);
>
> instead?

Much nicer. Thanks for the suggestion.

