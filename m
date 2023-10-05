Return-Path: <bpf+bounces-11460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA4A7BA723
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 18:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7F57D281DD2
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 16:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C93374E1;
	Thu,  5 Oct 2023 16:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NLuRkaN"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CEF36B1E
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 16:53:39 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D6547BD
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 09:53:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f8040b2ffso17568977b3.3
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 09:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696524816; x=1697129616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WgW7kVDuz2dwRfbyuaJkQrKoMU08UEVmYCgpM2nqKLU=;
        b=2NLuRkaNvG+LG3R0vE3dkIbJsBZZ0g2ahux+W5dhb9EVNAtJ6napyF+d9C4d7N3Fva
         PhEg4mLjxz65SJ+H5IK9JkNlMwVjyVZrrRu2Dj0LBcNQAL3Mv/AgnlIe0ir8eP6nXYW/
         DPWfEscxTMLcYnFQW2+urjtm+PilbgdVkH48rjOev34DWXg1RZjd2owM2rzrjVKTjJI2
         Ei3PMBQGW3HiR8cbAdTd3Q0VElWiB7iA3HJx9GoGVnxfeMx6bB21OWaW+4sip62qcvC9
         i1+LV3KZ6pLjoVgmokUpaPj3g514vkSpaFJfGCI+gQWoB8Q8AH1QSS8G4LBOWCCqUpjX
         PdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696524816; x=1697129616;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgW7kVDuz2dwRfbyuaJkQrKoMU08UEVmYCgpM2nqKLU=;
        b=lDmoNmvEJcu7E55DGTRqndxIPPX6moKlBq6CxHPWDtGaTvtObAsaM93XnMmzGis2Qb
         Bb55UOO+zbQ9gp/0kdSJyTet52sD/4yJ7cSsDUm7rmDu/w+AMURbpJeSyctI1E5e+mki
         d3vxBh69eTyk7rgMd4qKJAczZLbVUmnTYk/XZFERkD/AQLcI2But3+Os+w8VZmHGZNgQ
         rBeeZ54GC2oL7i1U9m6C9KSWUdevRLGvC+b5HdPFX+LoKgdf1DbTYhVa4yXF57pSLMjn
         +adVn7Q4t5vYS1VhCDOWe4mCnDfn5KO6XtzRwx6cGIP2tRRuBiecCWfNo5uLx3sf39oT
         /pLA==
X-Gm-Message-State: AOJu0YzuKFIg0rjMBkHX41HFW/cKUulgUermZUV3Rpg2hoVtcA/8Tq5T
	mM3ygghwgcmWP2mzWS74Q7y/BFI=
X-Google-Smtp-Source: AGHT+IHztXCCIAMUhHtWjKjtB1IfIfbYVA+Qw3NnRFPC8dPmFb8jyAPyiWc851i2XRuEVTAMqONHNKw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:bd4e:0:b0:576:af04:3495 with SMTP id
 n14-20020a81bd4e000000b00576af043495mr98619ywk.9.1696524816321; Thu, 05 Oct
 2023 09:53:36 -0700 (PDT)
Date: Thu, 5 Oct 2023 09:53:34 -0700
In-Reply-To: <20231005072137.29870-1-akihiko.odaki@daynix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231005072137.29870-1-akihiko.odaki@daynix.com>
Message-ID: <ZR7qDgEZ9pyFDZ3K@google.com>
Subject: Re: [PATCH] bpf: Fix the comment for bpf_restore_data_end()
From: Stanislav Fomichev <sdf@google.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/05, Akihiko Odaki wrote:
> The comment used to say:
> > Restore data saved by bpf_compute_data_pointers().
> 
> But bpf_compute_data_pointers() does not save the data;
> bpf_compute_and_save_data_end() does.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Please use [PATCH bpf-next] (or bpf, depending on the tree) for bpf
patches in the future.

Acked-by: Stanislav Fomichev <sdf@google.com>

