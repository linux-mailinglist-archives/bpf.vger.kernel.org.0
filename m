Return-Path: <bpf+bounces-40344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521A4987216
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 12:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA34CB24D84
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 10:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC071AD9DD;
	Thu, 26 Sep 2024 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1d66e2x"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D361AC451
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727348088; cv=none; b=PYbUPmOJcmdlYeRVE/RAc3sTpcJfxe8ajVpMc5k3pdQf2at8nevl2o4YSIhRU+rlfZmEAUp21pZQZYrVZt4D2WiieUXNnHKPFREsQA5S8tK1SzcxPicLWlqYqYWmFYLQEKlBJaNg3Kdn6A68b14o3PJ+IEoc49/n5cc/FPRb2wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727348088; c=relaxed/simple;
	bh=4XlqGlbVV4R1uMYpPaM1u91hWeFZhoe0keGWzfBIbFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DmSi18USyymA99Bp2pKQLNTDWSnKYmleAMvmOKSogQxaklBdI+Pt4NgZfVmj+t3AmOmIPDCrc0iWGIc0p40e3dOZktQCyh4FY7hXnPMyHrs3q9MPLYSHpScSCfTZZDKwzi2yVVvME97vvDl/cNuE+QRxmC1/xfn/MFZTsZnVsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b1d66e2x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727348086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nMAah5V6Hs369gZJo6DRHJeeBm1IDseuQxhG1iZY8ro=;
	b=b1d66e2x+yPex92dqM6cdyh7uzyIOt7e0y6WeU9MdqTunmI36kjHcUk8bvDnkZfLr60Bce
	oAG2+R0y21Hy2eJeXkreECQUWnPw4KbtjxIeyUE0xMhTLiftasuTFEiQWCSxerzmLfI/3k
	TZjt8yx4Psnz5fjHn+movE6VPftq+tU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-bV50Z0U-NFiTsliaotOlng-1; Thu, 26 Sep 2024 06:54:45 -0400
X-MC-Unique: bV50Z0U-NFiTsliaotOlng-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5356d0f6cdcso829225e87.3
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 03:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727348083; x=1727952883;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMAah5V6Hs369gZJo6DRHJeeBm1IDseuQxhG1iZY8ro=;
        b=L4LC1Bsz+EpBRV+5nu2tbqUNJD4dPjkVii+MK2lN5mOdKzKS8nHgMasMA8TR6BxeEy
         mgKz2MpcUA8+abSsn/Bbd3fEO2ttdVhau55TMMcZw3TQQUP9XTJUzReZw+tveoisM2Tc
         nMVhe+glNVFglgaTbvFs3muK85XE2l2IFSUUIU3BgeSQzWFF54DLGXnKqO5o8hHglUP1
         qlrkCIGMpfSQeRAgTWsinsmq+rnxl63lwCHOdxpyiV9p6HgFCwv2bWSfM7OUG3DW4AzS
         8LR7GCbTlwhDkmZv397X6GpyNmHVGW4zmN/MsPFhusH0Q8RXgkabiBu/sIH1LjyQxgPx
         RoVA==
X-Forwarded-Encrypted: i=1; AJvYcCVH7MXoVxUsAAX+nT52PcST6iDW7nuqp45k65tHcE42c704riKQSYIaStV2q/wlyG+imzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZGAuouLqWm8CEZrzBXtvlPwTZjIn+Q4AzvLD+Qn4YTYrk4Ir
	8210NdQDLQ8ZBU9Zmb/Sqwa2ZoUPPePbhvt6aAHlyVWnJCxYnF6OTTxrDMDihygAj1OYj70Pncm
	gX74NR7K37ww+ni+tdOzl7Kkn7wkhroOc8qa+U8yitKX7o0FMmA==
X-Received: by 2002:a05:6512:12c3:b0:536:7362:5912 with SMTP id 2adb3069b0e04-53877530ceemr5556745e87.30.1727348083444;
        Thu, 26 Sep 2024 03:54:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPs6D/lrxvYcK40WRUY7e6VMRqpb6o1HwhSdRJSeV7mA2JYuu9QVeRQM49+yc5lijfGXDHEQ==
X-Received: by 2002:a05:6512:12c3:b0:536:7362:5912 with SMTP id 2adb3069b0e04-53877530ceemr5556685e87.30.1727348082765;
        Thu, 26 Sep 2024 03:54:42 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93a5b82fbasm192615366b.103.2024.09.26.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 03:54:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E1DD0157FC51; Thu, 26 Sep 2024 12:54:40 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Arthur Fabre
 <afabre@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, john.fastabend@gmail.com, edumazet@google.com,
 pabeni@redhat.com, sdf@fomichev.me, tariqt@nvidia.com, saeedm@nvidia.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, mst@redhat.com, jasowang@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, kernel-team
 <kernel-team@cloudflare.com>, Yan Zhai <yan@cloudflare.com>
Subject: Re: [RFC bpf-next 0/4] Add XDP rx hw hints support performing
 XDP_REDIRECT
In-Reply-To: <ZvA6hIl6XWJ4UEJW@lore-desk>
References: <cover.1726935917.git.lorenzo@kernel.org>
 <1f53cd74-6c1e-4a1c-838b-4acc8c5e22c1@intel.com>
 <09657be6-b5e2-4b5a-96b6-d34174aadd0a@kernel.org>
 <Zu_gvkXe4RYjJXtq@lore-desk> <87ldzkndqk.fsf@toke.dk>
 <ZvA6hIl6XWJ4UEJW@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 26 Sep 2024 12:54:40 +0200
Message-ID: <874j62u1lb.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:

>> I'm hinting at some complications here (with the EFAULT return) that
>> needs to be resolved: there is no guarantee that a given packet will be
>> in sync with the current status of the registered metadata, so we need
>> explicit checks for this. If metadata entries are de-registered again
>> this also means dealing with holes and/or reshuffling the metadata
>> layout to reuse the released space (incidentally, this is the one place
>> where a TLV format would have advantages).
>
> I like this approach but it seems to me more suitable for 'sw' metadata
> (this is main Arthur and Jakub use case iiuc) where the userspace would
> enable/disable these functionalities system-wide.
> Regarding device hw metadata (e.g. checksum offload) I can see some issues
> since on a system we can have multiple NICs with different capabilities.
> If we consider current codebase, stmmac driver supports only rx timestamp,
> while mlx5 supports all of them. In a theoretical system with these two
> NICs, since pkt_metadata_registry is global system-wide, we will end-up
> with quite a lot of holes for the stmmac, right? (I am not sure if this
> case is relevant or not). In other words, we will end-up with a fixed
> struct for device rx hw metadata (like xdp_rx_meta). So I am wondering
> if we really need all this complexity for xdp rx hw metadata?

Well, the "holes" will be there anyway (in your static struct approach).
They would just correspond to parts of the "struct xdp_rx_meta" being
unset.

What the "userspace can turn off the fields system wide" would
accomplish is to *avoid* the holes if you know that you will never need
them. E.g., say a system administrator know that they have no networks
that use (offloaded) VLANs. They could then disable the vlan offload
field system-wide, and thus reclaim the four bytes taken up by the
"vlan" member of struct xdp_rx_meta, freeing that up for use by
application metadata.

However, it may well be that the complexity of allowing fields to be
turned off is not worth the gains. At least as long as there are only
the couple of HW metadata fields that we have currently. Having the
flexibility to change our minds later would be good, though, which is
mostly a matter of making the API exposed to BPF and/or userspace
flexible enough to allow us to move things around in memory in the
future. Which was basically my thought with the API I sketched out in
the previous email. I.e., you could go:

ret = bpf_get_packet_metadata_field(pkt, METADATA_ID_HW_HASH,
                                    &my_hash_vlaue, sizeof(u32))


...and the METADATA_ID_HW_HASH would be a constant defined by the
kernel, for which the bpf_get_packet_metadata_field() kfunc just has a
hardcoded lookup into struct xdp_rx_meta. And then, if we decide to move
the field in the future, we just change the kfunc implementation, with
no impact to the BPF programs calling it.

> Maybe we can start with a simple approach for xdp rx hw metadata
> putting the struct in xdp_frame as suggested by Jesper and covering
> the most common use-cases. We can then integrate this approach with
> Arthur/Jakub's solution without introducing any backward compatibility
> issue since these field are not visible to userspace.

Yes, this is basically the gist of my suggestion (as I hopefully managed
to clarify above): Expose the fields via an API that is flexible enough
that we can move things around should the need arise, *and* which can
co-exist with the user-defined application metadata.

-Toke


