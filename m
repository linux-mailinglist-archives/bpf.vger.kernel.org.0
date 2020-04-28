Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102541BCEF9
	for <lists+bpf@lfdr.de>; Tue, 28 Apr 2020 23:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgD1Vkz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Apr 2020 17:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbgD1Vkz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Apr 2020 17:40:55 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC85BC03C1AC;
        Tue, 28 Apr 2020 14:40:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0477E1210A3F2;
        Tue, 28 Apr 2020 14:40:53 -0700 (PDT)
Date:   Tue, 28 Apr 2020 14:40:53 -0700 (PDT)
Message-Id: <20200428.144053.1011868905140234992.davem@davemloft.net>
To:     mchehab+huawei@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, netdev@vger.kernel.org, linux-hams@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        linux-decnet-user@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, bpf@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, lvs-devel@vger.kernel.org
Subject: Re: [PATCH 00/38] net: manually convert files to ReST format -
 part 1
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1588024424.git.mchehab+huawei@kernel.org>
References: <cover.1588024424.git.mchehab+huawei@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 28 Apr 2020 14:40:54 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Tue, 28 Apr 2020 00:01:15 +0200

> There are very few documents upstream that aren't converted upstream.
> 
> This series convert part of the networking text files into ReST.
> It is part of a bigger set of patches, which were split on parts,
> in order to make reviewing task easier.
> 
> The full series (including those ones) are at:
> 
> 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=net-docs
> 
> And the documents, converted to HTML via the building system
> are at:
> 
> 	https://www.infradead.org/~mchehab/kernel_docs/networking/

Series applied to net-next, thank you.
