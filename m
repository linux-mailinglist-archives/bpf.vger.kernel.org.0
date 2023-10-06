Return-Path: <bpf+bounces-11577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FAB7BC11B
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 23:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3CD2821E4
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 21:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141E74448D;
	Fri,  6 Oct 2023 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+vSk99W"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2E41A8F
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 21:22:57 +0000 (UTC)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9F8BF
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 14:22:55 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4527d7f7305so1172920137.1
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696627375; x=1697232175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGVNTkTuEhOSEasSh+f06Vtoy0x55i2wMcWJNOvGy7A=;
        b=n+vSk99Wvz8Oz3Kyk9WWynpVMiPaVTPCVsqkZMCw5u8CJK+6xmawQaOuADpFN+l8Sj
         IIv5da45u/CM93dMRQcyjfgJb6WAUArzGxHy5Ibw6dBH493lLbWHh89Gxriv7696X29H
         lHqnY0xHLMySMusxJDGkpoMFnFrJ7PGPNI6UqUhgf0ypADHxwqEaa3Df6jAJOOXSZe6d
         y3t/pnxjUT/9zhbaPiN4UzFsyL72YXnVV8jDk0ln1cjpkyuR8DG78mMz2PlZ3l37a+JY
         Sx+hzPG6SHzbV/dcJLN3E6dNe0RePyhhkrJB2Q1KiPPZ4XgA5ZWP1uKY6FusDeMfmGbp
         mYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627375; x=1697232175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGVNTkTuEhOSEasSh+f06Vtoy0x55i2wMcWJNOvGy7A=;
        b=Kll3Ag/ofZICbhAAZ41tdODzBRkchkZ1ctT9BpXO+RXsDHncG8PUP4/vFH71JVO5Hm
         aMUOEPRjDdCMJXbO9m295Fo2AXLFaaU1zLg184byUjr9R/FCUI4k7mwhIDvnU7gAHqwW
         tc7m9N11W91lpDfs9Q1VtrBJOhF/pL7OlIdFmPJEDiju88vKkFqegcZYPRXy1GSxFULG
         ldL58VRMuOj5QF0iBOmTDJ86Kg9/+gvjyKHsqH3/j9QnqFGCJtezpCC9rseWQant9Bit
         wTzh4mQ6pZBKmK1AkYWhI1OTV6CAxR+uOfIOz/zhJgENTN+9DO7HcSJRi178T8kz1NIs
         XEcg==
X-Gm-Message-State: AOJu0Yyh122eOvt6/ns+nu8yrV/zrj9L9lhcErzRzVXToYH6dqP/l7hs
	Y/gqT7lHN4nMV3RJjbutnYoCA1V8Ci7nWH4j7IAcuA==
X-Google-Smtp-Source: AGHT+IHnX81YT51zxIXl1qmhGCbeGEzay4hR/OGqRxoTUMH7ud/FezhnE2gFVlk4Zt9S1a9t+vYObTEVG+pZ/4S4UyE=
X-Received: by 2002:a67:fe58:0:b0:44d:4c28:55ca with SMTP id
 m24-20020a67fe58000000b0044d4c2855camr9318168vsr.16.1696627374720; Fri, 06
 Oct 2023 14:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com> <20231005230851.3666908-4-irogers@google.com>
In-Reply-To: <20231005230851.3666908-4-irogers@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 6 Oct 2023 14:22:42 -0700
Message-ID: <CAKwvOd=7r9v72UadbTqk1EK=kMEH3-JybkmarToCs1_ohRC1sw@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] run-clang-tools: Add pass through checks and and
 header-filter arguments
To: Ian Rogers <irogers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ming Wang <wangming01@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yuan Can <yuancan@huawei.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 5, 2023 at 4:09=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Add a -checks argument to allow the checks passed to the clang-tool to
> be set on the command line.
>
> Add a pass through -header-filter option.
>
> Don't run analysis on non-C or CPP files.

Three distinct changes; I wouldn't have minded that as three distinct patch=
es.

>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  scripts/clang-tools/run-clang-tools.py | 32 ++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools=
/run-clang-tools.py
> index 3266708a8658..f31ffd09e1ea 100755
> --- a/scripts/clang-tools/run-clang-tools.py
> +++ b/scripts/clang-tools/run-clang-tools.py
> @@ -33,6 +33,11 @@ def parse_arguments():
>      path_help =3D "Path to the compilation database to parse"
>      parser.add_argument("path", type=3Dstr, help=3Dpath_help)
>
> +    checks_help =3D "Checks to pass to the analysis"
> +    parser.add_argument("-checks", type=3Dstr, default=3DNone, help=3Dch=
ecks_help)
> +    header_filter_help =3D "Pass the -header-filter value to the tool"
> +    parser.add_argument("-header-filter", type=3Dstr, default=3DNone, he=
lp=3Dheader_filter_help)
> +
>      return parser.parse_args()
>
>
> @@ -45,14 +50,27 @@ def init(l, a):
>
>  def run_analysis(entry):
>      # Disable all checks, then re-enable the ones we want
> -    checks =3D []
> -    checks.append("-checks=3D-*")
> -    if args.type =3D=3D "clang-tidy":
> -        checks.append("linuxkernel-*")
> +    global args
> +    checks =3D None
> +    if args.checks:
> +        checks =3D args.checks.split(',')
>      else:
> -        checks.append("clang-analyzer-*")
> -        checks.append("-clang-analyzer-security.insecureAPI.DeprecatedOr=
UnsafeBufferHandling")
> -    p =3D subprocess.run(["clang-tidy", "-p", args.path, ",".join(checks=
), entry["file"]],
> +        checks =3D ["-*"]
> +        if args.type =3D=3D "clang-tidy":
> +            checks.append("linuxkernel-*")
> +        else:
> +            checks.append("clang-analyzer-*")
> +            checks.append("-clang-analyzer-security.insecureAPI.Deprecat=
edOrUnsafeBufferHandling")
> +    file =3D entry["file"]
> +    if not file.endswith(".c") and not file.endswith(".cpp"):
> +        with lock:
> +            print(f"Skipping non-C file: '{file}'", file=3Dsys.stderr)
> +        return

^ perhaps worth returning earlier if this guard fails? i.e.

rather than do a bunch of work, then do a guard that may return early
that doesn't depend on the earlier work, instead guard first then do
all work.

I don't mind that as a follow up rather than a whole v3 for the series.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +    pargs =3D ["clang-tidy", "-p", args.path, "-checks=3D" + ",".join(ch=
ecks)]
> +    if args.header_filter:
> +        pargs.append("-header-filter=3D" + args.header_filter)
> +    pargs.append(file)
> +    p =3D subprocess.run(pargs,
>                         stdout=3Dsubprocess.PIPE,
>                         stderr=3Dsubprocess.STDOUT,
>                         cwd=3Dentry["directory"])
> --
> 2.42.0.609.gbb76f46606-goog
>


--=20
Thanks,
~Nick Desaulniers

