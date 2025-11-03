Return-Path: <bpf+bounces-73381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06013C2E0E6
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 21:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D9F3BAA0D
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 20:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF6296BDB;
	Mon,  3 Nov 2025 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+ufTnzQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FD1EA7FF
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202760; cv=none; b=MEYOzLXHZYp0me4lLuJBAzL+eKK3dN3dOIa30jOZUs14cSH6OkXhDBBUR9GTzJpw9Cy7GmJTXd1J6DqsFp71GeTfy5h+wP4mIIR4bUU0hw+VCypR0kLImLGitlpSjUAKcNC8r0sKEj0GE4wkcP2GijEPhdMLWSYCJIZUNxu2MBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202760; c=relaxed/simple;
	bh=KTbuhH0TpiIMnub9Ejrj6Oqy61dB87ge8XNbJkDVxBY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d5NXus+LxokBwm4eIc/BmbTkUaDCjtg+X2JGrolPQDzKWk7mA94/tULgu+wArbmjgDbeewYw41taFr8i+izoE8xVUUe0jAMFuFwUygY0Q2UpWO76uh3ysQFibUTeSNECq8VEmwsl2YOYlLNI5d2CKPwdKTPyyrwozCrXgjVWn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+ufTnzQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33292adb180so5279236a91.3
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 12:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762202758; x=1762807558; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLG/pwKORiAWoYfN+O5IQJHGGqCm/vLtC7PKSJAS8mU=;
        b=a+ufTnzQvA/Kql9O5F8lfJLXD369J8ERUU2mWwgpcZZolXNB48E6vp57iy1LWuPtAQ
         UO+hTVfdjhsVxQcWPUlj+oEnYRLJuUnjtafKTNSLxECHxE8e5J41FFXsSNiIXawFDuRp
         FXvNPNHBUYLLVZniZpGsPIsuz0xHrQ8o34mPGrTpoNYweTaMRDAweein0eOz7EEsQ35O
         5kjX+pOlsq77dtUaNjMo0coTm5f9/917Ix4oCYuyFJCuDGqQxzZAOdgB5BA5oFIm7AlR
         G5I1MTq3XxI+NYOeA2KdSJXJVqwng0J5J1wtnpoHLHPIUTKrKfWjvZxjc0xkoB1QzMQk
         3K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762202758; x=1762807558;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLG/pwKORiAWoYfN+O5IQJHGGqCm/vLtC7PKSJAS8mU=;
        b=AizBL/fWajWqnzjVRiyGXMvta2GgaigwtMj5KW5Q5MjgleNf8OrHXkOsrfHHCeGlr/
         RiRulm/WBqQeK7BxIb3RrsuD7zaDAJ5f2RM0NWqM6loUQpG7HqHKAulk/b4ztazBxT0O
         dKv8dRTVkNPggVno7s7oJVVM9c878yKDxPzw0liuwICCXGKDLvgwFocobqlGTkjBCR/J
         4cSOGxKU11qJyjgdQE6WVo0weMYrdn2qGHWzeQct7G0dagWwKDGZRYBcHn98a5xuwP99
         w/1La0WFotH1dPvpLFENpQBEwu0ZKkLk2YQhaBruFhPFejNkowCtCPSLXGBCW3UD9f1u
         ZIuA==
X-Forwarded-Encrypted: i=1; AJvYcCX8OFvJy+jOhA/20gNSA/M//XBjLjp05XheCuTPzNZCIPWcvf/udrWqTYQZNZeLP81XXuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBSTA+L/X+lqvvZlW1Ewoss4nw8TKAk6Ls/GPL3OZIBDx6jmAY
	/FLDYnZ7uAwa9neKPzB0PTavNnSMplzouL4VZGhSBPSP9pj+2WBJ/6zZ
X-Gm-Gg: ASbGncs+LuhxRve/rx5FDAD5jfwGpGhXazfCc+kRr9hOhAi/BHy1Q4R/0cgrUFhmnBk
	GiZvz1T0RvreQkPkXWRGM50RBUnGdiH0K2TyLmmCsHRuCd2+7JTD5CYuaGufZEK91c/x/QFA4da
	IgsrbaFbzh04su45+845KrPSPUNnzmA5OgNbHI9pifF6e/Ho+KMesUMgwIB4bH5KnKZIIJmqYl6
	c4jjZGX1DFUlooHDm+poAtjIlA6qlbS+GONFynMAiWs0ex+S45pTGKZTWTy/Wjp+GoDBSQQalDz
	XjkZAqsVu0P6aMci5Nzk8wjJZ7PppEEvzbgrD4ZBQr/bnIu0kCEWMRMRC+t+KUMXIewUXHMGOAM
	3e/jak5Rn2XfzwiGYRAWT2G9Q99A48Vw6kNlClmhw6/+5vkIBI67qhMkhSDEQ+umrgvdgVEfN2c
	izUy7FT/zGL7M1BSY8Uumk+jTWCoiYW5K1RudL
X-Google-Smtp-Source: AGHT+IGX68eNPLFyiovaOylx9QI739GfShL/ab3KUiuQ8giPrNp9ehP73uTUoAeMmJJ66X9QEZq8IA==
X-Received: by 2002:a17:90b:5150:b0:340:7f0d:2124 with SMTP id 98e67ed59e1d1-34082fd8cfamr18966307a91.11.1762202758412;
        Mon, 03 Nov 2025 12:45:58 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3eb6:963c:67a2:5992? ([2620:10d:c090:500::5:d721])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14bbsm2084630a91.13.2025.11.03.12.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 12:45:58 -0800 (PST)
Message-ID: <e72db29a74ce5e7ac43068e6bf8005c7a3c7cfa2.camel@gmail.com>
Subject: Re: [PATCH v10 bpf-next 11/11] selftests/bpf: add C-level selftests
 for indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 03 Nov 2025 12:45:56 -0800
In-Reply-To: <20251102205722.3266908-12-a.s.protopopov@gmail.com>
References: <20251102205722.3266908-1-a.s.protopopov@gmail.com>
	 <20251102205722.3266908-12-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-02 at 20:57 +0000, Anton Protopopov wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/t=
esting/selftests/bpf/prog_tests/bpf_gotox.c
> new file mode 100644
> index 000000000000..2a55fa91e1fa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> @@ -0,0 +1,272 @@

[...]

> +static void check_simple_fentry(struct bpf_gotox *skel,
> +				struct bpf_program *prog,
> +				__u64 ctx_in,
> +				__u64 expected)
> +{
> +	skel->bss->in_user =3D ctx_in;
> +	skel->bss->ret_user =3D 0;
> +
> +	/* trigger */
> +	usleep(1);
> +
> +	if (!ASSERT_EQ(skel->bss->ret_user, expected, "skel->bss->ret_user"))
> +		return;
> +}

[...]

> +static void check_other_sec(struct bpf_gotox *skel)
> +{
> +	__u64 in[]   =3D {0, 1, 2, 3, 4,  5, 77};
> +	__u64 out[]  =3D {2, 3, 4, 5, 7, 19, 19};
> +	int i;
> +
> +	bpf_program__attach(skel->progs.simple_test_other_sec);
> +	for (i =3D 0; i < ARRAY_SIZE(in); i++)
> +		check_simple_fentry(skel, skel->progs.simple_test_other_sec, in[i], ou=
t[i]);
> +}

The above means that fentry programs are accumulated for 'sys_nanosleep', r=
ight?=20
In all 3 test cases that use check_simple_fentry() the identical 'out'
values are used.  Should the programs be detached here to avoid
possible masking of a misbehaving program?

[...]

> diff --git a/tools/testing/selftests/bpf/progs/bpf_gotox.c b/tools/testin=
g/selftests/bpf/progs/bpf_gotox.c
> new file mode 100644
> index 000000000000..8a84f4b225b2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_gotox.c

+SEC("fentry/" SYS_PREFIX "sys_nanosleep")
+int use_nonstatic_global_other_sec(void *ctx)
+{
+	return __nonstatic_global(in_user);
+}

Should this check for target process pid?

[...]

> +#define SKIP_TEST(TEST_NAME)				\
> +	SEC("syscall") int TEST_NAME(void *ctx)		\
> +	{						\
> +		return 0;				\
> +	}
> +
> +SKIP_TEST(one_switch);
> +SKIP_TEST(one_switch_non_zero_sec_off);
> +SKIP_TEST(simple_test_other_sec);
> +SKIP_TEST(two_switches);
> +SKIP_TEST(big_jump_table);
> +SKIP_TEST(one_jump_two_maps);
> +SKIP_TEST(one_map_two_jumps);
> +SKIP_TEST(use_static_global1);
> +SKIP_TEST(use_static_global2);
> +SKIP_TEST(use_static_global_other_sec);
> +SKIP_TEST(use_nonstatic_global1);
> +SKIP_TEST(use_nonstatic_global2);
> +SKIP_TEST(use_nonstatic_global_other_sec);

Nice.
I double checked and tests are skipped when old clang is used and pass
when new clang is used.

> +#endif /* __BPF_FEATURE_GOTOX */
> +
> +char _license[] SEC("license") =3D "GPL";

