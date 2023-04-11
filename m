Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E216DD837
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 12:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDKKp0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 06:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjDKKpI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 06:45:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB73C39
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5047074939fso15807962a12.1
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681209880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnwAX68nNyh/hmMP/3M7+BVZliXJzHnkzF9BXMiTSDs=;
        b=hF0pw9frGm/QukyDt3MLiwgGfozAE/yj9qVLA41/QN1/4FLFXHfUfBht0J3crdWuKO
         NyErTk6dwuKDRf6BxOcBr2cMcXoC0GuukezV6WsGMndt4Mm0+jUMbF1bTXhyX67zCWa8
         7PSXMWBdY+K/l/n3gYMTD+6cfoB9PpZzuHknxe/h6Ps5iAOFneVGol+w9wMttfz3jI5U
         lyHlPCWEWMFHZV6dNMn3q005srotevbX4fRTd0VL391855bMExJne7SuKghzYm9EzSoS
         ziLFYtiCiXRJCl4Hz83V8L0ZBa53jTWqAFO7Sk2Bld8frXMwrCC+Eu4ntjS98MbtsM7A
         LU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnwAX68nNyh/hmMP/3M7+BVZliXJzHnkzF9BXMiTSDs=;
        b=xeL1t1dyfU3n//QFLKRkg5FFBxhfxIJDh1upuFPJiaWvlPvka5k2OHu982TrDPJh8i
         XMdFqGeojfTf2OCQ2DLduM91uk+fMI0L+6B+GvZJ7aYF53fgQLBDYivt78uZxxi8l88+
         kjAxvDL/HAGTg7BL4XYvBOjGRR99lXEZ8wReBKylytLQz9X5hrvgOmwZsTPP7Wvq6AMw
         e2sfrfYZg5X4wB0zq6ZIu1Akoc4XAwIMyuQvmTx72gnv72EuVCz1rbB7zRZloLpZkBX6
         UMU6Sin9kQhA9zb93TV+KQntWwYgJtuB5bjyoiRjnHO+ncfEJ+mK77aW+NYQ/Lm9pNDt
         vzqw==
X-Gm-Message-State: AAQBX9d5x2TW7AitHzB5FYuoJJlCNexDhk3YFlvZCM4vXMICzYCyzaCQ
        HzZ8YWBqvTFcy01Z9pQBqj0t2B5YpsfRo40zxaCfmg==
X-Google-Smtp-Source: AKy350blK2WTuTSt6iluSCcs5ZBO2rcOBBlpSD3VJc/jl1gj6jbeAEpIxjtczebk8Y891nlxaWgbkcaOS/Das6IOiys=
X-Received: by 2002:a50:d703:0:b0:4fb:7ccf:337a with SMTP id
 t3-20020a50d703000000b004fb7ccf337amr6561958edi.3.1681209880479; Tue, 11 Apr
 2023 03:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org> <20230406234205.323208-20-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-20-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 11:44:29 +0100
Message-ID: <CAN+4W8iMq3On9pbGcNqjz2ORReWX5muo1Bw-AfF=bTh14hdK_w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 19/19] selftests/bpf: add verifier log tests
 for BPF_BTF_LOAD command
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

On Fri, Apr 7, 2023 at 12:45=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Add verifier log tests for BPF_BTF_LOAD command, which are very similar,
> conceptually, to BPF_PROG_LOAD tests. These are two separate commands
> dealing with verbose verifier log, so should be both tested separately.
>
> Test that log_buf=3D=3DNULL condition *does not* return -ENOSPC.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>
