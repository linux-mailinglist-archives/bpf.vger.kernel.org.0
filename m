Return-Path: <bpf+bounces-345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2B36FF619
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 17:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEFE1C20F7B
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC3964D;
	Thu, 11 May 2023 15:36:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA506629
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 15:35:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DCE55BE;
	Thu, 11 May 2023 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=MHscP8JO9a977ifuFmAms77FPjymkVYX028FcGoGDPI=; b=TC8tH+i3jJ9ACSqpipFxuZrJ6j
	6rEraOVNsToWwPk8JihVWkQgJTLx9Ijn8VYLqr2l3z/p8GG9tpZ2ln891Z4ya1vx2VPYUK7uEjMWb
	NzKFFSnrCVnZqbmt7QmXik/3/ZTqMf0qE8LQXa5qOeUz+dFphnqyG5WtnT/mB7klrCCND+SQL77Dr
	uyrqf+2HFbo9BHgQVgFBNaVeD84Beo8SpM5rt+XI3giRUGRZo0GdJOgc3UriyautGBw8wEJ9AUjYZ
	G5iXDH5VmL7RE27rOqm3HApVG9w9dy4YeLA3SZep3w7p7yo10iXtCOlS94GicuEIlMpZYP6+ctjM0
	5uhKqOjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1px8Kj-009E8e-0V;
	Thu, 11 May 2023 15:35:57 +0000
Date: Thu, 11 May 2023 08:35:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Alistair Delva <adelva@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Serge Hallyn <serge@hallyn.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 4/9] block: use new capable_any functionality
Message-ID: <ZF0LXRWZb+xL+pTS@infradead.org>
References: <20230511142535.732324-1-cgzones@googlemail.com>
 <20230511142535.732324-4-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511142535.732324-4-cgzones@googlemail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 11, 2023 at 04:25:27PM +0200, Christian Göttsche wrote:
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.

What is this new function and why should we using it?

Your also forgot to Cc the block list on the entire series, making this
page completely unreviewable.

