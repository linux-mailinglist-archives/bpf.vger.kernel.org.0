Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEF75733CE
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 12:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbiGMKIY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 06:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbiGMKIX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 06:08:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D11FA1E3;
        Wed, 13 Jul 2022 03:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xgbsSE5I8qlHR8gZ109IrXjq+ksohUUuf41/l4Lzbqo=; b=ummZkWOCoXgshNgXw6Y7JLWZMQ
        Nse9cSoW/7YlLVurlIq9NWjofe0vO9oy0GGy8w4Zu5w12t9cgur6R7lMZQcuPEf8DYI1nsTgVvxJx
        C4ueqO9gt9BnkFwP1GXS6D30Msfg1cL0mUwFJM6u7M/YuKFA+plBtcdmIsxiPo7gLjNEhs/bq+mUv
        Vzai45D08mKp816K7AVrGYDuY6N09f9Zv8FLdx61uBvh+8bNZB0VWpbO8H8WVpLWl4iS6qK1ey0Cs
        U/8UbQJXrDSGVFhqGyTLLZS2dNCNIuQGMNNbTnxgk2Kd3agWFD44s/PhsMnj9mRbZHPt0CXf6JhCX
        NmnnWZXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBZI0-002Zfb-Nq; Wed, 13 Jul 2022 10:08:16 +0000
Date:   Wed, 13 Jul 2022 03:08:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        mcgrof@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        keescook@chromium.org, hch@infradead.org, dave@stgolabs.net,
        daniel@iogearbox.net, kernel-team@fb.com, x86@kernel.org,
        dave.hansen@linux.intel.com, rick.p.edgecombe@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH bpf-next 1/3] mm/vmalloc: introduce vmalloc_exec which
 allocates RO+X memory
Message-ID: <Ys6ZkDUhRZcmvPYy@infradead.org>
References: <20220713071846.3286727-1-song@kernel.org>
 <20220713071846.3286727-2-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713071846.3286727-2-song@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

NAK.  This is not something that should be an exported public API
ever.
