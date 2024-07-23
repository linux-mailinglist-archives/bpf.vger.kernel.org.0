Return-Path: <bpf+bounces-35297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2517F939769
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487CF1C219BC
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CB3B65A;
	Tue, 23 Jul 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPL6o1yZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51791FBB;
	Tue, 23 Jul 2024 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694096; cv=none; b=JWDAIESSwlxO/cFEZkdbXjg9zJRXY/cvTCyFxnpNpCi/T+RZliknBIVoLSkH3RbkA06MSkGCUnnOs7ngggmecJtDYzGmbteifBtLA7jFTc0KIXZf93pfFg3OiNRjTGdD+sncUDcu6t1pHLuuA2u7hT/gVEuPNv0CyTXFKyw/+EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694096; c=relaxed/simple;
	bh=veA7P7+OBvlyVBsvmKu9/+iczIcI3e56VhaEI6Wzny0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tr6eO2cP52UPHf2dk7kN5Nt3CgjQP5d8mxVvtbHgQgfrQC7wD5qTMk+sljigokoY7YjbYy9wApeqIaNznVWRtuUGSn3ehJbEk8CcJqqlQ+NVUjwDbVxyI+1Fx5Z0BafgJCLxDFrEqN13mY8Y5ODcE+dXJADU9/S5s1LewjgyrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPL6o1yZ; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a77dc08db60so524430666b.1;
        Mon, 22 Jul 2024 17:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721694093; x=1722298893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=veA7P7+OBvlyVBsvmKu9/+iczIcI3e56VhaEI6Wzny0=;
        b=fPL6o1yZUcW6PvP569UT5+CFkg0kXlXhSn7FuxcFlhpBKx74jVbMJBTbLkpLLpkBMp
         yArUKOJvs6V+6hTXeHO1zNhobCibbnugR8dAb2uLkhBKO8KT1T/FnaUBWB0ND24LBBvr
         VOHvOVjb5FDXk4dLFPReOS9hzljxCPCJ9jYbB6vcbKknnxeaxJwutod+wg8oqmingp7r
         7qFMll6Z5FT0fOIm6R+rPC5q1Y7AHF5jtLdGUeeyekc43xc5rOJAqD0D9cgXJgaJjgru
         5dRXWq3I44RHPHuLxd5z+UhkN6qqOl5kh0GwoErISqlzNaGNiZPsCmH0ZwdVVsiZFacH
         L1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721694093; x=1722298893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=veA7P7+OBvlyVBsvmKu9/+iczIcI3e56VhaEI6Wzny0=;
        b=A8JmgQquUl17IkXoy0XRTOShoGtyVSqDG6Hu0PHuSvW/GoLqHF8fePhiwT31Y978ZV
         DCukm4fNSTVuEe5u/2Y9eJkL4mNtgIuacUlURHsFyb9FpXGfa7SqpAM2hrQ9tbVQnvFG
         DdyeN68z8m99yPWihNIFGWxxD1ER0CgaFpDISMLLZDxtFdh3vLCP35sI8QvRG7VB9734
         nTHWCdwMCfgagnHiT0ZN6vDGLnK633iPWB9ukkiEce3D/B9d8+5t/14Vd/thzhoufi/3
         ieAsC8tRHT6tJyCyye8jtjdkaFH6/QBtjKCGvHPy3fY2vNOhUQeVd7rfNlPn51ayCIGM
         RFnA==
X-Forwarded-Encrypted: i=1; AJvYcCVLJpINDuEKoJ8Wgja+iXasBCfaEg0e3fc0K+xSzY3QjYcYA6siLVZpWmXCGFtNlPDjfp2EbBP93iC96caRKj7ySEN8V3O1xISLv3sIqdUfKVifO5dMS7ja50j8WrQI4qATuEDeQxOgGQaG7+csuVIvdtVccDz1aHDE
X-Gm-Message-State: AOJu0YzHy7+JI5aSD41d94hNaaJ14ZiVB0IIEexPBdMK0Emmq0p7IEOr
	zhMIy6Wnh8Qc/KXDcYuGPMz5CyWFFAxLgX7L2Vf8nRCNnkfdx5FZ6ayS8OAReyfdhW8BSnm24BR
	HEpOik3oChoBtDI7aI3YzVdrhz5ksvgeG4k8=
X-Google-Smtp-Source: AGHT+IFxAxH1tPNSB97YzHssXxr9T26eekc9/4/hRHbT8JXXy6ZE4xXd57onmd33G3yvnZWBudIUeR66/xuLk5iGAS0=
X-Received: by 2002:a17:907:6d10:b0:a72:44d8:3051 with SMTP id
 a640c23a62f3a-a7a4c051a77mr642537466b.16.1721694092848; Mon, 22 Jul 2024
 17:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <AM6PR03MB58488FA2AC1D67328C26167399A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB58488FA2AC1D67328C26167399A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 23 Jul 2024 02:20:56 +0200
Message-ID: <CAP01T74pq7pozpMi_LJUA8wehjpATMR3oM4vj7HHxohBPb0LbA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next RESEND 03/16] bpf: Improve bpf kfuncs pointer
 arguments chain of trust
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, andrii@kernel.org, avagin@gmail.com, 
	snorcht@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 13:26, Juntong Deng <juntong.deng@outlook.com> wrote:
>
> Currently we have only three ways to get valid pointers:
>
> 1. Pointers which are passed as tracepoint or struct_ops
> callback arguments.
>
> 2. Pointers which were returned from a KF_ACQUIRE kfunc.
>
> 3. Guaranteed valid nested pointers (e.g. using the
> BTF_TYPE_SAFE_TRUSTED macro)
>
> But this does not cover all cases and we cannot get valid
> pointers to some objects, causing the chain of trust to be
> broken (we cannot get a valid object pointer from another
> valid object pointer).
>
> The following are some examples of cases that are not covered:
>
> 1. struct socket
> There is no reference counting in a struct socket, the reference
> counting is actually in the struct file, so it does not make sense
> to use a combination of KF_ACQUIRE and KF_RELEASE to trick the
> verifier to make the pointer to struct socket valid.

Yes, but the KF_OBTAIN like flag also needs to ensure that lifetime
relationships are reflected in the verifier state.
If we return a trusted pointer A using bpf_sock_from_file, but
argument B it takes is later released, the verifier needs to ensure
that the pointer A whose lifetime belongs to that pointer B also gets
scrubbed.

>
> 2. sk_write_queue in struct sock
> sk_write_queue is a struct member in struct sock, not a pointer
> member, so we cannot use the guaranteed valid nested pointer method
> to get a valid pointer to sk_write_queue.

I think Matt recently had a patch addressing this issue:
https://lore.kernel.org/bpf/20240709210939.1544011-1-mattbobrowski@google.com/
I believe that should resolve this one (as far as passing them into
KF_TRUSTED_ARGS kfuncs is concerned atleast).

>
> 3. The pointer returned by iterator next method
> Currently we cannot pass the pointer returned by the iterator next
> method as argument to the KF_TRUSTED_ARGS kfuncs, because the pointer
> returned by the iterator next method is not "valid".

This does sound ok though.

>
> This patch adds the KF_OBTAIN flag to solve examples 1 and 2, for cases
> where a valid pointer can be obtained without manipulating the reference
> count. For KF_OBTAIN kfuncs, the arguments must be valid pointers.
> KF_OBTAIN kfuncs guarantees that if the passed pointer argument is valid,
> then the pointer returned by KF_OBTAIN kfuncs is also valid.
>
> For example, bpf_socket_from_file() is KF_OBTAIN, and if the struct file
> pointer passed in is valid (KF_ACQUIRE), then the struct socket pointer
> returned is also valid. Another example, bpf_receive_queue_from_sock() is
> KF_OBTAIN, and if the struct sock pointer passed in is valid, then the
> sk_receive_queue pointer returned is also valid.
>
> In addition, this patch sets the pointer returned by the iterator next
> method to be valid. This is based on the fact that if the iterator is
> implemented correctly, then the pointer returned from the iterator next
> method should be valid. This does not make the NULL pointer valid.
> If the iterator next method has the KF_RET_NULL flag, then the verifier
> will ask the ebpf program to check the NULL pointer.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---

I think you should look at bpf_tcp_sock helper (and others), which
converts struct bpf_sock to bpf_tcp_sock. It also transfers the
ref_obj_id into the return value to ensure ownership is reflected
correctly regardless of the type. That pattern has a specific name
(is_ptr_cast_function), but idk what to call this.

