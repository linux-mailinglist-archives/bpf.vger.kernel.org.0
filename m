Return-Path: <bpf+bounces-43744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38F49B9553
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 17:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7D91F21433
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 16:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC641CACC1;
	Fri,  1 Nov 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alGNxX4P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CCD1C9DFE;
	Fri,  1 Nov 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478431; cv=none; b=gn4sizSIKkP9CbIwn+nTUzKTdzXY4SvpVMZc18O1nkWc6j1IhXL58J8Xnvq9inVS1VJrVMdnkcyG/9R7z0h1hLkHM8ER8O2Dji5Mu0CSzDz1SLSuVU/8FHqGsymSDDRjowBlmy8+WeMy52RVUof31EKA9AmHcltFr4x3ljN+1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478431; c=relaxed/simple;
	bh=ZmIoI9PA6fIEVj/7yw5DX4LvbJaFbegZUheZe3LGM/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsH/hBd7KgkrAexeHe7i4KxBFtSJvqryC/Kwm+vIgKNhruFuGfRoml11/ewavO4XNFoRfEUB+198d/+ibCx16f7bIiehv4pGaL+E03+bvtE7BV5P2Jq8Lvl3b1vTDlTZGB++VRqi5A3f6GyvJ75onppsqazDSXMtGtLTqthMQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alGNxX4P; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d3e8d923fso1359222f8f.0;
        Fri, 01 Nov 2024 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730478427; x=1731083227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLYY+R9EbouSvKSthrZJT06QviU9iWM0Wdkcc7CpKew=;
        b=alGNxX4Pojc4chtL27EUegTLdczJ8aBCI3fWPdXiIq2Yb7dzjTl6MrkbppejAmz75p
         P59ieI6TZ1n5Bq65mukc80C5fvSV1GO9AQayDN6qc3P8SReXuJ2W0b9Jd9adQe5H/8Mr
         DsLIPswsLwgHOcPdnA19rumzntNLhoi5B6gynVsdQB3ZzZFuU8yym7CwSVQC6sMHKypS
         4MEEEP5rS5aJ1DR+15DfJjMcyGxI49JqyNwxp07zR2NRq2vEa65XeJ98UbXRWjzTSEQN
         wR80EXVEtRq/BcS86TVG9zyI8EZV4NRdAKO1mdbGEJXfwoNlJ6YIGCzWWNPkXgQrnUHf
         G8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730478427; x=1731083227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLYY+R9EbouSvKSthrZJT06QviU9iWM0Wdkcc7CpKew=;
        b=gdx1So73jC5BkKa8aGygsiJuel5Y1/FcbMU8g0L67f+MMf99ALmt+sWPD0vBgxbzVP
         f66CGMQC7/Nc2gGn190qCfPHNfgisO+wS3mL+o1cg7pDBgBKMVWeE6PB48dRyihIkTqJ
         IKGiwo8cltoRx9F1AjZ/99s1gncFuGGsK4KXwFouQpjW8kMrFRA22Eg/nM4hF9G3c28H
         ZFFBELmvSOHuOVLv4bZYb/0hu4JP9fV8Y2+r9HjrVu+g0Rsof6vFvZQCP6cmGOxf23Fa
         OnnHmezMzzfDYpmONRvP+iPebtGSkOIouzrYVWmxPz0at9qAavJXJFrrHhkdDqU/b4aQ
         GV/w==
X-Forwarded-Encrypted: i=1; AJvYcCU8EQvCgx7BU69Qh9v9Xt2P5v5C8IfBvyKqEJV5d1lBkncC7hDG+0RwpKWoUc51b59HGW8=@vger.kernel.org, AJvYcCWNts0FrS1rrAI9kj3T/f6SSpB3w4uwzKEM1YUzZ44KlaO/fQEd76+zvMAlAmq9UlNN/0ndcc0L9nc0KUpu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7kBd8X5geIf0IZeBeukPGTM3GIRTqp+iJ9TmQDUhpYOR5Huw1
	FOzrw+kOnDCIyI8WyFvQzEjI9RIgxSBRL/e1Y1acqie1kblcv0TTtcWx+EqkEcg4L7aviy8zasy
	PiGYsZ+Op5of7ppdaKxBLaaGXk8HV2w==
X-Google-Smtp-Source: AGHT+IGNJTH/QbU41hcv6IRF/s4Zb0h3V7k2TDKfPZNWnNOrbo7zXcVq9RECL7gQ7lVXuzz3Yh2E+QoHrS+X8CAUeSs=
X-Received: by 2002:a5d:5cd0:0:b0:37d:4c4a:77b with SMTP id
 ffacd0b85a97d-3806120e398mr14457591f8f.58.1730478427278; Fri, 01 Nov 2024
 09:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031210938.1696639-1-andrii@kernel.org> <20241031210938.1696639-2-andrii@kernel.org>
In-Reply-To: <20241031210938.1696639-2-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Nov 2024 09:26:55 -0700
Message-ID: <CAADnVQL-YGPDcMdJEu7E7-OKpzUaE8Kax7zOW-JYi4aPNivN7w@mail.gmail.com>
Subject: Re: [PATCH trace/for-next 2/3] bpf: decouple BPF link/attach hook and
 BPF program sleepable semantics
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:23=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
>  static inline void bpf_link_init(struct bpf_link *link, enum bpf_link_ty=
pe type,
>                                  const struct bpf_link_ops *ops,
> -                                struct bpf_prog *prog)
> +                                struct bpf_prog *prog, bool sleepable)
> +{
> +}

Obvious typo caught by build bot...
Other than that the set looks good.

