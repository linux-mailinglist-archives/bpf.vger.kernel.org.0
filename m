Return-Path: <bpf+bounces-39763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3BB9770DC
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 20:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C5A1F230AB
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 18:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AFE1BF80D;
	Thu, 12 Sep 2024 18:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6pgTuVf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687491BE22C
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726166491; cv=none; b=gapCiZQ9cHsQ4aitCZLlxrBRavFBP0Ff2z/M5K+MBHY8B8gyj6WG5kjE7gbDssR7CBWcid/gCiOZ1MiPe/GE4a8PMAvaPwU+cSFEECnJewXVJmMIcZYmEseay3LN7OZzGxYs5waabpcuNxf8LF4uYUGeICcSJlgrl5aeg+tqcVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726166491; c=relaxed/simple;
	bh=CygUe73rmFUtnSKQO6tk2IS+p4237tiiyD0dfiKmZLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Px40vlG+M11LDQi2gIvJTsp1alWBn1XjQ2wtG6MiObWt9+a0HepF8BU9qC7eiw0k97eFu+O+ThqRCU7FsPM0QIBbGFr5lmMs6N5kcECn0Z593mmWGNh7bztDWyKx1v5/2EL5lLmyeYsNu5ryJpk6ElJUnlWxeKQIRRZ3qzqzOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6pgTuVf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-205909af9b5so768105ad.3
        for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726166490; x=1726771290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJYklzg0X1AJ53ssRhIYWKZYOG1LlMAz/LM9lbrwnws=;
        b=M6pgTuVfFSQTqcL8ULBPSxRjSl1e++UzvIlhICDo2041Tl2El1w9ZXfpBiGxc83Qqu
         5lXQosinU9R+cV6zr8C8a5mVh+Ltb/rJj1KYhnt8TjwY8utXuSNpEuN73JCg/1bXOk6G
         ydM+IGEgf0/iUNR/iuJcts8mF5JV8dK5eKIjMsGSFoqkSEAh0Hxq8fvAY+mBvjS74RZb
         HjaJiN3OgEpwSUFJ69KU1dvsns2FmgSnhY6oWmPfcbj5QOYBhKHGZD/ejPTOpiuaG/si
         3SSNC5Zr1y+hOiDcAy3IeBuZufmk0jLDDiG6e5YLACZ97Ba1KX6C6qMobm4Jjnvyw9Tn
         aL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726166490; x=1726771290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJYklzg0X1AJ53ssRhIYWKZYOG1LlMAz/LM9lbrwnws=;
        b=kRyziWzmoZ8W0jUCZCLn/u853x5xOXYBCHNXkWpewX1cxDpc4CS4Fcs3EPWQHKVD8p
         lAfg8P55J+w9e5tBNgGHx2j+Z/T3HYoitL8R4P3n3dapB1Qr41tP3T9txexg9S9mwaPc
         uAS3OVw+YLXjX1MvGagLBuq0XiuYRXVHfWMI4tk0wqUV5wR5P3JK/9G0du4jneYdQFi2
         9/ty2Bqe1AXv0IdvvSK8G+Rg+uUytSR+/wSYoXRbFFMMTDrsYPP3Pr3NyTaqZW9RB70I
         uupL3V7wiodGBBO2/zaCFtvVdw4bsNyBD9DG2a1sEbfpITqQV75BY9n0dXkYcGcD+L0e
         3wnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsJo1rsysSCCi2rPabWpIKniPhTqkrUZoKsTgLYVKJdE2XxZbFGjY6E66TrfyxU/efG5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQvDbq8qIwEyj3ipjg2ohJYq01d1JumIS/TTqzAxu9Ejuqmne
	1797rutFgrtYbXrQTxN8mO6Syckq0e4PGWlrxl+RWt994IeOZINABly+o91U49Z2VUyhulLwDqr
	rKDOLZI+1YjgcxjR2mZE/2I7a0I8=
X-Google-Smtp-Source: AGHT+IEgnNsneuYDXEG7/tpn8Dij4t+jv/SMt/5sr8yaIA2xN67CRva8Q+yUCslxBnp/UHVtsFkV6LQpLejOZbCLRgY=
X-Received: by 2002:a17:90b:1c06:b0:2c9:1012:b323 with SMTP id
 98e67ed59e1d1-2dbb9f3c96amr35865a91.27.1726166489669; Thu, 12 Sep 2024
 11:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172615368656.133222.2336770908714920670.stgit@devnote2> <0170cd7d95df0583770c385c1e11bd27dfacf618b71b6e723f0952efc0ce9040@mail.kernel.org>
In-Reply-To: <0170cd7d95df0583770c385c1e11bd27dfacf618b71b6e723f0952efc0ce9040@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 11:41:17 -0700
Message-ID: <CAEf4BzZgAkSkMd6Vk3m1D-0AVqXp06PaBPr+2L7Dd3WRgJ8JvA@mail.gmail.com>
Subject: Re: [PATCH v14 00/19] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: mhiramat@kernel.org
Cc: kernel-ci@meta.com, bot+bpf-ci@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ BPF ML

On Thu, Sep 12, 2024 at 8:35=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> Dear patch submitter,
>
> CI has tested the following submission:
> Status:     FAILURE
> Name:       [v14,00/19] tracing: fprobe: function_graph: Multi-function g=
raph and fprobe on fgraph
> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=
=3D889822&state=3D*
> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/1083379298=
4
>
> Failed jobs:
> test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/run=
s/10833792984/job/30061791397
> test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/ac=
tions/runs/10833792984/job/30061791836
> test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/=
10833792984/job/30061757062
> test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/acti=
ons/runs/10833792984/job/30061757809
>
> First test_progs failure (test_progs-aarch64-gcc):
> #132 kprobe_multi_testmod_test
> serial_test_kprobe_multi_testmod_test:PASS:load_kallsyms_local 0 nsec
> #132/1 kprobe_multi_testmod_test/testmod_attach_api_syms
> test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> trigger_module_test_read:PASS:testmod_file_open 0 nsec
> test_testmod_attach_api:PASS:trigger_read 0 nsec
> kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe_tes=
t1_result: actual 0 !=3D expected 1
> kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe_tes=
t2_result: actual 0 !=3D expected 1
> kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe_tes=
t3_result: actual 0 !=3D expected 1
> kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kretpro=
be_test1_result: actual 0 !=3D expected 1
> kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kretpro=
be_test2_result: actual 0 !=3D expected 1
> kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretpro=
be_test3_result: actual 0 !=3D expected 1
> #132/2 kprobe_multi_testmod_test/testmod_attach_api_addrs
> test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> trigger_module_test_read:PASS:testmod_file_open 0 nsec
> test_testmod_attach_api:PASS:trigger_read 0 nsec
> kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe_tes=
t1_result: actual 0 !=3D expected 1
> kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe_tes=
t2_result: actual 0 !=3D expected 1
> kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe_tes=
t3_result: actual 0 !=3D expected 1
> kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kretpro=
be_test1_result: actual 0 !=3D expected 1
> kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kretpro=
be_test2_result: actual 0 !=3D expected 1
> kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretpro=
be_test3_result: actual 0 !=3D expected 1
>

Seems like this selftest is still broken. Please let me know if you
need help with building and running BPF selftests to reproduce this
locally.

>
> Please note: this email is coming from an unmonitored mailbox. If you hav=
e
> questions or feedback, please reach out to the Meta Kernel CI team at
> kernel-ci@meta.com.

