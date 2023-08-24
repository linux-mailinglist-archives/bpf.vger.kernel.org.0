Return-Path: <bpf+bounces-8475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5850F786FE6
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 15:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AD01C20DF5
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 13:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B2A288FB;
	Thu, 24 Aug 2023 13:07:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91286288E6
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 13:07:34 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8994FCEE
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 06:07:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50043cf2e29so7885326e87.2
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692882451; x=1693487251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cjn54rfabjXUFYpv1kWYH23ENLxk4VM6zeFcKct15Ow=;
        b=DqSJyxP1yz31ihqyTBazxHvTrcUsS0/HfZI5d3xJ9DLSM3ZE8t61eo4Xad80CXbVxj
         sHB/5ugr6/pc/VdWWDU2SUW2DZTb3y/bvz6RIEREQLFDhLzDt3vS7WdstJgG5nS4DwQM
         xJVtxLVHsWTGEjOfNupowVY06D43SQazznBpKQ0eP8orZXJ45E3zZap4dGUkpLYlaVwL
         vUNTqW5T7RtqyDytFCSi/JfcSD+OD8WhHJeDKBfj3HUFZMJQHF4bROIO4Lv37fimnH4/
         EmVckF5nVVujMudWnF/zXhdN2EJYVCbFS+gdx0FyBAdueUWSAvo9ABnQcBvGNwnLZYIL
         zlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692882451; x=1693487251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cjn54rfabjXUFYpv1kWYH23ENLxk4VM6zeFcKct15Ow=;
        b=ftcpmPIl3dwHpMh6Wp3PgaIuC4DCeKBGrJc/Q246Z6hw1p8tBK4tUk6gMZnNjy0fQY
         eFV1fNpbTIEL0atZwGUEBRnGKZib+C/IREzgSCNJbqbSWkpLFmTuYov0lIufaSDBx5P1
         Xz3OFRWefBqfbt5dt7Nm3wz1BKS8ExdK9S++xHz5j035QL+mKz6but9J4XIJ9ChZMwXc
         aM49N3Po6+x7yh8Cy7I5zy9eb/SJAjCgYA3PuhdwZvLtZRlOTJ9f5zEPSdFMRd/cgCgj
         YHMrXKlTLZBZvIHWWTsazf2Yv6s8VMYKgNNz+cNpkeJGrSfYP60hqa+/vUJg4uOsj6HW
         MJDg==
X-Gm-Message-State: AOJu0YxfUyF8Ilr7MnhWh7W1a4KqLVCBJlhlTSfXmbJR+5a96AoLhHaK
	VsO2RVQjRxzcScceOIMejnaZCvw1P4Q=
X-Google-Smtp-Source: AGHT+IFgVeKPRgZqznM+22aViaBMuk35guu4BsKjz4ecQV58zL7MkqWj5lwRgIH7pRq0k8/Rw0ZEYA==
X-Received: by 2002:a05:6512:a8b:b0:4f8:4177:e087 with SMTP id m11-20020a0565120a8b00b004f84177e087mr13103153lfu.47.1692882450265;
        Thu, 24 Aug 2023 06:07:30 -0700 (PDT)
Received: from krava ([83.240.63.172])
        by smtp.gmail.com with ESMTPSA id k25-20020aa7c059000000b0052889d090bfsm10499258edo.79.2023.08.24.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:07:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 24 Aug 2023 15:07:27 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: add uprobe_multi test binary
 to .gitignore
Message-ID: <ZOdWDxavXeJKpmbd@krava>
References: <20230824000016.2658017-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824000016.2658017-1-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 05:00:15PM -0700, Andrii Nakryiko wrote:
> It seems like it was forgotten to add uprobe_multi binary to .gitignore.
> Fix this trivial omission.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/testing/selftests/bpf/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> index 110518ba4804..f1aebabfb017 100644
> --- a/tools/testing/selftests/bpf/.gitignore
> +++ b/tools/testing/selftests/bpf/.gitignore
> @@ -44,6 +44,7 @@ test_cpp
>  /bench
>  /veristat
>  /sign-file
> +/uprobe_multi
>  *.ko
>  *.tmp
>  xskxceiver
> -- 
> 2.34.1
> 
> 

