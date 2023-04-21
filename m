Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95F86EB32A
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 22:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjDUUzr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 16:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjDUUzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 16:55:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4701FFB
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 13:55:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b50a02bffso2345872b3a.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 13:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682110543; x=1684702543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TEoUvmC7P6gtKUn+6tddEyOtFaXH0h0t30pvu3Cxco4=;
        b=qsDL6teL9u+AJOLLlxAdioFbQIqVG/sfr5FwwUxwMYJtzHOmHvi0JRJP5pa/X1NY2/
         QrAoT+sLfbjmQSKCmuzPlwxYF1wv7sUGG0n3B0BoVmT8uFbxJC3P8hZHrP52r03ojsJ0
         imNl06NisTQ7s6t0qDM/J45GjJxP31aT9770V0yKpFuT4vNYGPSc7AOp8DWWHui1RwP9
         2R37+5rY9bv8hgJhaQBR0oGCOcJLdFom5PvKfV5g+NijN89tVEI5hLWIOaAnOY3R8mvM
         DwEB+KQpDz6hR6G53RLxMqWtdviwJJyrMCjeM65UogNrFkOtANBO2PEoFl+IwVXw0fnm
         Aghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682110543; x=1684702543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEoUvmC7P6gtKUn+6tddEyOtFaXH0h0t30pvu3Cxco4=;
        b=FpideiEuVpjpTh5T5+TbMbW1sC4U/av48Rbervs08z/kkYqcqQpICDRrzkgolcW4x5
         Nb+McmOirYuE1ElGRvNZSWom3wwdgrplT7qKtCCxeCxc3vVNXVP1kjCZT7GHDRz693FY
         twWHooUqXkz0znG5iExIk4pMw4XoVU03Aonyvpj2KCLMq1+jJV55xTxgodMFrsCTrxng
         SJ7jM2OAh2cKHhod4JSpffJKJS/4HWSPUXAlVRFrx/diFiN00p1ifdg1tz21NDYB1EQd
         C572nJK7SIupE/numj7UL0OBbrKL39EZjwCg1clT5uuW3IL0gPLrlbC2tNdafXGK/OaM
         kB3A==
X-Gm-Message-State: AAQBX9f3QChKhW7vD/wb3mfRipP9m3bbnWx4n0dA4jfRZXUu71IVfRzC
        XL3RRjLuo3q82mKNny1h2Q0UwyffnXU=
X-Google-Smtp-Source: AKy350YMDuEXFr8GfO7DJGCr9zLr+RHprCWfjTgID8g6LZDH42g5flPxVVkPGc/FDVGzatfE+SiJvA==
X-Received: by 2002:a05:6a20:12ca:b0:f3:1b6:f468 with SMTP id v10-20020a056a2012ca00b000f301b6f468mr104339pzg.6.1682110543512;
        Fri, 21 Apr 2023 13:55:43 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:ef5e])
        by smtp.gmail.com with ESMTPSA id z10-20020a630a4a000000b0051b93103665sm2942815pgk.63.2023.04.21.13.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 13:55:42 -0700 (PDT)
Date:   Fri, 21 Apr 2023 13:55:40 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daan De Meyer <daan.j.demeyer@gmail.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 03/10] bpf: Allow read access to addr_len
 from cgroup sockaddr programs
Message-ID: <20230421205540.bklwtswdrxybrjsl@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230421162718.440230-1-daan.j.demeyer@gmail.com>
 <20230421162718.440230-4-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421162718.440230-4-daan.j.demeyer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 21, 2023 at 06:27:11PM +0200, Daan De Meyer wrote:
>   *
>   * This function will return %-EPERM if an attached program is found and
> - * returned value != 1 during execution. In all other cases, 0 is returned.
> + * returned value != 1 during execution. In all other cases, the new address
> + * length of the sockaddr is returned.
>   */
>  int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>  				      struct sockaddr *uaddr,
> +				      u32 uaddrlen,
>  				      enum cgroup_bpf_attach_type atype,
>  				      void *t_ctx,
>  				      u32 *flags)
> @@ -1469,9 +1472,11 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>  		.sk = sk,
>  		.uaddr = uaddr,
>  		.t_ctx = t_ctx,
> +		.uaddrlen = uaddrlen,
>  	};
>  	struct sockaddr_storage unspec;
>  	struct cgroup *cgrp;
> +	int ret;
>  
>  	/* Check socket family since not all sockets represent network
>  	 * endpoint (e.g. AF_UNIX).
> @@ -1482,11 +1487,16 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>  	if (!ctx.uaddr) {
>  		memset(&unspec, 0, sizeof(unspec));
>  		ctx.uaddr = (struct sockaddr *)&unspec;
> +		ctx.uaddrlen = sizeof(unspec);
>  	}
>  
>  	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> -	return bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> -				     0, flags);
> +	ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run,
> +				    0, flags);
> +	if (ret)
> +		return ret;
> +
> +	return (int) ctx.uaddrlen;

But that is big behavioral change..
instead of 0 or 1 now it will be sizeof(unspec) or 1?
That will surely break some of the __cgroup_bpf_run_filter_sock_addr callers.
