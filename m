Return-Path: <bpf+bounces-10426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A76E07A7025
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 04:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605EE280054
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 02:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA2C17E1;
	Wed, 20 Sep 2023 02:09:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A917CD
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 02:09:30 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1389F
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 19:09:28 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0VsT0Y1C_1695175765;
Received: from 30.221.149.44(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0VsT0Y1C_1695175765)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 10:09:26 +0800
Message-ID: <686fce03-cee7-c268-8bfc-ce49230210b9@linux.alibaba.com>
Date: Wed, 20 Sep 2023 10:09:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
To: bpf <bpf@vger.kernel.org>
From: Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: How to manually construct a struct bpf_program instance?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net




Hello.

I found that libbpf can only construct struct bpf_program instances 
through skeleton. Can I manually construct struct bpf_program instances?

We now load our eBPF program by putting the eBPF bytecode into the elf 
file, and then letting libbpf open the elf file [1]. But adding a map to 
an elf file is a more complicated matter [2]. Therefore, we hope to 
create a bpf_program instance through something like struct bpf_program 
*bpf_program_new(void *insns, int insns_cnt). After creating the struct 
bpf_program instance, we can call bpf_program__attach to load our eBPF 
program bytecode.


[1] https://github.com/aliyun/coolbpf/blob/master/lwcb/bpfir/src/object.rs
[2] https://github.com/aliyun/coolbpf/issues/38

Thanks in advance!

