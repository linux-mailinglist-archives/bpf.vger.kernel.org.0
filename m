Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA365619AF4
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 16:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiKDPF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 11:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiKDPF5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 11:05:57 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7AE5FF9;
        Fri,  4 Nov 2022 08:05:56 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id h21so3190135qtu.2;
        Fri, 04 Nov 2022 08:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKspryUXShYNSbZd0Tz6f9AJ4x/r0hDiiq5i0wx1tkE=;
        b=vvwyL5kqEMsudbviKymiA3miQyxehN13cp9Xpxl9pgxGxIguDTHil39icgzE3YVVeO
         RPUEx2XpLMxxUb4mWKJjFMj+JbWGFoZKEHmAXVLvrAxUoAlKq1N2+TttvJhEt6IUgwAC
         RRc8h8Ck8nVLJeD4mruXF7yAGaMGW8UAKviIM4sRWUOh6URC1JZ28nyTtf1lntjfw1WU
         iDxp4/Yp4A00jBmx4FAsT0idMSdCGjogq8EfT3PfNNevPpwebgagZqfJwuWGd12svm7o
         iVVMcnCbbr7M0072iRy8B/8Yl6oD32/5Yevc5QOL24vbFvY1vs5yx/wDv3l0VFe6y8hC
         JRZg==
X-Gm-Message-State: ACrzQf2TrKs24sbocozDl/ZR8wPjAHH6NcrQQjF07Y8NolOWlWws/i2g
        xSFcBT3ZMVu7xOgArqfayII=
X-Google-Smtp-Source: AMsMyM6BIFnDSMdh6LUJTGNjtmJjhjrS7sHuzgQ0G1FxEQAM3deBBTiVZg5tXpubcD2GkXNTb5Yd3w==
X-Received: by 2002:ac8:7d42:0:b0:3a5:66a9:2fe4 with SMTP id h2-20020ac87d42000000b003a566a92fe4mr2810851qtb.689.1667574355684;
        Fri, 04 Nov 2022 08:05:55 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::b27e])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a248600b006a6ebde4799sm3062419qkn.90.2022.11.04.08.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 08:05:55 -0700 (PDT)
Date:   Fri, 4 Nov 2022 10:05:54 -0500
From:   David Vernet <void@manifault.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next] Documentation: bpf: escape underscore in BPF
 type name prefix
Message-ID: <Y2UqUqrqVbPqueZ/@maniforge.dhcp.thefacebook.com>
References: <20221104123913.50610-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104123913.50610-1-bagasdotme@gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 04, 2022 at 07:39:14PM +0700, Bagas Sanjaya wrote:
> Sphinx reported unknown target warning:
> 
> Documentation/bpf/bpf_design_QA.rst:329: WARNING: Unknown target name: "bpf".
> 
> The warning is caused by BPF type name prefix ("bpf_") which is written
> without escaping the trailing underscore.
> 
> Escape the underscore to fix the warning. While at it, wrap the
> containing paragraph in less than 80 characters.
> 
> Fixes: 9805af8d8a5b17 ("bpf: Document UAPI details for special BPF types")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: David Vernet <void@manifault.com>
