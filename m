Return-Path: <bpf+bounces-3546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A643273F7ED
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 10:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D782C1C2029D
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 08:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACFC16436;
	Tue, 27 Jun 2023 08:56:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B3B8481
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 08:56:56 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C30610D7
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:56:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991fee3a6b1so125301066b.0
        for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 01:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687856213; x=1690448213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYgpTiJom9vTkRE0jx1R8WBPCb88VK4slYOWvHxvlgw=;
        b=hrowBFAGh0MRWzInnCwWpZB7vWCnOx6Exj+2+1COfmutUEowgDWy8Qm9363nUWClSN
         4lO4g6lQYYAC4L+x5901zXXz6GDmsg67Et9c5oKIIcwPWyNwAQAgv7qz5XGTOSGU7x2m
         O7H9TB3HA5SjPH77qgt4YsAF3ZxPyVM//gC9IUcGlSo93SpTxp4bFndaI3dWt5zUpVGF
         80a64BDoif9t78NXY284ceMfSDXej/oSuvjDEbdjlQm8ayBXbz/u/koQOVawySotBgWK
         WOflccXgz5A/vpUDAhduA1kKzN7BuTxflAzd+rGeAj/kBSLXX2fWbNteGY1cbYgWjLfV
         5Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687856213; x=1690448213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYgpTiJom9vTkRE0jx1R8WBPCb88VK4slYOWvHxvlgw=;
        b=YYY98zdAStvxhqliwMfXxdDEeuuvcL518oyvCvaH9JEGenjrCdIFWxoKEYz34JFfzu
         lIK0HvKS9Cc+ar9ad0SPlONe3kmFBG2d75MnGsuJjwywZjeIsEZIXmvrjZTMYl+VUUpH
         aRAeVsTZ0VdpPqDwcmAJlLis2qNHkX4YPOc8XB8M+uqWSi2lYserNzke/IKMeQw8qT6l
         N8hfkwTygf8lvNkxUUEH/vOECASRg5e1RQGv7ZVPzjal23kCAyjzRMMsOIBGEdpGY19o
         tT6WZCb1ZFn3vFgJt0gm3v4Zi+1Pggwc681ck/qzA3jeiMFCUL8zoJqMTEkowIjMWHmf
         sPcg==
X-Gm-Message-State: AC+VfDxktyagrwvrMX4J2ZnGB3NdSdpeaxfD2AKyhzHDxU8LFmas81Ia
	vFnw/28GG8QHyB3m+Ss3pCW+kSP4FER7bqPq9fcAHA==
X-Google-Smtp-Source: ACHHUZ4ZVIMQkP0IyNc/KDl9+luEXaR/1YGktg1CgYACrmeJFMiuBR2LziRDdqD2wJwLA+J4q+XtA1Q+I2fh3u0l9xA=
X-Received: by 2002:a17:906:684c:b0:98e:4c96:6e16 with SMTP id
 a12-20020a170906684c00b0098e4c966e16mr4864925ejs.5.1687856212807; Tue, 27 Jun
 2023 01:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230613-so-reuseport-v3-2-907b4cbb7b99@isovalent.com> <20230626173249.57682-1-kuniyu@amazon.com>
In-Reply-To: <20230626173249.57682-1-kuniyu@amazon.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 27 Jun 2023 09:56:42 +0100
Message-ID: <CAN+4W8hnPzhuKPorSjHeOQHFgAuk=A9oa1hW5jckUPoF=5zEQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] net: export inet_lookup_reuseport and inet6_lookup_reuseport
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com, 
	joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@google.com, shuah@kernel.org, 
	song@kernel.org, willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 6:33=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Lorenz Bauer <lmb@isovalent.com>
> Date: Mon, 26 Jun 2023 16:08:59 +0100
> > Rename the existing reuseport helpers for IPv4 and IPv6 so that they
> > can be invoked in the follow up commit. Export them so that DCCP which
> > may be built as a module can access them.
>
> We need not export the functions unless there is a real user.
>
> I added a deprecation notice for DCCP recently, so I bet DCCP
> will not get SO_REUSEPORT support.
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3Db144fcaf46d4

Misleading commit message, it turns out that ipv6 as a module also
needs (the v6 functions at least) to be EXPORT_SYMBOL'd. That's
because of some special shenanigans where inet6_hashtables.c is linked
into vmlinux even when CONFIG_IPV6=3Dm.

Also not sure how to work around this: DCCP may be deprecated but
without the export a module build of it fails.

