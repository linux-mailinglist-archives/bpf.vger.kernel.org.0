Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C1D56AFAF
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 03:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbiGHAxo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 20:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGHAxn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 20:53:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876F96B249;
        Thu,  7 Jul 2022 17:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=35SNbNDdnAJ/BYZDN8T44SRH2L1OpLCF0GMBsdrOlCQ=; b=OwXxltOVK4cODwJ2wABswCKIcm
        XtbpSMkSfU2ETLzDxewlhANYepBKW3DeKDjnU5i3hIDouV/T/GbuHhZjFeXKnSLivBaap9AOWCUgO
        2CJUbBKMA+QHsHyll2xPg6KMg4akk550pgw+vRdWE5ByGbiKOXuhyya64IxWJM21jRtMvd0ciUEYz
        XFNjx8PYfM0Gpf7DGJPY/Uu584LqHJTfV5JYn8hk2Dr7euMJBrR2ElhfSWj7S7XHH2p5G38KtX2EW
        tEqkF+gr0GSUWZZZzLKycT95RV2uNY1hDxL7lztAv5Mdtpt/TcfQL6HCGygb3J1bsIZTYUt8uww4T
        8mJIbDDA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9cFW-000tAn-3X; Fri, 08 Jul 2022 00:53:38 +0000
Date:   Thu, 7 Jul 2022 17:53:38 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Message-ID: <YseAEsjE49AZDp8c@bombadil.infradead.org>
References: <20220707223546.4124919-1-song@kernel.org>
 <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
 <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
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

On Thu, Jul 07, 2022 at 11:52:58PM +0000, Song Liu wrote:
> > On Jul 7, 2022, at 3:59 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> > 
> > On Thu, Jul 07, 2022 at 03:35:41PM -0700, Song Liu wrote:
> >> This set is the second half of v4 [1].
> >> 
> >> Changes v5 => v6:
> >> 1. Rebase and extend CC list.
> > 
> > Why post a new iteration so soon without completing the discussion we
> > had? It seems like we were at least going somewhere. If it's just
> > to include mm as I requested, sure, that's fine, but this does not
> > provide context as to what we last were talking about.
> 
> Sorry for sending v6 too soon. The primary reason was to extend the CC
> list and add it back to patchwork (v5 somehow got archived). 
> 
> Also, I think vmalloc_exec_ work would be a separate project, while this 
> set is the followup work of bpf_prog_pack. Does this make sense? 
> 
> Btw, vmalloc_exec_ work could be a good topic for LPC. It will be much
> more efficient to discuss this in person. 

What we need is input from mm / arch folks. What is not done here is
what that stuff we're talking about is and so mm folks can't guess. My
preference is to address that.

I don't think in person discussion is needed if the only folks
discussing this topic so far is just you and me.

  Luis
