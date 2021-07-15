Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B223C9883
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 07:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhGOFvH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 01:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhGOFvH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 01:51:07 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA9C06175F
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 22:48:14 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id p3so3945104ilg.8
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 22:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=1UNXUI+Q7y1tyrLCSBlunULpSMXhIXPZez85QUiGCB0=;
        b=nVDq+nrEb1WKv0+4sUJzRSC7+YSdMco02HtC2WDnHLq3/rkZYYvMCR3TuEvyithrc3
         w6jB032JFAPIvs/cOc6eThHtL6sVWlHaxDDUxQnYGhHb5APkvh+L1HpvxEs9wo+2+0lv
         cCZYsInk+s4oKPDuzSzVNv92zCVnOvw5tAzNQLZKJvPKVwn4nGegNMbCG6NPcnMpbN2y
         414zkeMbuQsN/X4PJZzMaqYq44muU5He9szK7Uwfaw91IqX+rC15ODu7ZCYVF8Gls2kG
         qMwOZ4RzVYO5UfLhTJrYUgaDGcw/8GZ7vh/JivSilIRug8E6hFvGqkmOSnspHxUXdyLz
         FmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=1UNXUI+Q7y1tyrLCSBlunULpSMXhIXPZez85QUiGCB0=;
        b=ljWfouH4A2pWxCnZf4z24tKdXcYiNfKIlPuMejOYJo6JwvwG6k11bVrQLV+AB/hjMl
         sA/vUKCew+LWxguBd29SUQ8B8YaDA2nWh1BA0ushqPyc0lNRalItYmN/oYEXiFgBwARr
         l4Xp6BtyqxX7sLOzWk9m86aO2ZPbwp1HG/FFupceX0dcvS+xfusygtaKF2Ws9m8W5KGe
         dT0AZCcP9vCmWJ6MXp+TOArb5KQ+JjLriVamISgFWXKFyGE1X8hRPm3UWn8D+tpYhk0q
         AYK2EmWNNzFCDcw6HqW2+1bfA7KvjXOiT2nb3p58FC8KIVtMzQLf4sHSx4ygChP1XV2q
         0aAw==
X-Gm-Message-State: AOAM532Cj9vQz4pBM0ShkSTWFEzXN1AU8iNH1ajPp4ESEmse30pgtF9k
        N9r2AdulddvpmVkzITIy+rU=
X-Google-Smtp-Source: ABdhPJzlPO2/6J/Ebw9lCgk78h4x9tr/nQ9xj5OGf6V3fjBeYt/J1+FGoe4L6EPUHgLRp1qrtmQIiw==
X-Received: by 2002:a92:660f:: with SMTP id a15mr1566124ilc.182.1626328093394;
        Wed, 14 Jul 2021 22:48:13 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id r24sm1682010ioa.31.2021.07.14.22.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 22:48:12 -0700 (PDT)
Date:   Wed, 14 Jul 2021 22:48:05 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Lorenzo Fontana <fontanalorenz@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net
Message-ID: <60efcc15271a6_5a0c1208bc@john-XPS-13-9370.notmuch>
In-Reply-To: <f01efeef-9653-0f5f-b76e-d37597ba08d5@gmail.com>
References: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
 <f01efeef-9653-0f5f-b76e-d37597ba08d5@gmail.com>
Subject: RE: [PATCH bpf-next 2/2] tools/bpf/bpftool: xlated dump from ELF file
 directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Fontana wrote:
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
> 
> It also works with the other commands like 'visual' to print
> an dot representation of the program.
> 
>   bpftool prog dump xlated elf program.o visual
> 
> Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>

Seeing we need another spin anyways can we get documentation
updates as well in ./tools/bpf/bpftool/Documentation.

> ---
>  tools/bpf/bpftool/common.c | 15 ++++++++++++---
>  tools/bpf/bpftool/main.h   |  2 +-
>  tools/bpf/bpftool/prog.c   | 26 +++++++++++++++++++++++---
>  3 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 1828bba19020..b28d15505705 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -703,7 +703,7 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
>  	return -1;
>  }
>  
> -int prog_parse_fds(int *argc, char ***argv, int **fds)
> +int prog_parse_fds(int *argc, char ***argv, int **fds, char **elf_filepath)
>  {
>  	if (is_prefix(**argv, "id")) {
>  		unsigned int id;
> @@ -763,9 +763,18 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
>  		if ((*fds)[0] < 0)
>  			return -1;
>  		return 1;
> +	} else if (is_prefix(**argv, "elf")) {
> +		NEXT_ARGP();
> +		if (!argc) {
> +			p_err("expected ELF file path");
> +			return -1;
> +		}
> +		*elf_filepath = **argv;
> +		NEXT_ARGP();
> +		return 1;
>  	}
>  
> -	p_err("expected 'id', 'tag', 'name' or 'pinned', got: '%s'?", **argv);
> +	p_err("expected 'id', 'tag', 'name', 'elf' or 'pinned', got: '%s'?", **argv);
>  	return -1;
>  }
>  
> @@ -779,7 +788,7 @@ int prog_parse_fd(int *argc, char ***argv)
>  		p_err("mem alloc failed");
>  		return -1;
>  	}
> -	nb_fds = prog_parse_fds(argc, argv, &fds);
> +	nb_fds = prog_parse_fds(argc, argv, &fds, NULL);
>  	if (nb_fds != 1) {
>  		if (nb_fds > 1) {
>  			p_err("several programs match this handle");
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index c1cf29798b99..f4e426d03b4a 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -187,7 +187,7 @@ int do_iter(int argc, char **argv) __weak;
>  
>  int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what);
>  int prog_parse_fd(int *argc, char ***argv);
> -int prog_parse_fds(int *argc, char ***argv, int **fds);
> +int prog_parse_fds(int *argc, char ***argv, int **fds, char **elf_filepath);
>  int map_parse_fd(int *argc, char ***argv);
>  int map_parse_fds(int *argc, char ***argv, int **fds);
>  int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len);
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index cc48726740ad..04fa9a83ef7e 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -537,7 +537,7 @@ static int do_show_subset(int argc, char **argv)
>  		p_err("mem alloc failed");
>  		return -1;
>  	}
> -	nb_fds = prog_parse_fds(&argc, &argv, &fds);
> +	nb_fds = prog_parse_fds(&argc, &argv, &fds, NULL);
>  	if (nb_fds < 1)
>  		goto exit_free;
>  
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

nit...

No reason to delete the line here IMO. Just adds noise to the
patch.

>  	if (argc) {
>  		usage();
>  		goto exit_close;
> @@ -866,9 +869,26 @@ static int do_dump(int argc, char **argv)
>  	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
>  	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
>  
> +	if (elf_filepath != NULL) {
> +		obj = bpf_object__open(elf_filepath); 
> +		if (libbpf_get_error(obj)) {
> +			p_err("ERROR: opening BPF object file failed");
> +			return 0;
> +		}
> +
> +		bpf_object__for_each_program(prog, obj) {
> +			struct bpf_prog_info pinfo;
> +			pinfo.xlated_prog_insns = ptr_to_u64(bpf_program__insns(prog));
> +			pinfo.xlated_prog_len = bpf_program__size(prog);
> +			err = prog_dump(&pinfo, mode, filepath, opcodes, visual, linum);
> +		}
> +		return 0;

goto exit_close?

> +	}
> +
>  	if (json_output && nb_fds > 1)
>  		jsonw_start_array(json_wtr);	/* root array */
>  	for (i = 0; i < nb_fds; i++) {
> +		printf("uno\n");

As noted, remove.

>  		info_linear = bpf_program__get_prog_info_linear(fds[i], arrays);
>  		if (IS_ERR_OR_NULL(info_linear)) {
>  			p_err("can't get prog info: %s", strerror(errno));
> -- 
> 2.32.0
> 


