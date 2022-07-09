Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CD356C851
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiGIJWK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jul 2022 05:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIJWJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 05:22:09 -0400
X-Greylist: delayed 473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Jul 2022 02:22:07 PDT
Received: from smtp227.sjtu.edu.cn (unknown [202.120.2.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC4666ACA
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 02:22:07 -0700 (PDT)
Received: from mta91.sjtu.edu.cn (unknown [10.118.0.91])
        by smtp227.sjtu.edu.cn (Postfix) with ESMTPS id 6846227DCF0
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 17:14:11 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mta91.sjtu.edu.cn (Postfix) with ESMTP id 21F6737C83F
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 17:14:11 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from mta91.sjtu.edu.cn ([127.0.0.1])
        by localhost (mta91.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CH0IP3rpAr6A for <bpf@vger.kernel.org>;
        Sat,  9 Jul 2022 17:14:11 +0800 (CST)
Received: from mstore106.sjtu.edu.cn (mstore101.sjtu.edu.cn [10.118.0.106])
        by mta91.sjtu.edu.cn (Postfix) with ESMTP id 0D20437C83E
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 17:14:11 +0800 (CST)
Date:   Sat, 9 Jul 2022 17:14:10 +0800 (CST)
From:   =?gb2312?B?0abV8cG6?= <xuezhenliang@sjtu.edu.cn>
To:     bpf@vger.kernel.org
Message-ID: <422556411.14152964.1657358050994.JavaMail.zimbra@sjtu.edu.cn>
Subject: Question on BPF's capability of changing kernel's TCP behaviors
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.22.181.145]
X-Mailer: Zimbra 8.8.15_GA_4308 (ZimbraWebClient - GC101 (Linux)/8.8.15_GA_3928)
Thread-Index: kzSS4+wQRijl2rkpNUk1OjUoo3uV9A==
Thread-Topic: Question on BPF's capability of changing kernel's TCP behaviors
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone,

We think BPF is a great and elegant technology to experiment with Linux network stack. Recently for some reasons we want to change TCP acknowledgement policy so that the kernel acknowledges a byte only after this byte has been read into the user space (e.g. via a recv syscall). As a comparison, a normal kernel will possibly send an ack once the data has been read into the TCP receive buffer, which lives in the kernel space.

We're new to BPF and it seems that there are many different types of BPF programs. We're not sure about whether BPF is capable of this task. Could you please give us some advice on which parts of BPF should we look into first?

Thanks,
Xue Zhenliang
