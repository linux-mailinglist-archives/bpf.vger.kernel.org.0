Return-Path: <bpf+bounces-28888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BB98BE867
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1461F2E34C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB116ABC7;
	Tue,  7 May 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d53XCll1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202515FD19;
	Tue,  7 May 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098245; cv=none; b=WgWJKK5s4y6ijB6jVfLMii1zYzb5iG8EbB7LTXPBEjb3xbMHoO/9bluEo7ldUzUcnHSorZlB/IR7oEiZ1K05vWdoaAidBIgGqlwh/maG9qiOFTpDZHLxjqceTlU39tObd0CAifIhxddkiEzp42TGtqytoe1bDR8L0GF4HGF2/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098245; c=relaxed/simple;
	bh=5tsHnXmIxTBlUcXYWObthWr72n5cZAQT1HTvetuqPcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXv35PXcYK2qBZHhbWTE9Gxon2sFrr7s1P1vEQ9IPlFHDJ9EHbRKrpjuXX8gm9lXL0/8bGhdtvj3WvwhOct14bgZcFCMhsg4TmMfjI4M+9+EAnEAVql+nLcYc6WFI0joGRi/37O4rjWXTSCeZ64qhW33ooI54oYzopk7/d4SRr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d53XCll1; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2686305a12.1;
        Tue, 07 May 2024 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715098243; x=1715703043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9V4CAV643r+hpQSsd0E4UmJxUAxHNoFtxM2SvNIpo/Q=;
        b=d53XCll1hDtkcj5/6cJRenoOekyjXcZ1fv7Di0I9MSb3aIpKqpqKpaDzrYAN5sWEaq
         t7xcsw+fMZaDjKIj6q52iqFqyYxNkbiN/QNO4LCQzToCKVjPwZnJW77TztOpzzTBQMKQ
         6D1IjXlCgoy2z6tuLFci+jB4f+phmXeRPbppFCKNWNGm3fb5OgSx8Ve2+2q35KrPKnI9
         GzIWXGZv1ixE+bzwz+yj3nYmKrALdEx5mxIqwBCERFULf3amgd2rp/VnYQO9zUYW4+AS
         lkqc6pLYmN1h+t4FkvKTLtNOx1MjvkbcTiXe4nhk6QEX0YPIEw1/7p9tC6xcs5amjTky
         yTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098243; x=1715703043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9V4CAV643r+hpQSsd0E4UmJxUAxHNoFtxM2SvNIpo/Q=;
        b=Iae/qSZVaI+P9YGFUyOqZ8addk/MPte29eLs174EEgvdD5RMUpQkcIgCCCc7nKr1ae
         5VJoLw6CqEMxWGptA3nuhOa91NmpG/jc9JdREyjSlhFcxOn7wRp+nnBHxhEffnhjWHtC
         LOISUbMdyIZohfa3YuznYGE3tLMyPay5AtCzwVEq7Zh3LFb/CGcqMPQbU4xk4E+6wRVs
         mr4PiD33I+EGNPcb59FSu5WUqoSeVavbWcwBdQR5mvGq7hG1mkmh1jeGLR4DfJuvqjbg
         fV80TUFXmtdttY7M1y1lk+nV0sdYxOfDHck9TgbTpgEfjo3/yk5i4lOA57MkEURngf7d
         x2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCU/1Xo2ltgy+8ijZE2FFkulVjpbCbsFw1F2a8sJJ9nsPvPbeEVbQvQs/fa+k/2qVPodClF2vdOCr6ECyq8UTOjs7nPtGoRXpcUwBiKeyvFlU2vWuh48+AmjMouSRJJHg/lhO+Hun7xfDseIyZq9IXWxvcZuwgGwNMQ/TDdHtuYqTgTT0qGTWaJD0uJjwAM/GKjPx/LbSA==
X-Gm-Message-State: AOJu0YyldpTLy4BmfywR3dbdsjxzVjwSDfv/IldkPKXVXk+glMPGNEP/
	Da2j5HQpV+Ca30UZVdcHtj39VH0bnsiMBjsoCB5t0XNASCmt6zi9
X-Google-Smtp-Source: AGHT+IGRyzCrdevZxKFBhUxDnOddgvpqme+M7ROiFiCztDKR/gn94LV80ZC0+hX8YvKA9BtIRQ//0w==
X-Received: by 2002:a17:90a:898f:b0:2b2:7055:5a8b with SMTP id 98e67ed59e1d1-2b6165c5232mr23151a91.21.1715098242936;
        Tue, 07 May 2024 09:10:42 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:f3e4:f9ee:d229:5b64])
        by smtp.gmail.com with ESMTPSA id rr3-20020a17090b2b4300b002b113ad5f10sm11956609pjb.12.2024.05.07.09.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:10:42 -0700 (PDT)
Date: Tue, 7 May 2024 09:10:41 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v7 00/11] net/smc: SMC intra-OS shortcut with
 loopback-ism
Message-ID: <ZjpSgWyHaNC/ikNP@pop-os.localdomain>
References: <20240428060738.60843-1-guwen@linux.alibaba.com>
 <Zi5wIrf3nAeJh1u5@pop-os.localdomain>
 <2e34e4ea-b198-487e-be5b-ba854965dbeb@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e34e4ea-b198-487e-be5b-ba854965dbeb@linux.alibaba.com>

On Tue, May 07, 2024 at 10:34:09PM +0800, Wen Gu wrote:
> 
> 
> On 2024/4/28 23:49, Cong Wang wrote:
> > On Sun, Apr 28, 2024 at 02:07:27PM +0800, Wen Gu wrote:
> > > This patch set acts as the second part of the new version of [1] (The first
> > > part can be referred from [2]), the updated things of this version are listed
> > > at the end.
> > > 
> > > - Background
> > > 
> > > SMC-D is now used in IBM z with ISM function to optimize network interconnect
> > > for intra-CPC communications. Inspired by this, we try to make SMC-D available
> > > on the non-s390 architecture through a software-implemented Emulated-ISM device,
> > > that is the loopback-ism device here, to accelerate inter-process or
> > > inter-containers communication within the same OS instance.
> > 
> > Just FYI:
> > 
> > Cilium has implemented this kind of shortcut with sockmap and sockops.
> > In fact, for intra-OS case, it is _very_ simple. The core code is less
> > than 50 lines. Please take a look here:
> > https://github.com/cilium/cilium/blob/v1.11.4/bpf/sockops/bpf_sockops.c
> > 
> > Like I mentioned in my LSF/MM/BPF proposal, we plan to implement
> > similiar eBPF things for inter-OS (aka VM) case.
> > 
> > More importantly, even LD_PRELOAD is not needed for this eBPF approach.
> > :)
> > 
> > Thanks.
> 
> Hi, Cong. Thank you very much for the information. I learned about sockmap
> before and from my perspective smcd loopback and sockmap each have their own
> pros and cons.
> 
> The pros of smcd loopback is that it uses a standard process that defined
> by RFC-7609 for negotiation, this CLC handshake helps smc correctly determine
> whether the tcp connection should be upgraded no matter what middleware the
> connection passes, e.g. through NAT. So we don't need to pay extra effort to
> check whether the connection should be shortcut, unlike checking various policy
> by bpf_sock_ops_ipv4() in sockmap. And since the handshake automatically select
> different underlay devices for different scenarios (loopback-ism in intra-OS,
> ISM in inter-VM of IBM z and RDMA in inter-VM of different hosts), various
> scenarios can be covered through one smc protocol stack.
> 
> The cons of smcd loopback is also related to the CLC handshake, one more round
> handshake may cause smc to perform worse than TCP in short-lived connection
> scenarios. So we basically use smc upgrade in long-lived connection scenarios
> and are exploring IPPROTO_SMC[1] to provide lossless fallback under adverse cases.

You don't have to bother RFC's, since you could define your own TCP
options. And, the eBPF approach could also use TCP options whenver
needed. Cilium probably does not use them only because for intra-OS case
it is too simple to bother TCP options, as everything can be shared via a
shared socketmap.

In reality, the setup is not that complex. In many cases we already know
whether we have VM or container (or mixed) setup before we develop (as
a part of requirement gathering). And they rarely change.

Taking one step back, the discovery of VM or container or loopback cases
could be done via TCP options too, to deal with complex cases like
KataContainer. There is no reason to bother RFC's, maybe except the RDMA
case.

In fact, this is an advantage to me. We don't need to argue with anyone
on our own TCP option or eBPF code, we don't even have to share our own
eBPF code here.

> 
> And we are also working on other upgrade ways than LD_PRELOAD, e.g. using eBPF
> hook[2] with IPPROTO_SMC, to enhance the usability.

That is wrong IMHO, because basically it just overwrites kernel modules
with eBPF, not how eBPF is supposed to be used. IOW, you could not use
it at all without SMC/MPTCP modules.

BTW, this approach does not work for kernel sockets, because you only
hook __sys_socket().

Of course, for sockmap or sockops, they could be used independently for
any other purposes. I hope now you could see the flexiblities of eBPF
over kernel modules.

Thanks.

