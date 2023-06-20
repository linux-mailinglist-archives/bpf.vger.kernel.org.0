Return-Path: <bpf+bounces-2927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA64C73713E
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6CF281347
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB3E17754;
	Tue, 20 Jun 2023 16:15:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E0101FB
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 16:15:17 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D9A1709;
	Tue, 20 Jun 2023 09:15:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51a324beca6so6557912a12.1;
        Tue, 20 Jun 2023 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687277715; x=1689869715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffr+q3XL7sJW03SA2FWvqcSs0TjZ+T5V8JGqqa2pw8I=;
        b=fJcIYTcNt6nml9r5lt0E0SMAGTE8yvI/Wfs9Covy3YisTA9cD76maRRRrVvK62flgI
         0qtx3yYmrryQxlAyZVoB2WafUfDEVJdwhO8WOvin2bGPEAq8tTEqBKegGN6muuKyiSFQ
         AuVxJC8QbzYTaTQdBl6IsdN95jF3gX/jHFDD9eKgzGpdalwpiewDptPGmwyXpIWmvMxW
         w34m00Yz060sxcybVqgEGFKXpZ7hEBBivHoJAAF6ZwNDpNW9po8PadDdsrBNZLmjDwfn
         BGDDy6fvAKT2wbISUu8CXVG+7BwWVpJMu/4AGf7XAV5ZokOH7ERACBRWtmz1+xm1V57G
         2kDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687277715; x=1689869715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffr+q3XL7sJW03SA2FWvqcSs0TjZ+T5V8JGqqa2pw8I=;
        b=SUS0xlnirlKuD3V/l8BKyHfh8qSOrB0tqvFMQStJZ4Hv5oOV6ERXF2IPYNZhksZK8k
         CO0IWulumHcZMU1UorjPlL1sj86URnZYLKfKKSIiSB+ePgWRJCVgAzY0p8hZmVx9F1cW
         UQGx3hj0aSnTmfH0etI3yZfHfn7MdokgZYMeku81IWb31NcwL2IHj1NQnFfU05M/xwFr
         Ub69szhMHAslkSQ2eRxbQM2+vgS7IdfxZazucxCzTOSX+9noxCjEYRA/7krxl0u63PM0
         RTbKr9t5Gt1fH96sFIWGG81RNlEZnWB20gmr0nXkHgnYWQbrzNvqR1V5xBKAitLufLIk
         p+ag==
X-Gm-Message-State: AC+VfDxWAQXA04iJE1ioefm4C2/RqhheMFWAfQWPdG0r9Pn0R1HLeAjS
	wmVVWg3uwNHFZA81OPuOnOGfFnrf6R+MR8ovUvA1HIZ9ohc=
X-Google-Smtp-Source: ACHHUZ7zrvxwkth8Q1zNJtwIkNtsH0BybDYrUD5XeVtXTxi0paHENV++9WLvG8DHqwt0ylxdBhYg5NctFVYVF88Thrk=
X-Received: by 2002:aa7:dbd9:0:b0:518:7ad9:64bb with SMTP id
 v25-20020aa7dbd9000000b005187ad964bbmr8321439edt.19.1687277714774; Tue, 20
 Jun 2023 09:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230619143231.222536-1-houtao@huaweicloud.com> <20230619143231.222536-3-houtao@huaweicloud.com>
In-Reply-To: <20230619143231.222536-3-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Jun 2023 09:15:03 -0700
Message-ID: <CAADnVQLPpnTT2W1Ev6Q5g2h2qk6aoFa9uFsuc7Q6Xb36e4YV3w@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 2/2] bpf: Call rcu_momentary_dyntick_idle()
 in task work periodically
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yhs@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 7:00=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> +static void bpf_rcu_gp_acc_work(struct callback_head *head)
> +{
> +       struct bpf_rcu_gp_acc_ctx *ctx =3D container_of(head, struct bpf_=
rcu_gp_acc_ctx, work);
> +
> +       local_irq_disable();
> +       rcu_momentary_dyntick_idle();
> +       local_irq_enable();

We discussed this with Paul off-line and decided to go a different route.
Paul prepared a patch for us to expose rcu_request_urgent_qs_task().
I'll be sending the series later this week.

