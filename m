Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C899F41AC63
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 11:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbhI1Jzp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 05:55:45 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41458 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239840AbhI1Jzp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 05:55:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0Upw1fcb_1632822844;
Received: from B-39YZML7H-2200.local(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0Upw1fcb_1632822844)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Sep 2021 17:54:04 +0800
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: How to attach a single bpf_program multiple times?
To:     bpf@vger.kernel.org
Message-ID: <d79d7eb8-98da-da02-24ad-130c6f88fe87@linux.alibaba.com>
Date:   Tue, 28 Sep 2021 17:54:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, everyone!

When the ebpf program is the same, but attach to a different kprobe 
function, I have to recompile the entire program. If the kprobe function 
of bpf_program attach can be specified dynamically, then there is no 
need to modify the original program.

Thanks!
