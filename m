Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981AB6AD414
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 02:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCGBf3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 20:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCGBf2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 20:35:28 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034A78699
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 17:35:28 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id ay14so42763501edb.11
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 17:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678152926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qiWk38PAvwJFbgBrQ1MfdHJNANyC2nMp+tvYnrHjBEg=;
        b=ngUnS5fVPvVdMTNr4FnRQMaUqLLD6wDOmjv48TT5iFKpHEsPgpUwW4q6Z16cqWdUAO
         QRCXwEBb+SJbG3cfxtpwCsb32eac3Dz6hzolyAYtwGwA/+q3wAQeDvPgOvcxH04brB+h
         5D821UZb8D8j2JqdRJx1/GFGymawlacC/0QIy0TmG8xi8JYqICTjBzd7sx/mvEGk+oks
         Ak81YKjlbaM6uvHQcOJqi8pqeFxfyv9a7eoi/LoDxojmOlwYFDePBGNxX8PjiMLI57Wh
         PabAUALa7KwwU9o97aVW4L6KQRe9vQIwrg16PN43zD3OR3o7rtGNrbAJFfgmKUz2zkBa
         gPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678152926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiWk38PAvwJFbgBrQ1MfdHJNANyC2nMp+tvYnrHjBEg=;
        b=XxTOy8AovBTFTzNCGEuF6W+8x4DF99ehviY8jvS8Yv3i1JEJZ8H0K7cWiizqda8TzR
         INH7iW5f6gt/edrw3UeuuvSjN7YKt1QcVCen0bc2l4xlSR4ge6j2ycHcWsPSuMylnbLz
         XGQNcE2kQqyM6pmSfbD3f+Ni/r1+EDQVAq4RpNBtn/+MDq2fUvgWz+7sL6weG+u9+3im
         k7995fBCzvPXuI2gsvzUs20arplJxbG7CVrBLACJq1M9nQsc/745YJarUyLXOL1vUmqW
         DvRxFs2Qd7m9LT6dy6N/2pDnABymWEsoe7k5YIYAj0yytAVnF+D4kSDhb3lshBPDFloh
         EDnA==
X-Gm-Message-State: AO0yUKUFIWh5FXOeQkrIcAjhK7vUteNM8rz0vYHxdyGXYBT9UQ8rQLBB
        O7scJ1aSdsPh50bubU9WInM=
X-Google-Smtp-Source: AK7set9Asa0bHFgjPLKaMfmsKMBZe7QWviD5I6VRo/i2RgLQLifNdMxjwPlrzL/j8ANmL07DfKhZvw==
X-Received: by 2002:aa7:c2d2:0:b0:4ad:7224:ce94 with SMTP id m18-20020aa7c2d2000000b004ad7224ce94mr13638278edp.15.1678152926368;
        Mon, 06 Mar 2023 17:35:26 -0800 (PST)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id qw15-20020a170906fcaf00b008d57e796dcbsm5261039ejb.25.2023.03.06.17.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 17:35:25 -0800 (PST)
Date:   Tue, 7 Mar 2023 02:35:24 +0100
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 07/16] bpf: Remove bpf_selem_free_fields*_rcu
Message-ID: <20230307013524.o4j6jqedunsvvepb@apollo>
References: <20230306084216.3186830-1-martin.lau@linux.dev>
 <20230306084216.3186830-8-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306084216.3186830-8-martin.lau@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 06, 2023 at 09:42:07AM CET, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> This patch removes the bpf_selem_free_fields*_rcu. The
> bpf_obj_free_fields() can be done before the call_rcu_trasks_trace()
> and kfree_rcu(). It is needed when a later patch uses
> bpf_mem_cache_alloc/free. In bpf hashtab, bpf_obj_free_fields()
> is also called before calling bpf_mem_cache_free. The discussion
> can be found in
> https://lore.kernel.org/bpf/f67021ee-21d9-bfae-6134-4ca542fab843@linux.dev/
>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
