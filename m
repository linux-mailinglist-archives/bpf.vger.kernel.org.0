Return-Path: <bpf+bounces-2245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D2872A217
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 20:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E241C210E7
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1A92107F;
	Fri,  9 Jun 2023 18:24:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E321062
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 18:24:13 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8BB35A9;
	Fri,  9 Jun 2023 11:24:11 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1b92845e1so23245951fa.0;
        Fri, 09 Jun 2023 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686335049; x=1688927049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkSKOW89nDC35DM2bAzieBlsMkC98kKqdM5YlWE1s7c=;
        b=hs/+fegU1wKqc41c76IevyAnX9P3e6+xN+1It0mModNznQVvUJCXOAm8VAqIh4s4b1
         voAP5nd1G2LTvdLykGVoYeHppl2n8gFBDYp2ErdqaBm8AqhMW9zpgETtp8dgLoxz6VRX
         znaY0CuuSqJSmh3EI4x43yXjR5EtW3rNXenYRI9i0v4xeDUAVSTtPXDLSDs2qaPqPz+A
         j7u39+knB/m7vhHlzRE7dTNiO+De+4sC4edTQ4k5VZNt9FzSq+BefuEzozO1W5zQLqcx
         NHMtbnRtmM8yjzZapHVqxeWzjjp3v47hnXZmFejRdWH59hkQsucNoFjOY0l4sb39kxlB
         mtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335049; x=1688927049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkSKOW89nDC35DM2bAzieBlsMkC98kKqdM5YlWE1s7c=;
        b=amvpdqap8MrY4XNjYoQtssBKclvr7PnqviG8Uoj7QP3zSmsPlQR6JUp/3YyH9sVvYX
         N/7Uy2Z3bO5drrRiLbnQDKkdrJMYZ2X8+uMHvS6YeDbvG9BCurM4Zzc82RRBA3Wg+Fe0
         yatU6xXtIyUNHUYbSKfqItZ7DFISI/nORZURTQYOJ3LhphXgfTnJBNHigXs8hgHhyK5v
         hHSsYqFsjhYmxOATXmph2o2bYnXwqX5l5lPKcQwH1Fpvj7vaCoMV6MSYZChXcJknE0/y
         yshHeO0INvDOlSCeAMjN+isZL5yLcwRcXUc3ThB9IOqKz/T7kHEA9SMYKjsZOAcKlaLY
         TAyg==
X-Gm-Message-State: AC+VfDzGx86b4XtQUctWkoMh8j01Bg1IA6FyAoTXn0uqmjzwX8vhu5za
	i/FqJO/swsXujN5GD6uh8LVSktXyYeS5TdMsfhc=
X-Google-Smtp-Source: ACHHUZ7JNSLJNHdeg+//CAl/KiV9vxPhNpA5zDueRCOtcIxs7o9QagBhOAvyE8COveHl8YAPKLWZ0cnY+bwXRDLTS94=
X-Received: by 2002:a2e:964b:0:b0:2ad:d949:dd39 with SMTP id
 z11-20020a2e964b000000b002add949dd39mr1454871ljh.29.1686335048887; Fri, 09
 Jun 2023 11:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230609024030.2585058-1-houtao@huaweicloud.com>
In-Reply-To: <20230609024030.2585058-1-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jun 2023 11:23:57 -0700
Message-ID: <CAADnVQJ5m_gT2h41m2_tuf=GDGSWzVSA6ixOwQECzGv8VimZwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Add benchmark for bpf memory allocator
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

On Thu, Jun 8, 2023 at 7:08=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
>
> (1) non-preallocated + no bpf memory allocator (v6.0.19)
> use kmalloc() + call_rcu
>
> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB=
)|
> | --                 | --        | --                  | --              =
 |
> | no_op              | 681.40    | 0.87                | 1.00            =
 |
> | overwrite          | 8.56      | 38.86               | 88.42           =
 |
> | batch_add_batch_del| 6.74      | 41.28               | 69.70           =
 |
> | add_del_on_diff_cpu| 4.68      | 3.43                | 5.70            =
 |
>
> (2) preallocated
> OPTS=3D--preallocated
>
> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB=
)|
> | --                 | --        | --                  | --              =
 |
> | no_op              | 673.95    | 1.98                | 1.98            =
 |
> | overwrite          | 114.63    | 1.99                | 1.99            =
 |
> | batch_add_batch_del| 78.34     | 2.04                | 2.06            =
 |
> | add_del_on_diff_cpu| 6.41      | 2.23                | 2.54            =
 |
>
> (3) normal bpf memory allocator
>
> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB=
)|
> | --                 | --        | --                  | --              =
 |
> | no_op              | 656.20    | 0.99                | 0.99            =
 |
> | overwrite          | 81.21     | 1.10                | 2.49            =
 |
> | batch_add_batch_del| 18.40     | 2.13                | 2.62            =
 |
> | add_del_on_diff_cpu| 5.38      | 10.40               | 18.05           =
 |

I have a feeling that you didn't remeasure things and just copy pasted
above from v4.
I see vastly different numbers in v5.
and peak memory usage is broken.
It always shows:
peak memory usage    0.00MiB

