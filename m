Return-Path: <bpf+bounces-11662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEE77BCF67
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 19:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12732816BC
	for <lists+bpf@lfdr.de>; Sun,  8 Oct 2023 17:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CD2171C5;
	Sun,  8 Oct 2023 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLWpFHZG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA02584;
	Sun,  8 Oct 2023 17:27:47 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D78A6;
	Sun,  8 Oct 2023 10:27:46 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-578d791dd91so2746068a12.0;
        Sun, 08 Oct 2023 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696786066; x=1697390866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZGLXpSeHTyTN+UoEg8u0H22R2bS1dweVih/YvudmVs=;
        b=SLWpFHZGCOU4A43wLyELjruJHYxA6Gn1EKKBJ9QXNOws15Bedg3crD94hxWkxOBXR5
         R5RBukteq165wfPsTMd5B4WHHWnzNEaKn2hVLZw42uAm0F/C2IJ8hZgPJtuIRz5KRlS2
         mtKHVGkb6FqAMekiLpAmvkiqGKsjB3ORov4Qf7Q62TbIByJBBgVqlhzmqSLtTeia/w6Z
         ju33WaRjFq849j4yS6R6xVzEdNRwfGHSfciLB/GDGj25aA7yQKqFlH/EBZWf0RUc698c
         CxkvHSZhISsw3hHsSA/TvbrMM6eA3vBVZ8QZsnvLWO6O4ENeiyL+LEbQuQEdfMfBrzXn
         7ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696786066; x=1697390866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZGLXpSeHTyTN+UoEg8u0H22R2bS1dweVih/YvudmVs=;
        b=COh52qxYlSduL4HckPYou5SASGuo7pAoBOuq+gjPmU9DQ5AhZ5BVbf3s7TgOoj65UM
         WuqZ2vjZtck/GfENTsJ816GL66eVnlnYvIA545GAYFHHfKVWW00AzyNLkGO/HBJUOFF4
         wL8FMy+P8HRI2KHW7LUU9xLDLz7UJ1M/iAeB2lHIPV5LPw5Uvp+MmMQd2ys3FQN+c4Xu
         Td0E0N8K/MseNeL2CQX691ZKkohzYwc4kJ41jOO/HkFhZ6SLF36AHzSc9JCjQZdtpcqG
         MIYwtBza6YjYg3r3jLpYLBhg3bQbeiCg26yCgfqb6ACkEy3cQBb0QR+ZcNcvVKU0SBx5
         +F3Q==
X-Gm-Message-State: AOJu0YxudVwGm5couB1CMfdFCOwCB7A3ATwIVLh47iYerkZX0mLGDEty
	FmYWpjfEmUNA/e87+gSUkpk=
X-Google-Smtp-Source: AGHT+IEQ2vz0NYz8fDEodyJttxl3/XTmHdiCyCSNVeF+0ore8SauGpgWFosQcvm1JisLYQCaCZMSYg==
X-Received: by 2002:a17:90b:3b43:b0:26b:374f:97c2 with SMTP id ot3-20020a17090b3b4300b0026b374f97c2mr17108180pjb.6.1696786066166;
        Sun, 08 Oct 2023 10:27:46 -0700 (PDT)
Received: from localhost ([2601:647:5b81:12a0:a3e9:5a65:be6:12db])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090a520500b002749a99318csm6762867pjh.26.2023.10.08.10.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 10:27:45 -0700 (PDT)
Date: Sun, 8 Oct 2023 10:27:44 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
	jhs@mojatatu.com, victor@mojatatu.com, martin.lau@linux.dev,
	dxu@dxuuu.xyz
Subject: Re: [PATCH net-next 1/2] net, tc: Make tc-related drop reason more
 flexible
Message-ID: <ZSLmkPxB9mHBT52v@pop-os.localdomain>
References: <20231006190956.18810-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006190956.18810-1-daniel@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 09:09:55PM +0200, Daniel Borkmann wrote:
> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index c7318c73cfd6..90774cb2ac03 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -324,7 +324,6 @@ struct Qdisc_ops {
>  	struct module		*owner;
>  };
>  
> -
>  struct tcf_result {
>  	union {
>  		struct {
> @@ -332,8 +331,8 @@ struct tcf_result {
>  			u32		classid;
>  		};
>  		const struct tcf_proto *goto_tp;
> -
>  	};
> +	enum skb_drop_reason		drop_reason;
>  };
>  
>  struct tcf_chain;
> @@ -667,6 +666,12 @@ static inline int tc_classid_to_hwtc(struct net_device *dev, u32 classid)
>  	return (hwtc < netdev_get_num_tc(dev)) ? hwtc : -EINVAL;
>  }
>  
> +static inline void tc_set_drop_reason(struct tcf_result *res,
> +				      enum skb_drop_reason reason)
> +{
> +	res->drop_reason = reason;
> +}
> +

Since this helper is for TC filters and actions, include/net/pkt_cls.h
is a better place for it?


