Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF462F28B
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 11:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbiKRK3D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 05:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiKRK3C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 05:29:02 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D761F9EB;
        Fri, 18 Nov 2022 02:29:01 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 21so6536089edv.3;
        Fri, 18 Nov 2022 02:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eDDnKSKUKNh/5MLwUUl+eLVdClsVLwH9ZeWm8DBVzw=;
        b=XgCsfBhiQO4lJalkBL6dinW7VaHvDXhcheH3R+djP/+gmxQom4sv2cYrI0H1AajMQG
         s22au/qBEo+zixY7XieguFsy85Vne5/O01LlGBik5KqeEf6JnfA+O/89MYx3EcOtGXhA
         7chWUFPk+mAAFL3hzgEc0shxiur4Wl+7v0fUXJHFW4sFcvDaSX5fopoXW9fWWy/Mfv4/
         5oZ6NexVJMrk69uXap6cUj8LLfvkG7AQ87c9mDBaIrnIPsZof248QPKyjEzq4phdrmMn
         CX7UAco+aXdDYFf7nLRvXcHMYl+CUDtx3jC/uTmXPMAk0ALGj/Rw2wXO3kakA2eNGDq/
         DYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eDDnKSKUKNh/5MLwUUl+eLVdClsVLwH9ZeWm8DBVzw=;
        b=uLporp82S9HUOlgpPX++vMR5FPL9LybazA4PdBSW2R69RRuU7+Font+o5UTAzIfTIK
         reVLNJ24xb3ngZhEyIhGms5Z98Wcll9WxshZzIlv50N4fQ8bJRrWVyR6FA3oh0opFuKT
         s/0E7Db/6/hQPehYsYLcWD4cbv73JXhFMRjmvruWVGFBEbicFIoL8EvA9wMhbluaLuRl
         KC348lU6KtHDgYeagGy2Z7n2lQehjLdG5946xMbhrfHoUTLhpFBPU/W51iQNHycpuYyD
         16q68MCp+hyjA2fCimMFhbI+LzPPGcdCHX4YXO+Xv0hx2ZRIKKgvBWyrO3YMvTkPagiX
         yCxA==
X-Gm-Message-State: ANoB5pkn5kqswX1P5MgBDOsF0T4zRhZm33lCbHSzJcq659Np/6XTdlMf
        F70Gb7pqX1szoJ5gy/+u+gM=
X-Google-Smtp-Source: AA0mqf6g+/K00HMi5iatfky5NdbPSR/Is6yiVnQLxMaKldOROVmujrxDQrGxyUS1hfxwvORY98PoZg==
X-Received: by 2002:a05:6402:c6:b0:468:3d69:ace0 with SMTP id i6-20020a05640200c600b004683d69ace0mr5534330edu.356.1668767340153;
        Fri, 18 Nov 2022 02:29:00 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p19-20020a17090653d300b007aea1dc1840sm1487807ejo.111.2022.11.18.02.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 02:28:59 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 18 Nov 2022 11:28:57 +0100
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] samples: bpf: Use "grep -E" instead of "egrep"
Message-ID: <Y3deaZ+QxLqtj1Pp@krava>
References: <1668765001-12477-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668765001-12477-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 18, 2022 at 05:50:01PM +0800, Tiezhu Yang wrote:
> The latest version of grep claims the egrep is now obsolete so the build
> now contains warnings that look like:
> 	egrep: warning: egrep is obsolescent; using grep -E
> fix this up by moving the related file to use "grep -E" instead.
> 
>   sed -i "s/egrep/grep -E/g" `grep egrep -rwl samples/bpf`
> 
> Here are the steps to install the latest grep:
> 
>   wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
>   tar xf grep-3.8.tar.gz
>   cd grep-3.8 && ./configure && make
>   sudo make install
>   export PATH=/usr/local/bin:$PATH
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  samples/bpf/test_cgrp2_tc.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/bpf/test_cgrp2_tc.sh b/samples/bpf/test_cgrp2_tc.sh
> index 12faf58..395573b 100755
> --- a/samples/bpf/test_cgrp2_tc.sh
> +++ b/samples/bpf/test_cgrp2_tc.sh
> @@ -115,7 +115,7 @@ do_exit() {
>      if [ "$DEBUG" == "yes" ] && [ "$MODE" != 'cleanuponly' ]
>      then
>  	echo "------ DEBUG ------"
> -	echo "mount: "; mount | egrep '(cgroup2|bpf)'; echo
> +	echo "mount: "; mount | grep -E '(cgroup2|bpf)'; echo
>  	echo "$CGRP2_TC_LEAF: "; ls -l $CGRP2_TC_LEAF; echo
>  	if [ -d "$BPF_FS_TC_SHARE" ]
>  	then
> -- 
> 2.1.0
> 
