Return-Path: <bpf+bounces-5823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FA57619B4
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 15:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681381C20DC5
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 13:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808BC1F921;
	Tue, 25 Jul 2023 13:20:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F71ED54
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 13:20:28 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F2B19BF
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 06:20:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99364ae9596so944982566b.1
        for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690291200; x=1690896000;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=/AN1YHLUYuWO5atontjFpAIVd9Zt4nVgfXmFEwZMLzU=;
        b=d00/nGb5if1lMP2Y7kVokEl1WMecpTb066F1Bn0/tUZ6XRXXfatJXIV2ekVmu1BdyI
         RwTbNk3xgFE+kMdJDUUJIvzRmY8BGR9ujCiLf7X9H6fQvU6G3L0a1sHgdCQzMZmzf3Y0
         Pk2AgMMB3kLb7+PHb+AH9a9SMpJK/LMcGynzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690291200; x=1690896000;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AN1YHLUYuWO5atontjFpAIVd9Zt4nVgfXmFEwZMLzU=;
        b=l69+45fqpniWJOZbyDKqFOt5fVblpDF/zD1hxXJtDBMAcoaoWYCL2W+TbWV0BYNKZa
         7pOS3w0xjXEztPI+6cpU6ulS6seZ3DRr53ES2qfW+5niaecmFFsF0bfxAe/ZIAPymCc4
         5QY4H55Kf+G68620NsgG3LN1NjHmeNeTctkz8ockhvufx0zrkxs7m5sNeZMeq1fQLNcK
         suHKUbsNMSOlBidHsqsgjq6jxyRb8NOKvJVX7RaP8CBz6Q6PMOqURCh1t9V4ocJhSzJA
         1Y9v2MikttrMWOoN3hYCtyd2Xznt5O0OKqHZvpdJ/q6xXSanptWB+09E3gO169XI7dU7
         mKDA==
X-Gm-Message-State: ABy/qLbVrcMG3LGTwlbAkTZtQi8uSSqL9WRH0RAKZAH1T4BmnGTHFaAo
	GUoRjIp/HieS6SPNC4ZZnzrzSQ==
X-Google-Smtp-Source: APBJJlExKo+MISIorbKqmmXFqOZx+fFkcFbM3faOMvOhcozXsTgxolJpBU64M1xQar434N5lKWU4nw==
X-Received: by 2002:a17:906:8a67:b0:994:673:8b00 with SMTP id hy7-20020a1709068a6700b0099406738b00mr11175043ejc.12.1690291200175;
        Tue, 25 Jul 2023 06:20:00 -0700 (PDT)
Received: from cloudflare.com (79.184.214.102.ipv4.supernova.orange.pl. [79.184.214.102])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906039300b0099364d9f0e2sm8239882eja.98.2023.07.25.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:19:59 -0700 (PDT)
References: <cover.1690255889.git.yan@cloudflare.com>
 <25c13cb89412b120616f4e31a31c3108e45bc6af.1690255889.git.yan@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Jordan Griege <jgriege@cloudflare.com>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH v3 bpf 2/2] selftests/bpf: test lwt redirect error handling
Date: Tue, 25 Jul 2023 15:18:58 +0200
In-reply-to: <25c13cb89412b120616f4e31a31c3108e45bc6af.1690255889.git.yan@cloudflare.com>
Message-ID: <87r0owxh4x.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 09:14 PM -07, Yan Zhai wrote:
> Tests BPF redirect at the lwt xmit hook to ensure error handling are
> safe, i.e. won't panic the kernel.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  .../selftests/bpf/progs/test_lwt_redirect.c   |  67 +++++++
>  .../selftests/bpf/test_lwt_redirect.sh        | 165 ++++++++++++++++++
>  3 files changed, 233 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
>  create mode 100755 tools/testing/selftests/bpf/test_lwt_redirect.sh
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 538df8fb8c42..e3a24d053793 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -66,6 +66,7 @@ TEST_PROGS := test_kmod.sh \
>  	test_xdp_vlan_mode_generic.sh \
>  	test_xdp_vlan_mode_native.sh \
>  	test_lwt_ip_encap.sh \
> +	test_lwt_redirect.sh \
>  	test_tcp_check_syncookie.sh \
>  	test_tc_tunnel.sh \
>  	test_tc_edt.sh \
> diff --git a/tools/testing/selftests/bpf/progs/test_lwt_redirect.c b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
> new file mode 100644
> index 000000000000..622c6b1e7128
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#define ETH_LEN 14

Nit: We have ETH_HLEN in bpf_tracing_net.h defined.

[...]

