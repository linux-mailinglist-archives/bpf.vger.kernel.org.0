Return-Path: <bpf+bounces-71482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FDFBF42CC
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 02:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A1018A5D4C
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C443192B90;
	Tue, 21 Oct 2025 00:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuKjQZn6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470C1CFBA
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007541; cv=none; b=Y5N6guoZfkIklIREc2SI/O1xsVIcJLRmRNnktt/hnR9B7ERBjmAHB/JYUahdLFC+w6FDpFk1ZGlHsi2fl49pheY9DUckYm6zwn+Uki7dGBkrcE4SyjZfguxL9dYB57EI8ko4MeYsCFE4wdADkmxN5IZRxb9swDR4uL/kJMbJmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007541; c=relaxed/simple;
	bh=8Y2+DBXYnAd4vxzfFfBK9bdR25Y+Ty9LsPn5SbPQ2Lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vihvl9AYg2UuA8CCGmtpXGjc4AvlyS08OXO3uBME8wFvX6rZ6b0ohK/RNbKIcYe1TMByhOopNkKpK+fqHFBk4DVqVRE6wxVLim7jClbRLB8oRFhLxpbn1LSA6DVEmLZvZOAKhTey/ZySftQVZIz01wtn63l9X8tnhBkTFSZDxNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuKjQZn6; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b62e7221351so4108962a12.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 17:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761007539; x=1761612339; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1Ez4DDzozi6seAPB2pIdPfWZEN65nYzxbvA2bkq/2o=;
        b=OuKjQZn6UF4mCR3TUEVdGzpLdIMcSboDr9ZiPaiKM0UoNacdz5syxOdUaQRyPRucA5
         L2aD/VcXm0uqp4SrW+AF3YpJ4eGNINc9FONE3iKSPPBwJcgL8HeZiRa1z97C2x0QSKq3
         xTF4e6NgDL1XG9apyqqm/ZXsMjXtVJ/P3bPipXgCcJOLWM1qFbKpVGf/nZVtfBVL4hZD
         IndRq/ieUb3naGtUDTvn11yDjxaqYeAGPqhZOuL63B9NPmSMAt9tvCZwwC/yW9ql8rX8
         RBGNrsdqHp/AhE3lotTe2q9KesG2LVtQL/0R1B9H0xHlMOWsPBxE1vgFwAEpWUu2m552
         /HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761007539; x=1761612339;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1Ez4DDzozi6seAPB2pIdPfWZEN65nYzxbvA2bkq/2o=;
        b=spJBxmAon4jGS3uPHQdh7CJEY5JUCOQrHk4jw2YjGHRyFrTG1zK1m703xlNJ8Ibkfh
         5o+pyYYPF7FATulojKxm7IhIsF1eyDDpY52B6AeDbpHaXtP9GE/XpmlobfhqEPBaYJ60
         MwN+ycVmmMHjssS7+VCnnZ4KQWCHDHFWSoyoyrrtO1movSu36bmEIuGlTlgdzlDy/mX8
         QeiWtWpuVfNDAytsIXmZZtdUmbHtuRuOiZGVMgUVpOZ9ZlrX3Dp87E9kaoKFQ0ESmc5V
         wmtdgktZ87gNL49a+ajda8Rqtg470E6uLyKAt4T41PkjbHC5FF/2wE/rW/CZQnBH4GNw
         Dx4w==
X-Forwarded-Encrypted: i=1; AJvYcCWV4AhE+Lz9s4ju/O2i3xcDMdwEQeQVKZ65AdKgI9z0UajJy4ku9mOrDnyicoCqkEtMeUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMq6Y2Toj4AheesvJGV0wfpA/l6UvVsgYF3lA1IP3Kmg/Wxvq
	Av+rd7cOHLASkR+6GvIsfXJjl5azEklQPL4KhQlRZN4XBez43GQDQ5zC
X-Gm-Gg: ASbGncuqEAXEgil2ryZ5gHIiwU+GDwCC72XtP8kLnHHrFV8cX2tGO88H2aLCPNEIuTU
	hv9MtoWC7SPCvC0rV/FvjDzneTZO1nN697H16/xYvdRGCerhSDhmy4I/cA8IZ50MjxUxAtlpgO3
	T8BeLn9ahVLZnZ0yxKQS2G6EuhC7YIM2IgtH8MQxhJOVQWyMDE11Kve+xivAOgTtq1rnQhYE6Sg
	AXzYcBP5agUzVnwZj6q1QJOGmRkJk8WNaAiYI0/s8rRiCK9fx+pbYhuXFMDPJohdi7TdWCZzY+V
	Ih8BNYcQ0tcgymME13sPa2x4eki9WJDoAkeuaxrrQDO5vCfHh9yPNyqW7bS/9GESMIIS3y8YUl2
	jp3AjJXHITUN3ZR+71NpNE54BAx1+++5FEinJjB+vphrJh11V4VKa4UHP/Bx2WE+PAnQNstMVGu
	EUoPMkdMNyeWzFQ/y+29M3a+usMw==
X-Google-Smtp-Source: AGHT+IEdcAoecaRMBAOt6HCRcZZz2XhMx3iXeJC0UpkmFuHmHLGR5lxiGyws6hGWbtm9ABKLYffDbw==
X-Received: by 2002:a05:6300:2408:b0:334:a23e:2dff with SMTP id adf61e73a8af0-334a858f4e4mr14936318637.25.1761007539532;
        Mon, 20 Oct 2025 17:45:39 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:badb:b2de:62b2:f20c? ([2620:10d:c090:500::4:1637])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2301231a9sm9614789b3a.74.2025.10.20.17.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:45:39 -0700 (PDT)
Message-ID: <006a3fe8ca7072ac35e083ee070408d9a12eadfc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 10/10] selftests/bpf: add file dynptr tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 20 Oct 2025 17:45:38 -0700
In-Reply-To: <20251020222538.932915-11-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
	 <20251020222538.932915-11-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 23:25 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Introducing selftests for validating file-backed dynptr works as
> expected.
>  * validate implementation supports dynptr slice and read operations
>  * validate destructors should be paired with initializers
>  * validate sleepable progs can page in.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

[...]

> diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/test=
ing/selftests/bpf/progs/file_reader.c
> new file mode 100644
> index 000000000000..695ef6392771
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/file_reader.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "errno.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, int);
> +	__type(value, struct elem);
> +} arrmap SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_RINGBUF);
> +	__uint(max_entries, 10000000);
> +} ringbuf SEC(".maps");

The test case lgtm, but a question: will it be possible to use an
array map instead of a ringbuf?  Just to avoid the need to allocate
and discard the pointer.

[...]

> diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools=
/testing/selftests/bpf/progs/file_reader_fail.c
> new file mode 100644
> index 000000000000..32fe28ed2439
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c

Thank you for adding these.

[...]

