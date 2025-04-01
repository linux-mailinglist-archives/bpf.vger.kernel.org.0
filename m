Return-Path: <bpf+bounces-55112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C29A78468
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 00:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5263AE38F
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 22:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19772144A6;
	Tue,  1 Apr 2025 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjpasMac"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D01E8854;
	Tue,  1 Apr 2025 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545196; cv=none; b=WuqlFd+6udyafMW01qVkV3zgtjecYZNpb5pVI/adVmGiUAKXUCnxY9fk11gKowuf3Q9LKTRSaDNTLnJfPVCMZBnxJ74yU0WcdObc/3KQusa/0+92XI0Nb5/MRGrvN+iXEyVQJCYy+qBANWKhVQPk8EzktYzBm4xYc8uBC4lr94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545196; c=relaxed/simple;
	bh=8AQAvDyaMhMVY2j4SU5UMr5j7ffgLFtEfYWwHBYe7pI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVrGUJ/v8327oazPzE2+Ub+jrYT1nR3RVduyjGkbZE+/bZxMQ07q84VHTtC5s/TMGmuu3A7DL8sLh2k9vfRJs1HLD9m7APXAG4QF74muxhzNuR3q3uoktSxkmON41rZOv3O+SAFjvxvKryhF3WteUZcBgBpbyXvymaTKCQbthrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjpasMac; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-303a66af07eso8343913a91.2;
        Tue, 01 Apr 2025 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743545194; x=1744149994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYu6Zg/XFavoCXahu5FxZXJJfvgTGH8lEtVwhtwJVMg=;
        b=cjpasMacNHor+E11k8iK0m+9AR6KX8Xf00PlYDQ9shIPDCPYMQgc5GD63fT6JJC4Du
         r67+GgrqIDzsltZaSlitfDbG51Hn/jGQ95QO/6KAt1pj1lhbIuXr8jNG6CPPYOpTIi2C
         TO/HhdiC528dciM5J8UOPl0vb9wgDQUn7r5Bvk5ovlwgtH/1lH2R1KTkdHoEOe4Gx/xL
         SUtwFDOViPcVhdgZOpZwATnEY0CE+GZO9lwIublV5GA60UwEEyMhA9zLYq+YDiCsSERf
         R9zbWfSSSnCmvrhBcBMsm8+O74833Vw0gaA8w84rRMG7j76qQRNu6jkCP+3iHNONdrMm
         GT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743545194; x=1744149994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYu6Zg/XFavoCXahu5FxZXJJfvgTGH8lEtVwhtwJVMg=;
        b=iBsx9IVLbRJdPeziDUWa1rSuDMLwy4hg0F4TqleBUGtKM0h1rOBZghytfcayjfKuKm
         kFm2t40/gRUw6FTZwtRJoLheLKnHoSlZqbicremyUa7Z0Y3hfDrdvIQabQbMf5D8o243
         0IrSGHZ457dAvho3RrynwpcmBTvbTHIhDsT2RwuRfJcFrM30Is419OPEttDcejxhSRSu
         KFJBd6TH4kS0GtlkCM4SRTmiAHciagF8wkulE9FFicqUgZge5PZerHjMThQBmPnzuEeo
         TnuXvvmLNgZN7V5tlHN9JglUdJgLulzKXJ5NiGwTnqLuvzIuUaRScivw6gSoCmhAsLvN
         Me4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT7WjP91t1iuskR8bONkyLD26S5EZVxfRXFTgtWBlqq+zxK0XpHZ3EeeTj5B1dRbDWZU+DQNTpbS2bDxrA9mGGvAVJ@vger.kernel.org, AJvYcCUdcgb51eqRyaWojQH23J6v6xUItFJgo0IijODJllM8cCjB43Dn7w7JX71u22eFI62EkLs=@vger.kernel.org, AJvYcCWQ2iMtKUdr/xT1rDYmCpltfaqJ9uYXssl37n0OvjJSPIppgNu4/kx9MIGiwK5Twmc39GsHpU/7Uk3+0NSh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4UyFLlQ+1Qm8Az7MrpkQ1rUl0weXXle3tzAc6pcQZ0D0MFWbf
	kaMlFvMra3s+YiHSVI4pY5aHc1BSL37cO7S107uHkLa+Bkf0KhVhE1r/1kB8ME8ly77k6kOySBB
	P8OqAMqto8DFxZ+qNiQ+HjUOkEWs=
X-Gm-Gg: ASbGnctCIwxQYmwzXjiVYYu7QNZCvdNbPu6c2B5CVu7CAp1upDA0v3nF2GF+aZhp9o3
	Zu8ySP2pDFjuAiUmFpyIidmdTkWUeu8iFF5YGnN6INDkSduxnsIhYc9/Yzvxda4bs12OnJhTnL2
	LpP/zgjsOz+dzFwxxb1mFSmI5UIlhahy3OnUWOtVhZRQ==
X-Google-Smtp-Source: AGHT+IERvPaxBrysC+e4JCILAIsd31ntmN6WeywrcyfH6dFJvTx3/pK+K72W5sGe0tkTAMO7WNYQtZ81EwwOZncae0Q=
X-Received: by 2002:a17:90b:2882:b0:305:2d27:7c9f with SMTP id
 98e67ed59e1d1-3056ee486b4mr500672a91.16.1743545194043; Tue, 01 Apr 2025
 15:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331094745.336010-1-chen.dylane@linux.dev>
 <20250331094745.336010-2-chen.dylane@linux.dev> <Z-vH_HiJhR3cwLhF@krava> <918395a6-122c-4fb0-9761-892b8020b95e@linux.dev>
In-Reply-To: <918395a6-122c-4fb0-9761-892b8020b95e@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Apr 2025 15:06:22 -0700
X-Gm-Features: AQ5f1JoI5vh6vg03OkQDgd1VCZ65IlMVf5VqtxtJnJMul4apg8nLqtuyww6UCHg
Message-ID: <CAEf4BzbOirQiAmowckX8OeiFUTR8yfkO6m+kY96VMy5f9rG26A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Check link_create parameter for multi_uprobe
To: Tao Chen <chen.dylane@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, laoar.shao@gmail.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 5:40=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wro=
te:
>
> =E5=9C=A8 2025/4/1 19:03, Jiri Olsa =E5=86=99=E9=81=93:
> > On Mon, Mar 31, 2025 at 05:47:45PM +0800, Tao Chen wrote:
> >> The target_fd and flags in link_create no used in multi_uprobe
> >> , return -EINVAL if they assigned, keep it same as other link
> >> attach apis.
> >>
> >> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >> ---
> >>   kernel/trace/bpf_trace.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >> index 2f206a2a2..f7ebf17e3 100644
> >> --- a/kernel/trace/bpf_trace.c
> >> +++ b/kernel/trace/bpf_trace.c
> >> @@ -3385,6 +3385,9 @@ int bpf_uprobe_multi_link_attach(const union bpf=
_attr *attr, struct bpf_prog *pr
> >>      if (sizeof(u64) !=3D sizeof(void *))
> >>              return -EOPNOTSUPP;
> >>
> >> +    if (attr->link_create.target_fd || attr->link_create.flags)
> >> +            return -EINVAL;
> >
> > I think the CI is failing because usdt code does uprobe multi detection
> > with target_fd =3D -1 and it fails and perf-uprobe fallback will fail o=
n
> > not having enough file descriptors
> >
>
> Hi jiri
>
> As you said, i found it, thanks.
>
> static int probe_uprobe_multi_link(int token_fd)
> {
>          LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
>                  .expected_attach_type =3D BPF_TRACE_UPROBE_MULTI,
>                  .token_fd =3D token_fd,
>                  .prog_flags =3D token_fd ? BPF_F_TOKEN_FD : 0,
>          );
>          LIBBPF_OPTS(bpf_link_create_opts, link_opts);
>          struct bpf_insn insns[] =3D {
>                  BPF_MOV64_IMM(BPF_REG_0, 0),
>                  BPF_EXIT_INSN(),
>          };
>          int prog_fd, link_fd, err;
>          unsigned long offset =3D 0;
>
>          prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
>                                  insns, ARRAY_SIZE(insns), &load_opts);
>          if (prog_fd < 0)
>                  return -errno;
>
>          /* Creating uprobe in '/' binary should fail with -EBADF. */
>          link_opts.uprobe_multi.path =3D "/";
>          link_opts.uprobe_multi.offsets =3D &offset;
>          link_opts.uprobe_multi.cnt =3D 1;
>
>          link_fd =3D bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI,
> &link_opts);
>
> > but I think at this stage we will brake some user apps by introducing
> > this check, link ebpf go library, which passes 0
> >
>
> So is it ok just check the flags?

good catch, Jiri! Yep, let's validate just flags?

pw-bot: cr

>
> > jirka
> >
> >
> >> +
> >>      if (!is_uprobe_multi(prog))
> >>              return -EINVAL;
> >>
> >> --
> >> 2.43.0
> >>
>
>
> --
> Best Regards
> Tao Chen
>

