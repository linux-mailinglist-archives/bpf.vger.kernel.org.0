Return-Path: <bpf+bounces-47828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00373A006E8
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 10:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918FE7A1EBD
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 09:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E0F1DE8A2;
	Fri,  3 Jan 2025 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qxl5Awe0"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A21119A;
	Fri,  3 Jan 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896408; cv=none; b=K/8Ntiy4bYw3ogh//DjfHkcHhHu1trwKtjeKC5WVl8gU2ZyRu5ryoRvZklVQJ9zBvtVpmaCXhZUfS0xgbfmfwbZBQ/qCbEs90lgvL3ThBlqmGBB2/VV1jMwkjtxE9zLzrauPkpqNEWAzhCFH4OTPA9V1u/XPYJWbbjih1lDbDW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896408; c=relaxed/simple;
	bh=r12MOnn1uesY7j1pRUihCeTf3pHRkYo3YfSJvunhVU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMr6v1PxbnMQ2LoBzfobyFW3dD1xFrBZnJOh3TxCS6yS/D1808ynLt+WXAmzS0FxNFU+VE/uGXeEy+pKjbh/Z2UvJgyxFlGPZlcFzUhg1u8VYXY22R+vm31Xk3XTspBwCda2mI3I6QdZWABg4acGasZlMAPOc772TSyOoRF1gnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qxl5Awe0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jmVJJz+38rmIB/8qMaixIq1CEISbYL2BWv1447YsIio=; b=qxl5Awe00UrxQyzxcnu9RkYyU0
	fF7vfHF92LW1CXnqoogPXuc5wSjvtp0ZbkUgKPyloKemOnkrKKemSlIuSYlX/kxcb4ivp5N/rhZA9
	fYZl6bCab7DquVIsYm4heHU/+qg8Iqt3exliDH8vijZTaC15RV9m5iToT8tIhJRYUozjlgYZgfwTT
	jDsAr6t6nskr1oZ6o8xQI6W1tSq//M6oqZQJSOTvmbKVoLDMoLasZE5zFrhrWFVnOGnhahFlmYN27
	k6KH0W04gIETO3ueK1k7r5mBmTuDgecZQrXZt+DRalO/3+27/qFhlzwFB94QKStzxvjK07nKTXNJj
	eVLla9jQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdx8-0000000Cbaw-0eXi;
	Fri, 03 Jan 2025 09:26:46 +0000
Date: Fri, 3 Jan 2025 01:26:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vishnu ks <ksvishnu56@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
Message-ID: <Z3etVqYMWjh9n7s5@infradead.org>
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 01, 2025 at 12:04:56PM +0530, Vishnu ks wrote:
> - I'm developing a continuous data protection system using eBPF to
> monitor block request completions
> - The system aims to achieve reliable live data replication for block devices
> Current tracepoints present challenges in capturing the complete
> lifecycle of write operations

This is nuts.  No, we don't guarantee any stability in the trace points,
and certainly not for data integrity operations.

Please make sure this never gets near any production system.

