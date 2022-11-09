Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1C622431
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 07:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiKIGzQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 01:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKIGzP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 01:55:15 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09C11C932
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 22:55:14 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2DA1268AFE; Wed,  9 Nov 2022 07:55:12 +0100 (CET)
Date:   Wed, 9 Nov 2022 07:55:12 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Song Liu <song@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
        x86@kernel.org, peterz@infradead.org, hch@lst.de,
        rick.p.edgecombe@intel.com, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <20221109065512.GA11254@lst.de>
References: <20221107223921.3451913-1-song@kernel.org> <Y2o9Iz30A3Nruqs4@kernel.org> <Y2pNyKmMnOEeongp@ziqianlu-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2pNyKmMnOEeongp@ziqianlu-desk2>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 08, 2022 at 08:38:32PM +0800, Aaron Lu wrote:
> set_memory_nx/x() on a vmalloced range will not affect direct map but
> set_memory_ro/rw() will.

Which seems a little odd.  Is there any good reason to not also propagate
the NX bit?
