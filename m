Return-Path: <bpf+bounces-75342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6FFC80C4E
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 14:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80D74344ED7
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447D215F42;
	Mon, 24 Nov 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3dODMhB"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0001DF970
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990956; cv=none; b=J1mfCyLUNnGa5qa3qxotDVsQjnDbVhXcAzJEO13/Ybd8CRIWa5qgdysmGPGhbHEH+X89K/3R2MfNwBj0I9lQzf+n+ZuXYeOdliUN17YmaPtNA9tZ1915vBseyRVihq7qYOtj97GszQhhwr0y64RNjwbo5Ji0K0feGupxrews+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990956; c=relaxed/simple;
	bh=jZ7Dl0fkH9Xclybjw2cHiajioeW5NfPOu7q0NjTY9Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwutE2aLqEMFQQQ5LM/lw3wTQIsQrUnENvmd2RWkCnSjnBXZW/z/nOnk0BO9u5IOCQj/8KCWuQI89whWVnDTuYg6WZTwTbXT1s38s44j59YU0S626uyJ2BWSaPodbgIik0EcseCLaNurfwqGQHDV2rE0NJotnpBZyuWuL2vIhR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3dODMhB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763990953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Y7Gu0g7KzACy/FQqscAB7DMUDY1Q/tCB7l7mvHVwVM=;
	b=P3dODMhBxMKNGRN1IZL0JuYfvcVKkWmIpqRdvgSADE2CbNtJJsuNtRXW80pD1/BwZa5f84
	zXBQy+LjGWjhGxHfOkWYYa8LqjfNalZpM7iEtR7oNfXs8Xda7hVs7x+oI19yT3dnnjfvbF
	wbmvpc7a/spHAqsvFl4nELHBKQfLDm4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-uGltvYzQOUmnMv8pURrUsg-1; Mon,
 24 Nov 2025 08:29:12 -0500
X-MC-Unique: uGltvYzQOUmnMv8pURrUsg-1
X-Mimecast-MFC-AGG-ID: uGltvYzQOUmnMv8pURrUsg_1763990951
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD9051954197;
	Mon, 24 Nov 2025 13:29:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBDD81955F1C;
	Mon, 24 Nov 2025 13:29:05 +0000 (UTC)
Date: Mon, 24 Nov 2025 21:28:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, axboe@kernel.dk,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v3 10/10] selftests/io_uring: add bpf io_uring selftests
Message-ID: <aSRdkIIP0oRwGrLU@fedora>
References: <cover.1763031077.git.asml.silence@gmail.com>
 <6143e4393c645c539fc34dc37eeb6d682ad073b9.1763031077.git.asml.silence@gmail.com>
 <aRcp5Gi41i-g64ov@fedora>
 <82fe6ace-2cfe-4351-b7b4-895e9c29cced@gmail.com>
 <aR5xxLu-3Ylrl2os@fedora>
 <1994a586-233a-44cd-813d-b95137c037f0@gmail.com>
 <CAFj5m9KfmOvSQoj0rin+2gk34OqD-Bb0qqbXowyqwj16oFAseg@mail.gmail.com>
 <f1db3be4-a4a7-4fd7-bd5c-0295a238b695@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1db3be4-a4a7-4fd7-bd5c-0295a238b695@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Nov 24, 2025 at 11:57:10AM +0000, Pavel Begunkov wrote:
> On 11/22/25 00:19, Ming Lei wrote:
> > On Sat, Nov 22, 2025 at 12:12 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
> ...
> > > > 
> > > > `thread_fn` is supposed to work concurrently from >1 pthreads:
> > > > 
> > > > 1) io_uring_enter() is claimed as pthread safe
> > > > 
> > > > 2) because of userspace lock protection, there is single code path for
> > > > producing sqe for SQ at same time, and single code path for consuming sqe
> > > > from io_uring_enter().
> > > > 
> > > > With bpf controlled io_uring patches, sqe can be produced from io_uring_enter(),
> > > > and cqe can be consumed in io_uring_enter() too, there will be race between
> > > > bpf prog(producing sqe, or consuming cqe) and userspace lock-protected
> > > > code block.
> > > 
> > > BPF is attached by the same process/user that creates io_uring. The
> > > guarantees are same as before, the user code (which includes BPF)
> > > should protect from concurrent mutations.
> > > 
> > > In this example, just extend the first critical section to
> > > io_uring_enter(). Concurrent io_uring_enter() will be serialised
> > > by a mutex anyway. But let me note, that sharing rings is not
> > > a great pattern in either case.
> > 
> > If io_uring_enter() needs to be serialised, it becomes pthread-unsafe,
> 
> The BPF program needs to be synchronised _if_ it races. There are
> different ways to sync, including from within the program, but not
> racing in the first place is still the preferred option.

Both the bpf program(kernel) and application(userspace) code may
modify SQ's tail, I don't know how you can sync it within the prog &
application easily, otherwise bpf prog may become quite complicated or
implies safety risk.

> 
> > that is why I mentioned this should be documented, because it is one
> > very big difference introduced in bpf controlled ring.
> 
> That can definitely be mentioned as a guide to users, would be a
> diligent thing to do, but my point is that it doesn't change the
> contract. SQ/CQ are not protected, and it's the users obligation
> to synchronise it. With this set it includes BPF programs the
> user attaches.

bpf prog becomes part of io_uring_enter() which starts to race
with userspace.

The interface needs to be clear from beginning:

- who provides the sync between bpf prog and io_uring application wrt.
  modifying SQ/CQ

- if it is responsibility of bpf prog and application, how to do it?

- otherwise, it is one contract change from syscall pthread safety
viewpoint, because userspace need to serialize io_uring_enter() syscall
with userspace code for manipulating SQ/CQ


Thanks,
Ming


