Return-Path: <bpf+bounces-8861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173078B663
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 19:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6041C20971
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4252C13AF0;
	Mon, 28 Aug 2023 17:26:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B10E134D3
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 17:26:20 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EF0CD2
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 10:25:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so52407961fa.2
        for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693243550; x=1693848350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNUlJ6t1UvNwWMo2o++afyNNkdo2uXFKpnhhfJ66XIY=;
        b=d4eMl1C0/ke+ATxst7d/766ErEK+p6DkaEVFNk37tl4+Y8LFS/0YczL3XIh2fLexGX
         k8v7bJoSDUAYtbTpncTQCJLUay/BK9IpcSEvoS5cc42P9bdiz5vnEMI5IIfo1m506xLb
         94sUb7FBk2zgi9io36RHZnLRe3+HHp2Wjv605U5LRcy6cZgRU9xhPOEv7Vy9Q5M2pq33
         XSkXQrTmcuONO540iYbCxHOgRgIrwuk5SH4LHqTem1jOhsuEbcnoQ4bHLBMdYacT6hsC
         N+Eju5SqNXSJ8VFJEI0mPN9QFQ5Kw+VxuN6Wyqd4xAOd1uIUGffq/8srgGcGuX/FDhb5
         NJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693243550; x=1693848350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNUlJ6t1UvNwWMo2o++afyNNkdo2uXFKpnhhfJ66XIY=;
        b=esfHjSAf2KHXt5XHkeAvPLASatd+1VXfsCeNLkoTegcl/I3pOdbTF0nICSZnZM3yD6
         JYoJhYRdXA04QgPzMEAbaD7HvE+cUxJcWJasujsLUinZoiT6IECd7W8TIEYoACSk9uGY
         kO/uZ23AV+Ccu1o307CevaUQRnZSynZw72M0cyix9FMiEpJZ8kyFWqa4BZlWCyeEkqVv
         98mOeNvdLUizn4YxYMXj9a8r0woxvLDwjwJdnbmXGK6h1fYTTkWtAw9eNENdEeo/7++R
         gD+2923VfMzOF07EonZ5Do9BPoWTj2+DmbWy1OlvQj1Xn+UaTnNqZZpDYuHumib9m4Zi
         PQ6A==
X-Gm-Message-State: AOJu0YzuvFcQ2mKMn8AUCzoZVgxSuuPqHFXXfFyH/LyK0khyaD1JpIE8
	6TEH4YEIM1I30TsYReu080qSk/E1Z38Hih228Rk=
X-Google-Smtp-Source: AGHT+IFXS0T3+xut9RopjxC2jWOTuHW7FHA2KrZWxidQ24m6PCQ51EYGyQpNctH/G2EpFoS+ODZxugjn1tLluc3Sy1M=
X-Received: by 2002:a2e:9b0b:0:b0:2bc:b70d:9cb5 with SMTP id
 u11-20020a2e9b0b000000b002bcb70d9cb5mr19019031lji.33.1693243549859; Mon, 28
 Aug 2023 10:25:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230828075537.194192-1-jolsa@kernel.org> <20230828075537.194192-2-jolsa@kernel.org>
In-Reply-To: <20230828075537.194192-2-jolsa@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Aug 2023 10:25:38 -0700
Message-ID: <CAADnVQLMZRn9E=czkHUxwTiW+9=y=qVYGo1_eOOni59HafemSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 01/12] bpf: Move update_prog_stats to syscall object
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 28, 2023 at 12:55=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote=
:
>
>  static void notrace __bpf_prog_exit_recur(struct bpf_prog *prog, u64 sta=
rt,
>                                           struct bpf_tramp_run_ctx *run_c=
tx)
>         __releases(RCU)
>  {
>         bpf_reset_run_ctx(run_ctx->saved_run_ctx);
>
> -       update_prog_stats(prog, start);
> +       bpf_prog_update_prog_stats(prog, start);

I bet this adds a noticeable performance regression.
The function was inlined before and the static key made it a nop.
Above makes it into a function call.
Please use always_inline and move it to a header.

