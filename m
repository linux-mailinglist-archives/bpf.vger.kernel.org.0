Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF105467255
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 07:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378741AbhLCHDH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 02:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345605AbhLCHDH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 02:03:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77174C06174A;
        Thu,  2 Dec 2021 22:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L9TEsOSb6kRI6cv6AHNLCgEMmFVJ2TwOFsBuT0mf2uI=; b=WJ8/zUe+SXuI4BfCR+BUL7Vkst
        WOwpe629JqT5Ndyc5srczyQ4GFkF24TYiT9Ch+yu8WMHtIQ/kJXhe/tuz17Cebczq4jV8M3AysQi5
        IgnYWA1kanCUQrzI2U5A3adQJk08pfuWgEJBtPO/lspAYfPYeqYQt8PgEhjJ0Qd/1dSX8qSaPZBFp
        VDcLl0khw9Eoc+u80YauIiJ5fAb/cmt5z3dorT2qy/OKtIwbKJDwXRoiU0cYCt2N1MD16BOV5V7Ow
        A1b7zYc8+EHrUAHlxpQL3ln0AcvSdc3xmv6xquHn5CofPFcYFWarkubJ7fDXuxOSQm8ryuWQcS3Se
        gQvjr07w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mt2Xj-00EeJY-SA; Fri, 03 Dec 2021 06:59:39 +0000
Date:   Thu, 2 Dec 2021 22:59:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Peter Chen <peter.chen@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, yuq825@gmail.com, robdclark@gmail.com,
        sean@poorly.run, christian.koenig@amd.com, ray.huang@amd.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, jingoohan1@gmail.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski@canonical.com, mani@kernel.org,
        pawell@cadence.com, rogerq@kernel.org, a-govindraju@ti.com,
        gregkh@linuxfoundation.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        akpm@linux-foundation.org, thomas.hellstrom@linux.intel.com,
        matthew.auld@intel.com, colin.king@intel.com, geert@linux-m68k.org,
        linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH bpf v2] treewide: add missing includes masked by cgroup
 -> bpf dependency
Message-ID: <YanAW6KnyNQ1V34r@infradead.org>
References: <20211202203400.1208663-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202203400.1208663-1-kuba@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks, always good to see someone else helping to unwind our include
dependency mess..

Reviewed-by: Christoph Hellwig <hch@lst.de>
