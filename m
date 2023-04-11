Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82ADF6DD833
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 12:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjDKKpX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 06:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjDKKpE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 06:45:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC0949C7
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sh8so19079713ejc.10
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681209876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwARP1Iu2jTq2c5OHPjlyaEzWILtqkXBB6v2oSWp54M=;
        b=Izr8W0PX8wjC+4CUMr1wYtz4OXFPYIuFNu8cLpN6goNlqphykLlZW9H6dQMYZIjshF
         XdgvbqllqlNiw2dzKrcSBnbfJjKym691JJ1/S4/FA333+kTd4LtuiiTC3NOOv437UQ16
         JI7hqfOa5imMxbNf0jYsDJtcMyHN1yK1XgGNgJRq3o7FnWydlezF+hGC90T9v3RK3Jvz
         A+BuM/i/qS9S9SoPVkaEopeU5gEDRTHOz1NiZCdfie5yIj6HM6nsJ7fnjxomqYfz2PxE
         xmPWWlnZ6Jtp5CfKHW0aiBy1k/4+/ZTkuqXkNUMPPoOBSn5GgjZHsW8EgElAcol5vRsg
         Fi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwARP1Iu2jTq2c5OHPjlyaEzWILtqkXBB6v2oSWp54M=;
        b=y4+vUZ8BTHTo8LOlQrl4BRHuDq/OgOoR6hp96KWbJNSm5O0qMdU1qBf6eiXLBtoCHR
         A0yp5CYlT2AEqZ9dlGxRI3tIbgsJgvn/UQpCTTIYNKt/3MhoT3EklEgwMO9jLsDE7ARa
         fQ0IgRPSWzKwuVKz2Qni3gyUzteR6sTfiUKfEWg67mf3h1sZwFE5UUivVwQxNz3g4t4X
         A8ynUfE1iCMLcoWMbheZwuvOG+PR/r6eYZ5++W3AzhcdAGPd/yr7pdolhMHRXdPfGgw8
         odaBRNDd8mJY29CaraIvWPV8mA4ZUXbIpA/rqh/e4ohWTgyd2jfluFaG1NfRIDlq4SeR
         eEZg==
X-Gm-Message-State: AAQBX9cgm+XfMgqP7M9L8VQk9ie2JUa7lOR1sNTDNQHIfNuSHYq+qSIL
        56kRysUJ9FiEzrDrkn1wIe4CoVNo3pKsNuw/xrqqJA==
X-Google-Smtp-Source: AKy350YkXX4/vtGNRfesveLS/iOFlRI2Ph/Vjy746UZf5X0PfwH1ihOfLppUxVMjHkHHMTjq+obmTlnGTNHZKurB6vc=
X-Received: by 2002:a17:906:795:b0:94a:5e76:c76b with SMTP id
 l21-20020a170906079500b0094a5e76c76bmr1094988ejc.14.1681209876717; Tue, 11
 Apr 2023 03:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org> <20230406234205.323208-19-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-19-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 11:44:25 +0100
Message-ID: <CAN+4W8hcdjT+3sGUuaLATnqQGdsEBqoyA8GmzsENGbhcGj9M7A@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 18/19] selftests/bpf: add testing of
 log_buf==NULL condition for BPF_PROG_LOAD
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
> Add few extra test conditions to validate that it's ok to pass
> log_buf=3D=3DNULL and log_size=3D=3D0 to BPF_PROG_LOAD command with the i=
ntent
> to get log_true_size without providing a buffer.
>
> Test that log_buf=3D=3DNULL condition *does not* return -ENOSPC.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>
