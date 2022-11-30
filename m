Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B263D235
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 10:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiK3Jkw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 04:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiK3Jkc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 04:40:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15B1663D0
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 01:40:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69C6F61AB3
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 09:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F6FC433D6;
        Wed, 30 Nov 2022 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669801204;
        bh=j4pbxURSkB/qMAGKhX3c71/EfzCnkVfnezE1/DTusgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWusOV3BBSkYy7rrN42u80HXQwwdVYZOFUGbiEihPaSrqL2ILGP8e1vaCHK2E2lTZ
         S7WkLtjnjui8RQQW3//nhppG3vhYZOhtZS4ibsuCM68bewY08jB8YrelFxVN46yITz
         6vBdiV5AtEMGKWlOCjeKkk2fL4F+1N432YCxdLHjLWEuH/rTiMLDUYma1AAL15yOTh
         oGi83OUsyDR/N3bh/pm1v8RdKaGX4cLTw0eEfBYq9pG3oMXVUHdCvNSSaxVU35H5HJ
         1WjylIAn3qadSUyNbO9ut3S0ZagD+OrfQ4XjAgTkRVil1dYQnhLJ660Nfs1gQ2HmPn
         Su0xPK1NkLdJA==
Date:   Wed, 30 Nov 2022 11:39:47 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y4ck40Wv3n5Q5ByK@kernel.org>
References: <Y2o9Iz30A3Nruqs4@kernel.org>
 <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
 <Y2uMWvmiPlaNXlZz@kernel.org>
 <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
 <Y3DITs3J8koEw3Hz@kernel.org>
 <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
 <Y3X1uHNTLQJxmJnm@kernel.org>
 <CAPhsuW51j8P+DNXvFh4uf5Mem7=egHyYMVK7-Zq2qeFoArYREQ@mail.gmail.com>
 <Y3oEXP3UqHd1L6Z9@kernel.org>
 <CAPhsuW4ZBShuBf39TLmich0ts07zWGFuHvfAB0Jbg_bG-fjjWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4ZBShuBf39TLmich0ts07zWGFuHvfAB0Jbg_bG-fjjWw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 07:52:12AM -0700, Song Liu wrote:
> On Sun, Nov 20, 2022 at 3:41 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > The most obvious one to implement Peter's suggestion with VM_TOPDOWN_VMAP
> > > > so that execmem_alloc() can be actually used by modules.
> > >
> > > Current implementation is an alternative to VM_TOPDOWN_VMAP. I am
> > > very sure it works for modules just like VM_TOPDOWN_VMAP solution.
> >
> > It might, but it still does not. And until they do I consider these
> > patches as an optimization for BFP rather than unification of code
> > allocations.
> 
> We haven't got module to use execmem_alloc yet, that's true. But
> this has nothing to do with VM_TOPDOWN_VMAP at all.

The point is that Peter suggested a way to make module_alloc() use 2M
pages, so that all code allocations could benefit from it. Your
execmem_alloc() isn't anywhere near this.
 
> Thanks,
> Song

-- 
Sincerely yours,
Mike.
