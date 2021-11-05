Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530C0446952
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 20:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhKETyn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhKETyh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 15:54:37 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CF8C061714;
        Fri,  5 Nov 2021 12:51:58 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bg25so15494406oib.1;
        Fri, 05 Nov 2021 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cu13afi5YdNTXVpPIxFdtRUqaXpmJXw8oN5rJSTgUfw=;
        b=cFBJ32UAO5dTAuReqy+9vhWjg5KioPPvsgYH4/8bwdj80vrdErPlgDjMhDaQuq2vK7
         NFicgPMRKCbJCrQjRws2WABl3oLXjTumYFj8nK1ABd6ZudT/Md56XN+tAy8Ka0Z1THu+
         gi7PmfQ8etnwswnsidtLhfJ6q6SxbSZjs6XyngKwBvZYjYP1/M3Gr7eM2TY/q6sRlN/k
         RtSQQYraGV6OtKDGSs4kAHTpN9GYe6aY5s3PIPdwEuZ9q2dtwSjIgZ4o605usbrWjxch
         b+58KuYTwCXB1VY5EWNV5f91m3o/2mIuu16ZlthMQqlKank5sUcc2+/rTbDR/K9y31ss
         UDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cu13afi5YdNTXVpPIxFdtRUqaXpmJXw8oN5rJSTgUfw=;
        b=XbS4kNL/5RvmGb72SloB2aqAyNPmN8PFBbhoItw85VCAaqBhDl8AORZH/MQNXPNU6F
         gC5OhlczVU7A/mfqJylOrMFPVI9Z8iJHtLGNHMDcZ6TGdTEqHQJk3qe32XpX9mbnIAgY
         qsPqzJ5JIDZXWgP7qgA0om5UPZzdrkN0sTrvyhyobgpmOGaB0JCN/G25B2jpW+1xDkAW
         arc9DLP6ax8V67euPy8QhO9bytV9mWVdAuNyPEsk80kG8sO0ngDFUge0RlyMEQINbhwI
         aKsutdvhh9XMcLmzlHpawy5JbyJfsks8/huIoO0jTeuCtWxNBvuiXV3lh3XPt/ZOay54
         EtcA==
X-Gm-Message-State: AOAM5310shEX+vIkVPNHQ2Od3Y0x3+nrHBvBXwj7o6QNDo5RW/Optr98
        TkczDNuAQHmhbagj7tgQMPY=
X-Google-Smtp-Source: ABdhPJyyj/xmEsV2riYpDqxqvSGA3gx3/VvulZ2S/W+tOa040GrFqBTndoudGnazdvmA/oApIfD8hg==
X-Received: by 2002:a05:6808:493:: with SMTP id z19mr10290264oid.125.1636141917462;
        Fri, 05 Nov 2021 12:51:57 -0700 (PDT)
Received: from localhost ([2600:1700:65a0:ab60:d18c:87bf:9ef9:564d])
        by smtp.gmail.com with ESMTPSA id y18sm1245203oov.29.2021.11.05.12.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:51:56 -0700 (PDT)
Date:   Fri, 5 Nov 2021 12:51:55 -0700
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     Di Zhu <zhudi2@huawei.com>
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jakub@cloudflare.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
Message-ID: <YYWLW5IJhmIa2aVX@unknown>
References: <20211104010745.1177032-1-zhudi2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104010745.1177032-1-zhudi2@huawei.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 04, 2021 at 09:07:44AM +0800, Di Zhu wrote:
> +int sock_map_bpf_prog_query(const union bpf_attr *attr,
> +			    union bpf_attr __user *uattr)
> +{
> +	__u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
> +	u32 prog_cnt = 0, flags = 0, ufd = attr->target_fd;
> +	struct bpf_prog **pprog;
> +	struct bpf_prog *prog;
> +	struct bpf_map *map;
> +	struct fd f;
> +	u32 id = 0;
> +	int ret;
> +
> +	if (attr->query.query_flags)
> +		return -EINVAL;
> +
> +	f = fdget(ufd);
> +	map = __bpf_map_get(f);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	rcu_read_lock();
> +
> +	ret = sock_map_prog_lookup(map, &pprog, attr->query.attach_type);
> +	if (ret)
> +		goto end;
> +
> +	prog = *pprog;
> +	prog_cnt = (!prog) ? 0 : 1;
> +
> +	if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
> +		goto end;

This sanity check (except prog_cnt) can be moved before RCU read lock?

> +
> +	id = prog->aux->id;
> +	if (id == 0)
> +		prog_cnt = 0;

The id seems generic, so why not handle it in bpf_prog_query() for all progs?

> +
> +end:
> +	rcu_read_unlock();
> +
> +	if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)) ||

'flags' is always 0 here, right? So this is not needed as uattr has been already
cleared in __sys_bpf().


Thanks.
