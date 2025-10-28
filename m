Return-Path: <bpf+bounces-72517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60277C143D0
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 12:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0591A26C31
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 10:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E359302150;
	Tue, 28 Oct 2025 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mg89WkOn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F4277C96
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648764; cv=none; b=Qd94tpflJBdiPbYUPSwYkejPChcvoRiUaT/OaDvCClIuXXOZLYif4PzyeKYrpItcYeMN2sxtXspIljA6cCSVM65/36/CnES1Q9m3F1RIz58xWXkHZ1dk7WKGUXSozLZJvQj6rBHEUx7nQ/zFQ9S1K4xBgKxsuJx3ZPLs01yPVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648764; c=relaxed/simple;
	bh=Py7d/pTPFOK6RrhmjKiR7J60AA7/QTdOI/zNquEcOOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8+tG0SO+2zXfeOUgNdVq9WwH9OaYQWvemwFlTbPwgYDcRMUycYHcJKSYS6gex5UMIPAaqbuVj9Iq0jpsukhjhHVIk/djVNoF2iHtvD3/8JtYDMxGhR2bXMkSU7p2gj8h2gBGQsAOdRJkNnGIfglJUb6+PR01Xec4MaAEyWwxuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mg89WkOn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47719ad0c7dso5920295e9.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 03:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761648761; x=1762253561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CM1/rdnARq6V8yWHkf8NlMSxVL3oKohVhRNxL9EXxJ8=;
        b=mg89WkOn8FzDewynEF/tuZalutrkRIi/3H6hC9I1bCD8X4vCWjhXbinYA/HWSVxHBz
         amTuCvrpEwZdtDoDZQVopiCBzZw468m6gGbeaYXfzz3JnXJMk+5JKokUhhxTo3vTkDSu
         581l7kZNfaNmB+Jn9QIRk97APE16iv1JtSA5m3Pz+PZ9WE3EceCX7SB8HkhRZEQoWCFp
         uhGOKoU8HEZ3gCr/a2XqybazgkHc6r+bUR9vmy618cgxWL2O8v5CJVjg4106yKQm5ZE1
         fhwO3JHXLm9O44EUPmfmUuX0AGihjfa+DQS8uNBQss+xNOt7R7j1yOZNIf5OlDhiKclT
         OmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648761; x=1762253561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CM1/rdnARq6V8yWHkf8NlMSxVL3oKohVhRNxL9EXxJ8=;
        b=L73/xkJZYpdVx2rgVt1EFC+ukIs8BCnCa6pgbSIPiKEelCR3cWkcGLyyh6wuwYTlNC
         xGe6pisBDntZSe4siyst9E1tG4S6WrWx+b59bFFrAkaRMm1esKWOpFwGqLvMPs7lD46f
         VgpnO61KI0bPdRaKcWItfMzndhzQazQdNcwlzOSMbETosjMyPI2FkOk03/SC2SULFs0V
         1PBTyBfTEjiubA5MS8VyBkTzJkpAk4Gp6FJyxe1TebcDs9Qxiroyz0PJ9+X8AUdZDEPQ
         VgytG5nUub+PmI24GVqlZe5LzpFmN27opw22qzVcytnFJ+cU+v3vUA+AX+m3rKaQuaOO
         CChw==
X-Forwarded-Encrypted: i=1; AJvYcCXEAkLvcjhJVTDhNutcVGsqYhQhQ/0M9lGkPM7I1dMtmRLyscAw7c6CtDJbMmflCs861wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFuDDVpD/lMWZxcfBeDFu9ppjj5z63tHc7qX/Cqmtagyfs5xe0
	NGHywLPEIojRXUc1wR+EUdikdR1I0gvAYLAV7tRLUlHwhnNL9ioNR4HL
X-Gm-Gg: ASbGnctdidFl+7j4HNVCDJs7R7oW8jzYe86nH9Lud+tpqIMp6DjY8nUA58gelAJdxWk
	vtC3oJyzhWzGwKH9HBJg3ZGc6jg+NX7/TxQRVO90qBCzHLdTRWXg/5lZOvGC9V26YOF5qWf1Yr3
	oM3IWaQDDjOe355+1Fva25YBilmTil2Z/v3Pfv45NbnTN3xJYG5KtHSkEIilPj/NpB6ZxtxuSJm
	tSMGn01yo3gGAr20OwV1Ml762IFdD+zY0CCTabgR/7vGwDTZjZ5YHTrp7mMTTyC80bI4HHtEGZo
	zxRcL2c/AU8/yEHyQscPCjeSqZcooeqV4XEZd8Og9aJBO94SrAb1a4QEWLY5wgGBlMcsyFmC2O5
	RRfFRF85zWtF+I5yNIsCRqz6Vi4QD6vl4/Hi5pv26gLN6MuEagTwe8mN4ftURS9gDBNnr3RqxC3
	q4uc9gGBYrPw==
X-Google-Smtp-Source: AGHT+IHYD84AHYDSl3jEMjC6xzktZV8Dcn5AfHYdqT/hQruzGAPyC8HXb6sqCN9pK1NwWjNBsnInBA==
X-Received: by 2002:a05:600c:a013:b0:46e:1b89:77f1 with SMTP id 5b1f17b1804b1-47717dfa406mr26202095e9.9.1761648761332;
        Tue, 28 Oct 2025 03:52:41 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4cc5efsm192625775e9.16.2025.10.28.03.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:52:40 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:59:16 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v7 bpf-next 12/12] selftests/bpf: add C-level selftests
 for indirect jumps
Message-ID: <aQCiBNHFYENQdNvL@mail.gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
 <20251026192709.1964787-13-a.s.protopopov@gmail.com>
 <ee2274f3293eb82c3c4671de8cefcbf6d679c0b3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee2274f3293eb82c3c4671de8cefcbf6d679c0b3.camel@gmail.com>

On 25/10/27 04:25PM, Eduard Zingerman wrote:
> On Sun, 2025-10-26 at 19:27 +0000, Anton Protopopov wrote:
> > Add C-level selftests for indirect jumps to validate LLVM and libbpf
> > functionality. The tests are intentionally disabled, to be run
> > locally by developers, but will not make the CI red.
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> 
> [...]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testing/selftests/bpf/progs/bpf_gotox.c
> > new file mode 100644
> > index 000000000000..3c8ee363bda1
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c
> > @@ -0,0 +1,402 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include "vmlinux.h"
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_core_read.h>
> > +#include "bpf_misc.h"
> > +
> > +/* Disable tests for now, as CI runs with LLVM-20 */
> > +#if 0
> 
> Yonghong,
> 
> I think we need the following thing in LLVM:
> 
>   diff --git a/clang/lib/Basic/Targets/BPF.cpp b/clang/lib/Basic/Targets/BPF.cpp
>   index 0411bcca5178..8de1083d758c 100644
>   --- a/clang/lib/Basic/Targets/BPF.cpp
>   +++ b/clang/lib/Basic/Targets/BPF.cpp
>   @@ -75,6 +75,7 @@ void BPFTargetInfo::getTargetDefines(const LangOptions &Opts,
>        Builder.defineMacro("__BPF_FEATURE_GOTOL");
>        Builder.defineMacro("__BPF_FEATURE_ST");
>        Builder.defineMacro("__BPF_FEATURE_LOAD_ACQ_STORE_REL");
>   +    Builder.defineMacro("__BPF_FEATURE_GOTOX");
>      }
>    }
> 
> Then, Anton will be able to use it in order to decide if to skip the
> tests, wdyt?

This will definitely be useful for the BPF side.

Where this doesn't apply is the corresponding prog_tests/bpf_gotox.c,
as it can be compiled independently and for sure it will not have
__BPF_FEATURE_GOTOX enabled. So what is the way to tell preprocessor
if gotox was enabled in BPF program? Is there a way to pass/generate
a macro definition from BPF prog to skeleton? If so, then it can be
used in the prog_tests/bpf_gotox.c to enable/disable tests.

> > +__u64 in_user;
> > +__u64 ret_user;
> > +
> > +struct simple_ctx {
> > +	__u64 x;
> > +};
> > +
> > +__u64 some_var;
> > +
> > +/*
> > + * This function adds code which will be replaced by a different
> > + * number of instructions by the verifier. This adds additional
> > + * stress on testing the insn_array maps corresponding to indirect jumps.
> > + */
> > +static __always_inline void adjust_insns(__u64 x)
> > +{
> > +	some_var ^= x + bpf_jiffies64();
> > +}
> > +
> > +SEC("syscall")
> > +int simple_test(struct simple_ctx *ctx)
> > +{
> > +	switch (ctx->x) {
> > +	case 0:
> > +		adjust_insns(ctx->x + 1);
> > +		ret_user = 2;
> > +		break;
> 
> [...]

