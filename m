Return-Path: <bpf+bounces-36831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B38B94DC3B
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 12:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117341F21F15
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B174B153814;
	Sat, 10 Aug 2024 10:17:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0276D3EA69
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723285060; cv=none; b=S/x6NJs+Z38rQ8awho9/zgblvaIW2GqXIFfXteDa5BTRhdMVoBHSYW+P8udEhYnLlrBzhwuqXuFlfGlpwWSvM2D5mJsNBnbVs8esMWKViPCJrhAmIOJYZ+tET86h9j2ijV/YVdnnzu/1teuGxSHr3EVR8jwy58eXwtUNV2tJV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723285060; c=relaxed/simple;
	bh=+pSlIcOBryXNURL+7mklMOcU1g3lSdJehHLZf3Whi0w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RmkF/nQagcQrbGjFgkEuToLFcznfdV9krAe9ypij4rPXR+RDAoh3ad/K3Q8kbHiMbbTCDtqAe2JuMY6cGLKoSZJZ9WOobxaH6O+t4bMMaZ1g+zUAbd8M5c2ELh5gS2zoQwLcxVvUxdJlMK6Qf0jxNyi/vjUBMzzRldRmLX3l4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WgxY07107z4f3jk0
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 18:17:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 246911A13FC
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 18:17:34 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgC3CUw7PrdmymMBBQ--.7598S2;
	Sat, 10 Aug 2024 18:17:34 +0800 (CST)
Subject: Re: [PATCH v3 bpf-next 2/5] bpf: Search for kptrs in prog BTF structs
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, sinquersw@gmail.com, davemarchevsky@fb.com,
 Amery Hung <amery.hung@bytedance.com>
References: <20240809005131.3916464-1-amery.hung@bytedance.com>
 <20240809005131.3916464-3-amery.hung@bytedance.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <2c1ccccf-cb81-aa4d-4197-2d5161ae3c42@huaweicloud.com>
Date: Sat, 10 Aug 2024 18:17:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240809005131.3916464-3-amery.hung@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgC3CUw7PrdmymMBBQ--.7598S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWxGr17XrWDtF1xAr47Arb_yoW8KryfpF
	Z3tr13CrW8Kryj9r1DKw42va1S9wn8J3W5JFy5JrWY9rnxKryDWr1rKa90kry5GrySgF9F
	qr4q9rZxJ3WDZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 8/9/2024 8:51 AM, Amery Hung wrote:
> From: Dave Marchevsky <davemarchevsky@fb.com>
>
> Currently btf_parse_fields is used in two places to create struct
> btf_record's for structs: when looking at mapval type, and when looking
> at any struct in program BTF. The former looks for kptr fields while the
> latter does not. This patch modifies the btf_parse_fields call made when
> looking at prog BTF struct types to search for kptrs as well.
>
> Before this series there was no reason to search for kptrs in non-mapval
> types: a referenced kptr needs some owner to guarantee resource cleanup,
> and map values were the only owner that supported this. If a struct with
> a kptr field were to have some non-kptr-aware owner, the kptr field
> might not be properly cleaned up and result in resources leaking. Only
> searching for kptr fields in mapval was a simple way to avoid this
> problem.
>
> In practice, though, searching for BPF_KPTR when populating
> struct_meta_tab does not expose us to this risk, as struct_meta_tab is
> only accessed through btf_find_struct_meta helper, and that helper is
> only called in contexts where recognizing the kptr field is safe:
>
>   * PTR_TO_BTF_ID reg w/ MEM_ALLOC flag
>     * Such a reg is a local kptr and must be free'd via bpf_obj_drop,
>       which will correctly handle kptr field
>
>   * When handling specific kfuncs which either expect MEM_ALLOC input or
>     return MEM_ALLOC output (obj_{new,drop}, percpu_obj_{new,drop},
>     list+rbtree funcs, refcount_acquire)
>      * Will correctly handle kptr field for same reasons as above
>
>   * When looking at kptr pointee type
>      * Called by functions which implement "correct kptr resource
>        handling"
>
>   * In btf_check_and_fixup_fields
>      * Helper that ensures no ownership loops for lists and rbtrees,
>        doesn't care about kptr field existence
>
> So we should be able to find BPF_KPTR fields in all prog BTF structs
> without leaking resources.
>
> Further patches in the series will build on this change to support
> kptr_xchg into non-mapval local kptr. Without this change there would be
> no kptr field found in such a type.
>
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>

Acked-by: Hou Tao <houtao1@huawei.com>


