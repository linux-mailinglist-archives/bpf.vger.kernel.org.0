Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1943C9C3D
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbhGOJ6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 05:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhGOJ6k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 05:58:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CC5C06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 02:55:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f17so6966539wrt.6
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QrEkh4TuE8YIGp1GEeL6M7jA+cvF+saL8niZXpeoUCM=;
        b=mVnqrZC8f1gk1otC+arM3lJvqQMAh/r4E5YiwKPbWFe0Ix/pMucqSXvupq61JW+tPs
         Pf5yYFVw17iJhdbvrzfPJvX8TJpIjqb+lvGDFtP3wsdzQJDEEPl3M8/cbvmgRv6u+v/a
         kk6nmOBH0XSZRBBbyQoG1gJHmR1SEpUZYGUWOM0QoYZm6j2qbkyrZ7H/ffGA2pW/XwbW
         dMNPnBAZO7tA5juK5ow4tEfP6WIgWVn/PTFFr6QaFUUTEJube2PrTAr68uxiAXXDuWnQ
         0NYMxpdhj5nwOKiGE+mGrCKFzW1qEvM4V8PYt0u6dI2yvxwShHko6riOSAdS/2Vl+JoP
         Lh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QrEkh4TuE8YIGp1GEeL6M7jA+cvF+saL8niZXpeoUCM=;
        b=OmH3pSmYkeNtg3aPeWFmF0YxiI+UQBOqw1+LcqGWfzSkmU/tTj6vaZGf5Q3sszkn1s
         WZGrWQ/4uB1fTDeZcArpkfX8wK4nwUgu947D6m7Vdo625SXrjfFTlrnh85rnIyfX5XQ3
         D9FGkkpJ9Ph4lGYxA0rbjB3Cr6aChPIzTI+49opt67pqo3ZBomKOBvm+1LHPyZg2ZHz4
         PPKTGHWndLcMJfAdTTgTZgs4+IBytLO3Iz+aMXsaL3z8Qjyrt0gC6ofjItga15cUrbnh
         bewsxwZMePzpdMqlr6qOccDaTDy/8G1N1r0GXa04iRFTxadZSV7oiCQiyeZBFLXpxuFc
         cwZA==
X-Gm-Message-State: AOAM531VvcdjXnonhEIv6wf1bbHy+DQGxbSFiQQ1lwYP+zHdujNEMJp7
        Cej+Bp7ApWRturA2RcOTLmYSmw==
X-Google-Smtp-Source: ABdhPJy7XFbOg6qtWZe6/olIas+Mj0HwPL4TFSJiU65txKv0eGxWzVIFjS9ulCzJRWbGXRbzPrXxbA==
X-Received: by 2002:a5d:4bc4:: with SMTP id l4mr4369907wrt.67.1626342945510;
        Thu, 15 Jul 2021 02:55:45 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.88.136])
        by smtp.gmail.com with ESMTPSA id p12sm3776905wma.19.2021.07.15.02.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 02:55:45 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/2] tools/bpf/bpftool: xlated dump from ELF file
 directly
To:     Lorenzo Fontana <fontanalorenz@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        John Fastabend <john.fastabend@gmail.com>,
        "liwei (GF)" <liwei391@huawei.com>
References: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
 <f01efeef-9653-0f5f-b76e-d37597ba08d5@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <0f28c24b-0d82-da71-0fe0-8c92cd6f306d@isovalent.com>
Date:   Thu, 15 Jul 2021 10:55:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f01efeef-9653-0f5f-b76e-d37597ba08d5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-07-13 20:35 UTC+0200 ~ Lorenzo Fontana <fontanalorenz@gmail.com>
> bpftool can dump an xlated or jitted representation
> of the programs already loaded into the kernel.
> That capability is very useful for understanding what
> are the instructions the kernel will execute for that program.
> 
> However, sometimes the verifier does not load the program and
> one cannot use this feature until changes are made to make the
> verifier happy again.
> 
> This patch reuses the same dump function to dump the program
> from an ELF file directly instead of loading the instructions
> from a loaded file descriptor. In this way, the user
> can use all the bpftool features for "xlated" without loading.
> 
> In particular, the "visual" command is very useful when combined
> to this because the dot graph makes easy to spot bad instruction
> sequences.
> 
> Usage:
> 
>   bpftool prog dump xlated elf program.o

Hi Lorenzo,

"elf" is not a bad keyword, but seeing that we use "file" for dumping
BTF from ELF object files with "bpftool btf dump file foo.o", I'd rather
have the same keyword here, for consistency.

> 
> It also works with the other commands like 'visual' to print
> an dot representation of the program.
> 
>   bpftool prog dump xlated elf program.o visual
> 
> Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
> ---
>  tools/bpf/bpftool/common.c | 15 ++++++++++++---
>  tools/bpf/bpftool/main.h   |  2 +-
>  tools/bpf/bpftool/prog.c   | 26 +++++++++++++++++++++++---
>  3 files changed, 36 insertions(+), 7 deletions(-)
> 

> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index c1cf29798b99..f4e426d03b4a 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h

> @@ -787,7 +787,10 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>  static int do_dump(int argc, char **argv)
>  {
>  	struct bpf_prog_info_linear *info_linear;
> +	struct bpf_object *obj;
> +	struct bpf_program *prog;
>  	char *filepath = NULL;
> +	char *elf_filepath = NULL;
>  	bool opcodes = false;
>  	bool visual = false;
>  	enum dump_mode mode;

Nit: Could you preserve the reverse-Christmas-tree order for the
declarations?

> @@ -817,7 +820,8 @@ static int do_dump(int argc, char **argv)
>  		p_err("mem alloc failed");
>  		return -1;
>  	}
> -	nb_fds = prog_parse_fds(&argc, &argv, &fds);
> +	elf_filepath = malloc(sizeof(char) * PATH_MAX);
> +	nb_fds = prog_parse_fds(&argc, &argv, &fds, &elf_filepath);
>  	if (nb_fds < 1)
>  		goto exit_free;
>  
> @@ -849,7 +853,6 @@ static int do_dump(int argc, char **argv)
>  		linum = true;
>  		NEXT_ARG();
>  	}
> -
>  	if (argc) {
>  		usage();
>  		goto exit_close;
> @@ -866,9 +869,26 @@ static int do_dump(int argc, char **argv)
>  	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
>  	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
>  
> +	if (elf_filepath != NULL) {

It would normally be just "if (elf_filepath) {". Checkpatch complains
about it, by the way.

But you don't want to enter here just if elf_filepath is non-NULL,
because you always malloc it (whether the "elf" keyword was passed or
not), so your pointer is always non-NULL if there's no allocation error.
This means that you always enter the block, and it breaks the command
for dumping instructions for loaded programs. You need another check.

Also before this block, we may also want to error out with a better
message error if the user attempts to dump "jited" instructions from an
ELF file? Right now bpftool simply answers "no instructions returned",
which is not very indicative of why it fails.

And since the block does not use the "arrays" variable necessary for
bpf_program__get_prog_info_linear(), it could be moved a bit higher,
right after the argument parsing.

> +		obj = bpf_object__open(elf_filepath); 
> +		if (libbpf_get_error(obj)) {
> +			p_err("ERROR: opening BPF object file failed");
> +			return 0;
> +		}
> +
> +		bpf_object__for_each_program(prog, obj) {
> +			struct bpf_prog_info pinfo;

Checkpatch complains about a missing blank line here after the
declaration, and about a few other things, please make sure to address it.

In addition to the documentation (.../Documentation/bpftool-prog.rst)
and the help message (although we don't want to change HELP_SPEC_PROGRAM
directly, as it is used in many context where the new handle does not
apply) as reported by John and Wei, can you please update the bash
completion (.../bash-completion/bpftool)?

The patch is a nice addition to bpftool, thanks for this work!
Quentin
