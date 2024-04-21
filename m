Return-Path: <bpf+bounces-27345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AA38AC12E
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 22:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39761F2103A
	for <lists+bpf@lfdr.de>; Sun, 21 Apr 2024 20:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D27D43178;
	Sun, 21 Apr 2024 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJkJPZ/3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F61418E3F
	for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713730598; cv=none; b=QNTphfzl8vdwD4/YvwJ9hC+tE/22zW2+ekoyHDQHVtKpNPNju8Gv9dLwDlghTY4gfZhdXDp9d8jyaP3IgknRwh2XJ/2IJQY952BHhHLDFyrcsO+P3bAgCAbjNSIHUvU/WdOD9Mw2aE2ufgGylniBoLC/YSAVJ698Ejuny9WCE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713730598; c=relaxed/simple;
	bh=xoy0QWiuFCjG2awDfTEByQ69ZKSMJ0t97vOflr4J5G4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VABVfbWw2x/QZhRRzcT49hKhvP4F8LehwAxJ/K1yVKddjcP4n/GwyugZq5nepnVRWEGeVBP9XkhcD5unGIjWnsSSLLjbOPaLBVlQ4sWReV91rHQPmQ8j/kYa+TLdaeDwzEBbIf4Im25ykbk4OML7lCll0cLjGRbzMNtINvFsuuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJkJPZ/3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a51803dceso2556055e9.3
        for <bpf@vger.kernel.org>; Sun, 21 Apr 2024 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713730595; x=1714335395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ypknRuVyxeEw7V5WbZzbZAN8JMPNVshRCUTqCF710qs=;
        b=eJkJPZ/3eKfRveXvp71IE/WkXCkkjrX3Jk1QmjjLve8xZa3Bi7JdNT3D/jQgAV0k+F
         fvetQTLUz6CgNIqSdOcgs7Y+wBL/+IDicGKO5SMnovz29CFTDXpftyesXxEfkYvBABtF
         bM3fHi2/XbC15efdofI23HJig4RLuAH0euPc6woVp9kPsrJ3HzdRRWNPr/HhTweRO72d
         4oqPq6exBy5Ce7S/Dq7dnpUqsfWQNJ68Z7ukcp1VMgdUWQl/Tv/IhQ/O5bi9/6Gid0KJ
         oStF4xMSyu4vWzfR07WHS76vu0W8foChDJqEz/9K6ICcUr7DWIzm0WW6sFf31AJBYb4M
         oh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713730595; x=1714335395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypknRuVyxeEw7V5WbZzbZAN8JMPNVshRCUTqCF710qs=;
        b=l/s0Q/NyobBYZF1+o+zbKTHlj1FmNj9Cu90dmlPAFOszYIe2/qaCf7GCaRCnYtA47g
         0TRJe5s9cb1NWRBDGEDtdmclX6irKViEsBRaUBffxYRaSJdiIHw+BK+2JxG5+rYnhZny
         regRYd6I7t/MsCcA/lH5Z1bkNDkLjTXM/Lu2xRBGQxYic3lGHgGmgf59td5DPiiUBnG9
         5TJ3kAU+CRr6pIyYlnGcoXDlvX6WxwhwMhdHqL6wFTlAxE3HyqbHyfnS5BO0TMK0vQXL
         AvK37uW5styvgt3qO2gcxru12IBQ4u0kvwcxzsusZus7Zvt8Bu8f2lPH296aV+Lv1v1V
         qdLw==
X-Gm-Message-State: AOJu0YxMbE/EUDGVuzmcn1B33zIk5iZaXUcfBzHMx5WiiNITKPm+gmhW
	jrCJnVavgofr+lFWIoRfuAbTf/M2BFpvkb0bIfaror1acoNbULy8
X-Google-Smtp-Source: AGHT+IGtnH8aCa1kYX8o0qnBaChv50Os3tRa1NRchkmViBxdPRph45WESTNytlBxX50Hw465QomkMw==
X-Received: by 2002:a05:600c:4ecb:b0:418:e7b6:21de with SMTP id g11-20020a05600c4ecb00b00418e7b621demr7138016wmq.23.1713730594399;
        Sun, 21 Apr 2024 13:16:34 -0700 (PDT)
Received: from krava ([83.240.61.103])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm14368345wmo.36.2024.04.21.13.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 13:16:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 21 Apr 2024 22:16:32 +0200
To: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, daniel@iogearbox.net,
	Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	"Craun, Milo" <miloc@vt.edu>, "Sahu, Raj" <rjsu26@vt.edu>,
	Roop Anna <sairoop@vt.edu>, "Williams, Dan" <djwillia@vt.edu>
Subject: Re: [PATCH bpf-next] Add notrace to queued_spin_lock_slowpath
 function to avoid deadlocks
Message-ID: <ZiV0ICqUbLNsnG05@krava>
References: <CAE5sdEjqMe2pMDOO4MZkuncKu5PxMvcxtXmnpjwpHSM1Ek9Hgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5sdEjqMe2pMDOO4MZkuncKu5PxMvcxtXmnpjwpHSM1Ek9Hgw@mail.gmail.com>

On Sat, Apr 20, 2024 at 05:45:17AM -0400, Siddharth Chintamaneni wrote:
> This patch is to prevent deadlocks when multiple bpf
> programs are attached to queued_spin_locks functions. This issue is similar
> to what is already discussed [1] before with the spin_lock helpers.
> 
> The addition of notrace macro to the queued_spin_locks
> has been discussed [2] when bpf_spin_locks are introduced.
> 
> [1] https://lore.kernel.org/bpf/CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com/#r
> [2] https://lore.kernel.org/all/20190117011629.efxp7abj4bpf5yco@ast-mbp/t/#maf05c4d71f935f3123013b7ed410e4f50e9da82c
> 
> Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
> Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@vt.edu>
> ---
>  kernel/locking/qspinlock.c                    |  2 +-
>  .../bpf/prog_tests/tracing_failure.c          | 24 +++++++++++++++++++
>  .../selftests/bpf/progs/tracing_failure.c     |  6 +++++
>  3 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index ebe6b8ec7cb3..4d46538d8399 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -313,7 +313,7 @@ static __always_inline u32
> __pv_wait_head_or_lock(struct qspinlock *lock,
>   * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
>   *   queue               :         ^--'                             :
>   */
> -void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> +notrace void __lockfunc queued_spin_lock_slowpath(struct qspinlock
> *lock, u32 val)
>  {
>   struct mcs_spinlock *prev, *next, *node;
>   u32 old, tail;
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> index a222df765bc3..822ee6c559bc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
> @@ -28,10 +28,34 @@ static void test_bpf_spin_lock(bool is_spin_lock)
>   tracing_failure__destroy(skel);
>  }
> 
> +static void test_queued_spin_lock(void)
> +{
> + struct tracing_failure *skel;
> + int err;

hi,
the patch seems to be mangled, tabs are missing
you might find some help in Documentation/process/email-clients.rst

jirka


> +
> + skel = tracing_failure__open();
> + if (!ASSERT_OK_PTR(skel, "tracing_failure__open"))
> + return;
> +
> + bpf_program__set_autoload(skel->progs.test_queued_spin_lock, true);
> +
> + err = tracing_failure__load(skel);
> + if (!ASSERT_OK(err, "tracing_failure__load"))
> + goto out;
> +
> + err = tracing_failure__attach(skel);
> + ASSERT_ERR(err, "tracing_failure__attach");
> +
> +out:
> + tracing_failure__destroy(skel);
> +}
> +
>  void test_tracing_failure(void)
>  {
>   if (test__start_subtest("bpf_spin_lock"))
>   test_bpf_spin_lock(true);
>   if (test__start_subtest("bpf_spin_unlock"))
>   test_bpf_spin_lock(false);
> + if (test__start_subtest("queued_spin_lock_slowpath"))
> + test_queued_spin_lock();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c
> b/tools/testing/selftests/bpf/progs/tracing_failure.c
> index d41665d2ec8c..2d2e7fc9d4f0 100644
> --- a/tools/testing/selftests/bpf/progs/tracing_failure.c
> +++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
> @@ -18,3 +18,9 @@ int BPF_PROG(test_spin_unlock, struct bpf_spin_lock *lock)
>  {
>   return 0;
>  }
> +
> +SEC("?fentry/queued_spin_lock_slowpath")
> +int BPF_PROG(test_queued_spin_lock, struct qspinlock *lock, u32 val)
> +{
> + return 0;
> +}
> --
> 2.43.0

