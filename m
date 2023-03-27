Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D890F6CAE90
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 21:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjC0T2X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 15:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjC0T2W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 15:28:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08642D48;
        Mon, 27 Mar 2023 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xcVWACh9AVKFBL+pW+FE9Xpu1vqOmtVYgQ8/xR2RZCI=; b=zrsUJ8Hbn4+JP3KFeqaeFDDib1
        9I+in64FRU8MmlqsojhKYp4fSx9/Eq37GabpFr3Y0mhunAH34v6wwEO1u2xZsFRMzgibGqGy0wN+K
        QcjjLcTH/k5PL/cCSVpH9ZoY2jDPIaskWMU587NLbbGuXdFlLJgaxnxwYNoUgAff8PhJpl4ZFgwQr
        004lzTzr4iHhzG7L3+ZfAODnEFVElU7gXfF+5wfESrU63CXJhgnK+6S0J1EndtBPQ11j1VFuXlZEu
        hQ1vrtdEyNp1DyRLBuKPMc2bqGE649drC8LCfb22mQXZc9nvwRiEZoBWBzEUeAeqh0zRd8lKPp08K
        mt2t7EAQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgsVv-00CE4Z-0k;
        Mon, 27 Mar 2023 19:28:19 +0000
Date:   Mon, 27 Mar 2023 12:28:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] kallsyms: move module-related functions under
 correct configs
Message-ID: <ZCHuU4Wui7Dwmdm2@bombadil.infradead.org>
References: <20230327161251.1129511-1-vmalik@redhat.com>
 <ZCHWtptOwPPtUe+u@bombadil.infradead.org>
 <c076e249-705a-e1bb-c657-f80cd4f2145b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c076e249-705a-e1bb-c657-f80cd4f2145b@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 27, 2023 at 08:20:56PM +0200, Viktor Malik wrote:
> On 3/27/23 19:47, Luis Chamberlain wrote:
> > On Mon, Mar 27, 2023 at 06:12:51PM +0200, Viktor Malik wrote:
> > > Functions for searching module kallsyms should have non-empty
> > > definitions only if CONFIG_MODULES=y and CONFIG_KALLSYMS=y. Until now,
> > > only CONFIG_MODULES check was used for many of these, which may have
> > > caused complilation errors on some configs.
> > > 
> > > This patch moves all relevant functions under the correct configs.
> > > 
> > > Signed-off-by: Viktor Malik <vmalik@redhat.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Link: https://lore.kernel.org/oe-kbuild-all/202303181535.RFDCnz3E-lkp@intel.com/
> > 
> > Thanks Viktor!  Does this fix something from an existing commit? If so
> > which one?  The commit log should mention it.
> 
> Ah, right, I forgot about that. The commit log is missing:
> 
> Fixes: bd5314f8dd2d ("kallsyms, bpf: Move find_kallsyms_symbol_value out of internal header")
> 
> I can post v2 but I'm also fine with maintainers applying the tag.

That patch went through the bpf tree so its fix can go throug that tree.
So up to Daniel if he wants a new patch.

  Luis
