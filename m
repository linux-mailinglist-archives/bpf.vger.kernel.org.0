Return-Path: <bpf+bounces-8084-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3629780FBA
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195D61C21639
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B519BA2;
	Fri, 18 Aug 2023 16:01:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACCCEACB
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 16:01:22 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670573AB4
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 09:01:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-528913c261bso1024097a12.1
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692374480; x=1692979280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPSQswlPfK/vg9tOIqV/BRlfCJnThjbbuWXP5dIGjVI=;
        b=eOS2hRxp7rH6eN6beKT9AhAtjWCJ5/IIE38A9lAemUFzSEY32ryQpxC0ZiY3D0m02E
         PPS/OljShi5fMfsQx+jB4P7wJ7+vIirfIJ9Ur8GkSfA3V4seJkEwxcZCb09xFsoKsUpA
         k9uSRlnUVjxiRqD9XaByBe/my5BTdzDGSUdko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692374480; x=1692979280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPSQswlPfK/vg9tOIqV/BRlfCJnThjbbuWXP5dIGjVI=;
        b=ReE5hYlxupbljxagwmPTJN32g3L9eQ2D2DWB+6eO/0KWOSIRNK14Rz2r7sIzXThDUL
         nBZievp2IVL5jfw0So8HMKswvFKk1z7cjqjk0Ega2ckYrgbxNEqL4H+XjqXNaZbtVgek
         /7AhOy4+eMSyaqLwJoTYmFSsr1IfQXC/PVQUR2XEgkwqnmLkHsGeeaqHmZzbTLPlVirX
         uaemIC8YxTm9t3dpOGz4waKC0XLCt18CgcUQgQW+V/jRmRE4lzcm9atAaz0XsOR0Okor
         wPBXSdEgi+w4/FiIbopp/uPmHq/HywcqdcM4bMJZgQMBoh2zI/+9FN0QW8YiuDg3ltz2
         zmNw==
X-Gm-Message-State: AOJu0Yw4hrop1xVMJl9+Fk99LkfFWPOQbSBm5AtrLNwzRNEQrNSbpecU
	8DKjxB3nB18zsXpzvxUpcJx7j/USX8z4lXY3AwNkUg==
X-Google-Smtp-Source: AGHT+IETP5rhdlK0N8SmshAKeFLK5w4xJiVCwhN2jNxLEpXbo/8uRFpY1Jr3KAeX1Do2SnfodkpwHGfpUEuEI5hzDks=
X-Received: by 2002:a05:6402:10c5:b0:523:4996:a4f9 with SMTP id
 p5-20020a05640210c500b005234996a4f9mr2776349edu.34.1692374479880; Fri, 18 Aug
 2023 09:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1692326837.git.yan@cloudflare.com> <10b3dff2-7be4-ab98-e4a5-968ebb93c25f@iogearbox.net>
In-Reply-To: <10b3dff2-7be4-ab98-e4a5-968ebb93c25f@iogearbox.net>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 18 Aug 2023 11:01:09 -0500
Message-ID: <CAO3-PbqUczUxg42ECStsZnAybYKBY-hJePN=V-JbPvq-BS4cGA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf 0/4] lwt: fix return values of BPF ops
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Thomas Graf <tgraf@suug.ch>, 
	Jordan Griege <jgriege@cloudflare.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 18, 2023 at 9:55=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/18/23 4:58 AM, Yan Zhai wrote:
> > lwt xmit hook does not expect positive return values in function
> > ip_finish_output2 and ip6_finish_output. However, BPF programs can
> > directly return positive statuses such like NET_XMIT_DROP, NET_RX_DROP,
> > and etc to the caller. Such return values would make the kernel continu=
e
> > processing already freed skbs and eventually panic.
> >
> > This set fixes the return values from BPF ops to unexpected continue
> > processing, checks strictly on the correct continue condition for
> > future proof. In addition, add missing selftests for BPF redirect
> > and reroute cases for BPF-CI.
> >
> > v5: https://lore.kernel.org/bpf/cover.1692153515.git.yan@cloudflare.com=
/
> > v4: https://lore.kernel.org/bpf/ZMD1sFTW8SFiex+x@debian.debian/T/
> > v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.com=
/
> > v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/
> > v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/
> >
> > changes since v5:
> >   * fix BPF-CI failures due to missing config and busybox ping issue
>
> Series looks good, thanks! Given we're fairly close to merge window and
> this has been broken for quite some time, I took this into bpf-next.
>
Thanks Daniel! Can you also queue this up for stable (or guide how I can do=
 it)?

Yan


> Thanks,
> Daniel

