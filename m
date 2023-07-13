Return-Path: <bpf+bounces-4967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60BC752A59
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 20:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226281C2142F
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E8A1E536;
	Thu, 13 Jul 2023 18:33:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCEE3224
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 18:33:17 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E4213F
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 11:33:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98df3dea907so145005066b.3
        for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689273194; x=1691865194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5eTbts8cHZSzakMKK2Zdyg4qGmgVnQqsmrB4hVj4oIo=;
        b=ZoUNZqiiXaXLtMBPKPXgAVSfvEYoBzG8qqmD01VocN/DvbvV7ayhLAbdTA19NWxeFr
         0zfjWATqKcY9MD1Pxjs/2uE9wEEnMFmWcgKMs8Jqb6RRC7v51adCGwjSFGVek9qJotLS
         7wbS2lO4KmOrIRUkmtVkT2cz5aa3rulDrI6j8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689273194; x=1691865194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eTbts8cHZSzakMKK2Zdyg4qGmgVnQqsmrB4hVj4oIo=;
        b=axphX9qkjT+8IlboZGLZX80WbPGHLucSTI/zEngNKTVikS+JnVRpWSZ4/M43ra41WE
         KIE4nYeW8hk5LGhQi4N6/EMRUhQUWc7hkkAp0u8o2Q7/gu1R+hw+LT0Mb2praZv0aEBj
         u1T2LjbdK0MebGCZ7Fb2XYJvMIoF0+fxt/MAkB9zW6Z6ZDryccjTmmYbWsMLNfSn3hke
         8pnsmVpNqL0WkAPYD0Iu/kMtWjDdGV+SzyZ/MLaCMvl6uv2XDtYkqzgayqpyTA4Ws4Tr
         6kFgphOb30BcR/NkQKjlYmRyf7BHsfYnzw8by5omfddi74EjaDI7GgqCWgDwNAmbBG6Q
         GEoA==
X-Gm-Message-State: ABy/qLbJeK2D8LRHdovl5BmziojJLmcoiBzB5OQzluasZm/dkqeqaNhc
	GvZznSR3ujh6eCwpJ7Aa3l3KEsRtEiEweqw5x9YFx+ca
X-Google-Smtp-Source: APBJJlEBA2rg5QobqI02xkfYwxaSbJDAQ9ZTKhy6KjNgNgkPxQ1J1ePJhl6vlAOCeEAbneN1J9jrww==
X-Received: by 2002:a17:906:c205:b0:986:d833:3cf9 with SMTP id d5-20020a170906c20500b00986d8333cf9mr1881955ejz.39.1689273194636;
        Thu, 13 Jul 2023 11:33:14 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id hb24-20020a170906b89800b00977c7566ccbsm4239452ejb.164.2023.07.13.11.33.14
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 11:33:14 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-986d8332f50so148193366b.0
        for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 11:33:14 -0700 (PDT)
X-Received: by 2002:aa7:d511:0:b0:51d:91d2:335b with SMTP id
 y17-20020aa7d511000000b0051d91d2335bmr2839984edq.1.1689273173806; Thu, 13 Jul
 2023 11:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711011412.100319-1-tj@kernel.org> <20230711011412.100319-28-tj@kernel.org>
 <ZLAAEnd2HOinKrA+@righiandr-XPS-13-7390>
In-Reply-To: <ZLAAEnd2HOinKrA+@righiandr-XPS-13-7390>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jul 2023 11:32:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiT-nr-kRON8vToQSbMhijztp8LV=Y0PgjLJhgDPckxPA@mail.gmail.com>
Message-ID: <CAHk-=wiT-nr-kRON8vToQSbMhijztp8LV=Y0PgjLJhgDPckxPA@mail.gmail.com>
Subject: Re: [PATCH 27/34] sched_ext: Implement SCX_KICK_WAIT
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 13 Jul 2023 at 06:46, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> I'm not sure if we already have an equivalent of
> smp_store_release_u64/smp_load_acquire_u64(). Otherwise, it may be worth
> to add them to a more generic place.

Yeah, a 64-bit atomic load/store is not necessarily even possible on
32-bit architectures.

And when it *is* possible, it might be very very expensive indeed (eg
on 32-bit x86, the way to do a 64-bit load would be with "cmpxchg8b",
which is ridiculously slow)

              Linus

