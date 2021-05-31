Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F3539689F
	for <lists+bpf@lfdr.de>; Mon, 31 May 2021 22:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhEaUHm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 May 2021 16:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhEaUHl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 May 2021 16:07:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEFBC061574;
        Mon, 31 May 2021 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D1L/+mdxfgOX82bLOF7iyFND6vOFiosl462sjl1BK4o=; b=SRMmBC3xPXkBUEG0m5YGRTdxCk
        bCr4DuJiA1ox9ZUmaow53og/iVkkgGK5/vDOd34oY7nhUaRLVY9rEgAj+l5xSmx9nOenIxhtIHnad
        txrv3EcRLTShOdED/XeuNDdCs4AeNnvgemV4V1VsXzE5XujhXBkOkYFIDT3laJAFpxab1dMrQGSxt
        YhX9tA2Rb+bDwM/dvTvSIaLKi2+cjL6vLija0lxMC8AjwE4j1ma+ZSk4EM4vRS8W6jgMpiYIeXNoz
        PgUVCbXLeX8MwshL7BxnmSzhzDZrcVpbZB26YYEiUVzXgzBo+Sud9zRFf/7F3gM7P6HH/LiZzjQgm
        hd/lPeiA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lnoA8-009MeU-BK; Mon, 31 May 2021 20:05:33 +0000
Date:   Mon, 31 May 2021 21:05:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     andrii@kernel.org, daniel@iogearbox.net, corbet@lwn.net,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] Add documentation for libbpf including API
 autogen
Message-ID: <YLVBhF+vUBSq538c@casper.infradead.org>
References: <20210531195553.168298-1-grantseltzer@gmail.com>
 <20210531195553.168298-2-grantseltzer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531195553.168298-2-grantseltzer@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 31, 2021 at 07:55:52PM +0000, grantseltzer wrote:
> +++ b/Documentation/bpf/libbpf.rst
> @@ -0,0 +1,14 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +libbpf
> +======
> +
> +This is documentation for libbpf, a userspace library for loading and
> +interacting with bpf programs.
> +
> +All general BPF questions, including kernel functionality, libbpf APIs and
> +their application, should be sent to bpf@vger.kernel.org mailing list.
> +You can subscribe to it `here <http://vger.kernel.org/vger-lists.html#bpf>`_
> +and search its archive `here <https://lore.kernel.org/bpf/>`_.

https://www.w3.org/QA/Tips/noClickHere

I suggest:

You can `subscribe <http://vger.kernel.org/vger-lists.html#bpf>`_ to the
mailing list or search its `archives <https://lore.kernel.org/bpf/>`_.

