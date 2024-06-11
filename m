Return-Path: <bpf+bounces-31848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E6A904057
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 17:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A684F1F25D52
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 15:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9882383A3;
	Tue, 11 Jun 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb3XMvIf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11BB376E9;
	Tue, 11 Jun 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120649; cv=none; b=L7Wxzn+xWmYtY/GSxx7afSiundFTZAbbJvm7OYiIt1ZiOkBNG+6quVhSSzVqQ56IY51VAqPY/SwRk90lUwDGc5MCDLu0CWlh9RU2DaqswSBSx+Vi7cptoMDCzELVZwX4myqL+2j9SEn3XEq4VN96vLzF9JWxX7Kqq1P6n25nCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120649; c=relaxed/simple;
	bh=DBNsg1rC/jcnLIlq0lcqjsD/lY864vvTgshgHj3EhX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHuBzem9IMAyjA988gFOJmEIyMDfJiZfWHlg81Yx2roMZEhVDW59RT705V+YdOkvCnjBkBkLDB9DR/GSHTiwUnu9Q11HgvAcatlYNIuMWPW7WFYFZr1RGuxaACya32jdHQpGadZACKWyZzWjpsQfpPs8tmjduq04Dk6EI/1SWxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pb3XMvIf; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-62f39fcb010so3401097b3.1;
        Tue, 11 Jun 2024 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718120646; x=1718725446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW82GS7eKzLFVwObKnP68TgmFv9WSJzEe3Ta59uYnqo=;
        b=Pb3XMvIf9GGTFJR/2aZRpFaQVH+nkJCh3iOZw1Yf/4/n12VodcGYzyOazahX29BLmx
         j/jx5091DYexpKYE2uC5cEoYeEpdYuYQmiwu2dHV9BNCJG0EtfKwAcWC8pgy+g6YlKBx
         e/olUyQkfjT174sJ8tr9btR1mStSglvKSW3F81TlyRrES30GXJxni0bi1x+rxVrBsycQ
         kwLydi+zOl9uM7sZQKVCgS+ScSdmREzbkou+Zg7CdpTMppqcW7cEtwwHGYoBO9sP3ws4
         arQ+u9eF1MIRT2kCDNQexNWDfvycwVhGa4T35eViHS+f6+Npx7ddTLCjZfgxAaFewZxa
         z4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718120646; x=1718725446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW82GS7eKzLFVwObKnP68TgmFv9WSJzEe3Ta59uYnqo=;
        b=YI6hBGTw+pJhlU7tMydTseDawYP0EJ4uPppUT++emzb6AKOzyUQPPjSPYGo5fuNt/G
         s44uSFnlPI++dub1a+gqjL3uQF4pQieYuaHKlhC1XymayLrQq3wTDgUOr6ATnzWgAa+L
         yWx6mpi63eeQ1mZqC7buY6CwbX4SAXlQd/Ls8+QkBzE25y6Kc3p6SXYNyZdewkxtzyJh
         ZNt6W7fTjzSIbcOgi7J32jWEaL3SZ5E3bC1kfsQbd04JiApFpet6INMUKlPn3prpWeKZ
         ewxgv/gLHO3wZLd9Ayv9QVpNzudL70bVtq5vYnfYTikNLAt/4DRo5OsGet/wHu02no7F
         U0sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrosTkNyec4BYGMB55COiCY4+ny33TW7QQ0a9X0ZnQKmeONgbfI85Zi4UoRjdTAgiYc66k8k+8ifBKWti86Gv5VWcAmCPePfC+TFmCuaGoH/Pm1qLFmIEe+tiLkUp/ZgbvoDLi9447EQu+q1PJKV48Klu/2HNkDh7w174EhOcI/aUhHpeLxGRrBduF5a/3gt1hgwN6x1bmPxniRfMgUpxeul550dONYzD+jA==
X-Gm-Message-State: AOJu0YzrFoAICRhtCeWKX3Ejd3fEiPfE/zyo9RMYaQN8WmhwX4T78G7C
	+LrasnCaG301nrom/LFqlFZvu5xrTnSFXUNtNTOLUzJGCzjehkDwFuHA25Ae8i30q/IZEqHghLo
	vW+10Ij5xP9d0wOgi1Bqgj7gG6s4=
X-Google-Smtp-Source: AGHT+IEX4PzRD1dBxbDuGigjdmHln9Tl2mPoHztJwq9MnPvO5Dd0wDH6xrTg1HRNfm9dWlWi4CgSMC/BYpMxCtDn600=
X-Received: by 2002:a81:52d7:0:b0:61b:3356:d28c with SMTP id
 00721157ae682-62cd5571b37mr125787047b3.2.1718120646450; Tue, 11 Jun 2024
 08:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172147.2779890-1-howardchu95@gmail.com> <ZmhsSF1UPcNZX8E_@x1>
In-Reply-To: <ZmhsSF1UPcNZX8E_@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 11 Jun 2024 23:43:56 +0800
Message-ID: <CAH0uvoj94J_1BX6H3kpCbw9Djrqf5BTG7XPsDbQSkg=ZBz27-Q@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix syscall untraceable bug
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	mic@digikod.net, gnoack@google.com, brauner@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Tue, Jun 11, 2024 at 11:25=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sun, Jun 09, 2024 at 01:21:46AM +0800, Howard Chu wrote:
> > as for the perf trace output:
> >
> > before
> >
> > perf $ perf trace -e faccessat2 --max-events=3D1
> > [no output]
> >
> > after
> >
> > perf $ ./perf trace -e faccessat2 --max-events=3D1
> >      0.000 ( 0.037 ms): waybar/958 faccessat2(dfd: 40, filename: "ueven=
t")                               =3D 0
>
> Yeah, before there is no output, after, with the following test case:
>
> =E2=AC=A2[acme@toolbox c]$ cat faccessat2.c
> #include <fcntl.h>            /* Definition of AT_* constants */
> #include <sys/syscall.h>      /* Definition of SYS_* constants */
> #include <unistd.h>
> #include <stdio.h>
>
> /* Provide own perf_event_open stub because glibc doesn't */
> __attribute__((weak))
> int faccessat2(int dirfd, const char *pathname, int mode, int flags)
> {
>         return syscall(SYS_faccessat2, dirfd, pathname, mode, flags);
> }
>
> int main(int argc, char *argv[])
> {
>         int err =3D faccessat2(123, argv[1], X_OK, AT_EACCESS | AT_SYMLIN=
K_NOFOLLOW);
>
>         printf("faccessat2(123, %s, X_OK, AT_EACCESS | AT_SYMLINK_NOFOLLO=
W) =3D %d\n", argv[1], err);
>         return err;
> }
> =E2=AC=A2[acme@toolbox c]$ make faccessat2
> cc     faccessat2.c   -o faccessat2
> =E2=AC=A2[acme@toolbox c]$ ./faccessat2 bla
> faccessat2(123, bla, X_OK, AT_EACCESS | AT_SYMLINK_NOFOLLOW) =3D -1
> =E2=AC=A2[acme@toolbox c]$
>
> In the other terminal, as root:
>
> root@number:~# perf trace --call-graph dwarf -e faccessat2 --max-events=
=3D1
>      0.000 ( 0.034 ms): bash/62004 faccessat2(dfd: 123, filename: "bla", =
mode: X, flags: EACCESS|SYMLINK_NOFOLLOW) =3D -1 EBADF (Bad file descriptor=
)
>                                        syscall (/usr/lib64/libc.so.6)
>                                        faccessat2 (/home/acme/c/faccessat=
2)
>                                        main (/home/acme/c/faccessat2)
>                                        __libc_start_call_main (/usr/lib64=
/libc.so.6)
>                                        __libc_start_main@@GLIBC_2.34 (/us=
r/lib64/libc.so.6)
>                                        _start (/home/acme/c/faccessat2)
> root@number:~#
>
> Now to write another test case, this time for the landlock syscall, to
> test your btf_enum patch.
>
> In the future please add the test case so that one can quickly reproduce
> your testing steps.

Thank you for testing this patch, sorry for the inconvenience, I will
attach tests to speed up reproduction in the future. Also, your
simplification looks good, thank you so much.

Thanks,
Howard

>
> - Arnaldo

