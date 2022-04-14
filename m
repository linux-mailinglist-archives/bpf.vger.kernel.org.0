Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A94A501CC1
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 22:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbiDNUgq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 16:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346657AbiDNUgj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 16:36:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2086EED911;
        Thu, 14 Apr 2022 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ffxFdsGh0bqDPLkDrznla8llrXAaFkdXXDivllwyW4o=; b=0dQ9C7MpbhYSKNF4gxgJy1LX3E
        7TA6YrJemtuhcydpZkRBEj3qrNIYQA3TqpmIzMF43x0+C47JxgdoknbUehrg1kFgLI/s7zF35BS8i
        zQ8uSolA1IwUSd7AgZNDsjO8Qi3pRUak5ErpR47J2xiWdoGWeq9rQ+UeJmB8wn6rLmh7yTNL5V9nU
        dB3aC1bfKFfEU1H8ybeAFEpF365RFI1wCsOEUTDFW0l2Z/6Fsr3rNInZVdVLXPcZwE0lJ57Dc86ge
        cy1dQQqRDd4W6IwOBklBGxUVOmwpNNJavXGAnfWarAbrFzTqJFjY5MNNSHZjSogK8xUGNh0Aq7VrM
        U2n8CCtw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf6AF-007DAO-JU; Thu, 14 Apr 2022 20:34:03 +0000
Date:   Thu, 14 Apr 2022 13:34:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, hch@infradead.org,
        imbrenda@linux.ibm.com
Subject: Re: [PATCH v3 bpf RESEND 3/4] module: introduce module_alloc_huge
Message-ID: <YliFO2sDv31j5vLb@bombadil.infradead.org>
References: <20220414195914.1648345-1-song@kernel.org>
 <20220414195914.1648345-4-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414195914.1648345-4-song@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 14, 2022 at 12:59:13PM -0700, Song Liu wrote:
> Introduce module_alloc_huge, which allocates huge page backed memory in
> module memory space. The primary user of this memory is bpf_prog_pack
> (multiple BPF programs sharing a huge page).
> 
> Signed-off-by: Song Liu <song@kernel.org>

See modules-next [0], as modules.c has been chopped up as of late.
So if you want this to go throug modules this will need to rebased
on that tree. fortunately the amount of code in question does not
seem like much.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next

  Luis
