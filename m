Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F83B607C48
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 18:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJUQcl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJUQck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 12:32:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D67270821;
        Fri, 21 Oct 2022 09:32:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e18so7933057edj.3;
        Fri, 21 Oct 2022 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvGNa8Oxr8KN8bOtj0Kp3l3FSaKDTc45adRz03MofDE=;
        b=JQZamgAXuZ5yvyLJwS/oKN0zgFpRMLAHnD7o4WLop/l+E7vir1lefMexXlndqyuqCj
         +oTbHcCpts573QPDAtWwne8CqCK/JR4e1pEHdXNOE6GgNn66Km7cLwuDKZShTC6MpDaV
         cp/Dt9kK4CIr/mlai9vlBG0YERRlXh1/6QQHv3nnoB3/IGCL/oK7LgNjsbovL1DTvoHJ
         vIGCBXwKAT8ql1eezRebrmN3BnkxyJqNaeM9Q7H3FH/ntHZsbRWRd8nmZvao1bolMVyp
         98VAsD98JWYaImcA/SY66axTH0Nive+TjvKZE/4jtsYWYsJjhvU7021UXDX3quETvGCX
         aetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvGNa8Oxr8KN8bOtj0Kp3l3FSaKDTc45adRz03MofDE=;
        b=JFl5PLaTSyeD68IpZSWZW9/iG5WxAc50IiamcZ5k2M6wFZhcD9FQMUO7Y9NXyjymL8
         W34VE/WmYS15j1ijpDsvQED0QLLSXqAbGjkPPR2NBJZmyZXJNtLOAEq04Q0Lh/0QNVIq
         iwfkbV76/cKvzBVLt0iqTbMI7Yt5MZXydjQy3MpJhFs4tJSayiZ3nerTJ2y0IfVUd83r
         J8rspmEoEpU3idFkYIq2ulzUb5VFJ845JwiKlu1TTBtqwg6ekzCEHryv62zL6LBNOCUQ
         bxBHwDEV5kGdACppOmnDCVOx2ZUhcXNVEjT3K9xuwx5r6PjudmPyHEWQ3sfdP1IL9nqa
         UO0g==
X-Gm-Message-State: ACrzQf2Q9h+AuDAFcf+vH6vQU8F4XSw5Z0KxBnO0gIR95+9iJec196da
        RZ++cbWATtqcfd7ka1TdZtw=
X-Google-Smtp-Source: AMsMyM7r38QCf3+w9CTEjXDaw6GUBuRGHwn5cG55npWLGh0JNw/DDleENGPeE6v5mc9X/HVE1Xvbgw==
X-Received: by 2002:a17:906:fe49:b0:73d:70c5:1a52 with SMTP id wz9-20020a170906fe4900b0073d70c51a52mr16385885ejb.469.1666369943053;
        Fri, 21 Oct 2022 09:32:23 -0700 (PDT)
Received: from krava ([83.240.63.167])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090618a900b0078d85934cf8sm11730873ejf.111.2022.10.21.09.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:32:22 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 21 Oct 2022 18:32:20 +0200
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, dwarves@vger.kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] dwarves: zero-initialize struct cu in cu__new()
 to prevent incorrect BTF types
Message-ID: <Y1LJlPBQauNS/xkX@krava>
References: <1666364523-9648-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666364523-9648-1-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 04:02:03PM +0100, Alan Maguire wrote:
> BTF deduplication was throwing some strange results, where core kernel
> data types were failing to deduplicate due to the return values
> of function type members being void (0) instead of the actual type
> (unsigned int).  An example of this can be seen below, where
> "struct dst_ops" was failing to deduplicate between kernel and
> module:
> 
> struct dst_ops {
>         short unsigned int family;
>         unsigned int gc_thresh;
>         int (*gc)(struct dst_ops *);
>         struct dst_entry * (*check)(struct dst_entry *, __u32);
>         unsigned int (*default_advmss)(const struct dst_entry *);
>         unsigned int (*mtu)(const struct dst_entry *);
> ...
> 
> struct dst_ops___2 {
>         short unsigned int family;
>         unsigned int gc_thresh;
>         int (*gc)(struct dst_ops___2 *);
>         struct dst_entry___2 * (*check)(struct dst_entry___2 *, __u32);
>         void (*default_advmss)(const struct dst_entry___2 *);
>         void (*mtu)(const struct dst_entry___2 *);
> ...
> 
> This was seen with
> 
> bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
> 
> ...which rewrites the return value as 0 (void) when it is marked
> as matching DW_TAG_unspecified_type:
> 
> static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
> {
>        if (tag_type == 0)
>                return 0;
> 
>        if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
>                // No provision for encoding this, turn it into void.
>                return 0;
>        }
> 
>        return type_id_off + tag_type;
> }
> 
> However the odd thing was that on further examination, the unspecified type
> was not being set, so why was this logic being tripped?  Futher debugging
> showed that the encoder->cu->unspecified_type.tag value was garbage, and
> the type id happened to collide with "unsigned int"; as a result we
> were replacing unsigned ints with void return values, and since this
> was being done to function type members in structs, it triggered a
> type mismatch which failed deduplication between kernel and module.
> 
> The fix is simply to calloc() the cu in cu__new() instead.
> 
> Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning routines as void")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

awesome, this fixes the missing dedup I was seeing
with current pahole:

	$ bpftool btf dump file ./vmlinux.test | grep "STRUCT 'task_struct'" | wc -l
	69

with this patch:

	$ bpftool btf dump file ./vmlinux.test | grep "STRUCT 'task_struct'" | wc -l
	1


Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
>  dwarves.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dwarves.c b/dwarves.c
> index fbebc1d..424381d 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -626,7 +626,7 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
>  		   const unsigned char *build_id, int build_id_len,
>  		   const char *filename, bool use_obstack)
>  {
> -	struct cu *cu = malloc(sizeof(*cu) + build_id_len);
> +	struct cu *cu = calloc(1, sizeof(*cu) + build_id_len);
>  
>  	if (cu != NULL) {
>  		uint32_t void_id;
> -- 
> 2.31.1
> 
