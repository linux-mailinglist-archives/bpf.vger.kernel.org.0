Return-Path: <bpf+bounces-22365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEACC85CE11
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 03:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0AF1F23095
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFF72556F;
	Wed, 21 Feb 2024 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Knc4WKsL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E46FC9
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482947; cv=none; b=Se4qZNIlpddiDK9LGgIVHkU8UrWnc+vmj2V7vBxrEoSkZfB0swvRxZnxVwcRNbYy+LHC0dRO0Ln0swjJBUlAq7eKP5ipT1p1pKZciwIWW6NDAzSrzeueWm7I8wNOIhAO9D91YnkGf0fyxfG3/XDUosTrKgmPVV9r9kctmB3jTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482947; c=relaxed/simple;
	bh=p9KaH1kG3VIAPvn6SehcGM/nl6oCx50robP1zVqyyiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oai+kLXuhjfKgW5N+jFFRIkpPB5aQHFzi9AEwDvAcVlTZcTeJebVpt96UvNx8ZfqBK+z07ghzhJH4O8BXqwYWfJZKX6YUYQ/bVcLEu9Nq/ir1krEL02ptnjlOv/OVcfUMOVgWZRah0iQSYySAk595jIQijCgbfK9CNYgLKzp7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Knc4WKsL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29026523507so4642923a91.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 18:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708482946; x=1709087746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9KaH1kG3VIAPvn6SehcGM/nl6oCx50robP1zVqyyiY=;
        b=Knc4WKsLbxXXhhybJwmLWgSyt/SdRfHGPu/1RlvyOD/bm135Tozsb+xXYWj/1shIva
         TAVJm/g4jzYZT/M/TSl3ktqZNgR6yi2oDfcYnQmDwqB6pgPPD4ULaOlauugsCEpAeMUw
         KuNYWZhM6PkZxPcZpLCSDbV43uOE8MPaFUpHXJxWX400hHc//v/JaKZnyAcYXh0mW2bi
         feh7Gzy3c9faRCvBkRak6v4yi8F7UCU2NxFOTmEs5b5RCpN+Oh3/P8kIPZ/F055t5T/6
         mTM955odnTsWZc3zxDPqnRzX4HhwM2cgVqaY7JQOzD8+iekn9G/lG8HPbTnYY+9YtV9v
         lQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708482946; x=1709087746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9KaH1kG3VIAPvn6SehcGM/nl6oCx50robP1zVqyyiY=;
        b=xQ0cBxmLXILPQF/RV6+7uO68yPn2ZNDTm4Elzab/I7AYiYjTRyXK6QWH2T/OU4KGYN
         BoZQ8/WY6zPGUvrQJi6T5BR7oRhO1a5qdPnTWbI5Fr3sJQ293IMfImd7M3UCXDnwhVdh
         0RoqMPn5HMIFYDz6jC7qUX2r7XCdz9y913dLbHsXnhPL7/DNYBzdF2/g6JeBtnBaHpAh
         n97ZV5C4uv+rNTcbmWFK68AJ/wjNgHZ8uC82dCZWSYSon8ZuhX7gk1auvmZgXsi7K55n
         aWMfZvHQLAk4UTESw4OYyRz16nj6QUSmQudYmdFkA4BOrHjN+5SnFr5fa9I5RgN2/7NQ
         vKyw==
X-Forwarded-Encrypted: i=1; AJvYcCWd1cQXmm8aXh9mvR7rG78qz/2z3J+JeJUgggurHkY7aXHZ7Mk6HrTIg+eyKdD4pv2h/oSMqaWm5+iiQS/dlDK03V37
X-Gm-Message-State: AOJu0Yzu8VUJcY+0TcM6e0knGgi13Gyxreo8lN05m7GtpSItjBb2lb8M
	Az3vMvPCEMiGm3HA12D6RonLG+ADyrSc5YeDOJ2eGtkvCdbJ6l24dvZESE6bN2Pmd7f+o+908bb
	Rxtyaew7WTKDyYxQDnZ3SLgoUqBbNWSYTNfKTvA==
X-Google-Smtp-Source: AGHT+IGBqVse+WdjABfmLP3ERXaSmAAVszht4JUGqKAyn/R0pWRIclJneX1cjoLELZhhU7yURPemUQm9OhzpBLcsGpM=
X-Received: by 2002:a17:90b:1bc1:b0:299:6717:e54d with SMTP id
 oa1-20020a17090b1bc100b002996717e54dmr8268880pjb.36.1708482945724; Tue, 20
 Feb 2024 18:35:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220035105.34626-1-dongmenglong.8@bytedance.com> <CAADnVQ+E4ygZV6dcs8wj5FdFz9bfrQ=61235uiRoxe9RqQvR9Q@mail.gmail.com>
In-Reply-To: <CAADnVQ+E4ygZV6dcs8wj5FdFz9bfrQ=61235uiRoxe9RqQvR9Q@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Wed, 21 Feb 2024 10:35:34 +0800
Message-ID: <CALz3k9g__P+UdO2vLPrR5Y4sQonQJjOnGPNmhmxtRfhLKoV7Rg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next 0/5] bpf: make tracing program
 support multi-attach
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Kui-Feng Lee <thinker.li@gmail.com>, 
	Feng Zhou <zhoufeng.zf@bytedance.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 21, 2024 at 9:24=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 19, 2024 at 7:51=E2=80=AFPM Menglong Dong
> <dongmenglong.8@bytedance.com> wrote:
> >
> > For now, the BPF program of type BPF_PROG_TYPE_TRACING is not allowed t=
o
> > be attached to multiple hooks, and we have to create a BPF program for
> > each kernel function, for which we want to trace, even through all the
> > program have the same (or similar) logic. This can consume extra memory=
,
> > and make the program loading slow if we have plenty of kernel function =
to
> > trace.
>
> Should this be combined with multi link ?
> (As was recently done for kprobe_multi and uprobe_multi).
> Loading fentry prog once and attaching it through many bpf_links
> to multiple places is a nice addition,
> but we should probably add a multi link right away too.

I was planning to implement the multi link for tracing after this
series in another series. I can do it together with this series
if you prefer.

Thanks!
Menglong Dong

