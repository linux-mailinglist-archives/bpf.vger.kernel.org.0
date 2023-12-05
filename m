Return-Path: <bpf+bounces-16692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FED804484
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 03:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD9D1F213B3
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 02:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAC54A0F;
	Tue,  5 Dec 2023 02:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl7jH0OH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC215107;
	Mon,  4 Dec 2023 18:14:07 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c09f5a7cfso21214345e9.0;
        Mon, 04 Dec 2023 18:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701742446; x=1702347246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLYOJitG6MsmYZ52J6r5K0brTXqqI1z2ZXUGcmpI7uQ=;
        b=jl7jH0OHdO7iMSsDaWMnUAf6nDTlxwbTrB+DGcIyFgTZIrDFYe6GvxQ2FgYAhB4lvL
         L7fbEEqHIA/GGOWD3nL5GPalBuH1yXbkvwTRvP7c+fKXOwcHqE64wYBAdVWytSm9VPar
         PpsUubKIGLbXf7jYK3VztPezsoii7x8gi2NF/F6wJ55hW178zeJhAinA16zkA9fmLHEK
         dSpq/F0W4ge4FKHwLpMEjOJRMuOklLB5lvWmjET8sbt5JWiQnSTnz7Pkk+OPXRDHqJsw
         T0NMrhwqHve0yZI1BeRXQ4BiZzYnkR41AeurCqJsRVOGlNMK1hAPRQgbgTEwELhKfq2r
         vAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701742446; x=1702347246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLYOJitG6MsmYZ52J6r5K0brTXqqI1z2ZXUGcmpI7uQ=;
        b=H9UXUAGUCX1D5cwESOUa1qw5W2RHKsWteZpoz6bWk+wlP8bcC4b+EYGXXnrvEG7XsW
         FeBaC/yGqBMP67oj0Kkj9RpY5PnqN/07ktUeRt5h5n0jh1kOhKmcGNiXyDqS/OxN7mGF
         4PFnM4hvTUlsflzQ6iCekIdJoNktTCO1ODpR+PSdMK8/NlQiEsUCgFUrupGt5k3VcetK
         lbov1OuayaHknXt0ApWnJif6uimfuC/5ZGLd5Mk8YBAEK3LYv3QS5qAlOcDtlu62E+YW
         XRIAQzQiq/s5rupH1TZVUHpYd0ZxBNwqnZsZLuEDD1qdq463bS3KFdFyLyncnAi51aWv
         7BaQ==
X-Gm-Message-State: AOJu0Yxg4SmftDLwRlJOYP6Zz5asBsg55tfi1yPncmC0YZnjGdgM+idl
	spTzVU2jevc0GwapL9J2q2tbcbK1qsgZh+yw0lo=
X-Google-Smtp-Source: AGHT+IHPexNKUJ22o+YlNP4qkph2kU0vWUYC1l2LYSKbQX5qjGBQpVF11/+hlFiOTTfeouXuFa0sCKH2UF+tDOZDGnI=
X-Received: by 2002:adf:f3d1:0:b0:333:2fd2:6f7a with SMTP id
 g17-20020adff3d1000000b003332fd26f7amr4050306wrp.132.1701742446148; Mon, 04
 Dec 2023 18:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205013420.88067-1-kuniyu@amazon.com> <20231205013420.88067-4-kuniyu@amazon.com>
In-Reply-To: <20231205013420.88067-4-kuniyu@amazon.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 4 Dec 2023 18:13:55 -0800
Message-ID: <CAADnVQKY74ynj8PB62Wf4xgDN6sC=VawQwy5V3YbRx-2tbcwNw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/3] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 5:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> +static __always_inline int tcp_load_headers(struct tcp_syncookie *ctx)

...

> +static __always_inline int tcp_reload_headers(struct tcp_syncookie *ctx)

please remove __always_inline here and in all other places.
The generated code will be much better =3D=3D faster and the verifier
should be able to understand it.

