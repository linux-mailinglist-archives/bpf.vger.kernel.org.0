Return-Path: <bpf+bounces-70354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F05CBB8443
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 00:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2593A921F
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 22:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941D426FDB2;
	Fri,  3 Oct 2025 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsRcjlJ3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD819882B
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530289; cv=none; b=hEwAEGBFafcyF4DvXFNo+LvVHpiqvXkdRNYhCT/Qrhm4XqB0S+/+sxj/0w341HNQWVrTLj9ABXDKKZDQMzMVJoRp4VFsHPdQn+DGA/K5oJrW5rVkanqu6KUhmRFdYH8u/vHE/hemrTGdvYUgsr/BlZL1zZuAtTgB/dfvP+T1d/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530289; c=relaxed/simple;
	bh=kcQAgoo83Bexpr/8zfx7c396lT6bG9YcngspcPTW7v4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LAvn33p1Hk4Ro8Ag4Eyajdjv0q3SEZzsC6awbdKbCnHJ4kD/lrdoYI/pxBTVUux+VRKDTpqIPjQJi4sw3Vo/PCNZya3R2ODeGRiDrqrlwrydFWGaSJcq4DowK9+QmKqcASeWG8G3AYKayjJyXzO9qztlZn/dJ8p/yUp3MzWEYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsRcjlJ3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78af743c232so2448384b3a.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759530287; x=1760135087; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vBmP+DfX8oR08gPWspQnQq2fDep3HKwLUS/lkABT/30=;
        b=WsRcjlJ3AvEePNfiWCl/zwelvCyhGvMw+kWygqHzcO023AHOOJFa8fHY89mOQZYOdM
         o9dMX8Q7jWYYivLYjrH44CSwF0qjPHlP8awuvdXm+7KP2Ksobd80Io7EXteDVFtxOHrU
         IMmh/XzX/M0m0GVYj7i3bBcyqpCfBeVvHRT7o1h7AQ+Eej8NgU6C4a4qMho5Zmmq1h/d
         Ahv9wN6O8xCCJE3gKH4wwfbWcsua0P4Py8XT5jIo0ZMtBv7zwKrLqZo/Oar3xF+BT6qx
         P/SOqPEhmKIOG0bdRDnUfl3uKYj9TCZhoTy54qUiMgKtxIm5idoErzb/W9v41VM259Bn
         EKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759530287; x=1760135087;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBmP+DfX8oR08gPWspQnQq2fDep3HKwLUS/lkABT/30=;
        b=VTGZS4CBRasW+pIjJI/HmtZfHhM5r9J+BBUOc6Y5+vq1QXi4CL9PsfAdu1qUESuTwy
         uRDVjBldV88HeMud9qkioYclTnMjFnmEOzN7tQNlb3fft9qTPHJTZWWDxb9wXwIwaRfB
         uPfrXJdjEwnuirWzXBcJVr3vxS+3dlPlIPiff4bM9RdUHC+A744n/jnflmYICEgBazw/
         J8rE7CTqzdDLkES9VqDMmiK5rNjumk06ny/CzXl7C3lz9GLhx+ajKiZkN8RRgcJKHv97
         MDxu8p3YYJwx3Ay4oMRYbqCbb+6AGZ/tW7gefROnNFjzIZ/n/0xWaqNQVedVmW8hOSlw
         9fsg==
X-Forwarded-Encrypted: i=1; AJvYcCU3DIJGeOF3rxBYbQYo333gzxNBv9381R5pSZA0ohny4++pbNG3UVE7smkP+nWTKaWY7ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjy5GpMfLVcwuIscC5N/Jgw0FgSieNCQ2fKetJ8KUKTNxvEogz
	NOqYNCJoLT3rn+rBmCKZC5fAhVMkd5O1C4p15BuUXhC8YkrMehXegpys
X-Gm-Gg: ASbGncvwn6tV8YZJbeZscmWhXWM3j3TOhp6Vdz0GuuwptOD1zg9i8nZmzp2vXi+6gwX
	4vnvkSkb9V1OSZ0u3c51lGX9UW7v+7KlsPdKZxWggGOYLOyoxZfHdJox53RRbT7g9UKQdRLOa7l
	op/fKwfHFwlQIOI7BQK11zplxQuuRNvOhP/O2nzj1MMYPybfy6PUwfFhwb+XIsD5HXyHkcgycf+
	zERsSQ+9XLzrpDhygm97FX3xlU7cUmlSCr7nYTDR+Veo8+lbKemV5T+EEZubZw7A1eL5VT8mK7o
	eLJjhZeHkT+2NLAsWOXhEV4dUqJFIWrsQgLx779Q73HHHGsHhZd29sZKqMLoGEIMpR8qB4sVfB2
	ZChsZ6QoWIUaQTOT9dsPDjfELoTPyFNx4SOdypZVfmWPA3a5fUsMeAJ1FynTv3pCnCvE9HkeS
X-Google-Smtp-Source: AGHT+IH/9/+/xFoCy/ohh8p5dgoo7+Z4PqEAd2RR3ByUPjMzP2j7KkHZbfXXGWGMUBx8f4NfYIJeoQ==
X-Received: by 2002:a05:6a20:2444:b0:2f6:6d95:69db with SMTP id adf61e73a8af0-32b621282d9mr6535150637.57.1759530287009;
        Fri, 03 Oct 2025 15:24:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099adce33sm5468478a12.1.2025.10.03.15.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 15:24:46 -0700 (PDT)
Message-ID: <47e2812f633ad990f6d1a38234d99bc1e6c3bd87.camel@gmail.com>
Subject: Re: [RFC PATCH v1 10/10] selftests/bpf: add file dynptr tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 03 Oct 2025 15:24:45 -0700
In-Reply-To: <20251003160416.585080-11-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
	 <20251003160416.585080-11-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/test=
ing/selftests/bpf/progs/file_reader.c
> new file mode 100644
> index 000000000000..9dd9a68f3563
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/file_reader.c

Do we really need an example of ELF parsing in selftests?
Maybe just stick to smaller test cases, exercising specific behaviors?

[...]

> diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools=
/testing/selftests/bpf/progs/file_reader_fail.c
> new file mode 100644
> index 000000000000..449c4f9a1c74
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c

[...]

> +static long process_vma_unreleased_ref(struct task_struct *task, struct =
vm_area_struct *vma,
> +				       void *data)
> +{
> +	struct bpf_dynptr dynptr;
> +
> +	if (!vma->vm_file)
> +		return 1;
> +
> +	err =3D bpf_dynptr_from_file(vma->vm_file, 0, &dynptr);
> +	return err ? 1 : 0;
> +}
> +
> +SEC("fentry.s/" SYS_PREFIX "sys_nanosleep")
> +__failure __msg("Unreleased reference id=3D") int on_nanosleep_unrelease=
d_ref(void *ctx)
> +{
> +	struct task_struct *task =3D bpf_get_current_task_btf();
> +
> +	bpf_find_vma(task, (unsigned long)user_ptr, process_vma_unreleased_ref,=
 NULL, 0);

Why testing this via callback?

> +	return 0;
> +}

[...]

