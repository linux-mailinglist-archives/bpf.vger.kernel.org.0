Return-Path: <bpf+bounces-55191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380EDA798A1
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 01:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C6D3B177D
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 23:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187B11E4A4;
	Wed,  2 Apr 2025 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByrgyDWb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD3873477
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743635777; cv=none; b=OpYnYCE5CignDYiBnoLv3FOOcUMxCE2aFK2mqCRCRaGyqEJngwsB4Ypzl+YCOWPG3spplG9kyxGuuGGr2doC8Lysjeba0HxCxu1vHd7oszJMnbGgrolHgTBxTB26vTO6KM8dyYk/gcSivTPggm5TMdnWV1XtyiXsALNtQvWmwM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743635777; c=relaxed/simple;
	bh=7nU3wF/hNI3BWbIJavL+EhYiyClmxpLepeAYWslqpx4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+igivWuedcx0M6yd0pKV2HTy+Ldr751SpCe6dv/tsbH7uIDQ5VScTxBjzYeya+iylVlAwwaouJUC00g1mlj9oU3YAAYefQkb5hYWivux78LUdL5XOyEdvFaUtGEdcquqQbw3DyBXc9NXaWbBtTJN22d1Xzd4uVE5+eyjITZzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByrgyDWb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7399838db7fso268622b3a.0
        for <bpf@vger.kernel.org>; Wed, 02 Apr 2025 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743635775; x=1744240575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT777iuG8vl0Ow8PdePxcqyHqzT4ya3KTCCQ2z3+nBw=;
        b=ByrgyDWbSju99H0u84FcYwA3UEzlIUyTOki4vN5wUtR2+bPyohhRtceDGk2kwXU0T6
         Ej2UzLX8pGXxUxsfoHm+LQHOnR/59ptnnkonuOHXIrDI5eyBy8w6DE+8cWxPhF/A4Kzn
         VdRR9xbaJ4pWftsbdB9pXvBTorGNHzfTVZfj5iOgUgsymJ2B8r7aJ0NELstkoeRZOey5
         tWz118d+w+pz74YOoi6x3J2PxQ8J1uT+n2Ta5jH0XIeQ9awE5Ikpce7acRKaR1f1qPib
         OzNPzAqCRzIS6Cbwq+9VVQlMI+duyYZ2vWo4nX5bhMNJwRmpzxHSJ1MSrbJpgkGp/CkF
         Bkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743635775; x=1744240575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT777iuG8vl0Ow8PdePxcqyHqzT4ya3KTCCQ2z3+nBw=;
        b=qYGhXXpEFdAGUpLe1x47sAcFcwGTJ56uOheMDAZ5PgKUQ+fL4aFMquMmMoXrNXyLDx
         JYKHTesp2nsnk8IQTpKiEOic3Kud2AiwG3NHGScruHC62U+tOYODS4hnG/0VWEM9Rm4n
         no1dXYnOLGyvlGA6Sx0Xl62NfzBsFGGxFM7j0FM51tGKUzQeMhhVSDORtWYvledKh2qF
         HV0yyunUOzAOiAbLnLVHRnIQCgwZAkz/nPgAnDG+efA9aXql/EtyPZqJ3ywRMfkbBzWC
         gufWAY+3hSehVAlsVp1CEQdOKRIMNVihpUQO9BYlihFzwjNzyV76saOTk/ZvHDrR9dyn
         L6QQ==
X-Gm-Message-State: AOJu0YyNmRY1kgIScSIjNNobxka56qCmGssw+FA0lNuxgLm7aAcYOqzk
	lIZmE2QGS8Y/LXECrILlU0mhEWZE2gJCuVt0UXVeAOXlMQHR8aB4Pnj4vA==
X-Gm-Gg: ASbGnct8GK4WpEysu22w4+DMjA7gh0Mi/DBQQkV4Rm7d4lYEpwlhV1dBUJduwtdK3Ew
	BElba6EVUX24eHVId5Lt1FDDMVF5P3DHCN7ZiGSbsp9b37LDWx6m2DyXFLUmkgc/OxE5ZFulyLA
	Omkrtx61bjMXzinGuPVvttu5r+WehbSqeOh02c1Cf64+gLwSvsXbjoJ4APQ4/G6fgcQ/MuuVR+C
	0k76bfctb8/QXgyby9YIXqyfHU30g1bvQ5QMnxP+TDwhdorj2Hs5I4YPoL1Op9+fobNK7bVv/y2
	rStoyhuyh3iMADIUwg0ZPrTCF7vy7ALN17stblGMnuyS
X-Google-Smtp-Source: AGHT+IGngBhgPMvC6OxI9YI3dajaNnGGvc3lpg7j7E4VeiThM3QTEP5X/X9uN9ubR4EcvJ3k6cF//w==
X-Received: by 2002:a05:6a00:8617:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-739d6351a52mr1420656b3a.1.1743635775138;
        Wed, 02 Apr 2025 16:16:15 -0700 (PDT)
Received: from gmail.com ([98.97.40.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0b2f66sm71668b3a.125.2025.04.02.16.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 16:16:14 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:15:48 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: bpf@vger.kernel.org, jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v2 1/2] bpf: fix ktls panic with sockmap
Message-ID: <20250402231548.5d242cty2r4msj52@gmail.com>
References: <20250219052015.274405-1-jiayuan.chen@linux.dev>
 <20250219052015.274405-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219052015.274405-2-jiayuan.chen@linux.dev>

On 2025-04-02 16:10:21, John Fastabend wrote:
> From: Jiayuan Chen <jiayuan.chen@linux.dev>
> 
> [ 2172.936997] ------------[ cut here ]------------
> [ 2172.936999] kernel BUG at lib/iov_iter.c:629!
> ......
> [ 2172.944996] PKRU: 55555554
> [ 2172.945155] Call Trace:
> [ 2172.945299]  <TASK>
> [ 2172.945428]  ? die+0x36/0x90
> [ 2172.945601]  ? do_trap+0xdd/0x100
> [ 2172.945795]  ? iov_iter_revert+0x178/0x180
> [ 2172.946031]  ? iov_iter_revert+0x178/0x180
> [ 2172.946267]  ? do_error_trap+0x7d/0x110
> [ 2172.946499]  ? iov_iter_revert+0x178/0x180
> [ 2172.946736]  ? exc_invalid_op+0x50/0x70
> [ 2172.946961]  ? iov_iter_revert+0x178/0x180
> [ 2172.947197]  ? asm_exc_invalid_op+0x1a/0x20
> [ 2172.947446]  ? iov_iter_revert+0x178/0x180
> [ 2172.947683]  ? iov_iter_revert+0x5c/0x180
> [ 2172.947913]  tls_sw_sendmsg_locked.isra.0+0x794/0x840
> [ 2172.948206]  tls_sw_sendmsg+0x52/0x80
> [ 2172.948420]  ? inet_sendmsg+0x1f/0x70
> [ 2172.948634]  __sys_sendto+0x1cd/0x200
> [ 2172.948848]  ? find_held_lock+0x2b/0x80
> [ 2172.949072]  ? syscall_trace_enter+0x140/0x270
> [ 2172.949330]  ? __lock_release.isra.0+0x5e/0x170
> [ 2172.949595]  ? find_held_lock+0x2b/0x80
> [ 2172.949817]  ? syscall_trace_enter+0x140/0x270
> [ 2172.950211]  ? lockdep_hardirqs_on_prepare+0xda/0x190
> [ 2172.950632]  ? ktime_get_coarse_real_ts64+0xc2/0xd0
> [ 2172.951036]  __x64_sys_sendto+0x24/0x30
> [ 2172.951382]  do_syscall_64+0x90/0x170
> ......

Sorry for the broken send there I hit send on accident. New laptop
doesn't have all the right config yet.

> 
> Fixes: fcb14cb1bdac ("new iov_iter flavour - ITER_UBUF")
> Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  net/tls/tls_sw.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

I tend to agree this is not a good situation. Returning 0 is probably
suspect as well and likely breaks some applications. But considering
we already have this behavior I think its best not to change here
if its not causing trouble.

And not panic'ing is clearly better. So...

Acked-by: John Fastabend <john.fastabend@gmail.com>

> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 914d4e1516a3..f3d7d19482da 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1120,9 +1120,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  					num_async++;
>  				else if (ret == -ENOMEM)
>  					goto wait_for_memory;
> -				else if (ctx->open_rec && ret == -ENOSPC)
> +				else if (ctx->open_rec && ret == -ENOSPC) {
> +					if (msg_pl->cork_bytes) {
> +						ret = 0;
> +						goto send_end;
> +					}
>  					goto rollback_iter;
> -				else if (ret != -EAGAIN)
> +				} else if (ret != -EAGAIN)
>  					goto send_end;
>  			}
>  			continue;
> -- 
> 2.47.1
> 
> 

