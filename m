Return-Path: <bpf+bounces-9918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F3579EC41
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06C71C20C2F
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446F21F198;
	Wed, 13 Sep 2023 15:14:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1F31F179
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 15:14:12 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E5CBD
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 08:14:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401b5516104so73525975e9.2
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694618050; x=1695222850; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LK16w0SxBny0WzOUZaKAWxtIAhYs997/uMnKoknIB9c=;
        b=qrJxmLHdsy3jlEiM9sgV/7JMuBfXP9prCWsL4lILg8CHMSSB0SX8AjiutHG5tHotm0
         il09+SwL/zOsT8CoAJeg+lsfF7fSKss5RVS2JLXndNio3FUJS73P3TmcUlLUqDX0Yk/4
         4rHcMylRuzGT5gr9Fp7WEvnm7yvZudOT8/Mnd9e124aItfNjgnL4P9KQFD2l0Aj03frU
         IgSiGoSWgPR86IKRiTJ5O+q5PiGRupImpIpyveGFTBwaKr1048EgkOqzL2cuF0vEhiFQ
         FfFhyw3bGow/TylDlDheRZWdEk7T4dncx6rmlC4k5lfdwbnpWblE+8aZ3hYkcE47WD4B
         zd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618050; x=1695222850;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK16w0SxBny0WzOUZaKAWxtIAhYs997/uMnKoknIB9c=;
        b=JLaY3GEU/Udf8FV9EdZtngi0KAdf3N+irJcWjUJwcc6D3fYQQTcU/D9vyS26uzTL0X
         0OpH4vOXc7QZCe1Bj2g/Lt6i0AI8GE51wn6VxmgStUD9rNCCU0w0Yu5RpSwfJKSdDS+b
         /GLMKC7t6V7ycaQRVb0+RNG6B0icx7pnQfKXjPmEKD0dNZ8u2XYns3hYxE24dy3acarX
         k+842AwbkY70c2B1d8WGQoFdHjPjaJTgpKaBkQrbJLpIW3PtCQVigNelTUNJyyYgr9ot
         CEAGUgEydx2scRiSqw3SLfikWVp7lY5HyRUS7nTG4mRN266qDucNyExx7kHDMAtdBP9K
         Dxvg==
X-Gm-Message-State: AOJu0YzxEaAs7ux/tA2K7IlmkG38JOmW5QWMZnA7j19JDFglTx8NBZbX
	4dCteHZNc9i5NfATgqG8iVg=
X-Google-Smtp-Source: AGHT+IH+n+mkfRTimgT59V1HvpMXrBv48YMxUBh9XWVL4Q0mYRhCO0+NM61d57oa2nOjJm47JYutDg==
X-Received: by 2002:a05:600c:290:b0:400:57d1:4911 with SMTP id 16-20020a05600c029000b0040057d14911mr2246851wmk.16.1694618050226;
        Wed, 13 Sep 2023 08:14:10 -0700 (PDT)
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003feee8d8011sm2311233wmj.41.2023.09.13.08.14.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:14:09 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Yonghong Song
 <yonghong.song@linux.dev>,  David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v3 17/17] selftests/bpf: Add tests for BPF
 exceptions
References: <20230912233214.1518551-1-memxor@gmail.com>
	<20230912233214.1518551-18-memxor@gmail.com>
Date: Wed, 13 Sep 2023 15:14:09 +0000
In-Reply-To: <20230912233214.1518551-18-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Wed, 13 Sep 2023 01:32:14 +0200")
Message-ID: <mb61pr0n214xq.fsf@amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 13 2023, Kumar Kartikeya Dwivedi wrote:

Hi,

> Add selftests to cover success and failure cases of API usage, runtime
> behavior and invariants that need to be maintained for implementation
> correctness.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.aarch64  |   1 +
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
>  .../selftests/bpf/prog_tests/exceptions.c     | 408 ++++++++++++++++++
>  .../testing/selftests/bpf/progs/exceptions.c  | 368 ++++++++++++++++
>  .../selftests/bpf/progs/exceptions_assert.c   | 135 ++++++
>  .../selftests/bpf/progs/exceptions_ext.c      |  72 ++++
>  .../selftests/bpf/progs/exceptions_fail.c     | 347 +++++++++++++++
>  7 files changed, 1332 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions.c
>  create mode 100644 tools/testing/selftests/bpf/progs/exceptions.c
>  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_assert.c
>  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_ext.c
>  create mode 100644 tools/testing/selftests/bpf/progs/exceptions_fail.c
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index 7f768d335698..f5065576cae9 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -1,5 +1,6 @@
>  bpf_cookie/multi_kprobe_attach_api               # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
>  bpf_cookie/multi_kprobe_link_api                 # kprobe_multi_link_api_subtest:FAIL:fentry_raw_skel_load unexpected error: -3
> +exceptions					 # JIT does not support calling kfunc bpf_throw: -524

I think you forgot to drop this.
exceptions work on aarch64 with this: https://lore.kernel.org/bpf/20230912233942.6734-1-puranjay12@gmail.com/

Thanks,
Puranjay

