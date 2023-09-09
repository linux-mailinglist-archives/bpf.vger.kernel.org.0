Return-Path: <bpf+bounces-9595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11F17996FB
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 11:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF9A281297
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 09:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3531C3C;
	Sat,  9 Sep 2023 09:00:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F4530F89
	for <bpf@vger.kernel.org>; Sat,  9 Sep 2023 09:00:05 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B59210F9;
	Sat,  9 Sep 2023 02:00:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RjRkf74FZz4f3khH;
	Sat,  9 Sep 2023 16:59:54 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgBX59YNNPxkXgAZAA--.9460S2;
	Sat, 09 Sep 2023 16:59:58 +0800 (CST)
Message-ID: <4fe804ce-9bb5-b622-37f0-4aff761af192@huaweicloud.com>
Date: Sat, 9 Sep 2023 16:59:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v5 3/3] bpf, arm64: use bpf_jit_binary_pack_alloc
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
 bpf@vger.kernel.org, kpsingh@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230908144320.2474-1-puranjay12@gmail.com>
 <20230908144320.2474-4-puranjay12@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20230908144320.2474-4-puranjay12@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBX59YNNPxkXgAZAA--.9460S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jry7tw4DZFykKFy3Kr47CFg_yoW3KFcEv3
	WYy3Z7WwnxKF4kCrW8Gr13Za1jk34vyrn5JryfXwn3C393XwsYyF929rWI93s7Wr1UtrW5
	JryfWF1rXw4xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
	AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xF
	o4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UWE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/2023 10:43 PM, Puranjay Mohan wrote:

[ ... ]

> +
> +void bpf_jit_free(struct bpf_prog *prog)
> +{
> +	if (prog->jited) {
> +		struct arm64_jit_data *jit_data = prog->aux->jit_data;
> +		struct bpf_binary_header *hdr;
> +
> +		/*
> +		 * If we fail the final pass of JIT (from jit_subprogs),
> +		 * the program may not be finalized yet. Call finalize here
> +		 * before freeing it.
> +		 */
> +		if (jit_data) {
> +			bpf_jit_binary_pack_finalize(prog, jit_data->ro_header,
> +						     jit_data->header);

bpf_jit_binary_pack_finalize copies all instructions on the rw image to
the ro_image, which is unnecessary in a free function.

> +			kfree(jit_data);
> +		}
> +		hdr = bpf_jit_binary_pack_hdr(prog);
> +		bpf_jit_binary_pack_free(hdr, NULL);
> +		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
> +	}
> +
> +	bpf_prog_unlock_free(prog);
> +}


