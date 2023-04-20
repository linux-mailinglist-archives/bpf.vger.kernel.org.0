Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3886E9BCA
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 20:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjDTSif (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 14:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjDTSie (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 14:38:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4DB5BB3
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 11:38:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a66b9bd893so13185595ad.1
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682015893; x=1684607893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WV+WNISnZ9owBs3X7K7q7nVALQDq1bcM5SD5ueSE1IM=;
        b=NoDogJrb0CTtoqon/mG2u1WAKHO7KK9e/BFiUQJw/Kgy5YvyXppjqHfOxpFEJ/SCOX
         g1SgzLdV6oysytLpFQLbDllMTwl0skffggcz3LuyMuQisC+HS1m076YK7Fcm7o9okNtZ
         qeIKJujf6M3t0rPKgGLMJD5sA21Y1ZX+oxBosigERW5/0dFQTDuOfZa+LiuQrc4aIY8Q
         2e+BAqnWVh8E1VUkIYmCBt3GW+jBTjfNuN45H2wqEAUcmAdym+Kfqm0pN02z5flRAD3h
         7vgko+JwjzElMqioL3swSV6NoECQhcvLzFZT75O17B58K/MF0nezrz5ukwtahkImZdvy
         Enyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682015893; x=1684607893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV+WNISnZ9owBs3X7K7q7nVALQDq1bcM5SD5ueSE1IM=;
        b=Hufamjs5XeNG6/XWfJMDh3o5Vtxh2aQFkaJ/SOnQ7RccvIvHOtNdWCY90Us4NMP32V
         spmmvdLa6sjFr/cezWOY+n2t0gAK5nZIWvilFkxeyQlpQ2JH+57pJFNFAjgMbYA1IkgU
         vnjpMmO/EY0VNTnzsOfg3VXedNPr8uRjQLNw/Y8ZuNF3tX7cuTxUiQriW8GzldVCycP/
         ZNDERqbqGlZElxOLGdnLb0Qw6zX//AhlMpeETpdQSjcri670OBzMrgqjjykheX0J1p3y
         SEz97r17p8gCVjrn5tSQD1ON+m8dszSmz8ZNeLHyIC8WfFpwyZunlZsQ2MY5WjkjHMdI
         bMmQ==
X-Gm-Message-State: AAQBX9eal/hzPFcP16sYm/y5gfWO4mXqi/vXCOAO3+m7ZMB1K4epHwU1
        Lwn/FQDEVbuLbVhLiOuN7o4=
X-Google-Smtp-Source: AKy350ZapBFmzmnPNwG5FyQdfyznILQMd92q1DyQceN1rBwLTn+6z2+s4tolUqQr4kACmzXmgKILVw==
X-Received: by 2002:a17:902:d503:b0:1a6:ed6f:d6b7 with SMTP id b3-20020a170902d50300b001a6ed6fd6b7mr2965058plg.5.1682015892930;
        Thu, 20 Apr 2023 11:38:12 -0700 (PDT)
Received: from MacBook-Pro-6.local ([2620:10d:c090:500::5:cf1d])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b00192aa53a7d5sm1470408pln.8.2023.04.20.11.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 11:38:12 -0700 (PDT)
Date:   Thu, 20 Apr 2023 11:38:09 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Add bpf_dynptr_adjust
Message-ID: <20230420183809.hgzvfn627vc3zro4@MacBook-Pro-6.local>
References: <20230420071414.570108-1-joannelkoong@gmail.com>
 <20230420071414.570108-2-joannelkoong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420071414.570108-2-joannelkoong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 20, 2023 at 12:14:10AM -0700, Joanne Koong wrote:
>  	return obj;
> @@ -2369,6 +2394,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_dynptr_adjust)

I've missed this earlier.
Shouldn't we change all the existing dynptr kfuncs to be KF_TRUSTED_ARGS?
Otherwise when people start passing bpf_dynptr-s from kernel code
(like fuse-bpf is planning to do)
the bpf prog might get vanilla ptr_to_btf_id to bpf_dynptr_kern.
It's probably not possible right now, so not a high-pri issue, but still.
Or something in the verifier makes sure that dynptr-s are all trusted?
