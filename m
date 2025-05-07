Return-Path: <bpf+bounces-57702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413FCAAEC93
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 21:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E244637D9
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6921528E5EC;
	Wed,  7 May 2025 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UOggaXR3"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687728DF26
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647970; cv=none; b=C1RadRU4izVTYET5+pw0u7tkDsf1++L89IslLMPlelEPdvIdr9wV4VYRE98gMnh6gvZ6QGrOSaO3bRlSXzd+TOMJRdhv/wjKZ9Ul86lyjSrcsCbm/MZg8MQsuW8FQALeycNe9CWKLzZQuZA9YqocNf5sriZO8kgx1GeFOqMwDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647970; c=relaxed/simple;
	bh=y/cfTKWsAxxpGewmPFV3yiomo4OnmNW8bup3vj0XCDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l++GW7CBW1LfEUqeRhmqLPruv64C+vks7XhgtrgABXiGPkOnSEHowX1pevuxZm93ocsFXuZcq5Oyu1afZK25VAnFQKrhagaE40IGSVvA8c22/Ch3IZ2xtoUtDFWPr2/j5K4x79pWuvW3oZuyd1pQ4oXVpgXA9n/8oIBAng75wPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UOggaXR3; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e2eba312-73f2-4d6e-b845-9c514eb7018a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746647964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JdjuxRo6S99iIM59BSjx75a1/SCyO+XiNbDOcwsjok=;
	b=UOggaXR3yakR6H1y5zUCYI0nW3e0SXIga1V4c1zNfuwqXXAGrIgoY2Xzh+6290047K9CtP
	tSywCuYh0W2puPPh2PiDuUO3oWkZ1Cl6j/6lnqF8C9IPKvq+0ZXHoZIxCbtn+LL4/AYizJ
	63pob6HSpo68UsZDIo03vKczfeXmWi0=
Date: Wed, 7 May 2025 12:59:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] scripts/bpf_doc.py: implement json output
 format
To: Quentin Monnet <qmo@kernel.org>, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com, dylan.reimerink@isovalent.com,
 kernel-team@meta.com
References: <20250507182802.3833349-1-isolodrai@meta.com>
 <c69aaf7b-6e7c-4236-b571-9efc273e27e1@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <c69aaf7b-6e7c-4236-b571-9efc273e27e1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025-05-07 12:43 p.m., Quentin Monnet wrote:
> 2025-05-07 11:28 UTC-0700 ~ Ihor Solodrai <isolodrai@meta.com>
>> bpf_doc.py parses bpf.h header to collect information about various
>> API elements (such as BPF helpers) and then dump them in one of the
>> supported formats: rst docs and a C header.
>>
>> It's useful for external tools to be able to consume this information
>> in an easy-to-parse format such as JSON. Implement JSON printers and
>> add --json command line argument.
>>
>> v1: https://lore.kernel.org/bpf/20250506000605.497296-1-isolodrai@meta.com/
>>
>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>> ---
>>   scripts/bpf_doc.py | 112 +++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 98 insertions(+), 14 deletions(-)
>>
>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>> index e74a01a85070..d669a0e16bf2 100755
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
>> @@ -43,6 +44,14 @@ class APIElement(object):
>>           self.ret = ret
>>           self.attrs = attrs
>>   
>> +    def to_dict(self):
>> +        return {
>> +            'proto': self.proto,
>> +            'desc': self.desc,
>> +            'ret': self.ret,
>> +            'attrs': self.attrs
>> +        }
>> +
>>   
>>   class Helper(APIElement):
>>       """
>> @@ -81,6 +90,11 @@ class Helper(APIElement):
>>   
>>           return res
>>   
>> +    def to_dict(self):
>> +        d = super().to_dict()
>> +        d.update(self.proto_break_down())
>> +        return d
>> +
>>   
>>   ATTRS = {
>>       '__bpf_fastcall': 'bpf_fastcall'
>> @@ -675,7 +689,7 @@ COMMANDS
>>           self.print_elem(command)
>>   
>>   
>> -class PrinterHelpers(Printer):
>> +class PrinterHelpersHeader(Printer):
>>       """
>>       A printer for dumping collected information about helpers as C header to
>>       be included from BPF program.
>> @@ -896,6 +910,43 @@ class PrinterHelpers(Printer):
>>           print(') = (void *) %d;' % helper.enum_val)
>>           print('')
>>   
>> +
>> +class PrinterHelpersJSON(Printer):
>> +    """
>> +    A printer for dumping collected information about helpers as a JSON file.
>> +    @parser: A HeaderParser with Helper objects
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
>> +        helper_dicts = [helper.to_dict() for helper in self.elements]
>> +        out_dict = {'helpers': helper_dicts}
>> +        print(json.dumps(out_dict, indent=4))
>> +
>> +
>> +class PrinterSyscallJSON(Printer):
>> +    """
>> +    A printer for dumping collected syscall information as a JSON file.
>> +    @parser: A HeaderParser with APIElement objects
>> +    """
>> +
>> +    def __init__(self, parser):
>> +        self.elements = parser.commands
>> +        self.elem_number_check(parser.desc_syscalls, parser.enum_syscalls, 'syscall', 'bpf_cmd')
>> +
>> +    def print_all(self):
>> +        syscall_dicts = [syscall.to_dict() for syscall in self.elements]
>> +        out_dict = {'syscall': syscall_dicts}
>> +        print(json.dumps(out_dict, indent=4))
>> +
>>   ###############################################################################
>>   
>>   # If script is launched from scripts/ from kernel tree and can access
>> @@ -910,6 +961,19 @@ printers = {
>>           'syscall': PrinterSyscallRST,
>>   }
> 
> 
> Can you please remove the old "printers" dict that is right above? It's
> no longer used now that you redefine it below.

Sure, missed it...
Thanks.

> 
> pw-bot: cr
> 
>>   
>> +# target -> output format -> printer
>> +printers = {
>> +    'helpers': {
>> +        'rst': PrinterHelpersRST,
>> +        'json': PrinterHelpersJSON,
>> +        'header': PrinterHelpersHeader,
>> +    },
>> +    'syscall': {
>> +        'rst': PrinterSyscallRST,
>> +        'json': PrinterSyscallJSON
>> +    },
>> +}
>> +
>>   argParser = argparse.ArgumentParser(description="""
>>   Parse eBPF header file and generate documentation for the eBPF API.
>>   The RST-formatted output produced can be turned into a manual page with the
> 
> [...]


