Return-Path: <bpf+bounces-71064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB7EBE0FA3
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 00:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05337486CE6
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7B331576C;
	Wed, 15 Oct 2025 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLM3vLO4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421CC314D0B
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760568611; cv=none; b=GaIEOGwe+hEEC/qTmGjeTDrQMil1YGzhgWwbkC56uDBl2JnthYy7uDgklj0ddJj1+4nvvv1XUvOYXtepduxqv79vAc4NXLrxzqBrbnUeJXfRWVEsfJKPil+HoZvariXPZpHDLqAeqrGSgj/GEmDLA/AvcdNdhCvbLko9KN3e0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760568611; c=relaxed/simple;
	bh=r+4iVqL8o0TCTQJ5JACcQB0kEQ2IKZBMXe2rafWYeNA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mVDNE0bxBvogXjhRuhMKcFW0/90z7T5jBYKaniJwy7ZL545b1igm6RCrqO25xPfpaSY6h1TJF+6ghqukSOp5LxTVbUTzpi9xyTt/D+2B7NOGG6GM2xM+HYdehtQOUxSB3qVXtTgh8XsOqcp1GfqJ7UCkZiiGjC3OhnXzgeNSSec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLM3vLO4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b57bffc0248so48849a12.0
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 15:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760568609; x=1761173409; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hQMHThmbeKQQTpiq8uQ7rF5heA1Xb3MxkqPmHdTzHeY=;
        b=PLM3vLO4M57cu0i7GbvExwAfzHi8FX/2sjzOzJB3M3wR/Zh3jZ6PFTmhCWVxE8OuY1
         v7POqo5kwf08Zx5iF7Qx4aAsjHlIC6dvLU2RZyNvSMgKCn8RcAC8XG1An+JCsgI8mu+a
         xSnq88U3yaZo8luf9+SFUBaIGznD+DELh8MR9I32qW4Z3XdE/YJo6MHOK/sk0Vb9o/Jm
         Psv8h0DcJ5sQPCjnXgtvNhnwJ9/JdcCE3TdVxFVFxhZhowoWGohi53SNfOKZG55xBYt1
         HS+ZhnxPR8h5x+lp3W9FszbkaL/hvvu9Kjhq8lIvgDts/BllNKbAy0/EaTp/7K2uKlYx
         dBEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760568609; x=1761173409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hQMHThmbeKQQTpiq8uQ7rF5heA1Xb3MxkqPmHdTzHeY=;
        b=DgZzNlCzZSlbcXbzwQACqawL6n1zzJRJ1/jghJbL+Clr5HMNCDfRm4L13e4h7BmIYs
         9NHD92GRGh2Ijs5DqQx2uI2Zev6utWooxrCQXfJb/+YxgmqMGAOppXlM3yhj9cJPuq/r
         o1lGuJCdC/apWq6KU+9LVSNu4ZN+RQijgV9WhtgAzwsqxRWINFM88wxgkhdTxreHplkM
         ImLFuVxYP7KAYJ5xAjNkuwX2858QJ/oBGHjMQDD6vk/O9wsNJJVxrKBHlNVBF9xbnNUR
         ql5bmt2nc1M6BEsjHtZ/XlXouuV9xYHGy5MFLa0Qncq6GwsqHy6urc4yrlzL5Qi3+7Iw
         zMVg==
X-Forwarded-Encrypted: i=1; AJvYcCVMguLP6JEkLHlT5MLhi7zOTWAUAygZpIG+/4h6IAXnqY3/Gq8HevEon69VOnsu+IRGH5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAOVYnM4upF3ipuFjq6euabWqsIEierYOQ/tdfcT12Et4XchQ
	4/LdqXGG0i21RYnne+HvnH3x7/Jadq5mrm8y2kolzcsCTAAj+KrLPb5/
X-Gm-Gg: ASbGnct5V6Z1FKRhfB5E0y3FdPL4gkzKOO9XVssz1hfL3sq1ivNcn+I8gAYjhhI1Wk5
	B6XyIqQiIDBDfryMgfy842HrnGLXfdlTTF6n25h/O165qYWHWQlL5S5PFuc6sq/jeoLvIqMwJpw
	asmyANufSJlkianG5dK8ThJ009ZOPkz+04vvAN/iS6v915qjEd6KsY4hrHO1l+gt0VX/raT/5IH
	p23cznrYKNwuwsxHvyBNITCnK24YwNpZaTXu1iUEwpBfzo5YRzxyeZvtzD20Rwk5/sptx2KNJwY
	iRekF0PEjL9Ec54jgL1hA8MNWJS0r8+JCwsvdD7lQ3aKlksPU9FOgqg65IVITqX51VnLoG9+lMY
	QeJYNf9XKnhL4swIociaJjyobQNbcX2RGiKJtPqRpL/D5agtb4IZB3x5Vu82I6VZyQxdptVUOoU
	jNUM8PAUCV
X-Google-Smtp-Source: AGHT+IFW7ZpPSv48N7G0Ue/nqUuAzDWH4Sp1QNmYCJdaBnhYeAAkIzw976Plt9oQDRgutKgUtl3z/Q==
X-Received: by 2002:a17:902:f64e:b0:28e:b14e:d45 with SMTP id d9443c01a7336-29091bedfa3mr17528265ad.30.1760568609440;
        Wed, 15 Oct 2025 15:50:09 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bae2a4df8sm86885a91.5.2025.10.15.15.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:50:09 -0700 (PDT)
Message-ID: <9228f1039879afba155be1237526537411aa4706.camel@gmail.com>
Subject: Re: [RFC PATCH v2 11/11] selftests/bpf: add file dynptr tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 15 Oct 2025 15:50:06 -0700
In-Reply-To: <20251015161155.120148-12-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
	 <20251015161155.120148-12-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 17:11 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Introducing selftests for validating file-backed dynptr works as
> expected.
>  * validate implementation supports dynptr slice and read operations
>  * validate destructors should be paired with initializers
>  * validate sleepable progs can page in.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

I think a few additional test cases are needed:
- negative verification test cases, e.g. when file dynptr is created
  but not discarded and vice versa;
- a test case for bpf_dynptr_adjust();
- a test case for bpf_dynptr_read() starting at non-zero offset.

[...]

> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c

[...]

> +static int initialize_file_contents(void)
> +{
> +	int fd, page_sz =3D sysconf(_SC_PAGESIZE);
> +	ssize_t n =3D 0, cur, off;
> +	void *addr;
> +
> +	fd =3D open("/proc/self/exe", O_RDONLY);
> +	if (!ASSERT_GT(fd, 0, "Open /proc/self/exe\n"))

Nit: ASSERT_OK_FD, 0 is a valid fd number.

> +		return 1;
> +
> +	do {
> +		cur =3D read(fd, file_contents + n, sizeof(file_contents) - n);
> +		if (!ASSERT_GT(cur, 0, "read success"))
> +			break;
> +		n +=3D cur;
> +	} while (n < sizeof(file_contents));
> +
> +	close(fd);
> +
> +	if (!ASSERT_EQ(n, sizeof(file_contents), "Read /proc/self/exe\n"))
> +		return 1;
> +
> +	addr =3D get_executable_base_addr();
> +	if (!ASSERT_NEQ(addr, NULL, "get executable address"))
> +		return 1;
> +
> +	/* page-align base file address */
> +	addr =3D (void *)((unsigned long)addr & ~(page_sz - 1));
> +
> +	for (off =3D 0; off < sizeof(file_contents); off +=3D page_sz) {
> +		if (!ASSERT_OK(madvise(addr + off, page_sz, MADV_PAGEOUT),
> +			       "madvise pageout"))
> +			return errno;
> +	}
> +
> +	return 0;
> +}
> +
> +static void run_test(const char *prog_name)
> +{
> +	struct file_reader *skel;
> +	struct bpf_program *prog;
> +	int err;
> +	char data[256];
> +	LIBBPF_OPTS(bpf_test_run_opts, opts, .data_in =3D &data, .repeat =3D 1,
> +		    .data_size_in =3D sizeof(data));
> +
> +	err =3D initialize_file_contents();
> +	if (!ASSERT_OK(err, "initialize file contents"))
> +		return;
> +
> +	skel =3D file_reader__open();
> +	if (!ASSERT_OK_PTR(skel, "file_reader__open"))
> +		return;
> +
> +	bpf_object__for_each_program(prog, skel->obj) {
> +		if (strcmp(bpf_program__name(prog), prog_name) =3D=3D 0)
> +			bpf_program__set_autoload(prog, true);
> +		else
> +			bpf_program__set_autoload(prog, false);

Nit: bpf_program__set_autoload(prog, strcmp(bpf_program__name(prog), prog_n=
ame) =3D=3D 0);

> +	}
> +
> +	skel->bss->user_buf =3D file_contents;
> +	skel->rodata->user_buf_sz =3D sizeof(file_contents);
> +	skel->bss->pid =3D getpid();
> +	skel->bss->user_ptr =3D (char *)user_ptr;
> +
> +	err =3D file_reader__load(skel);
> +	if (!ASSERT_OK(err, "file_reader__load"))
> +		goto cleanup;
> +
> +	err =3D file_reader__attach(skel);
> +	if (!ASSERT_OK(err, "file_reader__attach"))
> +		goto cleanup;
> +
> +	getpid();
> +
> +	ASSERT_EQ(skel->bss->err, 0, "err");

Nit: I'd check for some more unique value, e.g. 42, something not null.

> +cleanup:
> +	file_reader__destroy(skel);
> +}
> +
> +void test_file_reader(void)
> +{
> +	if (test__start_subtest("on_getpid_expect_fault"))
> +		run_test("on_getpid_expect_fault");
> +
> +	if (test__start_subtest("on_getpid_validate_file_read"))
> +		run_test("on_getpid_validate_file_read");
> +}

[...]

