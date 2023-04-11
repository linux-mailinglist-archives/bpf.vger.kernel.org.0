Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76786DD832
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 12:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDKKpT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 06:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDKKo7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 06:44:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05AD4686
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sh8so19078938ejc.10
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681209868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMmjC1vg/ynLy8n5f8ATDoFZJCYv2A+5Qju9ZmWdk/E=;
        b=UckPRO3PhsyYeqpfXiufDJfoZGfRfVukdmXBWV4io2wvtL1srzZlcHzSjf6gAoA8g9
         yeSEbZfXu422TFb0Ir7WK0TvzBIi7SkdNnCwK5O5S3FBWyy15IdEJbiIUT9C/p2dItPC
         QEeBP9I4VBl16OI6jOiymYAH2/uDC5qAMyt5i90t4CN/Wbd7gnMZj+xeEdkYpp3sdgSD
         Oy6B6ylcdWOJCG3e5bp6ucmXVfzli4UwOW6iwgdJ/42UHP/HqJF1KHjTHdftKzbyUcZW
         dvE9fpHsaz9k2rejuNnWPExdD0CZrLltbB30myizEGnO+IfY5IbwTk5F90/zVRqpkA5n
         3glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMmjC1vg/ynLy8n5f8ATDoFZJCYv2A+5Qju9ZmWdk/E=;
        b=K+RI5ArQNrRg3uFCVMalyy3RJGediTIQc5y3YjAJnHkLz8gg++aGvjQI+C3XeSjl/8
         yFX8el44GLkgr0HZzvBUd5lk1jztRhp3ggvwJhDt/fwmEnHms9y1dnY4lk8+8o5ngi4l
         3ZLyEUOhyo3dSjjYUSh6nqBQa92Afj0rkp5fwhowpEilm6B1REeyEMAKiwkRziawtfiN
         5pvdy8z4KMof3f4ATg0lbbi6E5Oc1smTLod2VgQjN1ABz20piU7MXb1NO3cxuCY9SUGY
         EuBDJcwV0VgaYGU7cDnGLfa6F2fA5YnDoWq4SVEXv7S0CFfV1EGj9fJT/uNJewSlhzIQ
         LNig==
X-Gm-Message-State: AAQBX9d9jAFpucyMCE56bm2DTN924Lhih3Zen3YOr0PslVpenC7h6Rcj
        e2FjuEMxM12F8BpRZddQmBaZOQEICQ2E6aRG/3BU7A==
X-Google-Smtp-Source: AKy350YAOhQFPI08ljh2A2tqTYwiSNi2lodtum6HfqO6B41RRTNgeXC/FOXBtJD7CMJZ8gR5sqDyXbccod1hcpOfrDA=
X-Received: by 2002:a17:906:795:b0:94a:5e76:c76b with SMTP id
 l21-20020a170906079500b0094a5e76c76bmr1094807ejc.14.1681209868554; Tue, 11
 Apr 2023 03:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org> <20230406234205.323208-15-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-15-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 11:44:17 +0100
Message-ID: <CAN+4W8h8vGXTG1k7GO_6ZexOK3p3RDK0zwVg98vkRLcO0GvO7w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 14/19] bpf: relax log_buf NULL conditions when
 log_level>0 is requested
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

On Fri, Apr 7, 2023 at 12:42=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Drop the log_size>0 and log_buf!=3DNULL condition when log_level>0. This
> allows users to request log_true_size of a full log without providing
> actual (even if small) log buffer. Verifier log handling code was mostly
> ready to handle NULL log->ubuf, so only few small changes were necessary
> to prevent NULL log->ubuf from causing problems.
>
> Note, that if user provided NULL log_buf with log_level>0 we don't
> consider this a log truncation, and thus won't return -ENOSPC.
>
> We also enforce that either (log_buf=3D=3DNULL && log_size=3D=3D0) or
> (log_buf!=3DNULL && log_size>0).
>
> Suggested-by: Lorenz Bauer <lmb@isovalent.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Lorenz Bauer <lmb@isovalent.com>
