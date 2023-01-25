Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC867B763
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 17:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjAYQxr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 11:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAYQxp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 11:53:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F218972BF
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 08:53:44 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h16so17679552wrz.12
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 08:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WlQUfDinkM8cIY+p9VLBKqc7J5pyv5xcvqS0YrIgVGs=;
        b=V7EX6+3wf/riQWKx7Fgn8oPs1tyZdQGE0cCOfdHMoyAOlvrWoxgNthrrKtHCtGPtN3
         ZYMuAJ28jbLGTNM2tCRkDThquzRqTeKZefYrUcM3DzTqD6zBc6yNfmibQ1PhPIZNQcxf
         /ElCb4oCwQcQ7Yk2bgIybade1/JOsH67XFcT7CuHSkHw0gCbLyRadcMxB5ieboKXV4Hs
         sbNz3xyUdQxyLpmns6GvdJgPLayft9rhYMUJyfRsbJsaeYxKChwxyGPZPdltmswzlr/8
         HWMfrU9zx6SaCKWLgmtPPnF7qxwdCPMi1PbjdCwHi1cRoT6GuRql7x7X4xqYxelhh1eB
         pjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlQUfDinkM8cIY+p9VLBKqc7J5pyv5xcvqS0YrIgVGs=;
        b=ugJAa/GiADOnZDj2N3LifODT+DcyS655gMt0l1F2PGPW5dc5bPhmtqJc93/7rFZFRG
         JNaqoJgOPxjcn6XVn/The0rDO5CCBBVX/If9WSh7Og0Tb60663sCqwiItQMqfYumqun8
         foz3/8EvRuvtMhr70lWfTBCFce3oUzYrSLpSEWHS0O0onW4h0BoFh+FZik7cEa4o/xE0
         xMjzsGCS/A1AHo9gJLzkn6KKiW+19Wxr8+pAJzO31AIUppkVw6iwYZx1MxMAYGQVsNQi
         gz4QyGvBX1O/GwDQDFkdP5uLB+6DzZguoiXSi6wdkdPvBi4GSbNi3sqaoOQzNFxZDE9N
         ThNw==
X-Gm-Message-State: AFqh2krhZMgCSaWDPz/+KyVJurMqMQq1q4NNWeqwGZRN/X4GQPWHL7ib
        Iec6OEssWu/o/eeQOWVblm6+v01B6svwcg==
X-Google-Smtp-Source: AMrXdXui0Q0vT8z/qvh7WMURr5vSrIN1cJ2rknXx8Flj6LftsWAuUlnI6QebDjS9U4cBgGGjeQ6QYg==
X-Received: by 2002:a5d:6f1c:0:b0:2be:103a:c825 with SMTP id ay28-20020a5d6f1c000000b002be103ac825mr32028636wrb.18.1674665623424;
        Wed, 25 Jan 2023 08:53:43 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id d24-20020a05600c4c1800b003db0cab0844sm2225639wmp.40.2023.01.25.08.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:53:43 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 25 Jan 2023 17:53:41 +0100
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     acme@kernel.org, yhs@fb.com, ast@kernel.org, olsajiri@gmail.com,
        timo@incline.eu, daniel@iogearbox.net, andrii@kernel.org,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
Message-ID: <Y9FelQQMDdVgTsfu@krava>
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-2-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674567931-26458-2-git-send-email-alan.maguire@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 01:45:27PM +0000, Alan Maguire wrote:

SNIP

>  
>  	return parm;
> @@ -1450,7 +1504,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
>  					     struct cu *cu, struct conf_load *conf,
>  					     int param_idx)
>  {
> -	struct parameter *parm = parameter__new(die, cu, conf);
> +	struct parameter *parm = parameter__new(die, cu, conf, param_idx);
>  
>  	if (parm == NULL)
>  		return NULL;
> @@ -2209,6 +2263,10 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
>  			}
>  			pos->name = tag__parameter(dtype->tag)->name;
>  			pos->tag.type = dtype->tag->type;
> +			if (pos->optimized) {
> +				tag__parameter(dtype->tag)->optimized = pos->optimized;
> +				type->optimized_parms = 1;
> +			}
>  			continue;
>  		}
>  
> @@ -2219,6 +2277,20 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
>  		}
>  		pos->tag.type = dtype->small_id;
>  	}
> +	/* if parameters were optimized out, set flag for the ftype this
> +	 * function tag referred to via abstract origin.
> +	 */
> +	if (type->optimized_parms) {
> +		struct dwarf_tag *dtype = type->tag.priv;
> +		struct dwarf_tag *dftype;
> +
> +		dftype = dwarf_cu__find_tag_by_ref(dcu, &dtype->abstract_origin);
> +		if (dftype && dftype->tag) {
> +			struct ftype *ftype = tag__ftype(dftype->tag);
> +
> +			ftype->optimized_parms = 1;

nit, could be:
   tag__ftype(dftype->tag)->optimized_parms = 1; 

as you did above

jirka

> +		}
> +	}
>  }
