Return-Path: <bpf+bounces-13246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53947D6D78
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 15:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D3B281CA9
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 13:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C850628DA0;
	Wed, 25 Oct 2023 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BUOAtfrE"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80427723
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 13:41:39 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C45F19D
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:41:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so8634087a12.1
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698241296; x=1698846096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7T/VX1aEQjbsBkCrW5UAE2KHJoyq/0CySfZ++IfQgo=;
        b=BUOAtfrElVFC3GAHE8wruSqXIEaG6/yrGHBBXZyvZzVCd2AEwP5okyAtgK0B9Q9wFR
         PFFXnVOYwgCg5VrWOfmOJA/P2QMjF1PyikinR0/Tjx+FlLLKFJoU2iwu6XWJFj3ZhPUu
         nhGWfL0m+qLuIf3bnLfMOZHykwRahizOyxmps+qwvs/9v0iWD2kMyn7GAsTJ7G6tsA/2
         3WLKVYH87eFXI5S1nk8qgDfnQu9tMEbU8NQ6ZksQeVgtZkr8SfRl46H6X3QNMt75+L7M
         FdS1tI3HiPDhkyqZFr6j34N9mkRxLVAGvvad6c9/lJFlkW8+Eeqxy4LOX1GVsFTgJgnW
         XxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241296; x=1698846096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7T/VX1aEQjbsBkCrW5UAE2KHJoyq/0CySfZ++IfQgo=;
        b=b3AR0BeIbkpTvSubo0UI3KfIEzmI9YVrUTxqmw/NBNjfouE3Thyyi60RsRbCXeYfML
         3NdZ2O+MuaA/C85Y1UPkihMSIeq9MulxhR92tkc6rjBvn7NxYxtZSQRA7rtwdi4OfwmZ
         xs9tgqXSvaSAgCZfGuksZJiw7AV/fcioyOHwsuNAEyiGHFgYq8LiCe3OG43Fg7SkHP0z
         7sLjEG5FrkfWQedVMtMAW4Xf91tEhdijPfnR0z2rRTdt8+7BUggdLolkkVHEN5bJK+d+
         2fLBEk4b9vLGzNiR6VqaBbyyNsYrJaju1PY+1vTFqgSMgIadVcdVcC2we1HCPSur9M3q
         R5Ew==
X-Gm-Message-State: AOJu0YxbFnX/6bq85nNuHqTzmpYdo0gLFe3fxh94Ius57MKmvtaC5X2k
	+zSjyjXmh2DhDuEYfo9OOYG9DUhAlH0oDKiRElRIe5gK+eSt3CmsUFQ=
X-Google-Smtp-Source: AGHT+IHBjU/KMiKqW5gzCPBJHKB7sTHnWDlZgbxCgyg3azajr2EtWf52br94/wohzr5eJpfvjEGJ6VXPPr0iwkGjFGg=
X-Received: by 2002:a50:8ad7:0:b0:540:bdda:b0b4 with SMTP id
 k23-20020a508ad7000000b00540bddab0b4mr2347533edk.36.1698241295389; Wed, 25
 Oct 2023 06:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd258298-8d8c-453a-bf21-9859b873d379@moroto.mountain>
In-Reply-To: <cd258298-8d8c-453a-bf21-9859b873d379@moroto.mountain>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 25 Oct 2023 08:41:24 -0500
Message-ID: <CAO3-PboDgpHjXhcYCSFvYtEjJkLNcBY_hQ5yFtm-xTsVOdW2PA@mail.gmail.com>
Subject: Re: [bug report] lwt: Fix return values of BPF xmit ops
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Wed, Oct 25, 2023 at 2:40=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Yan Zhai,
>
> The patch 29b22badb7a8: "lwt: Fix return values of BPF xmit ops" from
> Aug 17, 2023 (linux-next), leads to the following Smatch static
> checker warning:
>
>         net/core/lwt_bpf.c:131 bpf_input()
>         error: double free of 'skb'
>
Thanks for reporting. I looked at the code, and it is possible to
continue processing skb on bpf_input and bpf_output when BPF_REDIRECT
is returned. However, both paths call run_lwt_bpf with NO_REDIRECT as
can_redirect bool arg, which means the skb_do_redirect branch won't
trigger. So it does not look like a bug to me. The life-cycle of skb
is a bit messy around this corner though.

Yan

> net/core/lwt_bpf.c
>     38  static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *=
lwt,
>     39                         struct dst_entry *dst, bool can_redirect)
>     40  {
>     41          int ret;
>     42
>     43          /* Migration disable and BH disable are needed to protect=
 per-cpu
>     44           * redirect_info between BPF prog and skb_do_redirect().
>     45           */
>     46          migrate_disable();
>     47          local_bh_disable();
>     48          bpf_compute_data_pointers(skb);
>     49          ret =3D bpf_prog_run_save_cb(lwt->prog, skb);
>     50
>     51          switch (ret) {
>     52          case BPF_OK:
>     53          case BPF_LWT_REROUTE:
>     54                  break;
>     55
>     56          case BPF_REDIRECT:
>     57                  if (unlikely(!can_redirect)) {
>     58                          pr_warn_once("Illegal redirect return cod=
e in prog %s\n",
>     59                                       lwt->name ? : "<unknown>");
>     60                          ret =3D BPF_OK;
>     61                  } else {
>     62                          skb_reset_mac_header(skb);
>     63                          skb_do_redirect(skb);
>     64                          ret =3D BPF_REDIRECT;
>
> If skb_do_redirect() returns -EINVAL it means the skb has been freed.
> Originally we preserved error code but now we just return BPF_REDIRECT.
>
>     65                  }
>     66                  break;
>     67
>     68          case BPF_DROP:
>     69                  kfree_skb(skb);
>     70                  ret =3D -EPERM;
>     71                  break;
>
> regards,
> dan carpenter

