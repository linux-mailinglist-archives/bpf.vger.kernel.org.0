Return-Path: <bpf+bounces-5904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F718762982
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 05:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0A6281B4D
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 03:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F169C5236;
	Wed, 26 Jul 2023 03:52:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD311FD0;
	Wed, 26 Jul 2023 03:52:53 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503BB2695;
	Tue, 25 Jul 2023 20:52:51 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R9g050wtlzLp3n;
	Wed, 26 Jul 2023 11:50:13 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 11:52:47 +0800
Message-ID: <0878305d-7393-ea7a-25c4-455a43d3549e@huawei.com>
Date: Wed, 26 Jul 2023 11:52:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
From: shaozhengchao <shaozhengchao@huawei.com>
Subject: [Question]Attach xdp program to bond driver with skb mode
To: netdev <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi:
	Now, as shown in commit 879af96ffd72("net, core: Add support for
XDP redirection to slave device"), if the master has been attached
program, the slave cannot be attached program. Similarly, if the slave
is already attached program, the master is not allowed to attach the
program. It does work for hw and driver mode. But in skb mode, if the
slave has been attached program, the master also can be attached
program. So I have two questions:
1. should skb mode work the same to hw/drv mode?
2. If other "master" drivers (team?) need to implement XDP feature, is
it more appropriate to place the restriction in dev_xdp_attach? As shown
in the following figure:

@@ -9194,6 +9194,14 @@  static int dev_xdp_attach(struct net_device 
*dev, struct netlink_ext_ack *extack
  		}
  	}

+	/* don't allow if a slave device already has a program */
+	netdev_for_each_lower_dev(dev, lower, iter) {
+		if (dev_xdp_prog_count(lower) > 0) {
+			NL_SET_ERR_MSG(extack, "Cannot attach when a slave device already 
has a program");
+			return -EEXIST;
+		}
+	}
+

