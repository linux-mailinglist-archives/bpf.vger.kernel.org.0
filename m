Return-Path: <bpf+bounces-6847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643A476E9EA
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 15:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4001C211D3
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 13:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB651F174;
	Thu,  3 Aug 2023 13:19:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1511E528
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 13:19:27 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C901272A
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 06:19:19 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGqDz3DcSz4f41mC
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 21:19:15 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCnAh1QqctkakeuOg--.32091S2;
	Thu, 03 Aug 2023 21:19:15 +0800 (CST)
To: bpf <bpf@vger.kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Subject: Question: Is it OK to assume the address of bpf_dynptr_kern will be
 8-bytes aligned and reuse the lowest bits to save extra info ?
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Joanne Koong <joannelkoong@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Message-ID: <db144689-79c8-6cfb-6a11-983958b28955@huaweicloud.com>
Date: Thu, 3 Aug 2023 21:19:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCnAh1QqctkakeuOg--.32091S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4UKr17CF1kWF13ZFy5Arb_yoW8XF4rpa
	1jga4jqrykJa42yryDuw4xAFWFva9xXr1UG34UJ3y5CrWUWFyavryUWayY9a13Cry7G3yq
	qFW0vw13Ww1fZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

I am preparing for qp-trie v4, but I need some help on how to support
variable-sized key in bpf syscall. The implementation of qp-trie needs
to distinguish between dynptr key from bpf program and variable-sized
key from bpf syscall. In v3, I added a new dynptr type:
BPF_DYNPTR_TYPE_USER for variable-sized key from bpf syscall [0], so
both bpf program and bpf syscall will use the same type to represent the
variable-sized key, but Andrii thought ptr+size tuple was simpler and
would be enough for user APIs, so in v4, the type of key for bpf program
and syscall will be different. One way to handle that is to add a new
parameter in .map_lookup_elem()/.map_delete_elem()/.map_update_elem() to
tell whether the key comes from bpf program or syscall or introduce new
APIs in bpf_map_ops for variable-sized key related syscall, but I think
it will introduce too much churn. Considering that the size of
bpf_dynptr_kern is 8-bytes aligned, so I think maybe I could reuse the
lowest 1-bit of key pointer to tell qp-trie whether or not it is a
bpf_dynptr_kern or a variable-sized key pointer from syscall. For
bpf_dynptr_kern, because it is 8B-aligned, so its lowest bit must be 0,
and for variable-sized key from syscall, I could allocated a 4B-aligned
pointer and setting the lowest bit as 1, so qp-trie can distinguish
between these two types of pointer. The question is that I am not sure
whether the idea above is a good one or not. Does it sound fragile ? Or
is there any better way to handle that ?

Regards


