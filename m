Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0211571138
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 06:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGLEY2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 00:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiGLEYU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 00:24:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B806220E3;
        Mon, 11 Jul 2022 21:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X1H4iTaGBABhmn8tOuCBSLbmPwsiUysDxHfqz4KTFB0=; b=0M+SICsZdr6b34t1NTp14Vgb/L
        fpyen0doQO+i4tp+rZWBTPlHpvI5stRkmD0+5/Axt2gkOHZ5pLDEI7tep9nlJtVnTq6Lx6sONVc+L
        7cbzob8jbqoBZhLKwZkZ7UDv9dPplq34qHrqWvLcglh1f7r5LOPBLmR8BCHPTWb6U4fAskUphOGeN
        JCACIktUx2K23iBO8kBGut0FhsaMlWFyAb8392pDCMkYzlKbR1byslNj+WYrUrdMDxO9NgWX1ahn+
        +FyqjpLqDRoB8eECI5Ly5NZx20RzYhAQIiko0AiCHJt51k+LcmRj2Kn55gzC5oyQDlq+3qNX8wYnd
        nKRGVp2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oB7RM-007J5x-1f; Tue, 12 Jul 2022 04:24:04 +0000
Date:   Mon, 11 Jul 2022 21:24:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Message-ID: <Ysz3ZEzsgZOKu8cg@bombadil.infradead.org>
References: <20220707223546.4124919-1-song@kernel.org>
 <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
 <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
 <YseAEsjE49AZDp8c@bombadil.infradead.org>
 <C96F5607-6FFE-4B45-9A9D-B89E3F67A79A@fb.com>
 <YshUEEQ0lk1ON7H6@bombadil.infradead.org>
 <863A2D5B-976D-4724-AEB1-B2A494AD2BDB@fb.com>
 <YsiupnNJ8WANZiIc@bombadil.infradead.org>
 <6214B9C9-557B-4DC0-BFDE-77EAC425E577@fb.com>
 <Ysz2LX3q2OsaO4gM@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysz2LX3q2OsaO4gM@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 11, 2022 at 09:18:53PM -0700, Luis Chamberlain wrote:
> A vmalloc_ro_exec() by definition would imply a text_poke().
> 
> Can kprobes, ftrace and modules use it too? It would be nice
> so to not have to deal with the loose semantics on the user to
> have to use set_vm_flush_reset_perms() on ro+x later, but
> I think this can be addressed separately on a case by case basis.

And who knows, if they can, and can also share a huge page allocator
then they may also share similar performance improvements.

  Luis
