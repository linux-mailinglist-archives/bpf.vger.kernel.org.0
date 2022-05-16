Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48380528DA1
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 21:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiEPTDi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345238AbiEPTDh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 15:03:37 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED283EB82
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 12:03:35 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id a22so12993035qkl.5
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 12:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AIe3Hue2RANUPAWEczFREd5rggugmUC+di4V2hUv/Bs=;
        b=hjfcDrmNXCSTA8i5MIK2hxLZfhqUmKXdNgyEKMkVgJaNil1fH+3h2SXOBqCah4/KRO
         1soFoEGN0QXErdLI021Vy/c+rrylNcSsLifwrW09BR2028xr/NC4gQ7w4FeIeYH5kduS
         ltOhtzF4hjoGGa/ZEhUHqXkw1fm/ElUmf0RjLVbNsNGEyzm0TQR+uLWU9kmQHVWrGw/Z
         L6wQTlu2JOsD5f5FLlBkRkp+9lJ+mzIDPI1aqQtG9Mqz+epxwB0vIfJhLXx0OXjMEBOG
         AyDRuiT7VIRPrhzphHF365B0ET5a/JiyH4Ij5gYCfdqGt4yArLejcQjrWBsEGbo63tSd
         OlAw==
X-Gm-Message-State: AOAM531fugUxXX5axbmTiGQoJnhCZXlZUP7DlAo7W8h1Ff6QqgmFDnai
        AmM2f3EWwlL5KlMaY8dpZGd3vtsqgxI=
X-Google-Smtp-Source: ABdhPJwccKJDQPoMkZzJmSeOJeGqFbUDTAcphX/+44z3XYYpQ0bX0aDHkRSLmtgibh4hLW7R+q2E7Q==
X-Received: by 2002:a05:620a:44c8:b0:6a0:26a2:db4b with SMTP id y8-20020a05620a44c800b006a026a2db4bmr13357313qkp.284.1652727814441;
        Mon, 16 May 2022 12:03:34 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-003.fbsv.net. [2a03:2880:20ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id v18-20020a05622a145200b002f39b99f6a4sm5639299qtx.62.2022.05.16.12.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 12:03:34 -0700 (PDT)
Date:   Mon, 16 May 2022 12:03:32 -0700
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next] libbpf: fix memory leak in attach_tp for
 target-less tracepoint program
Message-ID: <20220516190332.5mrld5dranyoeuhd@dev0025.ash9.facebook.com>
References: <20220516184547.3204674-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516184547.3204674-1-andrii@kernel.org>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 16, 2022 at 11:45:47AM -0700, Andrii Nakryiko wrote:
> Fix sec_name memory leak if user defines target-less SEC("tp").
> 
> Fixes: 9af8efc45eb1 ("libbpf: Allow "incomplete" basic tracing SEC() definitions")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

LGTM

Acked-by: David Vernet <void@manifault.com>
