Return-Path: <bpf+bounces-45613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 626B09D9049
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 03:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAFDBB273EC
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 02:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C9C1799F;
	Tue, 26 Nov 2024 02:11:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3514A85
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732587098; cv=none; b=eFMr0vwwwQhxb0mpE3MHSFuLKTkTzJOiH1anFOoATYVu/jWwpxCKp01+I7IYg7IWeeMigu7a6W9qQi+shGYcCaz8L3wK8a+sD259HbmEmWOkJ/GJ3Br0xf52t/ZAcot9KGUb0Xlr0yaHNhtz9FcSZDlZq4zDMNSjF4K8j7hggrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732587098; c=relaxed/simple;
	bh=vjDRzJoaGfxwz/K2ssiL7bsa8sQp4dB8/fIgnT2cFCE=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=grO9NxAc5V0NhV0AK8F6NRHi8PrHFdtXF1bpHiqEhBqn4qC3GG9R7mXYG+U3MG3kRt26YG4Us7d/+PVsUaKTTGWpI086VpnOg5e5kf1Fiv9JyCUw1S3YqBY/w7JsTaSrb9VRxAKegCKvAz06el3eF+KWIslxWbEOkJ0cUkjQ20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xy5f226Btz4f3mHk
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 10:11:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ECD241A058E
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 10:11:25 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgDnDoNKLkVnoEhkCw--.43683S2;
	Tue, 26 Nov 2024 10:11:25 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 3/6] bpf: add fd_array_cnt attribute for
 prog_load
To: Anton Protopopov <aspsk@isovalent.com>, bpf@vger.kernel.org
References: <20241119101552.505650-1-aspsk@isovalent.com>
 <20241119101552.505650-4-aspsk@isovalent.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <1b5f9aba-d7de-a677-0a5f-89237c8f62a4@huaweicloud.com>
Date: Tue, 26 Nov 2024 10:11:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241119101552.505650-4-aspsk@isovalent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgDnDoNKLkVnoEhkCw--.43683S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XrW7KF1rXFyrtFy3GFWUtwb_yoW7Zr4UpF
	WkWFWxZF4UJr47C343Xay8uayYvr4rX3Wjk343u345CF9aqrn3ArWFka1Y9rs5tr4DCF1I
	vr4jv3s8Gayqya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/19/2024 6:15 PM, Anton Protopopov wrote:
> The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> of file descriptors: maps or btfs. This field was introduced as a
> sparse array. Introduce a new attribute, fd_array_cnt, which, if
> present, indicates that the fd_array is a continuous array of the
> corresponding length.
>
> If fd_array_cnt is non-zero, then every map in the fd_array will be
> bound to the program, as if it was used by the program. This
> functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> maps can be used by the verifier during the program load.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  include/uapi/linux/bpf.h       |  10 ++++
>  kernel/bpf/syscall.c           |   2 +-
>  kernel/bpf/verifier.c          | 106 ++++++++++++++++++++++++++++-----
>  tools/include/uapi/linux/bpf.h |  10 ++++
>  4 files changed, 113 insertions(+), 15 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 4162afc6b5d0..2acf9b336371 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1573,6 +1573,16 @@ union bpf_attr {
>  		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
>  		 */
>  		__s32		prog_token_fd;
> +		/* The fd_array_cnt can be used to pass the length of the
> +		 * fd_array array. In this case all the [map] file descriptors
> +		 * passed in this array will be bound to the program, even if
> +		 * the maps are not referenced directly. The functionality is
> +		 * similar to the BPF_PROG_BIND_MAP syscall, but maps can be
> +		 * used by the verifier during the program load. If provided,
> +		 * then the fd_array[0,...,fd_array_cnt-1] is expected to be
> +		 * continuous.
> +		 */
> +		__u32		fd_array_cnt;
>  	};
>  
>  	struct { /* anonymous struct used by BPF_OBJ_* commands */

SNIP
> +/*
> + * The add_fd_from_fd_array() is executed only if fd_array_cnt is given.  In
> + * this case expect that every file descriptor in the array is either a map or
> + * a BTF, or a hole (0). Everything else is considered to be trash.
> + */
> +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> +{
> +	struct bpf_map *map;
> +	CLASS(fd, f)(fd);
> +	int ret;
> +
> +	map = __bpf_map_get(f);
> +	if (!IS_ERR(map)) {
> +		ret = add_used_map(env, map);
> +		if (ret < 0)
> +			return ret;
> +		return 0;
> +	}
> +
> +	if (!IS_ERR(__btf_get_by_fd(f)))
> +		return 0;

For fd_array_cnt > 0 case, does it need to handle BTF fd case ? If it
does, these returned BTFs should be saved in somewhere, otherewise,
these BTFs will be leaked.
> +
> +	if (!fd)
> +		return 0;
> +
> +	verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
> +	return PTR_ERR(map);
> +}
> +
> +static int env_init_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
> +{
> +	int size = sizeof(int) * attr->fd_array_cnt;
> +	int *copy;
> +	int ret;
> +	int i;
> +
> +	if (attr->fd_array_cnt >= MAX_USED_MAPS)
> +		return -E2BIG;
> +
> +	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> +
> +	/*
> +	 * The only difference between old (no fd_array_cnt is given) and new
> +	 * APIs is that in the latter case the fd_array is expected to be
> +	 * continuous and is scanned for map fds right away
> +	 */
> +	if (!size)
> +		return 0;
> +
> +	copy = kzalloc(size, GFP_KERNEL);
> +	if (!copy)
> +		return -ENOMEM;
> +
> +	if (copy_from_bpfptr_offset(copy, env->fd_array, 0, size)) {
> +		ret = -EFAULT;
> +		goto free_copy;
> +	}

It is better to use kvmemdup_bpfptr() instead.
> +
> +	for (i = 0; i < attr->fd_array_cnt; i++) {
> +		ret = add_fd_from_fd_array(env, copy[i]);
> +		if (ret)
> +			goto free_copy;
> +	}
> +
> +free_copy:
> +	kfree(copy);
> +	return ret;
> +}
> +
>  int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
>  {
>  	u64 start_time = ktime_get_ns();
> @@ -22557,7 +22632,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>  		env->insn_aux_data[i].orig_idx = i;
>  	env->prog = *prog;
>  	env->ops = bpf_verifier_ops[env->prog->type];
> -	env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> +	ret = env_init_fd_array(env, attr, uattr);
> +	if (ret)
> +		goto err_free_aux_data;

These maps saved in env->used_map will also be leaked.
>  
>  	env->allow_ptr_leaks = bpf_allow_ptr_leaks(env->prog->aux->token);
>  	env->allow_uninit_stack = bpf_allow_uninit_stack(env->prog->aux->token);
> @@ -22775,6 +22852,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
>  err_unlock:
>  	if (!is_priv)
>  		mutex_unlock(&bpf_verifier_lock);
> +err_free_aux_data:
>  	vfree(env->insn_aux_data);
>  	kvfree(env->insn_hist);
>  err_free_env:
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 4162afc6b5d0..2acf9b336371 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -1573,6 +1573,16 @@ union bpf_attr {
>  		 * If provided, prog_flags should have BPF_F_TOKEN_FD flag set.
>  		 */
>  		__s32		prog_token_fd;
> +		/* The fd_array_cnt can be used to pass the length of the
> +		 * fd_array array. In this case all the [map] file descriptors
> +		 * passed in this array will be bound to the program, even if
> +		 * the maps are not referenced directly. The functionality is
> +		 * similar to the BPF_PROG_BIND_MAP syscall, but maps can be
> +		 * used by the verifier during the program load. If provided,
> +		 * then the fd_array[0,...,fd_array_cnt-1] is expected to be
> +		 * continuous.
> +		 */
> +		__u32		fd_array_cnt;
>  	};
>  
>  	struct { /* anonymous struct used by BPF_OBJ_* commands */


