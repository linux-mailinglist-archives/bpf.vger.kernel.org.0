Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CBF5063B2
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 06:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiDSFCO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 01:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiDSFCN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 01:02:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFABB13D
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 21:59:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s137so22800270pgs.5
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 21:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pc+VkLV0MW/T2lLKczrzVgRGhCcwHD/ApWUTSA1wdd4=;
        b=RwXlOLpgujQFGooe/L7k8VijkrX0VM8JQhk7wO1QHkTr8AERYONnE32tRJl+ykCPbu
         ati7TzuHFsk0Sfs5xyw+SHDRVb1dT1KEaiNRQSkrqBTBECWq1/O4UXwtOQAySvDKBorY
         3BVHvvlC3PjU+v1IS67ZOMkgHKAfZG/CCx1sqBc+ChmyZS0Bz81yerG4pO6RcZ9rBQth
         0zlDVxOj1yJZ5nipZWbcNOh3MwYohMsvq48d5XQAG5dkdJhaGs0G4d2wBI/eZwDbfllq
         5ZS6e1t+2sPtP6fcCQ2AMIkZVn43kYmn4pFDycywet3JvmpjfdW5oeGwoqF1zCburIb5
         3wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pc+VkLV0MW/T2lLKczrzVgRGhCcwHD/ApWUTSA1wdd4=;
        b=YwIGnbS1Ag1iiSevKnfWpeoCO+HRrQmw4V4ATSfaAtruGDh8O9Yq646KwC17EYuW0B
         14sjq9slY276riNbydzPJ2lXVB6pGEC6Sh7vqb40ljgNK2BwyLw2NdfNxl7rBDiicU6A
         JWh1QN56ilL6TRrrBb7lWPL2g/fBKY9E0nGdLTJlhOxreBBdalSHF/q242b0QGxyInZj
         JUh+A58fwmA5U5kBCfVm1JpAcpre/csdwpEtOT2vw5+cjtvsPd3IjHQc/RcykZ0/bCZv
         iCbEFQG/BkY/Sn0PKtw3iGnoKHqWmmpP4gd2odOlyopycn3iZVgUxNIae0sf21yGWwPK
         f0cg==
X-Gm-Message-State: AOAM531UY3KheCMXHixjIsdGCwGFMD+DREKG7Bf7OPBKg/7o6Nptgg31
        4l7sz51IG+imXCGIjifzrDY=
X-Google-Smtp-Source: ABdhPJwFiSicT0H+Q7G1T1FK201tHx99D99YOBZBNlJaEg5+BwDC0gkqgBLTC4DVCzT4MIqGe5Revw==
X-Received: by 2002:a05:6a00:1701:b0:50a:8483:a163 with SMTP id h1-20020a056a00170100b0050a8483a163mr5583574pfc.79.1650344372133;
        Mon, 18 Apr 2022 21:59:32 -0700 (PDT)
Received: from MBP-98dd607d3435.dhcp.thefacebook.com ([2620:10d:c090:400::5:d686])
        by smtp.gmail.com with ESMTPSA id a11-20020a63cd4b000000b00378b9167493sm14858248pgj.52.2022.04.18.21.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 21:59:31 -0700 (PDT)
Date:   Mon, 18 Apr 2022 21:59:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, memxor@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, toke@redhat.com
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Add MEM_UNINIT as a bpf_type_flag
Message-ID: <20220419045928.nlr6dvrlmrjdf6qq@MBP-98dd607d3435.dhcp.thefacebook.com>
References: <20220416063429.3314021-1-joannelkoong@gmail.com>
 <20220416063429.3314021-2-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416063429.3314021-2-joannelkoong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 15, 2022 at 11:34:23PM -0700, Joanne Koong wrote:
> -	ARG_PTR_TO_UNINIT_MEM,	/* pointer to memory does not need to be initialized,
> +	/* pointer to memory does not need to be initialized, helper function must fill
> +	 * all bytes or clear them in error case.
> +	 */
> +	ARG_PTR_TO_MEM_UNINIT		= MEM_UNINIT | ARG_PTR_TO_MEM,

Could you keep the name as ARG_PTR_TO_UNINIT_MEM ?
This will avoid churn in all the lines below.

> -	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
> +	.arg2_type	= ARG_PTR_TO_MEM_UNINIT,
...
> -	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
> +	.arg2_type	= ARG_PTR_TO_MEM_UNINIT,
...
> -	if (fn->arg1_type == ARG_PTR_TO_UNINIT_MEM)
> +	if (fn->arg1_type == ARG_PTR_TO_MEM_UNINIT)
>  		count++;
> -	if (fn->arg2_type == ARG_PTR_TO_UNINIT_MEM)
> +	if (fn->arg2_type == ARG_PTR_TO_MEM_UNINIT)
>  		count++;
> -	if (fn->arg3_type == ARG_PTR_TO_UNINIT_MEM)
> +	if (fn->arg3_type == ARG_PTR_TO_MEM_UNINIT)
>  		count++;
> -	if (fn->arg4_type == ARG_PTR_TO_UNINIT_MEM)
> +	if (fn->arg4_type == ARG_PTR_TO_MEM_UNINIT)
>  		count++;
> -	if (fn->arg5_type == ARG_PTR_TO_UNINIT_MEM)
> +	if (fn->arg5_type == ARG_PTR_TO_MEM_UNINIT)
>  		count++;
etc.
