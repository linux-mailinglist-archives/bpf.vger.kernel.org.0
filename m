Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA51325B73E
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 01:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBXWY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 19:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgIBXWY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 19:22:24 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B92C061244
        for <bpf@vger.kernel.org>; Wed,  2 Sep 2020 16:22:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0C1C415751F50;
        Wed,  2 Sep 2020 16:05:37 -0700 (PDT)
Date:   Wed, 02 Sep 2020 16:22:22 -0700 (PDT)
Message-Id: <20200902.162222.1706338150182336333.davem@davemloft.net>
To:     jose.marchesi@oracle.com
Cc:     daniel@iogearbox.net, alexei.starovoitov@gmail.com,
        bpf@vger.kernel.org
Subject: Re: EF_BPF_GNU_XBPF
From:   David Miller <davem@davemloft.net>
In-Reply-To: <87k0xb25kw.fsf@oracle.com>
References: <87o8mn281a.fsf@oracle.com>
        <d0a6eb38-76a4-b335-878b-647fe68f937a@iogearbox.net>
        <87k0xb25kw.fsf@oracle.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [2620:137:e000::1:9]); Wed, 02 Sep 2020 16:05:37 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Date: Thu, 03 Sep 2020 00:10:07 +0200

> 1) Due to BPF being so restrictive, many hundreds of GCC tests won't
>    even build, because they use functions having more than 5 arguments,
>    or functions with too big stack frames, or indirect calls, etc.  We
>    want to be able to test our backend properly, so we added the -mxbpf
>    option in order to relax some of these restrictions.
> 
> 2) We are working on a BPF simulator that works with GDB.  For that to
>    work, we needed to add a "breakpoint" instruction that GDB can patch
>    in the program.  Having a simulator also allows us to run more GCC
>    tests.
> 
> 3) With some extensions, it becomes possible to support DWARF call frame
>    information, and therefore to debug BPF programs in GDB with
>    unwinding support.  You can build with -mxbpf, debug, then build
>    again without -mxbpf.

All sounds like features to propose for BPF itself, rather than throw
into some weird extension.

Why not come to the bpf community and discuss the need for these
features?
