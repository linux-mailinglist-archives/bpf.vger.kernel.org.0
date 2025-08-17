Return-Path: <bpf+bounces-65831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F464B2911A
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 03:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF537482EED
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 01:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D80119CC0A;
	Sun, 17 Aug 2025 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EweB4VCa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0EC367;
	Sun, 17 Aug 2025 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755395740; cv=none; b=fL38QjGUUvB7dTHRAH3Cye4Fk41YzqWQgZiCsCRRGOzQWbHnevkCSm2IN9Wyg6TKel3faru4Nxjk10QG1ykdqjJgmUGrdAxMxsOZ7H55iN1rJV3Kh5GlXHmw9mTfwwFB8C0BL67SFgbkPXao4uJaarjSN/dATaWU6mhTdLHqqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755395740; c=relaxed/simple;
	bh=UG1faVmsxQoPdfzMJKvFH6SwLK2mkV1vBGDAZ6iKl8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3F12u3Qmov10LC0kJCGODaVvtmgafNNBbLNREG5NITSl8NXQ0wL9DPPwc1/mLeIkZYaRKt1LKwLqz3LKRtB64v5J4NzS7BV6kHmG2+fCizxaV+aejfK5PSsNg/lBtxbyCRf6R+KKKlqY2b/a0uG3Q/J6TwubodhpkUjzBOY+Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EweB4VCa; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-71d71bcab6fso16296527b3.0;
        Sat, 16 Aug 2025 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755395738; x=1756000538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68O+OOxnEG+kOK1ugXXr7TMacDjp+5EBzCtgr2gdegc=;
        b=EweB4VCaGh1scVJBlh8RpsrQ6VISE0J6u7rzFvIzdMQzUhyrqcwFvs5NEnlEPpUOse
         pELSlpmueQva3cWaviK75yTwGBmxL1EgWDXcQNW3MvEGklgaQYICuAsZzrd43VLBeJ4f
         pIfc8eHGKbXfNJYf6I/gE5YDEePpUCAUXYo3qu1bUhUTna8BmmpCg0I/ydU7oXAAjGLy
         JgBwHHqGQqj/JPSNwlWLPRLFGN44rtlNekHTu5WlFLwF/sCOeOgpnUEqKxW0cW6Lbt9F
         qsDF5vhD6lj11jM59Ju0UR2cZxEbnO263hcOaSaCzEbbjZB6dpb23EOJV5tk0jzrHTt2
         RP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755395738; x=1756000538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68O+OOxnEG+kOK1ugXXr7TMacDjp+5EBzCtgr2gdegc=;
        b=rbg4I52omFl1qXxSTli6Mtg5gxWDw8Ez1D0PVGjmcrrQEtXlxjLnEUD+CvOJFQEPTB
         wheMj8mdmytAXkaw++boKE3fnSF/AiyzHezUdQ+q2AzmtO63lS+PJUEpRU7zNehOCvQS
         hM6OxmCM3XquBalN7ts/+C2Y+t6gGMAjmOO+3YeJescWaIW+B+/tC7Fo52EIsgnBzClJ
         DKCuh/q5hDtwhLnJk9p16hk3GqL2/Y+vRw/e7MjTj1bIgQno5CMkcIDfuCIfe1+saQDl
         LXevCTqPcJ1N/Te1ozqJhuJ/EEwJ5eo4rDU1UfT9oobT++S/lY0ZAshhGqAFvbGtVrHT
         rEQA==
X-Forwarded-Encrypted: i=1; AJvYcCVFXWqXLhZ0VyNuGaElZHdI/MXmrMuwlqHkOd9ILSNLquK+zy495G3ZZLHqa+3mpMbLQ4s=@vger.kernel.org, AJvYcCWdVBj3Zcf22E07LgWENYtbrtJe1mVAwv1xrHusMFJ/K2d+s3KD1dtS9lXY6DW0GA4BslmWZYpyclUH7MXy@vger.kernel.org
X-Gm-Message-State: AOJu0YxKloZ/GYdL/8zjJvvZi9tqL9vnsunwXzp8qdJeb9rG9ekknLSa
	0o2yne8YtFHlDzA/phMwkpIfxyhmiP6+6iIsHnEKGtrkLLhkqbFt61MElu4r5i7ckXbH/RElazk
	PUbhTGgrVzzqPEfsPH8oXmjsiJOn+p3ODcmuWrSggTw==
X-Gm-Gg: ASbGncsM5eM6PjZWxX/aEi1CK1ndZ4hn6rxm/jjTnGuXAEq0lExML+wLvq10qGSSEfA
	4nFggCYPuSe869OnQ2mvcD55V+hWI7nw+DgWee977k3NG6m0R+ZVidh8FkkNg4uC27W+qlZavQF
	l/6rLSqtZhAM+VgIVDKKh0zfeeLsZrKBjvGtutE2FKj6uEBt7MoHRpa8GSMYLEIOxZmoX9FZ0aB
	GN7D5Y=
X-Google-Smtp-Source: AGHT+IGMt0olq8GgmkzTzRYbW/BLx8xpsaSZpG61fQsPEOxfJw/Ab7WlZ1E/w/RWb/TgJIMGLh0nsjfvoigmbtV76qE=
X-Received: by 2002:a05:690c:4a04:b0:71c:1a46:48d3 with SMTP id
 00721157ae682-71e6dd2e8eemr89264407b3.31.1755395738016; Sat, 16 Aug 2025
 18:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815061824.765906-1-dongml2@chinatelecom.cn>
 <20250815061824.765906-2-dongml2@chinatelecom.cn> <CAADnVQKA98hBSsb02djL-zMsaXQDCjn4Ytck+WP3SWfvgXqDYg@mail.gmail.com>
In-Reply-To: <CAADnVQKA98hBSsb02djL-zMsaXQDCjn4Ytck+WP3SWfvgXqDYg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 17 Aug 2025 09:55:27 +0800
X-Gm-Features: Ac12FXyv6ZWx5ytUUIqgTgvQbT7RFGc0u3xJ6hAVy-1YKW72-TzCDttC_IJWSNE
Message-ID: <CADxym3Y_1ushP8cYj8r7y0xin3zX3kObsM8_dCMUVtu54Tz9yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] rcu: add rcu_migrate_enable and rcu_migrate_disable
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 9:02=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Aug 15, 2025 at 9:18=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > migrate_disable() is called to disable migration in the kernel, and it =
is
> > used togather with rcu_read_lock() oftenly.
> >
> > However, with PREEMPT_RCU disabled, it's unnecessary, as rcu_read_lock(=
)
> > will disable preemption, which will also disable migration.
> >
> > Introduce rcu_migrate_enable() and rcu_migrate_disable(), which will do
> > the migration enable and disable only when the rcu_read_lock() can't do
> > it.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/linux/rcupdate.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 120536f4c6eb..0d9dbd90d025 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -72,6 +72,16 @@ static inline bool same_state_synchronize_rcu(unsign=
ed long oldstate1, unsigned
> >  void __rcu_read_lock(void);
> >  void __rcu_read_unlock(void);
> >
> > +static inline void rcu_migrate_enable(void)
> > +{
> > +       migrate_enable();
> > +}
>
> Interesting idea.
> I think it has to be combined with rcu_read_lock(), since this api
> makes sense only when used together.
>
> rcu_read_lock_dont_migrate() ?

Yeah, it looks much better. So we can introduce:

  rcu_read_lock_dont_migrate()
  rcu_read_unlock_do_ migrate()

>
> It will do rcu_read_lock() + migrate_disalbe() in PREEMPT_RCU
> and rcu_read_lock() + preempt_disable() otherwise?
>
> Also I'm not sure we can rely on rcu_read_lock()
> disabling preemption in all !PREEMPT_RCU cases.
> iirc it's more nuanced than that.

