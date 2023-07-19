Return-Path: <bpf+bounces-5349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B9F759C96
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 19:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4022281985
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 17:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B682C12B70;
	Wed, 19 Jul 2023 17:40:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6F12B6F;
	Wed, 19 Jul 2023 17:40:03 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A83D18D;
	Wed, 19 Jul 2023 10:40:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b962c226ceso777991fa.3;
        Wed, 19 Jul 2023 10:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689788399; x=1692380399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4FZ+pEDFxMu62/f3ZPQU8/ejLZyeXKnXKx6I8N8EPg=;
        b=CVXdubXH69K58dJHQTBhen0a6lTzPl/4lDHx/RpgNo7gpDXKZL87NsO2G/yViFJaG9
         7TS3yYbry1HrIue4mK4152ml8buuqqBVM/rPJvUc0PImdC25Es3JgLN6+aNTqxOnuYvt
         GXvrtXDVR58xbxzVUvo/yTc4CNNPjQD55awUyKRhVVcBneYnfKzCyrxodVlS14RPHQKg
         NvVpwsDP+YZ6RmMCfVQ5xE7UlK4z8/b4vzxutU4FZfWkOMWwDNA76OuLRML4Loehsw1j
         wXfLdFlEjuKbPcS0eGZcR18xUJty61dgB9bCgOXN+Lmc3ODdCDnbvKvMz6Sr4ZeVPCaM
         PYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689788399; x=1692380399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4FZ+pEDFxMu62/f3ZPQU8/ejLZyeXKnXKx6I8N8EPg=;
        b=KZ7f1FXPOyENbhbR9zjDcUsfaITKtmGkPrGMGUSLY5ncpw7W0IIk3NWK8tL6NAYCHZ
         Tpc3j+mvMQk/Qm4imugBQeeVDwSGoh159iH5lmHl2pT9qCUh+usjDk6iyOZ1SoWszaEo
         cjT+pJmhQI+eRTHpiwmVFI7691tdbelY1g5DDHCPW8iKV8joq+0kMhDBIin/ZvKDmP1X
         xOXk1NL6wkqkiC3YCUR/BkBoFIYm16crDVyMd3iehqm7uJzT2UN4lXBzpJn1ibiyj7pb
         glNegC23vwZeaTw7VcKdCsetWP7j3QwF+2b7I92w1w90hWPPwNrBtHBEr3p/Fb8wMzQS
         qHMw==
X-Gm-Message-State: ABy/qLarypQVRkyFI9DuKah9sT5aqUz3tCrYBxkCj4YWwcWR449W4yn5
	Sloa5kQfLWK0Z5+v8VSnQb9SU+sAwOmAk7/t+9M=
X-Google-Smtp-Source: APBJJlGImTB+nPdraOcOvpNx+dDsCOW/2CoyeTbuMoJdSdyjYZXkoTMzQHdGzkJGsbfve95V/0FvPYmb+CWQevfx8z0=
X-Received: by 2002:a2e:87d5:0:b0:2b5:80e0:f18e with SMTP id
 v21-20020a2e87d5000000b002b580e0f18emr518116ljj.3.1689788399045; Wed, 19 Jul
 2023 10:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230719125232.92607-1-hffilwlqm@gmail.com> <20230719125232.92607-3-hffilwlqm@gmail.com>
In-Reply-To: <20230719125232.92607-3-hffilwlqm@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Jul 2023 10:39:47 -0700
Message-ID: <CAADnVQKxGNNbn-OnQzrbcOfC6c_5tL0PSfZM0y8h_FJ0Pg=sDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add testcase for xdp
 attaching failure tracepoint
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yizhou Tang <tangyeechou@gmail.com>, kernel-patches-bot@fb.com, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 5:53=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
> +       return 0;
> +}
> +
> +/*
> + * Reuse the XDP program in xdp_dummy.c.
> + */
> +
> +char LICENSE[] SEC("license") =3D "GPL";

Do you have a hidden char in the above?
git considers the last line to be part of the commit log instead
of part of the patchset and it fails CI.

