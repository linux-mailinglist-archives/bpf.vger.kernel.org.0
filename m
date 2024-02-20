Return-Path: <bpf+bounces-22286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6604A85B344
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 07:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9865B1C215A7
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 06:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD6459B7F;
	Tue, 20 Feb 2024 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nzp4aMC8"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57855A0E0
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708412248; cv=none; b=I6v0TSdFWzX7EngO2nzi42hwappjUrKEGNoRnVDSXk904svP+EmofAfIxt/ZfMBCuOe6hZ9fzirNYfMPLEI7hrXo/buZvagv/vo1KZPs7FLAfoVGr4X1vWERY6OMB0nPezxfqAFDHzR/Ci9vSV6BGK5dobjwsQvYvrd9S/J0wN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708412248; c=relaxed/simple;
	bh=q8FjFUgbGtrdH9r+Zx3fwtEx1ifY0qtNhxFEpLR734I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qS8i7DJlxQcNDzrDzXNTmPOgJYu1dG3OwV07D/wbUeomd2dMsw7i9HchH/2yfCDvYSPglx1EbGJTpUyqmqsaRzauV1taOl8Kbzmq/137tzNPM6KTP8/MMYOclh/lmS8cyvAS3Hkibo0TTEUERoaHxWDl2a2eBd+6z+ESLAvTSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nzp4aMC8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q8FjFUgbGtrdH9r+Zx3fwtEx1ifY0qtNhxFEpLR734I=; b=nzp4aMC8iHHt+N/vjDR+St78uC
	9h/qR+FxaqRVKXV0lKE4zA1nTpsHkPsSdS3T6V1hqYI7VBLPh8l/VEKVsAEiTKYiQRzS7BzPFqt6g
	M/dkG/7P5vR/Ue/2buzeBLBhJwVU4Qc746kHbQU0VyzEoFAdKjXc8ME2gnoZKGatPNhn6waj0MELi
	vI5gO5aUspLydUk4ets1YVGXc01qKQVS9YYhlQsH3ZFzIFgdnVn1fnox0iC7Pbvwa9CqS9neGhSWe
	zDA1GuZ6OYagpluN5JVx2AzoRe121egQp1ty/bxOPaKFPJi0Wq9qIjo0C3jbeOOu12/wWKCRPT6uh
	3VSjVG0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcK4D-0000000DRJj-2DVQ;
	Tue, 20 Feb 2024 06:57:25 +0000
Date: Mon, 19 Feb 2024 22:57:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
Message-ID: <ZdRNVWhX-7Uel7Gy@infradead.org>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-5-alexei.starovoitov@gmail.com>
 <Zcx7lXfPxCEtNjDC@infradead.org>
 <CAADnVQKT9X1iSLXojVs1sWy4B-qEGccuk6S6u1d9GBmW9pBAeA@mail.gmail.com>
 <Zc22DluhMNk5_Zfn@infradead.org>
 <CAADnVQJ8azcUznU6KHhwEM99NUOx8oai8EOyay4dxLM6ho8mjw@mail.gmail.com>
 <Zc8rZCQtsETe-cxU@infradead.org>
 <CAADnVQJ_rn+PEETAApwK6iW5LYxGh=-rijpfTB6Y6r8K6sG4zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ_rn+PEETAApwK6iW5LYxGh=-rijpfTB6Y6r8K6sG4zA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Feb 16, 2024 at 08:54:08AM -0800, Alexei Starovoitov wrote:
> "vmalloc like allocation that grows" is not what I'm after.
> I need 4G+guard region at the start.
> Please read my earlier email and reply to my questions and api proposals.
> Replying to half of the sentence, and out of context, is not a
> productive discussion.

If you can explain what you are trying to do to the reviewers you're
doing something wrong..

