Return-Path: <bpf+bounces-53847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33488A5CAB6
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 17:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE16189BA65
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB3A25C70A;
	Tue, 11 Mar 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlK+9P1n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2491EB180;
	Tue, 11 Mar 2025 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710201; cv=none; b=nB6Iq1wCfvKs0gkO5pVPpmHFGkMcpHlI2YV3mLQ6yP3sgeoldv7/Cs99sXPHWAGZXk6UmX27wo2HGVbvLjGg3qNs/yHkNYr0JzWrJalJZzG9cHrJooE0aLnyQhzmrSIbteLvmNZiN0P4NOVdJZEnrWnHnvhWoFvKtl35sShSh1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710201; c=relaxed/simple;
	bh=sCbfmw9mUciGYGwwBPd4GuSh5poYOFVJAiezu+rGBC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAc/dGAX/DcQgQyr10PPJqxTkpqKMlwdQ56VMv460/loFMSN68AaIT+3AN7ixQFB7s8Sgri6nESce74ACEqKusLrWNGHVYBMKKj19SzBmhIB6Rfpt2H3HyE3/3xppd9qNNU1e17zKQHnCOT+5Jmt77LQQ/iavIQR6SXD500sKVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlK+9P1n; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fea47bcb51so12071475a91.2;
        Tue, 11 Mar 2025 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741710199; x=1742314999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0uZy7l3qUOyL2Z+qKh/31yAZqamw3GAny1IbGC+/M5A=;
        b=QlK+9P1nkLspZhDtIvZH/5vKMF2v3aU4Sfa3nlwMemkPAa6mPH1aD+g+Xi/34uuhWt
         g6fmaHeMXUJM5w1FG870ej3MOJkrNatjMUVMB+g9w4bv2QL83rhNh2DmnoFEfb4pajUx
         GLB7pl5ofCiOAhZUz4tWxHoaZOB7EFMQAAJpdjtqcL4BMXIgwjpv9/9iTXUAHJpmp1jS
         Ya7iqEKUqKDauggzMyeJGi0a3puV/kT29pFFcJAE5trasOAlKDLum1eG7vT9o1hrABmT
         RPjcxiZLcRy93QfkgKiTt7zpqKuDvN25qNSmIBxlo9pvivjPkiXqVkxFaO9ET42RTuD7
         +ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741710199; x=1742314999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uZy7l3qUOyL2Z+qKh/31yAZqamw3GAny1IbGC+/M5A=;
        b=dCbSjcOucui0nCbkLi6rfDuYf3YqtKmHAB+BznhnAlY46JPLR+X4/krY6nEm9d8cMf
         B/QnKhZY70i6wFvrqSVIDXoNbu/4ZwDDTtPBOFzu16EsIpzwQCvpQwfzGCcANN9gBukv
         USE6Qth+nzecPz6l3e2tGNd7aZy6jnZlkm2piq0efLp0iHPdy8BOwuy9vXZ/+eVUdz56
         B+5080+2RYQfnBZuRxnj+B0qKb8Crl2C+QC8VRwDdlpgNYXhzfAYhlNgmSmYp7z5Fs5N
         xmA/doSiyFT8W/Qv82vedSIUybjIQk1/ksPn3oFFogIYB7dqYpAdf/7T52QTYtuj4Ttl
         DcVg==
X-Forwarded-Encrypted: i=1; AJvYcCUnMnWsjusc/l7P9/4WJmOtbEcOv+SvXa6qXZvo1QH0s+hbsJYjJ36O6Ui8auCxVet9WvRslcde@vger.kernel.org, AJvYcCWQY8iXyYvSXCttx+o+grFt8u8Ki5qMnTjpR72h6HyYeqz8lm1WoKjnGSIQCxt3pit3UII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bp8FfE9Aj4qdWrVToa1GjnstCG+9SIHLf0Mb+6fxuOmV6jx8
	mm5RYVIw5mmXoRk1ien5qG5I5s0Wjr2O60TTUq6wwTlObHVCh9fV
X-Gm-Gg: ASbGncub1LdlVJCdO8YX3brNG/aiml6Mdn+IQnRkmjj4JdKVcKgFS2NoaRy7M8xt7VH
	XdPFILVSIkeiXyJsoNCOcBUlRrCxe+fW+WgpVH4Awbfy5GZtHXSHerpF9Z0l/Q1mN2C2vmLeOcg
	detf8YetU0KU6yjomeDU3VDBlpgucymyNoWoiElizxGXpFWsay4o3i3Y6Dfh8UBDnaMTq9JCHEK
	Oyy8g50AAUBG5mHas12Uu9/4Q+WK5JxPdl1xO8UK3QLNYd15r8lvUlTworxabKMbtytBKKRTiUp
	w814VaZ+zIpDPnCcsfsx4LDN5eZMQ/GJUbzAPs6GNa3F1g==
X-Google-Smtp-Source: AGHT+IGMdwB06MoivJxS1E3TZw+tfdkhI+FhATOTvSARCD66DvrjOTftlxUBYqXk3EwqN+ZdB5oMkg==
X-Received: by 2002:a17:90b:5281:b0:2ff:6f8a:3a13 with SMTP id 98e67ed59e1d1-2ff7cf167ecmr28426519a91.25.1741710199455;
        Tue, 11 Mar 2025 09:23:19 -0700 (PDT)
Received: from gmail.com ([98.97.37.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e73b9sm10194315a91.38.2025.03.11.09.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:23:18 -0700 (PDT)
Date: Tue, 11 Mar 2025 09:23:04 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <20250311162304.5xcnjeue2uwrhswg@gmail.com>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>

On 2025-03-07 10:27:50, Michal Luczaj wrote:
> Signal delivered during connect() may result in a disconnect of an already
> TCP_ESTABLISHED socket. Problem is that such established socket might have
> been placed in a sockmap before the connection was closed. We end up with a
> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
> contract. As manifested by WARN_ON_ONCE.
> 
> Ensure the socket does not stay in sockmap.
> 
> WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
> CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
>  sock_recvmsg+0x1b2/0x220
>  __sys_recvfrom+0x190/0x270
>  __x64_sys_recvfrom+0xdc/0x1b0
>  do_syscall_64+0x93/0x1b0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Hi Michal,

Unhashing the socket to stop any references from sockmap side if the
sock is being put into CLOSING state makes sense to me. Was there
another v2 somewhere? I didn't see it in my inbox or I missed it.
I think you mentioned more fixes were needed.

Thanks!
John

