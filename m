Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5584FF899
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 16:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiDMOI6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 10:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiDMOI5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 10:08:57 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2FD60CCD
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 07:06:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0VA-7uQk_1649858792;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0VA-7uQk_1649858792)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Apr 2022 22:06:33 +0800
Date:   Wed, 13 Apr 2022 22:06:29 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     bpf@vger.kernel.org
Subject: [Question] bpf map value increase unexpectedly with tracepoint
 qdisc/qdisc_dequeue
Message-ID: <20220413140629.GA22650@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I tried to count when tracepoint qdisc/qdisc_dequeue hit each time, then read
the count value from userspace by bpf_map_lookup_elem().
With bpftrace, I can see this tracepoint is hit about 700 times, but the count
I get from the bpf map is below 20. It's weird. Then I tried to add a bpf_printk()
to the program, and the count I get is normal which is about 700.

The bpf program codes like that:

	struct qdisc_dequeue_ctx {
	        __u64           __pad;
	        __u64           qdisc;
	        __u64           txq;
	        int             packets;
	        __u64           skbaddr;
	        int             ifindex;
	        __u32           handle;
	        __u32           parent;
	        unsigned long   txq_state;
	};
	
	struct {
	        __uint(type, BPF_MAP_TYPE_HASH);
	        __type(key, int);
	        __type(value, __u32);
	        __uint(max_entries, 1);
	        __uint(pinning, LIBBPF_PIN_BY_NAME);
	} count_map SEC(".maps");
	
	SEC("tracepoint/qdisc/qdisc_dequeue")
	int trace_dequeue(struct qdisc_dequeue_ctx *ctx)
	{
	        int key = 0;
	        __u32 *value;
	        __u32 init = 0;
	
	        value = bpf_map_lookup_elem(&count_map, &key);
	        if (value) {
	                *value += 1;
	        } else {
	                bpf_printk("value reset");
	                bpf_map_update_elem(&count_map, &key, &init, 0);
	        }
	        return 0;
	}

Any suggestion is appreciated!

Thanks,
Wu Zongyong
