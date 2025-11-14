Return-Path: <bpf+bounces-74451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1DAC5B0B3
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 04:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5B2C4E565C
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8423B62C;
	Fri, 14 Nov 2025 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ggxr5edu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFEF2248A5
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763089251; cv=none; b=FB1iNNO4a3aYCDXhTNwAHMZBPZGIcocUNuoQn4EBnNFrhmoj9eNeu3ks97vDCp6WqV+HvnRllCHaa56oXIDcR85m/VIifVwiNl8JBPEchERRNG4ui2Djd+P3agJN4UHQYAG/H/+8uJCRXWHvvKDpckEphE3G4H5ST0iX+KPKnQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763089251; c=relaxed/simple;
	bh=oSo/R2wZ0gY6bIFuUpPVp5f7R1cNHSHYbCjtxVn+yzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtzAXVausFEQfTlz/OBmP9cMNUcjerrvP8czare+M1m6UuBJVTwoJ3hKGWkyYSXUv+Y9DvVnEqtHalX3S4TDkoWUvhEV1BR9vyp1OKMBeTP+kNCkITaaoXQsGxg8TMg/UJnGeQ5P8OfC6qH+uRFTuRrnzGSRZd/z5xKgPRP7NII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ggxr5edu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763089248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GNQFShzIKmHT8KQAVa2CX2xq5RIcZ/FxT9iTFQR1K5M=;
	b=Ggxr5edum5pKkxolj2ksY3xxE4sik76BOnNHs/AcXzSXSV/OG9zxg+0GO7fHT1CEC5svdt
	r7zTor5jkCr+/p5GU5bf5oOscGS84bYlLQOQUybENvH9h9ZRaHcuT5rY7jwHWMj59ejTmF
	Gl07UxdcXZA1KqN+VJiN5yXkXqrgKUc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-Tey_Nn_nMK6S2codne-ctA-1; Thu,
 13 Nov 2025 22:00:42 -0500
X-MC-Unique: Tey_Nn_nMK6S2codne-ctA-1
X-Mimecast-MFC-AGG-ID: Tey_Nn_nMK6S2codne-ctA_1763089241
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EDA518AB406;
	Fri, 14 Nov 2025 03:00:40 +0000 (UTC)
Received: from fedora (unknown [10.72.116.75])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01D11300018D;
	Fri, 14 Nov 2025 03:00:35 +0000 (UTC)
Date: Fri, 14 Nov 2025 11:00:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 3/5] io_uring: bpf: extend io_uring with bpf struct_ops
Message-ID: <aRabTk29_v6p92mY@fedora>
References: <20251104162123.1086035-1-ming.lei@redhat.com>
 <20251104162123.1086035-4-ming.lei@redhat.com>
 <94f94f0e-7086-4f44-a658-9cb3b5496faf@samba.org>
 <aRW6LfJi63X7wbPm@fedora>
 <05a37623-c78c-4a86-a9f3-c78ce133fa66@samba.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a37623-c78c-4a86-a9f3-c78ce133fa66@samba.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Nov 13, 2025 at 12:19:33PM +0100, Stefan Metzmacher wrote:
> Am 13.11.25 um 11:59 schrieb Ming Lei:
> > On Thu, Nov 13, 2025 at 11:32:56AM +0100, Stefan Metzmacher wrote:
> > > Hi Ming,
> > > 
> > > > io_uring can be extended with bpf struct_ops in the following ways:
> > > > 
> > > > 1) add new io_uring operation from application
> > > > - one typical use case is for operating device zero-copy buffer, which
> > > > belongs to kernel, and not visible or too expensive to export to
> > > > userspace, such as supporting copy data from this buffer to userspace,
> > > > decompressing data to zero-copy buffer in Android case[1][2], or
> > > > checksum/decrypting.
> > > > 
> > > > [1] https://lpc.events/event/18/contributions/1710/attachments/1440/3070/LPC2024_ublk_zero_copy.pdf
> > > > 
> > > > 2) extend 64 byte SQE, since bpf map can be used to store IO data
> > > >      conveniently
> > > > 
> > > > 3) communicate in IO chain, since bpf map can be shared among IOs,
> > > > when one bpf IO is completed, data can be written to IO chain wide
> > > > bpf map, then the following bpf IO can retrieve the data from this bpf
> > > > map, this way is more flexible than io_uring built-in buffer
> > > > 
> > > > 4) pretty handy to inject error for test purpose
> > > > 
> > > > bpf struct_ops is one very handy way to attach bpf prog with kernel, and
> > > > this patch simply wires existed io_uring operation callbacks with added
> > > > uring bpf struct_ops, so application can define its own uring bpf
> > > > operations.
> > > 
> > > This sounds useful to me.
> > > 
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > > ---
> > > >    include/uapi/linux/io_uring.h |   9 ++
> > > >    io_uring/bpf.c                | 271 +++++++++++++++++++++++++++++++++-
> > > >    io_uring/io_uring.c           |   1 +
> > > >    io_uring/io_uring.h           |   3 +-
> > > >    io_uring/uring_bpf.h          |  30 ++++
> > > >    5 files changed, 311 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> > > > index b8c49813b4e5..94d2050131ac 100644
> > > > --- a/include/uapi/linux/io_uring.h
> > > > +++ b/include/uapi/linux/io_uring.h
> > > > @@ -74,6 +74,7 @@ struct io_uring_sqe {
> > > >    		__u32		install_fd_flags;
> > > >    		__u32		nop_flags;
> > > >    		__u32		pipe_flags;
> > > > +		__u32		bpf_op_flags;
> > > >    	};
> > > >    	__u64	user_data;	/* data to be passed back at completion time */
> > > >    	/* pack this to avoid bogus arm OABI complaints */
> > > > @@ -427,6 +428,13 @@ enum io_uring_op {
> > > >    #define IORING_RECVSEND_BUNDLE		(1U << 4)
> > > >    #define IORING_SEND_VECTORIZED		(1U << 5)
> > > > +/*
> > > > + * sqe->bpf_op_flags		top 8bits is for storing bpf op
> > > > + *				The other 24bits are used for bpf prog
> > > > + */
> > > > +#define IORING_BPF_OP_BITS	(8)
> > > > +#define IORING_BPF_OP_SHIFT	(24)
> > > > +
> > > >    /*
> > > >     * cqe.res for IORING_CQE_F_NOTIF if
> > > >     * IORING_SEND_ZC_REPORT_USAGE was requested
> > > > @@ -631,6 +639,7 @@ struct io_uring_params {
> > > >    #define IORING_FEAT_MIN_TIMEOUT		(1U << 15)
> > > >    #define IORING_FEAT_RW_ATTR		(1U << 16)
> > > >    #define IORING_FEAT_NO_IOWAIT		(1U << 17)
> > > > +#define IORING_FEAT_BPF			(1U << 18)
> > > >    /*
> > > >     * io_uring_register(2) opcodes and arguments
> > > > diff --git a/io_uring/bpf.c b/io_uring/bpf.c
> > > > index bb1e37d1e804..8227be6d5a10 100644
> > > > --- a/io_uring/bpf.c
> > > > +++ b/io_uring/bpf.c
> > > > @@ -4,28 +4,95 @@
> > > >    #include <linux/kernel.h>
> > > >    #include <linux/errno.h>
> > > >    #include <uapi/linux/io_uring.h>
> > > > +#include <linux/init.h>
> > > > +#include <linux/types.h>
> > > > +#include <linux/bpf_verifier.h>
> > > > +#include <linux/bpf.h>
> > > > +#include <linux/btf.h>
> > > > +#include <linux/btf_ids.h>
> > > > +#include <linux/filter.h>
> > > >    #include "io_uring.h"
> > > >    #include "uring_bpf.h"
> > > > +#define MAX_BPF_OPS_COUNT	(1 << IORING_BPF_OP_BITS)
> > > > +
> > > >    static DEFINE_MUTEX(uring_bpf_ctx_lock);
> > > >    static LIST_HEAD(uring_bpf_ctx_list);
> > > > +DEFINE_STATIC_SRCU(uring_bpf_srcu);
> > > > +static struct uring_bpf_ops bpf_ops[MAX_BPF_OPS_COUNT];
> > > 
> > > This indicates to me that the whole system with all applications in all namespaces
> > > need to coordinate in order to use these 256 ops?
> > 
> > So far there is only 62 in-tree io_uring operation defined, I feel 256
> > should be enough.
> > 
> > > I think in order to have something useful, this should be per
> > > struct io_ring_ctx and each application should be able to load
> > > its own bpf programs.
> > 
> > per-ctx requirement looks reasonable, and it shouldn't be hard to
> > support.
> > 
> > > 
> > > Something that uses bpf_prog_get_type() based on a bpf_fd
> > > like SIOCKCMATTACH in net/kcm/kcmsock.c.
> > 
> > I considered per-ctx prog before, one drawback is the prog can't be shared
> > among io_ring_ctx, which could waste memory. In my ublk case, there can be
> > lots of devices sharing same bpf prog.
> 
> Can't the ublk instances coordinate and use the same bpf_fd?
> new instances could request it via a unix socket and SCM_RIGHTS
> from a long running loading process. On the other hand do they
> really want to share?

struct_ops is typically registered once, used everywhere, such as
sched_ext and socket example.

This patch follows this usage, so every io_uring application can access it like the
in-kernel operations. 

I can understand the requirement for per-io-ring-ctx struct_ops, which
won't cause conflict among different applications.

For example, ublk/raid5, there are 100 such devices, each device is created in dedicated
process and uses its own io-uring, so 100 same struct_ops prog are registered in memory.
Given struct_ops prog is registered as per-io-ring-ctx, it may not be shared by `bpf_fd`, IMO.

> 
> I don't know much about bpf in details, so I'm wondering in your
> example from
> https://github.com/ming1/liburing/commit/625b69ddde15ad80e078c684ba166f49c1174fa4
> 
> Would memory_map be global in the whole system or would
> each loaded instance of the program have it's own instance of memory_map?
 
bpf map is global.

At default, each loaded prog owns the map, but it may be exported for
others by pinning the map.

It is easy to verify by writing test code in tools/testing/selftests/

But I am not an bpf expert...

Thanks,
Ming


