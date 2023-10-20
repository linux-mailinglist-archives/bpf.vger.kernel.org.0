Return-Path: <bpf+bounces-12792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE27D07AA
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 07:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83296B21511
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 05:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C680E63C2;
	Fri, 20 Oct 2023 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4D612B;
	Fri, 20 Oct 2023 05:38:59 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11381A4;
	Thu, 19 Oct 2023 22:38:58 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-577fff1cae6so333444a12.1;
        Thu, 19 Oct 2023 22:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697780338; x=1698385138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phGwGA8YItZvt4Th8CLkdVIJnpS0jaTYB4A+4FYmn78=;
        b=BbQwS/HzPLEU4rsb0XwXKJqg0beOABNQTbC/mbGr/dPmjsvRxz148Rt9OdTHPfWOMI
         90B/ZH4HTMjNfQiS7z2DqrT8Eyl5MTxDkVy9Uvjn9bedKXEVDsa1eTD76KnK1zb8FeB6
         2Nh46vGY6sLcVCa6jqYs8yykwJezfiXrU5aMUGRA1Z38EZtBbWcsDbm45GndoEuzqccQ
         l6iRVeqmMDAVRSRqM0ETIGyZ/UR2XVQ+Y5fQlB7kIrQ+ntixiKXQ+puZs2lO8NAAIrjY
         ukzMxSk+RTvLC16Eu1cMb69ukH8fBQVN7vhrw9tIDfBxGJ6b63mBh3cLmsXHaiST+jaG
         3C7A==
X-Gm-Message-State: AOJu0YzVVIerwBgYxfAMOSzbANQU0QyzvHAhjS8jmN3KJs20g9+J74fi
	96sS4TQwBZ8djqmiViD+yT2zw5Y1B9UDAHD06Aw=
X-Google-Smtp-Source: AGHT+IErBkBy/5ZMJ07P28ZG3olnME3S+coyI4bEZzJOk0Op0i6ln5Bq1mBsvH8/IxI4ziGMlORl9vQn0EbZ1Rr5xEY=
X-Received: by 2002:a17:90a:e409:b0:27d:1126:1ff6 with SMTP id
 hv9-20020a17090ae40900b0027d11261ff6mr6054838pjb.8.1697780338260; Thu, 19 Oct
 2023 22:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231008212251.236023-1-jolsa@kernel.org> <ZSVLI7yXFHCXqVJp@kernel.org>
In-Reply-To: <ZSVLI7yXFHCXqVJp@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 19 Oct 2023 22:38:46 -0700
Message-ID: <CAM9d7ci0XOGMC38+X9eUc2p8jigvGwSGPhafA-yxbuaWJsv8qw@mail.gmail.com>
Subject: Re: [PATCHv2 0/2] tools/build: Fix -s detection code for new make
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Ian Rogers <irogers@google.com>, 
	KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 6:01=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sun, Oct 08, 2023 at 11:22:49PM +0200, Jiri Olsa escreveu:
> > hi,
> > this fixes the detection of silent flag for newer make.
> >
> > It'd be better to re-use the code, but I don't see simple
> > way without more refactoring. I put that on my todo list.
> >
> > v2 changes:
> >   - adding the change for tools/scripts/Makefile.include as well
>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Applied to perf-tools-next, thanks!

