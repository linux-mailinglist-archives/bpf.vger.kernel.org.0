Return-Path: <bpf+bounces-4256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D10749F2A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 16:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BCF1C20DB1
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C47946D;
	Thu,  6 Jul 2023 14:37:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF38C19
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 14:37:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD27010F5;
	Thu,  6 Jul 2023 07:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=baht0WSMZ6QbZM7pntmZjkkjFnLfU481ZUm81KibBA4=; b=X0+ZV0gap58VSs2uIfMFpkbEJf
	x6AtYUJWe4uER2c03zE0niPknfxHoSLbdWmPzjJx+EoXBduZ+/GnPN0+4IxD+D2xME6glwrK6iWou
	Ylj5KzcGYagn1hvcb7+E1hKb9IHJFIPqjRv92s5TMRoN5+ZNr1nxw2rLJbO3i7aKUmolj2RoGdy+U
	V9VcpZbTdLaN8qLwRtFjBbIuUop/Kf/7jWpPZE4p0AZQKj9Li+PkEfkmhc7qVvEj/1e8XZ+D19KdN
	zy/ozN7aaZEYB9U5bK/N03hXRcuLmF5F5hiA0yCSJteaHM/A7vadQyCfFlf4iE57iwSpFzkdgMVUV
	kHYihmeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qHQ6y-001t1W-02;
	Thu, 06 Jul 2023 14:37:36 +0000
Date: Thu, 6 Jul 2023 07:37:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Hou Tao <houtao@huaweicloud.com>, Alexey Gladkov <legion@kernel.org>,
	bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v1] fs: Add kfuncs to handle idmapped mounts
Message-ID: <ZKbRrziFf4tf09vo@infradead.org>
References: <c35fbb4cb0a3a9b4653f9a032698469d94ca6e9c.1688123230.git.legion@kernel.org>
 <babdf7a8-9663-6d71-821a-34da2aff80e2@huaweicloud.com>
 <20230704-anrollen-beenden-9187c7b1b570@brauner>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704-anrollen-beenden-9187c7b1b570@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 03:01:21PM +0200, Christian Brauner wrote:
> That's too much stability for my taste for these helpers. The helpers
> here exposed have been modified multiple times and once we wean off
> idmapped mounts from user namespaces completely they will change again.
> So I'm fine if they're traceable but not as kfuncs with any - even
> minimal - stability guarantees.

I fully agree.  I also don't think any eBPF program has any business
looking at idmapping.

