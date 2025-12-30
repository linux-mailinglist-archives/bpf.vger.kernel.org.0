Return-Path: <bpf+bounces-77544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C898BCEAF06
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 00:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97E07300C0C5
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 23:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C4A2F8BC3;
	Tue, 30 Dec 2025 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnuwhtPK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAB11FBC8E
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 23:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767138569; cv=none; b=acQkl/zA2XPOSmPZEYP//4kUPlRrw3Qz+F3qN2wr03iG+7VLK6A9cYM58DbSDoXXjThu9ogJx9kniRFtiNlILCPnhMKMkqx7GZv+EZYtLV3q+75fkLy0sZF8I+KBScP1uDfQlF/e1GsoHq3CMHw/8/ElWyDtSZPgdwd5Ie9lnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767138569; c=relaxed/simple;
	bh=76cgsgkgm6USI9l2QJoDtNC2eCUtefcyxy69ej9b0V4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TEsn9RzzGo0W9y+VbQM7dSpdbHhCAdXO9F2RmQ2pxE2CVZW2gla8W2YyRIZ86InB0i9kcxJxf41JsyHoR7IgA0uaSH1XgditOS3YwrUoMlUtHNhfa2bWO1fZlMtAENt7yN/oLDxOk6x6CXn+k9t3JC/wg6vVZiLQQPFXALPKjEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnuwhtPK; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34ccdcbe520so6004175a91.1
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 15:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767138567; x=1767743367; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDeJwcRJl3DxaeW8EJAc/FJXGPXTOer4HjazSeSJ/pI=;
        b=OnuwhtPKo+SeJpljy2IikwzbZGvAj0kcBooxuXbMyUyN5VOOXepN393EI5C7IvgXWC
         3pUUW5PRCqJkylfzKKYSv4S2mjOZH2X6cwRhXYb0xzcxkeI+dnmQMOidv4yEUhYJIGYG
         4CzwAlfxnLL/GZirjtV/pSDf/ke/A11tHndtrxjtOfUvKQ7YoX74Ky30HopQ3ugiBQxe
         RALWjwzyVVdDwYRKbT0wsy8hh+kSNCShElcmPTeMC4ozqVXWwQ1j7OpHn3q73OHJMadZ
         avDHK/Ler7m/YWdH2hFNYmXs0Vxle6QjKmjZz+Jiy6WlHmTqpctLscxDiGop3EbJsDdK
         ttBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767138567; x=1767743367;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDeJwcRJl3DxaeW8EJAc/FJXGPXTOer4HjazSeSJ/pI=;
        b=YdxhB5M0NiripJizHfjKwBMa1oMxjYoMotxnEMZe0/x0lan0jul92ZEC0/9VqhydX7
         n/GpmIZ/93NOEggRzw89+7xTFaR+r4JOiYWMmrObPamKrtAluiRADEqVWpxRhko8L2Xu
         0GaZrzVmkeSZQQ10pYcmxNGtyp7hhmbLMxg9644OK4HmRaqa238x8te+Z502XsND1+ec
         NgRkEROxWrseUcfyu6MN/4pe8gqN0xZrojaXjLe7cJ15w98u5FBpkl64TmfyD5q6FM4z
         NywqUiYLRn4GmDNVuR4eXtzEVZ+38sLhvwzz5nvQPodS/OmqwQ6YdObbgYwjd5X4fzx/
         6+fA==
X-Forwarded-Encrypted: i=1; AJvYcCVRZYr7LrBxY8aXngd2wVVTXfTB1Wmln1qs6ouv0XUdFnhRsq4yZn18/Ej4Z0eAFRuK8oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8tYMsP0VDlNYz0JMXg845CFzR7EupVwuRoqByZ64raLZDerT
	osNo8kkk3WbPciDql1+egxIH7/zEIVOMm3gm7floa8OyUpFP2cLj84sg
X-Gm-Gg: AY/fxX7N1q5bhBjcUBoSZe50LD2lmzzEplkp74hCytT83QygAx8TMn/9+wiwtxYfwAg
	OCaWkSepIC5qzgNPs7ZSEi3q6sXVMiPizGOJD3Uyb2pesOuoDI6cwcFhM48UyFWWEJVa1iTA7go
	8AxyMgc6wUMqr78dKrMcEdBnfL2gaijcmJs3dp6ogU/M6GbAWibT/fYNvpLb25SBh8TiV1MFEPe
	+cZpw99GkXFW9N+Z+fWUIeSD/gZyq1510wUZXWvrBmbjWgW8NDHl0Hfh4zSQnBu9LpsaD0FSkgm
	QZGxKjr4A0AVBTyjjnAXecR+6sJ1ZNChOv+uzEDJWRwG1FqR1EoElPEopW+VGvNkRXEg+/KZq1j
	REhiI5jo8FRQglLyajc7w71KJuoMPiP3cGoZb8SmvRZZgfU5iNSUC64ZC1Ca8mUSgNjsX+YfbTh
	MLPqZsPFx8
X-Google-Smtp-Source: AGHT+IG4QJ1tFwGjEsJiI4Te9Q56NHpZ6bRILAFGRNkInn+M1T3S8ZxBsNZk7jgKsyBMXuFVLCFcew==
X-Received: by 2002:a17:90a:fc4c:b0:343:e692:f8d7 with SMTP id 98e67ed59e1d1-34e90dcfcb4mr30988122a91.11.1767138566918;
        Tue, 30 Dec 2025 15:49:26 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e921b1666sm30910387a91.7.2025.12.30.15.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:49:26 -0800 (PST)
Message-ID: <4cb72b4808c333156552374c5f3912260097af43.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Make KF_TRUSTED_ARGS the default for
 all kfuncs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Tue, 30 Dec 2025 15:49:23 -0800
In-Reply-To: <20251224192448.3176531-2-puranjay@kernel.org>
References: <20251224192448.3176531-1-puranjay@kernel.org>
			 <20251224192448.3176531-2-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-24 at 11:24 -0800, Puranjay Mohan wrote:
> Change the verifier to make trusted args the default requirement for
> all kfuncs by removing is_kfunc_trusted_args() assuming it be to always
> return true.
>
> This works because:
> 1. Context pointers (xdp_md, __sk_buff, etc.) are handled through their
>    own KF_ARG_PTR_TO_CTX case label and bypass the trusted check
> 2. Struct_ops callback arguments are already marked as PTR_TRUSTED during
>    initialization and pass is_trusted_reg()
> 3. KF_RCU kfuncs are handled separately via is_kfunc_rcu() checks at
>    call sites (always checked with || alongside is_kfunc_trusted_args)
>
> This simple change makes all kfuncs require trusted args by default
> while maintaining correct behavior for all existing special cases.

While I like the idea behind this patch, I don't think this is 100%
backwards compatible change. Not unless you check definition of every
kfunc in the kernel and add appropriate __nullable annotations,
like you do for some in patch #2.

For example, consider the following kfunc from drivers/hid/bpf/hid_bpf_disp=
atch.c:

  __bpf_kfunc int
  hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
                     enum hid_report_type rtype, enum hid_class_request req=
type)
          ... __hid_bpf_hw_check_params(ctx, buf, &size, rtype); ...


  static int
  __hid_bpf_hw_check_params(struct hid_bpf_ctx *ctx, __u8 *buf, size_t *buf=
__sz,
                            enum hid_report_type rtype)
          ...
          if (... !buf)
                  return -EINVAL;

  BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)

Currently, it is possible to pass 'buf' parameter as NULL.
In this particular case it would lead to an error code returned from
the function, but is it the case for all kfuncs in the kernel?
For some kfuncs NULL parameter might be expected as a part of a
non-error scenario.
Also, there is a question about kfuncs declared in out of tree modules.

So, I think there are two questions to be answered:
- a review of all kfuncs in the kernel checking if there are
  sufficient __nullable annotations;
- are we ready to potentially break BPF programs working with kfuncs
  defined in out-of-tree modules?
 =20
Wdyt?

[...]

