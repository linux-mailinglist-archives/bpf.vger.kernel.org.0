Return-Path: <bpf+bounces-39096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DAA96E878
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 05:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6383E1F24CF4
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 03:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDAB45BE3;
	Fri,  6 Sep 2024 03:56:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311133B1A2;
	Fri,  6 Sep 2024 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725595009; cv=none; b=bBPsOmbww0sO5hii/fw1p94w2HFrBD5JsA6fmbTu30bcgaA3eb76aoGAjYi8AQZKBd1oQQgS/ihn4zXeggPkW58w4VPSqcmpWUZyRwR8zzEyoU9xKdvEdKgoSwwPxiSsogDHgtTgV3jBpZfzPXSTMYFNOGs85YdBcDS5QymI3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725595009; c=relaxed/simple;
	bh=zYBGGDVe+JkLGVbsLnffLA+0HwJfDRiCsobm1vuByV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqtCAxMYunXE3p01z/VAE/h6aQSdKR1o0nFj2YAfM7flf7IrHFUt0AfRgMXnpm8CafOdLicJ5ezzoI0HrOEUXc7bF6wCv3rDTetXpJhk0lo1pOhDeoR+d3iGqEZXGYpzMd+JJZDTM6BPacvoHD22UZfx2TzwHkY5w5HF8/rkMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X0Mq52cf8z4f3jjw;
	Fri,  6 Sep 2024 11:56:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BA6331A0359;
	Fri,  6 Sep 2024 11:56:43 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgD3ecZ3fdpmQm0bAg--.37609S2;
	Fri, 06 Sep 2024 11:56:41 +0800 (CST)
Message-ID: <540dd7eb-1099-4c38-8004-1cb556b0b9be@huaweicloud.com>
Date: Fri, 6 Sep 2024 11:56:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_bpf-next_v3_00/10=5D_Local_vmtest_enhancem?=
 =?UTF-8?Q?ent_and_RV64_enabled=F0=9F=98=81?=
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240905081401.1894789-1-pulehui@huaweicloud.com>
 <e9816f7c-a603-c73e-5fcc-71bbcf6c6ca3@iogearbox.net>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <e9816f7c-a603-c73e-5fcc-71bbcf6c6ca3@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3ecZ3fdpmQm0bAg--.37609S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy5WrW8ZF47ZF47Kr47CFg_yoWrtFyfp3
	y8Jr1jkryUGF18J3W8Gr4UXFy5tr4DXw1xGr15JFyUAr4UJF1jqr40qF4jgrn8WrW8Xw15
	Aw12qF1UZw17Z3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/9/6 2:52, Daniel Borkmann wrote:
> On 9/5/24 10:13 AM, Pu Lehui wrote:
>> Patch 1-3 fix some problem about bpf selftests. Patch 4 add local rootfs
>> image support for vmtest. Patch 5 enable cross-platform testing for
>> vmtest. Patch 6-10 enable vmtest on RV64.
>>
>> We can now perform cross platform testing for riscv64 bpf using the
>> following command:
>>
>> PLATFORM=riscv64 CROSS_COMPILE=riscv64-linux-gnu- \
>>    tools/testing/selftests/bpf/vmtest.sh \
>>    -l <path of local rootfs image> -- \
>>    ./test_progs -d \
>>        \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
>>            | cut -d'#' -f1 \
>>            | sed -e 's/^[[:space:]]*//' \
>>                  -e 's/[[:space:]]*$//' \
>>            | tr -s '\n' ',' \
>>        )\"
>>
>> For better regression, we rely on commit [0]. And since the work of riscv
>> ftrace to remove stop_machine atomic replacement is in progress, we also
>> need to revert commit [1] [2].
>>
>> The test platform is x86_64 architecture, and the versions of relevant
>> components are as follows:
>>      QEMU: 8.2.0
>>      CLANG: 17.0.6 (align to BPF CI)
>>      ROOTFS: ubuntu noble (generated by [3])
>>
>> Link: 
>> https://lore.kernel.org/all/20240831071520.1630360-1-pulehui@huaweicloud.com/ [0]
>> Link: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3308172276db [1]
>> Link: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7caa9765465f [2]
>> Link: https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh 
>> [3]
> 
> Nice work! Next step is upstream BPF CI integration? :)

CC Björn😁

Yeah, that's what we're most looking forward to and we've been trying to 
move forward with that. There are currently several options, but they 
are not very suitable yet.

1. Cross-platform testing with subset of tests (test_verifier + 
test_progs), it will cost a bit more time.

x86_64 host:
Summary: 536/3594 PASSED, 68 SKIPPED, 0 FAILED
real    30m 18.88s
user    6m 52.97s
sys     21m 3.03s

2. Cross-platform testing will parallel mode, it will meet flaky 
problems while the time consume looks good.

x86_64 host:
real    7m 45.42s
user    6m 13.59s
sys     15m 41.12s

3. Real board testing, which relies on Hypervisor Extension to enable 
kvm on qemu. We are still trying to find a suitable board.

I believe we will be able to see the RV64 on the BPF CI soon.😄

> 
> Fwiw, all still works for me on x86-64 (*), so:
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Tested-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> (*) fresh Equinix Ubuntu instance still requires this one for vmtest.sh, 
> but
>      that is independent of this series (and for others it seems not 
> required)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile 
> b/tools/testing/selftests/bpf/Makefile
> index 04716a5e43f1..02dd161e5185 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -693,7 +693,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): 
> $(TRUNNER_TEST_OBJS)                   \
>                               $(TRUNNER_BPFTOOL)                         \
>                               | $(TRUNNER_BINARY)-extras
>          $$(call msg,BINARY,,$$@)
> -       $(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) 
> $$(LDFLAGS) -o $$@
> +       $(Q)$$(CC) $$(CFLAGS) $(TRUNNER_LDFLAGS) $$(filter %.a %.o,$$^) 
> $$(LDLIBS) $$(LDFLAGS) -o $$@
>          $(Q)$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@
>          $(Q)ln -sf $(if 
> $2,..,.)/tools/build/bpftool/$(USE_BOOTSTRAP)bpftool \
>                     $(OUTPUT)/$(if $2,$2/)bpftool
> diff --git a/tools/testing/selftests/bpf/vmtest.sh 
> b/tools/testing/selftests/bpf/vmtest.sh
> index 79505d294c44..afbd6b785064 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -189,7 +189,7 @@ update_selftests()
>          local 
> selftests_dir="${kernel_checkout}/tools/testing/selftests/bpf"
> 
>          cd "${selftests_dir}"
> -       ${make_command}
> +       TRUNNER_LDFLAGS=-static ${make_command}
> 
>          # Mount the image and copy the selftests to the image.
>          mount_image


