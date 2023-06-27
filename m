Return-Path: <bpf+bounces-3576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCF57400C1
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84DE2810ED
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A9E19E69;
	Tue, 27 Jun 2023 16:20:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DF819E40
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 16:20:53 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A60A3591;
	Tue, 27 Jun 2023 09:20:44 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so45278a12.0;
        Tue, 27 Jun 2023 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687882843; x=1690474843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d6dcOHsJQgpksMKnRP4FYw4su0q3QNatEqCaxVPjHrs=;
        b=UbzhqNFwDvC31obTcEjFweFhdR50GuCSbHXQcGPTJDxq/1how9bl6YUMBKh6PLZMBG
         QC8ahwIIrAci1ZfdjHUTJKt/1t40kQkDXbXbnChLqnJYrPM/DBgzE9hTS96vXbvMSGY2
         OeWoPGmsx6Lb8G36Ee4H/f4/6+RkLVFX8XwEwODahPIEZIjHX6+ufGCDGVg04Z1f78eM
         7RLAgidAQeWEbeZxiRDg3IqptRINunrtJCmBz5nOGsJx5YHW/cgfHCuQuDLUPAtmLbkl
         izoGyzS3HRuWwz9VbBwFCoVWcMmpOfMhgEegomaq0J6x/KqU5pOT6JMw6QV8aAT/QqPw
         Szpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687882843; x=1690474843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6dcOHsJQgpksMKnRP4FYw4su0q3QNatEqCaxVPjHrs=;
        b=hZyF4cVsod+ROf7D2h6kP3vJeokDq7tLMocmBz3LQEblrHFM+v1esaamMYw96JNXmQ
         Jycc6AmM9G2vxZtBtkkADCt6xedUO3qr3WiKvX8CyhhbP06kDkMZQdqcwke/0KExdztS
         BqDk0wSNDlYIo6caSotG6B4yVZ+J9CtgmNQsKvR2mUVvM6rumL+q8taI0trT6Z71zcBs
         OiAh8MekQUlSIBbdADeffvzIkwe0X+HwgZN5kfP+rFm9hbFGdW6cK1ucb27MMLIiHpx2
         7sDrZuV7rVqlWCO94TgZ6RmeCte38NDMiGwlcHRsaCn9PULUusA1WatG6o/aJGJogae7
         I+rA==
X-Gm-Message-State: AC+VfDw+1jLXhRXhfsD9WjdTL87ftGcpI6bNS1qTZkZ+ot76xIs7RCAT
	MhSC852cLCMi0ga4kD4xJngKXHEqq23Ld7km
X-Google-Smtp-Source: ACHHUZ5pIG6VTyBZ8yAbebNwTnq+PYqWCyK4mDhwR+HXUwcL/YN0yrKmSE/mA4rArjH9he4bggqUaQ==
X-Received: by 2002:aa7:cd65:0:b0:51d:89b2:7d8d with SMTP id ca5-20020aa7cd65000000b0051d89b27d8dmr8954054edb.15.1687882842757;
        Tue, 27 Jun 2023 09:20:42 -0700 (PDT)
Received: from krava (net-93-65-241-219.cust.vodafonedsl.it. [93.65.241.219])
        by smtp.gmail.com with ESMTPSA id a17-20020a50ff11000000b0051a4fcf7187sm3854474edu.62.2023.06.27.09.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:20:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 27 Jun 2023 18:20:39 +0200
To: SeongJae Park <sj@kernel.org>
Cc: martin.lau@linux.dev, ast@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Egorenkov <Alexander.Egorenkov@ibm.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] btf: warn but return no error for NULL btf from
 __register_btf_kfunc_id_set()
Message-ID: <ZJsMVxGVCJoF19wQ@krava>
References: <20230626181120.7086-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626181120.7086-1-sj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 06:11:20PM +0000, SeongJae Park wrote:
> __register_btf_kfunc_id_set() assumes .BTF to be part of the module's
> .ko file if CONFIG_DEBUG_INFO_BTF is enabled.  If that's not the case,
> the function prints an error message and return an error.  As a result,
> such modules cannot be loaded.
> 
> However, the section could be stripped out during a build process.  It
> would be better to let the modules loaded, because their basic
> functionalities have no problem[1], though the BTF functionalities will
> not be supported.  Make the function to lower the level of the message
> from error to warn, and return no error.
> 
> [1] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> 
> Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
> Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com/
> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> Fixes: dee872e124e8 ("bpf: Populate kfunc BTF ID sets in struct btf")

should it be this one in Fixes instead?
  c446fdacb10d bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF

other than that looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> Cc: <stable@vger.kernel.org> # 5.17.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  kernel/bpf/btf.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 6b682b8e4b50..d683f034996f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7848,14 +7848,10 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>  
>  	btf = btf_get_module_btf(kset->owner);
>  	if (!btf) {
> -		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
> -			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
> -			return -ENOENT;
> -		}
> -		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
> -			pr_err("missing module BTF, cannot register kfuncs\n");
> -			return -ENOENT;
> -		}
> +		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> +			pr_warn("missing vmlinux BTF, cannot register kfuncs\n");
> +		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
> +			pr_warn("missing module BTF, cannot register kfuncs\n");
>  		return 0;
>  	}
>  	if (IS_ERR(btf))
> -- 
> 2.25.1
> 
> 

