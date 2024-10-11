Return-Path: <bpf+bounces-41686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E665999A54
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DE01C21062
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA981E909F;
	Fri, 11 Oct 2024 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M621k/VX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A310E56C;
	Fri, 11 Oct 2024 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613301; cv=none; b=Gq9F1ATz+YYMYJMiP+ziGgwbNK9Va8kckfnzQzlJNbkgVHyPB5V2TVmpgK9PYPzINwRmDv5Brsr7x/ViVT/FCwwqmbBLhi6YITiixlsSi10OjVgwdKwXg/H3GI8G9z3I19E7nbhPyPPHVSKr4JHpzvAFifh6WTAEa9Ay2Dk622Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613301; c=relaxed/simple;
	bh=tc/UdZUOvlViT4RgdCT4OHnTBUnWQKwapgH7wTDF1BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvWZCBasDMpSUvJ+6scaTHq1TU3RULvupE+l5OAENp2XcN0lAeNpZp5dUz0Y53yPKXFjNc2IkRgIHcgTd9DQBOUkNvZWDZe2Uhep65M378W2nZKspNsWP4NHk/JUy+l5XEQuijwjP5zqWgJXHw9rq71L+KVY17ZQ6xUGwyXfp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M621k/VX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso613724a91.3;
        Thu, 10 Oct 2024 19:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728613300; x=1729218100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EGrwQX2pUhBJDuailgKFnmfWQOEkNWh/VZvU8d800Q=;
        b=M621k/VXqoN5D7IxSmG7fI7KI5R7U88RwrcmVAV01T/niiPSCSFAmL64jR6AA9ykgI
         /X8NP99TAHUc+h3rxxOTzO15GvC5CJFZC5knuZ7IhI/agr9B9vc2hdjMqhJtprJ8p97t
         U0pinxhS7GcRKSlMNIPzS3ojCBYQtV3SJV3mJlYZMg9ckCJMwMNRS3KPSijwE7UslZuf
         QDAwRequUYf0n/eqAFy66oUZ8hR8iQBQgjX2DbJiUHSdSQEXtRUs3TiSOGGAtxyBnZ6b
         FUR+RB3Nsd36TQJROoyMRFs1UVAVvYtN42Qgr/orExVxHFHQci0wbWu1IlbKjMSw3Cpt
         07kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728613300; x=1729218100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EGrwQX2pUhBJDuailgKFnmfWQOEkNWh/VZvU8d800Q=;
        b=AbXgg8HVOuQ1Zq+A12I4R97IocqZeML2rsqEMIRuJaI1qJ8jJm9cX9CLeCdRJl1wqN
         w+tOfFXq0XeeZEy5LAQYvOuW9fYN5c38YsMP790zVbPR7vYALFeJN8wp/yrZ/dGFWK/L
         TuOtTCkFpB66/GGausgQfAA+JHMtCADfkJjhpeKgqNqQ6J6JE/bz0oiLWO9ea5hRWLQK
         z4Oqv4zhlxYhK4BLAZx2vSRfIcVEbHEUpz4UAGKJJtlzx6spkf4/CdvPgi9iq3ncNCc4
         YSfDjyghIkWz8G3pJtvBddTBZX0HmY88btRB3X1mCHzejDA05Yd/ssR/E9srgIUMJSa8
         Nl6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKjwiXnKbbT2jWRgj+lkK/Zim2k5Xwb6K2q+WX5jqV6OtvYSAe6K3vx1frH62E39+6DRUwgLZGFdB0q0Tn@vger.kernel.org, AJvYcCUaZAbUeLk9YKCihsa5FL0/ed20bGWX8yFX6sn1xI5slPUszoh7zUtrAPVAd2Srp2U4zuxATEPpzDYiePViX4WR0cAw@vger.kernel.org, AJvYcCXabwF0GAtR9dqnO79uZwtLsPeMM/Mio/6yAcuBt6OfeUzTlf5sPoLp6psMomJlLktOTm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE4hx8IPYtEeptmDcaWlKWGEp/b0MFmEA7RkMZpkFa1aONLXLV
	AYqTFe61xE7vQC8j6OW5MsmMXx5c42wVOttx2V+hZjQ1rA9VYw0kGD2HEFG7wtoKiblsiGoAvZk
	7X9+kX7qNnpg/zi8XYHi3f/umr3Q=
X-Google-Smtp-Source: AGHT+IH03cAV+DovPcVvb/EccNXJFTUB3iLVugPD6xNERlpYU/fH5Tg6carfeYvJAFfN5UzRgw+c+Qtp9ocWMuONdSw=
X-Received: by 2002:a17:90a:bf02:b0:2e2:ebbb:760c with SMTP id
 98e67ed59e1d1-2e2f0b1398cmr1742827a91.11.1728613299778; Thu, 10 Oct 2024
 19:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010200957.2750179-1-jolsa@kernel.org> <20241010200957.2750179-8-jolsa@kernel.org>
In-Reply-To: <20241010200957.2750179-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 19:21:27 -0700
Message-ID: <CAEf4BzYrbcT=Zfrp93_fqkFCRXXGGaDP2SnhyJq08AO8Mt87UQ@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 07/16] libbpf: Add support for uprobe multi
 session attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:11=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach program in uprobe session mode
> with bpf_program__attach_uprobe_multi function.
>
> Adding session bool to bpf_uprobe_multi_opts struct that allows
> to load and attach the bpf program via uprobe session.
> the attachment to create uprobe multi session.
>
> Also adding new program loader section that allows:
>   SEC("uprobe.session/bpf_fentry_test*")
>
> and loads/attaches uprobe program as uprobe session.
>
> Adding sleepable hook (uprobe.session.s) as well.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/bpf.c    |  1 +
>  tools/lib/bpf/libbpf.c | 18 ++++++++++++++++--
>  tools/lib/bpf/libbpf.h |  4 +++-
>  3 files changed, 20 insertions(+), 3 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

