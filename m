Return-Path: <bpf+bounces-17255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A42980AF48
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 23:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B91B20B81
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE158AD8;
	Fri,  8 Dec 2023 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpJDJgL2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472371716;
	Fri,  8 Dec 2023 14:00:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-332fd81fc8dso2409570f8f.3;
        Fri, 08 Dec 2023 14:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702072835; x=1702677635; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YMLpYnfVM9iEfLiGUcdGRUL+oUiUpU3M2wg2/3ArWGU=;
        b=jpJDJgL2I3xGR5RTIUWOUTtHwj4J/5JHqP3NUCT8fn1iXw451Da3id8428VXsge2ch
         l60+sG5iMOonMl2NTKZ8UW0gH+NWY1LFGPK4JVniYnbos20Ye4LtnKkiwCbIQHYx0jhT
         FrANCq8uPjblXrixNF57CnrMVbpNHojXQR3ijHgwYARJmcx8RXl1sJEQUTOA9QlsvjFZ
         A1ugAzcmfueGGExQGCZnqRXVxohOJu5nBxAXw5MdIY7S6MadVdVfAwP9ixHGeKOXNveC
         ftadUH03Hb7qNEUx120wcSwbqsxE62p/kS7g5vEH44Xb1QGMyXOTWJ8U+uChL9LDmGC6
         AHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072835; x=1702677635;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMLpYnfVM9iEfLiGUcdGRUL+oUiUpU3M2wg2/3ArWGU=;
        b=SjAoFJbNYUEIBmAzPxAHs8bfvE1ispH9JgYoHQz0+eLeftDsMrBtrXtY6gUKIUW+tr
         QCc50qYSEBOdLfo9FDLHG3KVxL1KNfkz3ulKfBTuYXZKAsuXF+9tbSl99y0c3jzRh6/1
         6+sGVAFq5ck8GiHYs9eL7BlUXNRWjHjC8P5JttFsqCnIXlF1bwsW7KMBs0RNMxpfDeYW
         GEaQ9HdQXlYhVrnEracsa0DAoeJXmfWaVUqGYd3PouLlzpNygDcT2ufkImezNUowxSr7
         5mn6FgxIeitLW6RpqZ5p/R1n979X0OFDwi/3D2+AvaKkHb6swHj0dNTuZ7URu8wep/jw
         7pQQ==
X-Gm-Message-State: AOJu0YzEA557opD8q3J5O0E9YgUxlUxOGhd9+fy3d4rmGzVhEHw8rZmv
	L4W5HwJVraH45wgWsJ2Q2yqbEG3eJYb/1w==
X-Google-Smtp-Source: AGHT+IG9SXThv3yUhXEDCkrqxc4eKcp8Fh/DdpaDLaCsgdbRKVYGChk+W8Ys63O4Y8TnOP80ZNLZiQ==
X-Received: by 2002:adf:cf05:0:b0:333:2fd2:68b8 with SMTP id o5-20020adfcf05000000b003332fd268b8mr375478wrj.75.1702072834234;
        Fri, 08 Dec 2023 14:00:34 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d5192000000b0033339027c89sm2823380wrv.108.2023.12.08.14.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:00:33 -0800 (PST)
Message-ID: <acfff73b4a0b6d325f749b580ee593ce8d0187f6.camel@gmail.com>
Subject: Re: [PATCH v2] libbpf: add pr_warn() for EINVAL cases in
 linker_sanity_check_elf
From: Eduard Zingerman <eddyz87@gmail.com>
To: Sergei Trofimovich <slyich@gmail.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Date: Sat, 09 Dec 2023 00:00:32 +0200
In-Reply-To: <20231208215100.435876-1-slyich@gmail.com>
References: <159e94e7ce82e9432bd2bba0141c8feab0a9a2e6.camel@gmail.com>
	 <20231208215100.435876-1-slyich@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-08 at 21:51 +0000, Sergei Trofimovich wrote:
> Before the change on `i686-linux` `systemd` build failed as:
>=20
>     $ bpftool gen object src/core/bpf/socket_bind/socket-bind.bpf.o src/c=
ore/bpf/socket_bind/socket-bind.bpf.unstripped.o
>     Error: failed to link 'src/core/bpf/socket_bind/socket-bind.bpf.unstr=
ipped.o': Invalid argument (22)
>=20
> After the change it fails as:
>=20
>     $ bpftool gen object src/core/bpf/socket_bind/socket-bind.bpf.o src/c=
ore/bpf/socket_bind/socket-bind.bpf.unstripped.o
>     libbpf: ELF section #9 has inconsistent alignment addr=3D8 !=3D d=3D4=
 in src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o
>     Error: failed to link 'src/core/bpf/socket_bind/socket-bind.bpf.unstr=
ipped.o': Invalid argument (22)
>=20
> Now it's slightly easier to figure out what is wrong with an ELF file.
>=20
> CC: Alexei Starovoitov <ast@kernel.org>
> CC: Daniel Borkmann <daniel@iogearbox.net>
> CC: Andrii Nakryiko <andrii@kernel.org>
> CC: Martin KaFai Lau <martin.lau@linux.dev>
> CC: Song Liu <song@kernel.org>
> CC: Yonghong Song <yonghong.song@linux.dev>
> CC: John Fastabend <john.fastabend@gmail.com>
> CC: KP Singh <kpsingh@kernel.org>
> CC: Stanislav Fomichev <sdf@google.com>
> CC: Hao Luo <haoluo@google.com>
> CC: Jiri Olsa <jolsa@kernel.org>
> CC: Eduard Zingerman <eddyz87@gmail.com>
> CC: bpf@vger.kernel.org
> Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
> ---
>  tools/lib/bpf/linker.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> Change since v1:
> Following Eduard's suggestion added one extra pr_warn() call around
> section alignment and added compared values into warning messages.

Thank you for doing adjustments.
(Note: when I apply this patch locally full CC block is a part of the
       commit message, this is usually omitted from commit messages).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

