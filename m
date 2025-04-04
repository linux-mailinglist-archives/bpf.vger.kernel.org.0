Return-Path: <bpf+bounces-55337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CC5A7C108
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 17:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001FD3B8A33
	for <lists+bpf@lfdr.de>; Fri,  4 Apr 2025 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7804D1FC0E9;
	Fri,  4 Apr 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm4oOp14"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849AB1FBEAC
	for <bpf@vger.kernel.org>; Fri,  4 Apr 2025 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782149; cv=none; b=Le9OTz1vzjjUXbAdFIFZlzTCdjTIwk4I/AzcVAMWnZZ2+toRXYzWpqb0fxSFQY3ZiQpDg1BP6BzHodmhTbaheYXuw4C37R4izVgRQ6jDLIRtA4CNPxVIWzfMJUyXDjQsemzjIhcekmmPKOvG9pFcHXMTHdKvHE4p5/je7i8UcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782149; c=relaxed/simple;
	bh=o3zb0n4Mz41J8UwfAIEf/5XnZJR7H8rYfiuvCEx5pU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKkskugVQ9fvXqlE8gHBE0csun3CnEQ/aKL7IyocGnv2/WsjfDAfr4823HL56uyhUjGFSe9hI1ygD4vLtS1EuA/QM9uvbHmY3IELgf0Ukks6XbPAQFu7668kRhLEr97pzjb5RubF8YWRLwM1C20K+C4EpADxN1mdU87eY+f0j9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sm4oOp14; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736b350a22cso1923764b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Apr 2025 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743782147; x=1744386947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg6RdtZyBbAjsXHn5gt+wLSokRCSv0T2tNhZ064qEHM=;
        b=Sm4oOp14snlxZRs3gaBjzLEoYuZNimGCDkH8L5yTJ/POy0WNQbwftQn4fYx8KvzJ3V
         3pBv1Wpb1+SeWPUhep9+rs2OU/XXCUY3bpdZBjwAT22wEoy7qtj4PVquWqRv8zWCaUQ/
         d1jpXlWK7zx/fy1RtnKVp10jL0qB+ABY4z1qJecZM297KbN2UR9YOx6eXLNC19yl7Yc9
         GE6HT8Qs3X+biVUCFBHKS/1kInDNhe363MQ7stvbnxeJzmolw92PMs5UcZCFG9KA1hDR
         87l8dnrbK5ZTEbiSA0tkfCugd6iiRtR+qONs9JJaTJSI1EI/efKWyffkj2mjakhhJjvV
         +ZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743782147; x=1744386947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg6RdtZyBbAjsXHn5gt+wLSokRCSv0T2tNhZ064qEHM=;
        b=SSEhRXrnn2ckp+gIPZwMzHmwWT7iHTVX0QZv+wpELgAVdJ5V7TjB3q+Am/opDxYZnS
         QMp71rMRc4OHsUiciDj1XPQPUDCxLe50Ag0jmHb1hOvs5kLreJRzcFX5YUkpMZq0wHvS
         Hc65ksxvigTBMfyZU96F+dyMn6fkPlmXF6nwqJr0hofvfUL/upgsXoZQLYEkanjaebqI
         PY0Lji4ECNChr3Yg+KNKyVBtFv6npqpbseyT37lQRAAd+vHUXA4HG2sByhrjotmcTBSe
         86dyOqmgshvOfG6cI6E7O/OavvAUVEFUPeRkyGAcl7nQ+bbOmrvC3tYYpl0d3wCWkab0
         I33g==
X-Forwarded-Encrypted: i=1; AJvYcCXa2X5jPXOyZYjYuP9XsY+7Vqp32lhMY4foRlO+LqvwrsxhCv+s1081yvOQejXxlUfqfa8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv8JRMN3CafGu0vISN1UArK4/pa3jEjkN18LWuStlAlHxZLDAm
	SnZySCdRPYBzPQiQUPzFUIsTJk1EAm0kcHRa+LWzVsKVr4DrUNm6fhmbhaJW8CxukPwHsboCwQn
	iffUhjykNnWS/adVZVegyVIoqhRw=
X-Gm-Gg: ASbGncvr940Aqep6XBahdbc99ZdJPdCw06DOlwRKaXieCug6vJfqe6C9byaSA6Clvd4
	WEP1GVyudDZi/s88L0Cn1FZRULq2SHCH+tV0xAWXSMtSAKsr9trGW689cjDxldtjd4WdHgqxbi1
	wLc3pshM08Az+8t9iVld/F/eHfsW+g6AXzrgq1OWqmdw==
X-Google-Smtp-Source: AGHT+IE6SSiBIDsCq/Yw5jPql23QyoxqxKFUeGbyOWEjBiIQomvWo9S5rXTc35vrzP0rLGyU6JriSeeLrnKXPBN6VhM=
X-Received: by 2002:a05:6a00:114f:b0:730:4c55:4fdf with SMTP id
 d2e1a72fcca58-739e4921f61mr5868950b3a.7.1743782146597; Fri, 04 Apr 2025
 08:55:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403220841.66654-1-memxor@gmail.com> <e7ab8fdc788c43a552334e7322cf3ccf68c370372ce0291d6c5b762292e98333@mail.kernel.org>
In-Reply-To: <e7ab8fdc788c43a552334e7322cf3ccf68c370372ce0291d6c5b762292e98333@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 4 Apr 2025 08:55:32 -0700
X-Gm-Features: AQ5f1JqWHNpEStASftqSx_V8_iERoQyKFa1c-s-YUfHulgyrISQGFBdKnSQcji4
Message-ID: <CAEf4Bza=JEpWfnDHM0U59DMhFYrGs4MV3GJv7PrOdo92rR0XtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Make res_spin_lock test less verbose
To: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>
Cc: memxor@gmail.com, kernel-ci@meta.com, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ bpf

On Thu, Apr 3, 2025 at 4:31=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> Dear patch submitter,
>
> CI has tested the following submission:
> Status:     FAILURE
> Name:       [bpf-next,v1] selftests/bpf: Make res_spin_lock test less ver=
bose
> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=
=3D949804&state=3D*
> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/1425408754=
1
>
> Failed jobs:
> test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/run=
s/14254087541/job/39953770223
> test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/ac=
tions/runs/14254087541/job/39953770235
>
> First test_progs failure (test_progs-aarch64-gcc):
> #345 res_spin_lock_success
> test_res_spin_lock_success:PASS:res_spin_lock__open_and_load 0 nsec
> test_res_spin_lock_success:PASS:error 0 nsec
> test_res_spin_lock_success:PASS:retval 0 nsec
> test_res_spin_lock_success:PASS:error 0 nsec
> test_res_spin_lock_success:PASS:retval 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
> test_res_spin_lock_success:PASS:pthread_create 0 nsec
>

This one is strange, according to the log everything is successful,
but test_progs returned with an error. So some uninitialized variable
or something? Can you please check, Kumar?

>
> Please note: this email is coming from an unmonitored mailbox. If you hav=
e
> questions or feedback, please reach out to the Meta Kernel CI team at
> kernel-ci@meta.com.

