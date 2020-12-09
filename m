Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12002D4519
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 16:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgLIPJP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 10:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgLIPJP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 10:09:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B518C0613CF;
        Wed,  9 Dec 2020 07:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KmfM0dz9aaWaeZPra6pVjVS4g9ep1l744z/4R96Ui3M=; b=fKfdu1e6Ef5Bpq8BX9sCBr+tUY
        M4m9JESfmi+ue+BUSliO/MnXrGCgke/bHGWZAminabL+uWeZpoYPeUESXedSSW6ZYg5G2t6QGAwfQ
        UGGGVW0ubs7ikPD74DUhssG/PYrOUtoPU6imLXFH4klaVVqblTH8W32f7bM2KIwnmTbUPdgx3ku8L
        H4Zi3RtjNol5wuHqTHF+vY9IXtZ5cyexGKG3QIRezCDMdfzj6j9qzQZAQxikeBw/IDZdBcF5TYL8I
        p0d3USXWXkdaEAjeaLxSrg6OYxEffWrEj3efEqKLGBPp01AUvk95tFgAeFS07cDh8Z+eMLXptis4T
        oNeMutpw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kn14s-0005Hf-Kd; Wed, 09 Dec 2020 15:08:26 +0000
Date:   Wed, 9 Dec 2020 15:08:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Justin Forbes <jmforbes@linuxtx.org>,
        bpf <bpf@vger.kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] mm/filemap: add static for function
 __add_to_page_cache_locked
Message-ID: <20201209150826.GP7338@casper.infradead.org>
References: <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
 <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
 <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com>
 <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
 <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com>
 <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz>
 <CAADnVQJARx6sKF-30YsabCd1W+MFDMmfxY+2u0Pm40RHHHQZ6Q@mail.gmail.com>
 <CAADnVQJ6tmzBXvtroBuEH6QA0H+q7yaSKxrVvVxhqr3KBZdEXg@mail.gmail.com>
 <20201209144628.GA3474@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209144628.GA3474@wp.pl>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 09, 2020 at 03:46:28PM +0100, Stanislaw Gruszka wrote:
> At this point of release cycle we should probably go with revert,
> but I think the main problem is that BPF and ERROR_INJECTION use
> function that is not intended to be used externally. For external users
> add_to_page_cache_lru() and add_to_page_cache_locked() are exported
> and I think those should be used (see the patch below).

FWIW, I intend to do some consolidation/renaming in this area.  I
trust that will not be a problem?
