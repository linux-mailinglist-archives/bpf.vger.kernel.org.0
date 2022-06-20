Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD9A5523E5
	for <lists+bpf@lfdr.de>; Mon, 20 Jun 2022 20:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245116AbiFTSbs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243854AbiFTSbs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 14:31:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304D81CFE9;
        Mon, 20 Jun 2022 11:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ifeyTcl/AzgtaNQGujckbdAaI1u6Oc+W0eR30MKVMt0=; b=NeG2GYlsioxK7lRBX58s9G3eZ5
        yRo26XRbGPTm2TRZ2ypskU8cAk6ATuCX9XeqIcL6q99nZISK4o4XKlgw3duF9qGzI4q//E4v9IyHM
        uI9GHFz1MTLikBAaaGAdcq+ppIHdEA40bVnCvB/PyU5mNHz7qzL67FSm+mkBhjnc7Ld677b3x+4iS
        QwDaEjsesc1GyR6RsQJ2TmelieatvC6ScmDqfRY3wkiGd2vDbnLpByP2enuIgEOUVaWUZxeP6soEN
        BKy2DScdJ4jusJezIR9VsYU15GAZlqJcX6Ym4UiN+Tiu3r3CK7euoC6F7tGBiQlaw/3yWiNh+mqi2
        vrGmko9w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3MBX-001rrj-Fc; Mon, 20 Jun 2022 18:31:39 +0000
Date:   Mon, 20 Jun 2022 11:31:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Lu <aaron.lu@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-mm@kvack.org, ast@kernel.org,
        daniel@iogearbox.net, peterz@infradead.org,
        torvalds@linux-foundation.org, rick.p.edgecombe@intel.com,
        kernel-team@fb.com
Subject: Re: [PATCH v4 bpf-next 0/8] bpf_prog_pack followup
Message-ID: <YrC9CyOPamPneUOT@bombadil.infradead.org>
References: <20220520235758.1858153-1-song@kernel.org>
 <YrBV8darrlmUnrHR@ziqianlu-Dell-Optiplex7000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrBV8darrlmUnrHR@ziqianlu-Dell-Optiplex7000>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 20, 2022 at 07:11:45PM +0800, Aaron Lu wrote:
> Hi Song,
> 
> On Fri, May 20, 2022 at 04:57:50PM -0700, Song Liu wrote:
> 
> ... ...
> 
> > The primary goal of bpf_prog_pack is to reduce iTLB miss rate and reduce
> > direct memory mapping fragmentation. This leads to non-trivial performance
> > improvements.
> >
> > For our web service production benchmark, bpf_prog_pack on 4kB pages
> > gives 0.5% to 0.7% more throughput than not using bpf_prog_pack.
> > bpf_prog_pack on 2MB pages 0.6% to 0.9% more throughput than not using
> > bpf_prog_pack. Note that 0.5% is a huge improvement for our fleet. I
> > believe this is also significant for other companies with many thousand
> > servers.
> >
> 
> I'm evaluationg performance impact due to direct memory mapping
> fragmentation 

BTW how exactly are you doing this?

  Luis

> and seeing the above, I wonder: is the performance improve
> mostly due to prog pack and hugepage instead of less direct mapping
> fragmentation?
> 
> I can understand that when progs are packed together, iTLB miss rate will
> be reduced and thus, performance can be improved. But I don't see
> immediately how direct mapping fragmentation can impact performance since
> the bpf code are running from the module alias addresses, not the direct
> mapping addresses IIUC?
> 
> I appreciate it if you can shed some light on performance impact direct
> mapping fragmentation can cause, thanks.
