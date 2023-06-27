Return-Path: <bpf+bounces-3598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D5E7403FF
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 21:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B009B28111F
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 19:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7BB4A3B;
	Tue, 27 Jun 2023 19:29:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047084A2E
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 19:29:50 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B566B19A9;
	Tue, 27 Jun 2023 12:29:49 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bfee679b7efso4813715276.0;
        Tue, 27 Jun 2023 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687894189; x=1690486189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWTyrHWo3DH4WeJQJV3ZkbmX57NNeA9KlEEZWcqodA4=;
        b=kmfeeAkPPfIIrgdhOd0Wz4grrEpQXcJmqHZ9HzQ7fuysvUZaCgExi22n1Bd0FYEXa2
         TjrE9q5kPQe+asD1MQsO/KQw9jNjLqwHALeKqPUWj3pQmhn7/nSkIGlqf3z/X61xjh/R
         myalWcsWU5YNZyIHwdJgQSDQVhJoGUC/LQINYA3cW8I1OueqF48HhicinqWQyRKHq2Yc
         9Wj0GmeNw10ae8KihoCV4p3gfxAoiPGK94CwRt0+F9xfmGWLsi9wv/evVGUy8lhHyUv0
         1yQA4cZ+v37F/eLCdaqLgyGyLvqzjd6JdzNw9iBMXhQcf8D62KtWLIQNh1mswSGQ/KSZ
         Znkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687894189; x=1690486189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWTyrHWo3DH4WeJQJV3ZkbmX57NNeA9KlEEZWcqodA4=;
        b=IC3vXvbKX7UOZ0b4IuopssrknTuRAvhw/25VEJcPm6nWr0kTFX6l27tIfxKEzJ1RVL
         GAhX03Aj119tWbxhxzHeoz5KS/hMUBye/HKEtAxhNxm8NRViyDj6Hl86op0pP04bdTcP
         YnjE9d12xWnvBFbBHqnejSGtKUmLKCN2pbXfpp9QxHHMve2ojaVCXSr+pGrnUYnIrUAC
         OYq1TGkQL8CCiqxpASoC1jw8V5MtYC482fHkzW8cZpqzABwksK0EVnmcy8gPteEWWFc4
         J5JR4IysbKVRXujPZ+y0kVURfkikI84SotcoyvTighszajdsw9bmto7h2LOWzJx2JlI6
         MhJA==
X-Gm-Message-State: AC+VfDwHvCZMV++cTT6oGAZJmiYQ6WrLw5uD8TEDl7ELIgJOLQ9doNQh
	SjaH4b429mXbTU6ukeDZoEjfLyf/FnU0qlBBnFc=
X-Google-Smtp-Source: ACHHUZ56nLE7/aI1LmL+DMoeX705IRHIayduaPNCBJtfc5MDE2Q8Y9FjW+iOMmg2yR7Tp6iZIqy4yeFOLbNspBtvAXk=
X-Received: by 2002:a25:6fc6:0:b0:c24:dea:a5e1 with SMTP id
 k189-20020a256fc6000000b00c240deaa5e1mr6059171ybc.3.1687894188822; Tue, 27
 Jun 2023 12:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230624002708.1907962-1-maskray@google.com> <ff7c875a-8893-9b7d-e2fa-200f1601e666@meta.com>
In-Reply-To: <ff7c875a-8893-9b7d-e2fa-200f1601e666@meta.com>
From: Namhyung Kim <namhyung@gmail.com>
Date: Tue, 27 Jun 2023 12:29:37 -0700
Message-ID: <CAM9d7cjyKmKk+z1z8qatjaC7xwwJa_PFE0DJzJ=_mFjS6taz_A@mail.gmail.com>
Subject: Re: [PATCH] perf: Replace deprecated -target with --target= for Clang
To: Yonghong Song <yhs@meta.com>
Cc: Fangrui Song <maskray@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Fangui and Yonghong,

On Sun, Jun 25, 2023 at 11:25=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 6/23/23 5:27 PM, Fangrui Song wrote:
> > -target has been deprecated since Clang 3.4 in 2013. Use the preferred
> > --target=3Dbpf form instead. This matches how we use --target=3D in
> > scripts/Makefile.clang.
> >
> > Link: https://github.com/llvm/llvm-project/commit/274b6f0c87a6a1798de0a=
68135afc7f95def6277
> > Signed-off-by: Fangrui Song <maskray@google.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

After 10 years of deprecation, time to change. :)

Applied to perf-tools-next, thanks!

