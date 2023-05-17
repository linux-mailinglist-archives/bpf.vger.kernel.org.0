Return-Path: <bpf+bounces-724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB9705F64
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 07:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EE02812B8
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 05:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F38C5C9D;
	Wed, 17 May 2023 05:26:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C843212
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 05:26:16 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F054C40E5
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 22:26:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac826a1572so2347381fa.0
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 22:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684301173; x=1686893173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC9IkmejDz7U5L1FpIcZqA6R9eWPbcUEWLdIzgq+Ef0=;
        b=gf2ONac/I6/wrQJnQD9eDcx/8Z1ct20lT+jVKLAGnJ8Mk09BeFs135djoXZkCGhQGR
         Ylt7smGlVX9hUxA5gqEKqQKhD4WJdPli7ng2StBqmwC661LQllm8YMg/B4p1YEkrmcOL
         e1aAi3TSfD6faqKXaGY8wEtKrkzck/zg0kM9XiYwFhsQXDIIg8oFCcUQ18MR2uadUQQg
         0jwSzTppLTh3yHwWp34QSgfWdgd/RoEjp2Vkrb/XOV5daC6kRckp8OV7G+AHiLmPYclp
         nU1b/9nZXxeOURKqbuDpVcu5Yw4Sf5fAsnFZx1Qjzo5xO+/AdgZ9EfyXbVwp0FfrVZqh
         Ylmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684301173; x=1686893173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HC9IkmejDz7U5L1FpIcZqA6R9eWPbcUEWLdIzgq+Ef0=;
        b=TarvEMFN8UumuQ1n12ByVrH3fkuHXUBr4lj68ZV8wTe00x2XMp67zWPoN4C6ARgsVr
         qi8b0C92SOV2DvLFHYFglIfwos4YJ9LZLRV/vB1xzgEYmiZIk61WsUc/QRlEz19DEyyW
         uBf04mnw0+mHEEpWKQxOLyaY2PU+y7U05sMX/FvK3/YqWbWOvpmpOgthnkfBPDFy5tmG
         Mg+8XWhy2o2Gd7eh7EgzA3pZaNQNgs55uUkLJTPJ+WADN/TxBxX24HOfbcWBkt0YV6Rh
         43L9qf32wC9QD6ecppTu7Bs2BQnFF5gq/r9OldnNYPk2PvUC9sqBYQG0f4cuIY9l6DXj
         wxiQ==
X-Gm-Message-State: AC+VfDzpRbMgLhkoxHCWjYJIh7frT3ZOPTkZZruAPhGcGKsC8PbdLpa1
	v627OgeaThIj8INNtlcgHByOYA4mdCCkc4laqq+2aZUg+Fo=
X-Google-Smtp-Source: ACHHUZ5b6eYwkmWg+qknec1AQ9dqguMADrDQ/2SFqNqN4pzTLHgId3CcWfLreK7vf21pPuHTbyD4cP6fNKYPjhkiNHA=
X-Received: by 2002:a2e:8812:0:b0:2a9:f8fd:49ff with SMTP id
 x18-20020a2e8812000000b002a9f8fd49ffmr10195612ljh.17.1684301172924; Tue, 16
 May 2023 22:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509132433.2FSY_6t7@linutronix.de> <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 May 2023 22:26:01 -0700
Message-ID: <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
Subject: Re: [RFC PATCH] bpf: Remove in_atomic() from bpf_link_put().
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 12:19=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, May 9, 2023 at 6:24=E2=80=AFAM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks ar=
e
> > invoked within softirq context. By setting rcutree.use_softirq=3D0 boot
> > option the RCU callbacks will be invoked in a per-CPU kthread with
> > bottom halves disabled which implies a RCU read section.
> >
> > On PREEMPT_RT the context remains fully preemptible. The RCU read
> > section however does not allow schedule() invocation. The latter happen=
s
> > in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
> > from bpf_link_put().
> >
> > Remove the context checks and use the workqueue unconditionally.
> >
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
>
> Please see [0] and corresponding revert commit. We do want
> bpf_link_free() to happen synchronously if it's caused by close()
> syscall.
>
> f00f2f7fe860 ("Revert "bpf: Fix potential call bpf_link_free() in
> atomic context"")
>
>   [0] https://lore.kernel.org/bpf/CAEf4BzZ9zwA=3DSrLTx9JT50OeM6fVPg0Py0Gx=
+K9ah2we8YtCRA@mail.gmail.com/

Sebastian,

Andrii is correct. We cannot do this unconditionally,
but we can do it for IS_ENABLED(CONFIG_PREEMPT_RT)
if it's causing issues on RT, but BPF users won't be happy
with non deterministic prog detach.
Do you see a different way of solving it?

