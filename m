Return-Path: <bpf+bounces-44502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A43E9C3B6A
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 10:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE132833A3
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 09:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E351662FA;
	Mon, 11 Nov 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMOzJZmB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3D12C54B;
	Mon, 11 Nov 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318861; cv=none; b=aplepYeir666u51LWI5LLo4r/4QWaQqZz55WD74PvsJB9vbqU3CxJS16z5D5t5uSmyQdHqfmEsuHc/wGn52fe08sdQOF+SsEZJY7+yW7/DzbpV4IrY/UZNH9FDb1I/lyev8qwAM8KoafI+M/FmvEIFvDhV/Xx3x/gPWYDWpkV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318861; c=relaxed/simple;
	bh=YHJxIYeY914HoQ20eShbZnSorfeSy6xxRBUKJzUfbuM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgKwfCPwogbozM6BOT86Du2UqKzJ8H1Y+W0U74tfWqPZfNvPOV/EYPMhxcu9zzTd9ivjdtrwhc4b2fVGdeiSzl9L2eI6G+eI8NftZFPo2rD8o7lGGrlyRRbDWMI+qyWx2nCFNeX1jeC/QQFfk+I7wJ5vCX3OORAxsU0nlRikr40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMOzJZmB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9ed49edd41so772805066b.0;
        Mon, 11 Nov 2024 01:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318858; x=1731923658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xccvxVAPcgqQw26WknZ5D9ZxLw9B/1sb3k0l0/IcmvY=;
        b=KMOzJZmBqfdruqZ7IzX4wgk1Sdkz2QHvTGiDtpZy8eVPDxeOAiIxNGsuKDTTPiCqhq
         XRUNd5shp6kqLoiRyZYhL8VURyPqMIkv23Yn2YhPkfhUu9jjN5XaGnBgl7vEzuHLTY/g
         n2kwMIHy3BvbWA6ewRCzEv6McDnj01u97lidbx98lLreiKvpAUgCrcHAu1z3O0GCRlZt
         7otZkKP9DHZjtAptEJlR4oWbpF5m8ti57b33KzrAZciJEUVf2R2m7E/HxzOs+AjXuwWO
         Y8bOzAUcxhtvrphWBOXeSw/8gtY6Nc2IkmZ53946Z8CsLiAk/Wgye2+6sJF2ebImF77D
         9wSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318858; x=1731923658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xccvxVAPcgqQw26WknZ5D9ZxLw9B/1sb3k0l0/IcmvY=;
        b=anOs+Xt3224jyOLYZFEhGjoqHwls1OA4vcOcmLdosumJjCVV3msKfnYG72lqKICtj5
         RnnyXm+psKdrlRYqCnv6Rr1z8vOpYiJFIS9Foc2XPaC+1QKuvqRfMV5HhzzgAsJ1RmtW
         m6g8P6CToQjKlaolH9Zfs9S7T7Dq37BYf+XYchxDxXUkhTA/w5IaB3cRuhOLRRJpGFGK
         mf8LK1VKIPKxV3f3IbdFf4AjztZ01dbbgNv46L37AWut7Geq92yghLZAD6kMGUaKue0j
         Wad8rr5JoFddSsZSg/p42lwBNUH9MpVYMIRBIz/nO3QavKEy7R+yPpbtZfFjSlJkd9ve
         9i4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCR6T++eFd/q7YeYTAZDeHMdH5r5FKnmXYaGy+eymemvdHpyYGE4M50YOKBip6CJjh0O3g5ujaKw==@vger.kernel.org, AJvYcCWA1Fw2v3PLibRSLJBpDVItG5qJk9svZ+TqBoId1PcvKiJRuX0snT7VKXkD/3IErWqKpyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybcu1xgJT7IeFcvrJjDMHPg+OJo+M1OCDJgkY8LnZr/LoXB/1A
	p0TnS2uUj238GmrB9ghUg7Egi3p+p+6DCPgpNk5RjhM3oiFD5W0S
X-Google-Smtp-Source: AGHT+IF85PLdQJFJatQ+e77gMdZ/BxH/s8vcoH2ZXna9kNyDh1TWF3Ani7j5hG1947AnSLrsp3V8dg==
X-Received: by 2002:a17:907:844:b0:a9a:a96a:e280 with SMTP id a640c23a62f3a-a9eeff0ea22mr1206840266b.20.1731318857698;
        Mon, 11 Nov 2024 01:54:17 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0df0c85sm572170866b.171.2024.11.11.01.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:54:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Nov 2024 10:54:15 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
Message-ID: <ZzHURz01dzLHO2H4@krava>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108180524.1198900-1-yonghong.song@linux.dev>

On Fri, Nov 08, 2024 at 10:05:24AM -0800, Yonghong Song wrote:
> Song Liu reported that a kernel func (perf_event_read()) cannot be traced
> in certain situations since the func is not in vmlinux bTF. This happens
> in kernels 6.4, 6.9 and 6.11 and the kernel is built with pahole 1.27.
> 
> The perf_event_read() signature in kernel (kernel/events/core.c):
>    static int perf_event_read(struct perf_event *event, bool group)
> 
> Adding '-V' to pahole command line, and the following error msg can be found:
>    skipping addition of 'perf_event_read'(perf_event_read) due to unexpected register used for parameter
> 
> Eventually the error message is attributed to the setting
> (parm->unexpected_reg = 1) in parameter__new() function.
> 
> The following is the dwarf representation for perf_event_read():
>     0x0334c034:   DW_TAG_subprogram
>                 DW_AT_low_pc    (0xffffffff812c6110)
>                 DW_AT_high_pc   (0xffffffff812c640a)
>                 DW_AT_frame_base        (DW_OP_reg7 RSP)
>                 DW_AT_GNU_all_call_sites        (true)
>                 DW_AT_name      ("perf_event_read")
>                 DW_AT_decl_file ("/rw/compile/kernel/events/core.c")
>                 DW_AT_decl_line (4641)
>                 DW_AT_prototyped        (true)
>                 DW_AT_type      (0x03324f6a "int")
>     0x0334c04e:     DW_TAG_formal_parameter
>                   DW_AT_location        (0x007de9fd:
>                      [0xffffffff812c6115, 0xffffffff812c6141): DW_OP_reg5 RDI
>                      [0xffffffff812c6141, 0xffffffff812c6323): DW_OP_reg14 R14
>                      [0xffffffff812c6323, 0xffffffff812c63fe): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
>                      [0xffffffff812c63fe, 0xffffffff812c6405): DW_OP_reg14 R14
>                      [0xffffffff812c6405, 0xffffffff812c640a): DW_OP_GNU_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>                   DW_AT_name    ("event")
>                   DW_AT_decl_file       ("/rw/compile/kernel/events/core.c")
>                   DW_AT_decl_line       (4641)
>                   DW_AT_type    (0x0333aac2 "perf_event *")
>     0x0334c05e:     DW_TAG_formal_parameter
>                   DW_AT_location        (0x007dea82:
>                      [0xffffffff812c6137, 0xffffffff812c63f2): DW_OP_reg12 R12
>                      [0xffffffff812c63f2, 0xffffffff812c63fe): DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
>                      [0xffffffff812c63fe, 0xffffffff812c640a): DW_OP_reg12 R12)
>                   DW_AT_name    ("group")
>                   DW_AT_decl_file       ("/rw/compile/kernel/events/core.c")
>                   DW_AT_decl_line       (4641)
>                   DW_AT_type    (0x03327059 "bool")

hi,
I don't see that on gcc compiled kernel, is that related to clang?


 <1><318d475>: Abbrev Number: 74 (DW_TAG_subprogram)
    <318d476>   DW_AT_name        : (indirect string, offset: 0xf5776): perf_event_read
    <318d47a>   DW_AT_decl_file   : 1
    <318d47a>   DW_AT_decl_line   : 4746
    <318d47c>   DW_AT_decl_column : 12
    <318d47d>   DW_AT_prototyped  : 1
    <318d47d>   DW_AT_type        : <0x3135e35>
    <318d481>   DW_AT_low_pc      : 0xffffffff8135be90
    <318d489>   DW_AT_high_pc     : 0x196
    <318d491>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
    <318d493>   DW_AT_call_all_calls: 1
    <318d493>   DW_AT_sibling     : <0x318d900>
 <2><318d497>: Abbrev Number: 30 (DW_TAG_formal_parameter)
    <318d498>   DW_AT_name        : (indirect string, offset: 0x491590): event
    <318d49c>   DW_AT_decl_file   : 1
    <318d49c>   DW_AT_decl_line   : 4746
    <318d49e>   DW_AT_decl_column : 47
    <318d49f>   DW_AT_type        : <0x313a680>
    <318d4a3>   DW_AT_location    : 0x70c118 (location list)
    <318d4a7>   DW_AT_GNU_locviews: 0x70c110
 <2><318d4ab>: Abbrev Number: 30 (DW_TAG_formal_parameter)
    <318d4ac>   DW_AT_name        : (indirect string, offset: 0x51a865): group
    <318d4b0>   DW_AT_decl_file   : 1
    <318d4b0>   DW_AT_decl_line   : 4746
    <318d4b2>   DW_AT_decl_column : 59
    <318d4b3>   DW_AT_type        : <0x3136055>
    <318d4b7>   DW_AT_location    : 0x70c144 (location list)
    <318d4bb>   DW_AT_GNU_locviews: 0x70c13e

locations:
    0070c144 ffffffff8135be90 (base address)
    0070c14d v000000000000000 v000000000000000 views at 0070c13e for:
             ffffffff8135be90 ffffffff8135bed2 (DW_OP_reg4 (rsi))
    0070c152 v000000000000000 v000000000000000 views at 0070c140 for:
             ffffffff8135bed2 ffffffff8135bf17 (DW_OP_reg14 (r14))
    0070c158 v000000000000000 v000000000000000 views at 0070c142 for:
             ffffffff8135bf17 ffffffff8135c026 (DW_OP_entry_value: (DW_OP_reg4 (rsi)); DW_OP_stack_value)
    0070c162 <End of list>


other than that lgtm and I like the change Eduard suggested

thanks,
jirka

> 
> By inspecting the binary, the second argument ("bool group") is used
> in the function. The following are the disasm code:
>     ffffffff812c6110 <perf_event_read>:
>     ffffffff812c6110: 0f 1f 44 00 00        nopl    (%rax,%rax)
>     ffffffff812c6115: 55                    pushq   %rbp
>     ffffffff812c6116: 41 57                 pushq   %r15
>     ffffffff812c6118: 41 56                 pushq   %r14
>     ffffffff812c611a: 41 55                 pushq   %r13
>     ffffffff812c611c: 41 54                 pushq   %r12
>     ffffffff812c611e: 53                    pushq   %rbx
>     ffffffff812c611f: 48 83 ec 18           subq    $24, %rsp
>     ffffffff812c6123: 41 89 f4              movl    %esi, %r12d
>     <=========== NOTE that here '%esi' is used and moved to '%r12d'.
>     ffffffff812c6126: 49 89 fe              movq    %rdi, %r14
>     ffffffff812c6129: 65 48 8b 04 25 28 00 00 00    movq    %gs:40, %rax
>     ffffffff812c6132: 48 89 44 24 10        movq    %rax, 16(%rsp)
>     ffffffff812c6137: 8b af a8 00 00 00     movl    168(%rdi), %ebp
>     ffffffff812c613d: 85 ed                 testl   %ebp, %ebp
>     ffffffff812c613f: 75 3f                 jne     0xffffffff812c6180 <perf_event_read+0x70>
>     ffffffff812c6141: 66 2e 0f 1f 84 00 00 00 00 00 nopw    %cs:(%rax,%rax)
>     ffffffff812c614b: 0f 1f 44 00 00        nopl    (%rax,%rax)
>     ffffffff812c6150: 49 8b 9e 28 02 00 00  movq    552(%r14), %rbx
>     ffffffff812c6157: 48 89 df              movq    %rbx, %rdi
>     ffffffff812c615a: e8 c1 a0 d7 00        callq   0xffffffff82040220 <_raw_spin_lock_irqsave>
>     ffffffff812c615f: 49 89 c7              movq    %rax, %r15
>     ffffffff812c6162: 41 8b ae a8 00 00 00  movl    168(%r14), %ebp
>     ffffffff812c6169: 85 ed                 testl   %ebp, %ebp
>     ffffffff812c616b: 0f 84 9a 00 00 00     je      0xffffffff812c620b <perf_event_read+0xfb>
>     ffffffff812c6171: 48 89 df              movq    %rbx, %rdi
>     ffffffff812c6174: 4c 89 fe              movq    %r15, %rsi
>     <=========== NOTE: %rsi is overwritten
>     ......
>     ffffffff812c63f0: 41 5c                 popq    %r12
>     <============ POP r12
>     ffffffff812c63f2: 41 5d                 popq    %r13
>     ffffffff812c63f4: 41 5e                 popq    %r14
>     ffffffff812c63f6: 41 5f                 popq    %r15
>     ffffffff812c63f8: 5d                    popq    %rbp
>     ffffffff812c63f9: e9 e2 a8 d7 00        jmp     0xffffffff82040ce0 <__x86_return_thunk>
>     ffffffff812c63fe: 31 c0                 xorl    %eax, %eax
>     ffffffff812c6400: e9 be fe ff ff        jmp     0xffffffff812c62c3 <perf_event_read+0x1b3>
> 
> It is not clear why dwarf didn't encode %rsi in locations. But
> DW_OP_GNU_entry_value(DW_OP_reg4 RSI) tells us that RSI is live at
> the entry of perf_event_read(). So this patch tries to search
> DW_OP_GNU_entry_value/DW_OP_entry_value location/expression so if
> the expected parameter register matchs the register in
> DW_OP_GNU_entry_value/DW_OP_entry_value, then the original parameter
> is not optimized.
> 
> For one of internal 6.11 kernel, there are 62498 functions in BTF and
> perf_event_read() is not there. With this patch, there are 61552 functions
> in BTF and perf_event_read() is included.
> 
> Reported-by: Song Liu <song@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  dwarf_loader.c | 81 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 57 insertions(+), 24 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index e0b8c11..1fe44bc 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1169,34 +1169,67 @@ static bool check_dwarf_locations(Dwarf_Attribute *attr, struct parameter *parm,
>  		return false;
>  
>  #if _ELFUTILS_PREREQ(0, 157)
> -	/* dwarf_getlocations() handles location lists; here we are
> -	 * only interested in the first expr.
> -	 */
> -	if (dwarf_getlocations(attr, 0, &base, &start, &end,
> -			       &loc.expr, &loc.exprlen) > 0 &&
> -		loc.exprlen != 0) {
> -		expr = loc.expr;
> -
> -		switch (expr->atom) {
> -		case DW_OP_reg0 ... DW_OP_reg31:
> -			/* mark parameters that use an unexpected
> -			 * register to hold a parameter; these will
> -			 * be problematic for users of BTF as they
> -			 * violate expectations about register
> -			 * contents.
> +	bool reg_matched = false, reg_unmatched = false, first_expr_reg = false, ret = false;
> +	ptrdiff_t offset = 0;
> +	int loc_num = -1;
> +
> +	while ((offset = dwarf_getlocations(attr, offset, &base, &start, &end, &loc.expr, &loc.exprlen)) > 0 &&
> +	       loc.exprlen != 0) {
> +		ret = true;
> +		loc_num++;
> +
> +		for (int i = 0; i < loc.exprlen; i++) {
> +			Dwarf_Attribute entry_attr;
> +			Dwarf_Op *entry_ops;
> +			size_t entry_len;
> +
> +			expr = &loc.expr[i];
> +			switch (expr->atom) {
> +			case DW_OP_reg0 ... DW_OP_reg31:
> +				/* first location, first expression */
> +				if (loc_num == 0 && i == 0) {
> +					if (expected_reg >= 0) {
> +						if (expected_reg == expr->atom) {
> +							reg_matched = true;
> +							return true;
> +						} else {
> +							reg_unmatched = true;
> +						}
> +					}
> +					first_expr_reg = true;
> +				}
> +				break;
> +			/* For the following dwarf entry (arch x86_64) in parameter locations:
> +			 *    DW_OP_GNU_entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
> +			 * RSI register should be available at the entry of the program.
>  			 */
> -			if (expected_reg >= 0 && expected_reg != expr->atom)
> -				parm->unexpected_reg = 1;
> -			break;
> -		default:
> -			parm->optimized = 1;
> -			break;
> +			case DW_OP_entry_value:
> +			case DW_OP_GNU_entry_value:
> +				if (reg_matched)
> +					break;
> +				if (dwarf_getlocation_attr (attr, expr, &entry_attr) != 0)
> +					break;
> +				if (dwarf_getlocation (&entry_attr, &entry_ops, &entry_len) != 0)
> +					break;
> +				if (entry_len != 1)
> +					break;
> +				if (expected_reg >= 0 && expected_reg == entry_ops->atom) {
> +					reg_matched = true;
> +					return true;
> +				}
> +				break;
> +			default:
> +				break;
> +			}
>  		}
> -
> -		return true;
>  	}
>  
> -	return false;
> +	if (reg_unmatched)
> +		parm->unexpected_reg = 1;
> +	else if (ret && !first_expr_reg)
> +		parm->optimized = 1;
> +
> +	return ret;
>  #else
>  	if (dwarf_getlocation(attr, &loc.expr, &loc.exprlen) == 0 &&
>  		loc.exprlen != 0) {
> -- 
> 2.43.5
> 
> 

