Return-Path: <bpf+bounces-21419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7B384CF4A
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 17:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD06B286EC2
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E710823B7;
	Wed,  7 Feb 2024 16:54:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63081AD3;
	Wed,  7 Feb 2024 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324880; cv=none; b=H64GGn81xUaTqzpftBy0Nh/EbGptjZZmHBzl2rX9vSL315LEhbhRpTNVxJnJ7t8ezMg6cCgIYa/69pZC8iqdB0Q5zlxflSeoOvgSnHJMLyp/sQaj04Q+pL20DxKZSGH9bIni7otmgFPmA2mfGBjsbsWlG17YsHTJfWeEnG5r6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324880; c=relaxed/simple;
	bh=8SMGcPX1EaAbOnwuaOxFDCVdYeYRvn5HrRLClVWFJnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1HoqeAQntlJMOw9WEwMyhCeCMYr08zdlfvVfYpgzlRqTlDULEZNLR+gNcs9MPQNkQx7e0VNaSSO5WLv+IpbCaROBNH45hQhvoS895q7Bn0pXHHVWBc7pKWpCxk3pCd6sBnQfL4mv5EmFg6FHNLJu3avFM3cjM7B+RYR4/UjF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e0507eb60cso598482b3a.3;
        Wed, 07 Feb 2024 08:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324878; x=1707929678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFWCuFlBLzCUWV4jwVKyNSgCubC/35Kvhe3/yYpj56I=;
        b=Wkp8fDRsEzUCheBcXcNxdwgCL23/TnqwpsA+8R0XWboWTIaUpKCDswF4kVK2OlHdH+
         iWy04F3GALoKWI9YFnJ8FSVhHkQbRTIpumsunZW7RQIaNs7uhIfID17vtj+oj+eYqbOh
         pAhOHaCK7qLyIIhkhZqf21Mtxdt3Rv55I0P9pEXk+8x3QotWslsxsSTTsLpXHQ+s1wke
         XU/85+lohOQVxPZhJu/C0D/r/iLxWwIkW8k/hzQR7P9ZTbwEPb+Gf3Ye9hnAI1fagqT9
         WEWzBzDoZPHl7sp9i2BX9HNQ7gkCXBzbNzEf0FYqaPHbjN4LHMXkiI17vfvz8MgDYHFz
         8RMA==
X-Gm-Message-State: AOJu0Yzz2ZBWTPNbz6N+UgoISyTXdYgJ4sybm09oo8+FzsQrWq87h04X
	ARNh0HQ700jfKBs6LftCvxlrQeOQzNxhzJuFZg1ePt35rZeuEMaYujxT3HWhqdFYKfgrHADI5hB
	yb5U11Ld3ZQBpN6RNrJ21/mdmxlU=
X-Google-Smtp-Source: AGHT+IFvVYIu3Ss1QbwMuQSQ7A3OklEFUl+QL08+W1ad4I0SqbvyPguE+z/5iIaQaILDY4/Dpvadp9TJctdIlcLrEWE=
X-Received: by 2002:a05:6a00:44c5:b0:6e0:6c89:e308 with SMTP id
 cv5-20020a056a0044c500b006e06c89e308mr1808249pfb.3.1707324878028; Wed, 07 Feb
 2024 08:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206033320.2657716-1-irogers@google.com>
In-Reply-To: <20240206033320.2657716-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 7 Feb 2024 08:54:25 -0800
Message-ID: <CAM9d7cix-TuMov+hsqVvvkeSRA2snhuddcY0zypR1F9yY4G2Wg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] maps memory improvements and fixes
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, liuwenyu <liuwenyu7@huawei.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Mon, Feb 5, 2024 at 7:33=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> First 6 patches from:
> https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
>
> Ian Rogers (6):
>   perf maps: Switch from rbtree to lazily sorted array for addresses
>   perf maps: Get map before returning in maps__find
>   perf maps: Get map before returning in maps__find_by_name
>   perf maps: Get map before returning in maps__find_next_entry
>   perf maps: Hide maps internals
>   perf maps: Locking tidy up of nr_maps

This fails to build with NO_LIBUNWIND=3D1

util/unwind-libdw.c: In function =E2=80=98unwind__get_entries=E2=80=99:
util/unwind-libdw.c:266:70: error: invalid use of undefined type =E2=80=98s=
truct maps=E2=80=99
  266 |                 .machine        =3D
RC_CHK_ACCESS(thread__maps(thread))->machine,

Thanks,
Namhyung


>
>  tools/perf/arch/x86/tests/dwarf-unwind.c |    1 +
>  tools/perf/tests/maps.c                  |    3 +
>  tools/perf/tests/thread-maps-share.c     |    8 +-
>  tools/perf/tests/vmlinux-kallsyms.c      |   10 +-
>  tools/perf/util/bpf-event.c              |    1 +
>  tools/perf/util/callchain.c              |    2 +-
>  tools/perf/util/event.c                  |    4 +-
>  tools/perf/util/machine.c                |   34 +-
>  tools/perf/util/map.c                    |    1 +
>  tools/perf/util/maps.c                   | 1296 ++++++++++++++--------
>  tools/perf/util/maps.h                   |   65 +-
>  tools/perf/util/probe-event.c            |    1 +
>  tools/perf/util/symbol-elf.c             |    4 +-
>  tools/perf/util/symbol.c                 |   31 +-
>  tools/perf/util/thread.c                 |    2 +-
>  tools/perf/util/unwind-libunwind-local.c |    2 +-
>  tools/perf/util/unwind-libunwind.c       |    7 +-
>  17 files changed, 899 insertions(+), 573 deletions(-)
>
> --
> 2.43.0.594.gd9cf4e227d-goog
>

