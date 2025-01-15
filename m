Return-Path: <bpf+bounces-48945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D685A1275C
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C952D3A17D4
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064E51465B3;
	Wed, 15 Jan 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Agsd3yOT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DF24A7DF
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954738; cv=none; b=gdEcAxENXJk67g452XoLZX2TK49kJtm801TOsFxmvEl1amWWOVT+1ts8mWmaYNHjXxWleTGZArVz4+g6BrKZYCn50m8f+FU16T4XHJSMzFz4OIb7KWBiU2ApHOxfA9M9D4xG/tEY3Zr090NmHLdm5sZkRBIo649ztKeDYLrjsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954738; c=relaxed/simple;
	bh=SnplJKaPZ+REAWqhWtUICv0j6UY525fstIyGktGRDng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxP5p8lKXFLeFczNc7u2BKOEHiYzePG1v6J1R31nLBCGzl7cjDorsZGuf8seWL2ALJ5FXCZE/JnOyeN3Iig0ppeZvOG+3xVRk3+Oc2NDM62GKywOYyGfNPCoy3fvQZYe7nTltpoXtIRZfMS/SnvjG2xOBloaHbHGbo/2Q8qYboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Agsd3yOT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736954735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tWbRFdGx2+KJM9JmXd2E8lk3lOfEDDiv0qxeii/8VHM=;
	b=Agsd3yOTjDKNSIaOoHGCk7B+Pblwe2KV4Iftw3uCuygCz0ZUCl4FLBoFdv5zjKt88jrPDj
	0tOD1nivUCVpqgUogLpOq69FK/3qJbqfKr7nBXGxoqmSUZJIE7ccH7p5wBrE9NJdiAs63h
	4vwoH3Ws60/fS6h+DCS0EVXPfvv1QOE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-u_wTsRI8MlORUfqJ0hXFIw-1; Wed,
 15 Jan 2025 10:25:32 -0500
X-MC-Unique: u_wTsRI8MlORUfqJ0hXFIw-1
X-Mimecast-MFC-AGG-ID: u_wTsRI8MlORUfqJ0hXFIw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED52E195606A;
	Wed, 15 Jan 2025 15:25:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.23])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44F4319560AA;
	Wed, 15 Jan 2025 15:25:16 +0000 (UTC)
Date: Wed, 15 Jan 2025 23:25:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, alexei.starovoitov@gmail.com,
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com,
	jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com,
	amery.hung@bytedance.com
Subject: Re: [PATCH bpf-next v2 03/14] bpf: Allow struct_ops prog to return
 referenced kptr
Message-ID: <Z4fTVwa3W9zRrEjU@fedora>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
 <20241220195619.2022866-4-amery.hung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220195619.2022866-4-amery.hung@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello Amery,

On Fri, Dec 20, 2024 at 11:55:29AM -0800, Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
> 
> Allow a struct_ops program to return a referenced kptr if the struct_ops
> operator's return type is a struct pointer. To make sure the returned
> pointer continues to be valid in the kernel, several constraints are
> required:
> 
> 1) The type of the pointer must matches the return type
> 2) The pointer originally comes from the kernel (not locally allocated)
> 3) The pointer is in its unmodified form
> 
> Implementation wise, a referenced kptr first needs to be allowed to _leak_
> in check_reference_leak() if it is in the return register. Then, in
> check_return_code(), constraints 1-3 are checked. During struct_ops
> registration, a check is also added to warn about operators with
> non-struct pointer return.
> 
> In addition, since the first user, Qdisc_ops::dequeue, allows a NULL
> pointer to be returned when there is no skb to be dequeued, we will allow
> a scalar value with value equals to NULL to be returned.
> 
> In the future when there is a struct_ops user that always expects a valid
> pointer to be returned from an operator, we may extend tagging to the
> return value. We can tell the verifier to only allow NULL pointer return
> if the return value is tagged with MAY_BE_NULL.
> 
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>

I feel this patchset is very useful, as Alexei shared, it can help to
mark two ublk bpf aio kfunc[1] as KF_ACQ/REL for avoiding bpf aio leak.

[1] https://lore.kernel.org/linux-block/20250107120417.1237392-1-tom.leiming@gmail.com/

So I try to test it with ublk bpf patchset, however, looks it fails ublk
bpf selftests. And the test does succeed without applying this patch,
and ublk is built as module.

- apply the 1st and the 3rd(this one) patch
- apply ublk bpf patchset[1]
- build kernel & reboot
- make -C tools/testing/selftests TARGETS=ublk run_tests

make: Entering directory '/root/git/linux/tools/testing/selftests'
make[1]: Entering directory '/root/git/linux/tools/testing/selftests/ublk'
  GEN      vmlinux.h
  CLNG-BPF ublk_loop.bpf.o
  GEN-SKEL ublk_loop.skel.h
  CLNG-BPF ublk_null.bpf.o
  GEN-SKEL ublk_null.skel.h
  CLNG-BPF ublk_stripe.bpf.o
  GEN-SKEL ublk_stripe.skel.h
  CC       ublk_bpf.o
  BINARY   ublk_bpf
rm /root/git/linux/tools/testing/selftests/ublk/ublk_bpf.o
make[1]: Leaving directory '/root/git/linux/tools/testing/selftests/ublk'
make[1]: Entering directory '/root/git/linux/tools/testing/selftests/ublk'
TAP version 13
1..8
# timeout set to 45
# selftests: ublk: test_null_01.sh
# null_01 : [PASS]
ok 1 selftests: ublk: test_null_01.sh
# timeout set to 45
# selftests: ublk: test_null_02.sh
# libbpf: struct_ops init_kern: struct ublk_bpf_ops data is not found in struct bpf_struct_ops_ublk_bpf_ops
# libbpf: failed to load object 'ublk_null.bpf.o'
# fail to load bpf obj from ublk_null.bpf.o
# fail to register bpf prog null ublk_null.bpf.o
not ok 2 selftests: ublk: test_null_02.sh # exit=255



Thanks,
Ming


