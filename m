Return-Path: <bpf+bounces-57743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46208AAF6A1
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 11:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808D61BC679A
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 09:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE4B21CA03;
	Thu,  8 May 2025 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zh48w7PQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918D209F46
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746696048; cv=none; b=V2j5p6jI38ZatnIiMI0eSkvpTzcEAYwIM2ViIyTECVoSwdSSX5+l+w/KonbsPsr8V/w8g2aaCwEHw2zHHIjnPO6ega75mLYEabWiuPTqoTvfRT8IXUcSNku8SyDAAkfPwPyf0tQt9r6ApySVVZOisy7Z8Bsww8woF9kWGekdnD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746696048; c=relaxed/simple;
	bh=6/D1u6IbOuCYCPZYnT0msgMdgWBYMgr8AdAZ6znpkt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hjW4DwjTDktNCd5NhjmTy6o1yGanEBmfGnYzfjwWi0KR1E2wMwAK0lqFMbq7iUjGuzn0jDV0ZyezgrMPetJomM4ezL34AQ4YWd2Ofuj4TVa7WS6cd88uZFPVt+SJ5jvBF2lmNjEzItQNRqkoZbAEQsaRzl7flauxemzFjyV/IA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zh48w7PQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F89C4CEE7;
	Thu,  8 May 2025 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746696048;
	bh=6/D1u6IbOuCYCPZYnT0msgMdgWBYMgr8AdAZ6znpkt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zh48w7PQv6qoaKKtCNqHPOl3Hi8CXl1JeAYHf5lShTfCleCNP1it7aD6OA5s95dZN
	 M2/2HUamMRvslYZmjeIfw9RE/gxGD1QvtaJC9kLte+yBI5OM2mwD5ZEMr++yVT55VX
	 xprD6pOHR6PlGSkAPyMXVjkKQ+3hUaffaTdKO/98oW4UovG5B3VWvG3anNSRaeEEUZ
	 g81WwOYjazvQYqxSsAI34gJrWmnx0Ot+z3WaWfiWYyeGdERo9VF4cx9g8H5nK03s6d
	 hB4XxsiVSWwC0gTl1mwOsORg1cEv85/9KbgSDtjUNIhsJN8QQUq9yIgK5xcWmYhV7b
	 8mzxBBEmWKLPQ==
Message-ID: <4104d690-0a25-4403-9074-aa67fe46dc12@kernel.org>
Date: Thu, 8 May 2025 10:20:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] scripts/bpf_doc.py: implement json output
 format
To: ihor.solodrai@linux.dev, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com, dylan.reimerink@isovalent.com,
 kernel-team@meta.com
References: <20250507203034.270428-1-isolodrai@meta.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250507203034.270428-1-isolodrai@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-05-07 13:30 UTC-0700 ~ Ihor Solodrai <isolodrai@meta.com>
> bpf_doc.py parses bpf.h header to collect information about various
> API elements (such as BPF helpers) and then dump them in one of the
> supported formats: rst docs and a C header.
> 
> It's useful for external tools to be able to consume this information
> in an easy-to-parse format such as JSON. Implement JSON printers and
> add --json command line argument.
> 
> v2->v3: nit cleanup
> v1->v2: add json printer for syscall target
> 
> v2: https://lore.kernel.org/bpf/20250507182802.3833349-1-isolodrai@meta.com/
> v1: https://lore.kernel.org/bpf/20250506000605.497296-1-isolodrai@meta.com/
> 
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>  scripts/bpf_doc.py | 111 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 95 insertions(+), 16 deletions(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index e74a01a85070..b157fab016a3 100755
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
> @@ -43,6 +44,14 @@ class APIElement(object):
>          self.ret = ret
>          self.attrs = attrs
>  
> +    def to_dict(self):
> +        return {
> +            'proto': self.proto,
> +            'desc': self.desc,
> +            'ret': self.ret,
> +            'attrs': self.attrs
> +        }
> +
>  
>  class Helper(APIElement):
>      """
> @@ -81,6 +90,11 @@ class Helper(APIElement):
>  
>          return res
>  
> +    def to_dict(self):
> +        d = super().to_dict()
> +        d.update(self.proto_break_down())
> +        return d
> +
>  
>  ATTRS = {
>      '__bpf_fastcall': 'bpf_fastcall'
> @@ -675,7 +689,7 @@ COMMANDS
>          self.print_elem(command)
>  
>  
> -class PrinterHelpers(Printer):
> +class PrinterHelpersHeader(Printer):
>      """
>      A printer for dumping collected information about helpers as C header to
>      be included from BPF program.
> @@ -896,6 +910,43 @@ class PrinterHelpers(Printer):
>          print(') = (void *) %d;' % helper.enum_val)
>          print('')
>  
> +
> +class PrinterHelpersJSON(Printer):
> +    """
> +    A printer for dumping collected information about helpers as a JSON file.
> +    @parser: A HeaderParser with Helper objects
> +    """
> +
> +    def __init__(self, parser):
> +        self.elements = parser.helpers
> +        self.elem_number_check(
> +            parser.desc_unique_helpers,
> +            parser.define_unique_helpers,
> +            "helper",
> +            "___BPF_FUNC_MAPPER",
> +        )
> +
> +    def print_all(self):
> +        helper_dicts = [helper.to_dict() for helper in self.elements]
> +        out_dict = {'helpers': helper_dicts}
> +        print(json.dumps(out_dict, indent=4))
> +
> +
> +class PrinterSyscallJSON(Printer):
> +    """
> +    A printer for dumping collected syscall information as a JSON file.
> +    @parser: A HeaderParser with APIElement objects
> +    """
> +
> +    def __init__(self, parser):
> +        self.elements = parser.commands
> +        self.elem_number_check(parser.desc_syscalls, parser.enum_syscalls, 'syscall', 'bpf_cmd')
> +
> +    def print_all(self):
> +        syscall_dicts = [syscall.to_dict() for syscall in self.elements]


Looks good and works well, thanks! I tested it and have one more nit:
for syscalls, with JSON, we print an empty "attrs" array for each
syscall subcommand, because the attributes are used with helpers only.
Could we avoid printing these, please? We could refactor the attribute
parsing code to make it apply to helpers only, but the easiest approach
is probably to just discard the attributes from JSON right here, before
we print the dict:

           # Attributes do not apply to syscall subcommands docs
           for syscall in syscall_dicts:
               del syscall['attrs']


> +        out_dict = {'syscall': syscall_dicts}
> +        print(json.dumps(out_dict, indent=4))
> +
>  ###############################################################################
>  

