Return-Path: <bpf+bounces-15501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F7F7F252E
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 06:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82521B21CF5
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 05:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9D18AF3;
	Tue, 21 Nov 2023 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqh6lepc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B7ED
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 21:19:22 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc394f4cdfso38104355ad.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 21:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700543961; x=1701148761; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4QvWxVyLHfe1THaPjb2vgpfNpnx2h6mMp4izAMQEqjA=;
        b=gqh6lepcyN4Kam0WNwzF9Lic2FMvlh7XwEjLXVUqwUgEfI4Ocup0KNlafZ2hO76h7Q
         rY2bWH6/tVAiHp8jqhOXWrdrryd1hL+Ay1cs/AMlspOzoB/GlPLdLDZkbwmDg5UVEeMI
         jKu0iTwsHYBf5+MOryR7ifb9RUXoxeC1II/bNNlE0ce1DW70RuUrA+Mv6JqVAZMvE8N2
         DssZQ0sP9+bNtY49sn6gFB3/ceh0SRFJUa5419OFCNlmZBPqhsYnABIxeHps05G/xfH+
         UEP7vv/wB7NqtHY3tmcADJj3FFfCiNQKz2T2dT/7tAenWDGCt740Un8RgJKbdP0ivcop
         t8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700543961; x=1701148761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QvWxVyLHfe1THaPjb2vgpfNpnx2h6mMp4izAMQEqjA=;
        b=vAjus74LNyzo0n99fFiIG7kNHdA83RhjkjCtPMmpnSDL1vlmQBEUUEEVZfeK+zYpVO
         EGAVjE2bGX3Vemtx5WvbsfNmiXuxTymsm0vSMQeyPXrlnIbsmJvidU1gayEKNr3J96bp
         qMCgk+1F52KHfnPItyAb2xzPqKor8MVp2dteVcJyh9SiRVUOL0CWH8/ZOwfJo7OH5JXV
         /GF1px+Ce7uVOUFsn+csvJ3zkpnNryJsnM3Hxv1nHhwHHN4einA6QcqUuqK8juIeDycO
         Prhq5c7RrvRc6kymCD6K7kFatFoJiG0G0KNhTxpyBQobeWrrqlXDvx1kkmtBPOuC4WEV
         3kNA==
X-Gm-Message-State: AOJu0YytHyBi8/nc9Nd6Ku+sB2KdhvnLBYn7tHGJvNQCsUOFsblEowoO
	ubeBa3WMgYRfZ3QZdFCwYDA=
X-Google-Smtp-Source: AGHT+IEKijp1uhIVGXVGdqeBSNmpl6xivkAWqw5eHW0ZXc0aVSj2VppWNpMbqd7VR9b+YWbSYFOYHw==
X-Received: by 2002:a17:902:6941:b0:1cc:76c4:5144 with SMTP id k1-20020a170902694100b001cc76c45144mr7531998plt.12.1700543961233;
        Mon, 20 Nov 2023 21:19:21 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:e8eb])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001c9c97beb9csm6937452plr.71.2023.11.20.21.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 21:19:20 -0800 (PST)
Date: Mon, 20 Nov 2023 21:19:17 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Subject: Re: [PATCH bpf v2 4/5] bpf: Optimize the free of inner map
Message-ID: <20231121051917.lbp6luone7pxqkvw@macbook-pro-49.dhcp.thefacebook.com>
References: <20231113123324.3914612-1-houtao@huaweicloud.com>
 <20231113123324.3914612-5-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113123324.3914612-5-houtao@huaweicloud.com>

On Mon, Nov 13, 2023 at 08:33:23PM +0800, Hou Tao wrote:
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e2d2701ce2c45..5a7906f2b027e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -694,12 +694,20 @@ static void bpf_map_free_deferred(struct work_struct *work)
>  {
>  	struct bpf_map *map = container_of(work, struct bpf_map, work);
>  	struct btf_record *rec = map->record;
> +	int acc_ctx;
>  
>  	security_bpf_map_free(map);
>  	bpf_map_release_memcg(map);
>  
> -	if (READ_ONCE(map->free_after_mult_rcu_gp))
> -		synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);

The previous patch 3 is doing too much.
There is maybe_wait_bpf_programs() that will do synchronize_rcu()
when necessary.
The patch 3 could do synchronize_rcu_tasks_trace() only and it will solve the issue.

> +	acc_ctx = atomic_read(&map->may_be_accessed_prog_ctx) & BPF_MAP_ACC_PROG_CTX_MASK;
> +	if (acc_ctx) {
> +		if (acc_ctx == BPF_MAP_ACC_NORMAL_PROG_CTX)
> +			synchronize_rcu();
> +		else if (acc_ctx == BPF_MAP_ACC_SLEEPABLE_PROG_CTX)
> +			synchronize_rcu_tasks_trace();
> +		else
> +			synchronize_rcu_mult(call_rcu, call_rcu_tasks_trace);

and this patch 4 goes to far.
Could you add sleepable_refcnt in addition to existing refcnt that is incremented
in outer map when it's used by sleepable prog and when sleepable_refcnt > 0
the caller of bpf_map_free_deferred sets free_after_mult_rcu_gp.
(which should be renamed to free_after_tasks_rcu_gp).
Patch 3 is simpler and patch 4 is simple too.
No need for atomic_or games.

In addition I'd like to see an extra patch that demonstrates this UAF
when update/delete is done by syscall bpf prog type.
The test case in patch 5 is doing update/delete from user space.
If that was the only issue we could have easily extended maybe_wait_bpf_programs()
to do synchronize_rcu_tasks_trace() and that would close the issue exposed by patch 5.
But inner maps can indeed be updated by syscall bpf prog and since they run
under rcu_read_lock_trace() we cannot add synchronize_rcu_tasks_trace() to
maybe_wait_bpf_programs() because it will deadlock.
So let's make sure we have test cases for all combinations where inner maps
can be updated/deleted.

