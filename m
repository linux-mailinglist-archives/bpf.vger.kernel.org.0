Return-Path: <bpf+bounces-35289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F802939717
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D08E1F22371
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 23:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB64EB38;
	Mon, 22 Jul 2024 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWClIBIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAA017BCD;
	Mon, 22 Jul 2024 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721692035; cv=none; b=XAZlpKD8/LpDEN9Un37Zpkqt2EYEb/JVMuXk4na7RNRzaJHF/yEIDLUG6bFIljsV2Dp2jKtwA0F8fWVd8+Y/mBNd0HIV6BsWC0yaJED4hxobmQF1Zo5Ef5ZXgvQkd2j23u7UWVb0sz4DaZa0WYqEIQx/QMNrfrUi0gO8KbjRbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721692035; c=relaxed/simple;
	bh=fMGqJEhntV34oe0aaX1VoUtK0FjcZ3ZNJ+PsBMgcqTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBjKjvwl06T+LhMfo4ZPayGeAliAc3dFTM7iPZg04/inaQSD8axZn/SPYbinb47GkKL6VUf7Uws/sy+9qR9v4azbXIYQbo73a6Z4m81JmN2dshbanrxAbTLf9DrpP8zz4O66DJl12adaIQz6hd39ZrHvXspBVsLeGpKYp7PycYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWClIBIQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d1c655141so1312203b3a.1;
        Mon, 22 Jul 2024 16:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721692033; x=1722296833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kncTWBMo6GUlbnDDrR55aEmCKdZTRkey4vfmtFromsk=;
        b=YWClIBIQAphJWroOIOK0ahs93nq+9xPeoeDFgj8kzNZecn63SO1Q9QhkqSeVT+kdGg
         4MTP2mZKyPv02LipUzldCL7tcBNrIPJCJEKF4ZAhpol+IdoVYP8XJi4Jg3ytwLMjgrmV
         ASvd+nJMGTAWqIfdZwZlmOnJElGhG7/teHA581z1KOKRvCQLJ+/3tXZtYcL9p6JF5ole
         Oyt2eQkU69Cl+D1tj5aGiyJsmkrFFPd2m32BE/1CA91hF0DVLYmJZ9Y6SHlzpbWd+20s
         rLS1CGVL40xUOK3iU+zQ1he1VUYAuXwXOmxVFyTwMLfdpqHOkXhFwpGga2O0aCK9srwT
         l5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721692033; x=1722296833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kncTWBMo6GUlbnDDrR55aEmCKdZTRkey4vfmtFromsk=;
        b=EEXQtP0CS+CrXJw6T2y3gIMtj8ctaXLGjPoVoUwGcoyemXy6RucjJ5DjsbmdCTbLaO
         qiPYYi5uHeKB1sJzIDLdpmHiiepVmjJnLtD3Ps71IwrliNdeqaWNQ5rPEddRsFqjv3QJ
         oaY4rp/DAqsad8nFCbSUYqu+SoRpKDGcMfGGq7hhgicy12zgx+dWZDcUCt8a8NO9GEJZ
         VfCIOpFpKY6hpKNey7nSpzM06pDsGac6kjZV3R4oODZDtvTnpgBdLlROauWKC0naS+gd
         oDkT493Ec2MooBCkBsKO3NMZ8LFfxHLpUQqjp5LFk8s4B+u+b8n2K0VCEjJ3pN6pdQ/8
         K4+w==
X-Forwarded-Encrypted: i=1; AJvYcCVj61CI+wVsl7IfpL427lZ/4JURILWOH1ZqmWuhdlvZU+hBc+3TSrnoba500VnLrf9EHstgYzWhyu/UF8NLB/jRv96hHy9fNjfeQfqf/hXhyKzHRZFLVM9nKhapHsL4xLfjb7qH4X5XSIv+8Y5Cw0HS2z9MYrjqIFgv
X-Gm-Message-State: AOJu0YwopFF1cy8JcXf4qLdtnQL0eGD9o7+SZ7NCTExrObab4e1hzhCq
	KC4gZ4UnjariKEPSpgt3pxpbcRgWN2bg7GJPT+J991Mpl4qj7rCH/09e7e2u
X-Google-Smtp-Source: AGHT+IHG7BdEWq3cpZPFsp/e8Zmxlh6MS5ott9jrpziej+FZOcWGEP46nZXlgCOOr6r/bEvL/i4SoQ==
X-Received: by 2002:a05:6a00:22cf:b0:706:8a67:c3a0 with SMTP id d2e1a72fcca58-70d0efa9ebfmr6918340b3a.5.1721692033164;
        Mon, 22 Jul 2024 16:47:13 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::5:9d00])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d270cab28sm2471837b3a.115.2024.07.22.16.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 16:47:12 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:47:09 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	andrii@kernel.org, avagin@gmail.com, snorcht@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next RESEND 00/16] bpf: Checkpoint/Restore In
 eBPF (CRIB)
Message-ID: <etzm4h5qm2jhgi6d4pevooy2sebrvgb3lsa67ym4x7zbh5bgnj@feoli4hj22so>
References: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB58488045E4D0FA6AEDC8BDE099A52@AM6PR03MB5848.eurprd03.prod.outlook.com>

On Thu, Jul 11, 2024 at 12:10:17PM +0100, Juntong Deng wrote:
> 
> In restore_udp_socket I had to add a struct bpf_crib_skb_info for
> restoring packets, this is because there is currently no BPF_CORE_WRITE.
> 
> I am not sure what the current attitude of the kernel community
> towards BPF_CORE_WRITE is, personally I think it is well worth adding,
> as we need a portable way to change the value in the kernel.
> 
> This not only allows more complexity in the CRIB restoring part to
> be transferred from CRIB kfuncs to CRIB ebpf programs, but also allows
> ebpf to unlock more possible application scenarios. 

There are lots of interesting ideas in this patch set, but it seems they are
doing the 'C-checkpoint' part of CRIx and something like BPF_CORE_WRITE
is necessary for 'R-restore'.
I'm afraid BPF_CORE_WRITE cannot be introduced without breaking all safety nets.
It will make bpf just as unsafe as any kernel module if bpf progs can start
writing into arbitrary kernel data structures. So it's a show stopper.
If you think there is a value in adding all these iterators for 'checkpoint'
part alone we can discuss and generalize individual patches.

High level feedback:

- no need for BPF_PROG_TYPE_CRIB program type. Existing syscall type should fit.

- proposed file/socket iterators are somewhat unnecessary in this open coded form.
  there is already file/socket iterator. From the selftests it looks like it
  can be used to do 'checkpoint' part already.

- KF_ITER_GETTER is a good addition, but we should be able to do it without these flags.
  kfunc-s should be able to accept iterator as an argument. Some __suffix annotation
  may be necessary to help verifier if BTF type alone of the argument won't be enough.

- KF_OBTAIN looks like a broken hammer to bypass safety. Like:

  > Currently we cannot pass the pointer returned by the iterator next
  > method as argument to the KF_TRUSTED_ARGS kfuncs, because the pointer
  > returned by the iterator next method is not "valid".

  It's true, but should be fixable directly. Make return pointer of iter_next() to be trusted.

- iterators for skb data don't feel right. bpf_dynptr_from_skb() should do the trick already.

- start with a small patch set.
  30 files changed, 3080 insertions(+), 12 deletions(-)
  isn't really reviewable.

