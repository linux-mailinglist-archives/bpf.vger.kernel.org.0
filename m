Return-Path: <bpf+bounces-16646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25455804160
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF1A1C20B70
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3643A29E;
	Mon,  4 Dec 2023 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy5g9FCD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C06FF
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 14:12:33 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c09fcfa9fso18848195e9.2
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 14:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701727952; x=1702332752; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=288qIq9nmh/33XbH7d5teFlb1oR0DaHjqyVe+bohUAI=;
        b=Qy5g9FCDDDSfElVcijAMlXFTPcwHrOdoiW8/pC9LqKmu0XmC3okwq2biN24GqNZ7N/
         JMeLDdy4OqNkBH2coPfe+irql38ErUGLEWpKPlKHKfHo8Wr7j4Oc8Tu3UGOuynRYjKqc
         umK7tNknIoyFz//FMCw8roNFuFQbStwc1c68i4dGfZeikNK0AZB4s70bJ5pLe2ur2FVD
         9Wp5tS6wxAchGP+Xv6V8naIUAXYA1TR5W7C6zk20/sqp3320JiOFtexYCre3na+ezhs0
         1phD6mvk7gZyfMDymCRmA0mu01qM4o4c6pebhTg6Rr67G0dYCcT00H/gkQmzC+c/uiAY
         jt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727952; x=1702332752;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=288qIq9nmh/33XbH7d5teFlb1oR0DaHjqyVe+bohUAI=;
        b=ppECtqwUhPwLAtBe/8To2CrorHErWqlqWOvnOPOXQ1XbHgGB0qcMmPONYagD26wbqX
         5LYHFuJHvU5YNZnJkcT8RtAzFHIrgdqbkBKJQgR6FCqAnnqT6tT1X8C5WDnNQnPZxtH4
         LEeYYZuuQy232Bla5QTktb0EuulT4XB4SBervofC5uNfmhx1d5hK5BRy3ZFLFLw82Pwv
         84w3myvDPO+1MXY6f/nRMjPqUIhfwV+xAvuqBRglRn/1fT2rHamW8vy5TPQPhjn9o9PK
         vH2a5J+fxKKBHrM8ij+ZDvsf5YC7dTIeyqC0uT4jxRYjN9038IADZwCjgX8ko7j6L+rO
         Ce0A==
X-Gm-Message-State: AOJu0YwGXCKN1qK5wt79PlnlksR7hL6IRq1z9rJLpzM5kMxtJD9gIb2a
	oPRC43srk6NPqx3aTPHH2sw=
X-Google-Smtp-Source: AGHT+IER1tAQIMLFsKrhFyKpjMMst9KefQe0yx5T8GcWRH1hbCPwqLm0B2WJ5mzEOh/qCyuK8SZKOA==
X-Received: by 2002:a05:600c:4f49:b0:40b:3eb9:3f77 with SMTP id m9-20020a05600c4f4900b0040b3eb93f77mr1392991wmq.27.1701727951625;
        Mon, 04 Dec 2023 14:12:31 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090634cb00b00a0f770ae91bsm5692884ejb.89.2023.12.04.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:12:31 -0800 (PST)
Message-ID: <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: fix check for attempt to corrupt
 spilled pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 05 Dec 2023 00:12:30 +0200
In-Reply-To: <20231204192601.2672497-4-andrii@kernel.org>
References: <20231204192601.2672497-1-andrii@kernel.org>
	 <20231204192601.2672497-4-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 11:25 -0800, Andrii Nakryiko wrote:
[...]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4f8a3c77eb80..73315e2f20d9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4431,7 +4431,7 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
>  	 * so it's aligned access and [off, off + size) are within stack limits
>  	 */
>  	if (!env->allow_ptr_leaks &&
> -	    state->stack[spi].slot_type[0] =3D=3D STACK_SPILL &&
> +	    is_spilled_reg(&state->stack[spi]) &&
>  	    size !=3D BPF_REG_SIZE) {
>  		verbose(env, "attempt to corrupt spilled pointer on stack\n");
>  		return -EACCES;

I think there is a small detail here.
slot_type[0] =3D=3D STACK_SPILL actually checks if a spill is 64-bit.
Thus, with this patch applied the test below does not pass.
Log fragment:

    1: (57) r0 &=3D 65535                   ; R0_w=3Dscalar(...,var_off=3D(=
0x0; 0xffff))
    2: (63) *(u32 *)(r10 -8) =3D r0
    3: R0_w=3Dscalar(...,var_off=3D(0x0; 0xffff)) R10=3Dfp0 fp-8=3Dmmmmscal=
ar(...,var_off=3D(0x0; 0xffff))
    3: (b7) r0 =3D 42                       ; R0_w=3D42
    4: (63) *(u32 *)(r10 -4) =3D r0
    attempt to corrupt spilled pointer on stack

Admittedly, this happens only when the only capability is CAP_BPF and
we don't test this configuration.

---

iff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tool=
s/testing/selftests/bpf/progs/verifier_basic_stack.c
index 359df865a8f3..61ada86e84df 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -97,4 +97,20 @@ __naked void misaligned_read_from_stack(void)
 "      ::: __clobber_all);
 }
=20
+SEC("socket")
+__success_unpriv
+__naked void spill_lo32_write_hi32(void)
+{
+       asm volatile ("                                 \
+       call %[bpf_get_prandom_u32];                    \
+       r0 &=3D 0xffff;                                   \
+       *(u32*)(r10 - 8) =3D r0;                          \
+       r0 =3D 42;                                        \
+       *(u32*)(r10 - 4) =3D r0;                          \
+       exit;                                           \
+"      :
+       : __imm(bpf_get_prandom_u32)
+       : __clobber_all);
+}
+
 char _license[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/self=
tests/bpf/test_loader.c
index a350ecdfba4a..a5ad6b01175e 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -430,7 +430,7 @@ struct cap_state {
 static int drop_capabilities(struct cap_state *caps)
 {
        const __u64 caps_to_drop =3D (1ULL << CAP_SYS_ADMIN | 1ULL << CAP_N=
ET_ADMIN |
-                                   1ULL << CAP_PERFMON   | 1ULL << CAP_BPF=
);
+                                   1ULL << CAP_PERFMON /*| 1ULL << CAP_BPF=
 */);
        int err;
=20
        err =3D cap_disable_effective(caps_to_drop, &caps->old_caps);

