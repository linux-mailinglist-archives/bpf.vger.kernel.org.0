Return-Path: <bpf+bounces-51831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C6CA39EA7
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 15:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123143A1301
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730F626A08C;
	Tue, 18 Feb 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIli0xUI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83820236A61;
	Tue, 18 Feb 2025 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888573; cv=none; b=c7Z/NXX7tjlruKW0WblPYstq4iz6lVofsbiKUnEW+Cqj9bJF00LkxTwlycRUo2Whb0AOlZJukMt8Z5G51MfvyAR0DVmXShd3qkvQOEoGNxqFTAgL8wG+8kFrbSnkt3bxUiXnGD2fELeBJnuGCH/E5iP39LVu2PVjYzjg666oQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888573; c=relaxed/simple;
	bh=0wFK74nRz6hSW4dUiFbeWXBLJ2a2mbu9jh86FQpiI5A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=D55/bv15EQmOxxAsOlizf7+DJJcoxTI6CkoRJRkCyY6E3aPre1z52qoG03vjZ1LMDK29/FCV0Cv0hgzU4QsfTAfIfY8+YP6gxdobi6/Q1Hc5yW9zWfbwtoGpPX+IMEhHPSf/nqybSYWsavSRIQ4P40cN1nW0nLamyUKqsoCPooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIli0xUI; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0a1c4780bso163608985a.3;
        Tue, 18 Feb 2025 06:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739888570; x=1740493370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzEPDO0hjyTJEbk/McVN4L7lL1Vzd/kUngK1QpoiwLQ=;
        b=LIli0xUIS2PKH+mr4rYMF0JDfNEsjVemRYmX9xpU98iZbMhKUxzLRH3Y7FM4mmyTXj
         zvQCK/yefu+79VU9w5HQBhjeUn5v/r/rHPmMpv5BbEgWUf5PvcUIjWmdlCkSFFC7xZxa
         NxrQ9FhooyRD+aBq5ySKPbZJuHFlaLa+oxnGS0KvByd+WBMKGrBw3veVf1U+sg5jlfJJ
         omsOJFJc780ocUefLiT0yi3hrjgb/uUdHgD6BjGzgz5/wwCSeq5F3USCjAgLk0BQb4EE
         0dzuEk49E0puw6jI9dTpFNJqGy5sy+Lh6X3vX5uU6gZv5YQ+7TvmBIv92GaSPuabgxZD
         2F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888570; x=1740493370;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jzEPDO0hjyTJEbk/McVN4L7lL1Vzd/kUngK1QpoiwLQ=;
        b=iwXwthcBE925N4Zt6/OARdcA8q7xnfMw5M0qonPeeZN+Ef0eWtMpElIUsStPXTeNHW
         jk13mWW+EtIREsSb9eks+2VRGQEubK2TETf5wjK6CECOaqZiU1M7aPEUZ4GA3b5GYeG7
         Pht/PFtojyZSzY8XHcf6+mMDBWGXaSqwwKzwRAtPoLyuQYohQfgcaM2zAJLdoX1EQI/r
         YQbNMaWmGtPoU/PWVJ49NIE2qGTWw9bn6SKC4ox8XbMMfY8A15k2KrINKTqUBf8WPw73
         R0/kVAfOVSWiDIk/XwMLweXgoHuZi6fnvj4teGAkfsWQ2YWi9LnYea1Wikfg0Nb5wz9S
         4I2g==
X-Forwarded-Encrypted: i=1; AJvYcCVmvC/TXFYdFbKhKdSGNqKh5FJ5EPz7ZD7BJ9l5Hp5ffInwG9eG1UOwgI3eHFN/M5I+QeNmung=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPI8Q1ZmtI+MKiS3Nr+/INfYXvoqF1WTwORIm3gUmVjKM0VaU5
	TkD0z9mc+jUJ0BXoarIY+vWxJ0WtVWCIAAU824TnQB4dAm2XABF1
X-Gm-Gg: ASbGncsGuo5q7VNMcWdT666vV1Wjjzk37eTup30m16WhGuzbLE2SMQJpyXn7ac/o1xW
	LEBNgJLZAJ/MqG7LnomMQp/Pd79HhjJlPYMfI8BB9S3sIdfLCyQ2nEgVe6MoFSv0Zyc9S6aVFG2
	Dt9zOUjgzswnAJiFye5mMquEKkTKzlJC59qJPCe6/Orm28huW+2o51Sx6x6YYJEQU89flSBO0mJ
	YPr4Kx0L2RS+ryJcsTjFjfA/UDqbFmAFrNPtUhE/ajNgdp+oYzrDTGQBKijWcL2z6BNRH3ndP/J
	t3j+/Uew1pRTLTYStbJQs/AFVgPcA7ExQYcUWYW+rPTNdFXaGd5w7ItUcagrBpE=
X-Google-Smtp-Source: AGHT+IGSP3xsvqYYawpErGQJb6MG0d8ImmyzsvRrJ74C8aR/7Usztki7c03g2HNgAnMtsOj34+Rmqw==
X-Received: by 2002:a05:620a:2605:b0:7c0:a28e:4960 with SMTP id af79cd13be357-7c0a28e4b15mr976615485a.32.1739888570234;
        Tue, 18 Feb 2025 06:22:50 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a0baa1e9sm227754485a.72.2025.02.18.06.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:22:49 -0800 (PST)
Date: Tue, 18 Feb 2025 09:22:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b497b974fc3_10d6a32948b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250218050125.73676-2-kerneljasonxing@gmail.com>
References: <20250218050125.73676-1-kerneljasonxing@gmail.com>
 <20250218050125.73676-2-kerneljasonxing@gmail.com>
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

Jason Xing wrote:
> The new SK_BPF_CB_FLAGS and new SK_BPF_CB_TX_TIMESTAMPING are
> added to bpf_get/setsockopt. The later patches will implement the
> BPF networking timestamping. The BPF program will use
> bpf_setsockopt(SK_BPF_CB_FLAGS, SK_BPF_CB_TX_TIMESTAMPING) to
> enable the BPF networking timestamping on a socket.
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> ---
>  include/net/sock.h             |  3 +++
>  include/uapi/linux/bpf.h       |  8 ++++++++
>  net/core/filter.c              | 23 +++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  1 +
>  4 files changed, 35 insertions(+)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8036b3b79cd8..7916982343c6 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -303,6 +303,7 @@ struct sk_filter;
>    *	@sk_stamp: time stamp of last packet received
>    *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
>    *	@sk_tsflags: SO_TIMESTAMPING flags
> +  *	@sk_bpf_cb_flags: used in bpf_setsockopt()
>    *	@sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
>    *			   Sockets that can be used under memory reclaim should
>    *			   set this to false.
> @@ -445,6 +446,8 @@ struct sock {
>  	u32			sk_reserved_mem;
>  	int			sk_forward_alloc;
>  	u32			sk_tsflags;
> +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
> +	u32			sk_bpf_cb_flags;
>  	__cacheline_group_end(sock_write_rxtx);

So far only one bit is defined. Does this have to be a 32-bit field in
every socket?

Sorry for the late notice. I had not followed the BPF part closely, as
that is not my expertise.

