Return-Path: <bpf+bounces-53761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF07FA5A416
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 20:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1CB3ADF50
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1C1DDA39;
	Mon, 10 Mar 2025 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQbZPvNc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB3C1DA0E1;
	Mon, 10 Mar 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636289; cv=none; b=kbXUyWu0UeSpctW4CSu4uoobcbYHxObpr6RdMtWlupvMPAgNKyJxF4vYmHgqnqRHHqnCuYmCkOBD+fizxx8F+7JhImFAIEuJ/pFBU1g9c/tKVk0iEciu7EB0sUGbxGYcSZn6z6lXAYsqUfFSFaBJkTge3Vb7UxD/w+6hbEedkmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636289; c=relaxed/simple;
	bh=hUfhzqtt0Avajl2Gkpb8aA0blXMuQz9N4yKLfrTh6fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUmoescfrv+t9mbZjCFexuOJwTMvyBONK6JQ852lBKXipQl+A7zrrWPTnO1lqBOai5pj1nnWMFZEHY4XYwMRDTZqZOXPhKMVr2BRGM/6ulK3UDqgzN2LUduK3VFfSGjQzLOt2Db43gSyRo/ic2Nnc+DyqkiAecZ07DeZMZQNQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQbZPvNc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22337bc9ac3so89522215ad.1;
        Mon, 10 Mar 2025 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741636286; x=1742241086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQwbuud9J5NqaSGaH7uv9g3ohWXt10gFUVhJ8RTBEmk=;
        b=PQbZPvNc2X+RiwvU5eBJHOCSw/wSM5vAAteOW/udRKyoVmQXkV9Hn9xo4mDsc71p0u
         HCuW4IWYjmBng0tOu0CtUp6QJcWUE1+v423SuhZ2OMSLY8I8OJNIwad1U09nGGmFDkTz
         h7JTjFDS21ZcPOwBa22X3BYWa+EvEo3uPr7BI3HGN7Cx9MLQi4OMIiR2YI1SrUk0LPcd
         M6oJs/Mlh9WIvWfVOaEogPDZWlIxgAz46XKp6TW0NKlGs/V//WTx0rBnjDVoiBxNVKHP
         2ilKX/pDs76AEv+6CE42aduhDnO76y7/bdHyK5FcTDR0W8rvLLbJJ24EaSpaJibPTVQF
         GlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636286; x=1742241086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQwbuud9J5NqaSGaH7uv9g3ohWXt10gFUVhJ8RTBEmk=;
        b=InfI6Fd++DY1A0EOpiwl3IUfp9buRLJRL4J5x8qyVp5CulXIEIdX+KsomT0AE/QW+t
         XwEusSJiwhWmkxMlgxrzPZWfNJ1cq8ZnopJhz77LbowyCwQSfeANQK2utO1C9FKGuiXg
         MYdpzwkYsViSZFLVxz2SFjk5UhbxgsIQfgT5q0l6FPIHfq1bTGe6ibt8QhcYyaNYANAs
         8HaaIYWuTU2OQFozI/ZcGsqJ1QC8MgANABEJi2a70EsinWKptfUbb1Qb/ZExMPxekzcu
         9DXbDbzbDSpEs/rC4la9lrDosOx53c4jcCB4r8ltKgPK+h4M6sWK4dpX6rXePUHYAzWs
         A/9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJsF/BZeyO5X/Fz2e7Rwnb9AZ6uctWEsIvmudmIqsFU/yXbw9Tj9nlL5rNh2R7wEvRw3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9AeMCOZ9NV57wHygrji7TdV1AnIMJ4KtK9Jb191ihKmrgV2tc
	VIagYir3tVfRGCpffS5fj9yw5F9tLsdgALtXfNXBL760GxA7zFvORpFg9w==
X-Gm-Gg: ASbGncs5Fv5dN0czRfztMqu/9s7G6hQEVV2XzVel2y23gOb3vXvvFhkOFi8xZUywoyK
	gOgTQ+4EWwT/qDwcvT6wZMi/wX+Z3gyRTnVf+rVEC1KP+ktMhT9ECzivaYs0bfh2+Rsce53Fldc
	xj1M2xFacP/iJkSRnpVSLB8OGL0NZcQWmrrnrywpCQYhSuR1NKRE/yim8XigwSWH+5icrkzh6c2
	lhY0OkhZSbCq/alEdatD3AlPC7ncLi00BVoyQl9osBcJbx2DG83/2ZA1L04JE/3hg6HMx7LZRQC
	uontTci9QelemmxeJ6ayFJhvxb4x6Uvai012pRkYSvR3zJr3
X-Google-Smtp-Source: AGHT+IGRbu7d4R0IepIDY6cW99/5dGQphm3JEr4Iwj8FKhwlTmuDrgu8A5YVBxcGOqwflE1Sio48ag==
X-Received: by 2002:a05:6a00:99c:b0:736:4644:86e6 with SMTP id d2e1a72fcca58-736eb7fe8c7mr1241396b3a.12.1741636286277;
        Mon, 10 Mar 2025 12:51:26 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d4f20913sm2984505b3a.13.2025.03.10.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:51:25 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:51:24 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, alexei.starovoitov@gmail.com,
	martin.lau@kernel.org, kuba@kernel.org, edumazet@google.com,
	cong.wang@bytedance.com, jhs@mojatatu.com, sinquersw@gmail.com,
	toke@redhat.com, jiri@resnulli.us, stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v4 08/19] bpf: net_sched: Support implementation
 of Qdisc_ops in bpf
Message-ID: <Z89CvCM7B/Lvkq5K@pop-os.localdomain>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
 <20250210174336.2024258-9-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210174336.2024258-9-ameryhung@gmail.com>

On Mon, Feb 10, 2025 at 09:43:22AM -0800, Amery Hung wrote:
> From: Amery Hung <amery.hung@bytedance.com>
> 
> Enable users to implement a classless qdisc using bpf. The last few
> patches in this series has prepared struct_ops to support core operators
> in Qdisc_ops. The recent advancement in bpf such as allocated
> objects, bpf list and bpf rbtree has also provided powerful and flexible
> building blocks to realize sophisticated scheduling algorithms. Therefore,
> in this patch, we start allowing qdisc to be implemented using bpf
> struct_ops. Users can implement Qdisc_ops.{enqueue, dequeue, init, reset,
> and .destroy in Qdisc_ops in bpf and register the qdisc dynamically into
> the kernel.
> 
> Co-developed-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Amery Hung <amery.hung@bytedance.com>

Thanks for keeping updating this, Amery! It should be very close to be
merged. So acking this as TC maintainer:

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

I can't wait for trying it by myself too since it is now completely
different with my original code. ;-)

Regards,
Cong

