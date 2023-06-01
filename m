Return-Path: <bpf+bounces-1607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B8371F0E3
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 19:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDECB1C210CC
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F80647015;
	Thu,  1 Jun 2023 17:36:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C242501
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 17:36:57 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7B2189;
	Thu,  1 Jun 2023 10:36:56 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af2ef0d0daso16080271fa.2;
        Thu, 01 Jun 2023 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685641014; x=1688233014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pO4FII0u/eHrLOQ5BkkwHhkIfbGLfpdwLWunl0iT+U=;
        b=Qdn7iBNNAPRZ7leN6ZIxkznUayUVVTWN1OPCmLtATOnYD//3SmKUOFKJ0UOUYfReU8
         0vlKMCL9RX9GcFEXexp0N9UAaxAyHWT0Y5V693HLp9Kq4kdDM+yctXptXtscPfd29RxM
         BV8enV4MFjScfo1CI2ggWvEkD0/ML73ca9GsIx1//ggueTgd0dPbpH2cXWaZtLYcf0mQ
         y6NXIeR92PSmEPZNB0FU6CXnFLImbDMUgjEwfvEkJDkX0qStDrU6RSHEO5HG7IDpqcd1
         wiupz8H8XqY2XhqWWK8bsOAIEiicjNyKXgGXuufAu8hVu2wB54WvbWk4COrlIzvRI95u
         QzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685641014; x=1688233014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pO4FII0u/eHrLOQ5BkkwHhkIfbGLfpdwLWunl0iT+U=;
        b=bQo6B3Olu7hgIIlFzwZWaLX2cQa7YLxZVXGjfgADNjjxeuoyo34RuL9G8ewFUxYU1v
         KAgs2cD1YsbGm2tFXCI1TUcSIuKDBhAGrgdgYNohKgrbqF3Dg3kYm1ehZMkxCSYAzlVo
         Lq9QFOR9kISHeRsi9JUjWPyNJ7pGrq++8Q2GqRS+4nI2qJfLtRG3S7kQmMsQqx3AhqlK
         B3Zj0z5rTwbJ51xdhfXgvBI/MkUOA8i1ZttWuprTZrwmMasJzUG5A68TJllh+TPvj23n
         28RSX1t37EXvSi/EjXncYeLcdA7tYI6Zz6lXHVVFWUOeH/3sBYl3/Lh5AD9IsQ/sv+0X
         tLLA==
X-Gm-Message-State: AC+VfDyYIDGRQKtpddVMP1dFi5k3lkpksPsu8dL9uj/4JOWqKjaTZuVq
	cwcq7V+ibzEndxKYMTdeNrYr0eUgp2H1ktI+agQ=
X-Google-Smtp-Source: ACHHUZ40392VulkDYlINoWA/zAVgog1PROQ2CS8CZgWJopARs7kOjar4mfnmSR6zvulerCdXwmQVniUtve/Mixlt0rs=
X-Received: by 2002:a2e:8892:0:b0:2a7:6d19:b569 with SMTP id
 k18-20020a2e8892000000b002a76d19b569mr66121lji.53.1685641014220; Thu, 01 Jun
 2023 10:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230429101215.111262-1-houtao@huaweicloud.com>
 <20230429101215.111262-4-houtao@huaweicloud.com> <20230503184841.6mmvdusr3rxiabmu@MacBook-Pro-6.local>
 <986216a3-437a-5219-fd9a-341786e9264b@huaweicloud.com> <20230504020051.xga5y5dj3rxobmea@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <d3169329-1453-e87a-fbb0-e1435f0741dc@huaweicloud.com>
In-Reply-To: <d3169329-1453-e87a-fbb0-e1435f0741dc@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 Jun 2023 10:36:43 -0700
Message-ID: <CAADnVQ+yK700YFHBQx5-UpxkqhgK-SyL=b=vCXJb448WvSHkEQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 3/6] bpf: Introduce BPF_MA_REUSE_AFTER_RCU_GP
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

On Wed, May 3, 2023 at 7:30=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> > Construct the patch series as:
> > - prep patches
> > - benchmark
> > - unconditional convert of bpf_ma to REUSE_AFTER_rcu_GP_and_free_after_=
rcu_tasks_trace
> >   with numbers from bench(s) before and after this patch.
> Thanks again for the suggestion. Will do in v4.


It's been a month. Any update?

Should we take over this work if you're busy?

