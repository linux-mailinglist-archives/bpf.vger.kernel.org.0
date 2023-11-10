Return-Path: <bpf+bounces-14725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E117E791A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE823B20FE5
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 06:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2539053BF;
	Fri, 10 Nov 2023 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL+rBM5K"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B644538C
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 06:18:01 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EC05FDB
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 22:17:59 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507f1c29f25so2213303e87.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 22:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699597078; x=1700201878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT8lxZ8WzueexRDp/XsD2nE03bHELwQCRsE7MIUgk5Y=;
        b=HL+rBM5K+re7YSl2xMlbyeGxVFwYJ29mDX4UYv4O2c4JX9MCdUArXHkbqr+2FF0K5l
         9T+AUR/J7kn13zLFxX4LA29/w+dd7QEJde7sLoeKCPxxQuXiQxf/KsL8Aaep4QE9u0mk
         Fx9qvCq0MsHuq/ySNWFWZkz8b6H9ErViGvJ+DnkcTylAHwxecaZ0Do38SeBsYMe92MlV
         PU+oAiSNldF1PR/L7fam7fVJx+E/1vWu8RpXVw7DcV7iJUhREDlosIJRTvxTUeM6ZG4R
         q8Si+BBq/kwO9MRFnXvWkWxilsqfaP9RBn6JEv+g+xvBCAKSSxmu+QVjMUrVDyv516lP
         Pcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699597078; x=1700201878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AT8lxZ8WzueexRDp/XsD2nE03bHELwQCRsE7MIUgk5Y=;
        b=b8pCeCxV0xTGqGyCqHyxNm4WCuFnc0LgbicZDoqNm9jIAQQ6jDSMCgWc0IJLHkuGxq
         89DDSxIdVkJ17FUaWeDFDpkry592xc0NJr1aha1R25vjHCtLbE+79wB49DBH8vEXvhRQ
         zNfrPonFi0WnjDJbx9/N1nJO8UgkaFJ5ZGDPiZP/B7YmnwLT9EQu0Uhh5xkXPkcjxwtk
         8nKKUwIGyiuy7x2Z1ny802l+Td2XPzABoxAJiCjvhJE/X7lQ5KivfhPGav6VEl1ZaStd
         o1GClmHOamDqNPL7subXe6/zYBIfGKx0v7VtYGI468+KH0LlpsxxU2g0IO7dYOXLLVXl
         QMlA==
X-Gm-Message-State: AOJu0Yymv3q4p1IT1dtrFq8pvd1jQxF7BKLbxChN6/ToNqDF5hI4vuyJ
	XfUDaxbAS3AeChrkMYdBw5V6QzyzKrvTOW82bPDOVnMx9wA=
X-Google-Smtp-Source: AGHT+IEUkzqYTcsE2hch5m9giS9mcm0xUs4t74HsJbJjCAR8oLXbR8Qluxs/lX83fASw0STs1GNdSZsuGjUlODvlAwI=
X-Received: by 2002:a05:6000:1acc:b0:32f:9ad3:860f with SMTP id
 i12-20020a0560001acc00b0032f9ad3860fmr5631049wry.52.1699589671756; Thu, 09
 Nov 2023 20:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110002638.4168352-1-andrii@kernel.org> <20231110002638.4168352-4-andrii@kernel.org>
 <CAADnVQ+KtueBdD=8DazMhM3Xz0+YpLVW1-5-N4ZFiBOzji4vbg@mail.gmail.com>
 <CAEf4Bza1nxvLcBORkV+bKbKCz=f1jhRYM=PPaJxXDfQ7rmfJvA@mail.gmail.com> <CAEf4BzZFc6t5KCdCH4zYA1jp9UgRWHsEKgfMjVcc72qgH-FHXQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZFc6t5KCdCH4zYA1jp9UgRWHsEKgfMjVcc72qgH-FHXQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 20:14:20 -0800
Message-ID: <CAADnVQ+GzfdYSYAK5MYJ4cbOXsFPKG_Ly5CO5raCP7sopj9AXA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 3/3] selftests/bpf: add edge case backtracking
 logic test
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 8:05=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> >
> > When I was analysing and crafting the test I for some reason assumed I
> > need to have a jump inside the state that won't trigger state
> > checkpoint. But I think that's not necessary, just doing conditional
> > jump and jumping back an instruction or two should do. With that yes,
> > TEST_STATE_FREQ should be a better way to do this.
>
> Ah, ok, TEST_STATE_FREQ won't work. It triggers state checkpointing
> both at conditional jump instruction and on its target, because target
> is prune point.
>
> So I think this test has to be the way it is.

I see.
I was about to apply it, but then noticed:
numamove_bpf-numamove_bpf.o |migrate_misplaced_page |success ->
failure (!!)|-100.00 %

veristat is not known for sporadic failures.
Is this a real issue?

