Return-Path: <bpf+bounces-57646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B98FAADB7E
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 11:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0080D3ABA34
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2FE1F2BAB;
	Wed,  7 May 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uT/hERq+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DAF4B1E47
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610318; cv=none; b=VAM5Od+lhdT211JNEaqWYI+xRYB8NNO601jAmcSG/1YVcM9pie7ztZc87m5plkwq6MTMXwKzX4H+vfWaAZhq7J97DuquUEo/968yL4EijydI/MZXIYSy/eiElf54JeW6pupPh3UzszZl6JT7KSHVUySlB/JEFcQ3W5T1RAAYgFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610318; c=relaxed/simple;
	bh=iqv0N9S9PpST1QayNZHL7YyTLoc2+sgs2RbOwc2emVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwiZHwclPnSi99lezp1TQr3IXGcr4w6Noh7yCFrEYrKY6UBwebRm9BjOhFJ96gE92ZmNgSkxeeYA0qw3HAKdiEJyJNMA0ztmx9dRGMuQ1hqzZD5k8K5BVLTFzjTc8n+8ABRlA7Uo3NI9Z+tyxAuNGm9lo5bzP5uqn/CWjYa982Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uT/hERq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB04AC4CEE7;
	Wed,  7 May 2025 09:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746610317;
	bh=iqv0N9S9PpST1QayNZHL7YyTLoc2+sgs2RbOwc2emVw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uT/hERq+I35wGDyOCwGq7fEV3c0QxebDX4/IKcHvhSYyvhgLgBAkAQNJqtJ8wYb1e
	 MFjSzkw3MEqRXRxjkKZMElFsq0F8DbGme5bLXZlx4J7X5fCgwZueIwY0G4k2iEDmzo
	 mfd4GR9mSHsja7uSaEy6vOfUm+Y7Dq4k/CeVg7Mtv2lNhBjUF3JaTlbk2c+KfJFsww
	 QREVzEg3MhJHlKtDKzUaNxMTxdLd1m/chpRyWTrgmiBq7jgi154j4+TygTa28oqkII
	 kg/G21rZoN5QV4uiuA5eRQO6RGvgyxR2nssdgOv14G9ddkiIIVzjJdIl+qiuskzEPC
	 Rn9vyWdfSMGMg==
Message-ID: <79805e30-498e-4c2e-ba2c-8e180b49b716@kernel.org>
Date: Wed, 7 May 2025 10:31:54 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] scripts/bpf_doc.py: implement json output for
 helpers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, bpf@vger.kernel.org, mykolal@fb.com,
 kernel-team@meta.com, Dylan Reimerink <dylan.reimerink@isovalent.com>
References: <20250506000605.497296-1-isolodrai@meta.com>
 <CAEf4BzYY6mPto_9MwPp0zH+MvWScjQPxLdHLSGd+c2QjvJyNsA@mail.gmail.com>
 <659400eb-13d6-48ed-a8cf-66a79fc139b7@linux.dev>
 <CAEf4Bza4GDrccUy+nRJ8p4t6=bhGpFDi049xibd48DkR12ODVg@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAEf4Bza4GDrccUy+nRJ8p4t6=bhGpFDi049xibd48DkR12ODVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-05-06 15:25 UTC-0700 ~ Andrii Nakryiko <andrii.nakryiko@gmail.com>
> On Tue, May 6, 2025 at 3:18 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 2025-05-06 3:07 p.m., Andrii Nakryiko wrote:
>>> On Mon, May 5, 2025 at 5:06 PM Ihor Solodrai <isolodrai@meta.com> wrote:
>>>>
>>>> bpf_doc.py parses bpf.h header to collect information about various
>>>> functions (such as BPF helpers) and dump them in one of the supported
>>>> forms: rst docs and a C header.
>>>>
>>>> It's useful for external tools to be able to consume information about
>>>> BPF helpers - list of helpers and their args - in an easy-to-parse
>>>> format such as JSON. Given that bpf_doc.py already does the work of
>>>> searching and collecting the helpers, implement trivial JSON printer
>>>> and add --json option for helpers target.
>>>>
>>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>>> ---
>>>>   scripts/bpf_doc.py | 42 +++++++++++++++++++++++++++++++++++++-----
>>>>   1 file changed, 37 insertions(+), 5 deletions(-)
>>>>
>>>
>>> Ihor, do you have an example on how JSON output would look like?
>>
>> Sure. I already use it:
>>
>> https://github.com/libbpf/bpfvv/blob/master/bpf-helpers.json
>>
>> I only wanted function names and arg list, so the current output is good
>> enough for my use-case.
> 
> Nice, thanks! We also have doc comments, right? I'd add them for
> completeness (maybe your tool will show it when hovering over the
> helper call instruction or something...)
> 
>>
>>>
>>> Quentin, can you please take a look? Do you have any objections?


I'd missed this patch, thank you Andrii.

No objection, I think JSON support for the script is a nice addition,
thanks for this! Cc Dylan, not sure if this could be of interest for
your docs.

I agree with Andrii, we should just as well add the comments to the JSON
file. I'd even add support for printing syscalls info as JSON? It should
be easy to do too.


>>>
>>>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>>>> index e74a01a85070..15d83ff5d2bd 100755
>>>> --- a/scripts/bpf_doc.py
>>>> +++ b/scripts/bpf_doc.py
>>>> @@ -8,6 +8,7 @@
>>>>   from __future__ import print_function
>>>>
>>>>   import argparse
>>>> +import json
>>>>   import re
>>>>   import sys, os
>>>>   import subprocess
>>>> @@ -675,7 +676,7 @@ COMMANDS
>>>>           self.print_elem(command)
>>>>
>>>>
>>>> -class PrinterHelpers(Printer):
>>>> +class PrinterHelpersHeader(Printer):
>>>>       """
>>>>       A printer for dumping collected information about helpers as C header to
>>>>       be included from BPF program.
>>>> @@ -896,6 +897,27 @@ class PrinterHelpers(Printer):
>>>>           print(') = (void *) %d;' % helper.enum_val)
>>>>           print('')
>>>>
>>>> +
>>>> +class PrinterHelpersJSON(Printer):
>>>> +    """
>>>> +    A printer for dumping collected information about helpers as a JSON file.
>>>> +    @parser: A HeaderParser with Helper objects to print to standard output
>>>> +    """
>>>> +
>>>> +    def __init__(self, parser):
>>>> +        self.elements = parser.helpers
>>>> +        self.elem_number_check(
>>>> +            parser.desc_unique_helpers,
>>>> +            parser.define_unique_helpers,
>>>> +            "helper",
>>>> +            "___BPF_FUNC_MAPPER",
>>>> +        )
>>>> +
>>>> +    def print_all(self):
>>>> +        protos = [helper.proto_break_down() for helper in self.elements]
>>>> +        out_dict = {"helpers": protos}
>>>> +        print(json.dumps(out_dict, indent=4))
>>>> +
>>>>   ###############################################################################
>>>>
>>>>   # If script is launched from scripts/ from kernel tree and can access


Then we could add a dimension for formatting in the "printers" dictionary:

    printers = {
            'helpers': {
                'rst': PrinterHelpersRST,
                'json': PrinterHelpersJSON,
                'header': PrinterHelpersHeader,
            },
            'syscall': {
                'rst': PrinterSyscallRST,
                # JSON here?
            },
    }


>>>> @@ -917,6 +939,8 @@ rst2man utility.
>>>>   """)
>>>>   argParser.add_argument('--header', action='store_true',
>>>>                          help='generate C header file')
>>>> +argParser.add_argument("--json", action="store_true",
>>>> +                       help="generate a JSON with information about helpers")
>>>>   if (os.path.isfile(bpfh)):
>>>>       argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h',
>>>>                              default=bpfh)
>>>> @@ -930,11 +954,19 @@ args = argParser.parse_args()
>>>>   headerParser = HeaderParser(args.filename)
>>>>   headerParser.run()
>>>>
>>>> -# Print formatted output to standard output.
>>>> +if args.header and args.json:
>>>> +    print("bpf_doc.py: Use --header or --json, not both")
>>>> +    exit(1)


Could we change this to recall the usage and print to stderr, please?

    argParser.print_usage(file=sys.stderr)
    print("Use either --header or --json, not both",
          file=sys.stderr)


>>>> +if args.target != "helpers" and (args.header or args.json):
>>>> +    print("bpf_doc.py: Only helpers header/json generation is supported")
>>>> +    exit(1)
>>>> +
>>>>   if args.header:
>>>> -    if args.target != 'helpers':
>>>> -        raise NotImplementedError('Only helpers header generation is supported')
>>>> -    printer = PrinterHelpers(headerParser)
>>>> +    printer = PrinterHelpersHeader(headerParser)
>>>> +elif args.json:
>>>> +    printer = PrinterHelpersJSON(headerParser)
>>>>   else:
>>>>       printer = printers[args.target](headerParser)
>>>> +
>>>> +# Print formatted output to standard output.
>>>>   printer.print_all()

With the change to the "printers" dictionary we could error out if we
don't find the target/format combination:

    output_format = 'rst'
    if args.header:
        output_format = 'header'
    elif args.json:
        output_format = 'json'

    try:
        printer = printers[args.target][output_format](headerParser)
    except KeyError:
        argParser.print_usage(file=sys.stderr)
        print("Unsupported target/format combination: '%s', '%s'" %
              (args.target, output_format), file=sys.stderr)
        exit(1)

    # Print formatted output to standard output.
    printer.print_all()

What do you think?

Thanks,
Quentin

