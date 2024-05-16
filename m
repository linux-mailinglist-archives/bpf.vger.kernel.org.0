Return-Path: <bpf+bounces-29881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40A68C7EE7
	for <lists+bpf@lfdr.de>; Fri, 17 May 2024 01:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34FA1C2190D
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 23:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147BA2AF0F;
	Thu, 16 May 2024 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoXwXH/D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18E2C68C;
	Thu, 16 May 2024 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715901308; cv=none; b=ECiI3whgnUCZOwFTMN0L69TjRzcdx9yCsdEvnkzW14PrFLXx2F94l3tUAfyw1ZsG/mhu76qRPYNrQYCS1QTve0dXD+OTJoyD1UaLw0bUcHswYoMfbFuKpZhYcYKJVXcvROqeDz2iJmCmXorEX5KBBPSqeeFVqDNksA91xQlFOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715901308; c=relaxed/simple;
	bh=jzp5uKqq8uuufN/H6rzTr/n/dRRmI7vjujF9nK4G0FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO9+ZXPJl/z7OnLnrcK2p8kgfuLTB9emui4hqbx7WImeyW75HUdEUPR3iF4ogltW2+TLlRzM5P/YF/2O9hmA5oeTd9vbHLa71zduGzxywFQDi+9UX0tRkHc9AWSRVsQ+0QTg8xa5NMIB+9F0wCbStmRPXhNyTfdybxW0lEXzIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoXwXH/D; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de4665b4969so8679692276.2;
        Thu, 16 May 2024 16:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715901306; x=1716506106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zDLC5qQdaC9QLdMx+18xdxA3NXFpUHL2Vp8wk+sJ2T4=;
        b=FoXwXH/DcDvID0yYIOshC0Mm1cKZqc5ah2e3ZEhHCXT9KfUHjwGHqaePpzWdnzTR/+
         FtHmRJO7bicZEBlfn2FTMhlIuW05/oS+jGTcUgxDQQdl9etuER59c0dvfmJwZMknEe1i
         Ma0VKWelhUe9TiZdRR6P0vrHgvwf1Aq/1NVvSE1VL8CM9Un4i5rSYNA6O6AvoBsJJchl
         3nSQHjRURLU6tmxhDdl6rVQXbKQ7fukyX3zfRH61RRCUByL5BFKTLP6r7gRzYxT4iJBb
         gt1sVVZeQ0fc/BDJ9DsEWirYmumK6+EQEVmZmvNbzufMJoWJE54Q8AiIix0oYw2Pyt7G
         WsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715901306; x=1716506106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDLC5qQdaC9QLdMx+18xdxA3NXFpUHL2Vp8wk+sJ2T4=;
        b=mzegaCQs44SI4D53Q6OE3Bqg5JiKfJFA7OHWa7vS1rYBEtUVdni0erj87QBEpTr+My
         rSy5+eCWv8izhWK6hiFWd35C9Xrr2aGh7evpcmKDEMcbpWzH6FReJmkf3pOVCAdd3aQq
         SU0/beX3D7N6MrKbW+Hk9Gg04okbBH/Ib9PV+1WUcgMJZyDj99oNR5bCqXiFDoGPrKrB
         6VWKGDqYaQG1+PCSJ5FVLQ0dUeenvkVFPQD6xzwdBuH21oMyFBbaaxfVPOLgc2njScmt
         LS33IXPlVFp4GCM8GlB9RGkXI4lmzAxm+dv1diR/qAW3eT6HYtYf8/ZrtNSGuhWHXVi2
         IQFA==
X-Forwarded-Encrypted: i=1; AJvYcCVFa0/3qwbZKTjFPKoBce5Lmj60QJKZpzZVDIfsPMwiWMsu9yLgX2UZ9VMBA0o8VSwngtBPzNcJoE/yJzuyCwS5QWhj
X-Gm-Message-State: AOJu0YxNOUROsxRu6s+MvVbGsFqUxZHDhG9Fe5URgf1Li9zmf/QGb0Lk
	4gU+5PWuAnvwXlN2hZw6NqKsd/Wt4H8Gs0MSLV6qgxmyr/Cg3bNqVHHPWaTH/3KMYybrG5vSA5O
	FfdmygoOZ2CRViZnBjXnpnFIhbDs=
X-Google-Smtp-Source: AGHT+IEEKz7FKsU6bdIhJrFiKD0aAoLU4piZQbhOerzLQKFob0f1RtiBS1hQ8bcgcAIbxaQ+0lJGa2vyOhQPNf+1z5E=
X-Received: by 2002:a25:d68d:0:b0:df4:43f6:5b75 with SMTP id
 3f1490d57ef6-df443f65dd6mr5246919276.24.1715901306049; Thu, 16 May 2024
 16:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-3-amery.hung@bytedance.com> <b2486867-0fee-4972-ad71-7b54e8a5d2b6@gmail.com>
 <CAMB2axN3XwSmvk2eC9OnaUk5QvXS6sLVv148NrepkbtjCixVwg@mail.gmail.com>
In-Reply-To: <CAMB2axN3XwSmvk2eC9OnaUk5QvXS6sLVv148NrepkbtjCixVwg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 16 May 2024 16:14:55 -0700
Message-ID: <CAMB2axMG2Pr11-O8ZRh3=T-4VqUmfoKQ7=ukQxK3rHONaTXypQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 02/20] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"

I thought about patch 1-4 a bit more after the discussion in LSFMMBPF and
I think we should keep what "ref_acquried" does, but maybe rename it to
"ref_moved".

We discussed the lifecycle of skb in qdisc and changes to struct_ops and
bpf semantics. In short, At the beginning of .enqueue, the kernel passes
the ownership of an skb to a qdisc. We do not increase the reference count
of skb since this is an ownership transfer, not kernel and qdisc both
holding references to the skb. (The counterexample can be found in RFC v7.
See how weird skb release kfuncs look[0]). The skb should be either
enqueued or dropped. Then, in .dequeue, an skb will be removed from the
queue and the ownership will be returned to the kernel.

Referenced kptr in bpf already carries the semantic of ownership. Thus,
what we need here is to enable struct_ops programs to get a referenced
kptr from the argument and returning referenced kptr (achieved via patch
1-4).

Proper handling of referenced objects is important for safety reasons.
In the case of bpf qdisc, there are three problematic situations as listed
below, and referenced kptr has taken care of (1) and (2).

(1) .enqueue not enqueueing nor dropping the skb, causing reference leak

(2) .dequeue making up an invalid skb ptr and returning to kernel

(3) If bpf qdisc operators can duplicate skb references, multiple
    references to the same skb can be present. If we enqueue these
    references to a collection and dequeue one, since skb->dev will be
    restored after the skb is removed from the collection, other skb in
    the collection will then have invalid skb->rbnode as "dev" and "rbnode"
    share the same memory.

A discussion point was about introducing and enforcing a unique reference
semantic (PTR_UNIQUE) to mitigate (3). After giving it more thoughts, I
think we should keep "ref_acquired", and be careful about kernel-side
implementation that could return referenced kptr. Taking a step back, (3)
is only problematic because I made an assumption that the kfunc only
increases the reference count of skb (i.e., skb_get()). It could have been
done safely using skb_copy() or maybe pskb_copy(). In other words, it is a
kernel implementation issue, and not a verifier issue. Besides, the
verifier has no knowledge about what a kfunc with KF_ACQUIRE does
internally whatsoever.

In v8, we try to do this safely by only allowing reading "ref_acquired"-
annotated argument once. Since the argument passed to struct_ops never
changes when during a single invocation, it will always be referencing the
same kernel object. Therefore, reading more than once and returning
mulitple references shouldn't be allowed. Maybe "ref_moved" is a more
precise annotation label, hinting that the ownership is transferred.

[0] https://lore.kernel.org/netdev/2d31261b245828d09d2f80e0953e911a9c38573a.1705432850.git.amery.hung@bytedance.com/

