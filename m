Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFDE036880
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 01:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfFEX6S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 19:58:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42570 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFEX6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jun 2019 19:58:18 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 19DF810081D52;
        Wed,  5 Jun 2019 16:58:17 -0700 (PDT)
Date:   Wed, 05 Jun 2019 16:58:16 -0700 (PDT)
Message-Id: <20190605.165816.1306141938926112064.davem@davemloft.net>
To:     info@metux.net
Cc:     linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: drop unneeded likely() call around IS_ERR()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1559769094-20889-1-git-send-email-info@metux.net>
References: <1559769094-20889-1-git-send-email-info@metux.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Jun 2019 16:58:17 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Wed,  5 Jun 2019 23:11:34 +0200

> From: Enrico Weigelt <info@metux.net>
> 
> IS_ERR() already calls unlikely(), so this extra unlikely() call
> around IS_ERR() is not needed.
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>

Applied.
