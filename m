Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AD5618E9C
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 04:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKDDQb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 23:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDDQ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 23:16:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A78820186
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 20:16:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so3559416pjl.3
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 20:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=73DpOygwqROboGZAzCEuDXOOiYvXH6dIRTXXA+Wyidw=;
        b=OyF9tIlJ2tk0hSrXjMIpUBWOHClKOmpJOhGko6n2Udj8HG9wvr7cjD2J8EtAIOWZUC
         iAr++A+KePeROumVy2aRZ17tu4MjIy8CnJs3yF37SXQ6U0YQcCASjzCXB12Yay4JPqNc
         YMfYMnFbiNytc6RbONJzsaSN0XcGlJNjLTlNx/QgADniQdjnSWvlYCXl9z/xB5UGu26e
         +K1Rf5xwtVgX8HLkYjLHkgAB97S+WNh3MpAYZu+1SFKBdpii7WJrjzSbIIeHUOXpD3Jb
         MfvpmefeFrzLfIO2fNXJP83Jb3SZLfnM7fwd7BkLoy166ZUuf+wPNN6wGpmanPDtipp8
         WUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73DpOygwqROboGZAzCEuDXOOiYvXH6dIRTXXA+Wyidw=;
        b=O8mk2c2YwuqRHzy1UTuYygyIbeP57MIDGMiGMstVTQ/pAWrtwLsLa7Zan6mjhq7FP0
         afCUeQI3UQmcApGtzZFcZi5oIveEqkEwssez07u9xEKmXj249csFM3c/m6Al7F434ImJ
         V5Y/6YB9nsXurUbZploVZ9Q0ko51mJQNc/57ZZuNyxvDlIigWHrJie8SwFnPWXrSNc1v
         aOMQOBDrG+f77wrlWeplhUOIl6Le86LXCP1oi+qWEl8P1erXn1wEvvkaTzoduhvFjWbU
         oaS6ci0e5gK4g4/nzKPH9SSKt2QGdA5T/TYvfslNelDcQxmdMIYek28apGj/LWUv14iS
         +f/A==
X-Gm-Message-State: ACrzQf2xEZldZTPNTYbVkwV+K5Tv2JtHTBJeeD42wOe0Vx530kFtPM/a
        4rzrGqTRauHzUUh3ykikxOU=
X-Google-Smtp-Source: AMsMyM53FqlwBfH4M+vIFwjOxwJ0BHYjePzId05spH3xaPg25Mirys91stj7MdndcYfkQ8tw3AFFdA==
X-Received: by 2002:a17:902:f643:b0:185:50e4:f55e with SMTP id m3-20020a170902f64300b0018550e4f55emr33421615plg.156.1667531788605;
        Thu, 03 Nov 2022 20:16:28 -0700 (PDT)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:2035])
        by smtp.gmail.com with ESMTPSA id l36-20020a635724000000b0045dc85c4a5fsm1451893pgb.44.2022.11.03.20.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:16:28 -0700 (PDT)
Date:   Thu, 3 Nov 2022 20:16:25 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: Re: [PATCH bpf-next v4 06/24] bpf: Refactor kptr_off_tab into
 btf_record
Message-ID: <20221104031625.inxdktu6ztbpz4mk@macbook-pro-5.dhcp.thefacebook.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-7-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103191013.1236066-7-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 12:39:55AM +0530, Kumar Kartikeya Dwivedi wrote:
> -
> -	for (i = 0; i < nr_off; i++) {
> +	rec->cnt = 0;
> +	for (i = 0; i < cnt; i++) {
>  		const struct btf_type *t;
>  		s32 id;
>  
> @@ -3500,28 +3499,24 @@ struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
>  				ret = -EINVAL;
>  				goto end_mod;
>  			}
> -			tab->off[i].kptr.dtor = (void *)addr;
> +			rec->fields[i].kptr.dtor = (void *)addr;
>  		}
>  
> -		tab->off[i].offset = info_arr[i].off;
> -		tab->off[i].type = info_arr[i].type;
> -		tab->off[i].kptr.btf_id = id;
> -		tab->off[i].kptr.btf = kernel_btf;
> -		tab->off[i].kptr.module = mod;
> +		rec->fields[i].offset = info_arr[i].off;
> +		rec->fields[i].type = info_arr[i].type;
> +		rec->fields[i].kptr.btf_id = id;
> +		rec->fields[i].kptr.btf = kernel_btf;
> +		rec->fields[i].kptr.module = mod;
> +		rec->cnt++;
>  	}
> -	tab->nr_off = nr_off;
> -	return tab;
> +	rec->cnt = cnt;
> +	return rec;

This is weird. You also undo this assignment in the next patch.
What is the point of rec->cnt = 0;
followed by rec->cnt++
just to be overwritten with rec->cnt = cnt;
??
