Return-Path: <bpf+bounces-58993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A15AC5153
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 16:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F5C3B077F
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E892797A0;
	Tue, 27 May 2025 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5Ev8oZv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4F6259C9F
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357523; cv=none; b=HpY0MH0D8A032CVedApgjjfFFHS145nXwK3uu6XYcg/GtQX4nRxLgx3g0Md9+CbOvmRFYYPWaG1U/waGudGy51H7Mhsc8cVHmXpeNzgxAmc0AtxpnCmQNya962giEKkXVV6bjgo4942OIYmZfOs7j6axjEWmjs5H4VJ+gJtNI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357523; c=relaxed/simple;
	bh=k3kRVVUVWjqnWfzUR8lni4Z3CHJPlRyYtsP8SS8yu14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsyIKmNpHqXg1oDtPDBAiQOgWtTNtJV5kdltR+QWkNr5yGbbuC7/+SvTHVb1mGDnwPgW2DEBT7Gv7nSfOzYNQL8j+Ieqww2oWvS4kE08W1279pw6mJChK9BFkSMhn4/50dP60hBsEZZ+WbKJaaZEmEJWZ8tx51F6lq5bi0dNEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5Ev8oZv; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-60462e180e2so4707639a12.2
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748357520; x=1748962320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePOIMkUkZpz9f32bUQ8GkgwyyxGphIFdNMz/Rm4RtV4=;
        b=E5Ev8oZvZ4cqPka4GIyv8uHK62BarW1MqjNgKTKkqqpq9HSn6D6QOjQT1OTLJaiuSy
         VP5IUbq/KpzKovhU6mCRNxj71HQw5DO9vUkPFElBX09NoQYBCdjF7e6jhqL14cQtrH7A
         HLG4n4oFbZ+yZDPtUEGQS5SZU6anAbC2dEwqPzHhxNHJOf1YLTgK2WVN+3/8MCzCpYbr
         D0mGavYZjsFoTb8S2IRWle0OkAAZBgP/Da/uuX+GcHsaWsZL4wDyXqfM54BPUSBOAaxp
         Dj+WX2Wcx8bqpazGm92S8M3om0Z4r+ki6665YcB7rkLUf60KbDs5gmOiiM/9k6oripmD
         YXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748357520; x=1748962320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePOIMkUkZpz9f32bUQ8GkgwyyxGphIFdNMz/Rm4RtV4=;
        b=AdlmUgeEz9IuecxuJxDAyZGc7BLxaFeSgP9wJfJYNZ6aGcPZfg0xrO1KxlnXDuuRoR
         57m9jdaKLa7hL4NWT1M8IXVWUwewWxzMVa91dtzc/tEL0J5UwHfkAD2NcFhrLo+Un2CG
         hSXt7lu7YhkRdvbxDx3VWIEzMoybgkvUqtn1MlPlsOiXFvCwSeDekp5pszafBkle/DnC
         K7cd4zK1QLkjRnUqsBwGh8wcFWbUg8sxaxlgRNoDcix+0lJwX2720d3Co03WQU5pDk2n
         uCm6dAP+Q1m0d9pjJa06GhSIU7C5DhqsM/LQfJFDUh5w1YZ+TBDHleMGgVG/gz/yXAPj
         +clQ==
X-Gm-Message-State: AOJu0YwyTvYgUKqVIRSlQqhqfgUcAJHKna6eUTIQyy7YYcpq/ss+zeUa
	PurAZOXPSF9lAb2TNeovvMoPWyOwAMZm+7uNVbGL8IzPA8vyL7JT8L1GVzclBBAtsxKkXxfbIGJ
	q0T6Gxcu8mDfw8fHEjNTO46/40EGF8vg=
X-Gm-Gg: ASbGncsHx8ZP0PFZs1yufswn18ZzCgnKR37YhSErfrnr76hzm++Sxfb2bapUHcc+IOW
	cx3WNo5FEO6WGUS9deHQC4KRkKag93p/vUBuZEjW6dTh+dfptJxMNzEf+qNU7p02U96f8kR8H5M
	coff8Onw2qswX+9aZKfhQKcsPLaBxgTQavyrUMYFBmUDe3QFZcd5ZndpaTqqX1yBrx2Xo=
X-Google-Smtp-Source: AGHT+IHiPb8ZIHEdLf9OSQP0p4bBZ4rnpY4tgRGj60w3SPhGrel2F/Avi/dm74i9e9zpb0UsnyQAZK822XnGCZk7GfE=
X-Received: by 2002:a17:907:3d09:b0:ad2:4fb7:6cd7 with SMTP id
 a640c23a62f3a-ad85b00c695mr1298865366b.2.1748357519574; Tue, 27 May 2025
 07:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-11-memxor@gmail.com>
 <b8246692-6eb8-4079-9113-c1519221e55d@kernel.org>
In-Reply-To: <b8246692-6eb8-4079-9113-c1519221e55d@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 27 May 2025 16:51:23 +0200
X-Gm-Features: AX0GCFtfE5V4XVLIlI73izweYaQhMYQ7xkx6GK4rz_QoEp-HGQe3-jpOZXX7pqQ
Message-ID: <CAP01T75wfCu_GsvD9+MO-kkb_jRE6KCObi-DrmaVDzvePRY3vA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 10/11] bpftool: Add support for dumping streams
To: Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 May 2025 at 12:20, Quentin Monnet <qmo@kernel.org> wrote:
>
> 2025-05-23 18:18 UTC-0700 ~ Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Add support for printing the BPF stream contents of a program in
> > bpftool. The new bpftool prog tracelog command is extended to take
> > stdout and stderr arguments, and then the prog specification.
> >
> > The bpf_prog_stream_read() API added in previous patch is simply reused
> > to grab data and then it is dumped to the respective file. The stdout
> > data is sent to stdout, and stderr is printed to stderr.
> >
> > Cc: Quentin Monnet <qmo@kernel.org>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../bpftool/Documentation/bpftool-prog.rst    |  7 +++
> >  tools/bpf/bpftool/bash-completion/bpftool     | 16 +++++-
> >  tools/bpf/bpftool/prog.c                      | 50 ++++++++++++++++++-
> >  3 files changed, 71 insertions(+), 2 deletions(-)
> >
>
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index f010295350be..3f31fbb8a99c 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -1113,6 +1113,53 @@ static int do_detach(int argc, char **argv)
> >       return 0;
> >  }
> >
> > +enum prog_tracelog_mode {
> > +     TRACE_STDOUT,
> > +     TRACE_STDERR,
> > +};
>
>
> You could have TRACE_STDOUT = 1 and TRACE_STDERR = 2 in this enum, and
> later do "stream_id = mode". This would avoid passing "1" or "2" inside
> of the prog_tracelog_stream() function. Although thinking again, it's
> maybe confusing to use the same enum for the mode and the stream_id?
> Your call.

Yeah, that's why I kept them separate.

>
>
> > +
> > +static int
> > +prog_tracelog_stream(int prog_fd, enum prog_tracelog_mode mode)
> > +{
> > +     FILE *file = mode == TRACE_STDOUT ? stdout : stderr;
> > +     int stream_id = mode == TRACE_STDOUT ? 1 : 2;
> > +     static char buf[512];
>
>
> Why static?
>

Will change, not really needed.

>
> > +     int ret;
> > +
> > +     ret = 0;
> > +     do {
> > +             ret = bpf_prog_stream_read(prog_fd, stream_id, buf, sizeof(buf));
> > +             if (ret > 0) {
> > +                     fwrite(buf, sizeof(buf[0]), ret, file);
> > +             }
>
>
> Nit: No brackets needed around fwrite()

Ack.

>
> Otherwise looks good, thanks!
>
> Quentin

Thanks!

