Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC3956AEC8
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 00:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiGGW7q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 18:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiGGW7q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 18:59:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B356F61D58;
        Thu,  7 Jul 2022 15:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2LGPQBbmLZAhGLpuEXGKEbyXOETkHsQcpN3+BdruGK4=; b=EeUBbAP3OPV24ab05MtW6remFT
        4DOHjOKbpU2PHwDd3fsI5aTosvkKFOVbO/ghzOlWrFV/RDHOwYs3WMZVOu/AX/6uMOP95NOp19k/W
        wkFRHRAyk+yFSIcbC+BgxUCx2wx8svMbZhyHfb+RiPTkccYDpIed8E0FmLeiYGukRDv4cwGXdp8v8
        /S3KWwvQa19EAQBrOltUR6NpQCGnTTak3reuNlnvnHywfJdkrDdSZSgwgdipoTskg/S1+m9elGmAz
        a338gVt6OXZVDSvYV3eVEvxUokq/0y6nRAFojjOLyZKoc7YaXD+sHeQES6geSle3HbsWWwAQWpUkF
        DEyH50rA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9aTG-000dFe-6L; Thu, 07 Jul 2022 22:59:42 +0000
Date:   Thu, 7 Jul 2022 15:59:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, daniel@iogearbox.net, kernel-team@fb.com,
        x86@kernel.org, dave.hansen@linux.intel.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Message-ID: <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
References: <20220707223546.4124919-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707223546.4124919-1-song@kernel.org>
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

On Thu, Jul 07, 2022 at 03:35:41PM -0700, Song Liu wrote:
> This set is the second half of v4 [1].
> 
> Changes v5 => v6:
> 1. Rebase and extend CC list.

Why post a new iteration so soon without completing the discussion we
had? It seems like we were at least going somewhere. If it's just
to include mm as I requested, sure, that's fine, but this does not
provide context as to what we last were talking about.

  Luis
