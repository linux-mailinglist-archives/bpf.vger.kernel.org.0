Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E81D616F0D
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKBUqI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiKBUqH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:46:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8FB65F1
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:References;
        bh=kVVQiLUiV02wv3G/Z2IveioDo1I9DWghZhu7b2GiUuw=; b=2nCGK4KlUpYduL2XJk2EpqwfXr
        BEjVoYzzmtd2AjnwwIwJ5VIoBRMnARBeG0F0UytyJ3WNkzyyIIcUDD3ksiG3X6a4LsHqSTwi7umqu
        MSAJSIEbPYRMwOHruPfPxxNqNduWQ/UU7gN910KimpU1MQTAGJd9fTeDH+9qsZYMWRzOr7hKzIXd4
        NEm/PlbhomeUEfEHcewO0iMySL6i5zMUthAh6BezOjIy++aRh8ZemEXcxBp/IOFL6UtEP0xEuSzIM
        dEtRR8lhCB92riK0LmeTMh9aWCeLChMNOSTD+S2j4ThItizxgXN94Nr2bOMw0GSo8Us/wy6c+Pn3+
        Gx79qdZw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqKcZ-00EMGq-15; Wed, 02 Nov 2022 20:45:59 +0000
Date:   Wed, 2 Nov 2022 13:45:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, dave.hansen@intel.com, rppt@kernel.org,
        zhengjun.xing@linux.intel.com, kbusch@kernel.org,
        p.raghav@samsung.com, dave@stgolabs.net
Subject: Re: [PATCH bpf-next v1 RESEND 0/5] vmalloc_exec for modules and BPF
 programs
Message-ID: <Y2LXBsEzHBFafzda@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031222541.1773452-1-song@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 31, 2022 at 03:25:36PM -0700, Song Liu wrote:
> Changes RFC v2 => PATCH v1:

<-- snip -->

> 3. Drop changes for kernel modules and focus on BPF side changes.

Yeah because in my testing of RFCv2 things blow up pretty hard,
I haven't been able to successfully even boot *any* system with those
patches, virutal or bare metal.

I'm very happy to help test new iterations if you have anything.

  Luis
