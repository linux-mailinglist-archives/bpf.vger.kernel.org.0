Return-Path: <bpf+bounces-48865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF18BA11422
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08C3160E2A
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 22:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B735B2135B2;
	Tue, 14 Jan 2025 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnseXObs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417220F090;
	Tue, 14 Jan 2025 22:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736893955; cv=none; b=q4e+PFVBt6XSHHPxpNBTVCPxd9xTqC7hQ12GdYyuuY145xz23ow9vzQwViliQ3xhm4kDumoe9EWCDH3whE3o5lpo8OBgzGtXErSzCQFKXYqoAC6X5FT0wh2wZTp4A/qcHTfDjRnZOBcFokZL2tyQOKgAjQ4oePMapT3b1nL08KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736893955; c=relaxed/simple;
	bh=9aSAXbLT8Y/O7QYWW8AMqTJ8XzZEep6OE1DHz3XDhsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGNDanTY8xGp+RWIEHeZURK5qWeobh03iTnLU5zRSfbMdma+kc8Rn6CyRdTaXYfpYT6TR5rI2754fH1eY7L2P0EdJcso+d1tWmg+M5lTbZ3JtGSnwuZ9WOQ0ot9W6U50hZlA7fJcFRhC7b3fFqkbtHrrA/TlCMEVse8aCBfmd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnseXObs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso10042780a91.0;
        Tue, 14 Jan 2025 14:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736893953; x=1737498753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kabmU0F1TZfnF5oln3oXkhsupsM5B62wgwB4C8gG3I=;
        b=lnseXObs6Y5rllrP2VsR+iAvUny/bUAVTzN6fOuL/cU7zbktCuIv8fGdlUz+7o6hCs
         mORYcuwa/74vpUXoBmXp0qL6T/hhElHJpLOLjjb/DQa2o7JiCzzuKJiGj2x3Dsr2SqiW
         QcPt8KjZI7HvXH4M75lhojtK+y62I3MWJ4Qwjn6cJqaqQiVugfrREipVbYW0VIxy7lJv
         6B0u/a1T+NCJd2cCZsUxNQvFRQzmM2H4SQqwnn/X9yabMqJznrfD6g4Gq0gcEdv5qurR
         dW/d8/MuJ6y4uC6sfXMNj1V9DXaHDKeqHpPsbWxBxJBcxDcj8dki1C1q2k76OUsZzD3v
         6rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736893953; x=1737498753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kabmU0F1TZfnF5oln3oXkhsupsM5B62wgwB4C8gG3I=;
        b=ZW+983XQ/NctcQSQvwJEAQr3hrM616a8Lqamlp1wjvPiQ/HUrqRJBXA9dsKOT0d+bL
         xbo0GUuLHH1Nz+VlZMUHUlbFfHBa2FdCwH+iz6qzuT659ge2VXKNxv5pujgkwZOV84st
         3mxE/E9mum6cLb156eIHC598Krbo7Y7GFzdj6Hk1xOSfFxZM2IqpI+jz2ZgIWTwq3NGp
         V/ndpz0neN+Em2s+UbbUrP7dk+hRdeK4vfgRsvbBo8bVU1piT8Qbeo01uVxT6KOprpLj
         B8/c7uqOWNZNLIYxhnlbuPEDeVuQ2I1B03NBql8YxlqYdshluO5lo53Fps3oHyF3H0ej
         D3ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO4AN/ABPjQiYR0+Eol8lxtDLZi7EvGnIDLI5aSC3dVzczKmyVNSccL2FCgtzkl4+HRiI=@vger.kernel.org, AJvYcCVs/S7LkDlEbf3KU+JBDfUihRjzpWMs1qymifCrzoj/9xRqzIQeSOoVxha5AxeNTyxqSw2EeJXJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+jyiFRiSDqgln5L5yqhGREJ69oIAUpO57Zzxq4HrTe61S4VE7
	Ne+nKq3sPo1iDOH2n65WFxmZseCcActOP3pBaONUHMOCJWMu890xeZgcFZjtU4oJeguwrteyn1Y
	kgPFJVNAaZx0Ch/uMkujSTSx0cRI=
X-Gm-Gg: ASbGnctv5JmDRAElo/9blSfNXDwSMDTSnB+VGDCW2nrf7UnQgs18ULja5v78/XB+jdO
	PlfQWY364ebtEA47L0eX3Rx+fiYR0w+2U76ND
X-Google-Smtp-Source: AGHT+IEpXZbkt2vd3agPxz6COsslePzk8RMbBV11b9FAgNIE+WmfwtYEUiCqLr/xUm4vIMSXBDQ/SLrpvGSR529mtFI=
X-Received: by 2002:a17:90b:2b8e:b0:2ee:d433:7c54 with SMTP id
 98e67ed59e1d1-2f548eceae7mr36218369a91.19.1736893953168; Tue, 14 Jan 2025
 14:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112064513.883-1-laoar.shao@gmail.com>
In-Reply-To: <20250112064513.883-1-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Jan 2025 14:32:18 -0800
X-Gm-Features: AbW1kvYm4Itaq_DFp2jqD_5mLbxwaEwdwUeCe4q0HqgYWIvaRyNGbp6zSqyvJD4
Message-ID: <CAEf4BzZcs6YP067-KJYQRsMJMLooypepq8iiX7wXu7CZwVhD3g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] libbpf: Add support for dynamic tracepoints
To: Yafang Shao <laoar.shao@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, edumazet@google.com, dxu@dxuuu.xyz, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 10:45=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> The primary goal of this change is to enable tracing of inlined kernel
> functions with BPF programs.
>
> Dynamic tracepoints can be created using tools like perf-probe, debugfs, =
or
> similar utilities. For example:
>
>   $ perf probe -a 'tcp_listendrop sk'
>   $ ls /sys/kernel/debug/tracing/events/probe/tcp_listendrop/
>   enable  filter  format  hist  id  trigger
>
> Here, tcp_listendrop() is an example of an inlined kernel function.
>
> While these dynamic tracepoints are functional, they cannot be easily
> attached to BPF programs. For instance, attempting to use them with
> bpftrace results in the following error:
>
>   $ bpftrace -l 'tracepoint:probe:*'
>   tracepoint:probe:tcp_listendrop
>
>   $ bpftrace -e 'tracepoint:probe:tcp_listendrop {print(comm)}'
>   Attaching 1 probe...
>   ioctl(PERF_EVENT_IOC_SET_BPF): Invalid argument
>   ERROR: Error attaching probe: tracepoint:probe:tcp_listendrop
>
> The issue lies in how these dynamic tracepoints are implemented: despite
> being exposed as tracepoints, they remain kprobe events internally. As a
> result, loading them as a tracepoint program fails. Instead, they must be
> loaded as kprobe programs.
>
> This change introduces support for such use cases in libbpf by adding a
> new section: SEC("kprobe/SUBSYSTEM/PROBE")
>
> - Future work
>   Extend support for dynamic tracepoints in bpftrace.

Seems like the primary motivation is bpftrace support, so let's start
there. I'm hesitant to include this in libbpf right now. The whole
SEC("kprobe") that calls "attach_tracepoint()" underneath makes me
uncomfortable.

You can still attach to such dynamic probe today with pure libbpf
(e.g., if bpftrace needs to do this, for example) by creating
perf_event FD from tracefs' id, and then using
bpf_program__attach_perf_event_opts() to attach to it. It will be on
the user to use either tracepoint or kprobe BPF program for such
attachment.

Yes, this doesn't work "declaratively" with a nice SEC("...") syntax,
but at least it's doable programmatically, and that's what matters for
bpftrace.



>
> Changes:
> v1->v2:
> - Use a new SEC("kprobe/SUBSYSTEM/PROBE") instead (Jiri)
>
> v1: https://lore.kernel.org/bpf/20250105124403.991-1-laoar.shao@gmail.com=
/
>
> Yafang Shao (2):
>   libbpf: Add support for dynamic tracepoint
>   selftests/bpf: Add selftest for dynamic tracepoint
>
>  tools/lib/bpf/libbpf.c                        | 29 ++++++++-
>  .../bpf/prog_tests/test_dynamic_tp.c          | 64 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/dynamic_tp.c  | 27 ++++++++
>  3 files changed, 119 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_dynamic_t=
p.c
>  create mode 100644 tools/testing/selftests/bpf/progs/dynamic_tp.c
>
> --
> 2.43.5
>

