Return-Path: <bpf+bounces-54981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4BA76C83
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 19:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3766B188AB0F
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A324A215F5D;
	Mon, 31 Mar 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ai5xtqrp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C292147ED
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743441850; cv=none; b=NeP6n7suF72K6UGRVLBh35woPxi/dTWOfX5OTezNhCcYUM7a4dWIrpHvCnzSOtsmQ6IAi8Z4rp1/gOFgHxNNGbHnaR6fKUHrBkRqE/VOf1HZiiCiPykVP883xLJ+09Smx0Iqyt/XBMaHI4A0BoPp7vl/G7NxItj/i+0Li+UU69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743441850; c=relaxed/simple;
	bh=WngEv/BI9m9lNdQu2OFi8F+FQV33jHz1PUzH2a/+kY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=re9HmpqCUD8ycOStCSkYc9qkJzP9r8XwRLBbIMOY0aEhGsB8YjcSI70CRgG2t7ApeuHsrx0T2QxvNMdvwqAYnNpwbZFD9bmpH1Lnt4VcWG4coUPQLaobDadSGL+R3ahoCgolyjQBVBjW9TSJSSNmDFXl24Gryyb9fcHAwY8nZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ai5xtqrp; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so759a12.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743441847; x=1744046647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WngEv/BI9m9lNdQu2OFi8F+FQV33jHz1PUzH2a/+kY4=;
        b=Ai5xtqrpvoO4SlNfx07jgUjeRE2mj1HyLpD+MEvYZPvyR2G12700iCpH3TkhszqO/r
         aB2Xeb7tXEWprPBuxV2AoCiukGMxxkhsnraf1ZSeItQcu+MfJbLyz92HqwbTONe/cZvJ
         3h0++YNrJqm5Vo15vr9W2ihKzFLrISAvvkcBRajnOwzG8harVRzG+f1i2mdcjQjOEh71
         aa2yI7pWrVeMaUUztdchneA3Uq3eAgbHmJ3H402QBTGwhAQ1/g40Ni1JXy3nA77nyt7f
         Luu0TvUSlqzhLPFRsyBRmRN0VsiZTqijLbnDX0LELLcjkr/uNkiwSmVFaoOtsDWdeeCx
         8TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743441847; x=1744046647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WngEv/BI9m9lNdQu2OFi8F+FQV33jHz1PUzH2a/+kY4=;
        b=C+x5IsQVwHHsLE5qZCc9FmH0MeO0lUxaj09TFd8060G3FcaE+FsAPL2UEn2Tkwzdyi
         nzdyNd0K2EbxBXjhK2cFbjZ8fVnDx0Rg9XU/ix/T7kkB+zzs7bBuANet6s4b24YpMwsn
         F6ADHur0gpOncQobQYTC2FuXPkTNzMs87aOx6++QddEkzIuVMDHRStwTQ4lzNEItsWr0
         SFkMUaXy6pGetHQ4iX9YjVrM8i/fbhTqxXei8RTFqEAT/u85sGFMDpBN7I5qt5mP6QSI
         Khao0IjgCVdKsSQIRwjEx4GJoILP/OgEOBe3AxL0wSBrluTI0dEh551kkI2u84atv+q0
         JHsA==
X-Forwarded-Encrypted: i=1; AJvYcCUqV+srF4+hzA/P2LARuaxGXYbaxcDuAfQfnSBA7neL/q7WkrkhyB7JFSQg3QlZiTFXek0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPVDC9g6NoM0gipTnSXZ5NWQOkm7C+2chyV1YzkrQ0ii79IsR
	iDu4+cEZ0jgWDtcu5A+JG2PCW1imOY53yNGVSJTLk/UdpjBqwGF5MvlbG4Umm6o8N2JbE7ii/jg
	iN8QGrJZJiRyo5mw9bthyV7NAlL6lrk3SVTyz
X-Gm-Gg: ASbGncv4lCN9Yzevt/k3Mc1x2IbjB56xd12VvI0NODm4jLfUCfUCUA/yZB7x0ySwAe0
	9wyCn9WKw3Z6jGdESdUh70LjDhlsIr3K61TXzJBX6Rtb5hPmtZ9OWFWLFxAQe00+de7KbyJhT47
	4hh/xuaQWeS8+SwCYA+fbnFZaj/HWwTj8YW5dQoQO0tbrryNixaETouSEg
X-Google-Smtp-Source: AGHT+IFjTI59BaJajEc5ccgjAXvUPEzUCirJRo23YH1ZZLukyXLcwiUrYC4BjQgy532ChoCjsesclV1MU2XmTpa0yIo=
X-Received: by 2002:a50:d502:0:b0:5e0:eaa6:a2b0 with SMTP id
 4fb4d7f45d1cf-5ee0fece9c5mr175711a12.5.1743441846677; Mon, 31 Mar 2025
 10:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com> <384c31a4-f0d7-449b-a7a4-2994f936d049@linux.dev>
 <CADKFtnQk+Ve57h0mMY1o2u=ZDaqNuyjx=vtE8fzy0q-9QK52tw@mail.gmail.com> <c53cee32-02c0-4c5a-a57d-910b12e73afd@linux.dev>
In-Reply-To: <c53cee32-02c0-4c5a-a57d-910b12e73afd@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Mon, 31 Mar 2025 10:23:54 -0700
X-Gm-Features: AQ5f1Jru1XjUqIvO75Y0EPqiJXWlRp-Yb00PrXQaO1TDe3j-jYrtYqDwh-0Nv3Y
Message-ID: <CADKFtnT+c2XY96NCTCf7qpptq3PKNrkedQt68+-gvD9LK-tBVQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] Avoid skipping sockets with socket iterators
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

> It is a very corner case.
>
> I guess it can with GFP_ATOMIC. I just didn't think it was needed considering
> the key of the hash is addresses+ports. If we have many socks collided on the
> same addresses+ports bucket, that would be a better hashtable problem to solve
> first.

I see, thanks for explaining.

> We can also consider if the same sk batch array can be reused to store cookies
> during stop(). If the array can reuse, it would be nice but not a blocker imo.

> In term of slowness, the worst will be all the previous stored cookies cannot be
> found in the updated bucket? Not sure how often a socket is gone and how often
> there is a very large bucket (as mentioned at the hashtable's key earlier), so
> should not be an issue for iteration use case? I guess it may need some rough
> PoC code to judge if it is feasible.

I like the idea of reusing the sk batch array. Maybe create a union
batch_item containing struct sock * and __u64. I'll explore this
direction a bit and see if I can come up with a small PoC. Lots of
array scanning could be slow, but since changes to a bucket should be
rare, one optimization could be to only compare to the saved socket
cookies if the bucket has changed since it was last seen. I think
saving and checking the head, tail, and size of the bucket's linked
list should be sufficient for this?

-Jordan

