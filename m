Return-Path: <bpf+bounces-57700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57DAAEC5F
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 21:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ACA07B6A7B
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A0228E598;
	Wed,  7 May 2025 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXKHA07p"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6C19CC0A
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647012; cv=none; b=ox9UAywm1geLugptuzm5e6KcJgs3KWLIsbv3pO++s9gcdzuyg4igUAPESMg40IlyNGqpyZrtArkpfNKeKd6Wg+34Z0+N86VJiz78j4nn641DA0OBQvXxYzLc2L0Oai1ZlYx7z7gMov6aF1ni+v4CZAfP4dpwDsLJJDYb6eiP3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647012; c=relaxed/simple;
	bh=7zsxMhK2VfLQhTtOvFEvpNW6uDj1+sVNHFiMPFai3C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISjosYPrRWEcagf7nKuFkj5yPEoKn9WCMm2TB5ExGOtIa10Zj+bCNnNiZF3oRuwANgIagkbfq18gDXGP63/FWPUfO3CT8qzv1tCYb1sF3yUgZoU0WyLTQaBompAxTYsDaH1Pxgr/aAJR5NPYIzvFuVxpwE2Zb20hUXJsgv0F8rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXKHA07p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAA2C4CEE2;
	Wed,  7 May 2025 19:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746647010;
	bh=7zsxMhK2VfLQhTtOvFEvpNW6uDj1+sVNHFiMPFai3C4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RXKHA07p7WZ/diw5zNORvrbc/dPIvnh3fUMXcQPTMovQNa7LOfFQpdllbGHHZImE8
	 IFuBY3ZcY8By1vmAjHhgovE/Ue1M7BsAh42wPdA/361qRSjFAXVzBOOTESAfFezgw7
	 rayxtFAZwolSrDbdxMjP1ozPxx6z0nC1LC483wnw5zRTBfoiHLY23lA4FG24g+lqFN
	 lPVAcspu5HZ3ObfjY8Odf0s88U8sWA3LOqdKLKuDzfEMxWxnlIObJ6E18uxJFNa4TF
	 nnYgIMBsxxJNAtqaIn5grdAaz52tgnJv1J8n+KM3gFtubWE5ceZ3lryQY+4FIFvOBo
	 NVaR6/pNVjUaQ==
Message-ID: <c69aaf7b-6e7c-4236-b571-9efc273e27e1@kernel.org>
Date: Wed, 7 May 2025 20:43:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] scripts/bpf_doc.py: implement json output
 format
To: ihor.solodrai@linux.dev, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com, dylan.reimerink@isovalent.com,
 kernel-team@meta.com
References: <20250507182802.3833349-1-isolodrai@meta.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250507182802.3833349-1-isolodrai@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-05-07 11:28 UTC-0700 ~ Ihor Solodrai <isolodrai@meta.com>
> bpf_doc.py parses bpf.h header to collect information about various
> API elements (such as BPF helpers) and then dump them in one of the
> supported formats: rst docs and a C header.
> 
> It's useful for external tools to be able to consume this information
> in an easy-to-parse format such as JSON. Implement JSON printers and
> add --json command line argument.
> 
> v1: https://lore.kernel.org/bpf/20250506000605.497296-1-isolodrai@meta.com/
> 
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>  scripts/bpf_doc.py | 112 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 98 insertions(+), 14 deletions(-)
> 
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index e74a01a85070..d669a0e16bf2 100755
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
> +        out_dict = {'syscall': syscall_dicts}
> +        print(json.dumps(out_dict, indent=4))
> +
>  ###############################################################################
>  
>  # If script is launched from scripts/ from kernel tree and can access
> @@ -910,6 +961,19 @@ printers = {
>          'syscall': PrinterSyscallRST,
>  }


Can you please remove the old "printers" dict that is right above? It's
no longer used now that you redefine it below.

pw-bot: cr

>  
> +# target -> output format -> printer
> +printers = {
> +    'helpers': {
> +        'rst': PrinterHelpersRST,
> +        'json': PrinterHelpersJSON,
> +        'header': PrinterHelpersHeader,
> +    },
> +    'syscall': {
> +        'rst': PrinterSyscallRST,
> +        'json': PrinterSyscallJSON
> +    },
> +}
> +
>  argParser = argparse.ArgumentParser(description="""
>  Parse eBPF header file and generate documentation for the eBPF API.
>  The RST-formatted output produced can be turned into a manual page with the

[...]

