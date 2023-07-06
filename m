Return-Path: <bpf+bounces-4149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E246749425
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CAC1C20C89
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 03:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4CEC2;
	Thu,  6 Jul 2023 03:25:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64876A5A;
	Thu,  6 Jul 2023 03:25:41 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C555F1BC3;
	Wed,  5 Jul 2023 20:25:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69e6d324aso2375751fa.0;
        Wed, 05 Jul 2023 20:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688613934; x=1691205934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/eRDSzqQ25Yv2WyVY1qyBDRoPQjAC3HMy+pdvXL9Cc=;
        b=B2v/UPqlW/8h/URXicF1yvJp18WEf2LJfDsNDm61EL/iXhs9SYb849L3HD8touO1J+
         2ikJiQbUS1fqUjlesdYUCj6z1tfK7Ao+eD0iw/wqCmFf8wFQT7T77JDwEjERYuFCa3CB
         lwTgB0nmD0rR9i7D/C6XnG+Fge6blZ/c/3tU93Bs54iVqsNJB/g9Nn/o/fM6y8lFHGlN
         zhX/Buh4UDx0097s/Y44tZUhQK4hHNZk8cU/1Wlox+nBHSz5P5CDIJkOyfgJW7GJU8jF
         OQgetZdaZrmJe6zISuzut/7ctng5WCvTeofU+9t9zQzSoLhUR2onyyCOst9oqY0MzZ75
         45Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688613934; x=1691205934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/eRDSzqQ25Yv2WyVY1qyBDRoPQjAC3HMy+pdvXL9Cc=;
        b=eAUJvfsah8g3IB2jKDuQ6sS31AHGZL2mpb6uYXg7Wd+wJLDyNjGzmscu4ktibZOHzA
         sBcgjDstZgtEzbxh4Jggh34UnqDnuu2WqD584ndwKd4cPWCWkiyw9t513dsk1PwuRL4f
         HpmYpEWlJJP1hlfdm5D0HachBXA38yJUamnKtqPpiqin0tqgqftjpDC5v01HIHs9YKIq
         kfP8n8MORo/fqZe/ke0VFE2dkrIdhEy4ttT5Bhr2Uouf0oWqbAA2ESmRCQcQ6pcO/2j0
         Grnqt23x0C3cdE2PFHlIWekw62iPm+OmXQRhDgZpHfhMDE2OLEyVCrGV0E1jQZ98bRRl
         avBw==
X-Gm-Message-State: ABy/qLar8OgQrK30uXdZJkBkt8PucQ8SLAPR0E69LXnydYJHEsZX9Y1n
	4O0Ow8h7GR6U7v3CsJhnmBKnLd2luStc05S7Qyed/u0p
X-Google-Smtp-Source: APBJJlGEHOCrhbBI8oGOT6K6UDeqp5IC7UXaoZ4mLww8h1jZhNSoSsX39duufpBkFUCdmqTBZcKqffRq1aKqiIMMIbg=
X-Received: by 2002:a2e:a0c8:0:b0:2b7:764:3caf with SMTP id
 f8-20020a2ea0c8000000b002b707643cafmr218910ljm.10.1688613933782; Wed, 05 Jul
 2023 20:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-13-alexei.starovoitov@gmail.com> <57ceda87-e882-54b0-057a-2767c4395122@huaweicloud.com>
In-Reply-To: <57ceda87-e882-54b0-057a-2767c4395122@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Jul 2023 20:25:22 -0700
Message-ID: <CAADnVQKpT1HSjz8_bd2ZM67_fwTC9QoJ+4x8G+KzzqPT7QAkDw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To: Hou Tao <houtao@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 7:24=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> I think the race could be fixed by checking c->draining in
> do_call_rcu_ttrace() when atomic_xchg() returns 1 as shown below:
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 2bdb894392c5..9f41025560bd 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -303,8 +303,13 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache =
*c)
>  {
>         struct llist_node *llnode, *t;
>
> -       if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1))
> +       if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
> +               if (READ_ONCE(c->draining)) {
> +                       llnode =3D llist_del_all(&c->free_by_rcu_ttrace);
> +                       free_all(llnode, !!c->percpu_size);
> +               }
>                 return;
> +       }

I managed to repro with your extra check-leaks patch that I will
include in the series.
The fix also makes sense.
Thanks

