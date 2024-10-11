Return-Path: <bpf+bounces-41737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B18A99A2BC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 13:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0931C22584
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 11:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BB621643E;
	Fri, 11 Oct 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dntC6An9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68381215F75;
	Fri, 11 Oct 2024 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646392; cv=none; b=NqcooXqy/7g/obBVDIORJHIkJDGGsAbkw7MbKZCfwYu/zZC2OB6/gLCE9x18azbMjucE5PwdU38FwhxwJW2nf9xImntTFK4CIInMVjBF9odcZfaVEVH2DpdTXxz/0JfWWCMtUuOwS7UZg0XG3zQAN8O9WJ8eSQoUmKnzN03zxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646392; c=relaxed/simple;
	bh=joa4DPZm4oYmYiiqXqQkUjEeAqbS+xyOScktkS9yyKA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTiHt3Kc3TXbAIglRDBcBXXwrU1EJbNEBPe0VksofWl3E7/Ook216xhhlIKvd2lgj3Zv/9tSrNaoxwKWuoGPa6VZM2BLCdwxoymAjRwmPeX2yDlIRvmqr4C/lFJT8lUNn9cfVJYNiuWF3DIlbIkaF6j2TvWjPx1nofxIUiMoyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dntC6An9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c5bca6603aso2263621a12.1;
        Fri, 11 Oct 2024 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728646389; x=1729251189; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TrhuYtBeh8+4YkK5ubACyNqV/urk743FUpHgiUS8MiY=;
        b=dntC6An90PSCoX0oABAFCCbt/ogL9X8SbIeuC4gS1q5OwKjyr5XN03OEjqDTFmjeKh
         15r0yjhMkuKIIL7b9gwb1uLaoe5bXxNOT1QfnISF5xlHvMaguRA6OkBs2WZF0+Jr+3zU
         zhISsAMlBbty2SP0h1bT6SUliCrUab8w0bV9l1CCrHFcfiKi+WK/2sJAwcQU2JIs6Os/
         2DSs8CCp3JF3ToMr+jFhOvgFMX9sQ9jCw/cg8Y/eRwZLi/ficF55FTmD+pEZjx4nwtVD
         m4Sb1ZOVXQ3cka918Nvdqh7ME9PiADneRCu5X/FeEw2Tyf98OroESd17DLeX7x7dCRqR
         bpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728646389; x=1729251189;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrhuYtBeh8+4YkK5ubACyNqV/urk743FUpHgiUS8MiY=;
        b=lsACrtnzl1B63nLc0QVvIMKe3dKcBkfG5OcW7kn4NspwegV2EiUOF1VGbu1qS0MRJK
         yx4mBKnxAU8nV4O32ymDj/pqQqp8r3NJVLh7urWJINk43bhsWJYLn64RIyEr6lLn1hAr
         8goj1oQqziQU7ywdJhIyDKVpFhpTKEyqEzlwkgoGg/RKwNZr6piG/fIzA6pevMUYoD5T
         EKvZqzH1GGN6IKkWRf89v2cY2Siayr6KhX/W9O15Imh6bT0DG8YUGqJ7/UzvWjzUQdmP
         fNP3SVV/WM3jaG1qKjKXjDrzVYycySFyU5d+CAwzkAXWEILC3fGQxunfRWkR6r1yJqGX
         4jIw==
X-Forwarded-Encrypted: i=1; AJvYcCU7f70f0vhh6SEc2RxbsT88hnJn6xcC3DlijykOTdOY3dpi4itOU03orBlkq658j8SZIj8=@vger.kernel.org, AJvYcCW7ljT7T4+0cnGwVdeeJvxwTjUjYSfdJBX6MCGb8V2jbbJqMIj3OrY2wWCEnilTp1qqBTqs98CIfXJFeSy1@vger.kernel.org, AJvYcCWml9XZW8949qZJoIbOy4QGqaIlQO+UczgS65U3szkCrkJvEmKQWTpgFysydkHjEwutiL0fUAVTixPNOKNHrn9wsN8w@vger.kernel.org
X-Gm-Message-State: AOJu0YyFyTAw1qO3/DAsqaGGPpUyNCafBoANWmgqDjJu84mNOiHknCMQ
	RHBO8/xiu82wbKXvVBIH0FrmDImxcw6ePpCo8f3J3scecjQjABiM
X-Google-Smtp-Source: AGHT+IEIO6w7uhABBoGQyTIuvh6e52MLg6vz8U0fGIyJ4C0CU8hwMls+NdZ6UmX4/YhT7ofO59/8bg==
X-Received: by 2002:a05:6402:4410:b0:5c8:8668:e564 with SMTP id 4fb4d7f45d1cf-5c948d79b88mr1397773a12.30.1728646388513;
        Fri, 11 Oct 2024 04:33:08 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93729676dsm1838383a12.87.2024.10.11.04.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 04:33:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 11 Oct 2024 13:33:00 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv6 bpf-next 13/16] selftests/bpf: Add uprobe session
 single consumer test
Message-ID: <ZwkM7MJKnQUDX6nX@krava>
References: <20241010200957.2750179-1-jolsa@kernel.org>
 <20241010200957.2750179-14-jolsa@kernel.org>
 <CAEf4BzY9pp2bQXBwxcS4qLoPRRHrsKjA1UWdpZi3inkuz0PCDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY9pp2bQXBwxcS4qLoPRRHrsKjA1UWdpZi3inkuz0PCDQ@mail.gmail.com>

On Thu, Oct 10, 2024 at 07:25:59PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 10, 2024 at 1:12 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Testing that the session ret_handler bypass works on single
> > uprobe with multiple consumers, each with different session
> > ignore return value.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 33 ++++++++++++++
> >  .../bpf/progs/uprobe_multi_session_single.c   | 44 +++++++++++++++++++
> >  2 files changed, 77 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
> >
> 
> see the nit, but regardless:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
> > new file mode 100644
> > index 000000000000..1fa53d3785f6
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_single.c
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <stdbool.h>
> > +#include "bpf_kfuncs.h"
> > +#include "bpf_misc.h"
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +__u64 uprobe_session_result[3] = {};
> > +int pid = 0;
> > +
> > +static int uprobe_multi_check(void *ctx, bool is_return, int idx)
> 
> nit: you don't use is_return

ugh true, thanks

jirka

