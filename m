Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EF94B2507
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 12:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349768AbiBKL6A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 11 Feb 2022 06:58:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244238AbiBKL57 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 06:57:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E912AF59
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 03:57:55 -0800 (PST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JwBpX1W3Qz682kB;
        Fri, 11 Feb 2022 19:53:40 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 12:57:53 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.021;
 Fri, 11 Feb 2022 12:57:53 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>
Subject: Question about LSM with eBPF
Thread-Topic: Question about LSM with eBPF
Thread-Index: AdgfPjCCQz8FA8hRSCeOBTGYcaxD0Q==
Date:   Fri, 11 Feb 2022 11:57:53 +0000
Message-ID: <885e8924a6704f5181c8d774e0a8f74c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.204.63.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi

I'm working on an LSM implemented with eBPF. I have a
question about persistence. Is it possible to keep the
attached LSM running without the user space process
that attached it?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Zhong Ronghua

