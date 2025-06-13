Return-Path: <bpf+bounces-60629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E28BAD94D1
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 20:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471113A1F21
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 18:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE410233148;
	Fri, 13 Jun 2025 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRvw/CvV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD272236FC;
	Fri, 13 Jun 2025 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749840780; cv=none; b=YfCKAa2bVPMRqCMkGaB81nLGA6QmItn+V05+AF3wsFUDFcM+v1wUK4V9PDkvkNTSy7CW6sgjrWCpItAz6lv/TRSfi7TaunlCvZUfRIqTQJ1rz60UOkwbYp5i4StSEKGsWorWEAhDh4H9grc6o/w2Xf46arQlGnaq1E8MU4kRZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749840780; c=relaxed/simple;
	bh=4GG8h4VrUJ72KYx3JStbtJGGYIPOY8UMQiZqMjt0b+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVSuNH+q72NLW8JSoS7br9yeIsX6emboCWphAWY2REIJaqJ/z2zFVSwu02jLrtTHpW1czbjeXBRG+BM6f70yKClGCXOVuQ3JawNNzlWOga4OILUGefTQ+KH0OhtUk5ef/+IZHSDuzTMC/itzZDsbSaoA+D26N+HMzqVutjNXk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRvw/CvV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1535870f8f.2;
        Fri, 13 Jun 2025 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749840777; x=1750445577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiNV/nTakryBZy7/aqri35p4mFreiS8n/RLeN55SiFs=;
        b=FRvw/CvVt9iEZ/wVY2zWSzRMqZ+mQKZPJSUYW8hd2Qx/Lzy+vfsVuUeUX2OsBSpqxf
         aUhQcjYnVkVEvkWkwlB1V21ZM3zCxST+A8CxFRg76oDLQLalYcE3/y07l7o8t1h/x+HF
         LkS05mzYXMbZ1ftfmEYgTz/S2lW6Zhj2Apl9rZGk9TBc5snzDuKVffyYCGYN3c2vYQ9N
         /SOh60SV1LMI8ZU8aqPK7KE/iZP5VB2qKPf1PzRM6BGR+MKaRYGpv0a9lBE6RXVqnIrv
         Jg/3maNwRITLRyabsLjL9fHeOP0y+T/JFEDZOlrBtgG9TclPrCjEBOU5/8HQlBMeYmQI
         sjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749840777; x=1750445577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiNV/nTakryBZy7/aqri35p4mFreiS8n/RLeN55SiFs=;
        b=qFHmmqHCMsGrvLq9FceZHxDBuI8kzzBPDnAQ3/r+8Pn2T+gXYWVCbm+FfTpzN2S3pe
         lSiRDtVu/t5M8B8QEa8pnz0oKX6iEDzwN7CJcb94CnQaQaNeEpB3Kcp12P8cE4hJi8aX
         Lr3JSuhf3fuxSukz/viT2f6OkuXNBoEBTvET6ysY2bSHKN8NjE3YULf9W7LkrY8f7Dzw
         X5C7DBLF99f/lAPt46UEEAqjYHLSPdaIn6H8USxK9qZmMVzsYY8qIRrwuGk48DwfDpgV
         mZau0ez5IOcvu6GJInIK5R2yf8Us+CCD9TkV+FEVoKNaNU3gKcyrJJOKGiEWQ5sojwhJ
         Tnzw==
X-Forwarded-Encrypted: i=1; AJvYcCVB01RnAdl9OiILaq9BkNmZlJlybiLRacs2Nzq69JL2UEjPx2QBcu/ruUx7z1QgqaX+DwNsg4Y9n8O7PWpvdGdKNdKw@vger.kernel.org, AJvYcCWbPgq0K8hE+nCZMlpIGOVadDiJHWDHy434oT3DEx5k0c5kEf5Ezq9ZnF+jwW4VgkIHN5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUj8i+mAjfIg10Aox+HObipyB1PhBF9t3bRNShkXcQ1UJthK0
	kGALmRelPk7R1IBhpIrTYtFK7UIh7JCrthUtdcxQNWfLo7H5ww28FWU8iH3xGijMsch3a7G3j/U
	zcRsqpZV9IRpM5TbyXQesi+e35X+MQZ8=
X-Gm-Gg: ASbGncv+QX02F2vU+VlEc079VS1grM3+N7KA1fpRmTSfc0PETNroo4HKtBpHnatOQnG
	mZb60yxky8cFMGO4UQ4GI6XhjDCLuTAyrrMv2BDMBRMHiiLk9HXFy3jOxESy1BbBB1qLyMhecNY
	BrZCcYN17OHXEfoI9bSw0iWVt6yhT5H5uD1UZOOwoEzkmMmftCtUbzb2PA8pFf+MAnJTxo7Vr/
X-Google-Smtp-Source: AGHT+IGjeC/2sHP/3xV2aREWxija/hCdRDjn++PYArbmyRHRCDcQw+76Cm4ulAFCUyk5xiXD43VC13Za3SnnbIQp1UA=
X-Received: by 2002:a05:6000:144e:b0:3a4:eb92:b5eb with SMTP id
 ffacd0b85a97d-3a572e998a0mr718423f8f.50.1749840776759; Fri, 13 Jun 2025
 11:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612182023.78397b76@batman.local.home> <CAADnVQKEosaLbpLg4Zk_CcDSKT+Jzb3ScKQWBA51vLHt-AoQ8A@mail.gmail.com>
 <20250612222652.229eaa9c@batman.local.home>
In-Reply-To: <20250612222652.229eaa9c@batman.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Jun 2025 11:52:44 -0700
X-Gm-Features: AX0GCFssdBMjywfJptOVExlGYdngzOBaGqfQs8frgcbBiaOQYEqFjNxYC18X14I
Message-ID: <CAADnVQLkLPv6uvxXz0iWaA06KYXW8_P5fPPX2-WpXOYuXT-B5Q@mail.gmail.com>
Subject: Re: [PATCH v2] xdp: tracing: Hide some xdp events under CONFIG_BPF_SYSCALL
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 7:27=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 12 Jun 2025 19:16:33 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Thu, Jun 12, 2025 at 3:20=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> > >
> > > From: Steven Rostedt <rostedt@goodmis.org>
> > >
> > > The events xdp_cpumap_kthread, xdp_cpumap_enqueue and xdp_devmap_xmit=
 are
> > > only called when CONFIG_BPF_SYSCALL is defined.  As each event can ta=
ke up
> > > to 5K regardless if they are used or not, it's best not to define the=
m
> > > when they are not used. Add #ifdef around these events when they are =
not
> > > used.
> > >
> > > Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > ---
> > > Changes since v1: https://lore.kernel.org/20250612101612.3d4509cc@bat=
man.local.home
> > >
> > > - Rebased on top of bpf-next
> >
> > We can certainly take it, but you mentioned you're working
> > on some patches that will warn when tracepoint is not used.
> > So do you need this to land sooner than the next merge window ?
>
> No. I plan on sending that code near the end of the next merge window
> to let these patches get in before they start to add warnings.
>
> I'm also going to wait till near the end of this cycle before I add
> that code to linux-next to keep the warnings happening there too soon.
>
> So, please take it. That way there's less likelihood of another
> conflict.

It was applied to bpf-next/net yesterday.
pw-bot didn't notice.

