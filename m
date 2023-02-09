Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E9B6903F2
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 10:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjBIJgp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 04:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIJgo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 04:36:44 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87073B0EB
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 01:36:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j23so1177419wra.0
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 01:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v4rZUPQLVqroK30jLiXTt8XO8kHAVLptOPKZCKsy2lQ=;
        b=WIN3RC25/s3JmamYwNSuDO/kkVzmrSo0GEO18NXZqhpnG2MJFxPMpkH8tPVxbUcl/d
         CzB1bhJI0Ulcb/9FLiiTSOS6cusv88J5u8r9Oy+oyhlodYg2DKDpLtTEikoU0bt0SCNd
         BihjLrGfPX1K5b2eurOQCFgPeLwh/sEA/yvS6qMMq43FGOR5RnF9atJt8eh4BcMKJuii
         4YlJ0loD5rG4TWVvx7avTpeUEt+DtOxRjI1BiizipZFPbhvIOC+1QuZbVLTy7ly/z48B
         WsKeFov9joH0tMyFGlJ8Mc4Min0JZxiclVWom1imF+NPmbvG1x7u6C/he6Q36mPOy+Y5
         FNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4rZUPQLVqroK30jLiXTt8XO8kHAVLptOPKZCKsy2lQ=;
        b=2PLv5HChmrjefBNGy1LVmSu3Ih76bhSz3cXu7QC0MjXu9Mnevpfxr1apgCBZ8VUPzN
         IioU1yrvlUxof6l7ijRo7tBhSN6a0a2qYCht0ONow37phE0sO/mzehLDU5gXvlGPwh4A
         gqedz/EKHZw9g+Tz7LV7E1zqESS34vA2yvnsNUpb/KfIvh4Pl3g3DeuZKiEvd4prMOJQ
         e7Lcz2iGAVWozcomVQe4rJrmLtswr7QzTDzpr3RnzQXfRIB+YRcvVOLjO3pb+jfWTrtq
         tulSkYMUpq5G+95bIIE/rFU5PnEwq5RRmuKC2u9VqBRo0D3RR79cSmrPkor/BjRxVrzn
         ZO+g==
X-Gm-Message-State: AO0yUKWkBiw/YVczXHnRRwME8Jqfyy954uTuy1qMjmbsIbahhjN2t4ON
        PMTgV8c20QaC7xvDdOMjb3s=
X-Google-Smtp-Source: AK7set+kzZRRWTxj3RmUQ33W4nvJ8VRKNj2qHvl5sWfneflKUABMAhb3jUCQpCO9YLC28WYOapSKQQ==
X-Received: by 2002:a5d:591c:0:b0:2c4:759:a33d with SMTP id v28-20020a5d591c000000b002c40759a33dmr3199098wrd.43.1675935402174;
        Thu, 09 Feb 2023 01:36:42 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q12-20020adffecc000000b002c3ea9655easm765140wrs.108.2023.02.09.01.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 01:36:41 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Feb 2023 10:36:39 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] btf_encoder: ensure elf function representation
 is fully initialized
Message-ID: <Y+S+p3RuPg7KIFft@krava>
References: <1675896868-26339-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675896868-26339-1-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 08, 2023 at 10:54:28PM +0000, Alan Maguire wrote:
> new fields in BTF encoder state (used to support save and later
> addition of function) of ELF function representation need to
> be initialized.  No need to set parameter names to NULL as
> got_parameter_names guards their use.
> 
> A follow-on patch intended to be applied after the series [1].
> 
> [1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
> 
> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  btf_encoder.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 35fb60a..ea5b47b 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1020,6 +1020,8 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
>  	}
>  	encoder->functions.entries[encoder->functions.cnt].generated = false;
>  	encoder->functions.entries[encoder->functions.cnt].function = NULL;
> +	encoder->functions.entries[encoder->functions.cnt].state.got_parameter_names = false;
> +	encoder->functions.entries[encoder->functions.cnt].state.type_id_off = 0;
>  	encoder->functions.cnt++;
>  	return 0;
>  }
> -- 
> 1.8.3.1
> 
