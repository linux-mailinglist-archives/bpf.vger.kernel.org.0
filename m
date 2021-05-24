Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4155838DF30
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 04:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhEXCZt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 May 2021 22:25:49 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:50367 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231782AbhEXCZt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 23 May 2021 22:25:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0UZq20WH_1621823060;
Received: from B-39YZML7H-2200.local(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0UZq20WH_1621823060)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 May 2021 10:24:20 +0800
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
Subject: Why does bpf_probe_read also release relocation information?
To:     bpf@vger.kernel.org
Message-ID: <4b600d5b-c92b-878f-1306-d15909b56c3e@linux.alibaba.com>
Date:   Mon, 24 May 2021 10:24:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello everyone,

I would like to ask a question. The question is: Why does bpf_probe_read 
not use __builtin_preserve_access_index and also release relocation 
information?

The following document is from: 
https://github.com/libbpf/libbpf/blob/57375504c6c9766d23f178c40f71bf5e8df9363d/src/libbpf_internal.h#L414 


  * Such relocation is emitted when using __builtin_preserve_access_index()
  * Clang built-in, passing expression that captures field address, e.g.:
  *
  * bpf_probe_read(&dst, sizeof(dst),
  *		  __builtin_preserve_access_index(&src->a.b.c));
  *
  * In this case Clang will emit field relocation recording necessary 
data to
  * be able to find offset of embedded `a.b.c` field within `src` struct.


This document clearly explains the function of 
__builtin_preserve_access_index. However, I did a small test. The test 
results show that only using bpf_probe_read and not using 
__builtin_preserve_access_index will also be relocated.The specific test 
content is as follows:

// The bpf program.
SEC("kprobe/kfree_skb")
int BPF_PROG(kprobe__kfree_skb,struct sk_buff *skb)
{
     unsigned char *data;
     bpf_probe_read(&data,sizeof(data),&skb->data);
     return 0;
}

// The debug log.
libbpf: CO-RE relocating [0] struct sk_buff: found target candidate 
[3057] struct sk_buff in [vmlinux]
libbpf: CO-RE relocating [0] struct sk_buff: found target candidate 
[23925] struct sk_buff in [vmlinux]
libbpf: prog 'kprobe__kfree_skb': relo #0: matching candidate #0 [3057] 
struct sk_buff.data (0:77 @ offset 240)
libbpf: prog 'kprobe__kfree_skb': relo #0: matching candidate #1 [23925] 
struct sk_buff.data (0:77 @ offset 240)
libbpf: prog 'kprobe__kfree_skb': relo #0: patched insn #0 (ALU/ALU64) 
imm 240 -> 240

Thanks in advance for your help,
Cheng


