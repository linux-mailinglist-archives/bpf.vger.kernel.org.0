Return-Path: <bpf+bounces-20387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 989FA83DA04
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 13:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC7B1C246C3
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 12:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3CE18E2C;
	Fri, 26 Jan 2024 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EMdFCWB0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C051AACB
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706271328; cv=none; b=aeIf204C5sya7gRE86O0DPVi8UsEJwtXOUBstdjkLWA3hj9+ANcZkBNBh2JcjXx+bDPz8FNcKFnFcKWCcFBbqIwcpxzzEG7kFD9g+rUHk5X9+WlzzhrwAiNYknztBvW3jp1JbaDcwYjLGbGpg2+13Hga4KDRve/Qb0A8V6hRXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706271328; c=relaxed/simple;
	bh=fbgnSuEDq4yZ2oab4j9FKn4DHDK/uK6wjYVdZrZXTu4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=steNQFXYscDTfvNH9VLdsMgOC8Cq7RRNdE63tkBagdeCxD6mXDBzq8qSFm1m/b/TpH45IIegIIX0H+hTtOscunlt9jiFKkyHy1gQqEnsxLev9VSHtNICOi/9LLsAaHzwFA5AHwvOExk0zIdkAjKbA2q7lsoBpa9EWHBPzVZmGjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EMdFCWB0; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf4d2175b2so1422401fa.0
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 04:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1706271324; x=1706876124; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=p8LgSqtsrclfUPE1AEJuJvnVIk95Hq3D0gULKZeCF80=;
        b=EMdFCWB0cBH77hlFVH/GZQ9GjBOhwcgcejp3+/5nOSxuPUsDEI4t6WAeQSibkX0TJP
         77XzQ2uSp2qr9uyv3soEAy/FofuYUf3jt3y/O5/ojK0MoTqX91DMQtBs28jhjea2OigM
         I06l8nc3qA942dXNpKBct/sGvod4gzgGt2OmX4aH9I+x59pxq2+F8T+LmGgW+4sLSyNq
         DxPyzvS5duUTMEtsPaucSxWOSTir/Rkkuhli0oQyqebvszsK0qX4K7pBtt2NmzdqKyZ7
         enxbQ2XiI7wSzWWwxvympgP2ASA4bCTaHBdbTIc0afZchas0csVEfm8xbRdU7maZxkBB
         oj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706271324; x=1706876124;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8LgSqtsrclfUPE1AEJuJvnVIk95Hq3D0gULKZeCF80=;
        b=TiTktxLBWF7OmMXC3w98z3ULs+Uk+6lsQhhx0oIKtwPM6WTjn4+wjmcb+nOpeu6piB
         90PCtJSTcJDr0dEQsij6eAmLIkV/ZXyxF5QXFoWndmR1eYG6iyPDhmaA7Jj8biG70JIB
         +wI7nAZJ4SsY5q+x6cuxbBvfISYHREgh/REMnJzTErAtFGw6ODILCJ5nSEyBLVT/9K+4
         h5DKWcqwBSuK16hXSUIpaAyXEa+alHp5TFlFs8t+7lZUCwZudnQcH++Jt6Rqa07idLER
         5KOGw20rFhA88ubToVZjYpSH7RukT/TPSkDiDf1TtczG2AvDAm/MDTm2po4p+ZxsPYe/
         KSQQ==
X-Gm-Message-State: AOJu0Ywj0VL/iRK9de72kyk+mUypetMGoOl8RWYHl5VPR/q7OOY3Bp56
	NDrLqWQNarnaI7qpHH1XjfaipEhlM+QECCmRMrY7g1eR6bJycbCaxP1Av0YUNH4=
X-Google-Smtp-Source: AGHT+IFAlNc2olx6Jj4QN3KqphTSXrvFmXP/TkWnLkGSVEdoA7UmRd6XF4DQjJfWOZRsQ4U1eLBteQ==
X-Received: by 2002:a2e:9417:0:b0:2cc:6666:168d with SMTP id i23-20020a2e9417000000b002cc6666168dmr465996ljh.69.1706271324376;
        Fri, 26 Jan 2024 04:15:24 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1a2])
        by smtp.gmail.com with ESMTPSA id m3-20020a50cc03000000b0055cda996b63sm522879edi.20.2024.01.26.04.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 04:15:23 -0800 (PST)
References: <20240124185403.1104141-1-john.fastabend@gmail.com>
 <20240124185403.1104141-2-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, andrii@kernel.org
Subject: Re: [PATCH bpf-next v2 1/4] bpf: sockmap, add test for sk_msg prog
 pop msg helper
Date: Fri, 26 Jan 2024 12:48:45 +0100
In-reply-to: <20240124185403.1104141-2-john.fastabend@gmail.com>
Message-ID: <874jf0ffza.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24, 2024 at 10:54 AM -08, John Fastabend wrote:
> For msg_pop sk_msg helpers we only have older tests in test_sockmap, but
> these are showing their age. They don't use any of the newer style BPF
> and also require running test_sockmap. Lets use the prog_test framework
> and add a test for msg_pop.
>
> This is a much nicer test env using newer style BPF. We can
> extend this to support all the other helpers shortly.
>
> The bpf program is a template that lets us run through all the helpers
> so we can cover not just pop, but all the other helpers as well.
>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  .../bpf/prog_tests/sockmap_helpers.h          |  10 +
>  .../bpf/prog_tests/sockmap_msg_helpers.c      | 210 ++++++++++++++++++
>  .../bpf/progs/test_sockmap_msg_helpers.c      |  52 +++++
>  3 files changed, 272 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
>

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> new file mode 100644
> index 000000000000..9ffe02f45808
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_msg_helpers.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2020 Cloudflare

Thanks, but we can't take the credit for this brand new file ;-)

> +#include <error.h>
> +#include <netinet/tcp.h>
> +#include <sys/epoll.h>
> +
> +#include "test_progs.h"
> +#include "test_sockmap_msg_helpers.skel.h"
> +#include "sockmap_helpers.h"
> +
> +#define TCP_REPAIR		19	/* TCP sock is under repair right now */
> +
> +#define TCP_REPAIR_ON		1
> +#define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */

These defines are not unused by this module. Copy-pasted by mistake?

[...]

> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c b/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
> new file mode 100644
> index 000000000000..c721a00b6001
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_sockmap_msg_helpers.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2020 Cloudflare

^ :-)

[...]

