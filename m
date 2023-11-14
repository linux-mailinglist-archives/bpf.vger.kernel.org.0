Return-Path: <bpf+bounces-15039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829DB7EA95F
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 05:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB65B20ACD
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 04:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3CB659;
	Tue, 14 Nov 2023 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36F0946E
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 04:12:15 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC669D45
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:12:13 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4STtD723mdz4f3nb0
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 12:12:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 479F81A016D
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 12:12:11 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgBnd0eV81Jl7V6cAw--.11045S2;
	Tue, 14 Nov 2023 12:12:08 +0800 (CST)
Subject: Re: [PATCH bpf-next v3] bpf: Do not allocate percpu memory at init
 stage
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20231111013928.948838-1-yonghong.song@linux.dev>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <0efd26fc-7797-f792-4c08-69b80dd50494@huaweicloud.com>
Date: Tue, 14 Nov 2023 12:12:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231111013928.948838-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgBnd0eV81Jl7V6cAw--.11045S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw47GFyfGryxWr45Xw1kXwb_yoW8Jw47p3
	yrGry7CF9YkrnrWw4qq34IqryFgw4rGr1ft3y3Ar1UCr9xXa40kr1Iyan8Cas8Ar95KFy0
	vFyDXr17tayYkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 11/11/2023 9:39 AM, Yonghong Song wrote:
> Kirill Shutemov reported significant percpu memory consumption increase after
> booting in 288-cpu VM ([1]) due to commit 41a5db8d8161 ("bpf: Add support for
> non-fix-size percpu mem allocation"). The percpu memory consumption is
> increased from 111MB to 969MB. The number is from /proc/meminfo.
>
> I tried to reproduce the issue with my local VM which at most supports upto
> 255 cpus. With 252 cpus, without the above commit, the percpu memory
> consumption immediately after boot is 57MB while with the above commit the
> percpu memory consumption is 231MB.
>
> This is not good since so far percpu memory from bpf memory allocator is not
> widely used yet. Let us change pre-allocation in init stage to on-demand
> allocation when verifier detects there is a need of percpu memory for bpf
> program. With this change, percpu memory consumption after boot can be reduced
> signicantly.
>
>   [1] https://lore.kernel.org/lkml/20231109154934.4saimljtqx625l3v@box.shutemov.name/
>
> Fixes: 41a5db8d8161 ("bpf: Add support for non-fix-size percpu mem allocation")
> Reported-and-tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Hou Tao <houtao1@huawei.com>


