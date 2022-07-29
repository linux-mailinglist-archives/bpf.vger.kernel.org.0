Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2A6584E67
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 11:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiG2Jx1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 05:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiG2Jx0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 05:53:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61B778599
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 02:53:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h8so5375934wrw.1
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 02:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=saHqvH6UxsXxbz+utuFRkPa13DplD968SNaEfToEYN8=;
        b=5VnuaImcnq7kSXMdm15QgVP8DXNqS9kawBfrN8uyPZz0+K2djqFNKCMCGlI5UqxAIl
         WXqDgB37VCulnXedikcp2Q2MY3vzLHLtKpwyPSmukB5cZiK083hYksViAujs2u3FaqjE
         s4ybn40di1Q7EtmA7SoHV4KgI/TtXCViPHEOsGV+Hz+JhYkA/0qjg75X6/Z2PbZtqQEC
         4+uKgg/8tmXwJkaiIAA4oWbMWK4MC5VWzOBW8XwJwCzBlV6YeRnavh7jTO701lnLS1Tk
         fRKRR86n96Yyx3M27tuZg5B/KdtLaQW5D+81735vqw/V7GcSJkkKk0bj1wrER+zAhnsh
         6uOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=saHqvH6UxsXxbz+utuFRkPa13DplD968SNaEfToEYN8=;
        b=yu3B4V0qZnIqr2RNPuF1+6qwwTTlZcT0mFSQ6MEEIAFY6N/h+4aQ5s1GSntkhHK7v5
         SMMaMkEt6JsRi5pgDXAxa5uvm0d7SoAfP5pwy4POkUapQdiP9bcEzoCEaQrJFYv1EyOA
         4qxq1AyfBMWXElTChNjmoBZPSBWoB9FMopoeUXvtOwgD15VSSgwZ8Ob4/lJ1cVgHoAtm
         E7cMp/W5xv29Ire3vUl9cYI9VpqNfzleNyPAtqmnxKmgArWcDq+UOJ8Dr/Dy/aPmuEBG
         1F1tkECUV8L0WuHjh9jjgvEPzs42RhJqhvp9NRHKglFH0yVLWZZNY3ZAuz9MYU8I8R/w
         iOnQ==
X-Gm-Message-State: ACgBeo3ZlpN+0csnDCK1ljU/QzcIfTmMQL0beTNJmVQNFePLccbtt13V
        XnJJ+ikI33tuoNIEZFUgxW55Pvngy4RTE2B9
X-Google-Smtp-Source: AA6agR6SkuZR/iJj9y7DgQ5Uov5o1Pw7J+AfSw5DFJQpgECTC2nuBfILZPBS6tcr7rNMnq1BoSc1Gg==
X-Received: by 2002:a05:6000:178a:b0:21d:beeb:7878 with SMTP id e10-20020a056000178a00b0021dbeeb7878mr1783383wrg.708.1659088404195;
        Fri, 29 Jul 2022 02:53:24 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id m23-20020a05600c3b1700b003a30fbde91dsm8944975wms.20.2022.07.29.02.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jul 2022 02:53:23 -0700 (PDT)
Message-ID: <675f99fb-7ec4-71eb-130c-a47936feadc4@isovalent.com>
Date:   Fri, 29 Jul 2022 10:53:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH bpf-next] remove BPF_OBJ_NAME_LEN restriction when looking
 up bpf program by name
Content-Language: en-GB
To:     Manu Bretelle <chantr4@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org
References: <20220729061817.126062-1-chantr4@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220729061817.126062-1-chantr4@gmail.com>
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

On 29/07/2022 07:18, Manu Bretelle wrote:
> From: chantra <chantr4@gmail.com>
> 
> bpftool was limiting the length of names to
> [BPF_OBJ_NAME_LEN](https://github.com/libbpf/bpftool/blob/2d7bba1e8c17dd0422879c856cda66723b209952/src/common.c#L823-L826).
> 
> Since
> https://github.com/libbpf/bpftool/commit/61833a284f48b90f6802c141c8356de64bb41e10
> we can get the full program name from BTF.
> 
> This diffs remove the restriction of name length when running `bpftool

-> "This patch removes"?

> prog show name ${name}`.
> 
> Test:
> Tested against some internal program names that were longer than
> `BPF_OBJ_NAME_LEN`, here a redacted example of what was ran to test.
> 
> ```
> $ sudo bpftool prog show name some_long_program_name
> Error: can't parse name
> $ sudo ./bpftool prog show name some_long_program_name
> 123456789: tracing  name some_long_program_name  tag taghexa  gpl ....
> ...
> ...
> ...
> ```

Thanks a lot for the patch! The suggested change looks good, but the
code and the patch themselves need some adjustments.

Regarding your commit object (and email subject): Please prefix with the
component that you update. For your next version, this should be:

    [PATCH bpf-next v2] bpftool: Remove BPF_OBJ_NAME_LEN...

For the commit description, please avoid external links (GitHub). Prefer
function names (we can grep for them) or commit references [0]. I would
also recommend against too much Markdown mark-up, the triple quotes
could be removed and the snippet indented instead.

Your commit is also missing your Signed-off-by tag in its description,
you will need to add it [1].

[0]
https://www.kernel.org/doc/html/latest/process/submitting-patches.html?highlight=signed+off#describe-your-changes
[1]
https://www.kernel.org/doc/html/latest/process/submitting-patches.html?highlight=signed+off#sign-your-work-the-developer-s-certificate-of-origin

> ---
>  tools/bpf/bpftool/common.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 067e9ea59e3b..bc9017877296 100644
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
> @@ -754,12 +755,21 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
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
> +
> +

Too many blank lines, please use just one.

> +		if (!tag) {
> +			get_prog_full_name(&info, fd, prog_name, sizeof(prog_name));
> +			if (strcmp(nametag, prog_name)) {

strncmp(), please

> +				close(fd);
> +				continue;
> +			}
> +		}
> +
>  		if (nb_fds > 0) {
>  			tmp = realloc(*fds, (nb_fds + 1) * sizeof(int));
>  			if (!tmp) {
> @@ -820,10 +830,6 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
>  		NEXT_ARGP();
>  
>  		name = **argv;
> -		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
> -			p_err("can't parse name");
> -			return -1;
> -		}

Why removing the check? Just update the bound to MAX_PROG_FULL_NAME - 1?

>  		NEXT_ARGP();
>  
>  		return prog_fd_by_nametag(name, fds, false);

