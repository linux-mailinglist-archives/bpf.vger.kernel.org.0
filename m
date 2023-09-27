Return-Path: <bpf+bounces-10982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F37B09A8
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8600B28238D
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3050499A7;
	Wed, 27 Sep 2023 16:09:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509AF1170F;
	Wed, 27 Sep 2023 16:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D46C433C7;
	Wed, 27 Sep 2023 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695830992;
	bh=29xvS6IckRi6KRlCqL8FdLLJBEWH1CFbIZ0TphFXPaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EEyFXcxpELH4if2Vluo4qEaHH7+FfmHNIlfz7eCERLv//HxjqKpCeVxgxgyfNlJsC
	 wBwY/WWh6n8zxNYqHDolFudHROYNMssCXxmm5+rpdoNTeeAVCC/za7IWXWhUxRlvAZ
	 OOppLHTdjU0jCyoI8BcJjvhfY/nfxXGOOUwAaBI6Gc9/5x1/VnQtUETjFgjYVEH5HZ
	 VqOBtBp9J7hVchKRP0g8cNDFA1h+UZSWHfi9NJ0FfSFTCk53T2Hjog0pVdwGwQlPKh
	 2DUSOUC48pmvgIobPbN/8jJemFQI2uBPTJBgeHmpGFIvQCT/vO1GolR7pSWxlI3vN/
	 wIwLfPDEs9g+w==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50435a9f800so17582721e87.2;
        Wed, 27 Sep 2023 09:09:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YxxkZ1JlSLV0R8z3qn9fetOd58E4I+3IbDzqVWC02YrA8k8vsPk
	xbq9a+mWSIiz4zHb1XAOFNNL5thbytz6hXHF/dw=
X-Google-Smtp-Source: AGHT+IGp3+fz1AJ91MmIzVAQfTPDyNrrJTO5Zr+BTfLNgXaBr2MIyc/b/LGPxbYxlLced3r79V/W9DwssWZa77bUZYw=
X-Received: by 2002:a05:6512:711:b0:4fe:7dcc:3dc1 with SMTP id
 b17-20020a056512071100b004fe7dcc3dc1mr1915673lfs.44.1695830990353; Wed, 27
 Sep 2023 09:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922234444.3115821-1-namhyung@kernel.org>
In-Reply-To: <20230922234444.3115821-1-namhyung@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 27 Sep 2023 09:09:38 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6mEWJcZdYbPbqt5ArBMznzQYwHBqTpKCcsB4B0o=PSGA@mail.gmail.com>
Message-ID: <CAPhsuW6mEWJcZdYbPbqt5ArBMznzQYwHBqTpKCcsB4B0o=PSGA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix BTF type checks in the off-cpu profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 4:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The BTF func proto for a tracepoint has one more argument than the
> actual tracepoint function since it has a context argument at the
> begining.  So it should compare to 5 when the tracepoint has 4
> arguments.
>
>   typedef void (*btf_trace_sched_switch)(void *, bool, struct task_struct=
 *, struct task_struct *, unsigned int);
>
> Also, recent change in the perf tool would use a hand-written minimal
> vmlinux.h to generate BTF in the skeleton.  So it won't have the info
> of the tracepoint.  Anyway it should use the kernel's vmlinux BTF to
> check the type in the kernel.
>
> Fixes: b36888f71c85 ("perf record: Handle argument change in sched_switch=
")
> Cc: Song Liu <song@kernel.org>
> Cc: Hao Luo <haoluo@google.com>
> CC: bpf@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Song Liu <song@kernel.org>

