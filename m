Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFB42F40A9
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 01:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392141AbhAMAnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 19:43:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392381AbhAMA3e (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 19:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610497686;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3VmgZNeIieIH5iBg/fieZI6KHe20vOSZ8T5rOn9mcw=;
        b=Di5b1MkUdW0nMDDqtGPKypqc9G5rqLS01DfjvL4s2Ml3yVmnRnuRN1HhVD0HSS1rliUkZd
        9AbgMZSnExt/0KhhKJ0QQmywEwUBQSozmZykEQhc2NU4PHikbs7qxwlV2bKmyY1V+WWj9f
        hbBXcx7dHTQeeZ7RtQ5VaMJoTm8kdfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-1w-cURqKOIi5ydZ0r9rIzQ-1; Tue, 12 Jan 2021 19:28:02 -0500
X-MC-Unique: 1w-cURqKOIi5ydZ0r9rIzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECE2F8735D3;
        Wed, 13 Jan 2021 00:28:00 +0000 (UTC)
Received: from tstellar.remote.csb (ovpn-112-33.phx2.redhat.com [10.3.112.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D3855B4A1;
        Wed, 13 Jan 2021 00:28:00 +0000 (UTC)
Reply-To: tstellar@redhat.com
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210112184004.1302879-1-jolsa@kernel.org>
From:   Tom Stellard <tstellar@redhat.com>
Organization: Red Hat
Message-ID: <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
Date:   Tue, 12 Jan 2021 16:27:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210112184004.1302879-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/12/21 10:40 AM, Jiri Olsa wrote:
> When processing kernel image build by clang we can
> find some functions without the name, which causes
> pahole to segfault.
> 
> Adding extra checks to make sure we always have
> function's name defined before using it.
> 

I backported this patch to pahole 1.19, and I can confirm it fixes the 
segfault for me.

-Tom

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>   btf_encoder.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 333973054b61..17f7a14f2ef0 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>   
>   	if (elf_sym__type(sym) != STT_FUNC)
>   		return 0;
> +	if (!elf_sym__name(sym, btfe->symtab))
> +		return 0;
>   
>   	if (functions_cnt == functions_alloc) {
>   		functions_alloc = max(1000, functions_alloc * 3 / 2);
> @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>   		if (!has_arg_names(cu, &fn->proto))
>   			continue;
>   		if (functions_cnt) {
> -			struct elf_function *func;
> +			const char *name = function__name(fn, cu);
> +			struct elf_function *func = NULL;
>   
> -			func = find_function(btfe, function__name(fn, cu));
> +			if (name)
> +				func = find_function(btfe, name);
>   			if (!func || func->generated)
>   				continue;
>   			func->generated = true;
> 

