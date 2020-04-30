Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42AE1BF25B
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 10:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgD3INc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Apr 2020 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgD3INc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Apr 2020 04:13:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4295C035495
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 01:13:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d15so5720111wrx.3
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2020 01:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=S26iDR5wiFrSlBw+/Sqtg08lFgjLtyBozvtbShjn61Y=;
        b=pTvelUQ+zdPy9VKa02LtKHv3qmi3+WZYYOUBtJB+GxiRulqGC7PbCYETbq1Y6bLGyO
         IVHO2Bar5whefojm2f+DZ5OymKBa2qS3gDxuNKlX820aNuTJai9zLENWVTXVaKskUiCc
         zH/JduLJfFZU74TVWC72WISGslKVUDt5Fq5kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=S26iDR5wiFrSlBw+/Sqtg08lFgjLtyBozvtbShjn61Y=;
        b=qA3+TqhpM9q6bBv+xXSz5Nb4W80khghT7DP4M1l75knJyeBcCDJXcony6JeV4DfOwN
         fQJdxXG3cBM3PFUx6wPketAcqsCnq3pYB2t/yj8yCIUPWhf7gZhc1JD8tPJ2/Bug3zxu
         h0hH0FlQxvpQ9j9dNJxLxmzbdkB1Cw7WJHkUC35f5nBCR2ByGJNedVWZT52/xCs7X/AP
         2sA7Ll4inf9jTqhlovR+h80wlE44QQvx2ZCP18GKWE9FUROLUi/JUCdrgR46J6E2/s8E
         mXLOJXL0+l5H3wwjrhuyhBQpl3fJvJHLx5ttIQZvjCP/T0HZbA95wKoMpB99JgufUjRs
         k+rw==
X-Gm-Message-State: AGi0PuYwL2qKixuUzBVnANkrdA6iu8wfR1/587sVjuKzKMlV8rzkDZDe
        dKdh/pWlme6jIX9v7M4sK9P1Pe/r0g0=
X-Google-Smtp-Source: APiQypLvst+AtmPsyQgU2WZy0y3Y0J8quxpfpb0fOzCKml+3rJRIiOzy/41XYMewpzXoV1FZ57ZFYA==
X-Received: by 2002:a5d:6b8a:: with SMTP id n10mr2607952wrx.36.1588234410414;
        Thu, 30 Apr 2020 01:13:30 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id v1sm2992098wrv.19.2020.04.30.01.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 01:13:29 -0700 (PDT)
References: <20200430021436.1522502-1-andriin@fb.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next] libbpf: fix false uninitialized variable warning
In-reply-to: <20200430021436.1522502-1-andriin@fb.com>
Date:   Thu, 30 Apr 2020 10:13:28 +0200
Message-ID: <87imhhv1av.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 30, 2020 at 04:14 AM CEST, Andrii Nakryiko wrote:
> Some versions of GCC falsely detect that vi might not be initialized. That's
> not true, but let's silence it with NULL initialization.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d86ff8214b96..977add1b73e2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5003,8 +5003,8 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
>  					 GElf_Shdr *shdr, Elf_Data *data)
>  {
>  	int i, j, nrels, new_sz, ptr_sz = sizeof(void *);
> +	const struct btf_var_secinfo *vi = NULL;
>  	const struct btf_type *sec, *var, *def;
> -	const struct btf_var_secinfo *vi;
>  	const struct btf_member *member;
>  	struct bpf_map *map, *targ_map;
>  	const char *name, *mname;

Alternatively we could borrow the kernel uninitialized_var macro:

include/linux/compiler-clang.h:#define uninitialized_var(x) x = *(&(x))
include/linux/compiler-gcc.h:#define uninitialized_var(x) x = x
