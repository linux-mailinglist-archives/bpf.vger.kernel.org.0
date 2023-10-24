Return-Path: <bpf+bounces-13099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF547D4695
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 06:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523E2281A69
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 04:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F43D748D;
	Tue, 24 Oct 2023 04:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zrK1+C6T"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565E515BE
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 04:00:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F6E5
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 21:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rAhm+S8WkgS2WcwMtV35U7rxhHFkXYQ9VBLDjXK7jEc=; b=zrK1+C6Tp24vx+M3s+8VlDxPw4
	HoUPYxB75vcN9f7ZFHtnH/s3v6YY4jas/PyevBIcT3SidansI9DuvG+zN4w9dCZMahMfUZtEoxcQH
	EKfBMMFFu7p01SY+fI0j173/Z0mSoVJYRf9cpT0qAZlJt5rpwpLAuEPBi8HV5sZmKMzfZD+Gq9T73
	i+zjJeNy2kT5TEGMPtlCcOj9L+Nyh8Bt+ZaMd+mfxM1AR8GOzPZ+/TmQtkdN+qiri+moaJeEAJNx3
	inY+xa6aWWilNtF+95BHNak/Bc6KThSA8Va5doacA0manueQKj7sH/WYukjixUsSNpdxghZRwsD5S
	hWqNgN9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qv8av-008lXy-1c;
	Tue, 24 Oct 2023 04:00:41 +0000
Date: Mon, 23 Oct 2023 21:00:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Will Hawkins <hawkinsw@obs.cr>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>,
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] ISA RFC compliance question
Message-ID: <ZTdBacjsOq9MmXEg@infradead.org>
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <ZTDGfppgSnpKjaYz@infradead.org>
 <CADx9qWgP=h4kQEJ2Cpy-A9hyiKLdkF3hVZVydLrz2Lk+UGBaAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADx9qWgP=h4kQEJ2Cpy-A9hyiKLdkF3hVZVydLrz2Lk+UGBaAQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 23, 2023 at 11:06:32AM -0400, Will Hawkins wrote:
> Can we look to either RISC-V or ARM for prior art in how they worked
> different versions and compliance levels? I am happy to amass some
> documentation about their processes/procedures if you think that it
> would help!

I don't know arm to well.  x86 is mostly discoverable by bits set in the
cpuid leaves, and RISC-V has formal extensions, initially letter and
after they noticed that isn't fine grained enough a lot of Z-prefixed
ones.  I think RISC-V is a good starting point:

  https://en.wikichip.org/wiki/risc-v/standard_extensions

we need to be very careful on what are good scopes for extensions so
they are on the one hand useful, but on the other hand not too many
of them so that we stop being easily interoperable.

As seen in the other branch of this discussion we should also thing
a bit of what is supported by existing implementations.  I don't think
it is a non-startert if they become non-compliant, but we need to weight
this very carefully.


