Return-Path: <bpf+bounces-74101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C19C1C4940B
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 21:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981B41885992
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 20:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479D92EDD6B;
	Mon, 10 Nov 2025 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUK0FHXx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579B289E13
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806765; cv=none; b=UGah+V6368vfRTbeekhVd00yQc1IXyoJdk4tahgT9o0sbh/G88Ekja10GA0/pNjellgVzMUFBL0YqidMzDHDlMIlZquiYaJAwhIMloMdK9HpHJt4l2diW9xs/wYVqn9x+jaLmFrZrDiq7V5PMJbhf88zf3fmh1TvRkbzc0lYSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806765; c=relaxed/simple;
	bh=0oa65yx9pqeWLf0VUxVyKL6ji/Me8CrOdriquR0p7Vk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q7Jddsf3x5H64McJkWBI+cGpqV5B8AZRe5o5dFyzqKS9tIgpyl605OPYBPdOF+7/Axv+U99tULkg4tD0SagNLOqaQvm0EXHEWAf2pX1JB0qJNQ1QgT2QcQ7RvUKjXoFWgFe8l6vI5vjlOyBCkm+kqDcmgR96zuBL8d8SvUPh69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUK0FHXx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b55517e74e3so3041601a12.2
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 12:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762806764; x=1763411564; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8f8qedLqKIrDhVIJnb5C0SfYu2aedAAVIcPsiwLFYIc=;
        b=JUK0FHXx2Q6ejVMmLkjayLc6l9XsAraS74CpV4ZumKEtl3LwV4Hnmkbvf5RjYtCmMV
         dO/fpvPl7JbO/GZgBU0vhE9OBtYdcZ7bYzIDwEti9/5+f2HkU2C9zPQFAx4DmVbAY17g
         yqYJZhFq5k3KuEbEZc7MgDL3DPINEYLs+M5Xsc8s6DDE4JrkMGJTzX8Cz/w9tb9m4s1o
         Nb/DsxDXTdMEOx6MDR6U+KRO7yj/O43Ec6t86j5bnTXogxJQjx2l0+5NiUzNWPNDLbLU
         3cxkiXMvtz+hR3wgr3XSsN5TTq/DtvrEA2KuFQ2DpF16wKS5ub8tmVlM98x991mnf1R3
         Ez6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806764; x=1763411564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8f8qedLqKIrDhVIJnb5C0SfYu2aedAAVIcPsiwLFYIc=;
        b=wt09EDVP9VOibBir1mG38i+BOAHQ3F3NB+aKj852rUkkA5trVdy63z5yf5XAhMgSpc
         u3ZKLvWzYC9vXCEdVJj7s2okyp1EDCCsed/VK9n2g6x0llElV/3ET7Chxb6LppzH5xiW
         6KVk46IgDCH0EhXygBxYAcTd4HACCo8ZI5rFQf7zl35WnFV1NfcnYEmbWFkLw2BS6FcP
         PlA34af+iqoY50vqg44OPkul5dQj++G0IifjNHK0qWQM0c+jgDJQKp+JXSnBrflWv7s/
         HBJ7K1odJRVbkeIQ9X1Ld2hTawwXdCAzzHHVWyBs/zX9z4jtHGmogwpCXYl0cew8/llL
         4dvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpegtbgWTOdG99u9TksQS2yciHoW3fCHhxbfepMclRHo6e3iV9ckJzJ4/gTn5Ur3IfpRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQvgJijPHHu1jlw7dos6Yzo9vULf8OIXUMpC+Q4AhTb1JuExU
	4eZunhAqa80ixcevdGBIh7xJLj7+60wr76xRa/rr2Hm7+3fVZ5YnZcYy
X-Gm-Gg: ASbGncs+fMdPkyEZaxigSG093ua7tV8OaazXPEXZXkp6UxqR6wrMfdkvUpnep8aob+Z
	eDiRg5N9uVGatkQ5Nxx752SrK/8VP1nFYmnU96pthFzipzHAtcLHwaE3GUNjVjc9gaAktpFePTj
	1Iz8DUtE2BCOVH83DA+SIAPlEWmnQAbk7q2MCl+QEh4bFyf9CqaD8OWxY82xBTfSyB5NMOD5dlt
	gi7lvXlW6z1Irh2EAHVQX0sV4VJFIALt5ahMTDozi0BjF3DsZbasg4GtmNiPzbe/2PTO1RglGTJ
	r2cHYg4VfaPyrDOaOj49U7qGhwerzKd0U0aMEBWuPgaDzjeeb6A/naOBZkO9OGGysARu2FRWCZ8
	f+d9jyG9lRVGPbLkMLyF0MNB1mqwA0Dj5O+3g8JWDZdQeGW/QYbmIdqANaXrjOClOX0F1ZGCld+
	nNfiVxj1PtZ9VmKKLE7K4iCX02YONWktEBH+4sTYFb38P8oA==
X-Google-Smtp-Source: AGHT+IEjncU0fg4Dr7mXcBHRFT7Fz0NO5s0/LKzFBwn8OREFaTATkLtHnrLkt7navA+0F61Y8BNZmg==
X-Received: by 2002:a17:902:ea09:b0:295:2276:6704 with SMTP id d9443c01a7336-297e56e1286mr121655635ad.51.1762806763718;
        Mon, 10 Nov 2025 12:32:43 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:5ff:e0da:7503:b2a7? ([2620:10d:c090:500::7:ecb1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c64b47sm155781225ad.46.2025.11.10.12.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 12:32:43 -0800 (PST)
Message-ID: <544bf663633e445c6f1aef45456113ca6df05b3b.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] bpf: test the proper verification of
 tail calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Date: Mon, 10 Nov 2025 12:32:42 -0800
In-Reply-To: <20251110151844.3630052-3-martin.teichmann@xfel.eu>
References: <998304ddd050ef81ce6281ebb88130e836c07fc3.camel@gmail.com>
	 <20251110151844.3630052-3-martin.teichmann@xfel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 16:18 +0100, Martin Teichmann wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/to=
ols/testing/selftests/bpf/progs/verifier_live_stack.c
> index c0e808509268..9cc53eb1a545 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
> @@ -292,3 +292,52 @@ __naked void syzbot_postorder_bug1(void)
>  	"exit;"
>  	::: __clobber_all);
>  }
> +
> +struct {
> +        __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +        __uint(max_entries, 1);
> +        __type(key, __u32);
> +        __type(value, __u32);
> +} map_array SEC(".maps");
> +
> +SEC("socket")
> +__failure __msg("invalid read from stack R2 off=3D-1024 size=3D8")

Please also add `__flag(BPF_F_TEST_STATE_FREQ)` here, so that it is
guaranteed that checkpoint is created at the `call write_tail_call`
instruction.  Otherwise the test case would depend on add_new_state
heuristic in is_state_visited() remaining unchanged.

> +__naked unsigned long caller_stack_write_tail_call(void)
> +{
> +        asm volatile (
> +	"r6 =3D r1;"
> +	"*(u64 *)(r10 - 8) =3D -8;"
> +        "call %[bpf_get_prandom_u32];"
> +        "if r0 !=3D 42 goto 1f;"
> +        "goto 2f;"
> +  "1:"
> +        "*(u64 *)(r10 - 8) =3D -1024;"
> +  "2:"
> +        "r1 =3D r6;"
> +        "r2 =3D r10;"
> +        "r2 +=3D -8;"
> +        "call write_tail_call;"
> +        "r1 =3D *(u64 *)(r10 - 8);"
> +        "r2 =3D r10;"
> +        "r2 +=3D r1;"
> +        "r0 =3D *(u64 *)(r2 + 0);"
> +        "exit;"
> +        :: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +static __used __naked unsigned long write_tail_call(void)
> +{
> +        asm volatile (
> +        "r6 =3D r2;"
> +        "r2 =3D %[map_array] ll;"
> +        "r3 =3D 0;"
> +        "call %[bpf_tail_call];"
> +        "*(u64 *)(r6 + 0) =3D -16;"
> +        "r0 =3D 0;"
> +        "exit;"
> +	:
> +	: __imm(bpf_tail_call),
> +          __imm_addr(map_array)
> +        : __clobber_all);
> +}

[...]

