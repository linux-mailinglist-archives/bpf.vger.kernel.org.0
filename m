Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBF41A61DA
	for <lists+bpf@lfdr.de>; Mon, 13 Apr 2020 05:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgDMD72 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Apr 2020 23:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgDMD72 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Apr 2020 23:59:28 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [23.128.96.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3A5C0A3BE0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2020 20:59:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8152B127AE1F3;
        Sun, 12 Apr 2020 20:59:28 -0700 (PDT)
Date:   Sun, 12 Apr 2020 20:59:27 -0700 (PDT)
Message-Id: <20200412.205927.1627306630338317701.davem@davemloft.net>
To:     me@jibi.io
Cc:     bpf@vger.kernel.org, jasowang@redhat.com
Subject: Re: [PATCH 1/1] net: tun: record RX queue in skb before
 do_xdp_generic()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200410162059.15438-2-me@jibi.io>
References: <20200410162059.15438-1-me@jibi.io>
        <20200410162059.15438-2-me@jibi.io>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 12 Apr 2020 20:59:28 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Gilberto Bertin <me@jibi.io>
Date: Fri, 10 Apr 2020 18:20:59 +0200

> This allows netif_receive_generic_xdp() to correctly determine the RX
> queue from which the skb is coming, so that the context passed to the
> XDP program will contain the correct RX queue index.
> 
> Signed-off-by: Gilberto Bertin <me@jibi.io>

Applied and queued up for -stable, thanks.
