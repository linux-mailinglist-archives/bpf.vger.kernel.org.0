Return-Path: <bpf+bounces-51100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627A5A301F8
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 04:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72123A90FD
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 03:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487771D6DC4;
	Tue, 11 Feb 2025 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNW0CKPD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57653374EA
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 03:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242908; cv=none; b=XZmxwYohxJQYzIwYywZXswNDw45hsu/M1jcfPWum6XAp0e7HW9/TN7HS4QD6WYwdXGCm6UjeC6japvcsGbfQNruNjcQToi5ReYEnaT1KMKa3pk47kd6QBP9CdBZM6KuqQSU5uYlE6N97u3PEqBenyYWOTBXsx22x+9YaS+BTYiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242908; c=relaxed/simple;
	bh=4vPEyx/Cxi2crA92ocKOKDwNgtr/Pk8d/P0twqkcyyc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aYq2Zz/zv2AinJPi6t9GnVHrvMqXqtb70dx2BGlb1kQvF63mMEZROrrOOdJtBHA45hBKW6/yF7PW1Y8MGtkzKONzYLjLxJVpNBv4RYho4CHVO2Zb12JYr2NiH4xwkETekN2o0RQz+jJ5guZti7n3rZhzAqatTb/dCFS8Ze6aZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNW0CKPD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa19e1d027so6414060a91.0
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 19:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739242906; x=1739847706; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=swUpt3MGMWVmL6Fia0zHUWcytltlJ5MCz+nrBrJfCjA=;
        b=nNW0CKPDmajZnquYIb6VdvmKFgi6UNybtcltEHc0W1ELGy7gqsdE3HlMmFJD36nV3e
         Dv8tHnv3ZgnzYCLGvYIAMqczDVe2itEsVfU8sZ8yXcYcuBGxpxtFDLg7RkNVjL7WDyYr
         T4zb0qdfuagJjlUSdpxUdB2hEP6B7dQR6z66mlgEv5CbpmBw7yzWSTjPM4syK/Dv97x8
         qR6IYXI60B6sA0RmAIki/TmqiGy9hctgSVs41iRLboMOt1b2ulmjd20S9CuXw7HdHjIV
         PN6TfsP9cojQDPE0N681t6MT8b9nUku7X8ccwNFVDAZ1ipoPBQMe1Yp0mA1xacrQIxzx
         7Ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739242906; x=1739847706;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swUpt3MGMWVmL6Fia0zHUWcytltlJ5MCz+nrBrJfCjA=;
        b=TwvzGS4h40q5yBiYrvY8WfRJ4zrJJBQjigVmSgfHYkcY/uagO4rh733aXkQtRiAu1w
         aF03TtAGQzMRrD/3LJtajlylr2Wq9FfdHvGk7/LNsAEARwzUQ+wTUR3cxiHmbzeDIBLk
         /7lEdWQVSiIWainN0PdwzXRdoVm4nyErxLFZ8wUyfYstI9xQXe0RHQcOoPOzxoBKWjwc
         ZDaWn/4nwqi4JY4kUOwGBGIABoIOkA6oAUx/fSFLiOlbIsU6PEQBvhmSlK82RC1gMRzt
         A953sRoCT379rwReJhoV0059o8tLkVvrE0Dy+6Xhv7qph7Kv3DmWIIGfqzuw6s8f7wSH
         daGw==
X-Forwarded-Encrypted: i=1; AJvYcCWwbYFmdlSm19Po4zctKXFYBc1veCg34863nsHR4kaDqHB/RAcvN8aSDdh4ZIgKdYwW19k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLX2hdQhSYgDW4O1GgldPs+o2J5kWhJu6xSq3uIN3Zg0BbSI7m
	ullrPkcJOSG1tLl2AtHSsBdApP/g1UJMr5wwsxkmM7tlFVE+98S5wk9qwaOf
X-Gm-Gg: ASbGnctuTAk0IIbSt7vukxsEXHDdIeUNjHk+HUUmvTQBaaXi5JAqffvYx6fxEA/K8XI
	fLpruHYuQsi3zhIuZdXmAC3qLXvwsjiLsoeWNeolVu311QwHBiJjgGYFR7bhKsT6xtEm0QRCzxb
	Tw2rDKwqEUgolnygMbthuFDVQwoPNJWu2Gd1VyqB8dbtJQ73j1jIhV3AM+H5MarfIWzUyCzSQOB
	ihb3p++cPT6kJbPTTEpJG1wpnCooD1gDJ/DPp9fh7l//YeooYXPGqxcHz19JviPnWRGTS7CyOgW
	OEd4VTbtA5/t
X-Google-Smtp-Source: AGHT+IEwv0VyjAm4W5GVia+h3ePgqZKBA2uGYHmtL1cCJc3oMouoPzWm0EfrwgcDF0JyE12B+fiN8w==
X-Received: by 2002:a05:6a00:1383:b0:730:7d3f:8c6c with SMTP id d2e1a72fcca58-7307d3f929emr15399209b3a.22.1739242906429;
        Mon, 10 Feb 2025 19:01:46 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730949924cdsm2179863b3a.95.2025.02.10.19.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 19:01:45 -0800 (PST)
Message-ID: <37033e12b0aad918a1787d2e0ef4a8b5e67c7413.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: introduce veristat test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 10 Feb 2025 19:01:41 -0800
In-Reply-To: <20250210135129.719119-3-mykyta.yatsenko5@gmail.com>
References: <20250210135129.719119-1-mykyta.yatsenko5@gmail.com>
	 <20250210135129.719119-3-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-10 at 13:51 +0000, Mykyta Yatsenko wrote:

[...]

> +void test_veristat_set_global_vars_succeeds(void)
> +{

test_progs based tests are usually organized as a hierarchy of tests and su=
b-tests.
E.g. take a look at tools/testing/selftests/bpf/prog_tests/ksyms_btf.c:
- it defines an entry point test_ksyms_btf;
- and a bunch of sub-tests declared as static void functions,
  called from entry point;
- test__start_subtest() function is used to check if sub-test has to
  be executed.

> +	char command[512];
> +	struct fixture *fix =3D init_fixture();
> +
> +	snprintf(command, sizeof(command),
> +		 "./veristat set_global_vars.bpf.o"\
> +		 " -G \"var_s64 =3D 0xf000000000000001\" "\
> +		 " -G \"var_u64 =3D 0xfedcba9876543210\" "\
> +		 " -G \"var_s32 =3D -0x80000000\" "\
> +		 " -G \"var_u32 =3D 0x76543210\" "\
> +		 " -G \"var_s16 =3D -32768\" "\
> +		 " -G \"var_u16 =3D 60652\" "\
> +		 " -G \"var_s8 =3D -128\" "\
> +		 " -G \"var_u8 =3D 255\" "\
> +		 " -G \"var_ea =3D EA2\" "\
> +		 " -G \"var_eb =3D EB2\" "\
> +		 " -G \"var_ec =3D EC2\" "\
> +		 " -G \"var_b =3D 1\" "\
> +		 "-vl2 > %s", fix->tmpfile);
> +	if (!ASSERT_EQ(0, system(command), "command"))
> +		goto out;

Nit: there is SYS macro in test_progs.h, it combines
     snprintf/system/ASSERT_OK/goto.

> +
> +	read(fix->fd, fix->output, fix->sz);

Nit: check error for read() call (same read()/write() in tests below).

> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D0xf000000000000001 "),
> +		   "var_s64 =3D 0xf000000000000001");

Nit: I'd do these checks as below:

#define __CHECK_STR(str, name) \
	if (!ASSERT_HAS_SUBSTR(fix->output, (str), (str))) goto out
        __CHECK_STR("_w=3D0xf000000000000001 ");
        ...
#undef __CHECK_STR

     this way fix->output would be printed if sub-string is not found.
     For other tests I suggest using ASSERT_HAS_SUBSTR as well,
     as it prints the string where sub-string was looked for.

> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D0xfedcba9876543210 "),
> +		   "var_u64 =3D 0xfedcba9876543210");
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D0x80000000 "), "var_s32 =3D =
-0x80000000");
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D0x76543210 "), "var_u32 =3D =
0x76543210");
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D0x8000 "), "var_s16 =3D -327=
68");
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D0xecec "), "var_u16 =3D 6065=
2");
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D128 "), "var_s8 =3D -128");
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D255 "), "var_u8 =3D 255");
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D11 "), "var_ea =3D EA2");
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D12 "), "var_eb =3D EB2");
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D13 "), "var_ec =3D EC2");
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D1 "), "var_b =3D 1");
> +
> +out:
> +	teardown_fixture(fix);
> +}
> +
> +void test_veristat_set_global_vars_from_file_succeeds(void)
> +{
> +	struct fixture *fix =3D init_fixture();
> +	char command[512];
> +	char input_file[80];
> +	const char *vars =3D "var_s16 =3D -32768\nvar_u16 =3D 60652";
> +	int fd;
> +
> +	snprintf(input_file, sizeof(input_file), "/tmp/veristat_input.XXXXXX");
> +	fd =3D mkstemp(input_file);
> +	if (!ASSERT_GT(fd, 0, "valid fd"))

Nit: ASSERT_GE.

> +		goto out;
> +
> +	write(fd, vars, strlen(vars));
> +	snprintf(command, sizeof(command),
> +		 "./veristat set_global_vars.bpf.o -G \"@%s\" -vl2 > %s",
> +		 input_file, fix->tmpfile);
> +
> +	ASSERT_EQ(0, system(command), "command");
> +	read(fix->fd, fix->output, fix->sz);
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D0x8000 "), "var_s16 =3D -327=
68");
> +	ASSERT_NEQ(NULL, strstr(fix->output, "_w=3D0xecec "), "var_u16 =3D 6065=
2");
> +
> +out:
> +	close(fd);
> +	remove(input_file);
> +	teardown_fixture(fix);
> +}

[...]



