Return-Path: <bpf+bounces-9307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C85793319
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 02:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1542E1C208DF
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 00:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8C63C;
	Wed,  6 Sep 2023 00:55:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116FB62B
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 00:55:39 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C321FDA
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 17:55:34 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bd6611873aso48192541fa.1
        for <bpf@vger.kernel.org>; Tue, 05 Sep 2023 17:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693961733; x=1694566533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KK0WmWI0wy1qFel5QFb7ImX5takycoRqBl31ZbFz3XE=;
        b=ijEJvO/5I28MUvlVtz583+YRY/YPL3u4k0CcnYBP94cwcKe0krURBjaQOOQF+JEE21
         Fh65UpC5AqiQH3iZ+XQcCRa5k6dVNHxM/i/ijkYdxHbTt2jS2rYE0ZTOxP0fjrUPw3jm
         ktyTCNRO5546DyxvkfNJXwG2mELtPoRUdGzBJGrJuRCk0QbgJ0nm2jY3CzQY1AaONUuB
         S0bKN5wmEZ/SUD49a8pF8fTjdZJp2Wb1FtCpax9tovMZRRyABqlnz3FaVFbSOkj/yOD+
         H++YlrBD88ETN+uxzn/a34aogf46Zfn94PFGdTlkfmKooG78RK6hYbHm9UJMwkS7+86e
         SIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693961733; x=1694566533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KK0WmWI0wy1qFel5QFb7ImX5takycoRqBl31ZbFz3XE=;
        b=LF9B0N4RRfM5IEfllEt1psm3vGqJRBDrqi/RDlL80SMgb4RhCxCXgle3XQxyCMwybR
         /oui0cbMEXqPWmyH4+RGohWvBrFlaoD1x1b8OSPtGFLNWHJ5OzQTpOOB0lzrep7ojI8x
         lmW4qdZO2bXoa7g77bJkKKtW+UULZ0Hzcb6C+dK9fO13ggGQpd+7yoAfchb3fsp4vdLw
         6XokcU5ImtrX+GDyN2phZ2cDV632dhw29KSD8u0tTjQmBlL9oEs8yne5HW7Yir6HYmyR
         qnOyt+NxNpfFKXomgGqVjdDgWQkBM4/ZFcBwlVA4RA+U/iTCQyC9jZgfabrOQRwgIMlu
         jNpg==
X-Gm-Message-State: AOJu0YzKnYnn0k0lwI7a3Mb6RPLMjrcN//azlQ8jVL2zwuswlEfMJX4U
	8kvQbIyKwyvlnME5JDVsgAlSMK1M5AbgLq38H6s=
X-Google-Smtp-Source: AGHT+IHr6fJ6bB/vZ0PYNzS2D8Jaexn1uPOxeA6bgE9EVMXwsLAVVqVeu4vKy5EZ2hXgkhbcSmxXpImP8Y0dFulkY0Y=
X-Received: by 2002:a2e:b16e:0:b0:2bb:8eea:7558 with SMTP id
 a14-20020a2eb16e000000b002bb8eea7558mr987826ljm.13.1693961732705; Tue, 05 Sep
 2023 17:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901111954.1804721-1-houtao@huaweicloud.com>
In-Reply-To: <20230901111954.1804721-1-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Sep 2023 17:55:21 -0700
Message-ID: <CAADnVQ+c=udqOJQFWgNqz7LBaoxBz4FsDRF89jqij+kGHH7VEw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/3] bpf: Enable IRQ after irq_work_raise() completes
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 1, 2023 at 4:20=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patchset aims to fix the problem that bpf_mem_alloc() may return
> NULL unexpectedly when multiple bpf_mem_alloc() are invoked concurrently
> under process context and there is still free memory available. The
> problem was found when doing stress test for qp-trie but the same
> problem also exists for bpf_obj_new() as demonstrated in patch #3.
>
> As pointed out by Alexei, the patchset can only fix ENOMEM problem for
> normal process context and can not fix the problem for irq-disabled
> context or RT-enabled kernel.
>
> Patch #1 fixes the race between unit_alloc() and unit_alloc(). Patch #2
> fixes the race between unit_alloc() and unit_free(). And patch #3 adds

Looks good, but I disagree that patch 1 and 2 are fixes.
They're surely improvements to bpf_ma logic, but not bug fixes.
They decrease the probability of returning NULL, but can never
eliminate it. Async alloc behavior of bpf_ma cannot be "fixed".
We can make further improvements to it.
Like do synchronous kmalloc() when bpf_ma is used in sleepable
or other safe context.
Such future improvements will not be "fixes" either.
So I've applied the set to bpf-next.

