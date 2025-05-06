Return-Path: <bpf+bounces-57569-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E47AAD0C6
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA0F1B688C9
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28140219305;
	Tue,  6 May 2025 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUwBce3U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AB44B1E60
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569253; cv=none; b=YXUkiON/2q3WrVWp/b2c8UMiaqG6sh1hCKdOj25tOXXqQ5IgsXQZrBXBWN5wjrCWR2Cp5oVlG5ST98aEqUr85kJ0X1O/nf6z9ctTLXPyr8S3v/7iJWJ3uERT0TaU9Zaquv7kStMFXrHtiyeDrNeNOd2qBaFl+Vx8ZA/9CDKDzHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569253; c=relaxed/simple;
	bh=wTsmTUGM0m00k3UF0GhYayLQei5ZfQt/Z00/lwpqhqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKVThByDmZ+BfZ3K14eoYrtBHKdDBsxigJh9saO7fPLlDgdRnIVYcWwNjUc/7CUkvO4vcRG1XVJ3/bmBBAy2MR2baLOHqfzQljjhgc5HmLQo4YmLutubN37liwka7UUqrLnTa1kTO2txq0RsH6YbHTPanFrGazePk5jyrDKD6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUwBce3U; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30863b48553so282612a91.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746569251; x=1747174051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSLvbG29Aw1AkpA9ZNlQGj9spqPWIutINEfDJ5xrRHQ=;
        b=LUwBce3U4o9pvFTCN4Z+6VxcpOfW/W/LsE9HamWE3fFuYc71m0cVNp4zY94L7Ts+DP
         KGO+jZqtBwXMJIY0f20IHd6QPDQRggamW5dz23fIsFMkeJYL+UXpbUbFe9Krl1RmYRcy
         ukNSFnsnwpls+PRbSGloVI4JZ2hzbAtbwOlKM9+TXo+O6hz6F77TlGKu6NmTLrzeW6pr
         5u/7jY4WRrsdtqzLNEmurIWR1waujmLh1uFBcmVJYkEKQFU4dZd+l0bwWiip3fsLn/pi
         XWQYivJWTqLclSWOYHbazm4+nlivzBSCblzoRtgboo2O7F4qPBnomIo8vANo3aT56l21
         GcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746569251; x=1747174051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSLvbG29Aw1AkpA9ZNlQGj9spqPWIutINEfDJ5xrRHQ=;
        b=VV+5yBSzCA2Le86HqqgP4JVdQPNSyApnY2MxBLLrc6QMrUQP1Qlu6/sJf3cVQxKE5V
         TrbgkCa+3+BmWJ+EdyVjsqCX/1lD8dGyYBNbCKIT8rwt3SU+5jzjeEk2lzkpx3UybFEy
         PEYUHAilC5d7vclscDw9I8ArZSVLXlth6/4t5sCtEz7cjdyDNxXuC7yVx5LyIT4aJHR2
         ySojWsJq224Dq+4xlD5eAyqadgR5b9dic3XvlNhhKVyB3nOTMBTeab1YsfoXPYkpAIuI
         NVKaTwH4HIyhs+yJp/J5z/rytckKe/BQcv3sgZt+Iht7RqiaZTDlIQWAZfKxr94DiNV/
         +YlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUBBkSZNBOWmiBYaaz2XMOEFgRfmTzW3RZqMI7CVmfv1S64s1msO1odZ+jYxOQB0HoFK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw65tFRVT2l3QL7e2vIzHdMZZwKm7a536aSHZ4BKpzC3Mu6xM+L
	Tb8AnWFKIc+aD2yyd1Kfq6AWJTavzeotX9iMNWMa2xeBmCDaO6ZeXPbezcd25t+r/XwR9W9Qf7f
	F3S5ifOFAlh5UTpAWmQ0gD5LUZqg=
X-Gm-Gg: ASbGncvITfkc/UW0lePlZ9KlrQxX8cHIjlKuKIrwvC2flh6eJnagWllaUyGRG6hybQX
	HzzDyq0c56ZhN6P+hIBKzFbKFQXDz9qT1/POF61Ea7C6gikHTq+Am3QG6+qFIoOqCgvT5Nkf8yM
	/hs1GalmqxMNd4XeuAzIsYPLQUSWbRISwupbn0Iw==
X-Google-Smtp-Source: AGHT+IG5ZusKhJ4SbDhR0TF8x+n3HyJqLpL2BHH1uiX3h/OUmCUa/LfmV+T/6vaGrKHhVndI7fPm5U6x1WX062YDjq8=
X-Received: by 2002:a17:90b:2e45:b0:30a:9feb:1e0f with SMTP id
 98e67ed59e1d1-30aaecdc652mr1074678a91.5.1746569251188; Tue, 06 May 2025
 15:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506000605.497296-1-isolodrai@meta.com>
In-Reply-To: <20250506000605.497296-1-isolodrai@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 15:07:18 -0700
X-Gm-Features: ATxdqUEktU8GT8HwG732y1SgrH2fapncrwr3z08vWQzxLmUpNYyUmP59IpxqLHc
Message-ID: <CAEf4BzYY6mPto_9MwPp0zH+MvWScjQPxLdHLSGd+c2QjvJyNsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] scripts/bpf_doc.py: implement json output for helpers
To: ihor.solodrai@linux.dev, Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	bpf@vger.kernel.org, mykolal@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 5:06=E2=80=AFPM Ihor Solodrai <isolodrai@meta.com> w=
rote:
>
> bpf_doc.py parses bpf.h header to collect information about various
> functions (such as BPF helpers) and dump them in one of the supported
> forms: rst docs and a C header.
>
> It's useful for external tools to be able to consume information about
> BPF helpers - list of helpers and their args - in an easy-to-parse
> format such as JSON. Given that bpf_doc.py already does the work of
> searching and collecting the helpers, implement trivial JSON printer
> and add --json option for helpers target.
>
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>  scripts/bpf_doc.py | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
>

Ihor, do you have an example on how JSON output would look like?

Quentin, can you please take a look? Do you have any objections?

> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index e74a01a85070..15d83ff5d2bd 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -8,6 +8,7 @@
>  from __future__ import print_function
>
>  import argparse
> +import json
>  import re
>  import sys, os
>  import subprocess
> @@ -675,7 +676,7 @@ COMMANDS
>          self.print_elem(command)
>
>
> -class PrinterHelpers(Printer):
> +class PrinterHelpersHeader(Printer):
>      """
>      A printer for dumping collected information about helpers as C heade=
r to
>      be included from BPF program.
> @@ -896,6 +897,27 @@ class PrinterHelpers(Printer):
>          print(') =3D (void *) %d;' % helper.enum_val)
>          print('')
>
> +
> +class PrinterHelpersJSON(Printer):
> +    """
> +    A printer for dumping collected information about helpers as a JSON =
file.
> +    @parser: A HeaderParser with Helper objects to print to standard out=
put
> +    """
> +
> +    def __init__(self, parser):
> +        self.elements =3D parser.helpers
> +        self.elem_number_check(
> +            parser.desc_unique_helpers,
> +            parser.define_unique_helpers,
> +            "helper",
> +            "___BPF_FUNC_MAPPER",
> +        )
> +
> +    def print_all(self):
> +        protos =3D [helper.proto_break_down() for helper in self.element=
s]
> +        out_dict =3D {"helpers": protos}
> +        print(json.dumps(out_dict, indent=3D4))
> +
>  ########################################################################=
#######
>
>  # If script is launched from scripts/ from kernel tree and can access
> @@ -917,6 +939,8 @@ rst2man utility.
>  """)
>  argParser.add_argument('--header', action=3D'store_true',
>                         help=3D'generate C header file')
> +argParser.add_argument("--json", action=3D"store_true",
> +                       help=3D"generate a JSON with information about he=
lpers")
>  if (os.path.isfile(bpfh)):
>      argParser.add_argument('--filename', help=3D'path to include/uapi/li=
nux/bpf.h',
>                             default=3Dbpfh)
> @@ -930,11 +954,19 @@ args =3D argParser.parse_args()
>  headerParser =3D HeaderParser(args.filename)
>  headerParser.run()
>
> -# Print formatted output to standard output.
> +if args.header and args.json:
> +    print("bpf_doc.py: Use --header or --json, not both")
> +    exit(1)
> +if args.target !=3D "helpers" and (args.header or args.json):
> +    print("bpf_doc.py: Only helpers header/json generation is supported"=
)
> +    exit(1)
> +
>  if args.header:
> -    if args.target !=3D 'helpers':
> -        raise NotImplementedError('Only helpers header generation is sup=
ported')
> -    printer =3D PrinterHelpers(headerParser)
> +    printer =3D PrinterHelpersHeader(headerParser)
> +elif args.json:
> +    printer =3D PrinterHelpersJSON(headerParser)
>  else:
>      printer =3D printers[args.target](headerParser)
> +
> +# Print formatted output to standard output.
>  printer.print_all()
> --
> 2.47.1
>

