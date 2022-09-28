Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD995ED297
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 03:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiI1BUv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 21:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiI1BUs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 21:20:48 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAE1DDD9D;
        Tue, 27 Sep 2022 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1664328040;
        bh=wWKds1Wm5hrS7eILqqlAVIO9n3JyGKz1gUBbmMwiXPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=clsKaC0H8Auw665q3Q/3nstTewuQ8wyfTmpLK+PRRgVCYneTvBMRNDx/+LYRs0Y6J
         KCy+lBI0kazsy+h5m/ITYLS5QZm/ECef94b1Wq+bsGu5mV91z7qCMHYhLw6oJHLwul
         WMnZ5VLWcs5pajyAaVUOUgNVWDsKqwv87o95TltY=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id 5239D4B0; Wed, 28 Sep 2022 09:20:35 +0800
X-QQ-mid: xmsmtpt1664328035tx3kfulac
Message-ID: <tencent_3E405BA837ABEC725605F1B5629402D1CF05@qq.com>
X-QQ-XMAILINFO: NC/J3CrDtaBbpTzcYCt9hDvIg8K4+5edsxjK9Y+G2yNKufvIaQKyiqv5DTYb/v
         wmI/uCEOcHh8jPwxa08MxSp2nikcJe2UXWKoeWb2xrXQxDfSiy4c7hlVxy33usrbOQFEY2nC7MPU
         Y/aenZQMio8i8qbE8OPg+ZL9ri99MVfATHn3kfFmXq5yqTcs6hgJr+882XBNCfvhIKi+C5G+GqWu
         csmK0nNBzz5V+B8WmvzRvwLAYa9U2+isdcvBd9tSyK/IOGrZsFE77DWhndONjwQMSq8LchlIKA/s
         PRegUiqBuQR1PSzeJ3VmzztqwWfB7vqKC1hLyRmNNxxR1BnnKFmdbtob20WrflEJiA3ShrN2yRYi
         bRcxwMA8yhzOT6Duy/8D6gI1q/2EbHOZ+Hsl+qa7JXHDCbwFogjkXfYIMgVASsp+d0jNPnfplqKT
         j5VmgRYvLw+0t2k05r7xkyUQNxMN2CMAG/NPq9KQu9gkygEHq4JidvHd3zgBG1nYMx1S007cXogE
         kf0Q7o5m0BuLID2kjhP2/X6wPGYuMPtevlX1LX2UmwPchE+vAa7jF3ri6ywU32D4TCaj7vxqSHbS
         K4pDs9OOkYg3kD5ozhvcWuhZuQE1C9D8X7lR0/kYRThGoQyfwpUVhGOKHmxuPDU0PeWiJoirvhyq
         pcE/voKbZAupsou9ZO6mdB9bW5nKPCG2B5hNrDaRMQWMKepS4yO4MiGaAfX2J7bAOuFfVpJC+QvV
         UNa9v9GwzzMuMMhv6oaqlJKVJ/tMLnET7f52tpLIG7Pwk9ptO2HlsYv1pmajVDPk5YvqIlDKkeVq
         n0wgHRHj1u2AxIXbfKtckjoZdp3QWqCzHF6ZL/Zx66FivdHGcdQwc8N2ptC9RppxALAsw11srqP6
         i2XXf5iZ5uZvvnX3aPiwxHv/qvtZNGSvKX0rrdjxp5mba1+AG/dt2VkTm+Cg+iaQ0euRMVwXSU7n
         B9T6hRd89svr3scKTXhREQmqEqSBV0
From:   Rong Tao <rtoax@foxmail.com>
To:     martin.lau@linux.dev
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        rongtao@cestc.cn, rtoax@foxmail.com, sdf@google.com,
        song@kernel.org, yhs@fb.com
Subject: Re: [PATCH bpf-next] samples/bpf: offwaketime: pretty print
Date:   Wed, 28 Sep 2022 09:20:32 +0800
X-OQ-MSGID: <20220928012032.4564-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1d2c81e7-b9d8-c153-608b-6464a10949d8@linux.dev>
References: <1d2c81e7-b9d8-c153-608b-6464a10949d8@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Thank you very much for your reply, next time I will know all before
submitting.

-- 
