Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9081A5713AC
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 09:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiGLH6a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 03:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiGLH63 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 03:58:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F199D510
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 00:58:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b11so12847583eju.10
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 00:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BKk/xNQMqMywpV5u4L2mimeijZJhv7CWnVQ4wfY5dvE=;
        b=as3aTNCXm4kY0bYv4Ns/BvBI6XNgg8dGu+bDss5KWTGqBW5MqwJWbDjQg6rf/m6nwf
         j0ao0jXoVKjmR6yOKGBJaM1wBqObLKwKZGixYVMWzFdtG03D2C/1VDn5S9CJbdT9SJU4
         ksqx2TD8JvHQXNx4oAIteUAOq0yjOXNDo+qVs46LSauw2KoWOZv5dFAJIB0w07uvjIb+
         M3DsIKX/MhtLoPG1Be7aETV0qrNqxupelO8/bPvLFEriqQcIRnoVhcHi7w5fjcROhI1r
         WQ0Wlee1R/XFE2HEI2dXPPm+0h/Ky1o5ThJhDIWh4zYnGWF9OlBkTlNL8xsUJP3UC4pQ
         I7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BKk/xNQMqMywpV5u4L2mimeijZJhv7CWnVQ4wfY5dvE=;
        b=3G4DIpat0KQlTksj4PTBMJHyC7NjEwDeHhCX0XYIK+PedE//+trMnvVxbo6XKw/PmV
         gFk8rnpK4IJxahuyRg4+ghcxKKk7C6g6zeVkQUqgdW2qtAeiFXhPsWGufeGQ2KCz6AmB
         vJnWHLCNWDeHB6pF8WfPhuYSv+fUyq92VZnjmvd7N+HY1oAre63ptAuiDKEhU4Td58ro
         PQYenYaIRH6beSkiwZMqMXMahMppjl2stzpuMcQMND10B/2lZrAxSIJEfBXYXcYyzNoa
         1KN1LBV4N+TyniKoF3qjcm8irWeeROIvcBezPk+EXjCxq2AzrjmLNoCHtE01Wzor9Mlp
         E4Vw==
X-Gm-Message-State: AJIora+jiqYJrDETXYkhNeZC878PYdokAWM9EEAXwzO/rFYERo8XesVI
        GkoZaRZaSCGDsBnwSZ2VBwk=
X-Google-Smtp-Source: AGRyM1ub21ZKpgR07cOOyXgW8qACHh5PjsfgwjMkq+jR+t2YXkk5ME/8b+8weHXSuYHPYU/zAE3ekw==
X-Received: by 2002:a17:906:6a14:b0:72b:64bd:ea2b with SMTP id qw20-20020a1709066a1400b0072b64bdea2bmr6404960ejc.680.1657612707127;
        Tue, 12 Jul 2022 00:58:27 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id fy6-20020a170906b7c600b0072aed3b2158sm3538751ejb.45.2022.07.12.00.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 00:58:26 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 12 Jul 2022 09:58:24 +0200
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next] libbpf: Error out when binary_path is NULL for
 uprobe and USDT
Message-ID: <Ys0poNMCnkNUQ1VE@krava>
References: <20220712025745.2703995-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712025745.2703995-1-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 10:57:45AM +0800, Hengqi Chen wrote:
> binary_path is a required non-null parameter for bpf_program__attach_usdt
> and bpf_program__attach_uprobe_opts. Check it against NULL to prevent
> coredump on strchr.

binary_path seems to be mandatory so LGTM, cc-ing Alan to be sure ;-)

thanks,
jirka

> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cb49408eb298..72548798126b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10545,7 +10545,10 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>  	ref_ctr_off = OPTS_GET(opts, ref_ctr_offset, 0);
>  	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> 
> -	if (binary_path && !strchr(binary_path, '/')) {
> +	if (!binary_path)
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	if (!strchr(binary_path, '/')) {
>  		err = resolve_full_path(binary_path, full_binary_path,
>  					sizeof(full_binary_path));
>  		if (err) {
> @@ -10559,11 +10562,6 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>  	if (func_name) {
>  		long sym_off;
> 
> -		if (!binary_path) {
> -			pr_warn("prog '%s': name-based attach requires binary_path\n",
> -				prog->name);
> -			return libbpf_err_ptr(-EINVAL);
> -		}
>  		sym_off = elf_find_func_offset(binary_path, func_name);
>  		if (sym_off < 0)
>  			return libbpf_err_ptr(sym_off);
> @@ -10711,6 +10709,9 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
>  		return libbpf_err_ptr(-EINVAL);
>  	}
> 
> +	if (!binary_path)
> +		return libbpf_err_ptr(-EINVAL);
> +
>  	if (!strchr(binary_path, '/')) {
>  		err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
>  		if (err) {
> --
> 2.30.2
