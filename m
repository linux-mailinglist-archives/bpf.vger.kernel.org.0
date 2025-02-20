Return-Path: <bpf+bounces-52030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E43DDA3CF74
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 03:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89404189CAE4
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 02:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7D91D7E57;
	Thu, 20 Feb 2025 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXVsIdSq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304563A9;
	Thu, 20 Feb 2025 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740019565; cv=none; b=WfN6ZKFeh/mC1saQ3WfQQ34hg9Z7sEPwHsS/haY9fzwLfUZCCOf+iHNc5UPsLOIh5zaqNd11JwNCoGcFtwAe7yd9Titn3Re55H2stCQ1cvXszh29mn1vFbbWWs6WUUSXh5UEHyo3o6f1xLqNxL9P33lYsX3Omq4v8HbpuRJ2j20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740019565; c=relaxed/simple;
	bh=73uLvuaiLscksGhZc+hY2cupAUVy2zHkoE90LdSw12E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZisWYPUUmw4+OUXAIJtqEEw6TAropugqERFogUK7EQ/iH9YCpU9jrnv11AOHWzAwUgj5sXDILtTbVyPKtBCKKpP0LUj8MLbgczPqiemQ/b9O/r/ovfEs0IY0Mi/CGDgCn4Z9R+emSdXZflfY6ynadMSp+NXyQZz2asXepNCzt1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXVsIdSq; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46c8474d8f6so4276951cf.3;
        Wed, 19 Feb 2025 18:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740019562; x=1740624362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/D3678QYRZKxPCIowYLLtnEL0WC8u1sCf7aliAuVuE=;
        b=kXVsIdSqib3fZ9M4SQx1yh2bQXptUMTWi75eYfu9iU+AmAo9enZxR6zon9WRrLcR62
         ZPVlVaj4eV7Xqgz2US6aA/s1KNwZrhqMx3/Y/T/x4Q+MHFB05P+H5dqmlLRLO/w0CE4U
         gazSM/Oyj4LY7Z4Y4Gfu+nEVEvXSZS8ncG5QgtocvMcmexEtYsxlBohYPJtl0Nn3PKpR
         XNaafEMw+X6l6GqARqmJrIGNk1gCuSTk3x/AmDM3wHl+g22RmfHErHbnSMgkFInx5C7y
         rhDTpauxkTcysCTZA70MciEHELiQYlqgOqv/vsK9pgZGxgbDQ8TxtqtuXiN6Rp+d7L3q
         SX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740019562; x=1740624362;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z/D3678QYRZKxPCIowYLLtnEL0WC8u1sCf7aliAuVuE=;
        b=Wejy5vA1dLyntxn960tiIwDl7l7nYURcY2+ZeeO4AxXP+5Lh9j6QiUyQhb5a/X9wRf
         80ZGYEaLl8wopN/Ciick6a9rWmPMtpNPStqDU9b82qbcwNUebPTw2xi2Dl/C+6118AW7
         XlgCfoZt13ps7yieEzPbZfODVE/XJRIrJ9NO2RdQZDjLfcJhpXgm1UyKcc0Rg3liAt4n
         Vl6UN4U5YbeVDJ8r6idjoJ3hT1zRetAz4WYEBvT2AbIZ8k6D2/Wj9YU2SkodjSdXDVap
         YZq7Iq+qTlrzfwsVqLaCnFVyh04LeWRxx+uW3X8ghxcQSNZ/wrTaFRBZKHapsMf/Q3Qt
         lS4A==
X-Forwarded-Encrypted: i=1; AJvYcCVQDteKADtOxNI4XqqUVfJsDj/tspoJ5W7qCK8cHa3VEpLmuaF5WglilFX3v68DsLVzN8A=@vger.kernel.org, AJvYcCXlkdpyD1ny1Z+6y+TAv7PtqCyi5tHmHwePyQX+yNM1jpkiOdNUfVOMqCnzHd3TkxNWBvBxoRZW@vger.kernel.org
X-Gm-Message-State: AOJu0YyRvynN3NIcluLB96OcBnPZW6yZoqMNxQvxVMxz5abuBL1HWv7t
	gQsrc3YYYtDb7nwQaN8fvbJ1vt9NDns26FIBZr4qOcSmjnMvJdCYJHOUnQ==
X-Gm-Gg: ASbGncu1ujSGcFGHLOGPUedLs0IgFyLmcUtx+hpyUMA36+g6Q1wTBA8EEDTqoun4P5T
	wL6cLtPdPyYFXw8ZmZeVX5LvZ/44yKrJ+kgK5XVsppXupCdo2QLdxVIzhJsOypmKp6RnUTOnnw9
	OBy0Vj2AeMrbXB4/XcHJ8/tESiJJHwLLya/LUIZn57sotgBO2tAY/5BTvA5j52EG4THtFfx5gyn
	phaJLPg2uWbIWXFEBMmK07aWDe7FCSLgvaxrDdnKCiZjerDASbPOMupWvgL9Ys7a2r0e+vMzvec
	zSbccWtEa1hQ0+awmOvQAFc+3UI1UGIJyLRuYOPQpN0h6rhA69WASCp2lN7c7T8=
X-Google-Smtp-Source: AGHT+IEG9YapflJf2cUv8UVoSRBdPpMklvTrO3BRiqvzN12JeBtxzTYK7SAEFKyyNJwNn4PZ61++XQ==
X-Received: by 2002:ac8:5e0a:0:b0:472:1040:10b2 with SMTP id d75a77b69052e-472173e1c5amr14212311cf.39.1740019562567;
        Wed, 19 Feb 2025 18:46:02 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47209a1b133sm14864501cf.70.2025.02.19.18.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 18:46:01 -0800 (PST)
Date: Wed, 19 Feb 2025 21:46:01 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67b697697bdf8_20efb0294b4@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCJNM3YyLQpFCCUtHPN7dU+o721yBYE71+hs9-1r937Xg@mail.gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-2-kerneljasonxing@gmail.com>
 <67b497b974fc3_10d6a32948b@willemb.c.googlers.com.notmuch>
 <03553725-648d-467f-9076-0d5c22b3cfb3@linux.dev>
 <CAL+tcoA==aPOmBjDTOi2WgZ7HEE4OJiZ+4Z-OD_yGn_XN2Onqw@mail.gmail.com>
 <67b542b9c4e3d_1692112944@willemb.c.googlers.com.notmuch>
 <CAL+tcoCHsJ9KQf5w6TLHmQy9DrkhPHChRPQb=+9L_WKTTd8FQA@mail.gmail.com>
 <67b5f4f5990b0_1b78d829412@willemb.c.googlers.com.notmuch>
 <CAL+tcoCJNM3YyLQpFCCUtHPN7dU+o721yBYE71+hs9-1r937Xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 01/12] bpf: add networking timestamping
 support to bpf_get/setsockopt()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > Can you find a hole further down to place this in, or at least a spot
> > that does not result in 7b of wasted space (in the hotpath cacheline
> > groups of all places).
> 
> There is one place where I can simply insert the flag.
> 
> The diff patch on top of this series is:
> diff --git a/include/net/sock.h b/include/net/sock.h
> index e85d6fb3a2ba..9fa27693fb02 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -446,8 +446,6 @@ struct sock {
>         u32                     sk_reserved_mem;
>         int                     sk_forward_alloc;
>         u32                     sk_tsflags;
> -#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
> -       u8                      sk_bpf_cb_flags;
>         __cacheline_group_end(sock_write_rxtx);
> 
>         __cacheline_group_begin(sock_write_tx);
> @@ -528,6 +526,8 @@ struct sock {
>         u8                      sk_txtime_deadline_mode : 1,
>                                 sk_txtime_report_errors : 1,
>                                 sk_txtime_unused : 6;
> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
> +       u8                      sk_bpf_cb_flags;
> 
>         void                    *sk_user_data;
>  #ifdef CONFIG_SECURITY
> 
> 
> 1) before applying the whole series:
> ...
>         /* --- cacheline 10 boundary (640 bytes) --- */
>         ktime_t                    sk_stamp;             /* 0x280   0x8 */
>         int                        sk_disconnects;       /* 0x288   0x4 */
>         u8                         sk_txrehash;          /* 0x28c   0x1 */
>         u8                         sk_clockid;           /* 0x28d   0x1 */
>         u8                         sk_txtime_deadline_mode:1; /* 0x28e: 0 0x1 */
>         u8                         sk_txtime_report_errors:1; /*
> 0x28e:0x1 0x1 */
>         u8                         sk_txtime_unused:6;   /* 0x28e:0x2 0x1 */
> 
>         /* XXX 1 byte hole, try to pack */
> 
>         void *                     sk_user_data;         /* 0x290   0x8 */
>         void *                     sk_security;          /* 0x298   0x8 */
>         struct sock_cgroup_data    sk_cgrp_data;         /* 0x2a0  0x10 */
> ...
> /* sum members: 773, holes: 1, sum holes: 1 */
> 
> 
> 2) after applying the series with the above diff patch:
> ...
>         /* --- cacheline 10 boundary (640 bytes) --- */
>         ktime_t                    sk_stamp;             /* 0x280   0x8 */
>         int                        sk_disconnects;       /* 0x288   0x4 */
>         u8                         sk_txrehash;          /* 0x28c   0x1 */
>         u8                         sk_clockid;           /* 0x28d   0x1 */
>         u8                         sk_txtime_deadline_mode:1; /* 0x28e: 0 0x1 */
>         u8                         sk_txtime_report_errors:1; /*
> 0x28e:0x1 0x1 */
>         u8                         sk_txtime_unused:6;   /* 0x28e:0x2 0x1 */
>         u8                         sk_bpf_cb_flags;      /* 0x28f   0x1 */
>         void *                     sk_user_data;         /* 0x290
> 0x8 */
>         void *                     sk_security;          /* 0x298   0x8 */
>         struct sock_cgroup_data    sk_cgrp_data;         /* 0x2a0  0x10 */
> ...
> /* sum members: 774 */
> 
> It turns out that the new sk_bpf_cb_flags fills the hole exactly. The
> new field and some of its nearby fields are quite similar because they
> are only/nearly written during the creation or setsockopt phase.
> 
> I think now it's a good place to insert the new flag?

Thanks. This seems fine to me.
 



