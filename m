Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80AF5256E8
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 19:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfEURnb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 13:43:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42858 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfEURnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 13:43:31 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B16AF146BB096;
        Tue, 21 May 2019 10:43:30 -0700 (PDT)
Date:   Tue, 21 May 2019 10:43:30 -0700 (PDT)
Message-Id: <20190521.104330.1268444854419644640.davem@davemloft.net>
To:     jiong.wang@netronome.com
Cc:     jose.marchesi@oracle.com, binutils@sourceware.org,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org
Subject: Re: [PATCH 0/9] eBPF support for GNU binutils
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
References: <20190520164526.13491-1-jose.marchesi_()_oracle_!_com>
        <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 May 2019 10:43:30 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jiong Wang <jiong.wang@netronome.com>
Date: Tue, 21 May 2019 16:41:56 +0100

> CCing BPF kernel community who is defining the ISA and various runtime stuff.
> 
> Also two inline comments below about the assembler

Also, I already wrote such a binutils patch a year or two ago:

https://lwn.net/Articles/721473/
