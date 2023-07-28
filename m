Return-Path: <bpf+bounces-6148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3836E7661B5
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 04:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586441C2176E
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6061C26;
	Fri, 28 Jul 2023 02:18:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485F7C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 02:18:56 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F021BC6
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 19:18:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so2759013e87.2
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 19:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690510733; x=1691115533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iW4JMwFnqCVD+d2+erHxBd4VHkTR+0lG/+d9ZayWYs=;
        b=qVt1yfEv+6Mj5mbl1OklQJCXeEfINzaoxfFtaEwKqQUgT1wMAO7cRLHcToKi70oO1m
         UQ2AXsonjL+xANCSbGC2gzJkA44prI8URdqNGC9NnHTDsUidO5Uruj57fOAR75w5PoDe
         uGmuomoyZeLgXoBi6dJAJOQln4gBPXzJjM9Yw616H16dB/FbICARAmbkIQFOGUTmhsQl
         GVw6Iq0Vh+QRwuAAuOfDCI8cxEoSVkstizKKOHlXos3vUOOw/M8Qw/8n07aQVo5F9NoB
         FVjsGdRT81PdelbTxRFZCoN1g5IBsc3rcsIJfHwBTH/21W6t7f6YuTKUbTAnnc9x8mn0
         6jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690510733; x=1691115533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iW4JMwFnqCVD+d2+erHxBd4VHkTR+0lG/+d9ZayWYs=;
        b=KY15OgtB1SLvxlMLaASzt1W3RAkjhHzX/FpmEsUiOKZ7o8+wLjtyGQmtPZu1vb1dUu
         pyKFx4RWYFYGAMH5irNRB8mFQe9AuGwuKSpPWf+GqtR1+6rhLLNiukSAYoTLmDhkCQ6x
         tg3SIu9a888kntaMHkfnNmtL7IlNhzYX5XhlxA1DLxs0GF1vzWlmOu1+4E7/ljpC88+y
         bee/8yi8uDesuawJyjmW82ue3kdPNMQRBORZOd37BrmNoIFeLpUkLyBpITrgvdoHzOwj
         7WvfzG4T7CqKW3lqwuy9pXhUTz/pZq/wgsqCYK9E+c4W64zSZPIwsUxWGnnOmGjX0cVq
         kQ5A==
X-Gm-Message-State: ABy/qLaY8A+h3SFMeAkPy7HBkMPNPDI+Rq1jkAnfpue3QQcp4npPJHCk
	KOwmTlWXjmW71aAtNJyqnDDrkdcpHlpGsz8o1DA=
X-Google-Smtp-Source: APBJJlExyjuj4xtTdgTRSaxHM6Cwy5L3f427vkCiSHSah3ItyiEMXlnzq5/dSncf1f+VcDT7JGmMu0mczJ5wiLMVc0g=
X-Received: by 2002:a05:6512:54c:b0:4fd:d92e:31ca with SMTP id
 h12-20020a056512054c00b004fdd92e31camr528283lfl.36.1690510733314; Thu, 27 Jul
 2023 19:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230728011143.3710005-1-yonghong.song@linux.dev> <20230728011250.3718252-1-yonghong.song@linux.dev>
In-Reply-To: <20230728011250.3718252-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Jul 2023 19:18:42 -0700
Message-ID: <CAADnVQLUejc9+ZbS04a336vhww+HYok7U2Uuc=Gjuxb7sa=UhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 10/17] selftests/bpf: Add a cpuv4 test runner
 for cpu=v4 testing
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	David Faust <david.faust@oracle.com>, Fangrui Song <maskray@google.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 6:13=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> -# Silence some warnings when compiled with clang
>  ifneq ($(LLVM),)
> +# Silence some warnings when compiled with clang
>  CFLAGS +=3D -Wno-unused-command-line-argument
> +# Check whether cpu=3Dv4 is supported or not by clang
> +ifneq ($(shell $(CLANG) --target=3Dbpf -mcpu=3Dhelp 2>&1 | grep 'v4'),)
> +CLANG_CPUV4 :=3D 1
> +endif
>  endif

Gating cpu=3Dv4 testing by LLVM=3D1 is unnecessary.
The kernel can be built by GCC, but we should still build
test_progs-cpuv4 when clang supports it.

Please consider a follow up.

I've applied the set, since the rest looks great!

