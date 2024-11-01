Return-Path: <bpf+bounces-43793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E199D9B9AAC
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 23:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152D81C20D38
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 22:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C5F1E630C;
	Fri,  1 Nov 2024 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NznnpcGo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A9140E34;
	Fri,  1 Nov 2024 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499123; cv=none; b=gNJcAca1fNAGlYfXvfz2ZIeLgmpfxc/waf6rKccsBJIXSw8ZQETsMmHPFqZ5SAxagaBGsUgCb99r7cCVEFptlnLgZjli972PVW8BU6Dy5zMNACLXCEXSibWFSz9XmQS0N19DUedJBs9A5fpxsh4T+0SyhM9u8SlaBN61lZNXtCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499123; c=relaxed/simple;
	bh=jW0GasPsTPu1f1+v576YPI4v7YlsfDlWf/ACdBElNwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjNui3lfxdoaWxZ0FAwUtJUYao+yb0J76auSyNX/rProth/AzQx3r1nPPwtmdwukggkxN3eSKM1tBRGY0lJcsvnew3E0ipQlZNz4XsDs3mAt06bieRJ70TSCnITQQCMd7bqdofegZCVdyWsBdxAxg5WjehMGHpyvHlsANySBer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NznnpcGo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cbca51687so23178545ad.1;
        Fri, 01 Nov 2024 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730499122; x=1731103922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bszg8jg/Sp3Zup3ggoQ5aIB/d8jLcYiXi5EW/ZQs+m4=;
        b=NznnpcGoYfs7xBjH9sXVK4HHcpxg+o60OkqHNFMsuXMTyupSHRtjjummLtCsG+BaQo
         bGpC7mJA4eVUAHqp5jAiD2lu8SCayQPnZ5c7X9TxO9kdaF5GsYXhxPO/EIaQpO+IZWiC
         gd0DByWzpbUUzuqYPZB9zDPphv0dDKmgD/e+ZJ4t7TR/mmhTFAQaab2WCLO+H7gHiK7K
         crEVJ4HFRVo/s2F3nb8sSanWULzNoO/pE9uUo91kyCudxYUHmLAEKxdzbmD0JNUHZeRz
         IaZa2d5eX6/y6v1xX7pWB2hrdzkfCgun/TnBjto5JszV2vVsK7WAzBiiFYLaS/jyb7+C
         mzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499122; x=1731103922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bszg8jg/Sp3Zup3ggoQ5aIB/d8jLcYiXi5EW/ZQs+m4=;
        b=l77B5o0I7DcfoK6DXsJmFfnrlO/y42fJr6pIxEfmkmgrrsPVWFuMAJMZr/1hFvdvuh
         mJg6XA0P97PsuirTds8tUHGt55jxL19F23GdZZfLwrCvQSDA2p/+FbT6WkQL/R3hRGBY
         JdKk/upplTwENBeECYnmpbFBdScZDzZGVCNi0p9vGeDuDtV/mOLs/gGhVaN0wiNxquqd
         qWE3aog7rGctQI20g2Zy3du8kBgjUYMg3gE0hihvRK33bArcKIg1uzq2FQFv64/vklfA
         aZihGP7HnMiBAYSjuBz3ZzSnLYunXvFwFfi+uhk3cF3VK6OYx9StehOHNzZDBFByMTBn
         +Lww==
X-Forwarded-Encrypted: i=1; AJvYcCU7WhvbKfh9kpx+2ypQFPsV/L1FbPJpb2HVRTLPKrb9E3uYHj7+SqXDc63v4Xj3ErtK7wAiKJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+qVSFEvdZeG3tV/YRL25aBXNUJkuNP/p5TDnqtCBBx1ao9eU
	CdXBqGzJoVSBEMGH8uUu68Oo82qqF/hvJ8Uir/WDfzw2eEXVHpXW
X-Google-Smtp-Source: AGHT+IFSULHrOg0niXe5BOPihzV/4gPHyM0EUeI2NJ4HUlpMsIXyJfymmbQoboQeZcMm5uZjKofIuA==
X-Received: by 2002:a17:903:41d2:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-2111af914b0mr59514745ad.56.1730499121733;
        Fri, 01 Nov 2024 15:12:01 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:be2e:c8e6:bba5:abcd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c0f11sm25688575ad.200.2024.11.01.15.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 15:12:01 -0700 (PDT)
Date: Fri, 1 Nov 2024 15:12:00 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: zijianzhang@bytedance.com
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, stfomichev@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf] bpf: Add sk_is_inet and IS_ICSK check in
 tls_sw_has_ctx_tx/rx
Message-ID: <ZyVSMM7u2NBfjZeI@pop-os.localdomain>
References: <20241030161855.149784-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030161855.149784-1-zijianzhang@bytedance.com>

On Wed, Oct 30, 2024 at 04:18:55PM +0000, zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> As the introduction of the support for vsock and unix sockets in sockmap,
> tls_sw_has_ctx_tx/rx cannot presume the socket passed in must be IS_ICSK.
> vsock and af_unix sockets have vsock_sock and unix_sock instead of
> inet_connection_sock. For these sockets, tls_get_ctx may return an invalid
> pointer and cause page fault in function tls_sw_ctx_rx.
> 
> BUG: unable to handle page fault for address: 0000000000040030
> Workqueue: vsock-loopback vsock_loopback_work
> RIP: 0010:sk_psock_strp_data_ready+0x23/0x60
> Call Trace:
>  ? __die+0x81/0xc3
>  ? no_context+0x194/0x350
>  ? do_page_fault+0x30/0x110
>  ? async_page_fault+0x3e/0x50
>  ? sk_psock_strp_data_ready+0x23/0x60
>  virtio_transport_recv_pkt+0x750/0x800
>  ? update_load_avg+0x7e/0x620
>  vsock_loopback_work+0xd0/0x100
>  process_one_work+0x1a7/0x360
>  worker_thread+0x30/0x390
>  ? create_worker+0x1a0/0x1a0
>  kthread+0x112/0x130
>  ? __kthread_cancel_work+0x40/0x40
>  ret_from_fork+0x1f/0x40
> 
> v2:
>   - Add IS_ICSK check
> 
> Fixes: 0608c69c9a80 ("bpf: sk_msg, sock{map|hash} redirect through ULP")
> Fixes: e91de6afa81c ("bpf: Fix running sk_skb program types with ktls")
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>

Reviewed-by: Cong Wang <cong.wang@bytedance.com>

Thanks.

