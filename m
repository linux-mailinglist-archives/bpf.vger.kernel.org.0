Return-Path: <bpf+bounces-62505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A76BAFB641
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 16:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35A717326D
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D102DC355;
	Mon,  7 Jul 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJR8qzqs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE081724;
	Mon,  7 Jul 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899251; cv=none; b=GfXeNC95aTTfGZ17Z89fZnhRYYA8y47L1GVuWucgsYvBCqqd5mgf9Dhi56JGMo5Gch7hUxyqF5xe02xNWXs1SrCkSJHJLfanhnfPFXRMS9HSETYy/C2/OANlZldcHotq7vJuJaRlD1pH1YbbJPaRZGyQwG3Pe9FlK84+c0Mx2K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899251; c=relaxed/simple;
	bh=o9675fy+YlDFPc/Vh6r+Wc08+Q5y8d0HVLHSd8VBraE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDFSkqirQKNdQDOnelA9hzvbkIJlP6DTnZuCjN/BJMeGeRFOfCNCEAlA2h82U7pcJpGOU3XmjPDlrvpt5h7xq7twa2st/TmyDjohDYsHjzwVxCIqHoTh2ybugwt3YlDUFLZAnQV7OH9Auc3IcL7zFN1gTFbvIj6hiLDGiQDKKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJR8qzqs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23636167afeso29682495ad.3;
        Mon, 07 Jul 2025 07:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751899249; x=1752504049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q2TFzVZjN3Ft8pNBiIdSFh42y8iJAgW2txTgtC51U8=;
        b=fJR8qzqskKryz4Y6slxyVOgI35M694mkfWmsCrEZC+0JKcHHquSEuNWOSCqHeEEbjZ
         yceXoARdywZ/SUd8uOpqjYlIWIBM2sQRBeQc8kqVrLCd1XOa13yXKzXhj8RZnyE69+4B
         cLS379A0xBlZSI1qrZYCMjiuPeXFS3tkBME2PXcVRuvPiEqIq2PWrJnrTu1sK7Qdx549
         dl63C+VyswzqZSFVmXioYNsZMDgwcisuI2MNkHeRhng7oPFlSEK/WbZELcVd0GJc8ohx
         fN8LgbZ77JhjjnrkdZyOGlAZ4TeuS9ITkE6ntCDKe82mLwfJlGC2yhbSoD3hEm+xaq3M
         fsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751899249; x=1752504049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q2TFzVZjN3Ft8pNBiIdSFh42y8iJAgW2txTgtC51U8=;
        b=hcjOvIrIhn0jDaYArAxRz39FaMERVIN4lKtDitiNuSU6O1nayt4Ni0ENCrSjQ+y3Nt
         q1b80wXGWXW0XfMOZB4PRzxIioi5OimNIM0xfALvIk/Xb0GAZ2NyoENtkrfwPK/OOblA
         XCrGkS7L9wLRk6BXBprghK6kc76yNRA6ntHpN49jNL1EKtrszLPVoNS/LjcVVW8uMHSf
         hKpt7W0j5U+5GLeDIJ3a1IpeavwVkfSElDzGvs2W5sSCQtN+ASxSVlMZSg+idoYjw9OV
         yyyvMXAc8mJXN7QqPhDXWPlZhRk6Xn2azrpnclCMYZZbz7IIUTuPAQAXPThQfvz5g2mn
         qtAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn8g2ciWHkHuDlkcUzAkcxd+s27df1CcKNxgRYjaW8g2PVQx64rUUewT8jfnOBH0Vwi+/RUWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrO5Q98s65+DSLlscuzkHqulE3/9DiWbgK+9un08fnMzvLO95F
	lWBkhn9ZaK4RUWKJH8J9ktEGr4lLtHfVFgMoFmTwa08kBoNy/g9jjQs=
X-Gm-Gg: ASbGncsLCQxCK+6lR9P6OUhyFDi5P6i3KMrqIHafZSpAPCsyUv6DIxp7WO6BTV5qG4L
	n8qfpmKaZG23bqLGSrWBcCrt3RoxI5LIh9YhiLblw7BBa2SeEN1wZWR7UTf0PwWNDnMMnH97CCn
	P7I5q6YltIVtuh2JCkkVdONZHEbkISY14yX97k/oENkyj3oiRspYLe1YhkFnJTG/MpuCwhAf3r5
	UjaJ6nC/oJeD8BK+9RssiiJ+8uJW3dD1Yig01uMa2vGi50yvTx2z8FBfy+Qd9s8u1q2V83SgF3q
	eVMzOLaUqgZ9dNOzESlZ4JmTcAcGMd7mXu/Rj6TkZ7fDPI0X0JHFbid43rkFrTSFbi0nM+7oHU+
	RM26Ij+jRlqtu6x1pqqAGjW4=
X-Google-Smtp-Source: AGHT+IGR2d9zgqr1HAQ4DoNQFMIZwPVyUfk4UZxtYkfPKBa1mRVPR7FPCuDoeMZNRk8xYqbs6K2hfA==
X-Received: by 2002:a17:902:cf05:b0:21f:4649:fd49 with SMTP id d9443c01a7336-23c875db9d1mr178925815ad.49.1751899248987;
        Mon, 07 Jul 2025 07:40:48 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8455d391sm93506425ad.91.2025.07.07.07.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 07:40:48 -0700 (PDT)
Date: Mon, 7 Jul 2025 07:40:47 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, lorenzo@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <borkmann@iogearbox.net>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, sdf@fomichev.me,
	kernel-team@cloudflare.com, arthur@arthurfabre.com,
	jakub@cloudflare.com
Subject: Re: [PATCH bpf-next V2 0/7] xdp: Allow BPF to set RX hints for
 XDP_REDIRECTed packets
Message-ID: <aGvcb53APFXR8eJb@mini-arch>
References: <175146824674.1421237.18351246421763677468.stgit@firesoul>
 <aGVY2MQ18BWOisWa@mini-arch>
 <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1873a92-747d-4f32-91f8-126779947e42@kernel.org>

On 07/03, Jesper Dangaard Brouer wrote:
> 
> 
> On 02/07/2025 18.05, Stanislav Fomichev wrote:
> > On 07/02, Jesper Dangaard Brouer wrote:
> > > This patch series introduces a mechanism for an XDP program to store RX
> > > metadata hints - specifically rx_hash, rx_vlan_tag, and rx_timestamp -
> > > into the xdp_frame. These stored hints are then used to populate the
> > > corresponding fields in the SKB that is created from the xdp_frame
> > > following an XDP_REDIRECT.
> > > 
> > > The chosen RX metadata hints intentionally map to the existing NIC
> > > hardware metadata that can be read via kfuncs [1]. While this design
> > > allows a BPF program to read and propagate existing hardware hints, our
> > > primary motivation is to enable setting custom values. This is important
> > > for use cases where the hardware-provided information is insufficient or
> > > needs to be calculated based on packet contents unavailable to the
> > > hardware.
> > > 
> > > The primary motivation for this feature is to enable scalable load
> > > balancing of encapsulated tunnel traffic at the XDP layer. When tunnelled
> > > packets (e.g., IPsec, GRE) are redirected via cpumap or to a veth device,
> > > the networking stack later calculates a software hash based on the outer
> > > headers. For a single tunnel, these outer headers are often identical,
> > > causing all packets to be assigned the same hash. This collapses all
> > > traffic onto a single RX queue, creating a performance bottleneck and
> > > defeating receive-side scaling (RSS).
> > > 
> > > Our immediate use case involves load balancing IPsec traffic. For such
> > > tunnelled traffic, any hardware-provided RX hash is calculated on the
> > > outer headers and is therefore incorrect for distributing inner flows.
> > > There is no reason to read the existing value, as it must be recalculated.
> > > In our XDP program, we perform a partial decryption to access the inner
> > > headers and calculate a new load-balancing hash, which provides better
> > > flow distribution. However, without this patch set, there is no way to
> > > persist this new hash for the network stack to use post-redirect.
> > > 
> > > This series solves the problem by introducing new BPF kfuncs that allow an
> > > XDP program to write e.g. the hash value into the xdp_frame. The
> > > __xdp_build_skb_from_frame() function is modified to use this stored value
> > > to set skb->hash on the newly created SKB. As a result, the veth driver's
> > > queue selection logic uses the BPF-supplied hash, achieving proper
> > > traffic distribution across multiple CPU cores. This also ensures that
> > > consumers, like the GRO engine, can operate effectively.
> > > 
> > > We considered XDP traits as an alternative to adding static members to
> > > struct xdp_frame. Given the immediate need for this functionality and the
> > > current development status of traits, we believe this approach is a
> > > pragmatic solution. We are open to migrating to a traits-based
> > > implementation if and when they become a generally accepted mechanism for
> > > such extensions.
> > > 
> > > [1] https://docs.kernel.org/networking/xdp-rx-metadata.html
> > > ---
> > > V1: https://lore.kernel.org/all/174897271826.1677018.9096866882347745168.stgit@firesoul/
> > 
> > No change log?
> 
> We have fixed selftest as requested by Alexie.
> And we have updated cover-letter and doc as you Stanislav requested.
> 
> > 
> > Btw, any feedback on the following from v1?
> > - https://lore.kernel.org/netdev/aFHUd98juIU4Rr9J@mini-arch/
> 
> Addressed as updated cover-letter and documentation. I hope this helps
> reviewers understand the use-case, as the discussion turn into "how do we
> transfer all HW metadata", which is NOT what we want (and a waste of
> precious cycles).
> 
> For our use-case, it doesn't make sense to "transfer all HW metadata".
> In fact we don't even want to read the hardware RH-hash, because we already
> know it is wrong (for tunnels), we just want to override the RX-hash used at
> SKB creation.  We do want the BPF programmers flexibility to call these
> kfuncs individually (when relevant).
> 
> > - https://lore.kernel.org/netdev/20250616145523.63bd2577@kernel.org/
> 
> I feel pressured into critiquing Jakub's suggestion, hope this is not too
> harsh.  First of all it is not relevant to our this patchset use-case, as it
> focus on all HW metadata.

[..]

> Second, I disagree with the idea/mental model of storing in a
> "driver-specific format". The current implementation of driver-specific
> kfunc helpers that "get the metadata" is already doing a conversion to a
> common format, because the BPF-programmer naturally needs this to be the
> same across drivers.  Thus, it doesn't make sense to store it back in a
> "driver-specific format", as that just complicate things.  My mental model
> is thus, that after the driver-specific "get" operation to result is in a
> common format, that is simply defined by the struct type of the kfunc, which
> is both known by the kernel and BPF-prog.

Having get/set model seems a bit more generic, no? Potentially giving us the
ability to "correct" HW metadata for the non-redirected cases as well.
Plus we don't hard-code the (internal) layout. Solving only xdp_redirect
seems a bit too narrow, idk..

