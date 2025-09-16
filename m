Return-Path: <bpf+bounces-68570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D9AB7ED57
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B70521068
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 22:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D2A2E7BDA;
	Tue, 16 Sep 2025 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATX3ztVn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9222E4254
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 22:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758063217; cv=none; b=q5vTuKlFMpPLSaHCmfk1TSkqU6ZPk/mV1KmeSismcTSp1JLoDF8Zvklel9MsNP/REv/PCLgQdsnubxcOjVYnjxSQe+Ki60bK6f0xerfhxCClHhDAE+NqxzwklqgmwqEXiW7LRQ8ulFXnNpF/PObXb7V+4eeq4kPoSOeDMv9N1ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758063217; c=relaxed/simple;
	bh=iqzWeEm5QWwkR6y+30oQ+rGnrhGwUOHpGrDzbUCBqng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=poZGNISC3gaalFYvoVDtvLLjXxPhnOlnP8jqLV97yDQNlSOX+CvOeFmHtWfKL3p5jik1N6GwFMfLcfqCyAxDWwkK5aGZnHuUBaY9UUeS/NIvkzUv6fp1RxN/63huwxK/mJj0FE2jyNH+EFuzMDxae9/WVGgEgIJ4AyNNMiqu4Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATX3ztVn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7761b83fd01so4340615b3a.3
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 15:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758063215; x=1758668015; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4o5yTyiP50Ne2cPnQ0KZZxGHybqflpbfpM0KoBHYnkw=;
        b=ATX3ztVncqdcI8Ll2JdcNXCNUkO3oPbAc14Ukduam0cyNa2J+wDViLEpo57ftuaMYm
         pL51j6MD7ZWx1WSolIZubJkXRhlK04obcMHF4sDSXi/65QLJbAL6yFuqLF/3n/3oiMdD
         GyNXpTbPfkrYVDSSUypPD8iKLS4utlDbzJEspoYIORrnFZLUXJyr+fUcu9276m3jt+m6
         qMgoCKrJUHKTscZqbZFl8E5U8XThQU/vWkRV17XEBXd7NMaIj6cdJsmcuiiRK+pYWGIj
         rBxFZ85rmzQciefsMaf/0il2nrx4CbF2YUjF2C6oLBSAoKz8NHZaGUvsFGyr7MR6i9uF
         vKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758063215; x=1758668015;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4o5yTyiP50Ne2cPnQ0KZZxGHybqflpbfpM0KoBHYnkw=;
        b=ZQYtzJiJMRbl6uLR5TaVovIXkLGy316R5RlK73wAda9A7I0N2WtEfD0BcGYnIM+SyM
         SptD0mhJjlwqk2RnhrF3V6CsQBrEiiL7dM6fz7QyiCBKyMPhe1IZ1UXtleIZveuYBrwX
         PYhaz4Iyoe96bAy6cFgeHF+ewbW73913DBeO/M6TJDdVX4t1YXrZBAnXFfXq/I6i+y3w
         m//MWsi1gvJzkt4SpMFoPmsy9pJmH5BQBmQhqUoId3W5pFu1NRkDiuYUjyL2LxdUmgTh
         nNpNfgg6ow0H+PJd2QndPEf8m4x03CnVGlCrVPQXxOeKghFcweLDXdRfblwD1iMWIplf
         4olg==
X-Forwarded-Encrypted: i=1; AJvYcCW8a1GtkNVftQqYQsOGeeAjPkLv46j6U+gTJd6LHCawCxY8t/QNCyvY69ItlEyov17VScU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVl3whsXuBw4Ejo/LAyArjhXa8Xl2ZuOW3gG4JwRhc6eOsV9W+
	CEB3zOzO3lFkJvrO6SGb1t/Uhta+5hN90TRZgypkhSmJONgftLsYun96
X-Gm-Gg: ASbGncuL9FKDstfpbGtZck4bqjYfjIiXmRAtfvZxyCiznkkd7BugQmjcFcMOF3ifuyG
	JIZBhOhSQMTjyOjvNO+vhiUcP4wbrVkcNkj5eAmsqNKvfMxDv/0WLAPmHip4PggBUa6xJcBjVis
	z16m8GmXSDVrOLh6KYXSCjbuJJnF5ZMCcR7WnFpaSKP7A5XLpbqh3rBzgqzr59fkd1FMVcjzUFo
	4Hi0qUaEnUg6WcYP0EB/XkIXQB/bYpm4z6MX+wPV8IUny40JBr0fNPwFx9cdC8IApbyYp8fKhG0
	x01hGjJckm44o+1OPa1G99RYf9R8/3zxuVJJRS5NysPCOlzbtlzrPdwha2V51Tn62OrASOPUnOX
	hL62Cvvzt/ywTuUukIsVo8PKXk4M/P7h2RRQlD62jwOXIYw==
X-Google-Smtp-Source: AGHT+IH1fusV0HbuJMFObgBSuDhouKZcy6PLr/JaW6nQk4ynpRukA4brb+W0ifVEO2DoAiNKdJkW/Q==
X-Received: by 2002:a05:6a20:7f90:b0:246:291:f62f with SMTP id adf61e73a8af0-2602cb012d3mr21777199637.49.1758063215430;
        Tue, 16 Sep 2025 15:53:35 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a1:9747:e67f:953a? ([2620:10d:c090:500::4:432])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c478d4sm17261114b3a.99.2025.09.16.15.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:53:35 -0700 (PDT)
Message-ID: <247969bf7772187416f627692c687250ec6a4ee5.camel@gmail.com>
Subject: Re: [PATCH bpf 2/3] selftests/bpf: Move macros to bpf_misc.h
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>
Date: Tue, 16 Sep 2025 15:53:33 -0700
In-Reply-To: <6d21ac4ab11cceab453fbac8ef8c42260a201a10.1758032885.git.paul.chaignon@gmail.com>
References: 
	<f5310453da29debecc28fe487cd5638e0b9ae268.1758032885.git.paul.chaignon@gmail.com>
	 <6d21ac4ab11cceab453fbac8ef8c42260a201a10.1758032885.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-16 at 17:18 +0200, Paul Chaignon wrote:
> Move the sizeof_field and offsetofend macros from individual test files
> to the common bpf_misc.h to avoid duplication.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  tools/testing/selftests/bpf/progs/bpf_misc.h             | 4 ++++
>  tools/testing/selftests/bpf/progs/test_cls_redirect.c    | 4 +---
>  tools/testing/selftests/bpf/progs/test_tcp_hdr_options.c | 5 +----
>  tools/testing/selftests/bpf/progs/verifier_ctx.c         | 2 --
>  tools/testing/selftests/bpf/progs/verifier_sock.c        | 4 ----
>  5 files changed, 6 insertions(+), 13 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing=
/selftests/bpf/progs/bpf_misc.h
> index c1cfd297aabf..749bf235dc07 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -156,6 +156,10 @@
>  #define __imm_ptr(name) [name]"r"(&name)
>  #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
> =20
> +#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
> +#define offsetofend(TYPE, MEMBER) \
> +	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
                               ^
			Nit: this is a <tab>, not a <space> :)
> +
>  /* Magic constants used with __retval() */
>  #define POINTER_VALUE	0xbadcafe
>  #define TEST_DATA_LEN	64

[...]

