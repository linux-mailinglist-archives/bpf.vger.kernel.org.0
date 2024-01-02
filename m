Return-Path: <bpf+bounces-18768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86473821E35
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 16:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F30B22029
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472612E5F;
	Tue,  2 Jan 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfcjT7K/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6A12E5A;
	Tue,  2 Jan 2024 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-595471d17baso620550eaf.3;
        Tue, 02 Jan 2024 07:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704207670; x=1704812470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyLOp+oiw0esAy0wQraXA6wAoRvZSK9pPvSbS7IUzRg=;
        b=FfcjT7K/Aa6JMlb2WldZc8tY2/y8zfTfwIq250OsYppLdUjhJf2DBpTo5/q7zRZD+s
         FuDAGgJD3jhI9oM+7lLKeEUQz+xuS1uyzOcn1m8laCZLFRYNcfuGgcrZxhh5n2TSLgIv
         g83oOT3qwyj4Ps2qw+9x+0fS4y/Nv70jEfp49lE06t+Pf3nVTjJl1xDDfF1ZbvvJwMPi
         z4HOTmI4zJU09zeftGOUISmZkqP8wzdZw/Adu6mb2IJf9ixhtorefiIQ3Atvm2xdyrsX
         Be3hBUOFizm3QXNrpdjNYH1VWWHcnrASrDnRPtXYah4DToB/XtihuB+I5rsgZrmNjFAp
         2mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207670; x=1704812470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyLOp+oiw0esAy0wQraXA6wAoRvZSK9pPvSbS7IUzRg=;
        b=XY0STWcCr5duuybY9m5t+fEuK8JodWoYG1lRW3G3QgINTiDrs/1JYWwciP7m/1bZo/
         p5m9ystf1T9SVQY+35ZJPsfV2JW2esZIHpaSwYr1XioTvQ8bhYI5PijoXPP7imlTSkEu
         lgIpW0g8Nz+6ecHTiHGTkNALPmM1h+o+O9btRNguL2F0keEDdzjEIRCr9lY8CHpK+8tP
         e1Uz4sryc/IabyJ6wQupn4GMAOrIoefXHfk7z7b89iqHD2liCMZELHwvnVf2t0J/0pBG
         kAHZGskGzq5YmkZ/BHx1h7/93fs5K3Kq5IYMfTmUZ15hTCxKEGSc/Bh/gYD6WHJyW3Um
         nYDQ==
X-Gm-Message-State: AOJu0YzmW3KjL5Nj1J7CDogcUDSCqNWJObC0jiz5xkPb7kjfFGjiUgXa
	ylmeUr4W4ve5EbfzCLz7yGXlh7VYAE/tYi39yiECTZts
X-Google-Smtp-Source: AGHT+IGURtiz3YBIe7uJ+I9DwaohQ0agFQnx8UfiF3MLBRhBFFE0f/OYUG1elum9rg9qBYgj7YsuZ8yigsW6xQpUtlQ=
X-Received: by 2002:a4a:d47:0:b0:595:b365:ffd0 with SMTP id
 68-20020a4a0d47000000b00595b365ffd0mr738302oob.13.1704207670235; Tue, 02 Jan
 2024 07:01:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL0j0DF-b9ye7TD3mB-BgHvJYCN61NB+QU8Qr25NvfEv0OjPAA@mail.gmail.com>
 <20240102093102.6a74566d@gandalf.local.home>
In-Reply-To: <20240102093102.6a74566d@gandalf.local.home>
From: P K <pkopensrc@gmail.com>
Date: Tue, 2 Jan 2024 20:30:59 +0530
Message-ID: <CAL0j0DGTW+jN3vcOvjCUfLTpTSfokhcRdGoM4WRVuGcxi40Ssw@mail.gmail.com>
Subject: Re: Unable to trace nf_nat function using kprobe with latest kernel 6.1.66-1
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sure. function was available in /proc/kallsyms.

Any suggestion how to track source IP and natted IP in bpf after NAT
masquerade?
Basically I wanted to know the Source IP and source Port after NAT IP
using 5 tuple lookup?

-- PK

On Tue, Jan 2, 2024 at 8:00=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 2 Jan 2024 11:23:54 +0530
> P K <pkopensrc@gmail.com> wrote:
>
> > Hi,
> >
> > I am unable to trace nf_nat functions using kprobe with the latest kern=
el.
> > Previously in kernel 6.1.55-1 it was working fine.
> > Can someone please check if it's broken with the latest commit or  i
> > have to use it differently?
> >
>
> Note, attaching to kernel functions is never considered stable API and ma=
y
> break at any kernel release.
>
> Also, if the compiler decides to inline the function, and makes it no
> longer visible in /proc/kallsyms then that too will cause this to break.
>
> -- Steve
>
>
> > Mentioned below are output:
> > Kernel - 6.1.55-1
> > / # bpftrace -e 'kprobe:nf_nat_ipv4_manip_pkt { printf("func called\n")=
; }'
> > Attaching 1 probe...
> > cannot attach kprobe, probe entry may not exist
> > ERROR: Error attaching probe: 'kprobe:nf_nat_ipv4_manip_pkt'
> >
> >
> >
> > Kernel 6.1.55-1
> > / # bpftrace -e 'kprobe:nf_nat_ipv4_manip_pkt { printf("func called\n")=
; }'
> > Attaching 1 probe...
> > func called
> > func called
>

