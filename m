Return-Path: <bpf+bounces-7803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062B977CAE6
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 12:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F56A281489
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77182101D6;
	Tue, 15 Aug 2023 10:01:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6F6FA9
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:01:39 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6881B6
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 03:01:36 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0VprYthe_1692093693;
Received: from 30.221.147.43(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0VprYthe_1692093693)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 18:01:34 +0800
Message-ID: <45060ec9-d68a-dc6c-908d-649394f48dcb@linux.alibaba.com>
Date: Tue, 15 Aug 2023 18:01:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
To: bpf <bpf@vger.kernel.org>
From: Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: Can eBPF programs call kfuncs of out-of-tree modules?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello.

Recently we found that eBPF can call kernel functions, but we don’t know 
whether it is possible to call register_btf_kfunc_id_set in the 
out-of-tree module, and enable eBPF programs of types such as kprobe and 
tracepoint to call functions defined in out-of-tree modules.

Thanks in advance!

