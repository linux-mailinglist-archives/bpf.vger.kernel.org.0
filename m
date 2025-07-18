Return-Path: <bpf+bounces-63734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0E8B0A79C
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D917BE81C
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C312E3397;
	Fri, 18 Jul 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WgEVcxbx"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA2C2DF3C6;
	Fri, 18 Jul 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852725; cv=none; b=lSWkQ68yZpQ/nAZy0N9GRHdwZmXKojqb7ZznWF/JUH8LFWTX1FPpvJhfBAmASf74aXrHfhCbtE9AicQ5p3sQd4Sr8J7LRzDD9lS6xb6MidkzbldEf4g5HWtGOVoj3hqVjAlznP5WkJP3KNPu5dT0+f65dDxS462MvSn8EDWdQjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852725; c=relaxed/simple;
	bh=IGmyPMmkdO6fWAdCDA5Nezxa2nOwvHC/muUPYOvutWI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qs7GFd1AXrcBxIDuK8uNBb4Ya4GuQBp5/YNr6OSAl/Sa7qIk8S6Lv1Az+U5/nrXj77mmzi+Efwe3HNWcUzlqz0VUsZoNyvLJoGU8s+/k9sY6Jxc05YxvpErJ21CEcqYZxaAthN74gH0H2wG056M9HSubGOUJ4CfQ4xzAH4GcGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WgEVcxbx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id DF3D5211FEB6;
	Fri, 18 Jul 2025 08:32:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF3D5211FEB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752852723;
	bh=Hbk9hC+nTouU9H02cQbs8WLgepcQKbWKNlcsWiirmIA=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=WgEVcxbxxHRAF6tXAFJ2J/o973BZY/RQ1S47XctjRs30rj5VP2fMgJDZoEyKJquIK
	 +cH76RoEa+3HzV97Pm4k3MSocWMT/0bBNtd/fPMM92w2PIPTCgunlDMtngeGxmUQLB
	 rARhPubU/lEsU2PYj02swi+l2owoCNiCImHIGUkA=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn"
 <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, John Johansen
 <john.johansen@canonical.com>, Christian =?utf-8?Q?G=C3=B6ttsche?=
 <cgzones@googlemail.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
 bpf@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH] lsm,selinux: Add LSM blob support for BPF objects
In-Reply-To: <f1816e37-56f5-43de-8a52-129a2952c355@schaufler-ca.com>
References: <20250715222655.705241-1-bboscaccy@linux.microsoft.com>
 <f1816e37-56f5-43de-8a52-129a2952c355@schaufler-ca.com>
Date: Fri, 18 Jul 2025 08:32:00 -0700
Message-ID: <87bjph4irz.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Casey Schaufler <casey@schaufler-ca.com> writes:

> On 7/15/2025 3:25 PM, Blaise Boscaccy wrote:
>> This patch introduces LSM blob support for BPF maps, programs, and
>> tokens to enable LSM stacking and multiplexing of LSM modules that
>> govern BPF objects. Additionally, the existing BPF hooks used by
>> SELinux have been updated to utilize the new blob infrastructure,
>> removing the assumption of exclusive ownership of the security
>> pointer.
>>
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
>>  include/linux/lsm_hooks.h         |   3 +
>>  security/security.c               | 120 +++++++++++++++++++++++++++++-
>>  security/selinux/hooks.c          |  56 +++-----------
>>  security/selinux/include/objsec.h |  17 +++++
>>  4 files changed, 147 insertions(+), 49 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 090d1d3e19fed..79ec5a2bdcca7 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -116,6 +116,9 @@ struct lsm_blob_sizes {
>>  	int lbs_xattr_count; /* number of xattr slots in new_xattrs array */
>>  	int lbs_tun_dev;
>>  	int lbs_bdev;
>> +	int lbs_bpf_map;
>> +	int lbs_bpf_prog;
>> +	int lbs_bpf_token;
>>  };
>>  
>>  /*
>> diff --git a/security/security.c b/security/security.c
>> index 596d418185773..8c413b84f33db 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -283,6 +283,9 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>>  	lsm_set_blob_size(&needed->lbs_xattr_count,
>>  			  &blob_sizes.lbs_xattr_count);
>>  	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
>> +	lsm_set_blob_size(&needed->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
>> +	lsm_set_blob_size(&needed->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
>> +	lsm_set_blob_size(&needed->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
>>  }
>>  
>>  /* Prepare LSM for initialization. */
>> @@ -480,6 +483,9 @@ static void __init ordered_lsm_init(void)
>>  	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
>>  	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
>>  	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
>> +	init_debug("bpf map blob size    = %d\n", blob_sizes.lbs_bpf_map);
>> +	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
>> +	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
>>  
>>  	/*
>>  	 * Create any kmem_caches needed for blobs
>> @@ -835,6 +841,72 @@ static int lsm_bdev_alloc(struct block_device *bdev)
>>  	return 0;
>>  }
>>  
>> +/**
>> + * lsm_bpf_map_alloc - allocate a composite bpf_map blob
>> + * @map: the bpf_map that needs a blob
>> + *
>> + * Allocate the bpf_map blob for all the modules
>> + *
>> + * Returns 0, or -ENOMEM if memory can't be allocated.
>> + */
>> +static int lsm_bpf_map_alloc(struct bpf_map *map)
>> +{
>> +	if (blob_sizes.lbs_bpf_map == 0) {
>> +		map->security = NULL;
>> +		return 0;
>> +	}
>> +
>> +	map->security = kzalloc(blob_sizes.lbs_bpf_map, GFP_KERNEL);
>
> Some of the blobs use kmem_cache_alloc(). You should consider if that
> might be right for you.
>

I looked into that, allocation numbers for this are going to
very low in volume compared to something like inodes. I think we are
okay for the time being using kzalloc. If this turns out to be a
bottleneck, we can totally switch to that. 

-blaise

>> +	if (!map->security)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * lsm_bpf_prog_alloc - allocate a composite bpf_prog blob
>> + * @prog: the bpf_prog that needs a blob
>> + *
>> + * Allocate the bpf_prog blob for all the modules
>> + *
>> + * Returns 0, or -ENOMEM if memory can't be allocated.
>> + */
>> +static int lsm_bpf_prog_alloc(struct bpf_prog *prog)
>> +{
>> +	if (blob_sizes.lbs_bpf_prog == 0) {
>> +		prog->aux->security = NULL;
>> +		return 0;
>> +	}
>> +
>> +	prog->aux->security = kzalloc(blob_sizes.lbs_bpf_prog, GFP_KERNEL);
>> +	if (!prog->aux->security)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * lsm_bpf_token_alloc - allocate a composite bpf_token blob
>> + * @token: the bpf_token that needs a blob
>> + *
>> + * Allocate the bpf_token blob for all the modules
>> + *
>> + * Returns 0, or -ENOMEM if memory can't be allocated.
>> + */
>> +static int lsm_bpf_token_alloc(struct bpf_token *token)
>> +{
>> +	if (blob_sizes.lbs_bpf_token == 0) {
>> +		token->security = NULL;
>> +		return 0;
>> +	}
>> +
>> +	token->security = kzalloc(blob_sizes.lbs_bpf_token, GFP_KERNEL);
>> +	if (!token->security)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * lsm_early_task - during initialization allocate a composite task blob
>>   * @task: the task that needs a blob
>> @@ -5684,7 +5756,16 @@ int security_bpf_prog(struct bpf_prog *prog)
>>  int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>>  			    struct bpf_token *token, bool kernel)
>>  {
>> -	return call_int_hook(bpf_map_create, map, attr, token, kernel);
>> +	int rc = 0;
>> +
>> +	rc = lsm_bpf_map_alloc(map);
>> +	if (unlikely(rc))
>> +		return rc;
>> +
>> +	rc = call_int_hook(bpf_map_create, map, attr, token, kernel);
>> +	if (unlikely(rc))
>> +		security_bpf_map_free(map);
>> +	return rc;
>>  }
>>  
>>  /**
>> @@ -5703,7 +5784,16 @@ int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>>  int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>>  			   struct bpf_token *token, bool kernel)
>>  {
>> -	return call_int_hook(bpf_prog_load, prog, attr, token, kernel);
>> +	int rc = 0;
>> +
>> +	rc = lsm_bpf_prog_alloc(prog);
>> +	if (unlikely(rc))
>> +		return rc;
>> +
>> +	rc = call_int_hook(bpf_prog_load, prog, attr, token, kernel);
>> +	if (unlikely(rc))
>> +		security_bpf_prog_free(prog);
>> +	return rc;
>>  }
>>  
>>  /**
>> @@ -5720,7 +5810,16 @@ int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>>  int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
>>  			      const struct path *path)
>>  {
>> -	return call_int_hook(bpf_token_create, token, attr, path);
>> +	int rc = 0;
>> +
>> +	rc = lsm_bpf_token_alloc(token);
>> +	if (unlikely(rc))
>> +		return rc;
>> +
>> +	rc = call_int_hook(bpf_token_create, token, attr, path);
>> +	if (unlikely(rc))
>> +		security_bpf_token_free(token);
>> +	return rc;
>>  }
>>  
>>  /**
>> @@ -5763,7 +5862,12 @@ int security_bpf_token_capable(const struct bpf_token *token, int cap)
>>   */
>>  void security_bpf_map_free(struct bpf_map *map)
>>  {
>> +	if (!map->security)
>> +		return;
>> +
>>  	call_void_hook(bpf_map_free, map);
>> +	kfree(map->security);
>> +	map->security = NULL;
>>  }
>>  
>>  /**
>> @@ -5774,7 +5878,12 @@ void security_bpf_map_free(struct bpf_map *map)
>>   */
>>  void security_bpf_prog_free(struct bpf_prog *prog)
>>  {
>> +	if (!prog->aux->security)
>> +		return;
>> +
>>  	call_void_hook(bpf_prog_free, prog);
>> +	kfree(prog->aux->security);
>> +	prog->aux->security = NULL;
>>  }
>>  
>>  /**
>> @@ -5785,7 +5894,12 @@ void security_bpf_prog_free(struct bpf_prog *prog)
>>   */
>>  void security_bpf_token_free(struct bpf_token *token)
>>  {
>> +	if (!token->security)
>> +		return;
>> +
>>  	call_void_hook(bpf_token_free, token);
>> +	kfree(token->security);
>> +	token->security = NULL;
>>  }
>>  #endif /* CONFIG_BPF_SYSCALL */
>>  
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 595ceb314aeb3..8052fb5fafc4d 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -7038,14 +7038,14 @@ static int bpf_fd_pass(const struct file *file, u32 sid)
>>  
>>  	if (file->f_op == &bpf_map_fops) {
>>  		map = file->private_data;
>> -		bpfsec = map->security;
>> +		bpfsec = selinux_bpf_map_security(map);
>>  		ret = avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
>>  				   bpf_map_fmode_to_av(file->f_mode), NULL);
>>  		if (ret)
>>  			return ret;
>>  	} else if (file->f_op == &bpf_prog_fops) {
>>  		prog = file->private_data;
>> -		bpfsec = prog->aux->security;
>> +		bpfsec = selinux_bpf_prog_security(prog);
>>  		ret = avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
>>  				   BPF__PROG_RUN, NULL);
>>  		if (ret)
>> @@ -7059,7 +7059,7 @@ static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
>>  	u32 sid = current_sid();
>>  	struct bpf_security_struct *bpfsec;
>>  
>> -	bpfsec = map->security;
>> +	bpfsec = selinux_bpf_map_security(map);
>>  	return avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
>>  			    bpf_map_fmode_to_av(fmode), NULL);
>>  }
>> @@ -7069,7 +7069,7 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
>>  	u32 sid = current_sid();
>>  	struct bpf_security_struct *bpfsec;
>>  
>> -	bpfsec = prog->aux->security;
>> +	bpfsec = selinux_bpf_prog_security(prog);
>>  	return avc_has_perm(sid, bpfsec->sid, SECCLASS_BPF,
>>  			    BPF__PROG_RUN, NULL);
>>  }
>> @@ -7079,69 +7079,33 @@ static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
>>  {
>>  	struct bpf_security_struct *bpfsec;
>>  
>> -	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>> -	if (!bpfsec)
>> -		return -ENOMEM;
>> -
>> +	bpfsec = selinux_bpf_map_security(map);
>>  	bpfsec->sid = current_sid();
>> -	map->security = bpfsec;
>>  
>>  	return 0;
>>  }
>>  
>> -static void selinux_bpf_map_free(struct bpf_map *map)
>> -{
>> -	struct bpf_security_struct *bpfsec = map->security;
>> -
>> -	map->security = NULL;
>> -	kfree(bpfsec);
>> -}
>> -
>>  static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
>>  				 struct bpf_token *token, bool kernel)
>>  {
>>  	struct bpf_security_struct *bpfsec;
>>  
>> -	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>> -	if (!bpfsec)
>> -		return -ENOMEM;
>> -
>> +	bpfsec = selinux_bpf_prog_security(prog);
>>  	bpfsec->sid = current_sid();
>> -	prog->aux->security = bpfsec;
>>  
>>  	return 0;
>>  }
>>  
>> -static void selinux_bpf_prog_free(struct bpf_prog *prog)
>> -{
>> -	struct bpf_security_struct *bpfsec = prog->aux->security;
>> -
>> -	prog->aux->security = NULL;
>> -	kfree(bpfsec);
>> -}
>> -
>>  static int selinux_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
>>  				    const struct path *path)
>>  {
>>  	struct bpf_security_struct *bpfsec;
>>  
>> -	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>> -	if (!bpfsec)
>> -		return -ENOMEM;
>> -
>> +	bpfsec = selinux_bpf_token_security(token);
>>  	bpfsec->sid = current_sid();
>> -	token->security = bpfsec;
>>  
>>  	return 0;
>>  }
>> -
>> -static void selinux_bpf_token_free(struct bpf_token *token)
>> -{
>> -	struct bpf_security_struct *bpfsec = token->security;
>> -
>> -	token->security = NULL;
>> -	kfree(bpfsec);
>> -}
>>  #endif
>>  
>>  struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>> @@ -7159,6 +7123,9 @@ struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>>  	.lbs_xattr_count = SELINUX_INODE_INIT_XATTRS,
>>  	.lbs_tun_dev = sizeof(struct tun_security_struct),
>>  	.lbs_ib = sizeof(struct ib_security_struct),
>> +	.lbs_bpf_map = sizeof(struct bpf_security_struct),
>> +	.lbs_bpf_prog = sizeof(struct bpf_security_struct),
>> +	.lbs_bpf_token = sizeof(struct bpf_security_struct),
>>  };
>>  
>>  #ifdef CONFIG_PERF_EVENTS
>> @@ -7510,9 +7477,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>>  	LSM_HOOK_INIT(bpf, selinux_bpf),
>>  	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
>>  	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
>> -	LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
>> -	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
>> -	LSM_HOOK_INIT(bpf_token_free, selinux_bpf_token_free),
>>  #endif
>>  
>>  #ifdef CONFIG_PERF_EVENTS
>> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
>> index 6ee7dc4dfd6e0..9f935ed9a761f 100644
>> --- a/security/selinux/include/objsec.h
>> +++ b/security/selinux/include/objsec.h
>> @@ -26,6 +26,7 @@
>>  #include <linux/lsm_hooks.h>
>>  #include <linux/msg.h>
>>  #include <net/net_namespace.h>
>> +#include <linux/bpf.h>
>>  #include "flask.h"
>>  #include "avc.h"
>>  
>> @@ -237,4 +238,20 @@ selinux_perf_event(void *perf_event)
>>  	return perf_event + selinux_blob_sizes.lbs_perf_event;
>>  }
>>  
>> +#ifdef CONFIG_BPF_SYSCALL
>> +static inline struct bpf_security_struct *selinux_bpf_map_security(struct bpf_map *map)
>> +{
>> +	return map->security + selinux_blob_sizes.lbs_bpf_map;
>> +}
>> +
>> +static inline struct bpf_security_struct *selinux_bpf_prog_security(struct bpf_prog *prog)
>> +{
>> +	return prog->aux->security + selinux_blob_sizes.lbs_bpf_prog;
>> +}
>> +
>> +static inline struct bpf_security_struct *selinux_bpf_token_security(struct bpf_token *token)
>> +{
>> +	return token->security + selinux_blob_sizes.lbs_bpf_token;
>> +}
>> +#endif /* CONFIG_BPF_SYSCALL */
>>  #endif /* _SELINUX_OBJSEC_H_ */

