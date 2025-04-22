Return-Path: <bpf+bounces-56368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F47A95C34
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 04:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAFF166C0A
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6019D07B;
	Tue, 22 Apr 2025 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWjjzSaF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396316CD33;
	Tue, 22 Apr 2025 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745289460; cv=none; b=CeNGQHAjvRmzvrFwzLh9+FCHpTXjG9+Rb8OO/ngphMoqws/XIYxUiZQPLMmMuQMEsOgKs3vZ0kv0hn+1gzC8OoWEyC1zfSgQsVrEDGTIV0booXy+r4yNYG8EXAIi4CnVGVVhgG+Ux8/bm7/loZHUb3MW9o2e2mTo6xaQk0yfR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745289460; c=relaxed/simple;
	bh=P4pwXTFALWo3FBEQ+0ix3xSSBpAXL6odW8oiDWfuV5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouTHv2tV/D3WUquZPjfWdbDKcIYbhbv+xdYlYx/qhwX8O90xRCITLzmF8c/PKIQb4C2xGT/q1M+3s6NtvBcTAi1JJSZSbXwsYrIKXGFAIqGRuPhP75mvKzxbmseXz5pVbMDoBnikRWqgGSNAlUg9gjtgdccAo2KRKHWgwgWOG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWjjzSaF; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso7075155a12.0;
        Mon, 21 Apr 2025 19:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745289456; x=1745894256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P4pwXTFALWo3FBEQ+0ix3xSSBpAXL6odW8oiDWfuV5U=;
        b=OWjjzSaFTMcLyuazG7km5dqJDIlV49LQ3gVLJlsYFoMHoaSrIkFPQrGC2NRHWxOa5N
         E/bnP4nKfHLChe6QkyynREKw10AQp/bipwkLiUv9Kglf0aWdlI/YigcMagGnO3Z6gLfM
         bbx0sDGMDO1V6uK5Qrkw3EL5rLP+AtarUOjUug3d1VlDI86SeHzX3udvwMONMxY8y3Ty
         84BGThwL2QK42yYNXTqneCoDEibbK2vVBuJACXDuVMx2tjMZiyPZw/MlPuNLCN6qsRh/
         eOHuav4k+xiuSCnCCB1Z1Mxgki9EriNIYaGq8YFuygITxXyZXlYrKa6aQYVW/MB3cT3U
         xPXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745289456; x=1745894256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4pwXTFALWo3FBEQ+0ix3xSSBpAXL6odW8oiDWfuV5U=;
        b=pFgxvKMRmrJN/Nbx9U55hh4micC2OHMMqwhCuRQnoBHfT9+5hCtqNNAqBkv4Sj9nUp
         hc29Dz/lqJhNe3gNQ37kEuLUh9iVFRKO6nZ7YakjsUhLzhz4e4iwmPD+wMikeSz0W57d
         z2FO5LtEAQBjQ+vzwaZXtwdmpBWOnO7GB5vGUWbhBUeycJboLeD0NITcbV6xFMkvIr9/
         FyLOp6ZsxVsneBQWboqhyDHX9cGjgy41fGZNP2C8QZJg771aBT4dVWot81xGnG10dD42
         +8GxkFYRJZEmi9JcPJQenpWr4rE2GGO8W7HC9OWellRweBql7WofD4IJwvomWykQIYgs
         h/cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTidb+CA5UoIwuG6+Gc8Faq2sgCdKNpFfIF/2r+ZAeu/LUVnI2oGpYR8s9ZHWmx9NPfEnqeAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OEtsICRrHNFmwkCLBsjxf0GZsbXxFkbBm+hrA9ucrMNaX/ME
	cyso0DLQXzvAQzvHFPOMGfb13D/Yv7kCTl7O3QAl3ZM8ygzkO3nIFdmzAYVnKCimLNkTVLjalp9
	/E2PEuVjMwYaMvsn7dycCI0ogcbg=
X-Gm-Gg: ASbGncuDejuhRN/cogR9+O3KW5B3DTezx094kE+kcstDV1eaCgo7Q7ppFnQPHIX0ktR
	88rx+LRBzn3jPDI5NfgLHBkjb+svcLNRb7puz//nYqabz3Giec9pnmGIbSmpyoT9GEpwy6rebro
	mGBudV0BT0PLdjuQLUUreBF7N5wtZA/HJiDl8Lcb7DXEs=
X-Google-Smtp-Source: AGHT+IHIm6iHjkIq/h1wgvZhhKoVGeEGXsjapcVDluTf2aIqUUNy7PcFHiY00w18lg8M+DlC/ffwQwmstJ1JIQ8P6eA=
X-Received: by 2002:a17:907:6d25:b0:ac7:c585:c3bc with SMTP id
 a640c23a62f3a-acb74b378d9mr1215383566b.19.1745289455780; Mon, 21 Apr 2025
 19:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-7-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-7-martin.lau@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 04:36:59 +0200
X-Gm-Features: ATxdqUH34JwXrH27hV70d-FHZxGTauMCud6s-TX4oW_aulyZknk4sPNYBl0cvEA
Message-ID: <CAP01T77kU=LmH-z1WQa-4fiC8XvF94mH1NApTxt=hEPSfYFYfg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 06/12] selftests/bpf: Adjust test that does
 not allow refcounted node in rbtree_remove
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	kernel-team@meta.com, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Apr 2025 at 00:48, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> rbtree_remove now allows refcounted node now. The
> rbtree_api_remove_unadded_node test needs to be adjusted.
>
> First change, it does not expect a verifier's error now.
>
> Second change, the test now expects bpf_rbtree_remove(&groot, &m->node)
> to return NULL. The test uses __retval(0) to ensure this NULL
> return value.
>
> Some of the "only take non-owning..." failure messages are changed also.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Looks good, but again, we should fold into the previous patch.

