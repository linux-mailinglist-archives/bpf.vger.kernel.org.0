Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF9E60DF03
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 12:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiJZKrr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 06:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiJZKro (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 06:47:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528FECD5D3
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 03:47:42 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v1so25614488wrt.11
        for <bpf@vger.kernel.org>; Wed, 26 Oct 2022 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwO/J6XC5u/U/KETkLvY6jk2wOmjSxeU44uWgsDknd0=;
        b=Dh3IPko+ZGodvjmw02h3qp8SirFezR0NikFdhAqJBrDk2kH9Ikx/gMHU7O+OIzEO32
         5jKm+m6EiQHJJYuXR8yIdVkoNiHcp2MrggnFnCB64se1BlfIRd3T+7mzEdylrW46kYsd
         lkxkz4IiqczDA2Ph24U+v4onCwgLrJuMqTfA6Hz796H0mq3ZuBg1fJxRYU3hnWAIofCd
         IQL34JLqKwwsZ81wL8DnpHAPlWHSo2XtqvdKMUb8Ax5g2n20Y8uho+aauGNckvGr/BN8
         04MctORcWybLCHG+lUWtgvf3XJPS3VUcJCi5jOD6OxHBnceIbMxQ7WnUKeV5XiWA0rJ5
         1R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwO/J6XC5u/U/KETkLvY6jk2wOmjSxeU44uWgsDknd0=;
        b=BaY+9/Exu0VVxNUXooTxil6UZ30Cf+57FPiDVzmD10jA3PU6fa0TqPdE3Ii4t6CARY
         NQpnCzRu6jbdn9UYrsQGO1zd0vV8XFD3pXSo/CUP3qnLbdp9br79QAWBS85GILIyrHN3
         8u+aI8lIbJv3v+rCZ8+RSygIZrHCrT4C4kijKhRLm/ClxylEs287zfDU8YgRld1r9mwW
         r99C1KdBeM5QIKg/DsICGyiSSLfcLhTOBhE/vLjUiF/RnJqPDJ/3a7/c1qx+thxqHA9d
         Rq8AJULeO/vmAPsZmUys4fWlRDMAY3x1wfvQ2mWnraGkRg3qCE/crFQ4rk5FPvrzFllb
         FkjA==
X-Gm-Message-State: ACrzQf27UZEucFTHUSUmhM+aLlZUENi/5gBw48ocrQbSls39tCw3IN+2
        Xc4C88GUjA4MXxbPxi1HvC2I9A==
X-Google-Smtp-Source: AMsMyM4DBdS8BONnLcYygG0nChaeXJm5Wz4Xl6+2yQTblzNJXa8f7zLXecQ5aw32lK+foYOpTHkkwA==
X-Received: by 2002:a05:6000:170b:b0:22e:44d0:6bae with SMTP id n11-20020a056000170b00b0022e44d06baemr28135803wrc.99.1666781253236;
        Wed, 26 Oct 2022 03:47:33 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003a1980d55c4sm1553348wmb.47.2022.10.26.03.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 03:47:32 -0700 (PDT)
Message-ID: <e3b415c2-351f-e2df-4a24-6fa33df7d69b@isovalent.com>
Date:   Wed, 26 Oct 2022 11:47:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH][next] bpftool: Fix spelling mistake "disasembler" ->
 "disassembler"
Content-Language: en-GB
To:     Colin Ian King <colin.i.king@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221026081645.3186878-1-colin.i.king@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20221026081645.3186878-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-10-26 09:16 UTC+0100 ~ Colin Ian King <colin.i.king@gmail.com>
> There is a spelling mistake in an error message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/bpf/bpftool/jit_disasm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
> index 58a5017034a2..7b8d9ec89ebd 100644
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c
> @@ -223,7 +223,7 @@ static int init_context(disasm_ctx_t *ctx, const char *arch,
>  
>  	memset(tpath, 0, sizeof(tpath));
>  	if (get_exec_path(tpath, sizeof(tpath))) {
> -		p_err("failed to create disasembler (get_exec_path)");
> +		p_err("failed to create disassembler (get_exec_path)");
>  		return -1;
>  	}
>  

Thanks for the fix!

Acked-by: Quentin Monnet <quentin@isovalent.com>
