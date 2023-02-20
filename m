Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F3069D653
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 23:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjBTWal (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 17:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBTWal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 17:30:41 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C241E1EF
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 14:30:39 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id fb30so1241558pfb.13
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 14:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKy8AOJlnqk2z9bd4BuGtXzV3BOH/XKBuEon+28lL+w=;
        b=iMQXVLJUM2nQcSKc8u473CKeJjCVc/uqX3jnyZBinAMl5FfSqWxzMsZw68ICRSpeCc
         9iqRzjYRgY0prT7ZLaEIctTUGAe/GvzNVr810pSPz83ieWfTAvJ8RlOWkKPSha6D+e0H
         xLm5ygcbWi9fyPmFwzUTilZh9nzuA/g9OMRFV8MXMgeOQwYuppUqEid0DnP9RIL2/qz/
         d56qrdIuGHpXUPT7TPhmtvO1C/RA4cY2eVeNcOSa1aIy+w1r0AQG35cbD2GToka02tJ2
         9EscC0xmxh/FoUXoEM93oPW+GPsAV0lKV1u976NRuso73lXb6TbkskNsm1iL03XvU16D
         he3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKy8AOJlnqk2z9bd4BuGtXzV3BOH/XKBuEon+28lL+w=;
        b=BhUuOtVKlB9RR/e9ljSry9HsS5uThkk2cCPWFmX83P7aQWSjU1aUay0kKYQkuV8kFB
         FXLbYUy5omrNXz0KI9kraAGYWGZs4VcVpS2GotGKTdW7iXACvVPCrvnNHoH6DewvWQfc
         6Mjj+y/QNyomDoMaprY1xSZklfO0UcQe/WGSSfeUi5Eed0vWySjiO62MEbuov1Maf6Cn
         +hF4qGcXjJnBxlAJLiKPWMBqDG1pQlaByj4YqjlD7FwbiDQGAjGpvjRzaEwyL/S+K8vl
         B0HoGUoFk+Wyll6Ypu3TBAr3OVF9w7969z8vbwu3mmSqfPU9jwpXlnrNgdzeghe3dqNo
         qg9Q==
X-Gm-Message-State: AO0yUKU38oS/KaDQ3uOC9GMUubBf1Nc0+pW7ee+fcAoPQ/7NGFtZqT+A
        5FL5Q+Qm2190k+fNGWTMx84=
X-Google-Smtp-Source: AK7set+Vm0Oe10NSO0KNRgqaA44wfh/lywOaffQqLfzGfqBN+HWNwBBUratRctFMQwECvby62OwmKg==
X-Received: by 2002:a62:2f41:0:b0:5a8:808a:d3ce with SMTP id v62-20020a622f41000000b005a8808ad3cemr2791555pfv.8.1676932238816;
        Mon, 20 Feb 2023 14:30:38 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:4542])
        by smtp.gmail.com with ESMTPSA id e12-20020a62aa0c000000b005a8b4dcd21asm8431839pff.15.2023.02.20.14.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:30:38 -0800 (PST)
Date:   Mon, 20 Feb 2023 14:30:34 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, olsajiri@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
        eddyz87@gmail.com, sinquersw@gmail.com, timo@incline.eu,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC dwarves 1/4] dwarf_loader: mark functions that do not use
 expected registers for params
Message-ID: <20230220223034.sgtda6mcrwuqwvk4@macbook-pro-6.dhcp.thefacebook.com>
References: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
 <1676675433-10583-2-git-send-email-alan.maguire@oracle.com>
 <20230220190335.bk6jzayfqivsh7rv@macbook-pro-6.dhcp.thefacebook.com>
 <0bf3e832-ef5b-6ab5-4d8b-1de8e957e166@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf3e832-ef5b-6ab5-4d8b-1de8e957e166@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 07:42:15PM +0000, Alan Maguire wrote:
> On 20/02/2023 19:03, Alexei Starovoitov wrote:
> > On Fri, Feb 17, 2023 at 11:10:30PM +0000, Alan Maguire wrote:
> >> Calling conventions dictate which registers are used for
> >> function parameters.
> >>
> >> When a function is optimized however, we need to ensure that
> >> the non-optimized parameters do not violate expectations about
> >> register use as this would violate expectations for tracing.
> >> At CU initialization, create a mapping from parameter index
> >> to expected DW_OP_reg, and use it to validate parameters
> >> match with expectations.  A parameter which is passed via
> >> the stack, as a constant, or uses an unexpected register,
> >> violates these expectations and it (and the associated
> >> function) are marked as having unexpected register mapping.
> >>
> >> Note though that there is as exception here that needs to
> >> be handled; when a (typedef) struct is passed as a parameter,
> >> it can use multiple registers so will throw off later register
> >> expectations.  Exempt functions that have unexpected
> >> register usage _and_ struct parameters (examples are found
> >> in the "tracing_struct" test).
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >> ---
> >>  dwarf_loader.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++---
> >>  dwarves.h      |   5 +++
> >>  2 files changed, 109 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/dwarf_loader.c b/dwarf_loader.c
> >> index acdb68d..014e130 100644
> >> --- a/dwarf_loader.c
> >> +++ b/dwarf_loader.c
> >> @@ -1022,6 +1022,51 @@ static int arch__nr_register_params(const GElf_Ehdr *ehdr)
> >>  	return 0;
> >>  }
> >>  
> >> +/* map from parameter index (0 for first, ...) to expected DW_OP_reg.
> >> + * This will allow us to identify cases where optimized-out parameters
> >> + * interfere with expectations about register contents on function
> >> + * entry.
> >> + */
> >> +static void arch__set_register_params(const GElf_Ehdr *ehdr, struct cu *cu)
> >> +{
> >> +	memset(cu->register_params, -1, sizeof(cu->register_params));
> >> +
> >> +	switch (ehdr->e_machine) {
> >> +	case EM_S390:
> >> +		/* https://github.com/IBM/s390x-abi/releases/download/v1.6/lzsabi_s390x.pdf */
> >> +		cu->register_params[0] = DW_OP_reg2;	// %r2
> >> +		cu->register_params[1] = DW_OP_reg3;	// %r3
> >> +		cu->register_params[2] = DW_OP_reg4;	// %r4
> >> +		cu->register_params[3] = DW_OP_reg5;	// %r5
> >> +		cu->register_params[4] = DW_OP_reg6;	// %r6
> >> +		return;
> >> +	case EM_X86_64:
> >> +		/* //en.wikipedia.org/wiki/X86_calling_conventions#System_V_AMD64_ABI */
> >> +		cu->register_params[0] = DW_OP_reg5;	// %rdi
> >> +		cu->register_params[1] = DW_OP_reg4;	// %rsi
> >> +		cu->register_params[2] = DW_OP_reg1;	// %rdx
> >> +		cu->register_params[3] = DW_OP_reg2;	// %rcx
> >> +		cu->register_params[4] = DW_OP_reg8;	// %r8
> >> +		cu->register_params[5] = DW_OP_reg9;	// %r9
> >> +		return;
> >> +	case EM_ARM:
> >> +		/* https://github.com/ARM-software/abi-aa/blob/main/aapcs32/aapcs32.rst#machine-registers */
> >> +	case EM_AARCH64:
> >> +		/* https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#machine-registers */
> >> +		cu->register_params[0] = DW_OP_reg0;
> >> +		cu->register_params[1] = DW_OP_reg1;
> >> +		cu->register_params[2] = DW_OP_reg2;
> >> +		cu->register_params[3] = DW_OP_reg3;
> >> +		cu->register_params[4] = DW_OP_reg4;
> >> +		cu->register_params[5] = DW_OP_reg5;
> >> +		cu->register_params[6] = DW_OP_reg6;
> >> +		cu->register_params[7] = DW_OP_reg7;
> >> +		return;
> >> +	default:
> >> +		return;
> >> +	}
> >> +}
> >> +
> >>  static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
> >>  					struct conf_load *conf, int param_idx)
> >>  {
> >> @@ -1075,18 +1120,28 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
> >>  		if (parm->has_loc &&
> >>  		    attr_location(die, &loc.expr, &loc.exprlen) == 0 &&
> >>  			loc.exprlen != 0) {
> >> +			int expected_reg = cu->register_params[param_idx];
> >>  			Dwarf_Op *expr = loc.expr;
> >>  
> >>  			switch (expr->atom) {
> >>  			case DW_OP_reg0 ... DW_OP_reg31:
> >> +				/* mark parameters that use an unexpected
> >> +				 * register to hold a parameter; these will
> >> +				 * be problematic for users of BTF as they
> >> +				 * violate expectations about register
> >> +				 * contents.
> >> +				 */
> >> +				if (expected_reg >= 0 && expected_reg != expr->atom)
> >> +					parm->unexpected_reg = 1;
> >> +				break;
> > 
> > Overall I guess it's a step forward, since it addresses the immediate issue,
> > but probably too fragile long term.
> > 
> > Your earlier example:
> >  __bpf_kfunc void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked)
> > 
> > had
> > 0x0891dabe:     DW_TAG_formal_parameter
> >                   DW_AT_location        (indexed (0x7a) loclist = 0x00f50eb1:
> >                      [0xffffffff82031185, 0xffffffff8203119e): DW_OP_reg5 RDI
> >                      [0xffffffff8203119e, 0xffffffff820311cc): DW_OP_reg3 RBX
> >                      [0xffffffff820311cc, 0xffffffff820311d1): DW_OP_reg5 RDI
> >                      [0xffffffff820311d1, 0xffffffff820311d2): DW_OP_reg3 RBX
> >                      [0xffffffff820311d2, 0xffffffff820311d8): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
> > 
> > 0x0891dad4:     DW_TAG_formal_parameter
> >                   DW_AT_location        (indexed (0x7b) loclist = 0x00f50eda:
> >                      [0xffffffff82031185, 0xffffffff820311bc): DW_OP_reg1 RDX
> >                      [0xffffffff820311bc, 0xffffffff820311c8): DW_OP_reg0 RAX
> >                      [0xffffffff820311c8, 0xffffffff820311d1): DW_OP_reg1 RDX)
> >                   DW_AT_name    ("acked")
> > 
> > Both args will fail above check. If I'm reading above code correctly.
> > It checks that every reg in DW_AT_location matches ?
> 
> It checks location info for those that have it; so in this case the location
> lists specify rdi on entry for the first parameter (sk)
> 
> 
> 0x068a0f3b:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x74) loclist = 0x00a4c5a0:
>                      [0xffffffff81b87849, 0xffffffff81b87866): DW_OP_reg5 RDI
>                      [0xffffffff81b87866, 0xffffffff81b87899): DW_OP_reg3 RBX
>                      [0xffffffff81b87899, 0xffffffff81b878a0): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>                   DW_AT_name    ("sk")
>                   DW_AT_decl_file       ("/home/opc/src/clang/bpf-next/net/ipv4/tcp_cong.c")
>                   DW_AT_decl_line       (446)
>                   DW_AT_type    (0x06886461 "sock *")
> 
> 
> no location info for the second (ack):
> 
> 0x068a0f47:     DW_TAG_formal_parameter
>                   DW_AT_name    ("ack")
>                   DW_AT_decl_file       ("/home/opc/src/clang/bpf-next/net/ipv4/tcp_cong.c")
>                   DW_AT_decl_line       (446)
>                   DW_AT_type    (0x06886451 "u32")
> 
> ...so matching it is skipped, and rdx as the first element in the location list
> for the third parameter (acked):
> 
> 0x068a0f52:     DW_TAG_formal_parameter
>                   DW_AT_location        (indexed (0x75) loclist = 0x00a4c5bb:
>                      [0xffffffff81b87849, 0xffffffff81b87884): DW_OP_reg1 RDX
>                      [0xffffffff81b87884, 0xffffffff81b87890): DW_OP_reg0 RAX
>                      [0xffffffff81b87890, 0xffffffff81b87898): DW_OP_reg1 RDX)
>                   DW_AT_name    ("acked")
>                   DW_AT_decl_file       ("/home/opc/src/clang/bpf-next/net/ipv4/tcp_cong.c")
>                   DW_AT_decl_line       (446)
>                   DW_AT_type    (0x06886451 "u32")
> 
> 
> So this would be okay using the register-checking approach.

I meant in all that it's not clear that first and only first location info is used.
Is that the behavior of attr_location() ?


> > Or just first ?
> > 
> >>  			case DW_OP_breg0 ... DW_OP_breg31:
> >>  				break;
> >>  			default:
> >> -				parm->optimized = 1;
> >> +				parm->unexpected_reg = 1;
> >>  				break;
> >>  			}
> >>  		} else if (has_const_value) {
> >> -			parm->optimized = 1;
> >> +			parm->unexpected_reg = 1;
> > 
> > Is this part too restrictive as well?
> > Just because one arg is constant it doesn't mean that the calling convention
> > is not correct for this and other args.
> > 
> 
> Great catch; this part is wrong; should just be parm->optimized = 1 as it
> was before.

Will this fix change the stats you've quoted earlier ?

"
With these changes, running pahole on a gcc-built
vmlinux skips

- 1164 functions due to multiple inconsistent function
  prototypes.  Most of these are "."-suffixed optimized
  fuctions.
- 331 functions due to unexpected register usage

For a clang-built kernel, the numbers are

- 539 functions with inconsistent prototypes are skipped
- 209 functions with unexpected register usage are skipped
"

How does it compare before/after ?
iirc there were ~2500 functions skipped in vmlinux-gcc and now it's down to 1164+331 ?
