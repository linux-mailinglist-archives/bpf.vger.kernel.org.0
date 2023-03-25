Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70946C8EF1
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 16:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjCYPDp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Mar 2023 11:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCYPDp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Mar 2023 11:03:45 -0400
X-Greylist: delayed 488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Mar 2023 08:03:43 PDT
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B00E1024E
        for <bpf@vger.kernel.org>; Sat, 25 Mar 2023 08:03:43 -0700 (PDT)
Date:   Sat, 25 Mar 2023 15:55:27 +0100
From:   Florian Lehner <dev@der-flo.net>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     torvalds@linuxfoundation.org, x86@kernel.org, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, peterz@infradead.org,
        keescook@chromium.org, tglx@linutronix.de, hsinweih@uci.edu,
        rostedt@goodmis.org, vegard.nossum@oracle.com,
        gregkh@linuxfoundation.org, alan.maguire@oracle.com,
        dylany@meta.com, riel@surriel.com, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf 1/2] mm: Fix copy_from_user_nofault().
Message-ID: <ZB8LX/BKPgvzfvcm@der-flo.net>
References: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With this patch applied on top of bpf/bpf-next (55fbae05) the system no longer runs into a total freeze as reported in https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1033398.

Tested-by: Florian Lehner <dev@der-flo.net>

