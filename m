Return-Path: <bpf+bounces-78381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA44D0C359
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 21:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D937430213D9
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 20:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A9619F48D;
	Fri,  9 Jan 2026 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdRd47OX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07890248861
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991665; cv=none; b=n3d7tj+OMiRVO/hGpzm276QIliIcnQ5lUHY8yskjKrJnAweFvMKf8QOatuiDlSO02qhpfnpbH3dQs0rzaneC+jFMQ+y58Jsk7yr0yu2iHBGLO3rAASOxJzbj/4ugSjrDPM8+E8rz4QeCO4Zbdm7c8RjTjSO8AHUjD9CyYTUeIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991665; c=relaxed/simple;
	bh=CKV38SzVlF2d1rURig5UXmlSxJit+yDiumkwA8mKHKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEibJZTVN4p74I/nKwyB0iLQl3E6EcIjunE/Fs5Wcf6XSJnsXnJMyFbkCgXv5r1iRgbZhq88Tw75QCDyYRnJGl9CCe3vvAl/AlBXaMS/NVIkH94gvYJ5pv1OeanN4YLNABzdJ8SwL/Z9NAgyajBzWSyq6RaSh2NBpNXcVl+S8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdRd47OX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so3950786f8f.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767991662; x=1768596462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5DkWe8BK5oL6p5BAqhKcrcL+HSx/OZlEGaRXpxjMqM=;
        b=TdRd47OXQAAzHsE5I8r5HQWlJ3CZZrg4WJ+YqnDPiQyqeZ97j7PdLLLMUF0tvp+4bt
         siCaly9HB5pTraibKgZwk1/LwCUCeWFlU1Nd7eUyANuwPVBsKLC0OZ+BlPWBpcZW2g6I
         9/TM089aRt7pZcOf4FGhdMpsl0sp/ZnV+WwQxcM4Lh+XdDNNJxeR332IEb5QHKpqD6YJ
         mb0kY6lBjxCrMcliDv24ZeSAFnjHKWYbFfAyxmlt3CiyiWF82ldhI6AKCJMH9aYTd0Wq
         L8p7SDaylAFwJ3JWSR9rosgEWPReyCGNvU7Gn2nrs+BAR3dGqRdBnmyq/VfAXbFTVA1j
         bxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767991662; x=1768596462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N5DkWe8BK5oL6p5BAqhKcrcL+HSx/OZlEGaRXpxjMqM=;
        b=QS3wVHcKB2b+eUnqVBiuxVJGft8QYYcBAPudAEu1EHbZMpwCnTasUjKLRn/cncfH/q
         XKA6uSMtsgnjWp73XbRiNpdUh6lIn388pEfjUalii1BIN1kHh7ZZln3yDAhRjk5eBo3b
         bXluCUr3ktWoUuD3VaqFuBBfgj/xRiNjgMMin14rREihyBaRnF0j26p9bF/MWMLx6FYV
         EgcbFrugK/EiPVwEjKfaHurBEDKC04m0prqY+HYEvcvnCTnBIv20FKfeVuqmooF93XZt
         8cmfQ96lexWep3l6Se3NRdWFJqSHYfZFGDQl94jaeAq+kSSEeb92eE9zQNU6GSNJnMs+
         g9CQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5SuwKnfkMFED0MkuLENhVEnIdofqkTBtf593VdAX1sZNWSTtoM2IUPwQm5L9THHPoGqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdf36+Sk9PwxRNLzZCpnZR6ECpQG07ggK/0rbqBQVejDFjm7rd
	zd1BrEIhcohlCR+ca4NPvjuZfb85R8LLWyeRkF7J28Jy6E2/HqW6MjwUlVuqpm2tta8V4yWrIrL
	gpPkDdlKxeaI1hJvUtjvWqVNiazHWk80=
X-Gm-Gg: AY/fxX5Vk2WLkOT+XFfAItYwd7Amma/gjq8AcmF3SPWzbnbz2X8JMAuCH7t2BJpOvUH
	bgUOEUpNrviALNYvCSNsdzl8QGG0loS6MPrP1kWbGVFnNl6HgLNTUbpzmeug/xYm+geJh9EosQZ
	jPvwl08GURwO3jJxJWXXjjGimkto+kl28/3VxzGj1jBqPAWaM3nKLLI8NFNz1akwSlO3rj1ZHoI
	WXbhNmaZYZXazX5p7q0Im3QG81/kDOMKlCluY7RMXcj4AzZh0XkyDubOWerJ8CiR1k5UpaGpOvf
	vkKCXbo09V2gU/hpiZmqpDflM6H6
X-Google-Smtp-Source: AGHT+IHdRKNK84BvX/aCBc8Btep0njI4c23O6CoinWvyMnx6DkJfIxAwEbl0kb24cRMMwbjEKTdgmU4n2r2OqzVXXSk=
X-Received: by 2002:a05:6000:401e:b0:42b:41d3:daf1 with SMTP id
 ffacd0b85a97d-432c37c881cmr13219905f8f.38.1767991662165; Fri, 09 Jan 2026
 12:47:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-9-ihor.solodrai@linux.dev> <CAADnVQJDv80_T+1jz=7_8y+8hRTjMqqkm38in2er8iRU-p9W+g@mail.gmail.com>
 <b099a95e-5e69-4eeb-a2c9-9a52b8042a85@linux.dev>
In-Reply-To: <b099a95e-5e69-4eeb-a2c9-9a52b8042a85@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 12:47:30 -0800
X-Gm-Features: AZwV_QjBGwB1G6T0jt0mlsOuxSvnjBYFN-lMj3ADwkO59Yhgq5O_-D2dT5zsknc
Message-ID: <CAADnVQ+_AmiwuupkVJTGyKY3KOp68GLuivs2LMEr0M_yaHPUUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Add bpf_task_work_schedule_*
 kfuncs with KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 12:02=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 1/9/26 11:58 AM, Alexei Starovoitov wrote:
> > On Fri, Jan 9, 2026 at 10:50=E2=80=AFAM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>
> >> +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *tas=
k, struct bpf_task_work *tw,
> >> +                                             void *map__map, bpf_task=
_work_callback_t callback,
> >> +                                             struct bpf_prog_aux *aux=
)
> >> +{
> >> +       return bpf_task_work_schedule(task, tw, map__map, callback, au=
x, TWA_SIGNAL);
> >> +}
> >> +
> >>  __bpf_kfunc int bpf_task_work_schedule_signal_impl(struct task_struct=
 *task,
> >>                                                    struct bpf_task_wor=
k *tw, void *map__map,
> >>                                                    bpf_task_work_callb=
ack_t callback,
> >>                                                    void *aux__prog)
> >>  {
> >> -       return bpf_task_work_schedule(task, tw, map__map, callback, au=
x__prog, TWA_SIGNAL);
> >> +       return bpf_task_work_schedule_signal(task, tw, map__map, callb=
ack, aux__prog);
> >>  }
> >
> > I thought we decided that _impl() will not be marked as __bpf_kfunc
> > and will not be in BTF_ID(func, _impl).
> > We can mark it as __weak noinline and it will be in kallsyms.
> > That's all we need for the verifier and resolve_btfid, no?
> >
> > Sorry, it's been a long time. I must have forgotten something.
>
> For the *generated* _impl kfuncs there is no decl tags and the ids are
> absent from BTF_ID sets, yes.
>
> However for the "legacy" cases it must be there for backwards
> compatibility, as well as relevant verifier checks.

I see.
I feel bpf_task_work_schedule_resume() is ok to break, since it's so new.
We can remove bpf_task_work_schedule_[resume|singal]_impl()
to avoid carrying forward forever.

bpf_stream_vprintk_impl() is not that clear. I would remove it too.

