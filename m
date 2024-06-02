Return-Path: <bpf+bounces-31157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC0A8D7799
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 21:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29891F21DA0
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D0771747;
	Sun,  2 Jun 2024 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbI4sD15"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629A262B6;
	Sun,  2 Jun 2024 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717356759; cv=none; b=scEQLS/1nN+oEh+rBrzUM+JvEx0zijkfeZTDCLSu2WySxVvSn7wBntHB+d2fLfSYMtWyXPlY5fDEKKFzO+5rQsNXn4LUOW1X095DZ9ZGiugereSCvQDU+5j7mu3hKnqNM6qG7+Yoh1JcGU9yYNRtO3QaAX/o3Cd/GP3uUlomEgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717356759; c=relaxed/simple;
	bh=jIno1JF/zaBu1ybGTRfJ2FsZUbHpL9bl8tN6FO+8hLI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoYPvCfvEmGutKJGCEcv5ImIX7CdNNsCVS1u21crjmEtpHp+E7uPRSDqzenPKJPWQWtwJNcYv0fYPzC/yXc9zen3oGo8SqIEG7DLd8/Akk4epw6nTNA+6V/f21BH4Lxx29J+k0w3hB9GZR+ttOX/qCSosXoxm+ZMOLbXpe8CW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbI4sD15; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-421338c4c3bso15185125e9.1;
        Sun, 02 Jun 2024 12:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717356756; x=1717961556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKCOsV2XYSwYAbin9usnjEvg6RDHEVLVcrQaFWDC7m0=;
        b=GbI4sD15ZU0Je0FaUTfxG4q9X1Sn/UXD/6ViACsnvAGzxj4DAPeS2Uj4+6FUrstT1V
         YMg3TIrN2jMvPe8B5KSwkfKgI59Tj3Dw7/h16+zdMczzwgReU0D6BTlV6KS4nm+wBmlV
         Os6nwUuBzxwcRX77V/Bo7IGdOUlLcQHZuG0KDyjkB2YoBWa5UzVZRK+ZnU+3jz4nKeMv
         6Qu+QPcM0G3ms/6Q6Qay7hWduOARJMZ70JyOQtjfl0FIkYBCuQe1v3sZO/kK8b+9Vl9z
         e5JtzAiXT2HdsztaRlxkqnHpUE3/rdHbVI9Wy8agA1PihZQWmKM0/jV/cDDze09+pZXO
         9hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717356756; x=1717961556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKCOsV2XYSwYAbin9usnjEvg6RDHEVLVcrQaFWDC7m0=;
        b=r8gMDG/9IrfuojA9t30pUYo1SHOPFGfchhKuju7/n2fPRlOqJ4IT0hezEpf/pVNBZw
         ud+rWOM3OtMaYl3ziGNvW9yMXrAC70fHDz/kYKHU5j4l0ImUpER7am2NdwKuFpKzqrj2
         DlmWmmJer40FboCPEd73ik3bMcHRncE8MA9aFd/EHp0StLE5eylOfiU78Z96I2Ugv1Bg
         zct7SFhJ8XAF6Su9/Oemimn2IT98NqtXgJ+1poymZS9Eg2aLQfoj0ARGhdEhvGbhaqKV
         3SMfYc1YUClkZgRIc+U/wyQwLthyMUTb+mxU3TQo/6x0MXEU860Y7p4vVYogG1mTkc0A
         bvww==
X-Forwarded-Encrypted: i=1; AJvYcCXIMSfSPJHel9qqpwfcJhRpnIw0u9p+ESN4GUZDvRoFcS74x0oX9gwgroYaTo8H6mtwiCuzRAKQRHuumFUcuJ6EqA9z
X-Gm-Message-State: AOJu0Yw3QXxgkM+8tvI3c1QpFpi93kABPCzxj+q9agGmWmaY2x9cCV3n
	69q0R5D4/u18OUYgljtDGFQBlddfyAYopkOfVvAhcq48yIq61ZVK
X-Google-Smtp-Source: AGHT+IE0wIV1lHMQma4StsOqMl/QcsD2jWifORtX8XnqJREO7HxFU7LfOfxBZ7lixUh2Jjyb/RaZBA==
X-Received: by 2002:a05:600c:6ca:b0:41a:b961:9495 with SMTP id 5b1f17b1804b1-4212e09cc32mr57986895e9.25.1717356755591;
        Sun, 02 Jun 2024 12:32:35 -0700 (PDT)
Received: from krava ([83.240.60.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213411b25dsm68313655e9.40.2024.06.02.12.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:32:35 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 2 Jun 2024 21:32:33 +0200
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	syzbot+1989ee16d94720836244@syzkaller.appspotmail.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [Patch bpf] bpf: fix a potential use-after-free in
 bpf_link_free()
Message-ID: <ZlzI0bhlMP1sAHEI@krava>
References: <20240602182703.207276-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602182703.207276-1-xiyou.wangcong@gmail.com>

On Sun, Jun 02, 2024 at 11:27:03AM -0700, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
> 
> After commit 1a80dbcb2dba, bpf_link can be freed by
> link->ops->dealloc_deferred, but the code still tests and uses
> link->ops->dealloc afterward, which leads to a use-after-free as
> reported by syzbot. Actually, one of them should be sufficient, so
> just call one of them instead of both. Also add a WARN_ON() in case
> of any problematic implementation.
> 
> Reported-by: syzbot+1989ee16d94720836244@syzkaller.appspotmail.com
> Fixes: 1a80dbcb2dba ("bpf: support deferring bpf_link dealloc to after RCU grace period")
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  kernel/bpf/syscall.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 2222c3ff88e7..d8f244069495 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2998,6 +2998,7 @@ static int bpf_obj_get(const union bpf_attr *attr)
>  void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
>  		   const struct bpf_link_ops *ops, struct bpf_prog *prog)
>  {
> +	WARN_ON(ops->dealloc && ops->dealloc_deferred);
>  	atomic64_set(&link->refcnt, 1);
>  	link->type = type;
>  	link->id = 0;
> @@ -3074,8 +3075,7 @@ static void bpf_link_free(struct bpf_link *link)
>  			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
>  		else
>  			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
> -	}
> -	if (link->ops->dealloc)
> +	} else if (link->ops->dealloc)
>  		link->ops->dealloc(link);

nice catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

