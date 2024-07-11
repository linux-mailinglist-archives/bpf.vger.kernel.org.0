Return-Path: <bpf+bounces-34494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6F92DE33
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 04:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E902832A2
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 02:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50B7462;
	Thu, 11 Jul 2024 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkb/SN+T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17899449
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 02:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720663316; cv=none; b=nNpdhGpi3iddW3qpB3yiT39lWYjzKcJ5BoPVIArOM5o9AvsP67HsYlKcbyhkp6xv/XAwvpaUJY3Jv+vYZ//XziCzwQMNbMf7PiG1Nze6vmcQheP5rdhB7WM43QfIwEPi35aEVT9ag2HpYpy0w/5V9AuSw9i99JP2X+Bgzt3w61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720663316; c=relaxed/simple;
	bh=iLQEaqkwud5ge/KBYXhu4Td2SGMzDYPBV6whF0z3CbA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h1Lin/lYxqrPppb/dWPdQhH6GSWDQok74vrCZIMRU47pnanH7QgtNUlnG5WiXSxc8IpOGweMcglkpW2ssv+XI7lsltzkBbBJwNNoQNydTaI/0s8XRj+gKLqT24MYcF5VKFed76b+q210Zmt0uz6UlmUz4DGIFq+pMv57IztH1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gkb/SN+T; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb0d88fd25so3001805ad.0
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 19:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720663314; x=1721268114; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TOJwxuha3RsjHgBXYgnwNE1oKAH5yMRHr4syvHPv0UY=;
        b=Gkb/SN+TKEWLZCobC8dtowjG4V7C5ktcMdvGpjJk9NpCsnCtHZQqxs0x3b80wpl4Jm
         wpKCHyUKr3GKX2k6xaGDxgRujm7e8deSOo/Q+uDpigTfxAn6foNm/hfmbdUVBUDvnHo3
         9NeNM2DYwU4czDFRKreGvldMIG9b8cjS4DnnhqkDZPqmyfAqCu/Be86nLeHTNlXQ3IAt
         ExK8PQnvl0E2xcXLCdHJtYrtEWgkWj4lfKanC4gQsJeZRFKOSjE7B43y8lcgLA7AUxG6
         vppYhatcri0JmTAxziQoB3SHFf0uKwEXGvUbUoh9ptTQZTXcMZNtVrTp6ZA71vMPnF5+
         9ItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720663314; x=1721268114;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TOJwxuha3RsjHgBXYgnwNE1oKAH5yMRHr4syvHPv0UY=;
        b=Y/Pe252O9zf3A67YCZxBDcIWedFo51ScY5nPi1ZqaccrKU2WbMIrSZjQZSty1eFttd
         JMIY9EXTz76qun/8kdHfB1Fz5lRPQhYFlpGLuqwqnM3f8ncS3yZ/MM/TvXqHYojE2SKa
         pekK1jvwUNskqF5gr5Kq56lM4fZoTZzE3RyAr4pwtDOEeHnTgIw/ESDVOipgbhUY1wO2
         xTLTOpn+OXRO6aVixmjgpOOUYtmsQsWFCpu0gdaVqZTLuH0CoxGpfgGhJzGy2a6YNq/4
         u/rbO1mHXrwrIjx3mGZPpdLGz6X1EjVvHUP4nCQz0JCfAdQZeoduj5xvTXb97gF75Ifu
         +q8w==
X-Forwarded-Encrypted: i=1; AJvYcCVFeXLBVH0M4ntmB84nopwUjdho+GoYkF2HYdB/zVsK/eRhTNJ3Xk7yjIxmQhTL4p3KkyphZP2/Y5kLpCr+07SHYpuT
X-Gm-Message-State: AOJu0YykqyrKJHK7qQs+w33OTcG2TrqtXBmpGXEoamFRfxSA8fAuY+5E
	l4HeQZ4Vbl9Aem8yirvoUdIZYSdRJHqs/osupOdODis70txFURGR
X-Google-Smtp-Source: AGHT+IEP64wlE19uvqlrThplMiajcVeRfRI3fl5SAyIexsOH+b10WL8SD7+s3JwhSgAUU3rsrGdzfw==
X-Received: by 2002:a17:902:e841:b0:1f9:a69d:4e05 with SMTP id d9443c01a7336-1fbdba2849bmr18162155ad.19.1720663313969;
        Wed, 10 Jul 2024 19:01:53 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab79d0sm39752475ad.174.2024.07.10.19.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 19:01:53 -0700 (PDT)
Message-ID: <5665eb1f4217948a3a06b6898762abf719f141cd.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/3] selftests/bpf: Add testcases for
 tailcall hierarchy fixing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	maciej.fijalkowski@intel.com, puranjay@kernel.org, jakub@cloudflare.com, 
	pulehui@huawei.com, kernel-patches-bot@fb.com
Date: Wed, 10 Jul 2024 19:01:48 -0700
In-Reply-To: <20240623161528.68946-4-hffilwlqm@gmail.com>
References: <20240623161528.68946-1-hffilwlqm@gmail.com>
	 <20240623161528.68946-4-hffilwlqm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 00:15 +0800, Leon Hwang wrote:
> Add some test cases to confirm the tailcall hierarchy issue has been fixe=
d.
>=20
> On x64, the selftests result is:
>=20
> cd tools/testing/selftests/bpf && ./test_progs -t tailcalls
> 327/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> 327/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
> 327/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
> 327/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
> 327/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
> 327/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> 327/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> 327     tailcalls:OK
> Summary: 1/24 PASSED, 0 SKIPPED, 0 FAILED
>=20
> On arm64, the selftests result is:
>=20
> cd tools/testing/selftests/bpf && ./test_progs -t tailcalls
> 327/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> 327/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
> 327/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
> 327/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
> 327/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
> 327/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> 327/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> 327     tailcalls:OK
> Summary: 1/24 PASSED, 0 SKIPPED, 0 FAILED
>=20
> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
> ---

Nitpick:
I think that test cases *_hierarchy_{2,3} could be rewritten as
example by this link:
https://gist.github.com/eddyz87/af9b50d0ff3802b43f0e148591790017
It uses test_loader.c machinery, you can use RUN_TESTS macro from any
prog_tests/*.c file to run test cases from a specific binary file.

Otherwise these test cases look good to me.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

