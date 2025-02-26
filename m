Return-Path: <bpf+bounces-52612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F6BA45431
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 04:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AB21897E90
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 03:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F9B25C714;
	Wed, 26 Feb 2025 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAnkyHq/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD7253F05
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542197; cv=none; b=uH4f5QiXyCW1lhF6QPNPrsffvzUl4TvU/znnurxIeHZPPnIZxHnF6agKuqBR8JLHejaHx6mJvmCntlaeVoRF2c+fMX/GbVS2LttrgblU1zOWdQVJ643ByaBe8QozkK7RNlXpPlT5PtJ/mz22V5FKSNUGF0jdSiax725Ol88DWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542197; c=relaxed/simple;
	bh=zmDrXf5FJ1ilXdzQbkDkVlJQNEDCNsx0a24i+Uh3khs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbV6V2P4MCZ3uvJfP8CeP4yp7g5wRJwR5IFJ+y7gKvkzzDd10xJxUDpZZCUMTPb4n0mb49UuHR///qzVNmh4bD5nEw7sRlq7r2pT+AVpVtBvGPTljsksWbO1+jMkiPmpqoALdTFjRiXuJStGk0dv3iOt1sc5gJSUolSYTsfgf2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAnkyHq/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471f257f763so63248821cf.0
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 19:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740542195; x=1741146995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KuNgRIoNBTJwRNpRb9yYUnDtY02TqKCSg1ljb+1scM=;
        b=IAnkyHq/LFQDYSloZfRenfFiGvz/46rlxJw2wotYnPtJHKzOSUiQ/JYLmwDblefpuZ
         khzUV8VCmSvluATwRYl6fwRgkRWjqX3AGfI6lQvmY/Mf1iP2JoMbALVKjvEvEIviyosh
         pC8NkUexuZYAteQPzHvnwultPS7KdnamlUtzM2SOSwzKF6iPtZ8vx1FrIRvzbRgSavKB
         FDDM5Dji0zQdEMf/j5cjyaN3hcRt3U2xLatMwCthC0l1DPDkpz75cpCA/G5dd28LrQDQ
         iOpUZOoVeQsgCre5o19qzWIkafs0APdsJbHsptxIzF0D44+Lh1eNDiOM+SHDwO5WXpnd
         MIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740542195; x=1741146995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KuNgRIoNBTJwRNpRb9yYUnDtY02TqKCSg1ljb+1scM=;
        b=PaTiP+kN215RV2fXo9KQrO2c4GR3SX62b9kLyu/Z/DwjOt41D5Ow7ssN+Lzc/6OlD7
         ob5hN/pGmDA2XbheSW6n1yAp39F+FYXZYV6VvaKadDlvlTIQx3PquLyW7X/0OioWluS9
         Ofd6Czlld8b3p4Tx6XlD6qOzeK+GZCIEHomyja6wcQzl4L3sD/HWuNNQRCj66tZ+rzbA
         I3HHHNhxMm1U/hMVaf0YxFR6KXbn7k+Dq9KbtX1Z7k6nCyAq7ilUW/bSBVnSwGbqDMsR
         FupA0akhK+z93jJXRXc3dYeRyW3hkdB92KFEtyuWR5g+71nJdSpeuXYcDS1zIoHqPiOY
         gJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUfbu8P/8DicRxuxPIEGuKf0oDfpLuet3R+5oS/c5If/buBY9kQaHSkAymk3wVnCeWhOso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mf5b7ULNeNRZ0Cc15inK8P8PqZyJAWv8yg+eKQlj80GgLr+o
	yJrPFkVvwGNiQeVZ9JoASDpn/vd9u8tE94Yd7WB9pDvEKhkgl/JXd45H/u05IJ8q95s1MZiAqem
	EfjY8d2H8dOuYyHC4DAWNMzDqDlk6CNhfSzbV8A==
X-Gm-Gg: ASbGncuRaHD8QHiilXZLQweXKvCF4RiH/LjKip7M3ceUp9c19W14laK91nOXc8IszD1
	ns9z4zQ9u6lvdldib86EtIfI1kA2edL/MWfW/24fgUxzz92h/Ac4gBQrbxWKx8L6KnleVQBRcHA
	rzUD8Bazlv
X-Google-Smtp-Source: AGHT+IETRCGRWKND8HX9jJkH2w2Rm7OCx/yxKCJR7aY1Ve/SafHk8TPPxc32EmO8Uiede3dYetHuNsiSyF0/oUx2FK0=
X-Received: by 2002:ad4:5f8b:0:b0:6e6:64e8:28e7 with SMTP id
 6a1803df08f44-6e6ae7f7d4cmr254099656d6.15.1740542194719; Tue, 25 Feb 2025
 19:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224114606.3500-1-laoar.shao@gmail.com> <20250224114606.3500-2-laoar.shao@gmail.com>
 <CAADnVQKUYP8e_u5QWGHK_fi_LKyOO3voFkHyRLCuw9-qKiFmDQ@mail.gmail.com>
 <CALOAHbCM_9NotV3UqeOiK-s_Cd-HAUS+1L834Di1Pw75iyTCOA@mail.gmail.com> <CAADnVQK12yzwC=10yxoYUs02iCpkH+tZe881Dnc2_8j3cxsFdQ@mail.gmail.com>
In-Reply-To: <CAADnVQK12yzwC=10yxoYUs02iCpkH+tZe881Dnc2_8j3cxsFdQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 26 Feb 2025 11:55:58 +0800
X-Gm-Features: AQ5f1JqDcmtuM0SeZrsqshKb5Kyaqu2qLiejK06-ETlaRy2glCjoa9EaJNmoz88
Message-ID: <CALOAHbBE7MxYqW5PcVpda_DHmmDuG6vvQxjYi4jh5kua32CpkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpf: Reject attaching fexit to functions annotated
 with __noreturn
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 2:39=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 24, 2025 at 11:35=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > On Tue, Feb 25, 2025 at 1:30=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 3:46=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > +       } else if (prog->expected_attach_type =3D=3D BPF_TRACE_FEXI=
T &&
> > > > +                  btf_id_set_contains(&fexit_deny, btf_id)) {
> > > > +               verbose(env, "Attaching fexit to __noreturn functio=
ns is rejected.\n");
> > > > +               return -EINVAL;
> > >
> > > Just realized that this needs to include
> > > prog->expected_attach_type =3D=3D BPF_MODIFY_RETURN
> > > since it's doing __bpf_tramp_enter() too.
> >
> > I will add it.
> >
> > >
> > > Also the list must only contain existing functions.
> > > Otherwise there are plenty of build warns:
> > >   BTFIDS  vmlinux
> > > WARN: resolve_btfids: unresolved symbol xen_start_kernel
> > > WARN: resolve_btfids: unresolved symbol xen_cpu_bringup_again
> > > WARN: resolve_btfids: unresolved symbol usercopy_abort
> > > WARN: resolve_btfids: unresolved symbol snp_abort
> > > WARN: resolve_btfids: unresolved symbol sev_es_terminate
> > > WARN: resolve_btfids: unresolved symbol rust_helper_BUG
> > > ...
> >
> > I missed these warnings.
> > It looks like we need to add "#ifdef XXXX" to each function.
> > Alternatively, could we just compare the function name with
> > prog->aux->attach_func_name instead?
>
> Strings are much less efficient than btf_ids.
> Especially comparing across many strings.
> To minimize ifdef-s lets remove all functions that bpf cannot
> attach anyway (that are not in available_filter_functions).
> Then drop all that call panic/BUG equivalent,
> since refcnt on trampoline is irrelevant at that point.
> That will remove even more functions.
> At the end the list will be short with few ifdef-s.
> This is a temporary workaround anyway, so let's not get too creative.

Understood

--=20
Regards
Yafang

