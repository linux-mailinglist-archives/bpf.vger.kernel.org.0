Return-Path: <bpf+bounces-54886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED38FA753F6
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 02:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42FE169AB5
	for <lists+bpf@lfdr.de>; Sat, 29 Mar 2025 01:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9732744D;
	Sat, 29 Mar 2025 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJCpSw+G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1F29A0;
	Sat, 29 Mar 2025 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743212920; cv=none; b=Wi3QZpGtzzSAOE8KWvEQxc7JSV9EIqOcoywE9ZLKX3HWv5s11uEIY6K9YRmcJhr8rIEX6wdWtq2YgfV47ksz+dEoLuFKJGs5iNojJI65oGCNH4m3VJMWunv9wI5Ayf4L1EJfR6WRmo7oE79XSPVCjjzbIAMGpE9ZOgIOiB6ISHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743212920; c=relaxed/simple;
	bh=QJ25cCCjOlLoq4p+7jcRnXJCm7bBHp/lOu6ZIoamKYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5Gpp7aLTZLl96q5feCzavhIez2Vc33MA0PW3DpjHZoMQH2UMocWp4BQvxELuG2oWNZt2OzAzB/ZWcE+UvjC6p5p5XAsz9oWXX7uVQBbP7AXLj3oMYcgokfXDglGl3u5/YRJA2roTALmdSmfZ6wrupnxlyUJ7zox/m5l6ND1HlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJCpSw+G; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7023843e467so17228147b3.2;
        Fri, 28 Mar 2025 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743212918; x=1743817718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYyLjTTLlm3TtJ3ga+KagfNHrEj6EJpHloMAxTYeoyU=;
        b=SJCpSw+GYMZHOLJKVLpFehjwAv6aBZ0b4Fqr5bZptOqjaDjqydMIswhkSbNnQUkTlF
         m2IfxPIE+bKXGpIyEwEunKcRqNcGK290KKykQSphFSODGK2KjrHipWM9ovmDCkwPUKXB
         cGTpOYc4aHapXv9biCWdR/WpESvNRQcdfntlFwbctlHXbI4Y3jI92C+Ae9CiMjZWtI9X
         gCs+oRMKjUxRmJuLOHjIrhVovFB8O7ujtIpEYV92u550Mwr7If7z2kAPpAw6FPQdeIXG
         d6tXdcOB/QIap11NiZ2Nf6c6/sFQYsxGCwXkMrnft7qqJRdamINgQvbW3CvvK3cagwf9
         wLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743212918; x=1743817718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYyLjTTLlm3TtJ3ga+KagfNHrEj6EJpHloMAxTYeoyU=;
        b=NXTUiuUKgPAC5VUO+1JCDZlrHEb8SorVe8rwcn6Wd6a0f3IkpcBHeKuhxIFa1zgjsS
         GsuidjLe+b/sSl950oyPwq6tkeWMy4IuQgLQBhQi2QhoM0niAeIXNc0OEPxFbaa5m78Y
         y1c0yUB3wroEVQ9i15vALi3x94cEclXoiXBM78bX/0IPwGVW7Ikcge97HOdP6UIuzNfI
         MgRwRmfFg89LVfo4H/+5fk390/0wB0O3lSYnt6IzIDonDOFBc2PzbxZXx50qojyD7sPh
         SU2SeqpJjRNVdom8U3Nb8lqDb8Vi/s82YA+bv9kEOwFVlTldwCiM12Tk7x7udDRLyni5
         H7zw==
X-Forwarded-Encrypted: i=1; AJvYcCUhWT5RoAcLNy+kSwUpGSHy1mv0L5JSGvNoPElEv8vKzH8OdJiEtty4FgJ8jvYbnKK3Hag=@vger.kernel.org, AJvYcCUv5RvfOOzkixXdSUbhMjq+ljNGrSwwikkMvWWmggypNe30J/oRQDU8C84QODBgy4vfsE+McT6a3N1pUQca@vger.kernel.org, AJvYcCUvaRcD//wGJp6wQlefaNaygPVtNAoZAyeAwUFm7tS2Ui2ehhH7Uh7yj7Nwd/v/z8vIEMMoeqcSIggHmLrA2VSxNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOaJCMcdbdt1cFuoVh8s5zwbVaPGhc9Vu9ulQ0HPp5ermHHQPp
	T/7z77edQDQpKAGIXVafwsUNhklSvGrwVS3HW7OSWh/cL71panYEVhWhnU24HQb+VObUr3LD3vl
	3IV23ujMaz4WR+7XJ1f6S/vIDq4Q=
X-Gm-Gg: ASbGncuHPtEuyGvwrpFxEctaLCFiNrxRPlGi0dvXFqKlGj3N7ifyro5QrjIrlTb03mb
	iPXFDJXd1CL88pDOQFNdRmhULgqOyQtVU/ICeEL1+MDtEpfqGJaPSAwDPyokBg4UziPlZlskjYG
	tYW75P7PnLdk3VIohsp6ldR8bs
X-Google-Smtp-Source: AGHT+IF3T+5Tb5DRsJXKUaEj0OIMf0wUwSdeifwPmoLq2Chfvg3YRGTbtBX6BdbVy/7T039Uc4pcYo30x9oTQFFd8PQ=
X-Received: by 2002:a05:690c:7344:b0:702:d85:5347 with SMTP id
 00721157ae682-70257350bd2mr23435837b3.36.1743212917992; Fri, 28 Mar 2025
 18:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326044001.3503432-1-namhyung@kernel.org> <20250326044001.3503432-2-namhyung@kernel.org>
In-Reply-To: <20250326044001.3503432-2-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 28 Mar 2025 18:48:26 -0700
X-Gm-Features: AQ5f1JrZh9Vxlf8WTeFWlP0iv4IiJ9zBxTy-Ulqflquhr8gM4-tG9qGXLaeGe-A
Message-ID: <CAH0uvogpQDt-=wP1LYNuyqGfSdPN897WKiP53DqXSQPxGtK2fg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] perf test: Add perf trace summary test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Mar 25, 2025 at 9:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
>   $ sudo ./perf test -vv 'trace summary'
>   109: perf trace summary:
>   --- start ---
>   test child forked, pid 3501572
>   testing: perf trace -s -- true
>   testing: perf trace -S -- true
>   testing: perf trace -s --summary-mode=3Dthread -- true
>   testing: perf trace -S --summary-mode=3Dtotal -- true
>   testing: perf trace -as --summary-mode=3Dthread --no-bpf-summary -- tru=
e
>   testing: perf trace -as --summary-mode=3Dtotal --no-bpf-summary -- true
>   testing: perf trace -as --summary-mode=3Dthread --bpf-summary -- true
>   testing: perf trace -as --summary-mode=3Dtotal --bpf-summary -- true
>   testing: perf trace -aS --summary-mode=3Dtotal --bpf-summary -- true
>   ---- end(0) ----
>   109: perf trace summary                                              : =
Ok
>
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/trace_summary.sh | 65 +++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100755 tools/perf/tests/shell/trace_summary.sh
>
> diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/s=
hell/trace_summary.sh
> new file mode 100755
> index 0000000000000000..4d98cb212dd9de0b
> --- /dev/null
> +++ b/tools/perf/tests/shell/trace_summary.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +# perf trace summary
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Check that perf trace works with various summary mode
> +
> +# shellcheck source=3Dlib/probe.sh
> +. "$(dirname $0)"/lib/probe.sh
> +
> +skip_if_no_perf_trace || exit 2
> +[ "$(id -u)" =3D 0 ] || exit 2
> +
> +OUTPUT=3D$(mktemp /tmp/perf_trace_test.XXXXX)
> +
> +test_perf_trace() {
> +    args=3D$1
> +    workload=3D"true"
> +    search=3D"^\s*(open|read|close).*[0-9]+%$"
> +
> +    echo "testing: perf trace ${args} -- ${workload}"
> +    perf trace ${args} -- ${workload} >${OUTPUT} 2>&1
> +    if [ $? -ne 0 ]; then
> +        echo "Error: perf trace ${args} failed unexpectedly"
> +        cat ${OUTPUT}
> +        rm -f ${OUTPUT}
> +        exit 1
> +    fi
> +
> +    count=3D$(grep -E -c -m 3 "${search}" ${OUTPUT})
> +    if [ "${count}" !=3D "3" ]; then
> +       echo "Error: cannot find enough pattern ${search} in the output"
> +       cat ${OUTPUT}
> +       rm -f ${OUTPUT}
> +       exit 1
> +    fi
> +}
> +
> +# summary only for a process
> +test_perf_trace "-s"
> +
> +# normal output with summary at the end
> +test_perf_trace "-S"
> +
> +# summary only with an explicit summary mode
> +test_perf_trace "-s --summary-mode=3Dthread"
> +
> +# summary with normal output - total summary mode
> +test_perf_trace "-S --summary-mode=3Dtotal"
> +
> +# summary only for system wide - per-thread summary
> +test_perf_trace "-as --summary-mode=3Dthread --no-bpf-summary"
> +
> +# summary only for system wide - total summary mode
> +test_perf_trace "-as --summary-mode=3Dtotal --no-bpf-summary"
> +
> +# summary only for system wide - per-thread summary with BPF
> +test_perf_trace "-as --summary-mode=3Dthread --bpf-summary"
> +
> +# summary only for system wide - total summary mode with BPF
> +test_perf_trace "-as --summary-mode=3Dtotal --bpf-summary"
> +
> +# summary with normal output for system wide - total summary mode with B=
PF
> +test_perf_trace "-aS --summary-mode=3Dtotal --bpf-summary"
> +
> +rm -f ${OUTPUT}
> --
> 2.49.0.395.g12beb8f557-goog
>

Didn't quite get the combinatorial logic but it sure covers a lot :)

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

