Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52FF4FCD8D
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 06:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345757AbiDLEXD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 00:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345940AbiDLEWv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 00:22:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD2C29827;
        Mon, 11 Apr 2022 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M/eBqW7IS37VLx4QPwXoaFdr4fbVP8lEfBn+JPoJ8wA=; b=DGPNNVXyOotEHd5Lb96+fX3pE4
        iQbqIgSNGvfstIaYJzBcntrlidp0YvyE7tGPMEi3T5wz42hbpsga82VQKe18Uu/rjuMv5Zk2v+7ua
        YDJn+u/ce1JW1u6LKtYqesVvmMGNi4Xa/v6Pp58FUUOPdbsUtZUoVBep9gGKhQMHstnF+GVbpGKhv
        Gr+I5BceoVGxEkQnrTAYcDr9okRHxj/0ZvtXUqgWXMzFK5fwo5PLbp8nUxyXk26fAY/ISU1JdbIGz
        mWl5sYh6+vvuM2/fe0UaiplTJlvvl5ahHg/9R+GelIby6UhD3xUGVKL7RxkyYuUqTJZWQrLQD5Vel
        80QF21Cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ne814-00BWI4-SZ; Tue, 12 Apr 2022 04:20:34 +0000
Date:   Mon, 11 Apr 2022 21:20:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, hch@infradead.org,
        imbrenda@linux.ibm.com, mcgrof@kernel.org
Subject: Re: [PATCH v2 bpf 3/3] bpf: use vmalloc with VM_ALLOW_HUGE_VMAP for
 bpf_prog_pack
Message-ID: <YlT+ErUHkFidID2S@infradead.org>
References: <20220411233549.740157-1-song@kernel.org>
 <20220411233549.740157-5-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411233549.740157-5-song@kernel.org>
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

On Mon, Apr 11, 2022 at 04:35:49PM -0700, Song Liu wrote:
> Use __vmalloc_node_range with VM_ALLOW_HUGE_VMAP for bpf_prog_pack so that

That is only very indirectly true now.
