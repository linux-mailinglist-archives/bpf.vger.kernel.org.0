Return-Path: <bpf+bounces-73106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF6C233A7
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 05:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7364C1889696
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 04:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBC299928;
	Fri, 31 Oct 2025 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMvOi8eh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE96F50F;
	Fri, 31 Oct 2025 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761883263; cv=none; b=qFeShJ321aDvi3QhgBQxvJ0GSwkylvWiTz3u2YrhkKGrVgoqVgnSk0psfOKrwRvMMobMX1xuxBDy9x7ZPgh1sB2B5K3By7y7HO4mLdJLA/0qgHqp4L0nMLxZveNC5VEmwuG1SPtBHCBoyWnvnFUr5jNCFAdbO+MWfNjGRpy2nps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761883263; c=relaxed/simple;
	bh=OY8xTeGL0F4AxIWU4k4qDONZ/b2HpjqhvNdcy2uziXk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kVf5y1Xt82ZhvG4Wizh3e/C/UZoSJM/MqBHS9wvk9XWzu7B7B8PiakSX3v9CNUS6jtra7BQIfjGQPcfCus/WNw+1qlK+AqszKBuJPZ4lYk83b3Wve6FCDjx27HryVwzyHjnjCX4ET/wF58EDO0nW8+2KZjsozMQkKx+sq7QJ6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMvOi8eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46920C4CEE7;
	Fri, 31 Oct 2025 04:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761883262;
	bh=OY8xTeGL0F4AxIWU4k4qDONZ/b2HpjqhvNdcy2uziXk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=cMvOi8ehMKhVC55R/LsNdKmbGa7lDvRsZ0m9MVOFVDHbuy00i5a62/FkQpJhHoyHq
	 msx9Gp1grVDpOQcDlmNAlyVhX2hWBdB/M69Tog0ESczAOaIj5QYFm6hbtooYPz3M80
	 wD3/Q2YlaiAhRvnVwI8at/sFi1FsQ9O8k0/MmEXi2ONqxu+7iy903m2fzP4asSNmo0
	 fMH0FEbgzx77xk5LsXDD8ofOEA2RgUpOUL5dcKLFNG8WKobCLv91Ut54mS8rvoz+w3
	 i6d/vSfA3Pu9ovyu8eShtfu+6ayZVKjEYAE6GKJWH00fJiq5gVXFL/Q1QLfUHa8jCG
	 A7f9v51rRy2YQ==
Content-Type: multipart/mixed; boundary="===============8639568991618062134=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <554b5b314ffd7eb00be58d5997d44c7c4986895ad28776a87a9d6a2bf1c0765c@mail.kernel.org>
In-Reply-To: <20251031032627.1414462-2-jianyungao89@gmail.com>
References: <20251031032627.1414462-2-jianyungao89@gmail.com>
Subject: Re: [PATCH 1/5] libbpf: Add doxygen documentation for bpf_map_* APIs in bpf.h
From: bot+bpf-ci@kernel.org
To: jianyungao89@gmail.com,bpf@vger.kernel.org
Cc: jianyungao89@gmail.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Oct 2025 04:01:02 +0000 (UTC)

--===============8639568991618062134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


```
commit 4da02b18e2168885350f3935b5ce2f1f52c850ba
Author: Jianyun Gao <jianyungao89@gmail.com>

libbpf: Add doxygen documentation for bpf_map_* APIs in bpf.h

This commit adds Doxygen documentation for 13 bpf_map_* API functions in
the libbpf user-space library header.

> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index e983a3e40..bcb303d95 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h

[ ... ]

> @@ -151,19 +202,452 @@ struct bpf_btf_load_opts {
>  LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
>  			    struct bpf_btf_load_opts *opts);
>
> +/**
> + * @brief Update or insert an element in a BPF map.
> + *
> + * Attempts to store the value referenced by @p value into the BPF map
> + * identified by @p fd under the key referenced by @p key. The semantics
> + * of the operation are controlled by @p flags:

[ ... ]

> + * @return 0 on success; -1 on failure with errno set appropriately.
> + *
> + * Possible errno values include (not exhaustive):
> + *   - E2BIG:      Key or value size exceeds map definition.
> + *   - EINVAL:     Invalid map fd, flags, or unsupported operation for map type.
> + *   - EBADF:      @p fd is not a valid BPF map descriptor.
> + *   - ENOENT:     Key does not exist (with BPF_EXIST).
> + *   - EEXIST:     Key already exists (with BPF_NOEXIST).
> + *   - ENOMEM:     Kernel memory allocation failure.
> + *   - EPERM/EACCES: Insufficient privileges or rejected by security policy.
> + *   - ENOSPC:     Map at capacity (for maps with a max entries limit).
> + *
> + */
>  LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void *value,
>  				   __u64 flags);

Is the documented return value correct? The implementation uses
libbpf_err_errno() which returns negative errno values directly on
failure (e.g., -EINVAL, -ENOENT), not -1 with errno set. Looking at
bpf_map_update_elem() in bpf.c:

  int bpf_map_update_elem(int fd, const void *key, const void *value,
                          __u64 flags)
  {
      ...
      ret = sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, attr_sz);
      return libbpf_err_errno(ret);
  }

And libbpf_err_errno() in libbpf_internal.h:

  static inline int libbpf_err_errno(int ret)
  {
      return ret < 0 ? -errno : ret;
  }

So when syscall() returns -1, libbpf_err_errno() converts this to
-errno. Should the documentation state "negative error code on failure"
instead of "-1 on failure with errno set"?

For comparison, the existing batch operation docs in the same file
correctly document: "@return 0, on success; negative error code,
otherwise (errno is also set to..."

> +/**
> + * @brief Look up an element in a BPF map by key.

[ ... ]

> + * @return 0 on success (value populated),
> + *         -1 on failure with errno set appropriately:
> + *         - ENOENT: The key does not exist in the map.

The same return value documentation issue appears in
bpf_map_lookup_elem(). The implementation uses libbpf_err_errno() so it
returns negative errno, not -1.

> +/**
> + * @brief Look up (read) a value stored in a BPF map.

[ ... ]

> + * @return 0 on success; -1 on failure with errno set appropriately:
> + *         - ENOENT: No element with the specified key exists.

Same issue in bpf_map_lookup_elem_flags() - should document negative
errno return, not -1.

> +/**
> + * @brief Atomically look up and delete a single element from a BPF map.

[ ... ]

> + * @return 0 on success (value copied and element deleted);
> + *         -1 on failure with errno set:
> + *         - ENOENT: Key not found in the map.

Same issue in bpf_map_lookup_and_delete_elem() - returns negative errno.

> +/**
> + * @brief Atomically look up and delete an element from a BPF map with extra flags.

[ ... ]

> + * @return 0 on success; -1 on failure with errno set:
> + *         - ENOENT: Key not found.

Same issue in bpf_map_lookup_and_delete_elem_flags().

> +/**
> + * @brief Delete (remove) a single element from a BPF map.

[ ... ]

> + * @return 0 on success; -1 on failure with errno set appropriately.
> + *
> + */
>  LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);

Same issue in bpf_map_delete_elem().

> +/**
> + * @brief Delete an element from a BPF map with optional flags.

[ ... ]

> + * @return 0 on success; -1 on failure with errno set:
> + *         - ENOENT: Key not found.

Same issue in bpf_map_delete_elem_flags().

> +/**
> + * @brief Iterate over keys in a BPF map by retrieving the key that follows a given key.

[ ... ]

> + * @return 0 on success (next key stored in @p next_key);
> + *         -1 on failure with errno set:
> + *           - ENOENT: No further keys (end of iteration) or map is empty (when @p key is NULL).

Same issue in bpf_map_get_next_key().

All eight of these functions consistently return negative errno values
via libbpf_err_errno(), but the documentation states they return -1 with
errno set (the traditional C API pattern). This creates inconsistency
with the existing batch operation documentation and could mislead users
about proper error handling.


```

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

In-Reply-To-Subject: `libbpf: Add doxygen documentation for bpf_map_* APIs in bpf.h`
CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18961981609

--===============8639568991618062134==--

