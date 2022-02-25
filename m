Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E554A4C4FDB
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 21:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbiBYUoG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 15:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiBYUoF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 15:44:05 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49671AAFFE
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 12:43:32 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id v3so3576619qta.11
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 12:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0sTP7GDwptY8bNx87CNOI5Rdq6AzguIA/W9Y/8oT6f8=;
        b=MFoC5VBmZ3jGwG60wzsi/T6z2BtuS+rvj2L1jxRcPe/3E5zsMeT9bjEakVZp9Jnsxd
         tg4kSqlPzGlA0iyUQrY3CElDO+rbis9VxcDUHxSeSsFW3TRa388paIs3qbtKuCXgkx5+
         7xECK5DaXmFD3LY1+sOvgivI+qff76NvPyshWHmNHnvvVdsqYBnpczFZLz3yFzP+Orfa
         ZNSrBwGn88hdyaNa7CvOfyfQoyQCH9Oj0LnAlb5mHIuruh4MSpFq/799rPMISTacNcYV
         ivt9ctgA35LgvVvZUTZVi6hufVwiRD/K+kx4igZsyJnYNaOjNt0J677oY6ITiFClSdq6
         hm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0sTP7GDwptY8bNx87CNOI5Rdq6AzguIA/W9Y/8oT6f8=;
        b=2NghhbwHz+VCJBlBvxgrzzG+6/J8N0eNiGXNO4X0HxBN45/vSUPhHIK6CPL3SM153Y
         Y5Cbfs8tpifPpOK1DpkML1yA+kQEUxcoxCAk9AaOy4mp57i/35IsCmrs7fqkL87rVms/
         FNB/ycbROyvTZuNfdGq31CTcZdDRJIHClY1es7vyFeFfWeR3yM22d9++YHXGn80A6DdY
         h2uyAr2z0AQcFMrFwqHVYc4oeSgjwYwV/w97SlU2aBmJREZEcB/atrvz23Zl/7I0Z6wC
         1VqOLlLi8ruKKgtHuc8V9kygNpbSd+vQvrpAk6QogJ8uRPHr2uEkY0jPqis449V67Dlh
         9qCg==
X-Gm-Message-State: AOAM530EDJ32ZbGXBS7xAHDdU8rjaeV1Hlnl37SRJ9ptWvNtXr+K4dmI
        ZTov2ZFCLlKFIcsMpq/E/BsZnw==
X-Google-Smtp-Source: ABdhPJzAV+ii4WYbFAl+R+9tZfWmW/IA2f9BQUUwP6auXL+OaWyHqFSrXjfWo5MVaMH9Ks9Zb6CIZg==
X-Received: by 2002:a05:622a:1a81:b0:2ce:7959:d9a2 with SMTP id s1-20020a05622a1a8100b002ce7959d9a2mr8351037qtc.135.1645821811716;
        Fri, 25 Feb 2022 12:43:31 -0800 (PST)
Received: from [100.115.92.195] ([98.217.233.229])
        by smtp.gmail.com with ESMTPSA id o13-20020ac87c4d000000b002dd2647f223sm2150705qtv.42.2022.02.25.12.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 12:43:31 -0800 (PST)
Message-ID: <a7f26f93-c5f8-2abc-e186-5d179706ae8e@soleen.com>
Date:   Fri, 25 Feb 2022 15:43:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
References: <20220224000531.1265030-1-haoluo@google.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
In-Reply-To: <20220224000531.1265030-1-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/23/22 19:05, Hao Luo wrote:
> For binaries that are statically linked, consecutive stack frames are
> likely to be in the same VMA and therefore have the same build id.
> As an optimization for this case, we can cache the previous frame's
> VMA, if the new frame has the same VMA as the previous one, reuse the
> previous one's build id. We are holding the MM locks as reader across
> the entire loop, so we don't need to worry about VMA going away.
> 
> Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
> test_progs.
> 
> Suggested-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Hao Luo <haoluo@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha
