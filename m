Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EFB3C9A33
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 10:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhGOINI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 04:13:08 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:11279 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhGOINI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 04:13:08 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GQRjZ12X6z1CGsb;
        Thu, 15 Jul 2021 16:04:34 +0800 (CST)
Received: from [10.174.179.211] (10.174.179.211) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 15 Jul 2021 16:10:12 +0800
Subject: Re: [PATCH bpf-next 2/2] tools/bpf/bpftool: xlated dump from ELF file
 directly
To:     Lorenzo Fontana <fontanalorenz@gmail.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>
References: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
 <f01efeef-9653-0f5f-b76e-d37597ba08d5@gmail.com>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <16fde9ff-c8d9-78fd-d71b-26f56ce364ef@huawei.com>
Date:   Thu, 15 Jul 2021 16:10:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f01efeef-9653-0f5f-b76e-d37597ba08d5@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.211]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/7/14 2:35, Lorenzo Fontana wrote:
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

Should we update the 'HELP_SPEC_PROGRAM' info as well?

Thanks,
Wei

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
> +	}
> +
>  	if (json_output && nb_fds > 1)
>  		jsonw_start_array(json_wtr);	/* root array */
>  	for (i = 0; i < nb_fds; i++) {
> +		printf("uno\n");
>  		info_linear = bpf_program__get_prog_info_linear(fds[i], arrays);
>  		if (IS_ERR_OR_NULL(info_linear)) {
>  			p_err("can't get prog info: %s", strerror(errno));
> 
