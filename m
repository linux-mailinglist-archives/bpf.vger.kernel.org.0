Return-Path: <bpf+bounces-35487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579D493AE62
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 11:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D42281C92
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1491509A0;
	Wed, 24 Jul 2024 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/HwJwF3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6422C1A5
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812468; cv=none; b=q/C9NdW9GMv2BU/9M0/A9FG+cXBtjTy3dkg9RgWPNGkXTgnEgJaMhMm6j9iGGHkznwJwX/ghlBYvmob/4Zukyetph+KZR8AQAuHcaL2feg2MbHsSRGvu6mJq5X6Eh/vQtKSh7zevdd+X7GCXrE2rbs2ARuM/pkaDMY3sozQpWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812468; c=relaxed/simple;
	bh=FKum+tuaq61hH+eu0Wcokw5ZMoy4++IOwlcPxNd7Fog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q22YPAsnNhAPnnq3yibGDytNoKm3q67fhcPqeW3FZYtBTZVEPwgg+A+3OIAg9CEDK+xD58+aar4ZTggrtp3Cxg3qP0P7wg7o7mehgamqp8B2TScnin5SBc7wXHKUsqbhxsi2XEcpv9P9GB0KbCPOTeQTVpuxdF5KzwnaxGxKq6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/HwJwF3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721812466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LfKLYY6OSN+hoIgz0IYPiRQ+M14NGRLQWnwwXMGcBg=;
	b=W/HwJwF3PJiOfEhXgomeix/6aGqUCxCnRthRSkN51sLMZYD9hcish10t3mQED6O/BE2LlQ
	xVrAw6jgpqKhwR3Oq3GEVUcGUeCsLyZqOFffwAj7cNGWynbBmQK7mwb4z4enGZM0qvpjZn
	lIM/7QedWNKoT02CZdMCvvqf27eMZRQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-HKAoVx_JMRStW9pdVrcheA-1; Wed,
 24 Jul 2024 05:14:05 -0400
X-MC-Unique: HKAoVx_JMRStW9pdVrcheA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 982BC1955BF1;
	Wed, 24 Jul 2024 09:14:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.67])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A1251955D42;
	Wed, 24 Jul 2024 09:13:55 +0000 (UTC)
Date: Wed, 24 Jul 2024 17:13:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	song@kernel.org, andrii@kernel.org, drosen@google.com,
	kuifeng@meta.com, thinker.li@gmail.com,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] bpf: export btf_find_by_name_kind and bpf_base_func_proto
Message-ID: <ZqDFzmDfHN1igZVp@fedora>
References: <20240724031930.2606568-1-ming.lei@redhat.com>
 <5be6678d-d310-4961-a57c-45b311879017@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be6678d-d310-4961-a57c-45b311879017@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Jul 23, 2024 at 09:43:12PM -0700, Kui-Feng Lee wrote:
> 
> 
> On 7/23/24 20:19, Ming Lei wrote:
> > Export btf_find_by_name_kind and bpf_base_func_proto, so that kernel
> > module can use them.
> > 
> > Almost all existed struct_ops users(hid, sched_ext, ...) need the two APIs.
> > 
> > Without this change, hid-bpf can't be built as module.
> 
> Could you give me more context?
> Give me a link of an example code or something?
> Or explain the use case?

The merged patchset "Registrating struct_ops types from modules" is
trying to allow module to register struct_ops, which often needs
bpf_base_func_proto()(for allowing generic helpers available in
prog) and btf_find_by_name_kind() (for implementing .btf_struct_access).

One example is hid-bpf, which is a driver and supposed to build as module,
but it can't be done because the two APIs aren't exported.

I am working on ublk bpf support, which needs bpf_base_func_proto() at
least, and might require btf_find_by_name_kind() in future.


Thanks,
Ming


