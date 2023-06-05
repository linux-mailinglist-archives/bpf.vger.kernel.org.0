Return-Path: <bpf+bounces-1896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2497233B1
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 01:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F26281403
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 23:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79D828C13;
	Mon,  5 Jun 2023 23:32:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF382773D
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 23:32:41 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C698EC;
	Mon,  5 Jun 2023 16:32:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51475e981f0so7931730a12.1;
        Mon, 05 Jun 2023 16:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686007958; x=1688599958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XSS7GkuxbyAJz2hpFZd1hS8+hsFiywFxc/vDR6MdZU=;
        b=hset7a17N0jBVuymWZ7RYQaCmS4Lyd1Gd5vV3xIUSTt2NMnqTSMWS7tw9J8KxUy0TC
         HM5vUjbFdW2Jy2KY4YbcbpzUcVFfKT30eGuG35k68Khg6HoSOHUbAByJ6NyvmkJR4eDA
         bw9PR6Q1VfbT78MXN9dw3+pWk7NTbXEoMwxd5CQKdDwr/7I3oTrYcd1c9ah67muZG27n
         7/pPRlhi1oNJHgXvq00lU4p0ZGRoz2drKoZxFg7zGxMkG371wvzzllGhmSE/SG5C+jWD
         DEVVcTTiD78Y7ls24IMM3I+ovKhMJdYfsWg7Gx0fNaA0waSVd78VdaG8ID+CWu4j0B1H
         L1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686007958; x=1688599958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XSS7GkuxbyAJz2hpFZd1hS8+hsFiywFxc/vDR6MdZU=;
        b=QF1O7GZ56bZPce9ffSia2lGJeim0fVdweBFJCBvO0sisyQfyoZ9Dxoz6Muf1fuvwxG
         k2RNQSn6Fa1XOp7fmteQWVVhBeKjD3jkQuy189zp7b+7gafWAmm9Nl7fRGLfbYjk8h6j
         /f56A90a7x+S/XGOBnXoLTQVkPDqi2xzM3M+NuE5IHUem4axseaX1qQVbJTmIlB+K6lt
         0edSuI8McM5PoW/hCIM2oUPxluyd11Z+1LEFj9FgR/xDLIHQBEbRiwaFp5dKDJCyUW8L
         +O4hnkbpaJDr0/GJ0R9BiDiEcMMN2LYatlQwkhRiCAT2MO7CW48K2P59vS8UmlMsdxbG
         p04Q==
X-Gm-Message-State: AC+VfDxn31Okfh8X+bzV6sOEaZwSopJZXOijqQwUUsUtDwsumyslqVwm
	lcdn8A7RdM8AcPzJBIv0rlNGQRUriG/TtMb9oPQ=
X-Google-Smtp-Source: ACHHUZ6cZauFLADXENMrenKJcg0yRS4E9CptP7eO6OxudKDUQp3ThF2gh8EkWurUTnqdB4W3EQhc0/+7mFbWVXhOKrM=
X-Received: by 2002:a05:6402:644:b0:516:436d:3f82 with SMTP id
 u4-20020a056402064400b00516436d3f82mr373337edx.30.1686007957834; Mon, 05 Jun
 2023 16:32:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602030842.279262-1-gongruiqi@huaweicloud.com> <ZHoUyDMJ8xq7ENnX@google.com>
In-Reply-To: <ZHoUyDMJ8xq7ENnX@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jun 2023 16:32:25 -0700
Message-ID: <CAEf4BzYS5mj+0ZBA2HKW3=kB1cjZ3wdiJZ2OP9gSLE4e7WB_wQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: cleanup unused function declaration
To: Stanislav Fomichev <sdf@google.com>
Cc: gongruiqi@huaweicloud.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wang Weiyang <wangweiyang2@huawei.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 9:12=E2=80=AFAM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On 06/02, GONG, Ruiqi wrote:
> > All usage and the definition of `bpf_prog_free_linfo()` has been remove=
d
> > in commit e16301fbe183 ("bpf: Simplify freeing logic in linfo and
> > jited_linfo"). Clean up its declaration in the header file.
> >
> > Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
>

I'm actually having trouble applying this locally. Can you please
rebase against bpf-next/master and resend it? Also, please check
Signed-off-by's "<first> <last> <email>" order and spelling. Should it
be "Ruiqi Gong <...>"?


> Acked-by: Stanislav Fomichev <sdf@google.com>
>
> > ---
> >  include/linux/filter.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index bbce89937fde..f69114083ec7 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -874,7 +874,6 @@ void bpf_prog_free(struct bpf_prog *fp);
> >
> >  bool bpf_opcode_in_insntable(u8 code);
> >
> > -void bpf_prog_free_linfo(struct bpf_prog *prog);
> >  void bpf_prog_fill_jited_linfo(struct bpf_prog *prog,
> >                              const u32 *insn_to_jit_off);
> >  int bpf_prog_alloc_jited_linfo(struct bpf_prog *prog);
> > --
> > 2.25.1
> >

