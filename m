Return-Path: <bpf+bounces-15411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D97F1F52
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA8F2821C7
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4248638F9F;
	Mon, 20 Nov 2023 21:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GcYKFBPp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7962CB
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 13:39:11 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cf5901b1a9so25583385ad.1
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 13:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700516351; x=1701121151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG1vDgWu2nKSdBVzCq8kAu+r1Dbdevu3C444hSj0rlg=;
        b=GcYKFBPpGNxwdHHQFscglbYbuHfT1DH0C0Mu4K5EUJ48EfGHae7TN1nSMK+1S8cj4r
         0j8O3xXnr7PDgiofQFkCwi/UWJx5UlpH0UMnND4bjYX7rDN+FHK2PpcWLmrPrEZClqSi
         MxAkD62UWJ8DNX7c6wIKYTSRUQp7zT5Qp43x7wtlkrKrWo1Ie73kchErZMlw3HC4vhUB
         +m9p/68qL2ihouPN1WYtZxdi7vUHT7frCqnF5ZAu1UY0VKNZcXtOqj+NTZQLE9o8VCqu
         QWvkuyqxdYwLOdWmRg92la27eE66kAAVg3PQRUdUKb7dsRJXwtkFWUEhTIyxmB7bK0ha
         qP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700516351; x=1701121151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZG1vDgWu2nKSdBVzCq8kAu+r1Dbdevu3C444hSj0rlg=;
        b=hvJ27C3Pz5SB/TWek2PWC799sQNxKxIEWgLOssKWNOxtURF0ltzOceTfflFuTIO4Zb
         /YCBJmUdwlGwkcPoKUZ3qKaWvGI4psZOnz6cLVXS+WfgMR9ALlHMxFP4JwTZmFjCxqEi
         tUODIi3PVy/deMLiF1VabfxQAgDfP7aLp7+7F6Zhd/i/GaEagCBgCk6cM3eTrZrPwmvW
         X9jZfnMsfHRj/sNsSwX/aquMSsO8ef4H/ZltaQH8DgRveoqlIp0PVVFyFFA5iPgzJl8g
         QEMRz0X+KkcDKlSQhJcLv2q/e+07Q2Q8Ut8umu0SYKinBYihHcL3wMpoedtfjhl9kjuH
         Mfqw==
X-Gm-Message-State: AOJu0Yxd15hCViMePxny6DEoX1clnhH6TUiwCyg7tMzSrqq7lowQGsni
	Q40ZMKVMWyZzQcXSpT31GA6F33J/aGaFyUCDJmkjYiYKdl84ap9V2WRNbq9lBMOtfvgyy1Ni7+9
	tqQE2GbTs1I666UZSn6qDgSj1z+TkfJN5/YyutyggHdy7bXIX9Q==
X-Google-Smtp-Source: AGHT+IE6HMKV3e822phR9t0E3N3YA0C18ABXo35ybFcnnPVw7dOBk1yIOwnYxo5D0z70IOi/dBH01oM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ce81:b0:1cc:2bd6:b54a with SMTP id
 f1-20020a170902ce8100b001cc2bd6b54amr2761974plg.10.1700516351192; Mon, 20 Nov
 2023 13:39:11 -0800 (PST)
Date: Mon, 20 Nov 2023 13:39:09 -0800
In-Reply-To: <20231114045453.1816995-3-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231114045453.1816995-1-sdf@google.com> <20231114045453.1816995-3-sdf@google.com>
Message-ID: <ZVvR_fu2TIe4Puii@google.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: bring back removal of dev-bound id from idr
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="utf-8"

On 11/13, Stanislav Fomichev wrote:
> Commit ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD
> and PERF_BPF_EVENT_PROG_UNLOAD") stopped removing program's id from
> idr when the offloaded/bound netdev goes away. I was supposed to
> take a look and check in [0], but apparently I did not.
> 
> The purpose of idr removal is to avoid BPF_PROG_GET_NEXT_ID returning
> stale ids for the programs that have a dead netdev. This functionality
> is verified by test_offload.py, but we don't run this test in the CI.
> 
> Introduce new bpf_prog_remove_from_idr which takes care of correctly
> dealing with potential double idr_remove() via separate skip_idr_remove
> flag in the aux.
> 
> Verified by running the test manually:
> test_offload.py: OK
> 
> 0: https://lore.kernel.org/all/CAKH8qBtyR20ZWAc11z1-6pGb3Hd47AQUTbE_cfoktG59TqaJ7Q@mail.gmail.com/
> 
> Fixes: ef01f4e25c17 ("bpf: restore the ebpf program ID for BPF_AUDIT_UNLOAD and PERF_BPF_EVENT_PROG_UNLOAD")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/linux/bpf.h  |  2 ++
>  kernel/bpf/offload.c |  3 +++
>  kernel/bpf/syscall.c | 15 +++++++++++----
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4001d11be151..d2aa4b59bf1e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
>  	bool xdp_has_frags;
>  	bool exception_cb;
>  	bool exception_boundary;
> +	bool skip_idr_remove;
>  	/* BTF_KIND_FUNC_PROTO for valid attach_btf_id */
>  	const struct btf_type *attach_func_proto;
>  	/* function name for valid attach_btf_id */
> @@ -2049,6 +2050,7 @@ void bpf_prog_inc(struct bpf_prog *prog);
>  struct bpf_prog * __must_check bpf_prog_inc_not_zero(struct bpf_prog *prog);
>  void bpf_prog_put(struct bpf_prog *prog);
>  
> +void bpf_prog_remove_from_idr(struct bpf_prog *prog);
>  void bpf_prog_free_id(struct bpf_prog *prog);
>  void bpf_map_free_id(struct bpf_map *map);
>  
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index 1a4fec330eaa..6f4fe492ee2a 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -112,6 +112,9 @@ static void __bpf_prog_offload_destroy(struct bpf_prog *prog)
>  	if (offload->dev_state)
>  		offload->offdev->ops->destroy(prog);
>  
> +	/* Make sure BPF_PROG_GET_NEXT_ID can't find this dead program */
> +	bpf_prog_remove_from_idr(prog);
> +
>  	list_del_init(&offload->offloads);
>  	kfree(offload);
>  	prog->aux->offload = NULL;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ed286b8a0f0..bc813e03e2cf 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2083,10 +2083,19 @@ static int bpf_prog_alloc_id(struct bpf_prog *prog)
>  	return id > 0 ? 0 : id;
>  }
>  
> -void bpf_prog_free_id(struct bpf_prog *prog)
> +void bpf_prog_remove_from_idr(struct bpf_prog *prog)
>  {
>  	unsigned long flags;
>  
> +	spin_lock_irqsave(&prog_idr_lock, flags);
> +	if (!prog->aux->skip_idr_remove)
> +		idr_remove(&prog_idr, prog->aux->id);
> +	prog->aux->skip_idr_remove = 1;
> +	spin_unlock_irqrestore(&prog_idr_lock, flags);
> +}
> +
> +void bpf_prog_free_id(struct bpf_prog *prog)
> +{
>  	/* cBPF to eBPF migrations are currently not in the idr store.
>  	 * Offloaded programs are removed from the store when their device
>  	 * disappears - even if someone grabs an fd to them they are unusable,
> @@ -2095,10 +2104,8 @@ void bpf_prog_free_id(struct bpf_prog *prog)
>  	if (!prog->aux->id)
>  		return;
>  
> -	spin_lock_irqsave(&prog_idr_lock, flags);
> -	idr_remove(&prog_idr, prog->aux->id);
> +	bpf_prog_remove_from_idr(prog);
>  	prog->aux->id = 0;
> -	spin_unlock_irqrestore(&prog_idr_lock, flags);
>  }
>  
>  static void __bpf_prog_put_rcu(struct rcu_head *rcu)
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

Same here, should have been CC'ed to netdev.

