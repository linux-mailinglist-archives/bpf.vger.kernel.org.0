Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6017416F6
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjF1RIL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 13:08:11 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:47827 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230055AbjF1RIK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 28 Jun 2023 13:08:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8BF403200893;
        Wed, 28 Jun 2023 13:08:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 28 Jun 2023 13:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687972089; x=1688058489; bh=Qp
        SrMdysUNieu5qT+irX1lyFyfaREyITlqTu815mPP0=; b=VSaMqdOeF+VC2Oy4HB
        /BNXxvWzG2ZOgRegFaJDEB1W+84F8cnYwCxDVVxvoGDfXtZLkQ1kclhu5y/SPjha
        ZlqFpbd5I1RmvUArC5T1OQ2Wo8kHlNJ3L4Bsl0Soh4DgG7rQY1wyB04VMn2uig60
        dXaKNOvN73GThnMuthTb8dlY+j32vxkc6tuE7/guqnPrXrUJ/2A4jbokIL6sX/c4
        HtMUQdYYCpY7IvcAQQWoxEYwt+ayTSJVkm8floVAIHyRJhbBvVJDYVnJLyHP8zD2
        5J7UEY3aOmr7ieOGoZZ3GNF72p6BgoFRe+rlhrl/lc6Otxy70dZZJVTejVwj5Skp
        a0qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687972089; x=1688058489; bh=QpSrMdysUNieu
        5qT+irX1lyFyfaREyITlqTu815mPP0=; b=eQ7DmOL+AikN3LMpowcUDDWHo0xxK
        KYdbYzar2tgKmIB4AOZEVmg9t6iTkxWvOHhGwRpcofLEMvE8wdQj13zK7TShDD+1
        ytOkDDNvA3Z6WTH5F3qGpbaXcXxJu+jzD6sxQiKu9DX5jf6Rs9643Ampo1Nt7cNs
        8E2FGWGsnY7S6dZkvymLnaTyK8P5+fFV7EVxjkUetShlGFGp5zLIpf5qJDsoZXZF
        hXZ7EakRnlUhoF8AKvcrKVCjI8fb9h9CdicYkVFzhtXmOlduGDv3eoFGx/j94Pz0
        AIap1Hbd63riXpcv5kMk1xyE0NzgyU/bKKgtNbsVVSwci7NBXnxBxlBhg==
X-ME-Sender: <xms:-GicZAVl_ZLQup0UBuNWPl6xD219sFMtSxnBnHkYhiwpMlDPPdXaGQ>
    <xme:-GicZEmdOP0mPL6XNzuSR0Pr301pjABGdgDBPva9JlQLuf2FwHzPARvEZEl5s-pZT
    tENVU9Yc39hSwD7_w>
X-ME-Received: <xmr:-GicZEbmFvOaUGN1jiMBGQiUEHWHWC_is17X9ffJYfRgRImD_zTPRaE1mqTk9UX7yR4b_KS0xOL-YPlkM8Ux3IsCHINz_NGzkv18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtddvgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:-GicZPVbDlUsIJ300ajvCSgla414PCv3ewfkIbjb1P5GDwBLLvti_A>
    <xmx:-GicZKkJ25Vw76oeOF0pZg5SG-wrppSUnmxjzZig3f9nTBEemHHgbA>
    <xmx:-GicZEePo49O9D7RdLoJmHBNZFKuEd4pZKL8pDzw6EZy0AW84Q4BzA>
    <xmx:-WicZPxCdHVpv16KBTwvA5cuBpYQws1IYDkgOg7ItDsd6Qhx0TiAhQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jun 2023 13:08:08 -0400 (EDT)
Date:   Wed, 28 Jun 2023 11:08:07 -0600
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     Florian Westphal <fw@strlen.de>
Cc:     bpf@vger.kernel.org, ast@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/2] libbpf: add netfilter link attach helper
Message-ID: <c3mwjvbobfmmzeuiqeifxdjguk52mitltp3xqj46sozkrgqaeg@xvc6ifaaacpo>
References: <20230628152738.22765-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628152738.22765-1-fw@strlen.de>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 28, 2023 at 05:27:36PM +0200, Florian Westphal wrote:
> v4: address comment from Daniel Xu:
>   - use human-readable test names in 2/2
> 
> v3: address comments from Andrii:
>   - prune verbose error message in 1/2
>   - use bpf_link_create internally in 1/2
>   - use subtests in patch 2/2
> 
> When initial netfilter bpf program type support got added one
> suggestion was to extend libbpf with a helper to ease attachment
> of nf programs to the hook locations.
> 
> Add such a helper and a demo test case that attaches a dummy
> program to various combinations.
> 
> I tested that the selftest fails when changing the expected
> outcome (i.e., set 'success' when it should fail and v.v.).
> 
> Florian Westphal (2):
>   tools: libbpf: add netfilter link attach helper
>   selftests/bpf: Add bpf_program__attach_netfilter helper test
> 
>  tools/lib/bpf/bpf.c                           |  6 ++
>  tools/lib/bpf/bpf.h                           |  6 ++
>  tools/lib/bpf/libbpf.c                        | 42 +++++++++
>  tools/lib/bpf/libbpf.h                        | 15 ++++
>  tools/lib/bpf/libbpf.map                      |  1 +
>  .../bpf/prog_tests/netfilter_link_attach.c    | 86 +++++++++++++++++++
>  .../bpf/progs/test_netfilter_link_attach.c    | 14 +++
>  7 files changed, 170 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/netfilter_link_attach.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_netfilter_link_attach.c
> 
> -- 
> 2.39.3
> 
> 
For the series:

Acked-by: Daniel Xu <dxu@dxuuu.xyz>
