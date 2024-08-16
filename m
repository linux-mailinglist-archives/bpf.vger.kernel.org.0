Return-Path: <bpf+bounces-37350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5068B953F1B
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 03:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A233E1F246BA
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C12288BD;
	Fri, 16 Aug 2024 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md5K07Hx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40391D69E
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773054; cv=none; b=S61ghlnm0oUPAWnx6QMe0RInkM6oZ1gGmCmpsTISkxaBFsqy5DPPjCAhuzavunpTdJmZtCH42M2t0w17CJ2AG3pT7gqylpSK1mT/duTlhEXEM57UYjZPAigU+IFSNfUhfcFVuKVZRnR8mZOVWML6kaR3Z9KW6n9Ui27HTR/b+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773054; c=relaxed/simple;
	bh=cHLIG61XxiVKKHJjr+3co71KCnBckCnukGyjyAMxwMQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HWdgvqk3oMc8gS7rjV/GlOL9jO71Oyy6IAIft1OYWkaZJ4/iDyY1PtQ7eNGgD6OHM741opUTLs9/JCr0kDJfrjYQ3NeGNhRNn39GmAvE3ZFXqQpXMQNiIE+08ULu2vBGD+eQuW68w0wPpPzZ7moTyWtDWvPPuy4sb/XyShPbSp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md5K07Hx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb53da06a9so1041888a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 18:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723773052; x=1724377852; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=odVP9sBYulAskR9wIl3Lj4a8EeUFt66Adv8qLnwSP9c=;
        b=md5K07HxmLm6rUbsDQ7ToxT0D+9wAgiYYdmZfUfrpMWpkeExBni6UQ64UNn7qUxsxm
         VekXvek5lt0KfSMz8uaC3Z/E2qL6E/gRXa5DZ5VIoMxtWLHXrg3/4eaRrDHVZ4PytR62
         s/JRNewXr4+qAZZBXT6QONv0iHI/kOczR2IgPzwV96yTzA61EEGYYZuyc1UlkDpjoVm/
         ptuahXT/zDqEz8oNB2K2V4wI+RMcj3CwURWbgQ+vf+C1HEpOOBUaylgKsCzxvqB5Ggym
         tYB5bve58uYT1QLIOsBoab4Tevop2gEt1QCNghiTXtISfG7+S7JB63HgJ3FIZB9zAGmZ
         xB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723773052; x=1724377852;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=odVP9sBYulAskR9wIl3Lj4a8EeUFt66Adv8qLnwSP9c=;
        b=tL0zjK0KQ1aoQWICfZeuElEZ4hoUZLPo/dWdXNlxjhZ9Jyom1Ho/QYqF0DOwAmPwGu
         o/YdjNaMBE3pbviSaSXYxF6F1RL2ZAJeJ9K991JbaNHl6EuUlx0dn1eF/mPF3mtDuWmQ
         Nm+3CrWYADi2VsgCA10eWXQakhvvIcNizgJ7O2jBBV00/DBdPQKJJeI02CUC0vYOJzzz
         WFcd7AJrodcJnQzUNL9qNq62dgo4sJlgrfo5HdHpbvuYquB9RKLqYD50E9bTH8fbrgiS
         S0kSsULjuXeACHhE+YYvodb32a1ChPEgOxJ18zYnwm/mnARxlvpuKn94Tyw7tnfMPwkO
         1Cdg==
X-Forwarded-Encrypted: i=1; AJvYcCVXxyjP9FDFeB7x+mabz0JhglVv9YIgkXSooBS0LVZcJOq5Dpar6hTF0nEKSOTWVm8hE3eW3mU2F8z/36yJygxnkEs/
X-Gm-Message-State: AOJu0Ywpd0U2xAW7mqQg1YJQ0Bl4xeZY7TMhh4vcU8+jxqmJfJ8O4Mn9
	JRvreGBBP3MN6u5LTt2BkyZ7nyts+wpblycWaV3gaaKsAt3EWHqu
X-Google-Smtp-Source: AGHT+IG59nRJZt3InlUYqRWZwXfAdO8XrsFzwE9Qfas5szEm7JUaON8aXh7dVEyJjbJ4XEmfvPWleA==
X-Received: by 2002:a17:90a:7448:b0:2c8:4250:66a7 with SMTP id 98e67ed59e1d1-2d3e4539f9fmr1597155a91.1.1723773051730;
        Thu, 15 Aug 2024 18:50:51 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6d16asm541142a91.21.2024.08.15.18.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 18:50:51 -0700 (PDT)
Message-ID: <2e86ab640b6acbe8e21af826ccfeeac6c055bc69.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/6] selftests/test: test gen_prologue and
 gen_epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com, bpf@vger.kernel.org
Date: Thu, 15 Aug 2024 18:50:46 -0700
In-Reply-To: <92f724366153f2fbd7d9e92b6ba6f82408970dd7.camel@gmail.com>
References: <20240813184943.3759630-1-martin.lau@linux.dev>
	 <20240813184943.3759630-4-martin.lau@linux.dev>
	 <b9fc529dbe218419820f1055fed6567e2290201c.camel@gmail.com>
	 <0625a342-887c-4c27-a7a7-9f0eadc31b9d@linux.dev>
	 <92f724366153f2fbd7d9e92b6ba6f82408970dd7.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 17:23 -0700, Eduard Zingerman wrote:

[...]

> > Re: __retval(), the struct_ops progs is triggered by a SEC("syscall") p=
rog.=20
> > Before calling this syscall prog, the st_ops map needs to be attached f=
irst. I=20
> > think the attach part is missing also? or there is a way?
>=20
> I think libbpf handles the attachment automatically, I'll double check an=
d reply.
>=20

In theory, the following addition to the example I've sent already should w=
ork:

    struct st_ops_args;
    int bpf_kfunc_st_ops_test_prologue(struct st_ops_args *args) __ksym;
=20
    SEC("syscall")
    __retval(0)
    int syscall_prologue(void *ctx)
    {
    	struct st_ops_args args =3D { -42 };
    	bpf_kfunc_st_ops_test_prologue(&args);
    	return args.a;
    }

However, the initial value of -42 is not changed, e.g. here is the log:

    $ ./test_progs -vvv -t struct_ops_epilogue/syscall_prologue
    ...
    libbpf: loaded kernel BTF from '/sys/kernel/btf/vmlinux'
    libbpf: extern (func ksym) 'bpf_kfunc_st_ops_test_prologue': resolved t=
o bpf_testmod [104486]
    libbpf: struct_ops init_kern st_ops: type_id:44 kern_type_id:104321 ker=
n_vtype_id:104378
    libbpf: struct_ops init_kern st_ops: func ptr test_prologue is set to p=
rog test_prologue from data(+0) to kern_data(+0)
    libbpf: struct_ops init_kern st_ops: func ptr test_epilogue is set to p=
rog test_epilogue from data(+8) to kern_data(+8)
    libbpf: map 'st_ops': created successfully, fd=3D5
    run_subtest:PASS:unexpected_load_failure 0 nsec
    VERIFIER LOG:
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    ...
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
    do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
    run_subtest:FAIL:837 Unexpected retval: -42 !=3D 0
    #321/3   struct_ops_epilogue/syscall_prologue:FAIL
    #321     struct_ops_epilogue:FAIL

So, something goes awry in bpf_kfunc_st_ops_test_prologue():

    __bpf_kfunc int bpf_kfunc_st_ops_test_prologue(struct st_ops_args *args=
)
    {
    	int ret =3D -1;
   =20
    	mutex_lock(&st_ops_mutex);
    	if (st_ops && st_ops->test_prologue)
    		ret =3D st_ops->test_prologue(args);
    	mutex_unlock(&st_ops_mutex);
   =20
    	return ret;
    }

Either st_ops is null or st_ops->test_prologue is null.
However, the log above shows:

    libbpf: struct_ops init_kern st_ops: type_id:44 kern_type_id:104321 ker=
n_vtype_id:104378
    libbpf: struct_ops init_kern st_ops: func ptr test_prologue is set to p=
rog test_prologue from data(+0) to kern_data(+0)
    libbpf: struct_ops init_kern st_ops: func ptr test_epilogue is set to p=
rog test_epilogue from data(+8) to kern_data(+8)

Here libbpf does autoload for st_ops map and populates it, so st_ops->test_=
prologue should not be null.
Will have some time tomorrow to debug this (or you can give it a shot if yo=
u'd like).


