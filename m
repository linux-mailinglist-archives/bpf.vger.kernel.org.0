Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FB55872B3
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 23:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiHAVBw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 17:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiHAVBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 17:01:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A07A37FA4
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 14:01:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id rq15so16529175ejc.10
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=QyFqdazfQtWhTT1MY/OhnkM7cq92DrWEaRny9I5/9ic=;
        b=W8YdX0pA0KIEJwah+orRmsyDMCfyF1JDMXSK6JCsqkYLgGoWqE9dYxK4FKgvThRSvx
         HManAYt1B67iIg6O6zEav1FLoKUlhbkGskk7mizbJalFPUmCtcEAt5F0SVlbbvEheDGs
         UFvwpWLhUZzeMHCJ1LS4pfx3FPRe6/52BOd//CgAPNeagYJcnuGDxDe7qi5I6WgpAerE
         Zf+560Ms5i1QdJncjRzj+ORk9zco9Qd6gVtgWK51bomDqjt3aKHui55fHHZOO6zENdkb
         ZWjWWvLmKrDtrnMl7FEQMuwm8hoc8Xa2qBWnGN/qp8ToA/zFavT/Rxavr4aGEihlL+Tb
         cgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=QyFqdazfQtWhTT1MY/OhnkM7cq92DrWEaRny9I5/9ic=;
        b=A8hu1P4sv/nAhg14OD6QU6OKmOd2o0vgO8mC6YVQ++J/3WpkPZZh+e1c5bIMESzFYz
         lN8iivQO/bk5BXR2xZkjRRtosumAx3dwg45lRCC5AvPVDKKA2kyCZBo+GMSzvDBry/dK
         YoDBFEMjSHwY1yhYYes75zCJQ2So+ZZAQ/jLTjqisTD9J3CxIUPjNx/T8dXUGvpwUAfJ
         s/QpjZc55LXEulx2heQANsQ6yu5ag25cptIj2PPGyvg6QzN3adcEVz9+qJzc+iCDofmg
         zGVihBmV/xBnyqlrYGF2xBwZr+cwN7yHovMYotbSxJ2eJj1gFtgrbHEnUq8c7zj7jG5R
         IH/A==
X-Gm-Message-State: ACgBeo0ob3ybQ6p7FG60NhmecdkpPWmJSQ+pR+fqxc33Rt0VwBXaVGwB
        kNv45plFqdN22jufdxt7a8aMyrqd0TDxmg==
X-Google-Smtp-Source: AA6agR7NBmilwFHVDlzeSt8OUPFJ5099MvNXGDgj2ugeqaNZqlP0px7dkRb9/rYYbk7hM57b/BP/UQ==
X-Received: by 2002:a17:906:98c8:b0:730:7ada:87a7 with SMTP id zd8-20020a17090698c800b007307ada87a7mr6056779ejb.748.1659387705770;
        Mon, 01 Aug 2022 14:01:45 -0700 (PDT)
Received: from krava ([83.240.62.89])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906c08500b0072b36cbcdaasm5561564ejz.92.2022.08.01.14.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:01:45 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 1 Aug 2022 23:01:43 +0200
To:     Manu Bretelle <chantr4@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, quentin@isovalent.com
Subject: Re: [PATCH bpf-next v3] bpftool: Remove BPF_OBJ_NAME_LEN restriction
 when looking up bpf program by name
Message-ID: <Yug/N2TMIQQGWU8Q@krava>
References: <20220801132409.4147849-1-chantr4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801132409.4147849-1-chantr4@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 01, 2022 at 06:24:09AM -0700, Manu Bretelle wrote:
> bpftool was limiting the length of names to BPF_OBJ_NAME_LEN in prog_parse
> fds.
> 
> Since commit b662000aff84 ("bpftool: Adding support for BTF program names")
> we can get the full program name from BTF.
> 
> This patch removes the restriction of name length when running `bpftool
> prog show name ${name}`.
> 
> Test:
> Tested against some internal program names that were longer than
> `BPF_OBJ_NAME_LEN`, here a redacted example of what was ran to test.
> 
>     # previous behaviour
>     $ sudo bpftool prog show name some_long_program_name
>     Error: can't parse name
>     # with the patch
>     $ sudo ./bpftool prog show name some_long_program_name
>     123456789: tracing  name some_long_program_name  tag taghexa  gpl ....
>     ...
>     ...
>     ...
>     # too long
>     sudo ./bpftool prog show name $(python3 -c 'print("A"*128)')
>     Error: can't parse name
>     # not too long but no match
>     $ sudo ./bpftool prog show name $(python3 -c 'print("A"*127)')
> 
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> 
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>

tested on tetragon programs ;-)

Tested-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> ---
> 
> v1 -> v2:
> * Fix commit message to follow patch submission guidelines
> * use strncmp instead of strcmp
> * reintroduce arg length check against MAX_PROG_FULL_NAME
> 
> v2 -> v3:
> * Fix alignment with opening parenthesis
> ---
>  tools/bpf/bpftool/common.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 067e9ea59e3b..8727765add88 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -722,6 +722,7 @@ print_all_levels(__maybe_unused enum libbpf_print_level level,
>  
>  static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
>  {
> +	char prog_name[MAX_PROG_FULL_NAME];
>  	unsigned int id = 0;
>  	int fd, nb_fds = 0;
>  	void *tmp;
> @@ -754,12 +755,20 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
>  			goto err_close_fd;
>  		}
>  
> -		if ((tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) ||
> -		    (!tag && strncmp(nametag, info.name, BPF_OBJ_NAME_LEN))) {
> +		if (tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) {
>  			close(fd);
>  			continue;
>  		}
>  
> +		if (!tag) {
> +			get_prog_full_name(&info, fd, prog_name,
> +					   sizeof(prog_name));
> +			if (strncmp(nametag, prog_name, sizeof(prog_name))) {
> +				close(fd);
> +				continue;
> +			}
> +		}
> +
>  		if (nb_fds > 0) {
>  			tmp = realloc(*fds, (nb_fds + 1) * sizeof(int));
>  			if (!tmp) {
> @@ -820,7 +829,7 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
>  		NEXT_ARGP();
>  
>  		name = **argv;
> -		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
> +		if (strlen(name) > MAX_PROG_FULL_NAME - 1) {
>  			p_err("can't parse name");
>  			return -1;
>  		}
> -- 
> 2.30.2
> 
