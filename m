Return-Path: <bpf+bounces-2173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53DD728B8E
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 01:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2F72817F1
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 23:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B63E34D7B;
	Thu,  8 Jun 2023 23:09:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5542A9CA
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 23:09:07 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEDD2D7F
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 16:09:06 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso1784791a12.3
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686265744; x=1688857744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yg5mEjswlLN23yttIW1ZUVlQfNyv8tx3EfnWGApDV+k=;
        b=HkFNzLMyuQPx0P05E0wgepz8UBdcnwHvAc15242zAaBovy92qkNtV+VFjgn3dtDv+/
         Ip75gSjABPNzTu/8HwZkQXnzDmBBmqIE+l99tSxLqXbbtg8stt7jtIfxlOnbJ7oGxtvc
         xvCZH91VldMhczgwX9S9JYKurPICXa2qN/R/qMyIqoVTE2s0mrpoRr+hQ4O4rWhTjWos
         iba3Hzg2axoHZJ+OiRxd8am7/929oI/s76+vVFoqk5hBVcyRRCVRcMhyBRdtx766Hlnq
         Vj5R3x4Dvut/X3lROITttcaKVdq3JfsJY/NFIhyk2MeC2JEs/N3I+LsOQVbKlKa7RyQC
         XHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686265744; x=1688857744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yg5mEjswlLN23yttIW1ZUVlQfNyv8tx3EfnWGApDV+k=;
        b=JZhZ+OW+7kXuws4aoADAlBPrcVhpQjVbW+f6wO1jtFszftgEawat5WyFOYvnId32Fr
         7MXO9UVQhj6UVdTuriQ4KuKUW462BWNcYbAN651BM3K7eMa3YUp1hDr6+iM0ioC6ZAwF
         VbkRJqgfiiqAinmjpA6WVG6HBZOfvk/rg5Nq6WzVEgFDBgt1paS0NtPuypDr/R30vWTG
         Xev2RoZ1XVDvMJ8dKkXeOJ8Uk0ZPUtbjV2k9ssBmSp6uOPuUw5x0XoJy7lW/+b0Fd6C7
         qFvi+IqiuP+O88NEWqbouy6mtHyz3PlBxw5Vm3WCbsmGAlmuzoHvT1duBusoiJ5a65Gd
         qpTQ==
X-Gm-Message-State: AC+VfDwqCBh9VSCKQIOUk5kk33qmvJaUgs4KsaYFngek9NgRXYdaCXZT
	Y8ugaOxTIVfxCzZrh24taAPudiPyCC2aeq2nsWc=
X-Google-Smtp-Source: ACHHUZ7crnBGCwjWpKPtBYcY/WoKwzjtx/waoyHkj1AWxMqsTvtpIIOBCFEtQ8pPZyExIC4oFiqgAVlaDEBsDouk1V4=
X-Received: by 2002:a17:907:805:b0:92b:3c78:91fa with SMTP id
 wv5-20020a170907080500b0092b3c7891famr491315ejb.28.1686265744583; Thu, 08 Jun
 2023 16:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608103523.102267-1-laoar.shao@gmail.com> <20230608103523.102267-5-laoar.shao@gmail.com>
In-Reply-To: <20230608103523.102267-5-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jun 2023 16:08:52 -0700
Message-ID: <CAEf4BzYMnhqguqYCXBfKLzh8S+nAKScqBiG6pFxC8ay2KzfLLw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/11] bpf: Protect probed address based on
 kptr_restrict setting
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	quentin@isovalent.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 3:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> The probed address can be accessed by userspace through querying the task
> file descriptor (fd). However, it is crucial to adhere to the kptr_restri=
ct
> setting and refrain from exposing the address if it is not permitted.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/trace/trace_kprobe.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 59cda19..6564541 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1551,7 +1551,10 @@ int bpf_get_kprobe_info(const struct perf_event *e=
vent, u32 *fd_type,
>         } else {
>                 *symbol =3D NULL;
>                 *probe_offset =3D 0;
> -               *probe_addr =3D (unsigned long)tk->rp.kp.addr;
> +               if (kptr_restrict !=3D 2)
> +                       *probe_addr =3D (unsigned long)tk->rp.kp.addr;
> +               else
> +                       *probe_addr =3D 0;

kallsyms_show_value ?

>         }
>         return 0;
>  }
> --
> 1.8.3.1
>

