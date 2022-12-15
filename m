Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467AB64D5FD
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 05:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLOE61 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 23:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLOE60 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 23:58:26 -0500
Received: from mailgw1.comp.nus.edu.sg (84-20.comp.nus.edu.sg [137.132.84.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64C7C41981
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 20:58:25 -0800 (PST)
Received: from localhost (avs2.comp.nus.edu.sg [192.168.49.6])
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTP id AD91711A0FF;
        Thu, 15 Dec 2022 12:58:24 +0800 (+08)
X-Virus-Scanned: amavisd-new at comp.nus.edu.sg
Received: from mailgw1.comp.nus.edu.sg ([192.168.49.5])
        by localhost (avs.comp.nus.edu.sg [192.168.49.6]) (amavisd-new, port 10024)
        with ESMTP id Zk0Uael0eb-2; Thu, 15 Dec 2022 12:58:19 +0800 (+08)
Received: from mailauth1.comp.nus.edu.sg (mailauth1.comp.nus.edu.sg [192.168.49.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailgw1.comp.nus.edu.sg (Postfix) with ESMTPS;
        Thu, 15 Dec 2022 12:58:19 +0800 (+08)
Received: from soccf-srl-002.comp.nus.edu.sg (soccf-srl-002.d2.comp.nus.edu.sg [172.26.191.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: e0446373)
        by mailauth1.comp.nus.edu.sg (Postfix) with ESMTPSA id 3FB14601AF6A5;
        Thu, 15 Dec 2022 12:58:19 +0800 (+08)
From:   Shen Jiamin <shen_jiamin@comp.nus.edu.sg>
To:     olsajiri@gmail.com
Cc:     bpf@vger.kernel.org, nathan@kernel.org, shen_jiamin@comp.nus.edu.sg
Subject: Re: [PATCH] tools/resolve_btfids: Use pkg-config to locate libelf
Date:   Thu, 15 Dec 2022 12:57:52 +0800
Message-Id: <20221215045752.401871-1-shen_jiamin@comp.nus.edu.sg>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Y5pis0BEBZB7PsBh@krava>
References: <Y5pis0BEBZB7PsBh@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you, jirka, for your comment.
Actually we can put that `LIBELF_LIBS` into `LIBS` directly.
I've submitted a new patch.

https://lore.kernel.org/bpf/20221215044703.400139-1-shen_jiamin@comp.nus.edu.sg/

Jiamin
