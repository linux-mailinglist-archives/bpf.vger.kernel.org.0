Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D49181AA3
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 15:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgCKOBC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 10:01:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39973 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgCKOBC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 10:01:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so2246992wme.5
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2020 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=st6T0r/6+bS/alnv4g1bn1POyCeaa5C0vH9S2dNg93o=;
        b=I097htkv9toD64jIus4MDQriHnPlX5I5/u3CJzx3HOAgCGqcN+niX1b8vF7fQZYcql
         D7P4OFoIs/2RXu75huetc2RqudjX4l8BMEc//T2iGzqaOvk7yGDYSBYbsO4GWkNoWH9r
         wxn1mu0+he3WdaN+lmKOw4NOMoxv+sh8jWTLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=st6T0r/6+bS/alnv4g1bn1POyCeaa5C0vH9S2dNg93o=;
        b=uNkHCTHwJhm0Ax3B5z2KvpzI8gQDhK3QX/ohbQg59OhonrV/iOPmw6sFbqobOocwlE
         2lquoSWwy3DnoWV+CgJzccYB0sRCBbmnHn/4ryQGjyZahYsJcEF82tBJuPuxMhXbFBsd
         ZQJ90/LjdbuO4qSMXdecT1GRPnr/KaHKKkB334X8kC/7SesGn13QT7ZS2TZ59uMVRzwq
         FxNvAtOOAU+qMSmfa27HH+Iw6Dax3TZwkuaoN5bAgUosvJnNPWDtXJpKMxtt9XyYcpK3
         +S1/lA1Yctm2vE0NSDcD6wX8SYMPydWhoxsjhjfLWpy37eqo08mR0KPZd9JjkxNgZso0
         iNxA==
X-Gm-Message-State: ANhLgQ2PJa1ucByUomxJ/21rU7B/sPreAKvfv/5FlbhsegdNTbfSDtvp
        98SqTy1NoTIdLgVq2qNMne6F0Q==
X-Google-Smtp-Source: ADFU+vuNzZZ/aB/DBFskPbkdKY5PpuNWXDnHImPs87RpTw4z3v+JjU4zYukfDdogLaUZu6g/Gmwfsw==
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr2719125wml.26.1583935258738;
        Wed, 11 Mar 2020 07:00:58 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id k5sm6012188wmj.18.2020.03.11.07.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 07:00:58 -0700 (PDT)
References: <20200310174711.7490-1-lmb@cloudflare.com> <20200310174711.7490-3-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] bpf: convert queue and stack map to map_copy_value
In-reply-to: <20200310174711.7490-3-lmb@cloudflare.com>
Date:   Wed, 11 Mar 2020 15:00:57 +0100
Message-ID: <87tv2vxa7a.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 10, 2020 at 06:47 PM CET, Lorenz Bauer wrote:
> Migrate BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK to map_copy_value,
> by introducing small wrappers that discard the (unused) key argument.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  kernel/bpf/queue_stack_maps.c | 18 ++++++++++++++++++
>  kernel/bpf/syscall.c          |  5 +----
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
> index f697647ceb54..5c89b7583cd2 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -262,11 +262,28 @@ static int queue_stack_map_get_next_key(struct bpf_map *map, void *key,
>  	return -EINVAL;
>  }
>
> +/* Called from syscall */
> +static int queue_map_copy_value(struct bpf_map *map, void *key, void *value)
> +{
> +	(void)key;

Alternatively, there's is the __always_unused compiler attribute from
include/linux/compiler_attributes.h that seems to be in wide use.

> +
> +	return queue_map_peek_elem(map, value);
> +}
> +
> +/* Called from syscall */
> +static int stack_map_copy_value(struct bpf_map *map, void *key, void *value)
> +{
> +	(void)key;
> +
> +	return stack_map_peek_elem(map, value);
> +}
> +
>  const struct bpf_map_ops queue_map_ops = {
>  	.map_alloc_check = queue_stack_map_alloc_check,
>  	.map_alloc = queue_stack_map_alloc,
>  	.map_free = queue_stack_map_free,
>  	.map_lookup_elem = queue_stack_map_lookup_elem,
> +	.map_copy_value = queue_map_copy_value,
>  	.map_update_elem = queue_stack_map_update_elem,
>  	.map_delete_elem = queue_stack_map_delete_elem,
>  	.map_push_elem = queue_stack_map_push_elem,
> @@ -280,6 +297,7 @@ const struct bpf_map_ops stack_map_ops = {
>  	.map_alloc = queue_stack_map_alloc,
>  	.map_free = queue_stack_map_free,
>  	.map_lookup_elem = queue_stack_map_lookup_elem,
> +	.map_copy_value = stack_map_copy_value,
>  	.map_update_elem = queue_stack_map_update_elem,
>  	.map_delete_elem = queue_stack_map_delete_elem,
>  	.map_push_elem = queue_stack_map_push_elem,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6503824e81e9..20c6cdace275 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -218,10 +218,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
>  		return bpf_map_offload_lookup_elem(map, key, value);
>
>  	bpf_disable_instrumentation();
> -	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
> -	    map->map_type == BPF_MAP_TYPE_STACK) {
> -		err = map->ops->map_peek_elem(map, value);
> -	} else if (map->ops->map_copy_value) {
> +	if (map->ops->map_copy_value) {
>  		err = map->ops->map_copy_value(map, key, value);
>  	} else {
>  		rcu_read_lock();
