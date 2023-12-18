Return-Path: <bpf+bounces-18164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F2816676
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 07:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABA728260A
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A286FDE;
	Mon, 18 Dec 2023 06:26:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280B6FA2;
	Mon, 18 Dec 2023 06:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VygYz0X_1702880804;
Received: from 30.221.148.252(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VygYz0X_1702880804)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 14:26:45 +0800
Message-ID: <e616c2ac-e68b-3814-eac3-304e49eb39b8@linux.alibaba.com>
Date: Mon, 18 Dec 2023 14:26:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
Subject: =?UTF-8?Q?Can_netfilter-ebpf_modify_packets_=ef=bc=9f?=
To: pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de,
 coreteam@netfilter.org, pabeni@redhat.com, ast@kernel.org,
 netfilter-devel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hello everyone,

I've noticed that it's not possible to modify packets via netfilter-ebpf 
right now. I'm curious if this is by design.

Currently, I've observed some issues, such as:

1. The dynptr obtained through bpf_dynptr_from_skb in the netfilter-ebpf 
prog is read-only.
2. In addition to modification, applications may also need to delete or 
append some data in the skb, which dynptr_write cannot meet.
3. Modifying packets involves recalculating csum, or updating 
transparent header, etc.
4. The BPF_PROG_TYPE_SCHED_ACT provides a large number of helpers that 
can meet various packet modification scenarios. However, due to arg_type 
type checks(ARG_PTR_TO_CTX), we cannot use them directly in netfilter yet.

Looking forward to any feedback.

Best wishes,
D. Wythe

