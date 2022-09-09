Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165E95B3D34
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 18:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiIIQlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiIIQln (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 12:41:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8B214343F
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 09:41:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id v16so5271434ejr.10
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DRwJfDfUvquGqeEO7uBxCBjC7gdIjwvuPT372cxAYpQ=;
        b=Uh2A6nB3Je0xjwJkD6HBqRKtVToway5Tp1sUKGqXTXVJmyBsPvDZMAeq3gCZP4XfSb
         cRocVKPbdc52Vwsu7CFJOmr6iPVYZYYIq4HiOEcOFvXYJu0vw57jwxfa2moGpy5Qgc0B
         qSXZWP7Xa10m9Ee7dMGxfhD1yXkha92yPTjoA45AUEcqxaXY2Pe/kH1sVJ3aYi3+vjrZ
         KWWIR5Hnz8j//c4beS854oG6T8GlY6+G15OmqkWrUbNAVO44uuQdpReY0S6TJs6Gm2vw
         RHGzxgSbOsIOsEkIcYAii9NipGZ+MzCP2Gywdk5iNIE7Yb7YyoIVRofBqiR5oUpArWwc
         xfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DRwJfDfUvquGqeEO7uBxCBjC7gdIjwvuPT372cxAYpQ=;
        b=zB4RatJV3bhIsh8Zs1jEM3umIuLxExT/Vuw8RDVfG2xsYOEEdu9mMYU0w7R6e50DLO
         8YRaaJYkiFDC+iqvtNGZWLnAkrpwMEXv1kEp9uCLmLBwr7M4clJS1emRuhAIaWCOao2x
         rCZgaVNU6gO83hXUJFtPbJU1CenmyvLkx6a18EHmxis7B6GYTz6EYBWgGAOJ3+IKoJ+o
         0wKkeW5k4pUuDd0H8acM0BPm4EUeu5rZdxo2cfLMUWnGD4Cyl4luLe1GYBFLtFI4LvP2
         nldyER0mv2fFGdgaNQLpdlee2hKk4sTpvm7wxtVef2VQ2DSpROvPdLVrj7nA7920Ty7F
         /0fA==
X-Gm-Message-State: ACgBeo3zxt2aCfMfLAwmlmWByd6QO0sJSJ98rJaJhFnQugeF+yTfydRj
        R1n6YVADwfbVr6iSvvgeg6uoYUYN2wc=
X-Google-Smtp-Source: AA6agR7N3lZUuwaliPH+memk9kyj/1xPiCtaXAEKj3hdzTwC5boDBNNr5I8leSS7WjZSSpnGsC86oA==
X-Received: by 2002:a17:906:5d0a:b0:770:23b7:ba9 with SMTP id g10-20020a1709065d0a00b0077023b70ba9mr10636556ejt.404.1662741700827;
        Fri, 09 Sep 2022 09:41:40 -0700 (PDT)
Received: from blondie ([141.226.162.95])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906539600b0076fa6d9d891sm511070ejo.46.2022.09.09.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 09:41:40 -0700 (PDT)
Date:   Fri, 9 Sep 2022 19:41:38 +0300
From:   Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        andrii@kernel.org, ast@kernel.org, Kernel-team@fb.com,
        Eyal Birger <eyal.birger@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] bpf: Add bpf_dynptr_clone
Message-ID: <20220909194138.46aea4cb@blondie>
In-Reply-To: <20220908000254.3079129-6-joannelkoong@gmail.com>
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
        <20220908000254.3079129-6-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed,  7 Sep 2022 17:02:51 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:

> Add a new helper, bpf_dynptr_clone, which clones a dynptr.
> 
> The cloned dynptr will point to the same data as its parent dynptr,
> with the same type, offset, size and read-only properties.

[...]

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 4ca07cf500d2..16973fa4d073 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5508,6 +5508,29 @@ union bpf_attr {
>   *	Return
>   *		The offset of the dynptr on success, -EINVAL if the dynptr is
>   *		invalid.
> + *
> + * long bpf_dynptr_clone(struct bpf_dynptr *ptr, struct bpf_dynptr *clone)
> + *	Description
> + *		Clone an initialized dynptr *ptr*. After this call, both *ptr*
> + *		and *clone* will point to the same underlying data.
> + *

How about adding 'off' and 'len' parameters so that a view ("slice") of
the dynptr can be created in a single call?

Otherwise, for a simple slice creation, ebpf user needs to:
  bpf_dynptr_clone(orig, clone)
  bpf_dynptr_advance(clone, off)
  trim_len = bpf_dynptr_get_size(clone) - len
  bpf_dynptr_trim(clone, trim_len)

This fits the usecase described here:
  https://lore.kernel.org/bpf/20220830231349.46c49c50@blondie/
