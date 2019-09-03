Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA836A76B9
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2019 00:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfICWNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Sep 2019 18:13:11 -0400
Received: from www62.your-server.de ([213.133.104.62]:44740 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICWNL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Sep 2019 18:13:11 -0400
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i5H2u-0003qt-OW; Wed, 04 Sep 2019 00:13:04 +0200
Received: from [178.197.249.19] (helo=pc-63.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i5H2u-0003FM-E2; Wed, 04 Sep 2019 00:13:04 +0200
Subject: Re: [PATCH bpf v2] bpf: fix accessing bpf_sysctl.file_pos on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Andrey Ignatov <rdna@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20190816105300.49035-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <55d0fca4-099a-9fb8-8dcd-9cca31e18063@iogearbox.net>
Date:   Wed, 4 Sep 2019 00:13:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190816105300.49035-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25561/Tue Sep  3 10:24:26 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/16/19 12:53 PM, Ilya Leoshkevich wrote:
> "ctx:file_pos sysctl:read write ok" fails on s390 with "Read value  !=
> nux". This is because verifier rewrites a complete 32-bit
> bpf_sysctl.file_pos update to a partial update of the first 32 bits of
> 64-bit *bpf_sysctl_kern.ppos, which is not correct on big-endian
> systems.
> 
> Fix by using an offset on big-endian systems.
> 
> Ditto for bpf_sysctl.file_pos reads. Currently the test does not detect
> a problem there, since it expects to see 0, which it gets with high
> probability in error cases, so change it to seek to offset 3 and expect
> 3 in bpf_sysctl.file_pos.
> 
> Fixes: e1550bfe0de4 ("bpf: Add file_pos field to bpf_sysctl ctx")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> v1->v2: Merge bpf_ctx_narrow_load_shift and
> bpf_ctx_narrow_access_offset.
> 
>   include/linux/filter.h                    |  8 ++++----
>   kernel/bpf/cgroup.c                       | 10 ++++++++--
>   kernel/bpf/verifier.c                     |  4 ++--
>   tools/testing/selftests/bpf/test_sysctl.c |  9 ++++++++-
>   4 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 92c6e31fb008..2ce57645f3cd 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -749,14 +749,14 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
>   }
>   
>   static inline u8
> -bpf_ctx_narrow_load_shift(u32 off, u32 size, u32 size_default)
> +bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
>   {
> -	u8 load_off = off & (size_default - 1);
> +	u8 access_off = off & (size_default - 1);
>   
>   #ifdef __LITTLE_ENDIAN
> -	return load_off * 8;
> +	return access_off;
>   #else
> -	return (size_default - (load_off + size)) * 8;
> +	return size_default - (access_off + size);
>   #endif
>   }
>   
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 0a00eaca6fae..00c4647ce92a 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1325,6 +1325,7 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
>   				     struct bpf_prog *prog, u32 *target_size)
>   {
>   	struct bpf_insn *insn = insn_buf;
> +	u32 read_size;
>   
>   	switch (si->off) {
>   	case offsetof(struct bpf_sysctl, write):
> @@ -1356,7 +1357,9 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
>   				treg, si->dst_reg,
>   				offsetof(struct bpf_sysctl_kern, ppos));
>   			*insn++ = BPF_STX_MEM(
> -				BPF_SIZEOF(u32), treg, si->src_reg, 0);
> +				BPF_SIZEOF(u32), treg, si->src_reg,
> +				bpf_ctx_narrow_access_offset(
> +					0, sizeof(u32), sizeof(loff_t)));
>   			*insn++ = BPF_LDX_MEM(
>   				BPF_DW, treg, si->dst_reg,
>   				offsetof(struct bpf_sysctl_kern, tmp_reg));
> @@ -1365,8 +1368,11 @@ static u32 sysctl_convert_ctx_access(enum bpf_access_type type,
>   				BPF_FIELD_SIZEOF(struct bpf_sysctl_kern, ppos),
>   				si->dst_reg, si->src_reg,
>   				offsetof(struct bpf_sysctl_kern, ppos));
> +			read_size = bpf_size_to_bytes(BPF_SIZE(si->code));
>   			*insn++ = BPF_LDX_MEM(
> -				BPF_SIZE(si->code), si->dst_reg, si->dst_reg, 0);
> +				BPF_SIZE(si->code), si->dst_reg, si->dst_reg,
> +				bpf_ctx_narrow_access_offset(
> +					0, read_size, sizeof(loff_t)));

I see what you're doing, but generally I'm a bit puzzled on why we need these
partial store/loads and cannot access the full loff_t value internally with the
rewrite. Why was BPF_SIZEOF(u32) chosen in the first place? Looks like git history
doesn't have any useful insight here ... Andrey mind to put some clarifications
on this? Thx

>   		}
>   		*target_size = sizeof(u32);
>   		break;
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c84d83f86141..d1d4c995a9eb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8616,8 +8616,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>   		}
>   
>   		if (is_narrower_load && size < target_size) {
> -			u8 shift = bpf_ctx_narrow_load_shift(off, size,
> -							     size_default);
> +			u8 shift = bpf_ctx_narrow_access_offset(
> +				off, size, size_default) * 8;
>   			if (ctx_field_size <= 4) {
>   				if (shift)
>   					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
> diff --git a/tools/testing/selftests/bpf/test_sysctl.c b/tools/testing/selftests/bpf/test_sysctl.c
> index a3bebd7c68dd..abc26248a7f1 100644
> --- a/tools/testing/selftests/bpf/test_sysctl.c
> +++ b/tools/testing/selftests/bpf/test_sysctl.c
> @@ -31,6 +31,7 @@ struct sysctl_test {
>   	enum bpf_attach_type attach_type;
>   	const char *sysctl;
>   	int open_flags;
> +	int seek;
>   	const char *newval;
>   	const char *oldval;
>   	enum {
> @@ -139,7 +140,7 @@ static struct sysctl_test tests[] = {
>   			/* If (file_pos == X) */
>   			BPF_LDX_MEM(BPF_W, BPF_REG_7, BPF_REG_1,
>   				    offsetof(struct bpf_sysctl, file_pos)),
> -			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
> +			BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 3, 2),
>   
>   			/* return ALLOW; */
>   			BPF_MOV64_IMM(BPF_REG_0, 1),
> @@ -152,6 +153,7 @@ static struct sysctl_test tests[] = {
>   		.attach_type = BPF_CGROUP_SYSCTL,
>   		.sysctl = "kernel/ostype",
>   		.open_flags = O_RDONLY,
> +		.seek = 3,
>   		.result = SUCCESS,
>   	},
>   	{
> @@ -1442,6 +1444,11 @@ static int access_sysctl(const char *sysctl_path,
>   	if (fd < 0)
>   		return fd;
>   
> +	if (test->seek && lseek(fd, test->seek, SEEK_SET) == -1) {
> +		log_err("lseek(%d) failed", test->seek);
> +		goto err;
> +	}
> +
>   	if (test->open_flags == O_RDONLY) {
>   		char buf[128];
>   
> 

