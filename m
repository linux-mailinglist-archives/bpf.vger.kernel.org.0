Return-Path: <bpf+bounces-66696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC08B388B1
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7313317BCE6
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8B4273D68;
	Wed, 27 Aug 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ63lnOK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05443147
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756315968; cv=none; b=qsyGkebvaE2T7lemtYZPwbiEVwVYyDJoFjfNnoL6EJUxwO6OVFpOwjSzURL6nU7l4OBWZk8B1W9wLj9rMdstQ7HCbTS7GsSzyRbUGwVaM9MnkFMkam7bcBQySihuSQVd+20uKQDISZAZwI4/hCbWrUJd3bp51QoGYFz3iO8hwrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756315968; c=relaxed/simple;
	bh=iyjWZsBRFoBZkK7gjxcfZKvk3y+w5D9IB7L2nC+7/b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWjxNwq1CRixAAX23u//D/u++4TNiY2MJVlpHlpKeL3xLp3zuLY7KKhg4Uo3FNIaMx5lL/5CnoticwAeES+/J0isVr7945nFH5SXp65NvFpjB9Q0c+5+AejWKgmiwLJl+HXaP29DlV27kdFiq8ZUKuFA0vFL38qRpYB5ifiYa3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ63lnOK; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3252c3b048cso100115a91.2
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756315966; x=1756920766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKdzdSJ2+6CguLmx5dstHuYI1DNsaxa2Jgs8y/aBmDc=;
        b=FZ63lnOKv3C9gEaQte7bDTvWSce58Tq4rPSAYgc4TK9K/npm7aXL0YK5E0u8G0HlP4
         QV+kCGnaVGgJAvKC89LgB7whGVGVGb9XlveNdTB1I0qArof9yIOAqizbGQgjEwW80pCu
         Iv197huHjqzR+QTPKUeIQHHypzYKdI6UhbTYcWwlHIUXbeX+gJGGhPX8RI6oKDNs9BUX
         SibBNMLm+vEzT3g1KbwPg1n9iCwnovPMJz9QT97jWoHuMVljxvHfiWqULQgGeChIM34s
         yHzawbodEIKMi/hQMBz5R79lJdh8BnsLzSSPTIUGZ6K/PfDU13BdP9XqCNB9+n9nOdak
         +1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756315966; x=1756920766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKdzdSJ2+6CguLmx5dstHuYI1DNsaxa2Jgs8y/aBmDc=;
        b=L0k6q12N/GpJ7DE/PfXyFuPSptUn6fOTL6GFc9A0fLTJU/2XFLOMfvEWELlWfffI7v
         Ud0w+Me/WhQBVOTZCYTpP5uO+X05YBiBfM8HSAqk19POVZq2f+X3a6ch+skJ3piNVO62
         C5aBgZzUC7nSCbk+re9qgYf6pn3d8ElgttMjogtm8a6OQB/42fS2oySwEAvogInkKhFm
         +A3IginOmvvxDuKHcoMC1Yy1l5zgkEc2NOhHWElmK3Mt3U2wq/9wUFeUXsObsf7ru6KG
         7psb+yHqEVuyLr2yvIHjIjvYK5SPYmfk2Kuz8Cxz11sD1pe6NzAUINxyUf7oM5Eyr8+P
         DMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFvDujfTRmi5hyc1ee3e6pd5KW0IxIZ07Ng4EtB9ri0m+SqLMhlmEnt3Af1XE2D82imiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaKSFsC4GTZNsGJc+Wf0W8hKxdINWyIYoN9nqmQBux9L8FQ7Su
	3zLCuUBXYCeuCAZeGhx7CEDVcSBugYz5GENhNodco8CkfRTWlLdK85R9/V5TPnlf2MLCoOdmDmZ
	80WqRqf8vNi4LzufU485BVIR+O98YQ6f+sg==
X-Gm-Gg: ASbGncu1SxE0/E+ZmfIuyT4GQ+h4a7VJKVXULhUCU53jEmSj03SkXNpmqdFdwYaiBmz
	oY6PV7ebyHr1Bv7WeM1E5dTJz4Xj08KQKGraOZx29nk/vnMjcOD+cyl2yVLjRof+uHdolYSJeWr
	6zmlgWED9icLR+EoYrvcVahzCEXEtjGWtzuBOZ6dsQS3sMFrNhQNn7q1OY1Wxvt6MSK68JitKjb
	Zgz4hDmua8LL1/bNQ03Oxo=
X-Google-Smtp-Source: AGHT+IF+wH9AS2jaRwRxERAkPGTMCocoUzcmgq0sRetDrbl0x9okS4CKl+4fxZ4jX6V8hPuqDcloQfn7IIBKyC37Kr0=
X-Received: by 2002:a17:90b:384c:b0:31e:d9f0:9b96 with SMTP id
 98e67ed59e1d1-32515ef8acbmr26439129a91.14.1756315966312; Wed, 27 Aug 2025
 10:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827130519.411700-1-iii@linux.ibm.com> <20250827130519.411700-2-iii@linux.ibm.com>
In-Reply-To: <20250827130519.411700-2-iii@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 10:32:33 -0700
X-Gm-Features: Ac12FXy5S0Rj49y3O15cuFuCPVqUfjE1Gr0yXWjmthcauTgXTFZeTYdZRtV0xsk
Message-ID: <CAEf4BzZgf4vRWnse6N1X_h4X6XPuax_iMxiJ5x=kwLyJzz8x-w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Annotate
 bpf_obj_new_impl() with __must_check
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:05=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> The verifier requires that pointers returned by bpf_obj_new_impl() are
> either dropped or stored in a map. Therefore programs that do not use
> its return values will fail to load. Make the compiler point out these
> issues. Adjust selftests that check that the verifier does indeed spot
> these bugs.
>
> Link: https://lore.kernel.org/bpf/CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=3DBjB=
JWLAtpgOP9CKRw@mail.gmail.com/
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/bpf_helpers.h                          | 4 ++++
>  tools/testing/selftests/bpf/bpf_experimental.h       | 2 +-
>  tools/testing/selftests/bpf/progs/linked_list_fail.c | 8 ++++----
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 80c028540656..e1496a328e3f 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -69,6 +69,10 @@
>   */
>  #define __hidden __attribute__((visibility("hidden")))
>
> +#ifndef __must_check
> +#define __must_check __attribute__((__warn_unused_result__))
> +#endif
> +

do we need to add this to libbpf UAPI? let's put it in selftests
header somewhere instead?

>  /* When utilizing vmlinux.h with BPF CO-RE, user BPF programs can't incl=
ude
>   * any system-level headers (such as stddef.h, linux/version.h, etc), an=
d
>   * commonly-used macros like NULL and KERNEL_VERSION aren't available th=
rough
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index da7e230f2781..e5ef4792da42 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -20,7 +20,7 @@
>   *     A pointer to an object of the type corresponding to the passed in
>   *     'local_type_id', or NULL on failure.
>   */
> -extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
> +extern __must_check void *bpf_obj_new_impl(__u64 local_type_id, void *me=
ta) __ksym;

bpf_obj_new_impl will generally come from vmlinux.h nowadays, and that
one won't have __must_check annotation, is that a problem?

>
>  /* Convenience macro to wrap over bpf_obj_new_impl */
>  #define bpf_obj_new(type) ((type *)bpf_obj_new_impl(bpf_core_type_id_loc=
al(type), NULL))
> diff --git a/tools/testing/selftests/bpf/progs/linked_list_fail.c b/tools=
/testing/selftests/bpf/progs/linked_list_fail.c
> index 6438982b928b..84883f04d58b 100644
> --- a/tools/testing/selftests/bpf/progs/linked_list_fail.c
> +++ b/tools/testing/selftests/bpf/progs/linked_list_fail.c
> @@ -212,14 +212,14 @@ int map_compat_raw_tp_w(void *ctx)
>  SEC("?tc")
>  int obj_type_id_oor(void *ctx)
>  {
> -       bpf_obj_new_impl(~0UL, NULL);
> +       (void)bpf_obj_new_impl(~0UL, NULL);
>         return 0;
>  }
>
>  SEC("?tc")
>  int obj_new_no_composite(void *ctx)
>  {
> -       bpf_obj_new_impl(bpf_core_type_id_local(int), (void *)42);
> +       (void)bpf_obj_new_impl(bpf_core_type_id_local(int), (void *)42);
>         return 0;
>  }
>
> @@ -227,7 +227,7 @@ SEC("?tc")
>  int obj_new_no_struct(void *ctx)
>  {
>
> -       bpf_obj_new(union { int data; unsigned udata; });
> +       (void)bpf_obj_new(union { int data; unsigned udata; });
>         return 0;
>  }
>
> @@ -252,7 +252,7 @@ int new_null_ret(void *ctx)
>  SEC("?tc")
>  int obj_new_acq(void *ctx)
>  {
> -       bpf_obj_new(struct foo);
> +       (void)bpf_obj_new(struct foo);
>         return 0;
>  }
>
> --
> 2.50.1
>

