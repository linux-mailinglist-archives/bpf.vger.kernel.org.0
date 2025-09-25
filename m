Return-Path: <bpf+bounces-69789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CBFBA1E6E
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 01:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D8918901DA
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 23:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1FC2EC09F;
	Thu, 25 Sep 2025 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7s48foR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EAE2EC082
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841195; cv=none; b=tteyP1yB6SsXFDkqg4mo4Cy3YqSvl00Q2bGt4J3is41tJ5+dCCGOlEvr+yceNHyrDYZGyxwDGwbl9zU9ACQpRD+DL0XD+IVGCLkWS26VHA+PoofsU+nr2srqkJg9kuzWh+n9heRnaBYf4InSNltck3WLbo0sH8TkaHetsQYBIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841195; c=relaxed/simple;
	bh=k1Bi4GBNxZGldLOcK/Gfj2/5NcUND8W7LKwPLhlQNzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6KKR1/+364qHzfMxKqHd5pC4mCu7hKlfyvL5XBhH80cfpC/vEaRFTPG00bdpwe4se5srBle8OVuXSFjmah1GPx8reTHQsTEJHtsVXmuJR3GHGGUVPVVZQk1h+VpqmPp5gt28OWXd+pM64enY1huc2IZ/dI2qrdgXMrhI5BvYsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7s48foR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33082aed31dso1661752a91.3
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 15:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758841194; x=1759445994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyrvLFPundAPr1TrISf0HTBlOXV+fTi1lI8qVSX2a3k=;
        b=P7s48foRUaSNi8H1dtQDKpoNkBhgpGgeNfN2RDjpMZNOYDIRAcacXY/b1WofFkUnbJ
         yiyGcGrLUY1XV2Bw69Y0YUSJ3rgaIWOqMpVOze8PkTk/F2Y+XxwwFOWUmX5z3dW51l6W
         7+F6G0vY0jznrXcEfuZvl08GbrMNd6Po03ZH/o1EhJlm6RnEY7AwWA02Avw/sOrYl/uV
         YBLoUrsKflxqlud5sM8eUUaZQDGMYRTLY0vs3BQ9VtUGFL+Q+SZQGoenUqUcH50d74ED
         HSk951NLDLq5+1MFSCU9xo+q3H7NejfAmIy6xX0rNME5Feys2pSgTp76GGWs3pU6rQ4u
         V4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758841194; x=1759445994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyrvLFPundAPr1TrISf0HTBlOXV+fTi1lI8qVSX2a3k=;
        b=VwsphatElvVUO5tTnM1dLe8hDNFXDRdlfefGS56lrTFBsKOM35xQlX2+nLOVaVTeI9
         lX9cal3jlyrFwWLHm2X+p+oVIa6UzKcDOanH8QZTn+BY1yR45fTiPRSfLC69/Fq3ISgn
         BlwAha2vrhV2iKjWC1VO/Ky7tq5tG+vifp/winleVjmlYpSuwQNHb2lwBDM0lba+R4EZ
         Fei/2TxTaZN3oFiV28TwRHzuOMPOeyoNncxNNJLJsADvAj1XQ5DCBpQNhARWs9RtxVAG
         WMYWcLE2z0Ynti7XPnVf9NQSI1+WC8Ja14Y0FaCMbHO0AKJgi+usBwWL6jVx4PJoVlPB
         Pbkg==
X-Gm-Message-State: AOJu0YzftGLUZJX1R4sR3iVmG9QKpPKxr+Tqy/xm1ApGTE29VdQ7Mfl7
	5A+lOzCkWCNDQhTFNWEcZYZKY52w/TWqSayeGjMsNy7TG/qdu3EpIUU5YLrtYTb9piCr/vGpEbd
	j8qs3bm5oujqlPUR4l3sGDVBJCX2nJBC5cOJf
X-Gm-Gg: ASbGncvLyYV3UzzgzfojaGlQb8ZwosYhKKx3/ovRdWqlAhAzNODAEmMyXlo7b7Kt74d
	1ge3ewt71GSYG46rMJVaJs4RBZNp3/AfVVSW+BiOCivaptG0nxi6QIGTj0AD/B3j8VS20kxxRfk
	V11wQd6mYKCB/3/Z6EhzW21oZgxyzS8kqMNr2FXWUpUyamHTv6knPXkjWAkCu9HChSSApYoXWxO
	GtxZo2+RDfWv1ta/CecHZY=
X-Google-Smtp-Source: AGHT+IGx4H711q10DEN2YmSicn4+vkHET+f45Qpsh9Qbhrei1m2L5baGD7PNN63yXaD9xwVs3YY1O731cU/KVxMXhSc=
X-Received: by 2002:a17:90b:3849:b0:32d:d5f1:fe7f with SMTP id
 98e67ed59e1d1-3342a257810mr7003071a91.15.1758841193583; Thu, 25 Sep 2025
 15:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925215230.265501-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250925215230.265501-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 15:59:39 -0700
X-Gm-Features: AS18NWCRpuhOniDFjmO-0M3ryOonCZYjhSzf9Ik4qwH_BvrTkiMWpZvpCTLkcgc
Message-ID: <CAEf4BzaOOy1HkL2SaseDx=Y23U6uZcpETB2P6aMrv+MMcV58gA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix flaky bpf_cookie selftest
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>, Peter Ziljstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 2:52=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> bpf_cookie can fail on perf_event_open(), when it runs after the task_wor=
k
> selftest. The task_work test causes perf to lower
> sysctl_perf_event_sample_rate, and bpf_cookie uses sample_freq,
> which is validated against that sysctl. As a result,
> perf_event_open() rejects the attr if the (now tighter) limit is
> exceeded.
>
> From perf_event_open():
> if (attr.freq) {
>         if (attr.sample_freq > sysctl_perf_event_sample_rate)
>                 return -EINVAL;
> } else {
>         if (attr.sample_period & (1ULL << 63))
>                 return -EINVAL;
> }
>
> Switch bpf_cookie to use sample_period, which is not checked against
> sysctl_perf_event_sample_rate.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_cookie.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

We have:

$ rg '\.freq\s*=3D' tools/testing/selftests/bpf
tools/testing/selftests/bpf/prog_tests/find_vma.c
34:     attr.freq =3D 1;

tools/testing/selftests/bpf/prog_tests/perf_branches.c
112:    attr.freq =3D 1;
153:    attr.freq =3D 1;

tools/testing/selftests/bpf/prog_tests/perf_link.c
46:     attr.freq =3D 1;

tools/testing/selftests/bpf/prog_tests/perf_event_stackmap.c
66:             .freq =3D 1,

tools/testing/selftests/bpf/prog_tests/send_signal.c
220:            .freq =3D 1,
232:            .freq =3D 1,

tools/testing/selftests/bpf/prog_tests/unpriv_bpf_disabled.c
285:    attr.freq =3D 1;

tools/testing/selftests/bpf/prog_tests/fill_link_info.c
216:            .freq =3D 1,

tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
11:             .freq =3D 1,


So there are plenty of other cases like this, unfortunately. As I
mentioned before, I think we should rethink how we write
perf_event-based tests more generally to make them more robust.

But as a mitigation, I applied this patch to bpf-next. That
sysctl_perf_event_sample_rate check for attr.freq explains this
somewhat random behavior of perf_event_open() syscall.

cc Peter, in case he wasn't aware of this. This looks like a foot gun
in perf_event_open() API, tbh.


> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 4a0670c056ba..75f4dff7d042 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -450,8 +450,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>         attr.size =3D sizeof(attr);
>         attr.type =3D PERF_TYPE_SOFTWARE;
>         attr.config =3D PERF_COUNT_SW_CPU_CLOCK;
> -       attr.freq =3D 1;
> -       attr.sample_freq =3D 10000;
> +       attr.sample_period =3D 100000;
>         pfd =3D syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG=
_FD_CLOEXEC);
>         if (!ASSERT_GE(pfd, 0, "perf_fd"))
>                 goto cleanup;
> --
> 2.51.0
>

