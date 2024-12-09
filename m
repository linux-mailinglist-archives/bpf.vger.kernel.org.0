Return-Path: <bpf+bounces-46376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9689E8BCC
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 08:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334DE163E9D
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2024 07:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CD3214819;
	Mon,  9 Dec 2024 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/DDjduD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5151EB3D;
	Mon,  9 Dec 2024 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733727733; cv=none; b=dH6NHZnMmfItvwJtTHXX+S5me2nMnF4icqVf3wzyRsyeuXUlZcYs90XZdJhrs+GVy03eE9HOMWiPdjbdNqQrAjXcikWM9x8Hzh771ncoqOmRqoOmEEX5FE7sfdH+sZQv26tO4fA1/lBb4pCcQ/2oSrqpH+v7xCLEKAbgIiDWxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733727733; c=relaxed/simple;
	bh=YBl6LFi40rhs5H+dxXbTihS8WOQiiHr2KVRd9BEL5Nc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=D2ZZ5NZGF2eabw+grZBlcaIfbEU6jI0hvf5GONi3Y9uqVUXecmTok5lQucamRVYobRsoK4IbuFOEDME3gjrGH2d+QAMt0OOjjQrZ2DdNY1vpt50tQo59iVtfVqN4yArXeb2V6D//HPBvzu9UHGlFunbF1E89ybOkYXYlsIZxUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/DDjduD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-725e71a11f7so525715b3a.1;
        Sun, 08 Dec 2024 23:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733727731; x=1734332531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGqOkCrxuELNm/ZW4EA4OB741J1yUUBRLHKG/f585KI=;
        b=T/DDjduDprrORB4/XkN4z7nNajL/A12Dip5IgAyn0ySIDkAn/ptIleWrWUW5Yx42lo
         KldJT+Tw9wMOTUEMU9RPhT2PBWZr/FwIUGgwbzGTZ2Ut80kTL6dqT3X7wBxuY8ZWNICQ
         B8Zu6hQmaeSBXVmNTnIoMVOankTVJfAqNkVwYEeykislNMM0jv7qX/0K7dOcrSXSSU4C
         S3j4R1efaufA90u9WQ8U8AxSDhH7dMNGtdhGVNlEHXqcHxvlrRvbxgAPryTaTedIeprP
         JDAbppnSFZ3TLfT0xPTX3EkP5cId3KdQpyy/+3V63Ic1GWciFDYk8/sAf+W83uum1v6A
         K4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733727731; x=1734332531;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AGqOkCrxuELNm/ZW4EA4OB741J1yUUBRLHKG/f585KI=;
        b=iJQxSd+dlwVFoJimfyHRsISJVUB1Eu8pNuJmaGaaYB8uKa3PuodfXLFwyrZvBe3uM+
         7y2HrwsfJWLb2mDSjY5w/VzjkTAWM1AiauzGgSRLPZnTd/GcyKMnzVzBO3/fIa0yAdhU
         yrWDzqf5wOTkYsw2V0hkpwsBGIns3qF1RI98oOhXYf1B7QOXgJppkr5YFvF4I5qZVoLV
         CaLV3MjeMV8aFWTlf3v4ylsk7psM+HotCO8AnzsZERbsYpnLIVTERrl4AaOIEsRIG621
         DIVsLmXEI8dxXaMY9LJsvAoRuM1vDAAb7+s3hu6wrIg6fvcgL4I7K8qqiDGXgRxdfywj
         yupw==
X-Forwarded-Encrypted: i=1; AJvYcCV8PzDWKLdVhHzixAVT+9C2gznzA2rjn7IoFpAYScg6IgZQLQzL3A8lCJxerqPh+A7sdZM=@vger.kernel.org, AJvYcCWLeeg5cS38bt2X7uKjQruWlMmBL83cGVkhmNtIk+D1t2vw4s282JxiBXMaHYNPBp09Cmsx0I+d1Hn3svKA@vger.kernel.org
X-Gm-Message-State: AOJu0Yyld/jOLPOtnjoaum7ME/Egtd6C1bp9o9Hn2VTAhI6TTMJQG12f
	2KZubEgzhlJWqKsxMuJsqy9HKSVCxZoSvYnPECV7tjZEF6vQ3E0f
X-Gm-Gg: ASbGncsIyWjMGK8zE96QxOeqzfpJzV9zKFBrAPEP3IBlamewEKhu0Ugx61F6Wt0F+Ah
	mfmqDlIIf1GLzZKBWXblVMXBoVoi0G+7S2scvfQjJC9j5TVWTq8YncXsdHVeHowbSbPPsdy8RXJ
	MA0/o1yViQfn/QwtpzSRG5xfdlKtDGevHwkBr6Q4oQPmfCrbMU+c7dWEYGxW7hqv77Fh+7Efalz
	xCl17b6ulns4DPWEDCs19wXk26lvfvhB2mg2qle+pNAvgVJ1ic=
X-Google-Smtp-Source: AGHT+IHD+EKsIwkKz6QQfNxgpyQ4Z7f8tjRjNERJ0yCrWW0urijhOuQGTU1dLhcqi4C/EfQRGK/71w==
X-Received: by 2002:a05:6a21:3987:b0:1e1:adb8:c011 with SMTP id adf61e73a8af0-1e1adb8c320mr1427934637.18.1733727731131;
        Sun, 08 Dec 2024 23:02:11 -0800 (PST)
Received: from localhost ([98.97.37.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725eeeaf87csm1024345b3a.35.2024.12.08.23.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:02:10 -0800 (PST)
Date: Sun, 08 Dec 2024 23:02:09 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Levi Zim <rsworktech@outlook.com>
Message-ID: <675695f1265b2_1abf20862@john.notmuch>
In-Reply-To: <20241130-tcp-bpf-sendmsg-v1-2-bae583d014f3@outlook.com>
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
 <20241130-tcp-bpf-sendmsg-v1-2-bae583d014f3@outlook.com>
Subject: RE: [PATCH net 2/2] tcp_bpf: fix copied value in tcp_bpf_sendmsg
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Levi Zim via B4 Relay wrote:
> From: Levi Zim <rsworktech@outlook.com>
> 
> bpf kselftest sockhash::test_txmsg_cork_hangs in test_sockmap.c triggers a
> kernel NULL pointer dereference:

Is it just the cork test that causes issue?

> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
>  ? __die_body+0x6e/0xb0
>  ? __die+0x8b/0xa0
>  ? page_fault_oops+0x358/0x3c0
>  ? local_clock+0x19/0x30
>  ? lock_release+0x11b/0x440
>  ? kernelmode_fixup_or_oops+0x54/0x60
>  ? __bad_area_nosemaphore+0x4f/0x210
>  ? mmap_read_unlock+0x13/0x30
>  ? bad_area_nosemaphore+0x16/0x20
>  ? do_user_addr_fault+0x6fd/0x740
>  ? prb_read_valid+0x1d/0x30
>  ? exc_page_fault+0x55/0xd0
>  ? asm_exc_page_fault+0x2b/0x30
>  ? splice_to_socket+0x52e/0x630
>  ? shmem_file_splice_read+0x2b1/0x310
>  direct_splice_actor+0x47/0x70
>  splice_direct_to_actor+0x133/0x300
>  ? do_splice_direct+0x90/0x90
>  do_splice_direct+0x64/0x90
>  ? __ia32_sys_tee+0x30/0x30
>  do_sendfile+0x214/0x300
>  __se_sys_sendfile64+0x8e/0xb0
>  __x64_sys_sendfile64+0x25/0x30
>  x64_sys_call+0xb82/0x2840
>  do_syscall_64+0x75/0x110
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> This is caused by tcp_bpf_sendmsg() returning a larger value(12289) than
> size (8192), which causes the while loop in splice_to_socket() to release
> an uninitialized pipe buf.
> 
> The underlying cause is that this code assumes sk_msg_memcopy_from_iter()
> will copy all bytes upon success but it actually might only copy part of
> it.

The intent was to ensure we allocate a buffer large enough to fit the
data. I guess the cork + send here is not allocating enough bytes? 

> 
> This commit changes it to use the real copied bytes.
> 
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> ---
>  net/ipv4/tcp_bpf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 370993c03d31363c0f82a003d9e5b0ca3bbed721..8e46c4d618cbbff0d120fe4cd917624e5d5cae15 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -496,7 +496,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  {
>  	struct sk_msg tmp, *msg_tx = NULL;
> -	int copied = 0, err = 0;
> +	int copied = 0, err = 0, ret = 0;
>  	struct sk_psock *psock;
>  	long timeo;
>  	int flags;
> @@ -539,14 +539,14 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  			copy = msg_tx->sg.size - osize;
>  		}
>  
> -		err = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
> +		ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx,
>  					       copy);
> -		if (err < 0) {
> +		if (ret < 0) {
>  			sk_msg_trim(sk, msg_tx, osize);
>  			goto out_err;
>  		}
>  
> -		copied += copy;
> +		copied += ret;
>  		if (psock->cork_bytes) {
>  			if (size > psock->cork_bytes)
>  				psock->cork_bytes = 0;
> 
> -- 
> 2.47.1
> 
> 



