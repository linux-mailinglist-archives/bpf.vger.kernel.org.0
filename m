Return-Path: <bpf+bounces-43625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6CE9B72A3
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 03:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65A2B2337F
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 02:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C841487E1;
	Thu, 31 Oct 2024 02:44:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6A13D251
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730342676; cv=none; b=ZFD0UogkSXm+5o/zOkQun48v3m5hOGSqOpNi3okklgSzfqi0kBVqPrc3TTICXFB023zWRv9vDJg+qDxqv4fe32G4YgYO1b9pAkfXHNpQpx/YcjY9u76xnK6Mj4fILlZNv0F1SCxqPN8LGM0lnNfgQF+XGSDngVd6aigRP/L/4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730342676; c=relaxed/simple;
	bh=vErYlCn4AJI0PAECmCWSX+UKPnh2/wH3fixpTX0m4vg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XdV6FO/XNlS5PLBKq/bmxhz4lxieHj0CFnzwBjRzOUA1ZiOkw1Ul6zxvwrgKARjlb23/Q9buYuARmMaxPA9etZEJM1GBpm/oFheRTRs7wLhJ2H0f+ZoyIviABVPN7PD9z7oEK0KWFPQjb+AJbei9jekag+ZNmwiH4YDwQSocom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xf7c55lkyz4f3jJ1
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 10:44:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8982E1A08DC
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 10:44:23 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgD3n7EC7yJnYLWmAQ--.1140S2;
	Thu, 31 Oct 2024 10:44:21 +0800 (CST)
Subject: Re: [PATCH bpf-next 08/16] bpf: Handle bpf_dynptr_user in bpf syscall
 when it is used as input
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 bpf@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xukuohai@huawei.com
References: <47cda1ac-3d40-415a-a36c-833efbbfa19c@stanley.mountain>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <aa5dde4f-6e27-1c61-921f-e2254cfc7adb@huaweicloud.com>
Date: Thu, 31 Oct 2024 10:44:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <47cda1ac-3d40-415a-a36c-833efbbfa19c@stanley.mountain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgD3n7EC7yJnYLWmAQ--.1140S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur17AF4xXFyDtr1kCryrXrb_yoW5Wry7pa
	4rW3Wqqr4Yqr98AayDKw4xCw4rJw1rX343GFZxGryrWr4jqF90gw1xtay3WFnaqFWxGFya
	yrWfJr15G34kZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUxo7KDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 10/13/2024 9:08 PM, Dan Carpenter wrote:
> Hi Hou,
>
> kernel test robot noticed the following build warnings:
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Hou-Tao/bpf-Introduce-map-flag-BPF_F_DYNPTR_IN_KEY/20241008-171136
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> patch link:    https://lore.kernel.org/r/20241008091501.8302-9-houtao%40huaweicloud.com
> patch subject: [PATCH bpf-next 08/16] bpf: Handle bpf_dynptr_user in bpf syscall when it is used as input
> config: x86_64-randconfig-161-20241011 (https://download.01.org/0day-ci/archive/20241012/202410120530.zUoa1scp-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202410120530.zUoa1scp-lkp@intel.com/
>
> smatch warnings:
> kernel/bpf/syscall.c:1557 bpf_copy_from_dynptr_ukey() warn: 'key' is an error pointer or valid
>
> vim +/key +1557 kernel/bpf/syscall.c
>
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1543  static void *bpf_copy_from_dynptr_ukey(const struct bpf_map *map, bpfptr_t ukey)
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1544  {
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1545  	const struct btf_record *record;
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1546  	const struct btf_field *field;
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1547  	struct bpf_dynptr_user *uptr;
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1548  	struct bpf_dynptr_kern *kptr;
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1549  	void *key, *new_key, *kdata;
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1550  	unsigned int key_size, size;
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1551  	bpfptr_t udata;
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1552  	unsigned int i;
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1553  	int err;
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1554  
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1555  	key_size = map->key_size;
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1556  	key = kvmemdup_bpfptr(ukey, key_size);
> e1883aa78ac1fe9 Hou Tao            2024-10-08 @1557  	if (!key)
>
> This should be if (IS_ERR(key))

Thanks for the report. You are right, the check of key which is returned
by kvmemdup_bpfptr is incorrect(). Will fix it in the next revision and
will try to add some test cases for these error paths.
>
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1558  		return ERR_PTR(-ENOMEM);
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1559  
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1560  	size = key_size;
> e1883aa78ac1fe9 Hou Tao            2024-10-08  1561  	record = map->key_record;
>


