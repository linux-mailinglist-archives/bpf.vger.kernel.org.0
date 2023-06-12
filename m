Return-Path: <bpf+bounces-2445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4347272D056
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 22:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F7D1C20AD1
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 20:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2FDC14F;
	Mon, 12 Jun 2023 20:17:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8828F5F
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 20:17:37 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F36110C9
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 13:17:28 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1a4250b07so58553561fa.3
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686601047; x=1689193047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlfFY6oEBhu+y5ufHvyaR+3bCnZ1Uhgwx/DYgrZBnZw=;
        b=oJd39gB8szaIkPzFzIGcA9QOwbvYNFsqg1Zt6yO3sF2o0E8EIC2YobVvnowjlGVqYO
         A3wi+7gq8cjmKODRI8FnGN1qxRlAriyF8XlOHqKbPGX8xtOJAx+wSDd6gGCasWBtPnLT
         Rrc23KnhF7ICb/UmkMO1tsEk5ETNCK8MJziisBmqn8HYN+IzmyVUjlE8N7qit1g70xIM
         FrCUoZs38jj4k5CK3+XUY0+VYIa9/tGriabu26AMFfCrFB8+FpfOqnsTyEAI5V3PoL/t
         4kqtqKBaJ30UMgJKJ5eMNq4OvgNoKPOszrg9EVf3RsXl8YooCMeGa1gAg8WwbhV4dFFL
         cafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686601047; x=1689193047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlfFY6oEBhu+y5ufHvyaR+3bCnZ1Uhgwx/DYgrZBnZw=;
        b=R1HgFQpjbqsIV84aHSpV5FmP9WfCCqNQW5Lsr53jgfzh0M0jPULl7q0T6SpHVQUciG
         U/z4+0mQuD04Nzlj48M5WiauMMvX8ZWTCXv0fdJojBZaFJxuFz7CqCm/PAhWfBOCBE6U
         Lq2IUKP2bsNxP0MiT7QfnYz3d8+jF1wHN8DJ5o3stnkOTzH2nZcgXmmI9Fqpx311jOsO
         3QwdGUc+28lENKRwduD2Npt06aNlPahiGTgtb4oX2r8MtxqJG/IaTXQxf5n9Ox+Yk+Vv
         kHowRvqH2HSFNPDJJSNCKEPl2pd4Q/o5VoWmlbN7HXU+67EK9eb3GsO+wGMZ64l2Io6O
         EpOw==
X-Gm-Message-State: AC+VfDw+f4fu2U4cJqh67m9QihGoKQPMRsEnOZA+NnsY4yk9DD3doz1B
	8SL049YbXBvc6di56XF/BHH7J0H81WZuqgIYXkE=
X-Google-Smtp-Source: ACHHUZ4VrORCAr8hfsWYYUZ+5m46Wfuymb6+84Kz4WgfQrQzh3cYpSDwPcDMbdT8PG0/ZZP4Stz9BrxDGtgwl4/EPbE=
X-Received: by 2002:a2e:8949:0:b0:2af:23c0:ffe2 with SMTP id
 b9-20020a2e8949000000b002af23c0ffe2mr3767340ljk.48.1686601046419; Mon, 12 Jun
 2023 13:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230612191641.441774-1-kuifeng@meta.com> <20230612191641.441774-2-kuifeng@meta.com>
In-Reply-To: <20230612191641.441774-2-kuifeng@meta.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Jun 2023 13:17:15 -0700
Message-ID: <CAADnVQKi0c=Mf3b=z43=b6n2xBVhwPw4QoV_au5+pFE29iLkaQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] net: bpf: Always call BPF cgroup filters for egress.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 12:16=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com=
> wrote:
>
> Always call BPF filters if CGROUP BPF is enabled for EGRESS without
> checking skb->sk against sk.
>
> The filters were called only if sk_buff is owned by the sock that the
> sk_buff is sent out through.  In another words, sk_buff::sk should point =
to

What is "sk_buff::sk" ? Did you mean skb->sk ?

> the sock that it is sending through its egress.  However, the filters wou=
ld
> miss SYNACK sk_buffs that they are owned by a request_sock but sent throu=
gh
> the listening sock, that is the socket listening incoming connections.
> This is an unnecessary restrict.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---
>  include/linux/bpf-cgroup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 57e9e109257e..e656da531f9f 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -199,7 +199,7 @@ static inline bool cgroup_bpf_sock_enabled(struct soc=
k *sk,
>  #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)                        =
      \
>  ({                                                                      =
      \
>         int __ret =3D 0;                                                 =
        \
> -       if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk && sk =3D=3D skb=
->sk) { \
> +       if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {


I did a bit of git-archeology.
That check was there since the beginning of cgroup-bpf and
came as a suggestion to use 'sk' instead of 'skb->sk':
https://lore.kernel.org/all/58193E9D.7040201@iogearbox.net/

Using sk is certainly correct. It looks to me that the check
was added just for a "piece of mind".

