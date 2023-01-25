Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A0467B761
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjAYQxi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAYQxh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:53:37 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2731572BF
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 08:53:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso1764409wms.3
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 08:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FOf8KwWlc50nQkXWbdR1sZpwURnClINhhC+LrYeVCjg=;
        b=ACJzBGufV5RPGeqM4T2BsSpFeaAx9KsaKEUv2ziqgq0tEnAiSK5N2kxMridRxEXQCG
         0VqiAEIIUogFDqUk1iYV04HDWCTzSgzOO0v1X8Y5UF/hWc+k8SNj7SgkMaqGbePIJHaT
         9PwNP3scXTtt4RbWT6Fb3qdOuNNrD4VCzqzFKCCte+U8VDUyQxOU7Q5iLwwxcGr7U7B4
         55L+u1rQqNAO2ToKsAceSIX7UoDf3fOagxOgXzl9mMK7BLsC6v2XxbKUX+/S4baDLQxG
         /rHb9g1s6q9tgliA46V4sMw0+YGkQsTrosMAizZFeDm2mPUv+Din0OsgpkNrBdlNeYaG
         9y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOf8KwWlc50nQkXWbdR1sZpwURnClINhhC+LrYeVCjg=;
        b=KCjlepcaUGetnP4udYwBNAWwQebIuHPbIJwZOqyoKygD+N9k41fJbzL0mA7eUgPQE0
         NBaYDm2fSeJ3aCBHP8Kj7n4DoiuUiqGB47Ld28qyp5o5gja/Uq5IOdV1re22+rMzz0Ni
         fTlkmXbnLHMro9v+3HRkVCyITSGfU5FoiPcyGCXMRWeESmAq6C1ag8yT+8vZnfId5PEc
         lMZhwcs5hhtflmCQTX7t7/woTQOB/ioKhaAs/bY7l3ojpgQMzYpOvouVAcUge/JRSq2E
         CwEw49rRS27yF/ij0gvvkbKC+kkdZVPldYJD4BNmNWW+xD93HEmuHgGS58Z5qdAvvEcP
         Q7sg==
X-Gm-Message-State: AFqh2kqtGPAcSdvUWRBXQhhkhtUlvmVVJ3QaRlPlpx5uAlmTXZraHj/b
        /8BH3L9dMg+QZ7jdz0oak04=
X-Google-Smtp-Source: AMrXdXs0STOd3MfHvLh6UMmyaN3RptAcFDVGNOmm8v8KqlcBBfHhQu+wAx5WHV55JD2lZGSUVNZeNQ==
X-Received: by 2002:a05:600c:3ba5:b0:3da:ff66:e3cc with SMTP id n37-20020a05600c3ba500b003daff66e3ccmr31119203wms.21.1674665614519;
        Wed, 25 Jan 2023 08:53:34 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c358900b003dc1f466a25sm1973145wmq.25.2023.01.25.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:53:34 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 25 Jan 2023 17:53:31 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        timo@incline.eu, daniel@iogearbox.net, andrii@kernel.org,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 5/5] btf_encoder: skip BTF encoding of static
 functions with inconsistent prototypes
Message-ID: <Y9Fei36sE/59xbVn@krava>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-6-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674567931-26458-6-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 01:45:31PM +0000, Alan Maguire wrote:

SNIP

>  	} else {
>  		struct btf_encoder_state *state = zalloc(sizeof(*state));
>  
> @@ -898,10 +954,12 @@ static void btf_encoder__add_saved_func(const void *nodep, const VISIT which,
>  	/* we can safely free encoder state since we visit each node once */
>  	free(fn->priv);
>  	fn->priv = NULL;
> -	if (fn->proto.optimized_parms) {
> +	if (fn->proto.optimized_parms || fn->proto.inconsistent_proto) {
>  		if (encoder->verbose)
> -			printf("skipping addition of '%s' due to optimized-out parameters\n",
> -			       function__name(fn));
> +			printf("skipping addition of '%s' due to %s\n",
> +			       function__name(fn),
> +			       fn->proto.optimized_parms ? "optimized-out parameters" :
> +							   "multiple inconsistent function prototypes");
>  	} else {
>  		btf_encoder__add_func(encoder, fn);
>  	}
> @@ -1775,6 +1833,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  		 */
>  		if (fn->declaration)
>  			continue;
> +		if (!fn->external)
> +			save = true;

how about conflicts between static and global functions,
I can see still few cases like:

  void __init msg_init(void)
  static void msg_init(struct spi_message *m, struct spi_transfer *x,
                       u8 *addr, size_t count, char *tx, char *rx)

  static inline void free_pgtable_page(u64 *pt)
  void free_pgtable_page(void *vaddr)

  STATIC inline long INIT parse_header(u8 *input, long *skip, long in_len)
  static struct tb_cfg_result parse_header(const struct ctl_pkg *pkg, u32 len,
                                         enum tb_cfg_pkg_type type, u64 route)
  static void __init parse_header(char *s)


could we enable the check/save globaly?

jirka

>  		if (!ftype__has_arg_names(&fn->proto))
>  			continue;
>  		if (encoder->functions.cnt) {
> @@ -1790,7 +1850,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  			if (func) {
>  				if (func->generated)
>  					continue;
> -				func->generated = true;
> +				if (!save)
> +					func->generated = true;
>  			} else if (encoder->functions.suffix_cnt) {
>  				/* falling back to name.isra.0 match if no exact
>  				 * match is found; only bother if we found any
> diff --git a/dwarves.h b/dwarves.h
> index 1ad1b3b..9b80262 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -830,6 +830,7 @@ struct ftype {
>  	uint16_t	 nr_parms;
>  	uint8_t		 unspec_parms:1; /* just one bit is needed */
>  	uint8_t		 optimized_parms:1;
> +	uint8_t		 inconsistent_proto:1;
>  };
>  
>  static inline struct ftype *tag__ftype(const struct tag *tag)
> -- 
> 1.8.3.1
> 
