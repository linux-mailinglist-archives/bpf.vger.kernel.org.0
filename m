Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F53A64865E
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 17:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLIQPA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 11:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLIQOi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 11:14:38 -0500
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BE326AA2;
        Fri,  9 Dec 2022 08:14:37 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-381662c78a9so58384907b3.7;
        Fri, 09 Dec 2022 08:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2qId5xhvUo4Pl0t4FuJRG6nKhrNrqhzhcDasrr5b8g=;
        b=Eh6kWAW3WPRiHSavpa5GV/wIM6Od+Owf4zJYR02MNkfY+D7bbP9BE5uCIClSvMDfQl
         sBdg1uLRZhQmnqiMXv/oDitbjE56MnxgbGcwcAapa2seohnx+yuYSpuRRt4zQGOqsG8x
         PSWtKX8Yxc6HEXPOid6E7qkgMXu/oKqLIuIQ1QnIjN6x9SuPMye5HN5CPBv7hT0TpOuy
         EKY+KyOzLo8UKUu/YKdklcG2kzs0c12AHHFiHlD123SdjL/P2elvXL8xwIgovVqNAw6L
         Rs9/qcV8UrFiInhw+tZ9LQBO5KCLv1f+oyYFx50vUaMFK8eeQxpOGSZs84pJkqaTgPWK
         ecnw==
X-Gm-Message-State: ANoB5pmd+bKPKcaCwlBUQxYyc5cf+tWa3OMCLu7JZsTdjTWZQkO1hGnz
        QWF16EfBz3sp4qy0PA7+hRs=
X-Google-Smtp-Source: AA0mqf7UAzjZVBdSASqXI/YgrB/DuQZC33wUbPvFiInD7u7DL/upFOtLPKSzipZEQTiqIp2qLHBKGg==
X-Received: by 2002:a05:7500:1447:b0:eb:4b0:19ab with SMTP id q7-20020a057500144700b000eb04b019abmr580376gab.50.1670602476570;
        Fri, 09 Dec 2022 08:14:36 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:c9a7])
        by smtp.gmail.com with ESMTPSA id v25-20020a05620a0a9900b006f9f714cb6asm131617qkg.50.2022.12.09.08.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:14:36 -0800 (PST)
Date:   Fri, 9 Dec 2022 10:14:33 -0600
From:   David Vernet <void@manifault.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Yonghong Song <yhs@meta.com>
Subject: Re: [PATCH bpf-next v4] docs/bpf: Add documentation for
 BPF_MAP_TYPE_SK_STORAGE
Message-ID: <Y5Ne6eMENWY+6br5@maniforge.lan>
References: <20221209112401.69319-1-donald.hunter@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209112401.69319-1-donald.hunter@gmail.com>
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

On Fri, Dec 09, 2022 at 11:24:01AM +0000, Donald Hunter wrote:
> Add documentation for the BPF_MAP_TYPE_SK_STORAGE including
> kernel version introduced, usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Looks great, thanks Donald!

Acked-by: David Vernet <void@manifault.com>
