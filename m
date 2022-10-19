Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF9C604DFD
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 19:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiJSRAG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 13:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJSRAF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 13:00:05 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308871413B0
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 09:59:56 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id mg6so11773840qvb.10
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 09:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHE5X2/nIKGSceVvhngU214WQSg/9ITB7ku5N3O7xf8=;
        b=ARpD3QM9cOR/fp8bEOKxABRu9mQM/pe7+8eQ1XLWxMhE/9aME5AZj5sKT8HniYT9Bq
         CoXJ314Pfzm297XqPmxrhhXGAfopqHs+lw1UAZK38a+/IzEGja7yDLFV7k9sq1KQ/hKt
         HiadStSEHrOOM/3tfSytNDOAjM/zN0BZLVNCLT5AlxaFCNUViskCIoI2hMWuuTm8G1jS
         TIaMQoa/xdKSwITXEVWkAaPpu3itlcrFYEkvgpEiSNrQUfHBB5rOc2L/O5GdgopRwBxk
         LkWV9Bsg445ZOgk9fT4jmAm/I+/0suaZMQpgNiQLAZcIigt6FSvo25BA9rdbj/66EXNz
         tD7Q==
X-Gm-Message-State: ACrzQf3LfcbD+GMOYiEaCiKZ31e9UqmrJbMNYzqPEhj2bBWKPXN9FWr+
        a0BTtuxrwLscNDDTdkyhww9TGGVSMhQ=
X-Google-Smtp-Source: AMsMyM7ifudgKtnekFJ56c6qOTOyaq7FykdIDLoMwbksSG7o4wb2KJadgCvmhrg5XrELzM7s3l51pw==
X-Received: by 2002:a05:6214:c4e:b0:4b1:aa37:f4c1 with SMTP id r14-20020a0562140c4e00b004b1aa37f4c1mr7556936qvj.107.1666198788243;
        Wed, 19 Oct 2022 09:59:48 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::e12b])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006bb29d932e1sm5218526qkb.105.2022.10.19.09.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 09:59:47 -0700 (PDT)
Date:   Wed, 19 Oct 2022 11:59:49 -0500
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/13] selftests/bpf: Add test for dynptr
 reinit in user_ringbuf callback
Message-ID: <Y1AtBSPjy2Sp/C9b@maniforge.dhcp.thefacebook.com>
References: <20221018135920.726360-1-memxor@gmail.com>
 <20221018135920.726360-10-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018135920.726360-10-memxor@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 07:29:16PM +0530, Kumar Kartikeya Dwivedi wrote:
> The original support for bpf_user_ringbuf_drain callbacks simply
> short-circuited checks for the dynptr state, allowing users to pass
> PTR_TO_DYNPTR (now CONST_PTR_TO_DYNPTR) to helpers that initialize a
> dynptr. This bug would have also surfaced with other dynptr helpers in
> the future that changed dynptr view or modified it in some way.
> 
> Include test cases for all cases, i.e. both bpf_dynptr_from_mem and
> bpf_ringbuf_reserve_dynptr, and ensure verifier rejects both of them.
> Without the fix, both of these programs load and pass verification.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

LGTM

Acked-by: David Vernet <void@manifault.com>
