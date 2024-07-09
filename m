Return-Path: <bpf+bounces-34174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D2A92AD0B
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 02:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9868AB21D69
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A34A0A;
	Tue,  9 Jul 2024 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7BGrzLH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D0286A6;
	Tue,  9 Jul 2024 00:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720484475; cv=none; b=KaWk23SuIyoEjp6MhcINNCndnu2f65A3GWpRoaGBsJ6WgKpeg6i/wZM0pAf6F0e3dwwns+uFsorebD5eEWZQoye6u5g7GmEHat9Ilvklwy1eo0DSMG0kFl+pJSUoW6HOXQ8nd1vblK0X4Qw//1QvO35dYtbEBZXcLuNTt2pL+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720484475; c=relaxed/simple;
	bh=Xo3+QFBXpqmBlMplzfz/hdxkkPdt/5SCumC7QBHHisM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=na1KymeaXp/HEb233c4upnNAA/K1BgDpCb5CBXsv5Sotpo43biPnUswFGxX3d32icmLurZWYht4I4Ry1z7BcmT32mX+6GsceYaMbPg5+YHOa/tqSRofYgmhrdV9vFr3f12PKbudMN8zX+TAnS3rbMn8eT7jJBFlV5R5BtN5OLSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7BGrzLH; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70af0684c2bso2787510b3a.0;
        Mon, 08 Jul 2024 17:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720484473; x=1721089273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/SwctyraUjLIa9K94QJwveOwyBiR6rakJmgf688vGc=;
        b=a7BGrzLHMQVphT/D1vHngMH9FxcP69mCIgNYigQJRzR/NVDOi4Plo/v0Nq4gwVU85c
         x1BMuaZQSNauHbWAvqn1SEYKa9rMxdMn6LNMt8n3QWBP27zXAN5yvZn9dnVKzdF2qdiq
         1Wc6ubxEbfg2Bxt6akrUNpDWrjBjv9VGLlKnC2RoLC+gmJlGcHdZtfAd9cqq+Kq8AEwz
         J/mYnq2w9BpWvDs8thkE71bHX0u8k2Z5cGrOwTDgov6z65z546eASwQIrTwdOlX8eh8S
         7Ay+wJjb8V+C4bjs+e4LXJAladwI6NfvIj+WXZ8METuFqFNa+hDix9lE2lbWpNeeKoIS
         JIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720484473; x=1721089273;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R/SwctyraUjLIa9K94QJwveOwyBiR6rakJmgf688vGc=;
        b=Zj7nCE6C5uu/rp7tT++N6VxouLVe9v+4dTIWycwKe3qj3vEc1SmYOeevEcBlAGC3pk
         48wD0oYl6mHJiLGjn5QluHIf2xfgKsXm2+OkY4M0XCDVX4DYVCH6jA3AZcgoGK38ZFDd
         LxWXTLhLht2Nl3syj6aPM/hWEa5tZOj6wL47GebdZdd2N+YxjzVKS9QViZQPS6bCfjwt
         ZvCUrUHlSi50mhD60+x7ZzMpB0un67/mb7chH7Vpj3DFycvQtLEW+0ucbFZw2ZFYRmHu
         F6LARAD81tKxo5F5Aq4WbQmnpCfLXYD6TjyXDd7tK9mshH5iZx/DqTpWiJwFXqAk7aS/
         5DRw==
X-Forwarded-Encrypted: i=1; AJvYcCU402GGVmzc9MnHeJqo3BxFr+/9twNbj4HJp5kbKIUYbhEpG3cM0NcBeWkBL33t3NwQkOgcJYRfzjxbjZHDdTIFfFL8Pkdj
X-Gm-Message-State: AOJu0YzCsvowPY7Eg/Dl0hXRdYY2LKMYVjP1K0WF1sM889wvxDjWVN1X
	UR5bh16XHryBvn55VndlrDbUfjOBhcwaF6OtY9zJ5cgDjD4ddoAGzwte4g==
X-Google-Smtp-Source: AGHT+IEbeu0fPSJxg2Hdz6MG/eLE6DApOHWfSyQU5j2n6d2tbjX6V5EDFVjtF97Qysp7dh2y/FY6YA==
X-Received: by 2002:a05:6a00:999:b0:705:cade:1f50 with SMTP id d2e1a72fcca58-70b436875bbmr1347241b3a.34.1720484473048;
        Mon, 08 Jul 2024 17:21:13 -0700 (PDT)
Received: from localhost ([98.97.32.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b30b9sm487946b3a.178.2024.07.08.17.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:21:12 -0700 (PDT)
Date: Mon, 08 Jul 2024 17:21:12 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 martin.lau@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Pedro Pinto <xten@osec.io>, 
 Hyunwoo Kim <v4bel@theori.io>, 
 Wongi Lee <qwerty@theori.io>
Message-ID: <668c82787f16_d77208e0@john.notmuch>
In-Reply-To: <20240708133130.11609-1-daniel@iogearbox.net>
References: <20240708133130.11609-1-daniel@iogearbox.net>
Subject: RE: [PATCH bpf 1/2] bpf: Fix too early release of tcx_entry
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Borkmann wrote:
> Pedro Pinto and later independently also Hyunwoo Kim and Wongi Lee reported
> an issue that the tcx_entry can be released too early leading to a use
> after free (UAF) when an active old-style ingress or clsact qdisc with a
> shared tc block is later replaced by another ingress or clsact instance.
> 
> Essentially, the sequence to trigger the UAF (one example) can be as follows:
> 
>   1. A network namespace is created
>   2. An ingress qdisc is created. This allocates a tcx_entry, and
>      &tcx_entry->miniq is stored in the qdisc's miniqp->p_miniq. At the
>      same time, a tcf block with index 1 is created.
>   3. chain0 is attached to the tcf block. chain0 must be connected to
>      the block linked to the ingress qdisc to later reach the function
>      tcf_chain0_head_change_cb_del() which triggers the UAF.
>   4. Create and graft a clsact qdisc. This causes the ingress qdisc
>      created in step 1 to be removed, thus freeing the previously linked
>      tcx_entry:
> 
>      rtnetlink_rcv_msg()
>        => tc_modify_qdisc()
>          => qdisc_create()
>            => clsact_init() [a]
>          => qdisc_graft()
>            => qdisc_destroy()
>              => __qdisc_destroy()
>                => ingress_destroy() [b]
>                  => tcx_entry_free()
>                    => kfree_rcu() // tcx_entry freed
> 
>   5. Finally, the network namespace is closed. This registers the
>      cleanup_net worker, and during the process of releasing the
>      remaining clsact qdisc, it accesses the tcx_entry that was
>      already freed in step 4, causing the UAF to occur:
> 
>      cleanup_net()
>        => ops_exit_list()
>          => default_device_exit_batch()
>            => unregister_netdevice_many()
>              => unregister_netdevice_many_notify()
>                => dev_shutdown()
>                  => qdisc_put()
>                    => clsact_destroy() [c]
>                      => tcf_block_put_ext()
>                        => tcf_chain0_head_change_cb_del()
>                          => tcf_chain_head_change_item()
>                            => clsact_chain_head_change()
>                              => mini_qdisc_pair_swap() // UAF
> 
> There are also other variants, the gist is to add an ingress (or clsact)
> qdisc with a specific shared block, then to replace that qdisc, waiting
> for the tcx_entry kfree_rcu() to be executed and subsequently accessing
> the current active qdisc's miniq one way or another.
> 
> The correct fix is to turn the miniq_active boolean into a counter. What
> can be observed, at step 2 above, the counter transitions from 0->1, at
> step [a] from 1->2 (in order for the miniq object to remain active during
> the replacement), then in [b] from 2->1 and finally [c] 1->0 with the
> eventual release. The reference counter in general ranges from [0,2] and
> it does not need to be atomic since all access to the counter is protected
> by the rtnl mutex. With this in place, there is no longer a UAF happening
> and the tcx_entry is freed at the correct time.
> 
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Reported-by: Pedro Pinto <xten@osec.io>
> Co-developed-by: Pedro Pinto <xten@osec.io>
> Signed-off-by: Pedro Pinto <xten@osec.io>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Hyunwoo Kim <v4bel@theori.io>
> Cc: Wongi Lee <qwerty@theori.io>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

