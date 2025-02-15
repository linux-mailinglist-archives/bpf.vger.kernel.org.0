Return-Path: <bpf+bounces-51662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E02A36F05
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 16:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28C41892ED2
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7301DE2A5;
	Sat, 15 Feb 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTJCcNjQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86B42AA5;
	Sat, 15 Feb 2025 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739632516; cv=none; b=o9Hi4UEOxAn6z9g91BZWR52We98U0JKe1/ADivp2R3yVw8z+thdYSs3PXfjyGCAAcj61QtlJDeeYM+4uaHv7VtBVIJR8mWWZjnBQscrYzyDEHhGmHXjto0bnI3xcbnISFBY6HSEnxRDG8LQlcSWmdf47C2RpZV9mwDWqWr//l60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739632516; c=relaxed/simple;
	bh=4fVw09bb5CiP2xmXXw+nw/uWtvNNYmeLan3b7sJ7m2Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BMI/hQ5raxHgG6Yw43O3Kiy1acAgFhpRCQ/P/cU/L/IXfL0bIGiBKAZEoo8gaQ+e5E4sxjgQdkURZXJeXrE0sJg8/X1MWgUiizxBVF5q3VAKYsASxJRP8B1KCkE8yo71jrLBd6Ab1yCn5eCY7Edj4XtKdV6GMjoMCEqcRbMU58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTJCcNjQ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46b1d40ac6bso27052701cf.0;
        Sat, 15 Feb 2025 07:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739632514; x=1740237314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKT5nCt9I/ELe+hGD2lnSdVRFjBLW3uu/beDimn+qTc=;
        b=nTJCcNjQgOfBwJYRGR7g9MnDOLnUbhORUFvHVR3N8WOpgma9VUjpx4X8r3k/hduFuu
         ij9sWfNakpN4bjhdl8FXWuY5LOXidUHxJWAuVhjg+78QOoapE6bw4naZTIwgqUWf1Blv
         bGUgY3Uwz+WGd58Gub6+wgTfL+6GxGbBIpzoyzI3mwXusppfvUjwh/kZ8+2CKTpb7D7u
         KY0b5akx56QtNzyqY88rBqZKn7ucJL2wJR8SdX8F4SRye7VGK7V4KVpVr9Jd3GAldfYI
         kaoL+xsehys3otNhuncT3hcKnBMV5T73H7IliGJ44p7xsgTSvmhASzMRfn8FjwWJTeyz
         eyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739632514; x=1740237314;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dKT5nCt9I/ELe+hGD2lnSdVRFjBLW3uu/beDimn+qTc=;
        b=HrUchccdO6GNGj4A+PEhmGRYlrn3vlE+vZNt1fzK5RCOj6TYEDVWBjXL67nyZ7dRqJ
         z+ratvQEvcgvExPTCLxFKEtLfMCSV+l5dJI6OVIFOqM03K9qNnyjF1tQjj1sNeRbTfni
         fJb0yCCDNXW4TdqfGu4mbIKH4YjXpk8YcwhfSA8vHqHzeB8vN/6xR8k+/Eu/WFf65TMf
         z8T4gTx8LQcQYoi2+z6UqBCfkXew0YGZtXm74+3mxsz49PYjBULgjYooY2FuSVMm/ACn
         E3aD51/hLMNBqKdqs+fm8kDffgLRNMQ1vXaYYiQNI+wls1RsKBnJxMNtBcGDvgq6HZ3U
         9AQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgGZvhzTGBAhaoshtpmyvAsoDJxcnGhNFQoDOQKUSO2+wWA/SrrCMWMG9FkJi6XhlZDzUvuHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrep0tAd11+JfSdWPmL5elme9GtCUYzKUuIkjXICWtQCHEQlP4
	TRKjJpJ73pFQ1zi2T0+FVYBcsEg1kDJS8wk1XRHSJcvI1X8m/8Ax
X-Gm-Gg: ASbGnculC08cShLII8S9FuQoD7HK+Im9hPMYIa4icMf0YQpAplw7EuaozaNayCpGZI2
	ntP0EF8ul93R7r6Ek4znAJt6fMge7hiT1YwSAyhiX7+3blzFdBcqVMh6ymiNVMvSf2l61PS1Wbm
	Xv63QcJCwl+m0zL3zLxTC+Gphk0KJUFp+QytV8CZAlpvayxm4hkOsZi6tGH6JyvKmcpAAsTGKrL
	8ownveBlf8yMRZlpnpw5av2USRQ8mRQeLEjTmeriPybKUMup0iyD1U3E84ecKRWFZGx8qE12ddE
	vU4xY+d4SOmFFFIEYlWSWgj58R541In1FkkU9RsND+XKHwnzLpbUWI5J/q3Pw2w=
X-Google-Smtp-Source: AGHT+IH6IY4E+y9BR5rFO/oYDgm5mqppNyBgyfVbIoXbd0C117EjM2CHaf7tL/NKp1G7knxVt++Xgw==
X-Received: by 2002:a05:622a:293:b0:471:96af:276a with SMTP id d75a77b69052e-471c0217772mr176641261cf.24.1739632514229;
        Sat, 15 Feb 2025 07:15:14 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c29e9261sm28323761cf.5.2025.02.15.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 07:15:13 -0800 (PST)
Date: Sat, 15 Feb 2025 10:15:13 -0500
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
 horms@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b0af817bb1b_36e34429417@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250214010038.54131-13-kerneljasonxing@gmail.com>
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-13-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v11 12/12] selftests/bpf: add simple bpf tests in
 the tx path for timestamping feature
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
> BPF program calculates a couple of latency deltas between each tx
> timestamping callbacks. It can be used in the real world to diagnose
> the kernel behaviour in the tx path.
> 
> Check the safety issues by accessing a few bpf calls in
> bpf_test_access_bpf_calls() which are implemented in the patch 3 and 4.
> 
> Check if the bpf timestamping can co-exist with socket timestamping.
> 
> There remains a few realistic things[1][2] to highlight:
> 1. in general a packet may pass through multiple qdiscs. For instance
> with bonding or tunnel virtual devices in the egress path.
> 2. packets may be resent, in which case an ACK might precede a repeat
> SCHED and SND.
> 3. erroneous or malicious peers may also just never send an ACK.
> 
> [1]: https://lore.kernel.org/all/67a389af981b0_14e0832949d@willemb.c.googlers.com.notmuch/
> [2]: https://lore.kernel.org/all/c329a0c1-239b-4ca1-91f2-cb30b8dd2f6a@linux.dev/
> 
> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>

> +/* In the timestamping callbacks, we're not allowed to call the following
> + * BPF CALLs for the safety concern. Return false if expected.
> + */
> +static bool bpf_test_access_bpf_calls(struct bpf_sock_ops *skops,
> +				      const struct sock *sk)

Is this parameter aligned with the one on the previous line?

This line was changed in the latest revision. Still looks off to me.
But that may just be how the diff is presented in my vi.

> +SEC("fentry/tcp_sendmsg_locked")
> +int BPF_PROG(trace_tcp_sendmsg_locked, struct sock *sk, struct msghdr *msg,
> +	     size_t size)

Same

