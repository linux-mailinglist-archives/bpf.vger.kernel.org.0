Return-Path: <bpf+bounces-57570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A5DAAD0DB
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620BD1BC2B86
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 22:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBB6157A6B;
	Tue,  6 May 2025 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KvvYqGuM"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C9F7262E
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 22:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569905; cv=none; b=t5h9YlalnxLp6GD1KkrOf0grdYuV6cvpYjZ0xLJfkjSZsAVZtFwmvXISIHkFYwP7nKAbrJKfRxG7Yj2udsxD5zdHBMkmBw20l+UBmq7Ocw+cW7O8OYHs3EYMCksGTxvTBBAsX7ZIXBJmgVJOlEs/kGyYOSlrlzfAS8tlFU0Lkq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569905; c=relaxed/simple;
	bh=DhKN+iTCNc6cg8SX6wviRe9iKYCYSZW6itmCJpNrGsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/BEc3ejCR25Rxw3Wj9bhiv1nRYZEkpj8jXlq/OU3t4WxkjK94oWBKqsMvBy45vqooCLgKZBCCrL0aYtyxGolGwmKSvsaAYhx4vJjjMbWNhaxEhaT7w5tMLYqXX41xs0cPOnKa/fK9faaYcQRVodNct3STRI+/0hY9dTiu2hans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KvvYqGuM; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <659400eb-13d6-48ed-a8cf-66a79fc139b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746569900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAA6Np0CV3onDesUi+3LVBxTDDtZZbHAZLyVzkfAAO4=;
	b=KvvYqGuMYPJSW2X68IrjeGBgNlt+8JLHrsPoHpcmeNEsfXohVe8KBM4ltnYDv3rL5izGk8
	edJBevPZ5yROVr2P5Daz50CnaQr5MTcQxglrU9r2+kn0jBXZim33OKfYbiAFs18085zYvv
	mXhpmmpDb0mioZrW+VwIxMOXZQrig/c=
Date: Tue, 6 May 2025 15:18:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] scripts/bpf_doc.py: implement json output for
 helpers
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, bpf@vger.kernel.org, mykolal@fb.com, kernel-team@meta.com
References: <20250506000605.497296-1-isolodrai@meta.com>
 <CAEf4BzYY6mPto_9MwPp0zH+MvWScjQPxLdHLSGd+c2QjvJyNsA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzYY6mPto_9MwPp0zH+MvWScjQPxLdHLSGd+c2QjvJyNsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025-05-06 3:07 p.m., Andrii Nakryiko wrote:
> On Mon, May 5, 2025 at 5:06 PM Ihor Solodrai <isolodrai@meta.com> wrote:
>>
>> bpf_doc.py parses bpf.h header to collect information about various
>> functions (such as BPF helpers) and dump them in one of the supported
>> forms: rst docs and a C header.
>>
>> It's useful for external tools to be able to consume information about
>> BPF helpers - list of helpers and their args - in an easy-to-parse
>> format such as JSON. Given that bpf_doc.py already does the work of
>> searching and collecting the helpers, implement trivial JSON printer
>> and add --json option for helpers target.
>>
>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>> ---
>>   scripts/bpf_doc.py | 42 +++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 37 insertions(+), 5 deletions(-)
>>
> 
> Ihor, do you have an example on how JSON output would look like?

Sure. I already use it:

https://github.com/libbpf/bpfvv/blob/master/bpf-helpers.json

I only wanted function names and arg list, so the current output is good 
enough for my use-case.

> 
> Quentin, can you please take a look? Do you have any objections?
> 
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index e74a01a85070..15d83ff5d2bd 100755
>> --- a/scripts/bpf_doc.py
>> +++ b/scripts/bpf_doc.py
>> @@ -8,6 +8,7 @@
>>   from __future__ import print_function
>>
>>   import argparse
>> +import json
>>   import re
>>   import sys, os
>>   import subprocess
>> @@ -675,7 +676,7 @@ COMMANDS
>>           self.print_elem(command)
>>
>>
>> -class PrinterHelpers(Printer):
>> +class PrinterHelpersHeader(Printer):
>>       """
>>       A printer for dumping collected information about helpers as C header to
>>       be included from BPF program.
>> @@ -896,6 +897,27 @@ class PrinterHelpers(Printer):
>>           print(') = (void *) %d;' % helper.enum_val)
>>           print('')
>>
>> +
>> +class PrinterHelpersJSON(Printer):
>> +    """
>> +    A printer for dumping collected information about helpers as a JSON file.
>> +    @parser: A HeaderParser with Helper objects to print to standard output
>> +    """
>> +
>> +    def __init__(self, parser):
>> +        self.elements = parser.helpers
>> +        self.elem_number_check(
>> +            parser.desc_unique_helpers,
>> +            parser.define_unique_helpers,
>> +            "helper",
>> +            "___BPF_FUNC_MAPPER",
>> +        )
>> +
>> +    def print_all(self):
>> +        protos = [helper.proto_break_down() for helper in self.elements]
>> +        out_dict = {"helpers": protos}
>> +        print(json.dumps(out_dict, indent=4))
>> +
>>   ###############################################################################
>>
>>   # If script is launched from scripts/ from kernel tree and can access
>> @@ -917,6 +939,8 @@ rst2man utility.
>>   """)
>>   argParser.add_argument('--header', action='store_true',
>>                          help='generate C header file')
>> +argParser.add_argument("--json", action="store_true",
>> +                       help="generate a JSON with information about helpers")
>>   if (os.path.isfile(bpfh)):
>>       argParser.add_argument('--filename', help='path to include/uapi/linux/bpf.h',
>>                              default=bpfh)
>> @@ -930,11 +954,19 @@ args = argParser.parse_args()
>>   headerParser = HeaderParser(args.filename)
>>   headerParser.run()
>>
>> -# Print formatted output to standard output.
>> +if args.header and args.json:
>> +    print("bpf_doc.py: Use --header or --json, not both")
>> +    exit(1)
>> +if args.target != "helpers" and (args.header or args.json):
>> +    print("bpf_doc.py: Only helpers header/json generation is supported")
>> +    exit(1)
>> +
>>   if args.header:
>> -    if args.target != 'helpers':
>> -        raise NotImplementedError('Only helpers header generation is supported')
>> -    printer = PrinterHelpers(headerParser)
>> +    printer = PrinterHelpersHeader(headerParser)
>> +elif args.json:
>> +    printer = PrinterHelpersJSON(headerParser)
>>   else:
>>       printer = printers[args.target](headerParser)
>> +
>> +# Print formatted output to standard output.
>>   printer.print_all()
>> --
>> 2.47.1
>>


