Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672774FCD8B
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 06:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbiDLEWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 00:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245601AbiDLEWV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 00:22:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851E126AF9;
        Mon, 11 Apr 2022 21:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KkMg8Uf8LW6cbwskVM3FacACcaEeYcQo6r7APr6POlA=; b=3cY8tpKNT1BaSTaCkKVAoxndqi
        AwpMQHnIuH73A0J9X6Ayv2Q4DR2b1Oa0JfpBKLMye+UyOL6u28Usi5+gXgQsPzggXpDFvKm7kquqH
        A0bCtDj0OdYT2nXsIvvYggaH1Y+DbBTUMlZfpKvSB0VQshU0QITJvj0fxFL7p3J/Yqp9KOlGgM9ya
        7vPplIE+BAjgkwHENswnO7L8bvdMT2nyAEUiC7OCvYR7o3EYpJIdL3xoNBfVaYm6JSDDwOAJXqpCU
        Om9an+IhivYEVSG+o/55uA1waNZ3TDPplzBB5y4NtKhNl9fR5SuCubQY6mv70PiCB2HsJDa7/CcME
        /QY/bDLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ne80b-00BWBI-2P; Tue, 12 Apr 2022 04:20:05 +0000
Date:   Mon, 11 Apr 2022 21:20:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com, hch@infradead.org,
        imbrenda@linux.ibm.com, mcgrof@kernel.org
Subject: Re: [PATCH v2 bpf 2/3] module: introduce module_alloc_huge
Message-ID: <YlT99YrkJyLVMdNH@infradead.org>
References: <20220411233549.740157-1-song@kernel.org>
 <20220411233549.740157-3-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411233549.740157-3-song@kernel.org>
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

On Mon, Apr 11, 2022 at 04:35:47PM -0700, Song Liu wrote:
> Introduce module_alloc_huge, which allocates huge page backed memory in
> module memory space. The primary user of this memory is bpf_prog_pack
> (multiple BPF programs sharing a huge page).

I kow I lead you downthis road first, but I wonder if we just want to
pass a flag to module_alloc instead.  This avoids duplicating all the
arch overrides.
