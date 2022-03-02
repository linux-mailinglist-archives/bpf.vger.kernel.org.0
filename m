Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4274CB133
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 22:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiCBVXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 16:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245244AbiCBVXu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 16:23:50 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB3147AC0
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 13:23:06 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 195so2714658pgc.6
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 13:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HYz5BXHlIx8r3oPLqtla6YPvxC7U7o3U9yAVcQr8SyE=;
        b=qEhRQdV4nKQOHuA1A3ft2DrjhiXQQiNLFDkRh73VIjixPRKyLkCUkqkesBy58jrU7n
         X/y3ofhPeD3ybhje/wPauyIkn7dnqSVokHGaspxXyrQlDqfLaW7HarvhlRWbveeuyI4e
         q9ps8W+pZszGLrt0rDcMezdK8HlD0XNSrdkB3r8vePT6pmm8fLP2fuSkWeQRXFYJTHrt
         5EG1xQrCeVoxJD7Ch0vx6PaR6HGTD7dA4QKqsRMoTCzi9P8gNpVqIzJXBhPsL+CpXKRw
         pnnTuCfp9SpYGqzCzvmtZ/2h25Ts4u1y+gTHeK7ggV2pdt+J4IT0eem5vw8DdA3BMF9M
         INYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HYz5BXHlIx8r3oPLqtla6YPvxC7U7o3U9yAVcQr8SyE=;
        b=q64lYSdI/MiyEPUbUibD3VtokFkzBdaoYvupIc9AzZaGy8Q8KbVl0hWlCcyv0WdAZP
         V/M40F+1hmv7gsLBHKclFqMiMg1DvNHEGJDjhs+n0R/CrMxdtulChZk+sbvoN1tdpJxt
         b5qeKfhH1MQIDRjlNQ9W9WSE7qK8n9edu2O0Y+bub8EA71tZyYxb+eAJqa90Yza+eoIO
         rMwvBC0IS1bWV/Yr7lLnZijsBAXxMX1U02r4URPHASi3CwkwW4XbO/bL8W8zvMaJpp9P
         UDgSFL1ezcen+9Cg2cRudYbzSZ0EwpfNJsHl1X4zHSq1JXmzKooUHmwnb7QrmBqFQ3u/
         pjWQ==
X-Gm-Message-State: AOAM531u6BUCq0mOxFBTh2YwWZ+cWuuTYpuIfud3HfgONMsK2sWRDs74
        W9N61AAcx9YBHJFi11nSNOc=
X-Google-Smtp-Source: ABdhPJxMOdZ8tDpGkL42519AOxyJpSS0qSqox/IZrbQYp+2oUDtgolCRLBGJml+v2rS8BqhCZFIj7A==
X-Received: by 2002:a05:6a00:15c6:b0:4f0:ecec:8214 with SMTP id o6-20020a056a0015c600b004f0ecec8214mr35643840pfu.33.1646256186274;
        Wed, 02 Mar 2022 13:23:06 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::2:156b])
        by smtp.gmail.com with ESMTPSA id h17-20020a63df51000000b0036b9776ae5bsm75901pgj.85.2022.03.02.13.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:23:05 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:23:02 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH v5 bpf-next] Small BPF verifier log improvements
Message-ID: <20220302212302.y7ct3xgkpwu4dto3@ast-mbp.dhcp.thefacebook.com>
References: <20220301222745.1667206-1-mykolal@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301222745.1667206-1-mykolal@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 01, 2022 at 02:27:45PM -0800, Mykola Lysenko wrote:
>  		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
>  		.matches = {
> -			{6, "R3_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
> -			{7, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> -			{8, "R4_w=inv(id=0,umax_value=255,var_off=(0x0; 0xff))"},
> -			{9, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> -			{10, "R4_w=inv(id=0,umax_value=510,var_off=(0x0; 0x1fe))"},
> -			{11, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> -			{12, "R4_w=inv(id=0,umax_value=1020,var_off=(0x0; 0x3fc))"},
> -			{13, "R4_w=inv(id=1,umax_value=255,var_off=(0x0; 0xff))"},
> -			{14, "R4_w=inv(id=0,umax_value=2040,var_off=(0x0; 0x7f8))"},
> -			{15, "R4_w=inv(id=0,umax_value=4080,var_off=(0x0; 0xff0))"},
> +			{6, "R3_w=scalar(umax=255,var_off=(0x0; 0xff))"},
> +			{7, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
> +			{8, "R4_w=scalar(umax=255,var_off=(0x0; 0xff))"},
> +			{9, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
> +			{10, "R4_w=scalar(umax=510,var_off=(0x0; 0x1fe))"},
> +			{11, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
> +			{12, "R4_w=scalar(umax=1020,var_off=(0x0; 0x3fc))"},
> +			{13, "R4_w=scalar(id=1,umax=255,var_off=(0x0; 0xff))"},
> +			{14, "R4_w=scalar(umax=2040,var_off=(0x0; 0x7f8))"},
> +			{15, "R4_w=scalar(umax=4080,var_off=(0x0; 0xff0))"},

Sorry for the later review.
Would "int" be more precise and less verbose than "scalar"?
