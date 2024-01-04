Return-Path: <bpf+bounces-19017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BEC823EB8
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 10:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92BF1F250D7
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 09:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6FA208BC;
	Thu,  4 Jan 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amdms3Iw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E560208AA
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-556eadd5904so340445a12.2
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 01:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704360841; x=1704965641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=st7zXkydaJHUsGz1RbGpPKEVp1pNrspKhGkzC2akypU=;
        b=Amdms3IwA5MZHRVRMQTUT320qWIkyEJhuo+CJ3MPceyNdfbSyFyiyZYV0j2YXrWuRV
         gsp+CwGLIHmaa5V60d0xv+Y8lTSHh8/vnJ1Fs9ItpcdxfqRnxMPvOYxpbHqMgcoLjHVC
         uB7BnC/EESTeqWtjg0TNgMMiKqigZ0kIvmjYcEIV+2AHRwD3BONeuQbDeKgjdhKnMx2A
         2AoN4QTpKl61lLjxWZIdqpEMwNCbDlnHXHyh4PM8rU/ALH64BQlmn+4jxHalKx8Uftid
         BIKXGNvCdSC2uKAlk15rKnMjTKuI8YzadpjmsgcThNnskgN1UqFDSd674mTixT126QLk
         QSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704360841; x=1704965641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=st7zXkydaJHUsGz1RbGpPKEVp1pNrspKhGkzC2akypU=;
        b=WQVP9ilekb53ErOM0mDMXbQ3E6QC5kJo8/3XpNRae7QeaYE2Kyct1j73lzIxqGwDQ9
         VqMhj0vjZreHCV/o64xao3LqjR8uKVS64BiZtlwx1upUnOT70L2Ax3GH/+H1bmGXkK3W
         SG2l0BoPTfEPRIY+lAuQjL9Dzej+QloXWPIRkB3DWBlaJE8gZLDW7M4eUmQ9NZbVRZuW
         Gik38qMu1/yI1EiQh5NzngHCkfzyVDAh3iv5wno4W02IB6f8ncFNLGKGZFK9+NDW9k9Z
         5unDAEClzz2T/yIaL9yv9Kx+P2UsYESOwVsZfLNGg6v1q+Jgd95qWmZAwFM0xKKmGhjf
         PeyQ==
X-Gm-Message-State: AOJu0YyGtw8PUJg89wyMNTCd0pnQqIlmI4YDLKikF0vH5UYfHPV0Hp7Q
	l+3UlaaU8ZPRaY8jMxnE4b4=
X-Google-Smtp-Source: AGHT+IEcfU8goWRKBEJ2dNxWnUOXGjbdgDEwPlAsgt7GMXir4+lV/q9mimTAz/i+lRrRPC97zBW3/g==
X-Received: by 2002:aa7:cd12:0:b0:557:62e:240b with SMTP id b18-20020aa7cd12000000b00557062e240bmr107067edw.148.1704360840530;
        Thu, 04 Jan 2024 01:34:00 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ek20-20020a056402371400b00555f49e7080sm7218137edb.56.2024.01.04.01.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:34:00 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jan 2024 10:33:58 +0100
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Quentin Monnet <quentin@isovalent.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH] bpftool: Add missing libgen.h for basename()
Message-ID: <ZZZ7hgqlYjNJOynA@krava>
References: <ZZYgMYmb_qE94PUB@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZYgMYmb_qE94PUB@kernel.org>

On Thu, Jan 04, 2024 at 12:04:17AM -0300, Arnaldo Carvalho de Melo wrote:
> The header with the prototype for basename() is missing in the gen.c
> file, which breaks the build in distros where that header doesn't get
> include by some of the other includes present in gen.c, by luck, fix it.
> 
> Noticed when build perf on the Alpine Linux edge.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ---
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index ee3ce2b8000d75d2..0e50722588b48fa0 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -7,6 +7,7 @@
>  #include <ctype.h>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <libgen.h>
>  #include <linux/err.h>
>  #include <stdbool.h>
>  #include <stdio.h>

hi,
this gives me compile warning on fedora:

	gen.c: In function ‘get_obj_name’:
	gen.c:61:32: warning: passing argument 1 of ‘__xpg_basename’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
	   61 |         strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
	      |                                ^~~~
	In file included from gen.c:10:
	/usr/include/libgen.h:34:36: note: expected ‘char *’ but argument is of type ‘const char *’
	   34 | extern char *__xpg_basename (char *__path) __THROW;
	      |                              ~~~~~~^~~~~~


looks like there are 2 versions of basename (man 3 basename):

	VERSIONS
	       There are two different versions of basename() - the POSIX version described above, and the GNU version, which one gets after

		       #define _GNU_SOURCE         /* See feature_test_macros(7) */
		       #include <string.h>

	       The  GNU  version  never  modifies its argument, and returns the empty string when path has a trailing slash, and in particular also when it is "/".
	       There is no GNU version of dirname().

	       With glibc, one gets the POSIX version of basename() when <libgen.h> is included, and the GNU version otherwise.


I think we want to keep the GNU version declaration, but not sure how
to fix the bpftool on Alpine Linux edge, what's the exact build error?

jirka

