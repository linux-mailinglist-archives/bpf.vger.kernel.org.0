Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB136C574
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 13:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhD0Lna (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 07:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42652 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230365AbhD0Ln3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 27 Apr 2021 07:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619523766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oeOhd2V0c8rbmIphqlCMgVn2dflRjRSSpyq6Odht468=;
        b=coy1Pr1SBsw93xbikoY3Ahiy64jGOpydwG+DKdCVPf0lY7fqwMiPQPJbW4Fzf+RsvLjEMH
        PkCzN2fCsep3dWG7vLuGW7jZVd0OqWb039Ihio2qPr6+mXApXVOyOzGrzv8wUQF2VsvcYS
        z/34bAeDyrRZ8Xwcq+1b3p6NOND0tW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-qsUTR00TOz2AabF-IAOJhw-1; Tue, 27 Apr 2021 07:42:44 -0400
X-MC-Unique: qsUTR00TOz2AabF-IAOJhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCDA9107ACF6;
        Tue, 27 Apr 2021 11:42:42 +0000 (UTC)
Received: from krava (unknown [10.40.192.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id 67BED19704;
        Tue, 27 Apr 2021 11:42:41 +0000 (UTC)
Date:   Tue, 27 Apr 2021 13:42:40 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids
 section
Message-ID: <YIf4sF2H/xkex2Q1@krava>
References: <20210423213728.3538141-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423213728.3538141-1-kafai@fb.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 23, 2021 at 02:37:28PM -0700, Martin KaFai Lau wrote:

SNIP

> +static int collect_listed_functions(struct btf_elf *btfe, GElf_Sym *sym,
> +				    size_t sym_sec_idx)
> +{
> +	int len, digits = 0, underscores = 0;
> +	const char *name;
> +	char *func_name;
> +
> +	if (!btfe->btf_ids_shndx ||
> +	    btfe->btf_ids_shndx != sym_sec_idx)
> +		return 0;
> +
> +	/* The kernel function in the btf id list will have symbol like:
> +	 * __BTF_ID__func__<kernel_func_name>__[digit]+
> +	 */
> +	name = elf_sym__name(sym, btfe->symtab);
> +	if (strncmp(name, BTF_ID_FUNC_PREFIX, BTF_ID_FUNC_PREFIX_LEN))
> +		return 0;
> +
> +	name += BTF_ID_FUNC_PREFIX_LEN;
> +
> +	/* name: <kernel_func_name>__[digit]+
> +	 * Strip the ending __[digit]+
> +	 */
> +	for (len = strlen(name); len && underscores != 2; len--) {
> +		char c = name[len - 1];
> +
> +		if (c == '_') {
> +			if (!digits)
> +				return 0;
> +			underscores++;
> +		} else if (isdigit(c)) {
> +			if (underscores)
> +				return 0;
> +			digits++;
> +		} else {
> +			return 0;
> +		}
> +	}
> +
> +	if (!len)
> +		return 0;
> +
> +	func_name = strndup(name, len);
> +	if (!func_name) {
> +		fprintf(stderr,
> +			"Failed to alloc memory for listed function %s%s\n",
> +			BTF_ID_FUNC_PREFIX, name);
> +		return -1;
> +	}
> +
> +	if (is_listed_func(func_name)) {
> +		/* already captured */
> +		free(func_name);
> +		return 0;
> +	}
> +
> +	/* grow listed_functions */
> +	if (listed_functions_cnt == listed_functions_alloc) {
> +		char **new;
> +
> +		listed_functions_alloc = max(100,
> +					     listed_functions_alloc * 3 / 2);
> +		new = realloc(listed_functions,
> +			      listed_functions_alloc * sizeof(*listed_functions));
> +		if (!new) {
> +			fprintf(stderr,
> +				"Failed to alloc memory for listed function %s%s\n",
> +				BTF_ID_FUNC_PREFIX, name);
> +			free(func_name);
> +			return -1;
> +		}
> +		listed_functions = new;
> +	}
> +
> +	listed_functions[listed_functions_cnt++] = func_name;
> +	qsort(listed_functions, listed_functions_cnt,
> +	      sizeof(*listed_functions), listed_function_cmp);

I was thinking of doing this at the end in setup_functions,
but we need to do name lookups before adding.. also there are
not too many BTF_ID instances anyway

I'll run the test script with your change

jirka

