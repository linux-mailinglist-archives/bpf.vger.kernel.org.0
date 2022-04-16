Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27145033B4
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 07:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiDPFLR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 01:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiDPFLQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 01:11:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85DDAF1E9;
        Fri, 15 Apr 2022 22:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/iIo0JVr8TqpS6OeM1MMTlnanQ4ma+icA95lQhkDqAg=; b=vuqPnYaKN147QAafHsn7Xwyejz
        g4I0w7NWO+dMJj/kMLvTwsKf9t9ddprTrTDkT60CoTB6MnShtPbUOh72WnAhkchMIzm+PpQvU2KXT
        Fv/ZFNPcrUfHOEXcmrPnRnldZuosGM0QKngCmihpLBdAKnClCEJwlA2R1wJKf8lGgrjVZ5kJ1Fwx4
        5c+3v3X64MnP812jEAKb+M6fqJKQctmEYDErmyXeNy0diIoo6HE6hXjpbEwuJ0a6T4AXILMYZoEfB
        TDz+JlzEaASoOfixBBwZ+7NHwAqvYs2s24Fb72MBgoOA/Msq916qL7MVLsTw63VQeJz2REYpiHAiB
        5U89pCfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfafr-00CGE1-O2; Sat, 16 Apr 2022 05:08:43 +0000
Date:   Fri, 15 Apr 2022 22:08:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com,
        akpm@linux-foundation.org, rick.p.edgecombe@intel.com,
        hch@infradead.org, imbrenda@linux.ibm.com
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Message-ID: <YlpPW9SdCbZnLVog@infradead.org>
References: <20220415164413.2727220-1-song@kernel.org>
 <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
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

On Fri, Apr 15, 2022 at 12:05:42PM -0700, Luis Chamberlain wrote:
> Looks good except for that I think this should just wait for v5.19. The
> fixes are so large I can't see why this needs to be rushed in other than
> the first assumptions of the optimizations had some flaws addressed here.

Patches 1 and 2 are bug fixes for regressions caused by using huge page
backed vmalloc by default.  So I think we do need it for 5.18.  The
other two do look like candidates for 5.19, though.
