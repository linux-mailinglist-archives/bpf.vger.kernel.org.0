Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0EF2A5EF
	for <lists+bpf@lfdr.de>; Sat, 25 May 2019 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfEYSBD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 May 2019 14:01:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57496 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEYSBD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 May 2019 14:01:03 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 683D614F675CA;
        Sat, 25 May 2019 11:01:02 -0700 (PDT)
Date:   Sat, 25 May 2019 11:01:02 -0700 (PDT)
Message-Id: <20190525.110102.183178868031173654.davem@davemloft.net>
To:     blackgod016574@gmail.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] ip_sockglue: Fix missing-check bug in ip_ra_control()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190524032337.GA6513@zhanggen-UX430UQ>
References: <20190524032337.GA6513@zhanggen-UX430UQ>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 25 May 2019 11:01:02 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Gen Zhang <blackgod016574@gmail.com>
Date: Fri, 24 May 2019 11:24:26 +0800

> In function ip_ra_control(), the pointer new_ra is allocated a memory 
> space via kmalloc(). And it is used in the following codes. However, 
> when  there is a memory allocation error, kmalloc() fails. Thus null 
> pointer dereference may happen. And it will cause the kernel to crash. 
> Therefore, we should check the return value and handle the error.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

Applied.
