Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D603A62DF4
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2019 04:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGICPW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jul 2019 22:15:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33658 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGICPW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 22:15:22 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E0B3812EB0324;
        Mon,  8 Jul 2019 19:15:21 -0700 (PDT)
Date:   Mon, 08 Jul 2019 19:15:18 -0700 (PDT)
Message-Id: <20190708.191518.1110731080223523287.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2019-07-09
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190709001351.8848-1-daniel@iogearbox.net>
References: <20190709001351.8848-1-daniel@iogearbox.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Jul 2019 19:15:22 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Tue,  9 Jul 2019 02:13:51 +0200

> The following pull-request contains BPF updates for your *net-next* tree.
> 
> The main changes are:
 ...
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Pulled, thanks Daniel.
