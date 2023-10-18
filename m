Return-Path: <bpf+bounces-12573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB647CDDE8
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 15:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97ED8281DA0
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922B836B06;
	Wed, 18 Oct 2023 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gesH8ZVg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AA335C2
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 13:53:00 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4340511A
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 06:52:56 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so11664a12.0
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697637174; x=1698241974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/46gZYTJ7+k/lgTbjMcqanFyOH01uyIBr9Wzd+F/OeU=;
        b=gesH8ZVgqMuNrAj/v1DmeCaJKBrudCSqTv5BPmsVxvu2ZOA2AqEeaGxT8e2Gz074iE
         t8AJ9fhIU0ks2/708a71/EOKPTa6weS4SksKLkOHAKJyK/ZIisgq7W5tJNpZ5lNkMROd
         ieKTJMH4scanxuH/ysj7DxQqCUf8eITQEtdRxPEQd8SMQxS8tImkL9i1ms9t7L/r3sqU
         9xLY9PX83fTqsZ/f/9OWIF4KO/86U9X9tYf43dwZMDjdF4vG0Dm2ul/f/1MB1Cw9QXvN
         qsKG6ubmVnrtmvMK1NRx81NCw1+jt4Z3yjh7jjJ1cBGrm5NHR/7mcq6vdDy2hasIE1J9
         ++Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697637174; x=1698241974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/46gZYTJ7+k/lgTbjMcqanFyOH01uyIBr9Wzd+F/OeU=;
        b=iX3EwelNtaWzdT08MiU33sMHpp6sFrbMAJC+Q7V7mMqwCgcVOvgz5RLb6BUpBBOpoq
         fTKM4jB2qdNCh+43hgdQhzjltr1gNN+RA7MgwMv1di630BDmuejCXvz4D4cxFjdbPyaY
         CFBrBt84lfxzmy2CWAoUsTOiL8fp15iJh9IoEqumX163/p0a49kQVOgo3c7N8k/jyHMQ
         1oMQUEpm2Ituno49qAmWU2A9v04qxAppASSJVuAgkvSwwyIBsZvpEofqlpjbiH8KlBrA
         e7yQLISffJnnk7EtOq1iGmfkIWpCHLCnVSQjqAtAWrd/6lTRu4hccM4ivU5oQnbcBZ0k
         IFCA==
X-Gm-Message-State: AOJu0YxuSDyzb5E6b/5rOdTWa/icJEKycnVHsowGN0Snvjl5W3KNyAC7
	rcdNuk8WHGRXL4eiK94t2D/atriEz/DzHoj2T92/voymeq6ErDdSxnE=
X-Google-Smtp-Source: AGHT+IHgM8edRDcsMpPWg6bikRA2p5zTGd60b6gtAhYOAINUBfsPGE/mf0z2Xbn2GnImyWU55vQvHlyR75jxEh+fjGU=
X-Received: by 2002:a50:baa2:0:b0:538:47bb:3e88 with SMTP id
 x31-20020a50baa2000000b0053847bb3e88mr131030ede.6.1697637174324; Wed, 18 Oct
 2023 06:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8f99194c698bcef12666f0a9a999c58f8b1cb52c.1697557782.git.pabeni@redhat.com>
In-Reply-To: <8f99194c698bcef12666f0a9a999c58f8b1cb52c.1697557782.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 18 Oct 2023 15:52:42 +0200
Message-ID: <CANn89iL0f+RWFm1FuNmKjoeMTMZQZHW8=83ZQnUxiY8B6hHxrg@mail.gmail.com>
Subject: Re: [PATCH net] tcp_bpf: properly release resources on error paths
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 5:50=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> In the blamed commit below, I completely forgot to release the acquired
> resources before erroring out in the TCP BPF code, as reported by Dan.
>
> Address the issues by replacing the bogus return with a jump to the
> relevant cleanup code.
>
> Fixes: 419ce133ab92 ("tcp: allow again tcp_disconnect() when threads are =
waiting")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Right :)

Reviewed-by: Eric Dumazet <edumazet@google.com>

