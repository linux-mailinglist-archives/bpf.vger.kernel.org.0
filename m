Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61587F5A54
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 22:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfKHVnj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Nov 2019 16:43:39 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38848 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfKHVnj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 16:43:39 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F0E7A153873A8;
        Fri,  8 Nov 2019 13:43:38 -0800 (PST)
Date:   Fri, 08 Nov 2019 13:43:38 -0800 (PST)
Message-Id: <20191108.134338.1116276927138635214.davem@davemloft.net>
To:     toke@redhat.com
Cc:     daniel@iogearbox.net, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, brouer@redhat.com,
        andrii.nakryiko@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 5/6] libbpf: Add bpf_get_link_xdp_info()
 function to get more XDP information
From:   David Miller <davem@davemloft.net>
In-Reply-To: <157324879070.910124.16900285171727920636.stgit@toke.dk>
References: <157324878503.910124.12936814523952521484.stgit@toke.dk>
        <157324879070.910124.16900285171727920636.stgit@toke.dk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Nov 2019 13:43:39 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Fri, 08 Nov 2019 22:33:10 +0100

> From: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> Currently, libbpf only provides a function to get a single ID for the XDP
> program attached to the interface. However, it can be useful to get the
> full set of program IDs attached, along with the attachment mode, in one
> go. Add a new getter function to support this, using an extendible
> structure to carry the information. Express the old bpf_get_link_id()
> function in terms of the new function.
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
