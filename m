Return-Path: <bpf+bounces-77595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781D7CEC47B
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1D9730011A8
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB70280A29;
	Wed, 31 Dec 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1Q1BmDM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8F2248B0
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767199585; cv=none; b=RAu0wc8y6sYB8tgF2gcLKszmn4O6gOKMKpHz2lvMcJn17lJ0Lm2dlNZ8naXmapAr60qyMaJaHU155ANoguPUD4ymI+Hg5E/t3ll7GY4qi9TmYgxhXBdQ3kNxhRxSVybVh29CxROQiN3Enyf7I9fi9WCzUH0pTo0pQ5gVKBTe0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767199585; c=relaxed/simple;
	bh=S5FrASt+YDKWNZTWLUxIzOWqzcCixdTDssK3Do4Djq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnGtYvnr/jM4pAGlelTZHWZ9uKAOFZ22UsBxZTlJgQij+/1FuHok/O38AObRvQYuIp2fIwz2i9P82DjOPI450vvcvuAJB/9IBeiUmvFqWnXWVk+LamVvDlolSIdBrlYUXFmTlr1tZOZgvP/sJNWp5ILJyCKB2h0eaUe5flSL1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1Q1BmDM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fb5810d39so6868701f8f.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 08:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767199582; x=1767804382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZrBM1S9/mxya9NEItGvHC9zqInI4GbMnOrymniIuV0=;
        b=G1Q1BmDMKbX7g78zGbvE/BS3EyjdsuMPNj8ivgdxbJI7nFxeTC8KVADUhevyBUNU+f
         IYZvlcbRMA2B+/5QaMeoYW+sLoC6PBNLxnOBA9BfPJoJKlEUdji5ZuAUQhIhelhm3mxP
         BI8ucvNNk9NtNjhXekJbhWJS4lc8x7LjhethExRLiRMTa0YOGys15e/UQGJKo40sgulp
         AafCsCLyOWg4nQoEQtW0zyqcwvrSpae5Jk6rTbpb3VetuwLLr7L4v9Qf58UfgCR3UOHC
         HFQFjNmSod0z5SIQ0D5CMB0eVGE8t3qtsn6ZGSza6jb+kllpFCfbPKPmCJJFmcqOk+Qx
         i19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767199582; x=1767804382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZrBM1S9/mxya9NEItGvHC9zqInI4GbMnOrymniIuV0=;
        b=qLgn3uxnE2d9IoR5o3b0/oqmzvbF1C46QIMtVUlZ+ZQmpmwCcXt55Lv7u/rIFPMMv8
         3nOg9Ntw/BQOGl85PQIBmyER/4udYynuXBpisAESVKaR7sbbZPKsy19A/WccJtGmBptZ
         Lj5p6NgTJTuN6rP5g2VA9n1I6g11lZdEYRhhLdlzgmsFqdAXBSV5i3vy5gYPVkEueXdn
         iecO9BAruFTCZmB08K26qyyTrl/SFuf0NJOE3DpRBB03YCv7FTAk9+tXqYQWIZDCmZKt
         IRHqZUjHM1H/4rUHDWaSJhtddZ4bjb0+BfcoXF2heawaModW9C0P+zpfEYME/Ya52XZv
         ZDCA==
X-Forwarded-Encrypted: i=1; AJvYcCXx4qON9SpWpTJV3ZJCPw42rkA3TMlYT+sSO0vagNxlEt80DkFK/mx8cBhGMmtFZ9lBF2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwatfK6n+gsV9jLv/NFTtL5d2OBXUIFquaTS8qNiNnXwjp7N+Uv
	bD6pstlzl+VwHZZUSc/SrZOtQwGJfX4MdSyDehToYf9nMqSXXQ8ieH7LpGvpvBHgQimhnO2rwj/
	m9Tp7p/THUoaCrGlNC375fMKeUbRF/X538A==
X-Gm-Gg: AY/fxX5pDE8e5TBzDk9G7X6TYGgHtvkGgEk7Zztsjt92KEMV4slwVuBLyCxVDNlcQA+
	Zs22/qanMJc8u2XgKFLB6pgPAgtUq6KIGS0vcf7eF+8ThDI3cAsGGTsiqFm+sA8LlWqyixNq82q
	KmNLXXXxs6dIjQ69wENgdOymNL62YpBhEkxkF21JHFyVyvmWbJ1jmKpyXpwcBc+5aiC/vYmBlaq
	RAsAoEx+WTrPYqnxSJMHH8jpgUTEq6LzL6cowLyjzZ6VKEgao2utDvvWsuwKJ0/duhRHr/RAsYo
	qrQd70Jw3lB+ET8owsloN6Amz7RK
X-Google-Smtp-Source: AGHT+IFRcWZVoxPPY6i1WyZlhvMd8V51vC8I4ra0MIHhsEDMgQUIBj25Y6d8K/+d1Lb6vZ8sZiVoaWZQKphbtFDOWsE=
X-Received: by 2002:a5d:68c5:0:b0:432:5bf9:cf15 with SMTP id
 ffacd0b85a97d-4325bf9d091mr34543547f8f.5.1767199582223; Wed, 31 Dec 2025
 08:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231163329.4831-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20251231163329.4831-1-sun.jian.kdev@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 08:46:11 -0800
X-Gm-Features: AQt7F2prI8DvYiKhoVc-rKAAMki7kJ7gPtmB6oFWzCNLzBOKRRGRMGSAHJUKNpo
Message-ID: <CAADnVQJm8xoxbuq3Lck3Yen2k9KOQoQFd9e2UTyL-cH4fEaJbw@mail.gmail.com>
Subject: Re: [PATCH] bpf: selftests: fix missing declaration for bpf_copy_from_user_task_str
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 8:33=E2=80=AFAM Sun Jian <sun.jian.kdev@gmail.com> =
wrote:
>
> Clang BPF compilation fails in bpf_iter_tasks.c due to an implicit
> declaration of bpf_copy_from_user_task_str(), which is a BPF kfunc
> exported by the kernel.

nope. It's there in vmlinux.h
Fix your build setup instead.

pw-bot: cr

> Add an explicit prototype in the test program to make the kfunc visible
> to the BPF compiler and fix the build error.
>
> No functional change intended.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_iter_tasks.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c b/tools/t=
esting/selftests/bpf/progs/bpf_iter_tasks.c
> index 966ee5a7b066..f5f396b5aa27 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> @@ -4,6 +4,11 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>
> +extern int bpf_copy_from_user_task_str(void *dst, u32 dst__sz,
> +                                      const void *unsafe_ptr,
> +                                      struct task_struct *task,
> +                                      u64 flags);
> +
>  char _license[] SEC("license") =3D "GPL";
>
>  uint32_t tid =3D 0;
> --
> 2.43.0
>

