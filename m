Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41B147A35F
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 02:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhLTBvP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Dec 2021 20:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhLTBvO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Dec 2021 20:51:14 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF741C061574
        for <bpf@vger.kernel.org>; Sun, 19 Dec 2021 17:51:14 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so8845390pjj.2
        for <bpf@vger.kernel.org>; Sun, 19 Dec 2021 17:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g4cdQJ9hh6uhes2GwjNmddjdKQ+eB9+wVtZg8220UF0=;
        b=XiYST35dTZCJ2oK+BAhTl0W4aiwAjdRPF3BcAbF1Kms7D3c6ucC7P35nqgj5vVji0e
         fOVkOaPVgSbxrDJsNYdj3SWqhEqaoAhUY47/X6fKv2JSY+YzGdVN50NQ1Ai8lUV2AJiV
         xxcVOBKAR5kdOiDAt9xnc3V85Rscg1MGtOqKKp09PrcnOEw9tBUotQKlVMulGLDBV7Jc
         8Fe4hF7dkwzpgKHNg7yKyJv/m6Ru7D2BUiiT+K0K44r0S56VCdVnSog3c+SnBRcOaL3D
         C02rw/4+YH+1+7ZRvH6rg8Rl58ci15BB2YHoxSSB5Gqr8aZt9DBw53o3gzQu8ysqnXip
         Z+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g4cdQJ9hh6uhes2GwjNmddjdKQ+eB9+wVtZg8220UF0=;
        b=eetHhTf8m6pnXmQgR9whKoOI/nZmWFA8L6xrK88vgUuejxUxpyh8l8oclfLNYdwbxd
         dtZxpx4UyPumZnQUTpPEvs52n3HiJKTJlxU0Xlxpc2tY0th/jzEXY64Dy9aPXEJCMfGH
         8PVXsd2ilfa8C5DllKuFZAnCD6/W63IqdSxh5li+mdYyqzHCNYXEnQrdhXrIS0qjIUdq
         swby0OM/ueDKWtzuYo7rQVsp3yGlbH+haX8L1Fz03O5U0tUiIf58plqVpwY1PPqQ0AWx
         KfHWbWNWkJU9gwVnat2znLq7Uilw4P73tuGtwCMJZdB4TRzA7bbw3giPxwWcbk9KZfqI
         /Yiw==
X-Gm-Message-State: AOAM532QCdIE5gDIssb97mzfKK1IHz5s8ATFVT/Hq2oqKlD1tq0O4OF/
        jRj6pyGsuCKdJL4DLYK1QDU=
X-Google-Smtp-Source: ABdhPJyGrGxdRMf4qhFp5d+rwt+TE0C5EqaKNB57GIza0bqIy1tW5dgtV/FMtEcUaZMcG0ZV20EYMw==
X-Received: by 2002:a17:90b:1284:: with SMTP id fw4mr14770962pjb.45.1639965074246;
        Sun, 19 Dec 2021 17:51:14 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:9150])
        by smtp.gmail.com with ESMTPSA id z4sm17290857pfh.15.2021.12.19.17.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 17:51:13 -0800 (PST)
Date:   Sun, 19 Dec 2021 17:51:10 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: add a selftest with __user
 tag
Message-ID: <20211220015110.3rqxk5qwub3pa2gh@ast-mbp.dhcp.thefacebook.com>
References: <20211209173537.1525283-1-yhs@fb.com>
 <20211209173559.1529291-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209173559.1529291-1-yhs@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 09, 2021 at 09:35:59AM -0800, Yonghong Song wrote:
> Added a selftest with two __user usages: a __user pointer-type argument
> and a __user pointer-type struct member. In both cases,
> directly accessing the user memory will result verification failure.
...
> diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_user.c b/tools/testing/selftests/bpf/progs/btf_type_tag_user.c
> new file mode 100644
> index 000000000000..e149854f42dd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/btf_type_tag_user.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +struct bpf_testmod_btf_type_tag_1 {
> +	int a;
> +};
> +
> +struct bpf_testmod_btf_type_tag_2 {
> +	struct bpf_testmod_btf_type_tag_1 *p;
> +};
> +
> +int g;
> +
> +SEC("fentry/bpf_testmod_test_btf_type_tag_user_1")
> +int BPF_PROG(test_user1, struct bpf_testmod_btf_type_tag_1 *arg)
> +{
> +	g = arg->a;
> +	return 0;
> +}
> +
> +SEC("fentry/bpf_testmod_test_btf_type_tag_user_2")
> +int BPF_PROG(test_user2, struct bpf_testmod_btf_type_tag_2 *arg)
> +{
> +	g = arg->p->a;
> +	return 0;
> +}

This is a targeted synthetic test. Great, but can you add one
that probes real kernel function like:
getsockname(int fd, struct sockaddr __user *usockaddr
or
getpeername(int fd, struct sockaddr __user *usockaddr
and the bpf prog tries to deref usockaddr ?
