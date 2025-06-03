Return-Path: <bpf+bounces-59469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28203ACBE5C
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 03:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E541B3A5ADE
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 01:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C2E145B3F;
	Tue,  3 Jun 2025 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wbgb2rE4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A238821
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 01:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748915763; cv=none; b=BqkvFwpDKSRUHD3Se6iDfsgCuZ70cIfdfN2Ix7L/P4MHcDuwX4fadx/aHWqS5H4b+rJQuslcfRqDw6T2Fq8zz4qEx6a94NhcHDSA9kglWd9AuyyGH6MuPsz5G84Plio3K1930WijfMAY93APTNpWUyGb/zG7MBex2hw73lLt77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748915763; c=relaxed/simple;
	bh=TAsDJWuuzKn0DU8LhA8wgoEiT81dQkucIY/SWi6ZUMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaLjWTZU69vvBfR6kX3k8BHjeLOz+ej6vhJCAJRhHuojWBWQxkicjPkGAcQ4yLRXjHk0GdMz4zsX/Y6XEUgo6PJgFQrmQPuN0ygt5bXxkz+bVaFduMxeJ6laUy4ig9iDAhjkTnll9YPFl+5ErZU4RTWdqXbwYCuE0zUOrZoWAKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wbgb2rE4; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d51dso8675597a12.2
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 18:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748915760; x=1749520560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6eaOY0lRVn02Pd3a/ktxTeQ7lNEmX3tQQi8DDzMSeA=;
        b=Wbgb2rE4Q184XILkDROH6fms8PatMlF4BUNcL7UN7mdNzTMVNPW2914ZaylZe/OMG0
         M0zTCuhCWdClb1Bg5fi0wu5ciFhFnmlG4tFfzaizhF5rksM0m2p2KKcdQIG6O+P+Bkyi
         IECbTPMWaRqjNcK+k2+uPwoH8ETS7vC9nNHKUGEDhLEMAsisEKwH0HHHJXpUt5lyWL+a
         Pey7PDTwMmI17UdG7NKDPCbVIcVsoSSTT2kNioRwtqqaa6ErXR/BqtZoKhaN7f0q6ZXd
         cuevx864ifFIuNvvfuRfbItbjwWr4VJAFQLH6qpMocmoKy0DyoTOrKSKk62A906Z5kzS
         MLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748915760; x=1749520560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6eaOY0lRVn02Pd3a/ktxTeQ7lNEmX3tQQi8DDzMSeA=;
        b=Gplv/9j8r3cHdJvPSxbmRwTWAi+wgq+xpOuPitJPcTA/S2TJLHXgApx1wynFQv+mcF
         vtXWtTLnLjFeNO2liU4BuqXYuDWLBUcbm9lu9q/f+Rv3lilY7OOQT50X98J0rgvADInG
         kMga2KnUR3cRYJM70Fh+Yz725DmHyfKgs4+AzlLMF1O0bzZYe7c/7J7SttEoguO0EBzh
         vjF8vyJaiqIDzodDJ4ku9WY15JxnlihV4DVXYlDOH+++trmMv/wQfIlTpSIzxJUH2Jeo
         ZbGE80DA8ysiBRHq/7z2myp/trXKdz4N2uWQv4TOXeW8mdmpgYTy4tyqYnPfS3gTAYA/
         KrGA==
X-Gm-Message-State: AOJu0YwKmcjWsR/x8FTtkvzwOVPyvyrAyOSYaNSDvNr1Lk6AlXtSyLli
	f6bpJ9BjuUIHZnboVRHQ9nwvT60Zg2HGn7QXsP1UdfnY/oaFFM+MQDwjzzPOCQhI0vm0b0plBGC
	Ot5IIckK4k4nudVLjmeVINy2CvPCQFkRzcxvn
X-Gm-Gg: ASbGnctbmCIu578gSOCe/tLZyn2ixkDgJtPc+LGmIkptSZo/Tw2OER8xq1erzeze1z9
	/5/MBt97iohe7UMUIRFs/QW2uJtuDhOHXaLkmGpl7zOSmTER7tipLTpnUMFrKFAZEB+L0nKc1ZE
	DCfMi2xa+MaylocXqLGWWjm3DYTzQpQuIcD2iOzfHAY0pjDUgifnPUJaQsd24afQUtbFo=
X-Google-Smtp-Source: AGHT+IFSG7K5I5GZvzAUrNwUsFF2bPUFdy/21yGVOILbATOXXaHRYfLzmieGj+AulKEeYqv18cdO9vG8j88HJecfytY=
X-Received: by 2002:a17:906:99c2:b0:ad6:53a8:32ad with SMTP id
 a640c23a62f3a-adb32598a6fmr1519491566b.57.1748915759489; Mon, 02 Jun 2025
 18:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-7-memxor@gmail.com>
 <CAADnVQKZ6MwegovctyozRDBgQ6G03NsYKjtg3pzYdmA5bcPc1g@mail.gmail.com>
In-Reply-To: <CAADnVQKZ6MwegovctyozRDBgQ6G03NsYKjtg3pzYdmA5bcPc1g@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 3 Jun 2025 03:55:22 +0200
X-Gm-Features: AX0GCFt-H1MnQTskVCjwYpCjTaXjZ5MbFRVMfbgkTpVcDYb_xVBKXAzXgR2b6tw
Message-ID: <CAP01T75f++x1VG4zkqUKau_yna-6XX-RCUKtYmb696yuEN9yNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/11] bpf: Report may_goto timeout to BPF stderr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Jun 2025 at 00:28, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 23, 2025 at 6:19=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > Begin reporting may_goto timeouts to BPF program's stderr stream.
> > Make sure that we don't end up spamming too many errors if the
> > program keeps failing repeatedly and filling up the stream, hence
> > emit at most 512 error messages from the kernel for a given stream.
> >
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h | 21 ++++++++++++++-------
> >  kernel/bpf/core.c   | 19 ++++++++++++++++++-
> >  kernel/bpf/stream.c |  5 +++++
> >  3 files changed, 37 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index aab5ea17a329..3449a31e9f66 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1682,6 +1682,7 @@ struct bpf_prog_aux {
> >                 struct rcu_head rcu;
> >         };
> >         struct bpf_stream stream[2];
> > +       atomic_t stream_error_cnt;
> >  };
> >
> >  struct bpf_prog {
> > @@ -3604,6 +3605,8 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data =
*data);
> >  int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
> >  void bpf_put_buffers(void);
> >
> > +#define BPF_PROG_STREAM_ERROR_CNT 512
> > +
> >  void bpf_prog_stream_init(struct bpf_prog *prog);
> >  void bpf_prog_stream_free(struct bpf_prog *prog);
> >  int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id str=
eam_id, void __user *buf, int len);
> > @@ -3615,16 +3618,20 @@ int bpf_stream_stage_commit(struct bpf_stream_s=
tage *ss, struct bpf_prog *prog,
> >                             enum bpf_stream_id stream_id);
> >  int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
> >
> > +bool bpf_prog_stream_error_limit(struct bpf_prog *prog);
> > +
> >  #define bpf_stream_printk(...) bpf_stream_stage_printk(&__ss, __VA_ARG=
S__)
> >  #define bpf_stream_dump_stack() bpf_stream_stage_dump_stack(&__ss)
> >
> > -#define bpf_stream_stage(prog, stream_id, expr)                  \
> > -       ({                                                       \
> > -               struct bpf_stream_stage __ss;                    \
> > -               bpf_stream_stage_init(&__ss);                    \
> > -               (expr);                                          \
> > -               bpf_stream_stage_commit(&__ss, prog, stream_id); \
> > -               bpf_stream_stage_free(&__ss);                    \
> > +#define bpf_stream_stage(prog, stream_id, expr)                       =
   \
> > +       ({                                                             =
  \
> > +               struct bpf_stream_stage __ss;                          =
  \
> > +               if (!bpf_prog_stream_error_limit(prog)) {              =
  \
> > +                       bpf_stream_stage_init(&__ss);                  =
  \
> > +                       (expr);                                        =
  \
> > +                       bpf_stream_stage_commit(&__ss, prog, stream_id)=
; \
> > +                       bpf_stream_stage_free(&__ss);                  =
  \
> > +               }                                                      =
  \
> >         })
>
> I think this part can be in the macro in some prior patch
> from the start to avoid the churn.
> To me it's easier to review all key things about it in one go.

Ok, will move it.

