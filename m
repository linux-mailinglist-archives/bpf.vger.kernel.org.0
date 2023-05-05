Return-Path: <bpf+bounces-76-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4E46F7ACF
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 04:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F37280F2D
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 02:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5111376;
	Fri,  5 May 2023 02:17:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16027E
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 02:17:12 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B7CAD29
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 19:17:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ab01bf474aso8865875ad.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683253031; x=1685845031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdjQk63bsT7mrU/s3aQYdftjqTnzo/MG+xXYEVsna0k=;
        b=cNuZBwkK4yXW8K27cGJ9GnVjFtsW/hFT/cg8OBlmMmdRkpPVstXFh7Wywu0GgnT3On
         PTNPZQhM9NMVxIMiCxjvv/PQs+kApBhlaYz6YkJAnOHoz4lxCMTCSKHXWstxJc9xrDEB
         hS1eaiTSE2MZHSaY+2UyhVcENTX4wuTB/qPWsz5m1zr3dYYZKliX0imz5PxfVcfjCcMx
         76+MQ0K2q47aaeqXDBKWrI7H1Gz+gR6sMPk2Z9eTacDTOXpDUwy+sF7m99hvFw1f/0e4
         VPWszEcd+WsA1RxXNiP0X4i0+sMT/7SEUlppcVHUITeI4o78MzTYlchCeoYshWk+lhrk
         2NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683253031; x=1685845031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdjQk63bsT7mrU/s3aQYdftjqTnzo/MG+xXYEVsna0k=;
        b=CNzVar/ABZHHMQvJJO4KL4Ky8wnmlE7akynuPRCVqorNim1/1d1vXoS4SEPEuIKFYH
         n/JIEijauQ06Reo2mJeO+LMy7emD+YRDo8Fi3J/ny4LGw1LL1qvK2HTcYM5x0+PC2esH
         5NYQACB6LqvAw64s5LIG+UBD0EdZhD3v0HkriksT1pE/IoA+WLCOuRONsgcS3qoFT16l
         F4gu74C8uCM51Fpo+7nXjKzCVpKl8f+RNJbukaaRyY/p7QXcSrSe58bdeD9U4NTCuf5y
         BOLrAkUeBCdM+V2rQfQnUgZ5HA2x/sjVZKdWzqkF/xphnuKYnjB0HwzQNaRr8ycUMRFZ
         wYaQ==
X-Gm-Message-State: AC+VfDzY9A7kHGltCk+zkEKk1741iJc0zd3piAna+YBkQd9LYNXSWLDU
	swTE8iDYLskRHATdPTiSFSE=
X-Google-Smtp-Source: ACHHUZ4vFfCm0iPSjESO2Sg7uKGvao/FXqlZd4Lny4RiG6zI6ugGgYvIghhDZLt+JZ2KSfbUxNWYZw==
X-Received: by 2002:a17:902:b106:b0:1ab:68b:cafe with SMTP id q6-20020a170902b10600b001ab068bcafemr5840156plr.27.1683253030571;
        Thu, 04 May 2023 19:17:10 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:cce7])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a195300b0023a84911df2sm12122141pjh.7.2023.05.04.19.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 19:17:10 -0700 (PDT)
Date: Thu, 4 May 2023 19:17:07 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v1 bpf-next 6/9] bpf: Make bpf_refcount_acquire fallible
 for non-owning refs
Message-ID: <20230505021707.vlyiwy57vwxglbka@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230504053338.1778690-1-davemarchevsky@fb.com>
 <20230504053338.1778690-7-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504053338.1778690-7-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 03, 2023 at 10:33:35PM -0700, Dave Marchevsky wrote:
> @@ -298,8 +298,11 @@ struct bpf_kfunc_call_arg_meta {
>  	} arg_constant;
>  	union {
>  		struct btf_and_id arg_obj_drop;
> -		struct btf_and_id arg_refcount_acquire;
>  		struct btf_and_id arg_graph_node;
> +		struct {
> +			struct btf_and_id btf_and_id;
> +			bool owning_ref;
> +		} arg_refcount_acquire;
...
>  
> -			meta->arg_refcount_acquire.btf = reg->btf;
> -			meta->arg_refcount_acquire.btf_id = reg->btf_id;
> +			meta->arg_refcount_acquire.btf_and_id.btf = reg->btf;
> +			meta->arg_refcount_acquire.btf_and_id.btf_id = reg->btf_id;

I wasn't excited about patch 2, but this one is taking it too far.
Let's just get rid of this union and struct btf_and_id and all arg*.
Just add
 struct btf *arg_btf;
 u32 arg_btf_id;
 bool arg_owning_ref;
to bpf_kfunc_call_arg_meta and use them in all cases.
arg_refcount_acquire vs arg_graph_node difference doesn't give us readability or bug-proofing.

