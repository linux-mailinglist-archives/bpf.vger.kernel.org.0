Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0F618B40
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 23:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiKCWSW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 18:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiKCWSV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 18:18:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE3019A
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 15:18:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s196so2876125pgs.3
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WYyhXX1dUTXW8ScoewypnH64XW0d7upCv/IQHuxAiZM=;
        b=WDm81TghbKfaL6+gYt9UO9Mok3GfumnMq0B+zgZHceOU7g0x67DjB0Hfj+s4p6fcdu
         1K6duWMVwcYOUONg2vtrMwkrZh5DMMGjeYZpBnUqBwe8Xl3wkSoCCoo96Fb2p0aWjZdG
         8x5kJNdQgNnGvZ9qZ77NPtJedSKFmnKNr19cr1OI0uysqPCPIzOWxs6xLIpSwXIAbxmN
         L4R0gQbkgfprVJ+1xlzMHZ+2T3bbQ32EbhJBV/+doNJgKwxgd+foAFDKRCIWEO1EmPzu
         jQEwhzL9X6xj+Fy2SssrRzFLTqvvawrZEH83mDuYlL2J9FnSG1HMTDjuPkkyggLy8SOr
         uaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYyhXX1dUTXW8ScoewypnH64XW0d7upCv/IQHuxAiZM=;
        b=Z+/lNyMyUE3V7l0eSMlUhuuxlM7kjRYeBDDpS7FHcXCSOCnwCVVgAKsCWPEwIhfEde
         G39gruraVkDHSVv1GECSV1PNyzU2yfZfy+W3kinjVz07OBKIpO9Ja2/VAzUu7RmmfLNg
         P3K9SrQgM18G5hQ3TTNXYhG9e5w2N0YK3bAY0+4vzu/bofun5Ny/no+vKwFjpvXom63A
         bkZdM4EZDZ8sv/tI/KgtOyZ7gielBOZhY1+vgMi86iVjG6K5OnINQ0qb+YY7/opsK6Mp
         7RtMSF8vjtwlOYOqz1e4NK/G+BwDPPKFenbAVKP/BNRiH0slVTr7kGklFPK/eOlaglL6
         gNdA==
X-Gm-Message-State: ACrzQf1BRJXoA5smIvIBnXira2+HC63/FRf6gOWZ2FNpW64jDnpWlXmu
        53+e2AdVoJbG0z9EJihNb80=
X-Google-Smtp-Source: AMsMyM7y2BlG2g0pnDl5TUFNm3BxVO7UtKj0cqQHNRGAu7qyxMtZmo4eSusWXJnKNbIBWCdUidmNpw==
X-Received: by 2002:a63:24d:0:b0:452:87c1:9781 with SMTP id 74-20020a63024d000000b0045287c19781mr28113737pgc.512.1667513899939;
        Thu, 03 Nov 2022 15:18:19 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902b18200b001871acf245csm1180368plr.37.2022.11.03.15.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:18:19 -0700 (PDT)
Date:   Fri, 4 Nov 2022 03:48:00 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 2/5] bpf: Add bpf_rcu_read_lock/unlock helper
Message-ID: <20221103221800.iqolv5ed2muilrgq@apollo>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072113.2322563-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103072113.2322563-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 03, 2022 at 12:51:13PM IST, Yonghong Song wrote:
> Add bpf_rcu_read_lock() and bpf_rcu_read_unlock() helpers.
> Both helpers are available to all program types with
> CAP_BPF capability.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/bpf.h            |  2 ++
>  include/uapi/linux/bpf.h       | 14 ++++++++++++++
>  kernel/bpf/core.c              |  2 ++
>  kernel/bpf/helpers.c           | 26 ++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>  5 files changed, 58 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 8d948bfcb984..a9bda4c91fc7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2554,6 +2554,8 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
>  extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
> +extern const struct bpf_func_proto bpf_rcu_read_lock_proto;
> +extern const struct bpf_func_proto bpf_rcu_read_unlock_proto;
>
>  const struct bpf_func_proto *tracing_prog_func_proto(
>    enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 94659f6b3395..e86389cd6133 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5481,6 +5481,18 @@ union bpf_attr {
>   *		0 on success.
>   *
>   *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * void bpf_rcu_read_lock(void)
> + *	Description
> + *		Call kernel rcu_read_lock().
> + *	Return
> + *		None.
> + *
> + * void bpf_rcu_read_unlock(void)
> + *	Description
> + *		Call kernel rcu_read_unlock().
> + *	Return
> + *		None.
>   */

It would be better to not bake these into UAPI and keep them unstable only IMO.

> [...]
