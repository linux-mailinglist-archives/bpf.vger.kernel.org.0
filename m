Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98CD5025A1
	for <lists+bpf@lfdr.de>; Fri, 15 Apr 2022 08:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245602AbiDOGeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Apr 2022 02:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbiDOGea (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Apr 2022 02:34:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019FAA7740;
        Thu, 14 Apr 2022 23:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AlSJrh/9aVdD6cccT4WMJlmUmFpg/2qtlWCw6b8UaS8=; b=C85NOtrZeDmbcQIJtBMn+UH4yg
        wAE14ydK2cPQcvA6sTvku0725EUU2bbJWA2cYyN2u9LD4UJOa+yettotZc5rO0g7KnNlAyEFW16K7
        hg62RpMXTl5L/Yz0ZYkSxPWqx4oLJIlSXpL8KvoAtrWQbcNeOrvmbCbY8xelRO/gbyF/UpQ01jPQF
        vJyVmnMhijlVS9O0NhmANtGNZ10CI+W+5CaLCIQOAn8ZlhswxHSjFe9g7rb8uVHo2NaJLGMqQBTe6
        ptdU5ynL/jRR9whMLC6m2YXic1KtNhebfGx23pgAY/mQ2xg/CVO6JVuLS5twqV8+8KH8I53Xfnnkr
        B8r2XJbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfFUx-0090pQ-Gn; Fri, 15 Apr 2022 06:32:03 +0000
Date:   Thu, 14 Apr 2022 23:32:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, hch@infradead.org,
        imbrenda@linux.ibm.com, mcgrof@kernel.org
Subject: Re: [PATCH v3 bpf RESEND 2/4] page_alloc: use __vmalloc_huge for
 large system hash
Message-ID: <YlkRY8QfAdNk+Oso@infradead.org>
References: <20220414195914.1648345-1-song@kernel.org>
 <20220414195914.1648345-3-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414195914.1648345-3-song@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 14, 2022 at 12:59:12PM -0700, Song Liu wrote:
> Use __vmalloc_huge() in alloc_large_system_hash() so that large system
> hash (>= PMD_SIZE) could benefit from huge pages. Note that __vmalloc_huge
> only allocates huge pages for systems with HAVE_ARCH_HUGE_VMALLOC.

Looks good (modulo the possible naming chane suggested in patch 1):

Reviewed-by: Christoph Hellwig <hch@lst.de>
