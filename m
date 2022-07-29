Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960D9584F5F
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 13:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiG2LKm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 07:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiG2LKm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 07:10:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8C54679
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 04:10:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m13so1627059wrq.6
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 04:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=Giw/1gk04NH25KunnIqIMkXWxed0rc1D0pJw4ex8yC8=;
        b=PjmTjRTXIhXGjDWixoZB5nIjNwTE+B/OVhQQ2Yc7DYlCDnth2sDTT8d9tu5CFHeWmR
         5c07QjC2JBaqmNRk92ZwWOEifhLLsE206elBkuygRBPHPNx6ZPijZorJhzb2JX9UsEuQ
         bkqTlUQ5dDIRJRpFQlHoH6bBkLRJVHt36MhH8HO3SE1VIH9jBSAYg5S7mOlyVZ2oHQ55
         U9XpniPt5d/EYx4Uczh0GGm2+I6CQmaZiHo9VFtUY24UYGytHfzjAjPMNRBOt6aDRl3Q
         xxfoLrrAqvTZMpZ71e9McWL0epennp3sFOCKOok4e/jqKYpAUwlrGPX++DmAfMVvxUyQ
         q9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=Giw/1gk04NH25KunnIqIMkXWxed0rc1D0pJw4ex8yC8=;
        b=uSQb0P/FDVXIBHpux0bs617VsbWuAclT/qDmZkb9CkaTJ1Sk9TkHnahwJGqX4rhtif
         DGAKDccWVMFbL+pZlHowyOTlYSwTNq9zFx72w2n/1rTp0c3T33TwgrsTS/97bjZF8piB
         g/VvSQY2MNaBJ+uHbEEDMbvu0aTUPDCvmDRP8u38AVNcUJDF5dHXyDJpoOzUDAva4JGx
         I4xYHtEZFoDpMjKAeFeK/q+AeDnzvBVmov5a0tWo+o0klKdk0sefnee91rtEDyK0RD9h
         6WJzLgPb5sWKIdfgY+rppZzMchlQqwPps9+QIgATNR5HwvsmctVELJ9GUFNiv9FD2xoG
         /5bQ==
X-Gm-Message-State: ACgBeo3eDOmbCFjfcqBGxHqnPwyyNPcyXyRtTyCirVuBVochBqMm+zFV
        D8XhlDjlfau7qHTk8uslcCU=
X-Google-Smtp-Source: AA6agR7IWLLZCkn7+93KTNjSBMUq3dHEOz0d4nRC0t+5wlCyRuplsL48n4trREfDlzg7fhJZTayqaQ==
X-Received: by 2002:a5d:5244:0:b0:21d:866e:2409 with SMTP id k4-20020a5d5244000000b0021d866e2409mr2019603wrc.400.1659093039621;
        Fri, 29 Jul 2022 04:10:39 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id be4-20020a05600c1e8400b0039c454067ddsm4330624wmb.15.2022.07.29.04.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 04:10:39 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 29 Jul 2022 13:10:37 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [RFC PATCH bpf-next 4/7] bpf: x86: Support in-register struct
 arguments
Message-ID: <YuPALUYnHcZ1drB5@krava>
References: <20220726171129.708371-1-yhs@fb.com>
 <20220726171151.712242-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726171151.712242-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 26, 2022 at 10:11:51AM -0700, Yonghong Song wrote:

SNIP

>  
> -static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
> -			 int regs_off)
> +static void __save_struct_arg_regs(u8 **prog, int curr_reg_idx, int nr_regs,
> +				   int struct_val_off, int stack_start_idx)
>  {
> -	int i;
> +	int i, reg_idx;
> +
> +	/* Save struct registers to stack.
> +	 * For example, argument 1 (second argument) size is 16 which occupies two
> +	 * registers, these two register values will be saved in stack.
> +	 * mov QWORD PTR [rbp-0x40],rsi
> +	 * mov QWORD PTR [rbp-0x38],rdx
> +	 */
> +	for (i = 0; i < nr_regs; i++) {
> +		reg_idx = curr_reg_idx + i;
> +		emit_stx(prog, bytes_to_bpf_size(8),
> +			 BPF_REG_FP,
> +			 reg_idx == 5 ? X86_REG_R9 : BPF_REG_1 + reg_idx,
> +			 -(struct_val_off - stack_start_idx * 8));
> +		stack_start_idx++;
> +	}
> +}
> +
> +static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
> +		      int regs_off, int struct_val_off)
> +{
> +	int curr_arg_idx, curr_reg_idx, curr_s_stack_off;
> +	int s_size, s_arg_idx, s_arg_nregs;
> +
> +	curr_arg_idx = curr_reg_idx = curr_s_stack_off = 0;
> +	for (int i = 0; i < MAX_BPF_FUNC_STRUCT_ARGS; i++) {
> +		s_size = m->struct_arg_bsize[i];
> +		if (!s_size)
> +			return __save_normal_arg_regs(m, prog, curr_arg_idx, nr_args - curr_arg_idx,
> +						      curr_reg_idx, regs_off);

could we just do break in here instead?

SNIP

> +
> +static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
> +			 int regs_off, int struct_val_off)
> +{
> +	int curr_arg_idx, curr_reg_idx, curr_s_stack_off;
> +	int s_size, s_arg_idx, s_arg_nregs;
> +
> +	curr_arg_idx = curr_reg_idx = curr_s_stack_off = 0;
> +	for (int i = 0; i < MAX_BPF_FUNC_STRUCT_ARGS; i++) {
> +		s_size = m->struct_arg_bsize[i];
> +		if (!s_size)
> +			return __restore_normal_arg_regs(m, prog, curr_arg_idx,
> +							 nr_args - curr_arg_idx,
> +							 curr_reg_idx, regs_off);

same here

jirka

> +
> +		s_arg_idx = m->struct_arg_idx[i];
> +		s_arg_nregs = (s_size + 7) / 8;
> +
> +		__restore_normal_arg_regs(m, prog, curr_arg_idx, s_arg_idx - curr_arg_idx,
> +					  curr_reg_idx, regs_off);
> +		__restore_struct_arg_regs(prog, curr_reg_idx + s_arg_idx - curr_arg_idx,
> +					  s_arg_nregs, struct_val_off, curr_s_stack_off);
> +		curr_reg_idx += s_arg_idx - curr_arg_idx + s_arg_nregs;
> +		curr_s_stack_off += s_arg_nregs;
> +		curr_arg_idx = s_arg_idx + 1;
> +	}
> +
> +	__restore_normal_arg_regs(m, prog, curr_arg_idx, nr_args - curr_arg_idx, curr_reg_idx,
> +				  regs_off);
>  }
>  

SNIP
