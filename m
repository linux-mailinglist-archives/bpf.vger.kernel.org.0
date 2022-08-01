Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21D5586AFA
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiHAMj5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 08:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbiHAMjn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 08:39:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B66AA0BA1
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 05:18:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so5519672wmo.0
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 05:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=j6/wwDIbtRb486R26+o4gLdYN6HcHSLyf3aWGdnneHo=;
        b=0+RU5zpMvZB4/WYQ2yAaEslOqurFzPXHaO4y0KJ3VWLFNt+EVsWVKHhXoffldM9ZqN
         CxlMC1bJ1cIy/M9FhWWBAlNANqYWaT9jfgTtgAhWCyyNpBTKOChgFFP2p+qlavutFnSy
         tO7keIxXp7A8AvPsZjoEudfwKqWnF0ngUy34AiedfzLzN/aovsPxBuzxsjXzFj8uORr1
         +pOdNCKJqLV98n1Hw14vubkAQh4Q7MWXtCVWdY6O+ONg0yFoJyBtDngxa8qF79IsZAMm
         H0D063bxFOJNCaQWNz6AEA+57X+QKt07OlLmNxAR17Ykgy7BEozl1jEcqNUT5qfQyPUZ
         NFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=j6/wwDIbtRb486R26+o4gLdYN6HcHSLyf3aWGdnneHo=;
        b=izP2Gqh0uGNG4xtbUg4J3FvnIjKAJeStgTgmP/x/ZwI5VkNWvS5ro2FEOXD/FtA1Ka
         pFyc97dlh18mld8Vh3lk8jBKt6n8KOEV9T0YabLn/5JANQInAod3fqxN5nQV5N0LoJ4E
         1xUKFVteadG29DM/JZ54UKmMKfCsEgr5gb7AW6LHP5vhUlW8j8npBWvSSt0tDbxrRQHg
         CngZk1VuvIjRLBGAckSI40hH0DHeytdhwv1lEZvcbR9ARjb2vaajDvatxfDy6BA/Vjxe
         7W4dcshOscFqgjZpvKSbzVm4Wc6KbPofPvpezlhrg2+HzOnfIrSq7B/mRpeTXUlQlXNu
         ctSg==
X-Gm-Message-State: AJIora/ICjA19wh/+RZkLrF48hDIWLBbUGs8vezAjwgq8dDpUJ4OxFb5
        af/3OjkvJ80AGy9mUktoZ9Ho9w==
X-Google-Smtp-Source: AGRyM1vX7FfQErUNhwVL12LTTvxMfehNWOBSjkyzR/CV+U+KWiX5Bp1pdSEMF4lauerKrxs5ce1OKA==
X-Received: by 2002:a7b:c5d2:0:b0:3a3:55d9:fd36 with SMTP id n18-20020a7bc5d2000000b003a355d9fd36mr11324771wmk.52.1659356308828;
        Mon, 01 Aug 2022 05:18:28 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h23-20020a05600c145700b003a35ec4bf4fsm14874573wmi.20.2022.08.01.05.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 05:18:28 -0700 (PDT)
Message-ID: <98f6a795-50dc-e6d2-87ee-8fafc7e1ee7b@isovalent.com>
Date:   Mon, 1 Aug 2022 13:18:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH bpf-next v2] bpftool: Remove BPF_OBJ_NAME_LEN restriction
 when looking up bpf program by name
Content-Language: en-GB
To:     Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org
References: <20220731181007.3130320-1-chantr4@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220731181007.3130320-1-chantr4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 31/07/2022 19:10, Manu Bretelle wrote:
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
> ---
> 
> v1 -> v2:
> * Fix commit message to follow patch submission guidelines
> * use strncmp instead of strcmp
> * reintroduce arg length check against MAX_PROG_FULL_NAME
> 
> 
>  tools/bpf/bpftool/common.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 067e9ea59e3b..3ea747b3b194 100644
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
> +				sizeof(prog_name));

Nit: This line should be aligned with the opening parenthesis from the
line above, checkpatch.pl complains about it. Probably not worth sending
a new version just for that, though.

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

Looks good, thank you!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
