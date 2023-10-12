Return-Path: <bpf+bounces-12036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EF77C70D8
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 17:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1F52829F9
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 15:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AFE26296;
	Thu, 12 Oct 2023 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMB2PvPf"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3FB249F0
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 15:00:51 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68813BE
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 08:00:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5031ccf004cso1404226e87.2
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697122847; x=1697727647; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q4GcHVcImsCmkkAzVPFlYXjCx/OtSQRb+8D59GIF+UQ=;
        b=GMB2PvPfyXs4UE+H9Hhe3lSj0LHjvQxDpLDf0P/FyvS68vdakck2IRoBNIv14Jlsmc
         5Vz389WjsF74aKpjtPi2OGgHglFqPgM7EKaMbRgH6og2c05iQthOVYoPI+yO2fVTnVWb
         QdPnhLzrIbbrOGlsHqVUq73AqmHEqj2L62JkoGUArcB/vSLQH4+0mVBynE9l9gMCiv5i
         rCRJrwAhJg8RBbZrjbpxK7v+gAvRT58j79rRi82iYJ6bo5iS8w7atqiFQfbSF8cdY1kS
         ejhM9iWRWV1t/ZHcqkqQnVg1iRYL+uG/Mp2q1gIG3j55mIfR92DQtDIzXZUz6mYzrKGJ
         v9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697122847; x=1697727647;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4GcHVcImsCmkkAzVPFlYXjCx/OtSQRb+8D59GIF+UQ=;
        b=ooSEfVfHvRHnxXYlc5xwyLfjYJNmGui1mFsse8v3ils+Ns0H80oNsUplxc9hPiaYo2
         TYz5+/j3tK6+G+BXCgW+pvvwRct9c9IiFuwCP6R7dymHJbk5btk8Ut/7TrV0QOL19Q3E
         r7IsPVGAQJ0MidyQuPJ/6FP64/pNcfcHvJyG6xhG/ebZ/BXgzydnrNcRAmXuaJxFEfNA
         zNMLm6DuscoOOIuie+hqjarqYRK5OYxVL4Xeu/ZvV0oc0lkcIAPcE3vLSrTe8g71s1MW
         XgE+Gu0e0bvJeKcnx8JStPxCE4LvLMwvuSYMDqMY8miotRT52tRaIq+eKu8HgNvM/t5T
         4nyg==
X-Gm-Message-State: AOJu0Yw90KDSjH/iFxjPAuO0mTFqbBqCVVWW06QtSV1mHq2y4gDofb7+
	6FuLlN1XTn3f5HHSJxW/hpM=
X-Google-Smtp-Source: AGHT+IHm8e701noKnLoPbkvY2UnNd94eCUo6S1qEGPW5DvQxKcnxDGBBLcoTw9GciINI6elKwIziWw==
X-Received: by 2002:a05:6512:1029:b0:500:9f7b:e6a4 with SMTP id r9-20020a056512102900b005009f7be6a4mr18148395lfr.32.1697122847285;
        Thu, 12 Oct 2023 08:00:47 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q7-20020ac25147000000b005009aa86582sm2844289lfd.55.2023.10.12.08.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 08:00:46 -0700 (PDT)
Message-ID: <3a31082343bc1efd9328e5bb48adf9a36932135f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/5] BPF verifier log improvements
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 12 Oct 2023 18:00:45 +0300
In-Reply-To: <20231011223728.3188086-1-andrii@kernel.org>
References: <20231011223728.3188086-1-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 15:37 -0700, Andrii Nakryiko wrote:
> This patch set fixes ambiguity in BPF verifier log output of SCALAR regis=
ter
> in the parts that emit umin/umax, smin/smax, etc ranges. See patch #4 for
> details.
>=20
> Also, patch #5 fixes an issue with verifier log missing instruction conte=
xt
> (state) output for conditionals that trigger precision marking. See detai=
ls in
> the patch.
>=20
> First two patches are just improvements to two selftests that are very fl=
aky
> locally when run in parallel mode.
>=20
> Patch #3 changes 'align' selftest to be less strict about exact verifier =
log
> output (which patch #4 changes, breaking lots of align tests as written).=
 Now
> test does more of a register substate checks, mostly around expected var_=
off()
> values. This 'align' selftests is one of the more brittle ones and requir=
es
> constant adjustment when verifier log output changes, without really catc=
hing
> any new issues. So hopefully these changes can minimize future support ef=
forts
> for this specific set of tests.

All seems reasonable and passes local testing.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>=20
> Andrii Nakryiko (5):
>   selftests/bpf: improve percpu_alloc test robustness
>   selftests/bpf: improve missed_kprobe_recursion test robustness
>   selftests/bpf: make align selftests more robust
>   bpf: disambiguate SCALAR register state output in verifier logs
>   bpf: ensure proper register state printing for cond jumps
>=20
>  kernel/bpf/verifier.c                         |  74 ++++--
>  .../testing/selftests/bpf/prog_tests/align.c  | 241 +++++++++---------
>  .../testing/selftests/bpf/prog_tests/missed.c |   8 +-
>  .../selftests/bpf/prog_tests/percpu_alloc.c   |   3 +
>  .../selftests/bpf/progs/exceptions_assert.c   |  18 +-
>  .../selftests/bpf/progs/percpu_alloc_array.c  |   7 +
>  .../progs/percpu_alloc_cgrp_local_storage.c   |   4 +
>  .../selftests/bpf/progs/verifier_ldsx.c       |   2 +-
>  8 files changed, 200 insertions(+), 157 deletions(-)
>=20


