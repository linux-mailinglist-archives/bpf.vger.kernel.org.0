Return-Path: <bpf+bounces-28410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6368B9194
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 00:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9532B1C233D7
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F40165FD5;
	Wed,  1 May 2024 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sli4VA5V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E41C68D
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714601708; cv=none; b=h52WwJoOpq7XIcUNiTK5YlEVM4I3tkSILYEDQxLe0blKxerpQ2Ht7b+5A2G0haW6VjA/F0JtxYPDExYxGkfE6u9aHRYxBaJHlMsMSBKSfYOl9YYXTc9JCy8336nmE1VOuWlwOQSTsUGPBUbDwKliWsaCdMpAWMyD02C4sb58Qp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714601708; c=relaxed/simple;
	bh=jgJ5aKB1dJACxBrG0QmkiESwbiVmHMRrDkbnjZji4S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLt8I16nhSBWphYl1N+fZ4cDMfOrGOziCsPtsyuyFyqFUENmg46WHmoXA0TBesNg4R1QFkO9N1KMMMAfogKH7sDne59MHvg+XwGhZ5bzlUw1tjf7+E+BZFSnb7sKZjxdAlfmf7Jt17s1zRTYqPwvWkVP3Rysl/3zKu+7VHlQ5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sli4VA5V; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23d477a1a4fso1012465fac.3
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714601706; x=1715206506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FvflbsUK2ZexKc2nW+EVxF8DUFno02sla37rz/KAyc=;
        b=Sli4VA5VelMFRcSr1lPz1ZdKW2Sf1tlzX66xoWlEdiaKotEaOS8fmlF9jfywk9wxzF
         j7iaIs2mTfPRUmkQWc+RDAS8jqZcwlR1PokOIAVHaEBcPlG+l4RuO+Zlktw8BJPhwzAm
         PDh2fZvXlo3VgeFelqUSyBgxnT/5Se9VNoito3Ur/nk6q8Gi/yqWOVGJoYeV890DizaD
         ylWKzccsEGf5OAM861KIlvziH5efJRFIMVrndlIAKFo8sio9reZbta8Fz/VLFs01Bx4g
         jpK5jM89b/kJ6pRbd37Bz3bNtTIW9RSNe/Ve1SY3IEue6azPcZCK+kIaQwkC99nIRZu7
         p0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714601706; x=1715206506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FvflbsUK2ZexKc2nW+EVxF8DUFno02sla37rz/KAyc=;
        b=jFek22DKgBa7W7wXLlbLiXqbALHRPy2NKsbdMXkVQC36MZ4BFSJ+ZdCnomNQMS/BdV
         zRochh4cd5BJwpkI39wY+uYib6kss3pqlXaaZJXY0ztFOZWWHEMAyrc9KRHpNXnTyyjJ
         MC+p1+kfhKFucnH7L6kYQvtlDvESqoNNlLMnNPzo4HKrQXgTENv8qJSK/NKxqeIYdK+2
         473KAf3olmYizFD6fjV5O+Mvaq1FTUedfaVCv7Kxiix3sG0ymJoudf2XA+zanUnIo4E+
         MT0H+d/YSLHSsnamaKTYHFqVzRddFj0ddXnp/+ISoxw2bi/WmnWGQoOSFs91P43y7uHR
         KS5w==
X-Gm-Message-State: AOJu0Yyx0Tpd0MXDGIbB/NmdVor6nmznlTGEupvTYw3+VBVsUVjOampN
	WTnzHraYumC99Y9wlTpi1UxZ/gj9xrRjMMWDqgZ/YWOF9/eRv3AA
X-Google-Smtp-Source: AGHT+IHQ9NKwJEoH3AAZ/j+ErU6Digko0nznfTwNEswdwZS8cbvGD4Kg4Ge+oUr/GRlIizDBEqbIXA==
X-Received: by 2002:a05:6870:a70d:b0:23c:3afb:eceb with SMTP id g13-20020a056870a70d00b0023c3afbecebmr375935oam.1.1714601706115;
        Wed, 01 May 2024 15:15:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:22b9:2301:860f:eff6? ([2600:1700:6cf8:1240:22b9:2301:860f:eff6])
        by smtp.gmail.com with ESMTPSA id lu11-20020a056871430b00b00239541760e2sm5320715oab.41.2024.05.01.15.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 15:15:05 -0700 (PDT)
Message-ID: <23f3dddd-b354-40a4-9b63-81d9e6649a3e@gmail.com>
Date: Wed, 1 May 2024 15:15:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/6] bpf: provide a function to unregister
 struct_ops objects from consumers.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-4-thinker.li@gmail.com>
 <f287c62f-628f-4201-ba34-03a7193212d8@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <f287c62f-628f-4201-ba34-03a7193212d8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/1/24 11:48, Martin KaFai Lau wrote:
> On 4/29/24 2:36 PM, Kui-Feng Lee wrote:
>> +/* Called from the subsystem that consume the struct_ops.
>> + *
>> + * The caller should protected this function by holding 
>> rcu_read_lock() to
>> + * ensure "data" is valid. However, this function may unlock rcu
>> + * temporarily. The caller should not rely on the preceding 
>> rcu_read_lock()
>> + * after returning from this function.
> 
> This temporarily losing rcu_read_lock protection is error prone. The 
> caller should do the inc_not_zero() instead if it is needed.
> 
> I feel the approach in patch 1 and 3 is a little box-ed in by the 
> earlier tcp-cc usage that tried to fit into the kernel module reg/unreg 
> paradigm and hide as much bpf details as possible from tcp-cc. This is 
> not necessarily true now for other subsystem which has bpf struct_ops 
> from day one.
> 
> The epoll detach notification is link only. Can this kernel side 
> specific unreg be limited to struct_ops link only? During reg, a rcu 
> protected link could be passed to the subsystem. That subsystem becomes 
> a kernel user of the bpf link and it can call link_detach(link) to 
> detach. Pseudo code:
> 
> struct link __rcu *link;
> 
> rcu_read_lock();
> ref_link = rcu_dereference(link)
> if (ref_link)
>      ref_link = bpf_link_inc_not_zero(ref_link);
> rcu_read_unlock();
> 
> if (!IS_ERR_OR_NULL(ref_link)) {
>      bpf_struct_ops_map_link_detach(ref_link);
>      bpf_link_put(ref_link);
> }


Since not every struct_ops map has a link, we need a callback in additional
to ops->reg to register links with subsystems. If the callback is
ops->reg_link, struct_ops will call ops->reg_link if a subsystem provide
it and the map is registered through a link, or it should call ops->reg.

> 
>> + *
>> + * Return true if unreg() success. If a call fails, it means some other
>> + * task has unrgistered or is unregistering the same object.
>> + */
>> +bool bpf_struct_ops_kvalue_unreg(void *data)
>> +{
>> +    struct bpf_struct_ops_map *st_map =
>> +        container_of(data, struct bpf_struct_ops_map, kvalue.data);
>> +    enum bpf_struct_ops_state prev_state;
>> +    struct bpf_struct_ops_link *st_link;
>> +    bool ret = false;
>> +
>> +    /* The st_map and st_link should be protected by rcu_read_lock(),
>> +     * or they may have been free when we try to increase their
>> +     * refcount.
>> +     */
>> +    if (IS_ERR(bpf_map_inc_not_zero(&st_map->map)))
>> +        /* The map is already gone */
>> +        return false;
>> +
>> +    prev_state = cmpxchg(&st_map->kvalue.common.state,
>> +                 BPF_STRUCT_OPS_STATE_INUSE,
>> +                 BPF_STRUCT_OPS_STATE_TOBEFREE);
>> +    if (prev_state == BPF_STRUCT_OPS_STATE_INUSE) {
>> +        st_map->st_ops_desc->st_ops->unreg(data);
>> +        /* Pair with bpf_map_inc() for reg() */
>> +        bpf_map_put(&st_map->map);
>> +        /* Pair with bpf_map_inc_not_zero() above */
>> +        bpf_map_put(&st_map->map);
>> +        return true;
>> +    }
>> +    if (prev_state != BPF_STRUCT_OPS_STATE_READY)
>> +        goto fail;
>> +
>> +    /* With BPF_F_LINK */
>> +
>> +    st_link = rcu_dereference(st_map->attached);
>> +    if (!st_link || !bpf_link_inc_not_zero(&st_link->link))
>> +        /* The map is on the way to unregister */
>> +        goto fail;
>> +
>> +    rcu_read_unlock();
>> +    mutex_lock(&update_mutex);
>> +
>> +    if (rcu_dereference_protected(st_link->map, true) != &st_map->map)
>> +        /* The map should be unregistered already or on the way to
>> +         * be unregistered.
>> +         */
>> +        goto fail_unlock;
>> +
>> +    st_map->st_ops_desc->st_ops->unreg(data);
>> +
>> +    map_attached_null(st_map);
>> +    rcu_assign_pointer(st_link->map, NULL);
>> +    /* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
>> +     * bpf_map_inc() in bpf_struct_ops_map_link_update().
>> +     */
>> +    bpf_map_put(&st_map->map);
>> +
>> +    ret = true;
>> +
>> +fail_unlock:
>> +    mutex_unlock(&update_mutex);
>> +    rcu_read_lock();
>> +    bpf_link_put(&st_link->link);
>> +fail:
>> +    bpf_map_put(&st_map->map);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(bpf_struct_ops_kvalue_unreg);
> 

