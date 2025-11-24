Return-Path: <bpf+bounces-75377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BE6C81EA5
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 546BC4E5824
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D7B274FC2;
	Mon, 24 Nov 2025 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWU6LghC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB1FC0A
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005701; cv=none; b=HPmmTANYYzi7FIP1dEIlefRm+vQJDfDyId35s1CtWSOYSHo0igJbtqrM6J03GXvKmqdVQHfkRNWTQeFAOCmciQszt5TwneSRd5hrTzOeCXQx0CEi0q+Cts+QU3WZpYD2igsuyO9MPqnMkvF8beEyTA5Yj+Qc3sHf3SIjTSp7k50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005701; c=relaxed/simple;
	bh=EjmkdVxhLEgUXcp9zFnKYmC7knvhOX8mMcgM2RFf9G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+yaJLHXbH6NwN4IEKVcLEHWwUMJJmtsKs53TUDqe6cIM+lS5E/LV6qXBxZHTSgl/wc4goDTLV7m8nrOTuDNRtFDFHoqM0hEaw5z68EM5TObwTe7t+7td2qQ971mGbRAYW6vHTrZx9A7Z1Thps2a7TDozNsBVMm7Dzew0BOaZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWU6LghC; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b9f1d0126e6so1847312a12.1
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 09:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764005699; x=1764610499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny1upLnO8ZhLlG0AsO+HUCdYICvMIJF9F4mzlstaKwc=;
        b=OWU6LghCNPgDFVHCjgt+IQP3dTrUMOR0sdr1y1NCKohkTjpcnGGGEDZyv7Wa6rZB8z
         7OHm/a1n35vYOqI8VBIYC+d+Ill3L+45Ej2a3lyh4IWVhTylRY2k/Ob58FamG7g/4kiH
         wGOkc8V5N2qeK5jcDYiYdEG/JEjHNW1T5JczBSmNYjxo9HIThA++RqUL78DppGssFoHm
         QKTXDoxR0e2QXV/2fYefKnfgQCGP0WT72jse2f6jde3ltfRvWftFOELraFKsPMldkGeR
         aqe5gZTNro+eTJUZ/fh9DqmIhaNIf8sqFWfDASy5o95npPDs3FuQIGeWUTCibm/Q7QbN
         yCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764005699; x=1764610499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ny1upLnO8ZhLlG0AsO+HUCdYICvMIJF9F4mzlstaKwc=;
        b=ZSpmU6mBZY+qpTyf/MkdScGBX4WmD8gJpnYOGS4sLaLFQyDulIvplkXTHqZkPfWooa
         A9VBRvLuD1KbuzMNKrQEZ8mvgKde64JcV+nrxvDFl3az46AuWZaQq8HdpLHzNDzxespT
         UBlcYIOqBnvn6BoJzWE+dk6uRcMI0FqIm5gsK2PQYFM4cuvVx8Q6o50J/Vwzw9nYZnhs
         ufKA5wHLUFnlTSF4edI11SXXdfgTZ36d6gEoexpSZmYz4XZ9ZW+8QTnyBipzo51R1s8i
         ctssRPoU57+YSld0oQ5mqWK/XEPYHpH+1QkQDIASrugI2mAnfDHTSSX4m4mJ5asNbjY2
         rhXg==
X-Forwarded-Encrypted: i=1; AJvYcCVP17YfUNOIRkiTBwixGj+SlEhpsoHUgITjnoTGG7u8XVLdvKDeITP3I2Pzlu7c/Ibglqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaj3nm7KkyCdxgJrXLZ064eVPrSKGwVEBeGjfn05H0ad3ya4Rs
	5tiob2xkAhrEpHgMLeg8ERnuvobPw7KUy5c3obciWmiC6AhxuNNGtGxw41XtSy7OhmQsYiv5M6z
	dQu3fGVMEu4G/oDGVgU7dbw6IMSZtdi8=
X-Gm-Gg: ASbGncsFq6dmMs8PqNEHFvowmku48XkMuWLWgTlRVGl/Y6qrwMEaLV8bucTQwiAqosQ
	jPPf+s/4knWdVte8AXKUm6gKHvQ8BAuxQUn3BW81WJkDAam9F2YVgjnPTIU7hp5j+0GX3KCQXiK
	PxrTrjVPNTdKT5sL9dzrkIXn9EndoS3rZrUuLAPPhKK2qyH+0s+vkP3xq0clGHOOII38E3UwJCE
	Mc1+EThW9dWkBADjKajmOpg2M4DkiKUed98eL522Z8oQI19mu4gppUL77+1GK/BNSfJcrC44jpZ
	gF9tTMcNOQ==
X-Google-Smtp-Source: AGHT+IHUGC4jY8dvoaLTAh0kdZtQOPm5tFpTKtPEcSERDrLl57DAxt+KghdKSsQXGOgWiEd1CIdNaM53umEo86DnZvo=
X-Received: by 2002:a17:90b:37c6:b0:32e:72bd:6d5a with SMTP id
 98e67ed59e1d1-347331a773cmr12480244a91.1.1764005699152; Mon, 24 Nov 2025
 09:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117083551.517393-1-jolsa@kernel.org> <20251117083551.517393-5-jolsa@kernel.org>
In-Reply-To: <20251117083551.517393-5-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Nov 2025 09:34:45 -0800
X-Gm-Features: AWmQ_bl0CoAUAVjfu93i4hNSrHy6JtvkzTIjJawsUqI0gWboVyryAlILcfksuGU
Message-ID: <CAEf4Bzb1Du11wwUK=qXeWi0V-nN7qc7VsomGiaOM_8eSH2oHtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Add test for checking correct
 nop of optimized usdt
To: Jiri Olsa <jolsa@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
> Adding test that attaches bpf program on usdt probe in 2 scenarios;
>
> - attach program on top of usdt_1 which is standard nop probe
>   incidentally followed by nop5. The usdt probe does not have
>   extra data in elf note record, so we expect the probe to land
>   on the first nop without being optimized.
>
> - attach program on top of usdt_2 which is probe defined on top
>   of nop,nop5 combo. The extra data in the elf note record and
>   presence of upeobe syscall ensures that the probe is placed
>   on top of nop5 and optimized.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/.gitignore        |  2 +
>  tools/testing/selftests/bpf/Makefile          |  7 +-
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 82 +++++++++++++++++++
>  tools/testing/selftests/bpf/progs/test_usdt.c |  9 ++
>  tools/testing/selftests/bpf/usdt_1.c          | 14 ++++
>  tools/testing/selftests/bpf/usdt_2.c          | 13 +++
>  6 files changed, 126 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/usdt_1.c
>  create mode 100644 tools/testing/selftests/bpf/usdt_2.c
>

can you please add a simple uprobe benchmark so that we can compare
nop1 vs nop5 performance easily? See below, I'd actually force nop1
for existing test with custom USDT_NOP override, and assume nop1+nop5
as a default case for nop5 bench.

> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selft=
ests/bpf/.gitignore
> index be1ee7ba7ce0..89f480729a6b 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -45,3 +45,5 @@ xdp_synproxy
>  xdp_hw_metadata
>  xdp_features
>  verification_cert.h
> +usdt_1
> +usdt_2
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 34ea23c63bd5..4a21657e45f7 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -733,6 +733,10 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SE=
TUP)
>  $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
>         $(Q)xxd -i -n test_progs_verification_cert $< > $@
>
> +ifeq ($(SRCARCH),$(filter $(SRCARCH),x86))
> +USDTX :=3D usdt_1.c usdt_2.c
> +endif
> +

why not compile it unconditionally, why complicating makefile if we
can do x86-64-specific logic in corresponding files?

>  # Define test_progs test runner.
>  TRUNNER_TESTS_DIR :=3D prog_tests
>  TRUNNER_BPF_PROGS_DIR :=3D progs
> @@ -754,7 +758,8 @@ TRUNNER_EXTRA_SOURCES :=3D test_progs.c              =
 \
>                          json_writer.c          \
>                          $(VERIFY_SIG_HDR)              \
>                          flow_dissector_load.h  \
> -                        ip_check_defrag_frags.h
> +                        ip_check_defrag_frags.h \
> +                        $(USDTX)
>  TRUNNER_LIB_SOURCES :=3D find_bit.c
>  TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read                         =
 \
>                        $(OUTPUT)/liburandom_read.so                     \
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testin=
g/selftests/bpf/prog_tests/usdt.c
> index f4be5269fa90..a8ca2920c009 100644
> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -247,6 +247,86 @@ static void subtest_basic_usdt(bool optimized)
>  #undef TRIGGER
>  }
>
> +#ifdef __x86_64
> +extern void usdt_1(void);
> +extern void usdt_2(void);
> +
> +/* nop, nop5 */
> +static unsigned char nop15[6] =3D { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 }=
;

nop15 is a very confusing name for this :) nop1_nop5_combo ?

> +
> +static void *find_nop15(void *fn)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < 10; i++) {
> +               if (!memcmp(nop15, fn + i, 5))
> +                       return fn + i;
> +       }
> +       return NULL;
> +}
> +

[...]

>  char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/usdt_1.c b/tools/testing/selftes=
ts/bpf/usdt_1.c
> new file mode 100644
> index 000000000000..0e00702b1701
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/usdt_1.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Include usdt.h with defined USDT_NOP macro will switch
> + * off the extra info in usdt probe.
> + */
> +#define USDT_NOP .byte 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00
> +#include "usdt.h"

upstream usdt.h will use nop1+nop5 on x86-64 unconditionally, so I'd
invert this, and *force* one of the cases to a single nop1 with custom
USDT_NOP, wdyt?

> +
> +__attribute__((aligned(16)))
> +void usdt_1(void)
> +{
> +       USDT(optimized_attach, usdt_1);
> +}
> diff --git a/tools/testing/selftests/bpf/usdt_2.c b/tools/testing/selftes=
ts/bpf/usdt_2.c
> new file mode 100644
> index 000000000000..fcb7417a1953
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/usdt_2.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Include usdt.h with the extra info in usdt probe and
> + * nop/nop5 combo for usdt attach point.
> + */
> +#include "usdt.h"
> +
> +__attribute__((aligned(16)))
> +void usdt_2(void)
> +{
> +       USDT(optimized_attach, usdt_2);
> +}
> --
> 2.51.1
>

