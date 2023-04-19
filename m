Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA86D6E85E1
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 01:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjDSXZS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 19:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDSXZS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 19:25:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3425926A9
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 16:25:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c9so2401649ejz.1
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681946714; x=1684538714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4W9g6CEcF44uAiweNxjmcLZ82VNlELRpxqiWznnWLJE=;
        b=ApDCo7qQ0CVqyde+kpj2U1pozBg5hC0GEeE3YtfR64l344PRbIYJRTLj++9i30daP6
         /E09pXYoG7rnrqhsDx84epjrK+nKuWg9pXvLez4DOTThKdI/OH64hKQNo/atG22UJmk9
         G+mDhR5EpPyvMEGGk9OMYxGCm4azvpEWcRXqaKoeJQIgeKg9Z/qFjje6kv0L7Tt3LoKp
         ioTzHTgkeihKLVp4xFfm4cUlZJDe7+gc837RzdN/DJ7hKCxmIWYhmC61+5nnG0Pv4IyN
         RXrdsnrEg+6mYhSeOTAGcKIZ56a689N1yw63L8ydFVw9w/LRwC7VUDjmkdd9weDtKlLd
         SaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681946714; x=1684538714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4W9g6CEcF44uAiweNxjmcLZ82VNlELRpxqiWznnWLJE=;
        b=b7kEQEJFzcTEkjBOvVguLVoGEqiMTp3sq2rdZXQa2M/pe+Mg3gSyrlZf3x16ihoPYE
         0yB/liHcnB6mdmWotUt3cG8vVG78SGrEthtzcxheWTjqgzXyoxAI3NNy/nyy4rOeKL9Z
         WocrzaJ4gxzYOuOlrmDmietCTuxLtYmKjKKrhG3y1DjiUFKQR9HShiAeAWE2/Sg133LT
         yguQ4xGpe2pj4w3cyOZ+Ae3vOpWEcUulZ6Yt9y9sbu3s+LzMjkwMA26mjpFtmNzkzY/J
         ZzBSjYYEc4lVrqsgkOrazTmkYWUuwc0g6jC+aSHzt4/qJJuvpTafvuGwL7lkrkV8uGCM
         LlAQ==
X-Gm-Message-State: AAQBX9c/Mm0TAUlS7mqCqbqN1ZRih9FFkO8JPOl5WcyowUAZnLuvZ5VA
        mBDO6r8e1r5cxyde8zo+ahoyGXDZ2w9HMggf9yFTbg==
X-Google-Smtp-Source: AKy350bnZZvAIGg5gdET2GUhiTB7iF54/ifEggTcu3A1AOD/Mr7dsuTdiTHXGlo5N561a1nR+9EFJUZ7AKiEp8ErLgQ=
X-Received: by 2002:a17:906:4d8e:b0:947:df9e:4082 with SMTP id
 s14-20020a1709064d8e00b00947df9e4082mr16938812eju.35.1681946714627; Wed, 19
 Apr 2023 16:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230419003651.988865-1-kuifeng@meta.com>
In-Reply-To: <20230419003651.988865-1-kuifeng@meta.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Thu, 20 Apr 2023 00:25:03 +0100
Message-ID: <CACdoK4K1WjBrm6jcF7zhFSn8VN2BhBHtWubzVira-Xiiz+JV7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: Show map IDs along with struct_ops links.
To:     Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        yhs@meta.com, song@kernel.org, kernel-team@meta.com,
        andrii@kernel.org, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 19 Apr 2023 at 01:37, Kui-Feng Lee <thinker.li@gmail.com> wrote:
>
> A new link type, BPF_LINK_TYPE_STRUCT_OPS, was added to attach
> struct_ops to links. (226bc6ae6405) It would be helpful for users to
> know which map is associated with the link.
>
> The assumption was that every link is associated with a BPF program, but
> this does not hold true for struct_ops. It would be better to display
> map_id instead of prog_id for struct_ops links. However, some tools may
> rely on the old assumption and need a prog_id.  The discussion on the
> mailing list suggests that tools should parse JSON format. We will maintain
> the existing JSON format by adding a map_id without removing prog_id. As
> for plain text format, we will remove prog_id from the header line and add
> a map_id for struct_ops links.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Looks all good from my side, thank you.
