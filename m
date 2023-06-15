Return-Path: <bpf+bounces-2645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D02731D92
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 18:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A628148D
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB4182CB;
	Thu, 15 Jun 2023 16:17:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36F15AE1
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 16:17:46 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA55C3
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 09:17:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b4470e1500so11722471fa.1
        for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686845863; x=1689437863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkOWrf86Mam2v8kp/hOctV0jsvDdu4S/Uec0JVMybMM=;
        b=K9Gv2u+c33J/IM7fEsSnGtdwzud3ruVc0uTIqIINcvvRZUIDmaY5wzc6gVXLEJVulU
         l5OIG4LB775SX1hGFkvjAXPlm3629He58gRsYD6J73ElVuHF77RSHTq1fCFfKgQkSo0I
         AugDkupZ2zXD6DPhiuBBRl1DN/6m4YaghYOmGXfCxmB7Rm4h28lr8EyLqA+aDnwBJuL6
         4YyPQ0emVss9InNCzEYqcAnWQvffwET4p4dFc2FF457I631LFZm6LheF0l2an4Rq+bcn
         4pPtQMfnODmQ80XaQ9FmZ2c6ZS8RBw40JXRIZyXz8uO86eyfJ1y8zeIfBDfCnhf3uWgQ
         ffVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686845863; x=1689437863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkOWrf86Mam2v8kp/hOctV0jsvDdu4S/Uec0JVMybMM=;
        b=iueaF5Hy2L/xIMBRKFXLZeQtgYFb8wsut7nRx0YVn+DGyh+QfhyKpd/g7jz6KhKypy
         PT+m8rsGLnQ2Hz2nShi07QpIzOsI5V+QKp6NJUJMS+ogg69VBRL3j57l3UgS2bOig20p
         +JomHUsDZMiHGWJlNbvYZrVsAFizScPP1D5Inb6IVMwi+nrxzBbwUPAYwxJ4+Z3Vy6xb
         r11aQomAWtfU6CxDzrpUmt8MdtgAhQJa9wK2MQ8f/oWF6oeNrUPFJ7M95bakCjr0tZbb
         qwmUx5KBWKGKBWHhZaKbnvZiVaQY/ZXu0Ql7dTWfRLyCLGywK+o1otlzH2P4dEpBvnej
         2uOg==
X-Gm-Message-State: AC+VfDyNUkA0oBepmiMBK60XyAsKscPfDj2hRoVqeODA6jjfjYHKFoqH
	GMDT+CcTnXfFnbFgI+I4sDQapBvyzJgWRuVMVlLX+tc3
X-Google-Smtp-Source: ACHHUZ5gKRGoI0i0xy+G9TyfiQeAQ1XQIYa80kERxaR9lXooLDUK5//ITySZWrZrLJgPwss9FbiT0ljR/zvLJsJuTXU=
X-Received: by 2002:a2e:901a:0:b0:2b4:48de:b2cb with SMTP id
 h26-20020a2e901a000000b002b448deb2cbmr1072229ljg.50.1686845862376; Thu, 15
 Jun 2023 09:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd173bf2-dea6-3e0e-4176-4a9256a9a056@google.com>
In-Reply-To: <bd173bf2-dea6-3e0e-4176-4a9256a9a056@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 Jun 2023 09:17:31 -0700
Message-ID: <CAADnVQKbNjKJgYODUS0zO3dR8dxEcFpgY3GkhEEmwT462HW+wA@mail.gmail.com>
Subject: Re: Calling functions while holding a spinlock
To: Barret Rhoden <brho@google.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 14, 2023 at 1:32=E2=80=AFPM Barret Rhoden <brho@google.com> wro=
te:
>
> Hi -
>
> Would it be possible to add logic to the verifier to handle calling
> functions within my program (subprograms?) while holding a bpf_spin_lock?
>
> Some of my functions are large enough that the compiler won't inline
> them, so I'll get a BPF_CALL to PC + offset (relative call within my
> program).  Whenever this pops up, I force the compiler to inline the
> function, but that's brittle.  I'd rather just have the ability to call
> a function.

always_inline works as a workaround, right?
And it's guaranteed to work, no?
I'm not sure why you're saying it's brittle.
It probably generates less performant code,
so it would be good to add such support.
It wasn't done earlier, because spin_lock-ed section
supposed to be short. So the restriction was kinda forcing
program authors to minimize the lock time.
Could you please share the example code where you want to use it?
Just to make sure we're talking about calling bpf subprograms only
and you're not requesting to call arbitrary helpers and kfuncs
while holding the lock.
Some of the kfuncs can be allowed under lock if there is a real need.

