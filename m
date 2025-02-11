Return-Path: <bpf+bounces-51108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667A8A303A7
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9BF167C6C
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 06:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76741E9B17;
	Tue, 11 Feb 2025 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F3k+NiMq"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F51D5161
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255669; cv=none; b=Vaf3d4XvZyWfZDOqqWxYAEdei2P3DNwFIf/0vekRhI7bDoTp/Okj2t01i4XgT8wmBM0DACAw//ScB/qpmBpctxNNn/gEvcHPPdxoe2hJdixUhBOa18Nd/LvmsF5JHRQPuH/+hhxuppW4nAEpIbGlYmikw/yW6wlkCQE/Q4DDmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255669; c=relaxed/simple;
	bh=o22PPYCuKrympHClzmOiV9eSI+dq/O5DlAO1b8EMGzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gpwy/HbVSILDGRCGolO7bF7u4Fq+Bdc772+sAamC6YxLzWEdY2gsIQxJRMmXE5GPln1mZ5z9b+F8Uezw7ntFdtBERDUbLpwDbL5nEhZxWutPp9ljglu9v/wJSMPw8VLrvTEkw2Ea4COFPtbkXr3ZjEz1Fl+E0aVLyoxLDmlsaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F3k+NiMq; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1ac825c7-e685-4363-ba9d-db0d983ce9f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739255655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B66XgQ63HyJZMIT1F+CZdr2+zUWMbchUde75HiXLy5U=;
	b=F3k+NiMqo9dUW1oGLTszTiDngxO5iqh7+HmVyd+l24qzOdmbgs72BNZ/1bF0nr/w9Me7My
	lfCpe1RqnVrS/PfL9ymaZ75ZNzfS5ohjFcV7Q2ScACuDTkEybIKnGWEARd/vkkrWS9AQaF
	eZHqHLOYT5zqi93hFbvTxFAGzQNXh8c=
Date: Mon, 10 Feb 2025 22:34:08 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 03/12] bpf: stop unsafely accessing TCP fields
 in bpf callbacks
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-4-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250208103220.72294-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/8/25 2:32 AM, Jason Xing wrote:
> The "is_locked_tcp_sock" flag is added to indicate that the callback
> site has a tcp_sock locked.

It should mention that the later TX timestamping callbacks will not own the 
lock. This is what this patch is primarily for. We know the background, but 
future code readers may not. We will eventually become the readers of this patch 
in a few years' time.

> 
> Apply the new member is_locked_tcp_sock in the existing callbacks

It is hard to read "Apply the new member....". "Apply" could mean a few things. 
"Set to 1" is clearer.


> where is_fullsock is set to 1 can stop UDP socket accessing struct

The UDP part is future proof. This set does not support UDP which has to be 
clear in the commit message. This has been brought up before also.

> tcp_sock and stop TCP socket without sk lock protecting does the
> similar thing, or else it could be catastrophe leading to panic.
> 
> To keep it simple, instead of distinguishing between read and write
> access, users aren't allowed all read/write access to the tcp_sock
> through the older bpf_sock_ops ctx. The new timestamping callbacks
> can use newer helpers to read everything from a sk (e.g. bpf_core_cast),
> so nothing is lost.

(Subject):
bpf: Prevent unsafe access to the sock fields in the BPF timestamping callback

(Why):
The subsequent patch will implement BPF TX timestamping. It will call the 
sockops BPF program without holding the sock lock.

This breaks the current assumption that all sock ops programs will hold the sock 
lock. The sock's fields of the uapi's bpf_sock_ops requires this assumption.

(What and How):
To address this,
a new "u8 is_locked_tcp_sock;" field is added. This patch sets it in the current 
sock_ops callbacks. The "is_fullsock" test is then replaced by the 
"is_locked_tcp_sock" test during sock_ops_convert_ctx_access().

The new TX timestamping callbacks added in the subsequent patch will not have 
this set. This will prevent unsafe access from the new timestamping callbacks.

Potentially, we could allow read-only access. However, this would require 
identifying which callback is read-safe-only and also requires additional BPF 
instruction rewrites in the covert_ctx. Since the BPF program can always read 
everything from a socket (e.g., by using bpf_core_cast), this patch keeps it 
simple and disables all read and write access to any socket fields through the 
bpf_sock_ops UAPI from the new TX timestamping callback.

Moreover, note that some of the fields in bpf_sock_ops are specific to tcp_sock, 
and sock_ops currently only supports tcp_sock. In the future, UDP timestamping 
will be added, which will also break this assumption. The same idea used in this 
patch will be reused. Considering that the current sock_ops only supports 
tcp_sock, the variable is named is_locked_"tcp"_sock.




