Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4DF59D2D5
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 09:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbiHWH7I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 03:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241456AbiHWH7G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 03:59:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396513E05
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 00:59:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bf22so13299130pjb.4
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=6DnYQNwUW9eqRYhVnpJFuBYYSrombQjTfKedzZiWtac=;
        b=JNB0y94pzQYvDGEHxxfMKKXpUT6eYjLmC6SINHcmfoP2kUc3EJOiqjeH9F4VAtiuuq
         7ZEYK6psWNp0DEbXkumuQTohJV5owGmn6bQAoWFM/7yeTOgWbaktU7WEY5fWsHfqGC2K
         jrk+ExDwagXKs8VJtYmMk81xWGTRGyeSbF5Sg0YuoKsWraC5ERBZE5jJVXBSO7+59Y9u
         2dlzza+hLlE6ez7KroaGJIkjtxUXW9ia7/NJiFUuOw8MBxdEE/yj3WXTAnV8TWnX0/q5
         9OvtWqfVPoYhalReQRI5Oxnc9cX0VUB92510UuhgLfVKXVdD8nUt3xkn4JHp1NcupQU1
         QCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=6DnYQNwUW9eqRYhVnpJFuBYYSrombQjTfKedzZiWtac=;
        b=O3C2j8JoddFueIVMtuoQOeJEODCVMR5/ReRM4O+t4XRV/4jvvlpPaGAXa7PfwlvXiC
         F+SlS8nEg8yU+XQzUwD9mF0/jhn8elRKF7qc9ogFjAEa/r41GLh4bWOeTpcrT26RLZpX
         ifPCNFT09VSaRGbjR9Qf5K5jEs+vCPkQ0iWxBXyPIhuwErldrkWi0RQ0u0IdrAOC35z4
         cisD7GaZhEZPnqm4XDwKrNNk0FNXlMPjnkB59LanGTRxCccnzJGXWTJHWZuCZVc198py
         0ikF6kGfhPKJ4B6HRGiu0zm/jTPhLNs3uLLlgBwCe/wI/xrOoYpLO2N5vJlnqEhXeYz4
         DRng==
X-Gm-Message-State: ACgBeo2zPQs9QeS6oEQVJP7i8NzOC8NxegdO+diQinnrWZj3ZqMv6l4W
        dyvtZxqrwkw/do/qtSLY94c=
X-Google-Smtp-Source: AA6agR4t1aWpb+b1ATRI67L1g+xLtixQEnCAaMKpsjajt2G3MHNBa8vSnpflvNExHA1yFb/D7c23dw==
X-Received: by 2002:a17:902:e84c:b0:172:ebff:6107 with SMTP id t12-20020a170902e84c00b00172ebff6107mr6106540plg.40.1661241544480;
        Tue, 23 Aug 2022 00:59:04 -0700 (PDT)
Received: from localhost ([98.97.33.232])
        by smtp.gmail.com with ESMTPSA id e5-20020aa79805000000b005366e592cf9sm5016234pfl.96.2022.08.23.00.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:59:03 -0700 (PDT)
Date:   Tue, 23 Aug 2022 00:59:01 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Shmulik Ladkani <shmulik@metanetworks.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Message-ID: <630488c5d0f99_2ad4d720813@john.notmuch>
In-Reply-To: <20220822052152.378622-2-shmulik.ladkani@gmail.com>
References: <20220822052152.378622-1-shmulik.ladkani@gmail.com>
 <20220822052152.378622-2-shmulik.ladkani@gmail.com>
Subject: RE: [PATCH v3 bpf-next 1/3] bpf: Support setting variable-length
 tunnel options
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

Shmulik Ladkani wrote:
> Existing 'bpf_skb_set_tunnel_opt' allows setting tunnel options given
> an option buffer (ARG_PTR_TO_MEM|MEM_RDONLY) and the compile-time
> fixed buffer size (ARG_CONST_SIZE).
> 
> However, in certain cases we wish to set tunnel options of dynamic
> length.
> 
> For example, we have an ebpf program that gets geneve options on
> incoming packets, stores them into a map (using a key representing
> the incoming flow), and later needs to assign *same* options to
> reply packets (belonging to same flow).
> 
> This is currently imposssibly without knowing sender's exact geneve
> options length, which unfortunately is dymamic.
> 
> Introduce 'skb_set_var_tunnel_opt'. This is a variant of
> 'bpf_skb_set_tunnel_opt' which gets an *additional* parameter 'len',
> which is the byte length from 'opt' buffer to copy into ip_tunnnel_info.
> 
> The 'size' parameter is kept ARG_CONST_SIZE. This way, verifier can still
> safe-guard buffer access. 'len' must never exceed 'size', o/w EINVAL is
> returned.
> 
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> ---
> v3: Avoid 'inline' for the __bpf_skb_set_tunopt helper function
> ---
>  include/uapi/linux/bpf.h       | 12 ++++++++++++
>  net/core/filter.c              | 34 +++++++++++++++++++++++++++++++---
>  tools/include/uapi/linux/bpf.h | 12 ++++++++++++
>  3 files changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 934a2a8beb87..1b965dfd0c80 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5355,6 +5355,17 @@ union bpf_attr {
>   *	Return
>   *		Current *ktime*.
>   *
> + * long bpf_skb_set_var_tunnel_opt(struct sk_buff *skb, void *opt, u32 size, u32 len)
> + *	Description
> + *		Set tunnel options metadata for the packet associated to *skb*
> + *		to the variable length *len* bytes of option data contained in
> + *		the raw buffer *opt* sized *size*.
> + *
> + *		See also the description of the **bpf_skb_get_tunnel_opt**\ ()
> + *		helper for additional information.
> + *	Return
> + *		0 on success, or a negative error in case of failure.

This API feels akward to me. Could you collapse this by using a dynamic pointer,
recently added? And drop the ptr_to_mem+const_size part at least? That seems
redundant with latest kernels.

And then is there a case where size != len? Probably I guess? Anyways having
a signature like tunnel_otpion(skb, opt, len) looks a lot like memcpy to me
and feels familiar.

[...]

>  
> +static const struct bpf_func_proto bpf_skb_set_var_tunnel_opt_proto = {
> +	.func		= bpf_skb_set_var_tunnel_opt,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_CTX,
> +	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
> +	.arg3_type	= ARG_CONST_SIZE,
> +	.arg4_type	= ARG_ANYTHING,
> +};
> +
