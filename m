Return-Path: <bpf+bounces-30330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB6B8CC80B
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894CB284898
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 21:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F3914658D;
	Wed, 22 May 2024 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkuIM2nu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2C1CAA6
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412451; cv=none; b=RTKL44Y8UWidwfiYX773KTI/2qpeP/7GJDQzJQobdgRAxTUI/7O8KHmf5wJDKj/IhzuoqBnkZ7J+pCMMXdHR51cOSTO4qAugtzpnuPNsURn0JAsnxi/DAmaeNpfZZBPMqMiWapK77vYTXqW2YwHlgN7Z+kAyB2dhsruxLdNiIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412451; c=relaxed/simple;
	bh=oh5mFcp2etupYvHbgzAuzNJYbCB32Y38pDy0zxwmVUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vo04zKWwH3/08a2tXfzVaYp/0LVm9HPl07b2Im8t3F6owT4D7aJhqtzYFS0T0NCXaiqwhAelZGGXLwNnijEdW7/gMx2zRZeKTAlRsOvLRs5/V9B0sLIRiYlpAcFWNzcuG1syZTiJ+QwIwTSYuGcmjUirs3kDwllO6lYoOd8X0NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkuIM2nu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34dc129accaso1275897f8f.0
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 14:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716412448; x=1717017248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g416yFBVjE/oAx6LwxVnMCBmx4UxICWa/utg4BbTh/I=;
        b=CkuIM2nuXpVtQLae3G0filR9QImGobdsNLvA6CFFrfgw8aanU0c20ZVdt6UyF9ycEo
         aDDot7oF/G29EcO1iFEnRcN4CXSVwBCmq24wDebMLDVDREESoNJgvf8ad6lv1ej/ddFu
         xF3XV99TInIP/ECi5nlBUFJWoFqmGWhi4fxOA3iA7aWNrKuM4l8sDjNJ4IZZ8zsHXqsv
         qlefQfRCfcCDh+UlU+69svBHq8lVpvqtqPran/XAZXrcb35fdRg8BCwUEwYe7y85GL17
         7WQdYnV3tjFKl0JRbzy1BSYvkP84atF/ytBeUk7bytDeNhNsOu108ZvsnrAflIBfJ+Yi
         TvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716412448; x=1717017248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g416yFBVjE/oAx6LwxVnMCBmx4UxICWa/utg4BbTh/I=;
        b=GVk4MUOEmaHSdZyZiyahYTi1PvDjbGkUydmhd1di8Xa6VEf8YrT+KZoFEIP52B+xwX
         4OvZD5vc3vW6C0DVEHFQTcMZzEyfE3bu7LuMhNk7f501ZxzqMWtvnR3DIaxoOTsFsXlE
         +z/yoz5i06SVLLcX65gFtVgD1Itb51oXcET37uabeaPOG38ykOJmkia08FJ7yW0Vx4GR
         V8tkdUVDyotv8nm8PjHUGfwbfRFpr260B5GcAfOwzzUDLL8xCIRxsgii2w0QyOvrn/gL
         vWZ0KCVYvnEeDaBlEDf2U9LxA0FGi9CMMVfBp3ipxGVjCMCpRIZsluSwpaDUeStgkNli
         Ovlw==
X-Gm-Message-State: AOJu0YzTHGVr0pcRxmSr3zgu6Aap6+d4lh1KMrhVnoZhlskKYfOA0tzH
	PHGsm95A9OocyAJ4T3LKr0fFxK1ySJrOlrLLIkemIcF7M0wpHysvGAJRXXfBeHjRjm45GOPQ8Ml
	83AdN+jWn42qIsm9MAzmm1nESglfb3CLM
X-Google-Smtp-Source: AGHT+IEh2nOHDJcgVeU4Iu6Z34oPnIUUkLp6QrvWf2X++NBRk6UX8zLxFdGDV648ocnG6a0HgV+d3bHsNL7fuUd+6cc=
X-Received: by 2002:a5d:4c4a:0:b0:34a:1b90:198d with SMTP id
 ffacd0b85a97d-354d8d991b7mr2428283f8f.55.1716412448098; Wed, 22 May 2024
 14:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522024713.59136-1-alexei.starovoitov@gmail.com> <78fa1f7e442579a968a99b00230c6aa0f280679d.camel@gmail.com>
In-Reply-To: <78fa1f7e442579a968a99b00230c6aa0f280679d.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 May 2024 14:13:56 -0700
Message-ID: <CAADnVQJ_c0XTsNY_bfHL0qWfzpEdgy+-mJ1oqtHVppvxA2_TCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Relax precision marking in open coded iters
 and may_goto loop.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 1:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-05-21 at 19:47 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> Regarding this part, since we discussed it off-list
> (I'll continue with the rest of the patch a bit later).
>
> > First of all:
> >    if (is_may_goto_insn_at(env, insn_idx)) {
> > +          update_loop_entry(cur, &sl->state);
> >            if (states_equal(env, &sl->state, cur, RANGE_WITHIN)) {
> > -                  update_loop_entry(cur, &sl->state);
> >
> > This should be correct, since reaching the same insn should
> > satisfy "if h1 in path" requirement of update_loop_entry() algorithm.
> > It's too conservative to update loop_entry only on a state match.
>
> So, this basically changes the definition of the verifier states loop.
> Previously, we considered a state loop to be such a sequence of states
> Si -> ... -> Sj -> ... -> Sk that states_equal(Si, Sk, RANGE_WITHIN)
> is true.
>
> With this change Si -> ... -> Sj -> ... Sk is a loop if call sites and
> instruction pointers for Si and Sk match.
>
> Whether or not Si and Sk are in the loop influences two things:
> (a) if exact comparison is needed for states cache;
> (b) if widening transformation could be applied to some scalars.
>
> As far as I understand, all pairs (Si, Sk) marked as a loop using old
> definition would be marked as such using new definition
> (in a addition to some new pairs).
>
> I think that it is safe to apply (a) and (b) in strictly more cases.

Agree with this conclusion.
As discussed offlist we can add a check that
Si->parent->parent...->parent =3D=3D Sk.
to make the algorithm "by the book".
I'll play with that.

