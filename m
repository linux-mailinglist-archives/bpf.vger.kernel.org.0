Return-Path: <bpf+bounces-57572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1046AAD0F3
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D037998266A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 22:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C17D218ACA;
	Tue,  6 May 2025 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0FNQCVi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D377262C
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570354; cv=none; b=fKH0Snbug32iuZuQyQOTf/VRKH6bXZrzOc1KIeg6OrxAL5g0g4NdEoqz2CNYcH7Ai4DbW2lBqT48GpWtVUE1kkfFbBrkyJcKcjDxc8bb+FLeh5LyBcEAUQDhUA7iRJq8IFZp+K6SpvFSa5EfJM4Xa3I9JOVhVZcVi2xFX2R/yhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570354; c=relaxed/simple;
	bh=0MrGuka3GERohYt1U8Q7vQb7hq1nFXezqxDlrgIGBkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlNLA9cb2vzZhDQEfZwA7VC3ifTZqxnOsN173m7kNiXYSE77T4FJle4RJIkvCMw0J+BAGuZAdE0P8GF2ZfgivgFAVR4MawpLVIjpiWfWqYoJBas339MjHeZ9Ya+JXmjBNklTgruG+D0i5nYarymEbXXNh5kxJFBMxdIFoXjr414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0FNQCVi; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736a72220edso6865928b3a.3
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746570352; x=1747175152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBPBfKOfca+HbSGM0bLzdDCAmc9BqSH1JRVQo+J5Yrk=;
        b=h0FNQCViI5DwmD6ngovuvyar12MzMs7KloKFGVuySwugLS1QUHIuX/UQlfLhXAIgbw
         KO5L9bEaJv2oRJVUi9xN91GmmDCHgzOBscHOV/KgAX+GNhdDxnuqbfEURd1IjcP22Za3
         KqLi5q/sqh1hqLYCBqNjq2m2j0w8W5zkPMuqzQkaSYWyq/g646X6aChdvn2kV4yUGLYt
         ixPPrsahCzZCdJupFsFCazdpstW7yhj22EGFXT8QixXv0CJcONThqQe31GULvrsxlwEF
         v/sSVYyDC4Nk8X7aOOnSgJh0CAytGQzUIBhHvYssyYyraPjzcIoRrREjDQS6vBpB2Wgg
         iAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746570352; x=1747175152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBPBfKOfca+HbSGM0bLzdDCAmc9BqSH1JRVQo+J5Yrk=;
        b=sJOEGsQKUZPFNCcdg1ycMrgRXLYECJxqQRyClW4S7k3XQklpKZbbWulu0cFwKPLb8d
         FoY3DSeyYbrIL2BsrpRtsfKD9CYq+YNOgTDM/eTczLz7D3dn+5qcTu8oTkEV7myTrajR
         efVahE2TjMtWsOJOPu9NMy8gPozccR/aUg1sPyU9/0MXOrBEpCq6ffl5e28oNec6TKDN
         74aYIYZz0D0FJqKQT9vxu3Tivw2hxoP7GiX/akSVBfcLxTQuf6MTJmE2k+2YWCNX0y31
         cHdzendCc2SiOZ/Z8mhvWO/x3XbgQVsV4nczznNwHUX9GVykL3i69R5dm4iovayYgOvo
         h/6g==
X-Forwarded-Encrypted: i=1; AJvYcCVDabCIhomrmw9RXrdvuWRLL5AHxgfkFspt3Av65y7692RrNjAy8D8me5VlsuXF5sB1icU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVzU1K9/UqP678vw9iEK7CtBw6vB7MY+ZvWIzjTe7ymFHJvtfY
	zTaJ3zCI0drfltyVmAnb6f5g9JbPCr74VOC63ug0LEWABdzt5fenmQifovqLesBqXa0qhEfJpBp
	RHl5YTGAUGXhs5nfGyQu4OZHfits=
X-Gm-Gg: ASbGncsCQiYeAgfclaaspwJz8dwTaPFuzL6CjgA193e8fuOdg1CoXbujWxV2A4ZXDEN
	a2QBI4/6aHjB0+8E5TfJgpJir2qxr1NyIDVq0+LC1BBU3bhCNqOyZCenrab2nd4CBfS4Yoja715
	gpXLsCsIklPxrLVFnwGmRtoQ9mxVGJCZzh6v2IMw==
X-Google-Smtp-Source: AGHT+IERtORtedqs8qqH6NV2mmcCava4I/qPL25bASF3Z2sqjzsZBVYhl0i+XH76qaPwLyHFWPenAci6kC1/qAbjb0g=
X-Received: by 2002:aa7:9a84:0:b0:730:99cb:7c2f with SMTP id
 d2e1a72fcca58-7409cefeab1mr1116416b3a.6.1746570352484; Tue, 06 May 2025
 15:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506000605.497296-1-isolodrai@meta.com> <CAEf4BzYY6mPto_9MwPp0zH+MvWScjQPxLdHLSGd+c2QjvJyNsA@mail.gmail.com>
 <659400eb-13d6-48ed-a8cf-66a79fc139b7@linux.dev>
In-Reply-To: <659400eb-13d6-48ed-a8cf-66a79fc139b7@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 May 2025 15:25:40 -0700
X-Gm-Features: ATxdqUG6lPMqt1vzPTMAaEWwSyU2Qqdq8xOyFjdt_MRHtGgnbKJJg52QEG1-JPE
Message-ID: <CAEf4Bza4GDrccUy+nRJ8p4t6=bhGpFDi049xibd48DkR12ODVg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] scripts/bpf_doc.py: implement json output for helpers
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	eddyz87@gmail.com, bpf@vger.kernel.org, mykolal@fb.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 3:18=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> On 2025-05-06 3:07 p.m., Andrii Nakryiko wrote:
> > On Mon, May 5, 2025 at 5:06=E2=80=AFPM Ihor Solodrai <isolodrai@meta.co=
m> wrote:
> >>
> >> bpf_doc.py parses bpf.h header to collect information about various
> >> functions (such as BPF helpers) and dump them in one of the supported
> >> forms: rst docs and a C header.
> >>
> >> It's useful for external tools to be able to consume information about
> >> BPF helpers - list of helpers and their args - in an easy-to-parse
> >> format such as JSON. Given that bpf_doc.py already does the work of
> >> searching and collecting the helpers, implement trivial JSON printer
> >> and add --json option for helpers target.
> >>
> >> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> >> ---
> >>   scripts/bpf_doc.py | 42 +++++++++++++++++++++++++++++++++++++-----
> >>   1 file changed, 37 insertions(+), 5 deletions(-)
> >>
> >
> > Ihor, do you have an example on how JSON output would look like?
>
> Sure. I already use it:
>
> https://github.com/libbpf/bpfvv/blob/master/bpf-helpers.json
>
> I only wanted function names and arg list, so the current output is good
> enough for my use-case.

Nice, thanks! We also have doc comments, right? I'd add them for
completeness (maybe your tool will show it when hovering over the
helper call instruction or something...)

>
> >
> > Quentin, can you please take a look? Do you have any objections?
> >
> >> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> >> index e74a01a85070..15d83ff5d2bd 100755
> >> --- a/scripts/bpf_doc.py
> >> +++ b/scripts/bpf_doc.py
> >> @@ -8,6 +8,7 @@
> >>   from __future__ import print_function
> >>
> >>   import argparse
> >> +import json
> >>   import re
> >>   import sys, os
> >>   import subprocess
> >> @@ -675,7 +676,7 @@ COMMANDS
> >>           self.print_elem(command)
> >>
> >>
> >> -class PrinterHelpers(Printer):
> >> +class PrinterHelpersHeader(Printer):
> >>       """
> >>       A printer for dumping collected information about helpers as C h=
eader to
> >>       be included from BPF program.
> >> @@ -896,6 +897,27 @@ class PrinterHelpers(Printer):
> >>           print(') =3D (void *) %d;' % helper.enum_val)
> >>           print('')
> >>
> >> +
> >> +class PrinterHelpersJSON(Printer):
> >> +    """
> >> +    A printer for dumping collected information about helpers as a JS=
ON file.
> >> +    @parser: A HeaderParser with Helper objects to print to standard =
output
> >> +    """
> >> +
> >> +    def __init__(self, parser):
> >> +        self.elements =3D parser.helpers
> >> +        self.elem_number_check(
> >> +            parser.desc_unique_helpers,
> >> +            parser.define_unique_helpers,
> >> +            "helper",
> >> +            "___BPF_FUNC_MAPPER",
> >> +        )
> >> +
> >> +    def print_all(self):
> >> +        protos =3D [helper.proto_break_down() for helper in self.elem=
ents]
> >> +        out_dict =3D {"helpers": protos}
> >> +        print(json.dumps(out_dict, indent=3D4))
> >> +
> >>   ####################################################################=
###########
> >>
> >>   # If script is launched from scripts/ from kernel tree and can acces=
s
> >> @@ -917,6 +939,8 @@ rst2man utility.
> >>   """)
> >>   argParser.add_argument('--header', action=3D'store_true',
> >>                          help=3D'generate C header file')
> >> +argParser.add_argument("--json", action=3D"store_true",
> >> +                       help=3D"generate a JSON with information about=
 helpers")
> >>   if (os.path.isfile(bpfh)):
> >>       argParser.add_argument('--filename', help=3D'path to include/uap=
i/linux/bpf.h',
> >>                              default=3Dbpfh)
> >> @@ -930,11 +954,19 @@ args =3D argParser.parse_args()
> >>   headerParser =3D HeaderParser(args.filename)
> >>   headerParser.run()
> >>
> >> -# Print formatted output to standard output.
> >> +if args.header and args.json:
> >> +    print("bpf_doc.py: Use --header or --json, not both")
> >> +    exit(1)
> >> +if args.target !=3D "helpers" and (args.header or args.json):
> >> +    print("bpf_doc.py: Only helpers header/json generation is support=
ed")
> >> +    exit(1)
> >> +
> >>   if args.header:
> >> -    if args.target !=3D 'helpers':
> >> -        raise NotImplementedError('Only helpers header generation is =
supported')
> >> -    printer =3D PrinterHelpers(headerParser)
> >> +    printer =3D PrinterHelpersHeader(headerParser)
> >> +elif args.json:
> >> +    printer =3D PrinterHelpersJSON(headerParser)
> >>   else:
> >>       printer =3D printers[args.target](headerParser)
> >> +
> >> +# Print formatted output to standard output.
> >>   printer.print_all()
> >> --
> >> 2.47.1
> >>
>

