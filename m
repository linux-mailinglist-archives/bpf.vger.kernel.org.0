Return-Path: <bpf+bounces-62421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124F7AF9A4D
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7191D1792A2
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8771FECCD;
	Fri,  4 Jul 2025 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaobvnE8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCDE2E3714
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652321; cv=none; b=BjcJ4f4ezQ8Pqyk7Ep250MPDqgL/aT2Iu+qdYpUuZQINncFnxX9BW7gyIVipn/Dy5DdteCn3c9s0LQys3lGbMHCY1sLvDomVowoqGCvsKdgesueL/sIgftKtOmr6cXtusVXh2eBESaLQ3n1cOi1MC/WBm2rnCGO9o7KHRqGji74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652321; c=relaxed/simple;
	bh=qZeAmbh4L0V0p4cXEh/wt7a9CGxM+kvochafMRovsXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT3lFn8UB5c5psOsFbcgvzbUPgrjKDsdhigmOzWjO4K4mjtD5QW96fsa/QBE84XuUy+Nk0V5IEZsAyIonyQIP8siH+tFRFq0+E6zRa0MnteZ5iXMRPYR1s6Wvvjls5II2Uo6/oTukbmQrw7H+na5l2yFsNj3lM4dThF33UN+aQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaobvnE8; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso230974766b.0
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751652317; x=1752257117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EMSw4GuOSoUhON3IWKaib2ZxaADIP46flTMypCPo2No=;
        b=WaobvnE8nj+5tqzh/Q+OhSPky/+HnpR2zDw+vmM12evSiJR6d1UVpD0SQcxRx+JWHw
         E0XOY2eakPn0uaqq/8/qgfeAuw1TpqMKXz62RxGAPn8VbJEBkIdYvlyDnlKnXJm6hl+a
         58a0cW7BQzrA5eSpUHrWq/eK5sLWTqk/ITxW3tQGOhaJgrfFDVLe7PvpXZ5GSnCQaowF
         N0P3Zn9752A1KjjqaqnyIRlgxuPtWEm7q3fsVrKOsD+mWTMfUfbwx9gXnyKuZSZDTpk/
         NetIxwwxV3n/SoS8r4+Ht6b8ok68b3CnGABlnqB+3NupGSEab3kRj1szjLby/hJ0yF8a
         9M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751652317; x=1752257117;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMSw4GuOSoUhON3IWKaib2ZxaADIP46flTMypCPo2No=;
        b=m74Oq6mkwwL2g+V0UyZ2S2ORHtPRFWaNuAMynP3SKcSF5UYRelviCxJ9G/1HyS1hxG
         q9ieGuyfibJ+qaAa/kE9TJto+IO2A1D/1N4gMsDdDR2K72G0oYiwrURTqLxwCGCEUBRB
         poK/OmgWrdfmMzm4jT3NoR8XNINAbOk9CQBu6qf9O4SkJQIH6xOB17HzbIvGpt6mprMO
         S1i52SHLL8kYrbX/mMPbkxFPrR/+CtwkNJFB5KM9UcYH4a8DMRfdRI6kagax+O/Rqrw3
         CK7EafYLhJ+w+gkl9ubjMiWm9sHUz71r6tOWfu2Hyvx1jR1cjXoT3ZusNHd4EwNmWbft
         rtVg==
X-Gm-Message-State: AOJu0YwBEcvWnbNSyKxp1D0e7KLiFB4g4QnvwvgCmzRZ8EPj+j4Z3QRV
	1oqNDFkX3vV/Hk+T4/q12OzELAr94JJkJlx15miShOHeAMUlTuLEDNZIr6+/KuQ54UF7PhTkqQE
	1avrmtq/BfmboBZhxeBhtFKLSRDb35b0=
X-Gm-Gg: ASbGncuRVr7lyZsXX9yUakyQb6EK0D1k2UTmz7194mgm4CdyEsGDVkYfPZwrHvu7wQV
	QxGBs6DhenNn59yAQJwzRyK8yA4y2n1HhEyRb73M1DkBRWXTvCR7G7qx6FxEB6WHx7Z9Bg3Da6r
	1DYLj9qQBP+NVMaLWmbgjAfJ6ILVDB098xXD+p+OBi+Ve//ammyluuCXNT93sYrG3WQDtQK18D6
	MI=
X-Google-Smtp-Source: AGHT+IFfwLuFwiyXgXERXmZX9t8UyBlYiq0EWGe72k65qKIV0mry/oG5C2ZaO89PDrt5f8OCrN7i7ruj3eTGoCHqNvA=
X-Received: by 2002:a17:907:3e06:b0:ad8:9257:5727 with SMTP id
 a640c23a62f3a-ae3fbd6b304mr356094466b.51.1751652317240; Fri, 04 Jul 2025
 11:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-6-eddyz87@gmail.com>
In-Reply-To: <20250702224209.3300396-6-eddyz87@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 20:04:40 +0200
X-Gm-Features: Ac12FXz2xA5l7S3euqB2sbI5yoZH2Pl5qHw5MOrIxtdLonZClJfRaCVY2o7Z3W4
Message-ID: <CAP01T77vZLLDKzv13Mz8GVErArPbxvLYJiV-nWNbzLPv5UJnAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] libbpf: __arg_untrusted in bpf_helpers.h
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 00:47, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Make btf_decl_tag("arg:untrusted") available for libbpf users via
> macro. Makes the following usage possible:
>
>   void foo(struct bar *p __arg_untrusted) { ... }
>   void bar(struct foo *p __arg_trusted) {
>     ...
>     foo(p->buz->bar); // buz derefrence looses __trusted
>     ...
>   }
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  tools/lib/bpf/bpf_helpers.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index a50773d4616e..cd7771951a71 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -215,6 +215,7 @@ enum libbpf_tristate {
>  #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
>  #define __arg_nullable __attribute((btf_decl_tag("arg:nullable")))
>  #define __arg_trusted __attribute((btf_decl_tag("arg:trusted")))
> +#define __arg_untrusted __attribute((btf_decl_tag("arg:untrusted")))
>  #define __arg_arena __attribute((btf_decl_tag("arg:arena")))
>
>  #ifndef ___bpf_concat
> --
> 2.47.1
>
>

