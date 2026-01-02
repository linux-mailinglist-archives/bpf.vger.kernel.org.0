Return-Path: <bpf+bounces-77666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABDCED92D
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 01:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE375300C6C0
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 00:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877B4126C03;
	Fri,  2 Jan 2026 00:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="W1l55DDW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6755249E5
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767313171; cv=none; b=KmueLSGWcEyMUO17y3LHeHerVzCw+73FnJwN2N8FhpVaZ7WDTy+r6ADt0pQfswx3bYCgfgqFsjgvpZjb0gN00r4BcjG2CDIX24B2OXvbOW9NKaBSxtVtN6kbm+U3VswxjvSUdwAQ/DKMpxFzejvxaquzHUH0MjXKFzMusOQbRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767313171; c=relaxed/simple;
	bh=7regkGSw7SgWjtKlQ72HMNjMuxIFjD/Rfo2Mz7UPTY0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=bKI964gvLz3Wp9Jbzx9VdUMdY2FAJ8rNAIxQCs4inIruIi2wjcxIcsEYVPNr/HFpe2HSmVp80bJnhO/+ac+xFl28uZJyVzPxDzVqLboWBHxTVBXIjtbd+G9YHhT/ieuMnAOJPQPVieE5vZWkmsAxYX6DBwsyc+Vz1HjV5AniFz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=W1l55DDW; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8bb6a27d3edso1207629385a.3
        for <bpf@vger.kernel.org>; Thu, 01 Jan 2026 16:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1767313167; x=1767917967; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4H7stON1JX4MZo5TmuwXlqIQB5O7lpToi3FWwOsJSo=;
        b=W1l55DDW1Pyjl3VmNUv+0krdsdRfZqXbSk0MUh97zC2GxIhQiuXpNfei/EoDNB7vVp
         ZBz876jkVbNhAo7gv7Xno3FrIkWZUsTvhu7hpbfEmdNAzsqemC8ZlOaZIMgpMpTnx0Jp
         QU0hU1AV62p5vBxVP7iyL+D7Tg9HDb2rMqS2RC5X0we6gLATAXL6HU7w5a+0pm2E3mPZ
         W0wpvWdibdkfpIZJG6sCgXrSp5+cwHag5z3OL54HMOR8um06mMlnlWwt4HB/6IX3w2f5
         EDnNGJU6MOWY6tsjn6bvNL4yeHgqh25dkO/uiNsrcCGbc7yIigqLsDWw/D2vGyuDE+VI
         Fngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767313167; x=1767917967;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q4H7stON1JX4MZo5TmuwXlqIQB5O7lpToi3FWwOsJSo=;
        b=b8pJHa6fxtRMe7lKps8JxJ1NPE44bhd4X4fHm/pwuY7ccV0pK6zvIb8a3EzrqMSZ8h
         R/lXmlU/lqVbrNTnnfFN7dsehl9XiDgZhZyPepC4fjnFuSLREeCKn5Epxx8Mzfx6NasB
         OADnz9bbjFtwMA+JD4pQSeHIQqt63PhVPeaemC4No5FtWlOMxHtP9wo8agJpf1aN7Kzl
         vHAWt6qGJ8gAOxxpuKPdY9O3/Yn8NW217pPd+sBsWYfpO/w4v9QXDQZuEH9TvOBvliB1
         XEI30Xa74AaGUXOUelkOhBRMe/7nV0drodF7W9gZ2UwoDlE1WJ2qggajCMBeDo8muYJS
         2G1A==
X-Forwarded-Encrypted: i=1; AJvYcCUigCQl7uSRiONJk3/VII2ChtZi6vnQG88UskC4QIHH3Fi/EQzRZQhfdFQ+RwPO86yitk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyNbpU9cghNuT+GEVF3KdlC1t4JIyFpeBvGM7hMPznYz7c8Re
	0zhd2+ll8HBnpr+EWXn7lX7waQAbJIF7cc0q1iOoKtUVNJmIjdLEZkqMD3iJEEZ5nEQ=
X-Gm-Gg: AY/fxX6KTmQaiX+PeGYusuePflZALgg7s1jHg4upuHY5l9hIjnrBfxEdCmJ8Wfl7U/S
	doGbLXAdCpRVnHSM0dxiERjTahGfUVkUvyGumX7Sa5We71Nz/e2VITLnpYVw0rH1Rl6AwYth3WT
	KY5PduQb6+ohr7Axky5mKD4dawTidJRIm3yiBjhtRCN+I4fffH7/ZR8jzXBgXtIdtSN18aS7mpW
	ZfBEwk6WvfieuJ0RCw0CNRFJ0bPxs+7TYcHeSWmrOvCpoJlQJcFbi15z6dJKyBQmU/XkQjpzHKK
	akkoCXpiPhAQsaCCPAjEcORNtOKQOuE4CScYev6JHGbE6rGw8AU+50hbc2iVDNsaiAVK229mijD
	3w0xPOZk6X9tV/bmeVJxvsQzDbm01JhchAWNwdiRAOFdV/VuCJW6oTiJV764A5wVEnCwtbGo1lR
	of6Ughush1ON4=
X-Google-Smtp-Source: AGHT+IGruK+R4XCDi3NsPLMjXjeL/lhVYMU/onUOjMSZcMxgMItRljXA2xxD8dEp7eGIrbd4PQoi+Q==
X-Received: by 2002:a05:620a:3188:b0:8b5:5a03:36b4 with SMTP id af79cd13be357-8c08fbc16a1mr5906972085a.71.1767313167381;
        Thu, 01 Jan 2026 16:19:27 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0967886d2sm3049698985a.10.2026.01.01.16.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 16:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Jan 2026 19:19:25 -0500
Message-Id: <DFDO8C5ED7YH.AAMHOWLANIUB@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2 3/9] bpf: Remove redundant KF_TRUSTED_ARGS
 flag from all kfuncs
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Puranjay Mohan" <puranjay12@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.20.1
References: <20251231171118.1174007-1-puranjay@kernel.org>
 <20251231171118.1174007-4-puranjay@kernel.org>
In-Reply-To: <20251231171118.1174007-4-puranjay@kernel.org>

On Wed Dec 31, 2025 at 12:08 PM EST, Puranjay Mohan wrote:
> Now that KF_TRUSTED_ARGS is the default for all kfuncs, remove the
> explicit KF_TRUSTED_ARGS flag from all kfunc definitions and remove the
> flag itself.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  fs/bpf_fs_kfuncs.c                            | 13 ++++++------
>  fs/verity/measure.c                           |  2 +-
>  include/linux/btf.h                           |  3 +--
>  kernel/bpf/arena.c                            |  6 +++---
>  kernel/bpf/cpumask.c                          |  2 +-
>  kernel/bpf/helpers.c                          | 20 +++++++++----------
>  kernel/bpf/map_iter.c                         |  2 +-
>  kernel/sched/ext.c                            |  8 ++++----
>  mm/bpf_memcontrol.c                           | 10 +++++-----
>  net/core/filter.c                             | 10 +++++-----
>  net/core/xdp.c                                |  2 +-
>  net/netfilter/nf_conntrack_bpf.c              |  8 ++++----
>  net/netfilter/nf_flow_table_bpf.c             |  2 +-
>  net/netfilter/nf_nat_bpf.c                    |  2 +-
>  net/sched/bpf_qdisc.c                         | 12 +++++------
>  .../selftests/bpf/test_kmods/bpf_testmod.c    | 20 +++++++++----------
>  16 files changed, 60 insertions(+), 62 deletions(-)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 5ace2511fec5..a15d31690e0b 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -359,14 +359,13 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup=
 *cgroup, const char *name__s
>  __bpf_kfunc_end_defs();
> =20
>  BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
> -BTF_ID_FLAGS(func, bpf_get_task_exe_file,
> -	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_get_task_exe_file, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
> -BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE | KF_TRUSTED_AR=
GS)
> +BTF_ID_FLAGS(func, bpf_path_d_path)
> +BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
> =20
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
> diff --git a/fs/verity/measure.c b/fs/verity/measure.c
> index 388734132f01..6a35623ebdf0 100644
> --- a/fs/verity/measure.c
> +++ b/fs/verity/measure.c
> @@ -162,7 +162,7 @@ __bpf_kfunc int bpf_get_fsverity_digest(struct file *=
file, struct bpf_dynptr *di
>  __bpf_kfunc_end_defs();
> =20
>  BTF_KFUNCS_START(fsverity_set_ids)
> -BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_get_fsverity_digest)
>  BTF_KFUNCS_END(fsverity_set_ids)
> =20
>  static int bpf_get_fsverity_digest_filter(const struct bpf_prog *prog, u=
32 kfunc_id)
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index f06976ffb63f..691f09784933 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -34,7 +34,7 @@
>   *
>   * And the following kfunc:
>   *
> - *	BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
> + *	BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE)
>   *
>   * All invocations to the kfunc must pass the unmodified, unwalked task:
>   *
> @@ -66,7 +66,6 @@
>   *	return 0;
>   * }
>   */
> -#define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arg=
uments */
>  #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
>  #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions *=
/
>  #define KF_RCU          (1 << 7) /* kfunc takes either rcu or trusted po=
inter arguments */
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 456ac989269d..2274319a95e6 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -890,9 +890,9 @@ __bpf_kfunc int bpf_arena_reserve_pages(void *p__map,=
 void *ptr__ign, u32 page_c
>  __bpf_kfunc_end_defs();
> =20
>  BTF_KFUNCS_START(arena_kfuncs)
> -BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_TRUSTED_ARGS | KF_ARENA_RET=
 | KF_ARENA_ARG2)
> -BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_TRUSTED_ARGS | KF_ARENA_ARG2=
)
> -BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_TRUSTED_ARGS | KF_ARENA_A=
RG2)
> +BTF_ID_FLAGS(func, bpf_arena_alloc_pages, KF_ARENA_RET | KF_ARENA_ARG2)
> +BTF_ID_FLAGS(func, bpf_arena_free_pages, KF_ARENA_ARG2)
> +BTF_ID_FLAGS(func, bpf_arena_reserve_pages, KF_ARENA_ARG2)
>  BTF_KFUNCS_END(arena_kfuncs)
> =20
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> index 9876c5fe6c2a..b8c805b4b06a 100644
> --- a/kernel/bpf/cpumask.c
> +++ b/kernel/bpf/cpumask.c
> @@ -477,7 +477,7 @@ __bpf_kfunc_end_defs();
>  BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
>  BTF_ID_FLAGS(func, bpf_cpumask_create, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_cpumask_release, KF_RELEASE)
> -BTF_ID_FLAGS(func, bpf_cpumask_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_cpumask_acquire, KF_ACQUIRE)
>  BTF_ID_FLAGS(func, bpf_cpumask_first, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_first_zero, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_cpumask_first_and, KF_RCU)
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index db72b96f9c8c..2c15f77c74db 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4427,7 +4427,7 @@ BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | =
KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_throw)
>  #ifdef CONFIG_BPF_EVENTS
> -BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_send_signal_task)
>  #endif
>  #ifdef CONFIG_KEYS
>  BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SL=
EEPABLE)
> @@ -4467,14 +4467,14 @@ BTF_ID_FLAGS(func, bpf_iter_task_vma_new, KF_ITER=
_NEW | KF_RCU)
>  BTF_ID_FLAGS(func, bpf_iter_task_vma_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_task_vma_destroy, KF_ITER_DESTROY)
>  #ifdef CONFIG_CGROUPS
> -BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
> -BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF_=
RCU_PROTECTED)
> +BTF_ID_FLAGS(func, bpf_iter_css_new, KF_ITER_NEW | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_css_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_css_destroy, KF_ITER_DESTROY)
>  #endif
> -BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS | KF=
_RCU_PROTECTED)
> +BTF_ID_FLAGS(func, bpf_iter_task_new, KF_ITER_NEW | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_task_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_task_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_dynptr_adjust)
> @@ -4510,8 +4510,8 @@ BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
>  BTF_ID_FLAGS(func, bpf_probe_read_kernel_str_dynptr)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRU=
STED_ARGS)
> -BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF=
_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE)
>  #endif
>  #ifdef CONFIG_DMA_SHARED_BUFFER
>  BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
> @@ -4536,10 +4536,10 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
>  #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>  BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>  #endif
> -BTF_ID_FLAGS(func, bpf_stream_vprintk_impl, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_dynptr_from_file, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_stream_vprintk_impl)
> +BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl)
> +BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_file)
>  BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
>  BTF_KFUNCS_END(common_btf_ids)
> =20
> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> index 9575314f40a6..261a03ea73d3 100644
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c
> @@ -214,7 +214,7 @@ __bpf_kfunc s64 bpf_map_sum_elem_count(const struct b=
pf_map *map)
>  __bpf_kfunc_end_defs();
> =20
>  BTF_KFUNCS_START(bpf_map_iter_kfunc_ids)
> -BTF_ID_FLAGS(func, bpf_map_sum_elem_count, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_map_sum_elem_count)
>  BTF_KFUNCS_END(bpf_map_iter_kfunc_ids)
> =20
>  static const struct btf_kfunc_id_set bpf_map_iter_kfunc_set =3D {
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 94164f2dec6d..fd5423428dde 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7229,9 +7229,9 @@ BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECT=
ED | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
> -BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_exit_bstr)
> +BTF_ID_FLAGS(func, scx_bpf_error_bstr)
> +BTF_ID_FLAGS(func, scx_bpf_dump_bstr)
>  BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
>  BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
> @@ -7250,7 +7250,7 @@ BTF_ID_FLAGS(func, scx_bpf_cpu_curr, KF_RET_NULL | =
KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
>  #endif
>  BTF_ID_FLAGS(func, scx_bpf_now)
> -BTF_ID_FLAGS(func, scx_bpf_events, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, scx_bpf_events)
>  BTF_KFUNCS_END(scx_kfunc_ids_any)
> =20
>  static const struct btf_kfunc_id_set scx_kfunc_set_any =3D {
> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index e8fa7f5855f9..716df49d7647 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c
> @@ -166,11 +166,11 @@ BTF_ID_FLAGS(func, bpf_get_root_mem_cgroup, KF_ACQU=
IRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL | KF_RCU=
)
>  BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
> =20
> -BTF_ID_FLAGS(func, bpf_mem_cgroup_vm_events, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_mem_cgroup_memory_events, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_mem_cgroup_usage, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_TRUSTED_ARGS | KF_SLEE=
PABLE)
> +BTF_ID_FLAGS(func, bpf_mem_cgroup_vm_events)
> +BTF_ID_FLAGS(func, bpf_mem_cgroup_memory_events)
> +BTF_ID_FLAGS(func, bpf_mem_cgroup_usage)
> +BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state)
> +BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_SLEEPABLE)
> =20
>  BTF_KFUNCS_END(bpf_memcontrol_kfuncs)
> =20
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 616e0520a0bb..d43df98e1ded 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12438,11 +12438,11 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff=
 *skb, u64 flags,
>  }
> =20
>  BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
> -BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_skb)
> =20
>  BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
> -BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
> =20
>  BTF_KFUNCS_START(bpf_kfunc_check_set_xdp)
> @@ -12455,11 +12455,11 @@ BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
> =20
>  BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
> -BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
> =20
>  BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
> -BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
> =20
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb =3D {
> @@ -12554,7 +12554,7 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_comm=
on *sock)
>  __bpf_kfunc_end_defs();
> =20
>  BTF_KFUNCS_START(bpf_sk_iter_kfunc_ids)
> -BTF_ID_FLAGS(func, bpf_sock_destroy, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_sock_destroy)
>  BTF_KFUNCS_END(bpf_sk_iter_kfunc_ids)
> =20
>  static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id=
)
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9100e160113a..fee6d080ee85 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -964,7 +964,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const st=
ruct xdp_md *ctx,
>  __bpf_kfunc_end_defs();
> =20
>  BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
> -#define XDP_METADATA_KFUNC(_, __, name, ___) BTF_ID_FLAGS(func, name, KF=
_TRUSTED_ARGS)
> +#define XDP_METADATA_KFUNC(_, __, name, ___) BTF_ID_FLAGS(func, name)
>  XDP_METADATA_KFUNC_xxx
>  #undef XDP_METADATA_KFUNC
>  BTF_KFUNCS_END(xdp_metadata_kfunc_ids)
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
> index a9f4b7d23fe0..a82d3388c0dd 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -518,10 +518,10 @@ BTF_ID_FLAGS(func, bpf_skb_ct_alloc, KF_ACQUIRE | K=
F_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_skb_ct_lookup, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_ct_insert_entry, KF_ACQUIRE | KF_RET_NULL | KF_RE=
LEASE)
>  BTF_ID_FLAGS(func, bpf_ct_release, KF_RELEASE)
> -BTF_ID_FLAGS(func, bpf_ct_set_timeout, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_ct_change_timeout, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_ct_set_status, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_ct_change_status, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_ct_set_timeout)
> +BTF_ID_FLAGS(func, bpf_ct_change_timeout)
> +BTF_ID_FLAGS(func, bpf_ct_set_status)
> +BTF_ID_FLAGS(func, bpf_ct_change_status)
>  BTF_KFUNCS_END(nf_ct_kfunc_set)
> =20
>  static const struct btf_kfunc_id_set nf_conntrack_kfunc_set =3D {
> diff --git a/net/netfilter/nf_flow_table_bpf.c b/net/netfilter/nf_flow_ta=
ble_bpf.c
> index 4a5f5195f2d2..cbd5b97a6329 100644
> --- a/net/netfilter/nf_flow_table_bpf.c
> +++ b/net/netfilter/nf_flow_table_bpf.c
> @@ -105,7 +105,7 @@ __diag_pop()
>  __bpf_kfunc_end_defs();
> =20
>  BTF_KFUNCS_START(nf_ft_kfunc_set)
> -BTF_ID_FLAGS(func, bpf_xdp_flow_lookup, KF_TRUSTED_ARGS | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_xdp_flow_lookup, KF_RET_NULL)
>  BTF_KFUNCS_END(nf_ft_kfunc_set)
> =20
>  static const struct btf_kfunc_id_set nf_flow_kfunc_set =3D {
> diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
> index 481be15609b1..f9dd85ccea01 100644
> --- a/net/netfilter/nf_nat_bpf.c
> +++ b/net/netfilter/nf_nat_bpf.c
> @@ -55,7 +55,7 @@ __bpf_kfunc int bpf_ct_set_nat_info(struct nf_conn___in=
it *nfct,
>  __bpf_kfunc_end_defs();
> =20
>  BTF_KFUNCS_START(nf_nat_kfunc_set)
> -BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_ct_set_nat_info)
>  BTF_KFUNCS_END(nf_nat_kfunc_set)
> =20
>  static const struct btf_kfunc_id_set nf_bpf_nat_kfunc_set =3D {
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index adcb618a2bfc..b9771788b9b3 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -271,14 +271,14 @@ __bpf_kfunc void bpf_qdisc_bstats_update(struct Qdi=
sc *sch, const struct sk_buff
>  __bpf_kfunc_end_defs();
> =20
>  BTF_KFUNCS_START(qdisc_kfunc_ids)
> -BTF_ID_FLAGS(func, bpf_skb_get_hash, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_skb_get_hash)
>  BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
> -BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_qdisc_init_prologue, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_qdisc_bstats_update, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
> +BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
> +BTF_ID_FLAGS(func, bpf_qdisc_init_prologue)
> +BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue)
> +BTF_ID_FLAGS(func, bpf_qdisc_bstats_update)
>  BTF_KFUNCS_END(qdisc_kfunc_ids)
> =20
>  BTF_SET_START(qdisc_common_kfunc_set)
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 90c4b1a51de6..1c41d03bd5a1 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -693,9 +693,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_dynptr_test)
>  BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_nonzero_offset_test, KF_ACQU=
IRE)
>  BTF_ID_FLAGS(func, bpf_kfunc_nested_acquire_zero_offset_test, KF_ACQUIRE=
)
>  BTF_ID_FLAGS(func, bpf_kfunc_nested_release_test, KF_RELEASE)
> -BTF_ID_FLAGS(func, bpf_kfunc_trusted_vma_test, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_kfunc_trusted_task_test, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_kfunc_trusted_num_test, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_kfunc_trusted_vma_test)
> +BTF_ID_FLAGS(func, bpf_kfunc_trusted_task_test)
> +BTF_ID_FLAGS(func, bpf_kfunc_trusted_num_test)
>  BTF_ID_FLAGS(func, bpf_kfunc_rcu_task_test, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_kfunc_ret_rcu_test, KF_RET_NULL | KF_RCU_PROTECTE=
D)
>  BTF_ID_FLAGS(func, bpf_kfunc_ret_rcu_test_nostruct, KF_RET_NULL | KF_RCU=
_PROTECTED)
> @@ -1158,7 +1158,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_pass2)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail1)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail2)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
> -BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS | KF_RCU)
> +BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
> @@ -1172,12 +1172,12 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_sendmsg,=
 KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_sock_sendmsg, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getsockname, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_kfunc_call_kernel_getpeername, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_TRUSTED_ARGS | KF_=
SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_TRUSTED_ARGS | KF_=
SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_TRUSTED_ARGS |=
 KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1, KF_TRUSTED_ARGS)
> -BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_impl, KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_prologue, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_epilogue, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_kfunc_st_ops_test_pro_epilogue, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_kfunc_st_ops_inc10)
> +BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1)
> +BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_impl)
>  BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
> =20
>  static int bpf_testmod_ops_init(struct btf *btf)


