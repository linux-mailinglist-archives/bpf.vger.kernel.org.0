Return-Path: <bpf+bounces-62407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A526AF9996
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 19:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DD53A2089
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 17:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77678192580;
	Fri,  4 Jul 2025 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXaLvATB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D52E3707
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751649681; cv=none; b=LaXtKRrnufdsoxQunMWFmsgP5nh/hJ1V54qSUiX/XaaLygHbyNaZ43V2gxNXbdXKuFXBxswyFni3Q3EK1ylxEeu6td+i7001TWqHW7oaDi/OmiAFHqpuQ9s4Qt0NSDY6vn9dFs665H4Z3506ACa7i1VBCCCVd0I064ZEZEZccUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751649681; c=relaxed/simple;
	bh=tWh+bc1m911fQh0YjVwb+RHP3E/wouWjR/OVFuPzLvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3az3hHhDmPYNOrEKqSeDAOD5wnE6LCYp8AAIzndEZUeaesRrGPo5iv6Bj6To8mADIP/IKtDRGnSiM2QQjwdEt3otOe79XSPjZScb6YIiW9T/lkAJZZ5pzDC/lDy5Ha0beewN1MZRT15MHyroel6TdilBmk1sClALJhtsg7oJEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXaLvATB; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so234900466b.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751649678; x=1752254478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ot3maYuBq6najGgD+/VUAKWAzgOK80VFseFYaQ9IPJ8=;
        b=fXaLvATBdYdQIKcgO8EMNLr1OzYLMOomEeolb0+W0cdXb8DcMWW8qFn31bMmW67xc/
         Ds45XjTCVHEinkFwOTadAsSWdBANH3U/QujubE/lvzHRGn5s1QXxMlTA4T5ChK2ztVqH
         eMayctRjAiyXxBx7nW2d4v/KYJ8wVXB6gbYpebfuK9s9nw2HDGiyg0aTdqminpC94AI1
         CRBHkTNegqzMxvFGyzviMFDup+cPOKQf9t7Sg+KnNq4eP7p27bnYQUDFrUh/Hmp0eADs
         cv37ouecmGCYNxOKRk+err+4igGhuuOiidtHL/91eW/N5pFuwnWRxbOVcAsrhiqzVWc+
         5l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751649678; x=1752254478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ot3maYuBq6najGgD+/VUAKWAzgOK80VFseFYaQ9IPJ8=;
        b=DsL5B8znjGSnEExhNfV6ho11MWhzONQwj4hRYJ2ODLlS4aCRUZta4CY5EPljEfuHmQ
         rCSI5bjb6/4jTryoaGCHsDYPSt7CnhwaXZPYFDtQbTORV6UiMi0gPTraEEA/fFQvSaQk
         kMKuIr8o04Efv08Iw0ZBSfElo2ct+0Uuc5/sMn7xLm4oPJU28TaZDcEosFA3zJ+bQtwo
         fpGGefuQa/1qSzZhNXv9S9BriBFbHZtB0Szsrm8tjpq58ByKTXFfnpSBccdQvEeQt1h6
         n5mzafymqpYhkdSSATpxXTNCPFOdOUTG4htayH2uivmLYdG90jnNJaQ+ZtJIi/kSwWEz
         1N0Q==
X-Gm-Message-State: AOJu0YwmlFOBE92pSMiCj0fGZfmS7tWS+ARetS3J6XUabl8970vE+5xr
	DItrRMDUMW6do82Ak5YIfjKXUB29t2WzkuPf66MQqiN9YMGXVaJhLfoPGspZQ3Sohja5InStw+v
	4PJCNWLHfcG/Nx1ijUWaMem2202j4KI0=
X-Gm-Gg: ASbGncu0rWlp+WYiBBO/lqFt59Z75t3UMO14ixg0KzoQauli1uQmD6T+Jj9boTtmIUg
	hy+Y0nd05cQmZrptrknDkXJwFLAyBbdcIE7JAkUIN/5+7hN4CaVd4QVXirx60Dl/GAtPF7lgVL4
	tJGYay/nHJtcRXkAojJ4rdZCVn4ZNmfOFL4wonwi89zfD8lfVm1gfoandT4GxpoNnMe7d7ORc1B
	p0=
X-Google-Smtp-Source: AGHT+IEtxXrfS9otCkmw6wxSHqkHyEer0n5e3XS9SdVdZaE1CzXzS86oc/WDdAs40qhv/CDIP9VAz8DWqRtIoR0kh/A=
X-Received: by 2002:a17:907:2d0f:b0:ae3:5e70:3320 with SMTP id
 a640c23a62f3a-ae3f9bb4f3bmr380844066b.4.1751649677427; Fri, 04 Jul 2025
 10:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-2-eddyz87@gmail.com>
In-Reply-To: <20250702224209.3300396-2-eddyz87@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 19:20:40 +0200
X-Gm-Features: Ac12FXy2-p81YO5wZJKOGDnQtRtIIJU5_6tYts4g65UoluapmNYfu0o2cdL5O-4
Message-ID: <CAP01T77DfUQSVBLxp91MnYu1VjNW3ZvA6WUuSNDOjF7Xot721g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: make makr_btf_ld_reg return error
 for unexpected reg types
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 00:47, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Non-functional change:
> mark_btf_ld_reg() expects 'reg_type' parameter to be either
> SCALAR_VALUE or PTR_TO_BTF_ID. Next commit expands this set, so update
> this function to fail if unexpected type is passed. Also update
> callers to propagate the error.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]

