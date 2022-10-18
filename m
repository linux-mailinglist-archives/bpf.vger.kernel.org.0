Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B46020FC
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 04:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJRCMo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 22:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJRCMQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 22:12:16 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E891237D8
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 19:12:08 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id g11so8932472qts.1
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 19:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8cM8Pvm56TbVLBT2MPEiCu53XmPf7PNk+VjsYaG9z8=;
        b=3r7yvAwmwuPAA4IeWjhunNWD0WRZ0jsPFd6kQcGo1WyrnHnFVQpk09wNkaskE2FzWu
         rYjCtVwq3+wQTWCQVE6Oi8aPeyKsaJ/K3y8jPE65YPioKEhigOIa2OcJGYgBKV0fuIJx
         TWjFJphZexsYM3gnWHg6rDzoV3A6MEhsLMXg3ytWU1FHInENhLRMPS0BfOR+njypUjEb
         o19MCxli9vEJzcvG6LSh/jZcGjiFsrDZA6aps/LBGaYdGdapxeDoNjZZAE+3sS2yc5T6
         LALvo60sh8BYWGXfsPT7gJylUBhME0ncj44u3fneFOpelXpfsLV8pdKeiNsi6fGrETHh
         SKGA==
X-Gm-Message-State: ACrzQf0k5mtiLg/PPZNCRXLbimX4a4HzH1E88sm60zNvZMQJQT3NTxKN
        ekk41cWgAMFOo5B7Kg+OyV4YI9a0mugtcw==
X-Google-Smtp-Source: AMsMyM5GtJe/WjmcSnLGpZG8AMYGLUP1F8TMiPkjmHeuJpaWZvtdt+H+lC4RqYucHtgIG/ro3p5W8g==
X-Received: by 2002:a05:622a:43:b0:39c:eb15:c2ee with SMTP id y3-20020a05622a004300b0039ceb15c2eemr459171qtw.331.1666059102877;
        Mon, 17 Oct 2022 19:11:42 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::d067])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a258500b006bb366779a4sm1186764qko.6.2022.10.17.19.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:11:42 -0700 (PDT)
Date:   Mon, 17 Oct 2022 21:11:43 -0500
From:   David Vernet <void@manifault.com>
To:     Daniel =?iso-8859-1?Q?M=FCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next] samples/bpf: Fix two typos
Message-ID: <Y04LX7wN9cEMnsQr@maniforge.dhcp.thefacebook.com>
References: <20221017232201.1257089-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221017232201.1257089-1-deso@posteo.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 17, 2022 at 11:22:01PM +0000, Daniel Müller wrote:
> This change fixes two typos in the BPF samples README file.
> 
> Signed-off-by: Daniel Müller <deso@posteo.net>
> ---
>  samples/bpf/README.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
> index 60c649..f98c26 100644
> --- a/samples/bpf/README.rst
> +++ b/samples/bpf/README.rst
> @@ -37,8 +37,8 @@ user, simply call::
>  
>   make headers_install
>  
> -This will creates a local "usr/include" directory in the git/build top
> -level directory, that the make system automatically pickup first.
> +This will create a local "usr/include" directory in the git/build top
> +level directory, that the make system will automatically pickup first.

LGTM

While you're here, could you please also change "pickup" to "pick up"?
"Pickup" is a noun, "pick up" is a verb. If you do make this change, the
commit title + summary should also be updated to not say "two".

Acked-by: David Vernet <void@manifault.com>
