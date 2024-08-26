Return-Path: <bpf+bounces-38105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAAF95FC5B
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 00:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E72A1C22868
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCC819CCED;
	Mon, 26 Aug 2024 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk5UL659"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2A19DF76
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724709587; cv=none; b=O67zKMSCNKY4Umdgm0zzvoCOlCnEq3f4JIHVtZV3oLtl7QwV9eF8xp9jcOhuXI7woAEAI0JQ6J4ri3VxL2OC+c8DIh8jmka4jGcn/xseOiTYfCTZnlGcbY4IjMDbbm0McyEEx9jfYhzdKKgtcLh+Hp7XayKBSLYO+45iqYgso3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724709587; c=relaxed/simple;
	bh=4EUtIrnimvx8O0cU+uZ/uuVDE/0DOxB0MYGcMLSnXmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=az5Cdpox0z1m11TFwhPpYaOcAuvwWB+6Hxd9GDVXI2evyRed1t5CbrvC9EgXXOPGMrmOXGyNQwE4LlX5VhJHceGk0MR1xa9vxwOBldg5N2VQq1DMh3SVywSnSbVU6MndNVtyeItpBQ9ab9wq6JsaXvoce03MQ2oUc2/Q0fixxtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gk5UL659; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3da6d3f22so3737795a91.0
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724709585; x=1725314385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/elePcEcmxfgIp/KV/bGB99eZHjEDFMaoEcXKPqmEg=;
        b=gk5UL659ns0+Ks5Wi2Yj6TL9MbCuWAFuPVJYsYvucQDYxqS4JluK1zce0l4fs46po2
         L5hxagK8zTM/IGYkcBOLpgUxk3xP5nDxJfwAhFOsxst52PzI+NJ791SP8IpRX6YYi7hj
         auO/l65k9BEq2NnCYfur4+kgJaugNXqz7aObe7li95gJXDIXdwbjNu9w96RBN9mcwo1B
         McODAg88RCcCMbwCNlAnuPMs4SVpJKAzexpr5ea32caGoorMpxpBvvSjJTcwlzdNaI2s
         FdfExzK1zmBQLFMFvHoljEh3wtIjAxsW+SGo+8UQpGU7sKqcn6DqPdDKDhR0B8a9iWD8
         ua8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724709585; x=1725314385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/elePcEcmxfgIp/KV/bGB99eZHjEDFMaoEcXKPqmEg=;
        b=BmXzUf7LXF8PoDoA3b4Z5tGmOL8Tv7Ph6QR0XrFp5gO91KpIb5p2dXBFmU3JNx1+h1
         abBTQWKjrWqwM17hlAfwIh8kOoNYSwQRx/mNW0xo0iag5ndWleBwYBakOLUWbMsCeP+s
         PVDfmZHgb8nti8xb258TLklTo+OLqK2HhJ4tRDG0mHpV6yQLox2dT1FR2v70HHfmpUHT
         VdY+IBbXnxs72X+sZmQcOeaWDFfEIZ5suB6fwkOVws3HcnUV5spTpkmzR2pskqy2N8bD
         u0S/QrnbmNEPN2POAjnXN5GjppDQDCP7ICY2FY4m/CC30Lm9pi7i7An335v98tyK29L8
         H5Rg==
X-Gm-Message-State: AOJu0YwQ7qs0u5X21HerbSQ5ub4FC6lNTQReNlR79om5SY+VWWx4rGmU
	ybSU41RuGVhwCLuzGcmlZfuHZBz8MC4hxMNrYuAWepVCpMM1o4OXtDck8QS+f4tXYa2GCGoZgl1
	q7tpBBZ6czDR/Ws+ZNY5Vi8ulDrM=
X-Google-Smtp-Source: AGHT+IHvXCFwINy3SuJbphWIZ1zr7XOnOPjHORnaMtJoUgzt6X2KurpwQ6htNGOghRBwebEjh4GJEG4vxjmN+T5rohA=
X-Received: by 2002:a17:90b:8d6:b0:2d3:ba92:b27c with SMTP id
 98e67ed59e1d1-2d646d74eacmr11459861a91.42.1724709585205; Mon, 26 Aug 2024
 14:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TCvb-R45mBUJOpoW3V-tLkH2XppfNXYbkv7Ph0ae8J9MZKWFvQ3nkJw74KKMbMzzpAvbwXBwRuBmhFOtHl0-jLLrIALH-_2_Zp-MZ9pPXPo=@pm.me>
In-Reply-To: <TCvb-R45mBUJOpoW3V-tLkH2XppfNXYbkv7Ph0ae8J9MZKWFvQ3nkJw74KKMbMzzpAvbwXBwRuBmhFOtHl0-jLLrIALH-_2_Zp-MZ9pPXPo=@pm.me>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Aug 2024 14:59:32 -0700
Message-ID: <CAEf4BzaixE=-+YnowJhZMDk0SoVdZTHgx-X+3UwnJVUnXxkXzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: compare vmlinux.h checksum when
 building %.bpf.o
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"andrii@kernel.org" <andrii@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, "mykolal@fb.com" <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:06=E2=80=AFPM Ihor Solodrai <ihor.solodrai@pm.me>=
 wrote:
>
> %.bpf.o objects depend on vmlinux.h, which makes them transitively
> dependent on unnecessary libbpf headers. However vmlinux.h doesn't
> actually change as often.
>
> Compute and save vmlinux.h checksum, and change $(TRUNNER_BPF_OBJS)
> dependencies so that they are rebuilt only if vmlinux.h contents was
> changed. Also explicitly list libbpf headers required for test progs.
>
> Example of build time improvement (after first clean build):
>   $ touch ../../../lib/bpf/bpf.h
>   $ time make -j8
> Before: real  1m37.592s
> After:  real  0m27.310s
>
> You may notice that the speed gain is caused by skipping %.bpf.o gen.
>
> Link: https://lore.kernel.org/bpf/CAEf4BzY1z5cC7BKye8=3DA8aTVxpsCzD=3Dp1j=
dTfKC7i0XVuYoHUQ@mail.gmail.com
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  tools/testing/selftests/bpf/Makefile | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index ec7d425c4022..4f23d9ddc8b8 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -407,6 +407,14 @@ else
>         $(Q)cp "$(VMLINUX_H)" $@
>  endif
>
> +VMLINUX_H_CHECKSUM :=3D $(INCLUDE_DIR)/vmlinux.h.md5
> +
> +$(VMLINUX_H_CHECKSUM): $(INCLUDE_DIR)/vmlinux.h
> +       $(shell md5sum $(INCLUDE_DIR)/vmlinux.h > .tmp.md5)
> +       $(shell md5sum -c .tmp.md5 $(VMLINUX_H_CHECKSUM) --status \
> +               || cp -f .tmp.md5 $(VMLINUX_H_CHECKSUM))
> +       $(shell rm .tmp.md5)

I'm not sure what md5sum buys us here, tbh... To compute checksum you
need to read entire contents anyways, so you are not really saving
anything performance-wise.

I was originally thinking that we'll extend existing rule for
$(INCLUDE_DIR)/vmlinux.h to do bpftool dump into temporary file, then
do `cmp --silent` over it and existing vmlinux.h (if it does exist, of
course), and if they are identical just exit and not modify anything.
If not, we just mv temp file over destination vmlinux.h.

In my head this would prevent make from triggering dependent targets
because vmlinux.h's modification time won't change.

Does the above not work?


> +
>  $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids   \
>                        $(TOOLSDIR)/bpf/resolve_btfids/main.c    \
>                        $(TOOLSDIR)/lib/rbtree.c                 \
> @@ -515,6 +523,12 @@ xdp_features.skel.h-deps :=3D xdp_features.bpf.o
>  LINKED_BPF_OBJS :=3D $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
>
> +HEADERS_FOR_BPF_OBJS :=3D $(wildcard $(BPFDIR)/*.bpf.h)          \
> +                       $(addprefix $(BPFDIR)/, bpf_core_read.h \
> +                                               bpf_endian.h    \
> +                                               bpf_helpers.h   \
> +                                               bpf_tracing.h)
> +
>  # Set up extra TRUNNER_XXX "temporary" variables in the environment (rel=
ies on
>  # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
>  # Parameters:
> @@ -564,9 +578,8 @@ $(TRUNNER_BPF_PROGS_DIR)$(if $2,-)$2-bpfobjs :=3D y
>  $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:                         =
       \
>                      $(TRUNNER_BPF_PROGS_DIR)/%.c                       \
>                      $(TRUNNER_BPF_PROGS_DIR)/*.h                       \
> -                    $$(INCLUDE_DIR)/vmlinux.h                          \
> -                    $(wildcard $(BPFDIR)/bpf_*.h)                      \
> -                    $(wildcard $(BPFDIR)/*.bpf.h)                      \
> +                    $(VMLINUX_H_CHECKSUM)                              \
> +                    $(HEADERS_FOR_BPF_OBJS)                            \
>                      | $(TRUNNER_OUTPUT) $$(BPFOBJ)
>         $$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,                      \
>                                           $(TRUNNER_BPF_CFLAGS)         \
> --
> 2.34.1
>
>

