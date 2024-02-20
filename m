Return-Path: <bpf+bounces-22315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D173D85BB71
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 13:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2061F2217A
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FC767C69;
	Tue, 20 Feb 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SH8qRCrK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ns8J1nrG"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57365BA3;
	Tue, 20 Feb 2024 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430907; cv=none; b=k9J7UaEKUPo26rEAha4k9iTRThve98kUSUbABGWc0SvPMz5h4119Ob1104KB58bykBYUMP+eJkFKkKjufLivtNteRxxGbNpF9wPymhtQJPtqY9p2ocoA8+q100AtUi7RyhbxZk8BF98LqMPqexccK1D8OJZyaXMDLckwV+FnAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430907; c=relaxed/simple;
	bh=eXY31aS7tDneSxtFXr5YzEj99wWYH1MvJhblgs5aKZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeVBrmiibAvnvMU8h02Az1Yp3p1fSlfEW0kAlyYg1LmdCWVgNiFANlKdSIVN3G7i6IFGfvUVLMn0GEzUxpbLUX9E564S/4T4fWdPi6014YUmiY2v7239Mr80ElYNQva+l7UPBh5OQHRY17VvmkZm1JBrzn4IwaLmhv+pdYmSta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SH8qRCrK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ns8J1nrG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 13:08:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708430902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YPGgO9EwUSk5pK6JrCSvWMD884EPlE3OA4jdXqzQ0w=;
	b=SH8qRCrK4QpZO17wL3NlIvik1USa/2In7q21TYxBpu3TaTOWA7KGlcuxoWKdAMFOz8PC86
	1lTfleyTOucmMFWBkOafbnzDROJ0eoFSjb4dYBhfkaPZ5GAgkcYxyXq4dEu5gPv7FzHlAj
	W1IEmGLKwFRVREZV7aFF/OWjQBAeFFm61rfNVH5QZLF6Fufz/sip3u5hf2kyX1cNqCRhHI
	u/VyuW9XBy58BT14E6Kfy0hOLfg8s6nlE8WkL/GU90hmjUlTzkUB6gm0fgQaLmvrnahk1f
	d30ahWDV5ZtPyvhgrL96mOqMNIUA0NhQK+Ohg1vv7zVBqXKVnImbXmQ34dKD3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708430902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7YPGgO9EwUSk5pK6JrCSvWMD884EPlE3OA4jdXqzQ0w=;
	b=ns8J1nrGsPMNXSApN4oD5x3W5hxDYvzll/29uKoUmbHUSswYqzYecZ8HrJfaX4KohLx07i
	9xMIJTiIQNqHnCDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Message-ID: <20240220120821.1Tbz6IeI@linutronix.de>
References: <87y1bndvsx.fsf@toke.dk>
 <20240214142827.3vV2WhIA@linutronix.de>
 <87le7ndo4z.fsf@toke.dk>
 <20240214163607.RjjT5bO_@linutronix.de>
 <87jzn5cw90.fsf@toke.dk>
 <20240216165737.oIFG5g-U@linutronix.de>
 <87ttm4b7mh.fsf@toke.dk>
 <04d72b93-a423-4574-a98e-f8915a949415@kernel.org>
 <20240220101741.PZwhANsA@linutronix.de>
 <0b1c8247-ccfb-4228-bd64-53583329aaa7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0b1c8247-ccfb-4228-bd64-53583329aaa7@kernel.org>

On 2024-02-20 11:42:57 [+0100], Jesper Dangaard Brouer wrote:
> This seems low...
> Have you remembered to disable Ethernet flow-control?

No but one side says:
| i40e 0000:3d:00.1 eno2np1: NIC Link is Up, 10 Gbps Full Duplex, Flow Cont=
rol: None

but I did this

>  # ethtool -A ixgbe1 rx off tx off
>  # ethtool -A i40e2 rx off tx off

and it didn't change much.

>=20
> > | Summary                 8,436,294 rx/s                  0 err/s
>=20
> You want to see the "extended" info via cmdline (or Ctrl+\)
>=20
>  # xdp-bench drop -e eth1
>=20
>=20
> >=20
> > with "-t 8 -b 64". I started with 2 and then increased until rx/s was
> > falling again. I have ixgbe on the sending side and i40e on the
>=20
> With ixgbe on the sending side, my testlab shows I need -t 2.
>=20
> With -t 2 :
> Summary                14,678,170 rx/s                  0 err/s
>   receive total        14,678,170 pkt/s        14,678,170 drop/s         0
> error/s
>     cpu:1              14,678,170 pkt/s        14,678,170 drop/s         0
> error/s
>   xdp_exception                 0 hit/s
>=20
> with -t 4:
>=20
> Summary                10,255,385 rx/s                  0 err/s
>   receive total        10,255,385 pkt/s        10,255,385 drop/s         0
> error/s
>     cpu:1              10,255,385 pkt/s        10,255,385 drop/s         0
> error/s
>   xdp_exception                 0 hit/s
>=20
> > receiving side. I tried to receive on ixgbe but this ended with -ENOMEM
> > | # xdp-bench drop eth1
> > | Failed to attach XDP program: Cannot allocate memory
> >=20
> > This is v6.8-rc5 on both sides. Let me see where this is coming from=E2=
=80=A6
> >=20
>=20
> Another pitfall with ixgbe is that it does a full link reset when
> adding/removing XDP prog on device.  This can be annoying if connected
> back-to-back, because "remote" pktgen will stop on link reset.

so I replaced nr_cpu_ids with 64 and bootet maxcpus=3D64 so that I can run
xdp-bench on the ixbe.

so. i40 send, ixgbe receive.

-t 2

| Summary                 2,348,800 rx/s                  0 err/s
|   receive total         2,348,800 pkt/s         2,348,800 drop/s         =
       0 error/s
|     cpu:0               2,348,800 pkt/s         2,348,800 drop/s         =
       0 error/s
|   xdp_exception                 0 hit/s

-t 4
| Summary                 4,158,199 rx/s                  0 err/s
|   receive total         4,158,199 pkt/s         4,158,199 drop/s         =
       0 error/s
|     cpu:0               4,158,199 pkt/s         4,158,199 drop/s         =
       0 error/s
|   xdp_exception                 0 hit/s

-t 8
| Summary                 5,612,861 rx/s                  0 err/s       =20
|   receive total         5,612,861 pkt/s         5,612,861 drop/s         =
       0 error/s     =20
|     cpu:0               5,612,861 pkt/s         5,612,861 drop/s         =
       0 error/s     =20
|   xdp_exception                 0 hit/s       =20

going higher makes the rate drop. With 8 it floats between 5,5=E2=80=A6 5,7=
=E2=80=A6

Doing "ethtool -G eno2np1 tx 4096 rx 4096" on the i40 makes it worse,
using the default 512/512 gets the numbers from above, going below 256
makes it worse.

receiving on i40, sending on ixgbe:

-t 2
|Summary                 3,042,957 rx/s                  0 err/s
|  receive total         3,042,957 pkt/s         3,042,957 drop/s          =
      0 error/s
|    cpu:60              3,042,957 pkt/s         3,042,957 drop/s          =
      0 error/s
|  xdp_exception                 0 hit/s

-t 4
|Summary                 5,442,166 rx/s                  0 err/s
|  receive total         5,442,166 pkt/s         5,442,166 drop/s          =
      0 error/s
|    cpu:60              5,442,166 pkt/s         5,442,166 drop/s          =
      0 error/s
|  xdp_exception                 0 hit/s


-t 6
| Summary                 7,023,406 rx/s                  0 err/s
|   receive total         7,023,406 pkt/s         7,023,406 drop/s         =
       0 error/s
|     cpu:60              7,023,406 pkt/s         7,023,406 drop/s         =
       0 error/s
|   xdp_exception                 0 hit/s


-t 8
| Summary                 7,540,915 rx/s                  0 err/s
|   receive total         7,540,915 pkt/s         7,540,915 drop/s         =
       0 error/s
|     cpu:60              7,540,915 pkt/s         7,540,915 drop/s         =
       0 error/s
|   xdp_exception                 0 hit/s

-t 10
|Summary                 7,699,143 rx/s                  0 err/s
|  receive total         7,699,143 pkt/s         7,699,143 drop/s          =
      0 error/s
|    cpu:60              7,699,143 pkt/s         7,699,143 drop/s          =
      0 error/s
|  xdp_exception                 0 hit/s

-t 18
| Summary                 7,784,946 rx/s                  0 err/s
|   receive total         7,784,946 pkt/s         7,784,946 drop/s         =
       0 error/s
|     cpu:60              7,784,946 pkt/s         7,784,946 drop/s         =
       0 error/s
|   xdp_exception                 0 hit/s

after t18 it drop down to 2,=E2=80=A6
Now I got worse than before since -t8 says 7,5=E2=80=A6 and it did 8,4 in t=
he
morning. Do you have maybe a .config for me in case I did not enable the
performance switch?

> --Jesper

Sebastian

