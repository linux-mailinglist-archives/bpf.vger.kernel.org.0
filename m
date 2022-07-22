Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2168557E183
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiGVMkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 08:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbiGVMkI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 08:40:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149A61009
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 05:40:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ez10so8261546ejc.13
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5wcxEe6tFZ/9Ee9rhoiZEVi19n8e8WeGfE+cYGuHLaw=;
        b=Zu03CbiF3DnE8F48B9xbWOrTWGiOtoeosR+/RZAw87Tr53KPdHYhOhfS6JUTWbT1Iv
         mXclacYwXtX0NSzejV7DwH48YaDp8rmX1g/zigJfgKjTnwft32eMLIELoPuysECZK8aA
         zswhyjD/VRFOYAmYX35bLEu/tASsCyqZH5qVqnMTKKwhAGnyc1jSXjAtsptfTcPuhxoE
         o0z6FsFzG2bh+3mB+dd7SClrdwjbVBvdyUiUpL/DCiv/LpaVAJoa8x/sxehrIA8Lhdg0
         TwlnXlu8D8U4gGtpETvSXKN1Tf6yAj8LKh8n+AfbXt1+OUpsiD9GmAhOUWLlUKLxJTZy
         Oobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5wcxEe6tFZ/9Ee9rhoiZEVi19n8e8WeGfE+cYGuHLaw=;
        b=vKvg5CFEi4ifYuyRYiBQeecArVNWydj0sKlOMwnrJjzTZv/5opkjPHxNWiyqqXJG9b
         +VZmHbWJQnU7RH96U49XKiCyXH0D1cLBcW9vgn31Bxl0ssWlES+PJFHjpURd10O4v6j5
         /ehXXuWW+wH9m+o6jdkGc+MPS3Sy9PfPSIH7m5c3Aa/qmT1NemWx6K8KUoDJ4bwwrfK1
         9OsR2zyFxJoinm3HW9GcztBPYucUJTC8kV2cfeLbPUN71JvFZb/sSkLlm3cyDMILVn5q
         ZrqXEcwQj/UWvZnOCtHCuCaS136ZGPjtWUofbuAJhl7vkqSLF+V8nhfZjMJRDdfP+sLy
         wjIQ==
X-Gm-Message-State: AJIora9X2O/rLIigPsLGSlUpWt7EWRPF9iTAS2Pgk2LIvYjcJj8TFG6M
        jClxpukJvP/xSh37qfQQbgk=
X-Google-Smtp-Source: AGRyM1txi2eVcnlETn8YJqDbq2UNXP+m2HVPprHACkM+XyGxzx+A7But2vWSsCf78R52D8deuSonrA==
X-Received: by 2002:a17:907:87b0:b0:72b:9f0d:3f89 with SMTP id qv48-20020a17090787b000b0072b9f0d3f89mr327754ejc.734.1658493605520;
        Fri, 22 Jul 2022 05:40:05 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id dx1-20020a170906a84100b0072b8fbc9be1sm1957005ejb.187.2022.07.22.05.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 05:40:03 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 22 Jul 2022 14:40:00 +0200
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next] bpf: Fix build error in case of
 !CONFIG_DEBUG_INFO_BTF
Message-ID: <YtqaoIhBY5Fp5iV3@krava>
References: <20220722113605.6513-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722113605.6513-1-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 01:36:05PM +0200, Kumar Kartikeya Dwivedi wrote:
> BTF_ID_FLAGS macro needs to be able to take 0 or 1 args, so make it a
> variable argument. BTF_SET8_END is incorrect, it should just be empty.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: ab21d6063c01 ("bpf: Introduce 8-byte BTF set")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  include/linux/btf_ids.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 3cb0741e71d7..2aea877d644f 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -206,7 +206,7 @@ extern struct btf_id_set8 name;
> 
>  #define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
>  #define BTF_ID(prefix, name)
> -#define BTF_ID_FLAGS(prefix, name, flags)
> +#define BTF_ID_FLAGS(prefix, name, ...)
>  #define BTF_ID_UNUSED
>  #define BTF_ID_LIST_GLOBAL(name, n) u32 __maybe_unused name[n];
>  #define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 __maybe_unused name[1];
> @@ -215,7 +215,7 @@ extern struct btf_id_set8 name;
>  #define BTF_SET_START_GLOBAL(name) static struct btf_id_set __maybe_unused name = { 0 };
>  #define BTF_SET_END(name)
>  #define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
> -#define BTF_SET8_END(name) static struct btf_id_set8 __maybe_unused name = { 0 };
> +#define BTF_SET8_END(name)
> 
>  #endif /* CONFIG_DEBUG_INFO_BTF */
> 
> --
> 2.34.1
> 
