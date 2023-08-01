Return-Path: <bpf+bounces-6523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ED376A7EC
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 06:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D33281883
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 04:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913711866;
	Tue,  1 Aug 2023 04:40:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E22263D
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 04:40:19 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA552E5C;
	Mon, 31 Jul 2023 21:40:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9fa64db41so2705811fa.1;
        Mon, 31 Jul 2023 21:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690864816; x=1691469616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbIA8vliJmfA3NgQumGKPdzxvNnSpJGzTRLMaSERhw8=;
        b=BLYU6nDu116IjNKE4R0tDcCjuT/X/215Szl/gh+3/qXxHG4DverRcHEH2jN1A+Niz3
         8pvoLYC6wEzzP6Z4dfJT4sWhp52+QKVFlGepeASofKLAOWa/oDULSuhsHrAkE4oxeCAL
         gpNRwIXRh/7Tf2oamZH9BVFeazuFuXDnpAr1W98uZ0FByAY0rDCuO95yGkr+XshtITNB
         6EiS/tWQ9wkQi+uWp0zdLRAPfVUIRs8ne5VScGP+7iG2xjJuUGdaYKh1UpoJxxKzc0MP
         civHhp8n9Ay3iufs3pjfuRTBfuP++OFTaGQ5QDV7gjSAwniEXpciUk8WtjKSq+JKjd6b
         Kf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690864816; x=1691469616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbIA8vliJmfA3NgQumGKPdzxvNnSpJGzTRLMaSERhw8=;
        b=gqvzUMW+NTtUG1kctmgi4aL4dTtvcbcdy7nVZ3XAgr39SB2Q2go7x23OAWGjMJTf+4
         xgNU2er2F4FHeK4Dg7fC6Wt1ugmhL38t1HmjjnbZKlIKPvugXwYChUBspJQtMOeAtW1j
         Yp/YH4aaIDvPYJwQao4lYuEf2eiPu8N4NTEYtASSzNglEJYvtTGF53yzcgJf+GlVwuqo
         VdbwWOyQBwkPJ6nOgKhxXqW0iYcMJaNeWW78rq3nPbG8ZrVU7aH3Cvb/qxsevokQKa60
         XaHeYQRgj4J6B/100zX/dDga9u5scTZZt15o+RMHYwH7DHp9ToBtRDRUdLfHQzZDzaI0
         Pp6g==
X-Gm-Message-State: ABy/qLZ0ztHHtYhvGXMafNAY6ScuNdTNJAFLjNRI5fXDja8QMUNN1748
	V+G9T/oLHGGWjaYzwyBwGUuYueGMBzzpeSM8X80=
X-Google-Smtp-Source: APBJJlGB2th5I+Ybcc9W2KRFmQVl+cCnJA9FxRkNdK8Hav2e8+sgSREFvtO0ftu/GXUGmcuVM+eOymuA+4PmscYT5/0=
X-Received: by 2002:a2e:8813:0:b0:2b9:575e:5298 with SMTP id
 x19-20020a2e8813000000b002b9575e5298mr1420567ljh.13.1690864815883; Mon, 31
 Jul 2023 21:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801034624.3412175-1-ruanjinjie@huawei.com>
In-Reply-To: <20230801034624.3412175-1-ruanjinjie@huawei.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 31 Jul 2023 21:40:04 -0700
Message-ID: <CAADnVQKc-JVYVaszVJRY-5=6S5sXbPER9KwE-_eCtQbw5J2tkg@mail.gmail.com>
Subject: Re: [PATCH -next] selftests/bpf: Use fallthrough pseudo-keyword
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: Alexei Starovoitov <Ast@kernel.org>, Daniel Borkmann <Daniel@iogearbox.net>, 
	Andrii Nakryiko <Andrii@kernel.org>, Martin KaFai Lau <Martin.lau@linux.dev>, Song Liu <Song@kernel.org>, 
	Yonghong Song <Yonghong.song@linux.dev>, John Fastabend <John.fastabend@gmail.com>, 
	KP Singh <Kpsingh@kernel.org>, Stanislav Fomichev <Sdf@google.com>, Hao Luo <Haoluo@google.com>, 
	Jiri Olsa <Jolsa@kernel.org>, Mykola Lysenko <Mykolal@fb.com>, Shuah Khan <Shuah@kernel.org>, 
	Benjamin Tissoires <Benjamin.tissoires@redhat.com>, Artem Savkov <Asavkov@redhat.com>, 
	Kumar Kartikeya Dwivedi <Memxor@gmail.com>, Ilya Leoshkevich <Iii@linux.ibm.com>, Colin.i.king@gmail.com, 
	Awkrail01@gmail.com, Randy Dunlap <Rdunlap@infradead.org>, 
	Joanne Koong <Joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 31, 2023 at 8:47=E2=80=AFPM Ruan Jinjie <ruanjinjie@huawei.com>=
 wrote:
>
> Replace the existing /* fall through */ comments with the
> new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> fall-through markings when it is the case.
>
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highligh=
t=3Dfallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Pls resubmit with the proper subject.
RTFM

