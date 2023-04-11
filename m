Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5206DD84F
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDKKwJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjDKKwI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 06:52:08 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C582D57
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:52:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id jg21so18858430ejc.2
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681210326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIneWuWqtNAcWU2RXauFR9ffbopRvSw0g0bao3/EIE4=;
        b=Kf4Z06SYVLtsre+IVCn3Z0w/gc4cjIYLKxtnQpSur7ILDdAJ9vylZPT5XnBwx/GdSt
         NkLyLzX+JdncHXcAGJBSKHVEbpTwgHFU7kRoMRirECwchBjpF2OOx2dLg+d4d4JUd3Om
         RXf9avVf+g1kKDSqxnfLO18JGVqlfduDGSBeFvsJQAAKD5Wj+coyvfJPWwwoCmEEJjhC
         /4G2Ry0lHg3aa2vYO4DPTa7I5tENdNCBCadF9UzfDTq/niHpgNIvTHE1LtCZdIyJ6/K8
         7xkXCuuMwbk8x/3y/4aU5p7CK3DDx8BubA3lbCjrD68ozmOecVckVZA00xnOOV8i21NF
         nifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681210326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIneWuWqtNAcWU2RXauFR9ffbopRvSw0g0bao3/EIE4=;
        b=j5v5LlsNThoapj9eGZKiqGOV1ia9o5aq6HOE8sG8URZF6Q+yS0BXl9NZJB8WN2L32I
         h6tkiB8nY1nuwUCumosd71wg+XysEPdwAhxAcI3nPx+TIu6hSYzXQutv79yxQ5tpFoj0
         gsaaNPvLtbtbZjy+btdBv0Ib5dZkmwFCRM7i9Rk/p7/4vR7Rnm5FQffQQDuj6K5yB8MX
         ilVwCiMJ6F+sKfxQQmRaatY/KHbAf3zqA0FhmCw/F4p7tVjuNBXrzeX1HY2WClPXTYPI
         mE2Lt1uikqgXyvpXFHJi7qMApCrIxQ8+1JYm9V4fL82U7JXCTDSS7ruJdtEjRNjdlUKw
         AChw==
X-Gm-Message-State: AAQBX9dSxwd2inSHKeok/nzh7i1Rdddf7wjr1onipBxeBbxpOEFObMmx
        6ycDSECrTYP2XhzoD4sBxUdNij/mkQ4eKfB1ZrxmSg==
X-Google-Smtp-Source: AKy350Z26lOw0uiG5GVM7W/bqUZz1i4Lf+EysXEq2/XnJUaf02aJaDCrLF7t7eYDrYairCRHXnW3IL/tCg5w/9aEU2I=
X-Received: by 2002:a17:906:8491:b0:949:87f1:8129 with SMTP id
 m17-20020a170906849100b0094987f18129mr4471007ejx.14.1681209872161; Tue, 11
 Apr 2023 03:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org> <20230406234205.323208-18-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-18-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 11:44:21 +0100
Message-ID: <CAN+4W8ipTr8S=FYJD00iO5+b6MtM-EhivDmgeWtuWMXybN-77A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 17/19] selftests/bpf: add tests to validate
 log_true_size feature
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 7, 2023 at 12:43=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Add additional test cases validating that log_true_size is consistent
> between fixed and rotating log modes, and that log_true_size can be
> used *exactly* without causing -ENOSPC, while using just 1 byte shorter
> log buffer would cause -ENOSPC.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Great idea to test the size - 1 case!

Acked-by: Lorenz Bauer <lmb@isovalent.com>
