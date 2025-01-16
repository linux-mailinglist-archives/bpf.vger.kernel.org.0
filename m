Return-Path: <bpf+bounces-49070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA868A14069
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 18:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37BD1679AF
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8732722CBF5;
	Thu, 16 Jan 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffNYlZMp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82115442C;
	Thu, 16 Jan 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047532; cv=none; b=Oqhow7wPFWje7JdWFB0xcx5rfA48b3bsN7aMGeViTAtr32OqQYKZIA8YAJ55LjdTM8OKdoOK5lPIAowGYTxJy3fjNt4hRNbhYlEJzmu9BbLJ1vZ+077KSKSP86xB906YAGOQ2NzybQRiVZOmuXaSeDoinS416pJ60vuUmgBt3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047532; c=relaxed/simple;
	bh=1ZjDAefkkir6NuPWAVn/XE5Z9Yh9OUEFfyK1SEkrDYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NF2PSjQQ0e2CSG2omNJU1HRfixax0GcXDxd7XRo+cogUk6QTTmbDKyHWVdDb+2wLoHBE03XhsS9jn7LiB5wcJUu56UcDVvNEaHkU+ngnfDKjn7/F5TMyG1I/4hIaeNbJJjmJRPcIAJpPeRa+a66uzbul3/qKXJ+ZjKRw2qkMoVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffNYlZMp; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29fe83208a4so691405fac.0;
        Thu, 16 Jan 2025 09:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737047529; x=1737652329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZjDAefkkir6NuPWAVn/XE5Z9Yh9OUEFfyK1SEkrDYA=;
        b=ffNYlZMpdNu0TWuAL6fqCLoZlsBQ10QisrHG5EWKt0VwQMvA8T5ey9sfc0eoE3wdXW
         y//6Fw7EMxbWqAhHlwpzBbBMPr4xqp9eP1MyQXf/K5eCyoPtSnDmcdLDISMeiThyv4DZ
         Cebbnl8P5US2YenMePO2s7vxL+sVvA6Q77wy+Vmeb6hxp8JYrt0/GMaiwANJad/TXhf7
         KAeoqFEl9Eiy2TGkJWPrUherGbHZdu0FyCZkkkwrLRvZ7OAfyvbJMC+U4hCBUOybtnKY
         td7ZJalKiBCNVayEy6LhZs8CciuignFlrVhZ0prK5HllwhJ6oFk4ObSqhVzeQaP+3M9t
         rt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737047529; x=1737652329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZjDAefkkir6NuPWAVn/XE5Z9Yh9OUEFfyK1SEkrDYA=;
        b=XI7CN65gY41ovypd8JIQBVZiuM8xey0FRWp1nLqKdZwkMM7UJJJo5eMUWynoSF1NHO
         rFap6ddlbxTsivj/e2pReQkMAnSOiGnWq8Kr5141jP16Ycj1aXlRz5QWEfxE0ejPWbeY
         vu0soxUmvFDjyCHQwDKxhZNX56nJrSunKNgy/pLP3cux+fKo/XAdS2EzLCGP4pdRJgXO
         QMDcadtJ6ZmSGQoCf015LXFKobSdJn6gUQPzCJtldYcLp9pKbXD67xh48MWpUvpyvjaF
         fJnnXGbbRwO6D0zc70Te0y4f9v6SKSrMrlgypAewe2gJN7Nx1Z9bePVl+zW9MlrtzQZ3
         KbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJAa7g1V2mf+x0+cMb6ukGR7OyA8x1QuecEtZ3MhkH7cSK0GhgN0ZGh/bHQqX/Knr9Bw/CjoGDysEd@vger.kernel.org, AJvYcCW+PNCYlzwCWZg2ueMcFzQSpEpNRHPMYpSsbBp39/2e4hBFMs2z3swAhtGkzrY/Ns8AGk274eioA2VbUxp/IPPohGBN@vger.kernel.org, AJvYcCW7CttuZzwQea8HHAStYIogS9V3wlDcHdmUZhe/1ZLKbWqh0Z1Lkx9DsInQCYC8/xhKNm0=@vger.kernel.org, AJvYcCWBw4+qDpuAnvmzauoijEbmNF9fsKrNLbx3TBMrwJdq+UK7Tfm2ZlOHMc+KQtYGjtNMnK57HuLS6x/p9kOR@vger.kernel.org
X-Gm-Message-State: AOJu0YzpgZ2C3Snvu9n4N0pv4ZhrPHZnz5vNCa/77Sl69u6xrrMbp/ps
	7wq5/bPFnT3GD7vami0mBaI6VIk3YC28ld24aFErlPHvSrMCxBCtLr/gNcu+l4fJ2zMsBh6Lh5u
	YMyXqAyuaYj70NVELYJu3XjCMLQU=
X-Gm-Gg: ASbGncucjB7F/pYh12Rm13kNV7bJTbIpGNYih8kCRCx/iXArI8YJuznYhRg6Qfq/HGP
	fQ0uC3dsvG+e+SHan8so1UhN6li3RIYqkYqBntw==
X-Google-Smtp-Source: AGHT+IFE5YOiTCzwej2+zI3c0cxmQVw/BAMwETsC/4JHp3F3p0g2wuJSUxCQg2x7/drM7Z1WV0NDYdh2JHNE1GOSkcA=
X-Received: by 2002:a05:6870:d14a:b0:2a7:8b78:e902 with SMTP id
 586e51a60fabf-2b186a772c9mr5104602fac.7.1737047529676; Thu, 16 Jan 2025
 09:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114172519.GB29305@redhat.com> <Z4eBs0-kJ3iVZjXL@krava>
 <20250115150607.GA11980@redhat.com> <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
 <20250115184011.GA21801@redhat.com> <CAHsH6Gu1kXZ=m3eoTeZcZ9n=n2scxw7z074PnY5oTsXfTqZ=vQ@mail.gmail.com>
 <20250115190304.GB21801@redhat.com> <CAHsH6Gtd5kYPife3hK+uKafjBMx=-23UzvQgnOnqNDzSZgHyqw@mail.gmail.com>
 <20250116143956.GD21801@redhat.com> <CAHsH6GukV+ydR+hw_-RF=0=_x6aO7xZzkCmbc53=Pk0Kv=8hUQ@mail.gmail.com>
 <20250116153044.GF21801@redhat.com>
In-Reply-To: <20250116153044.GF21801@redhat.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 16 Jan 2025 09:11:57 -0800
X-Gm-Features: AbW1kvYwkSvS83x9824ZSnXRqsuwoFy-nzCc8TqU2Npnmap9Y_QqEQG9C9BBJnY
Message-ID: <CAHsH6GshxQxw2euH_v+cvoCk=17GLQXgogUUWzLmo2P=gO9oLg@mail.gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, BPF-dev-list <bpf@vger.kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 7:31=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 01/16, Eyal Birger wrote:
> >
> > Ack. I agree.
> >
> > Do you want to send a formal patch, or should I?
>
> Please send the patch ;)

Will do. If it's ok I'll put you in a "Suggested-by" tag (or
co-developed - as you see fit).

Eyal.

