Return-Path: <bpf+bounces-48370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE5A06FE1
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 09:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF197A2F63
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 08:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750B215045;
	Thu,  9 Jan 2025 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wwTNL5o2"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1385B77102;
	Thu,  9 Jan 2025 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736410990; cv=none; b=g8uBTCJzAg2k7oTNvy6pmlAXrVdeqYYZYQBqnS/DwHpDH9ZozlY7v6n61goEkHL2RtLcIP/+g/QVuGRPnICbltmDY+JrbZfsdm+bseisDJYhSErDYwEBe7QHAioxb6TBt2eA7oYHvdvqzjI4Hj6uP8J0EKBp0BMYfPJW2XGxYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736410990; c=relaxed/simple;
	bh=N58UFaY6c8ONQZFsaFTgGtv6rECWQYrW8BZJsXhwfGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug6nnmLpYY2Db164+ECZcFWjudpH7wpFLJdLjDhUhSA2V7fjuHYwifQo1eyitxqm3kF1RwSKAtlybf41nmFxloijaYbJPS7UjpY+njkp9CDVHnS6E8XY4kmpYn2MQ95+HT4goEKIbUWF2VwcF3+PGeWGVyJB1/b5fuzTgc7emkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wwTNL5o2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y+Vh7rfq/7OoaD/IsISKN4B/bJgLMs6nBckWnFw2QEY=; b=wwTNL5o2PrJNFVNsz/xKhWJmSM
	ZDxd+ffCCbK0fUJEEGHCLabsv2VV0dOLB+IdTzr4+LJfTi5QvYgwKcWlAz/keEGERfaPYuLzj3dyO
	a5/N5TPgpmRAAF2CutF/IpXUqTXHjmRnEH6w7jM+XHG6yQpHaAG/KaOde8ZCUDAI5BjqwYpdBA/Vu
	ZMXdBowhIu4gc2MuBwS165ER8BGQX19a3bh8g4TK9TfvOHbNmwNK4s6KcW9zI5/2mu/jfiP7CXg05
	VfF02b1KVHBIqL9w5SY1spNsk2dXG+BY5EOKGjqVGjUIR5rXkFZuwP4YZlD0HEhGzWAfc1eeHQrt4
	vdo0i/iw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnoj-0000000BAUc-1uqF;
	Thu, 09 Jan 2025 08:23:01 +0000
Date: Thu, 9 Jan 2025 00:23:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-modules@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] sysfs: constify bin_attribute argument of
 sysfs_bin_attr_simple_read()
Message-ID: <Z3-HZT5kwt18QSQn@infradead.org>
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
 <CAADnVQ+E0z8mY4BF9qamPh1XV9qs2jZ03bfYz2tVw8E4nFVWBw@mail.gmail.com>
 <0cbfd352-ee3b-4670-afae-8e56d888e8c3@t-8ch.de>
 <CAADnVQJMV-zRcDKftZ-MbKEJQ7XGmPteMYCS0Bm5siBEXUK=Fw@mail.gmail.com>
 <2025010914-gangly-trodden-aa96@gregkh>
 <Z3-DcbY60SxoM0dN@infradead.org>
 <2025010930-resurrect-attest-94c9@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010930-resurrect-attest-94c9@gregkh>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 09, 2025 at 09:12:03AM +0100, Greg Kroah-Hartman wrote:
> > Hey, when I duplicated the method to convert sysfs over to a proper
> > seq_file based approach that avoids buffer overflows you basically
> > came up with the same line that Alexei had here.
> 
> I did?  Sorry about that, I don't remember that.

It's been a while..

> As for seq_file for sysfs, is that for binary attributes only, or for
> all?  I can't recall that at all.

Non-binary ones.


