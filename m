Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB76E6DFA25
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 17:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDLPb7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 11:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDLPb6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 11:31:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B397D97
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 08:31:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50263dfe37dso26290065a12.0
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681313502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kKQiD07CS0w2VxLyLHgs7b6wLchcSIa56UjxK+xU58=;
        b=hZL0xKdiKz/Hm38z1V5RV/YCevmbF+ioAHSykjYwrVWU767ctgwf1eaefBOlOLzVsX
         hvniwWUm3fBJVRXsyvY6IkPsyG1v4qNVkn4s7sZU6je+ytva4g1M/yMPEpCnJ+ETTWW8
         /IVVUhv5vdNfr5GTY1byd0z06/d6KV+DVHXtnJ103sl1JFEYabeLoeXOw9iKPeBixjxu
         eFeQa17YkhTKvfiPpLmW0FqwEP+WFcxjVIFRdqrEz6+mP+FaSYCrXcOkTd3Yrhd4MCW6
         wVfLDtrfldLR9w6ouiinPBItPhqaS+cfVWfPsYKVlEzeEid6S+O3fvtR0m6NUCdzneJV
         F11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681313502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kKQiD07CS0w2VxLyLHgs7b6wLchcSIa56UjxK+xU58=;
        b=BPmyOOsATtlufbvQ5ynAuObDyJ7RwVsCm4JGUmOAyxMk+zLB8mv5ixv120pZUiU4SU
         k4399Kjo/4tcGfudMRyOPVCPQtjSLJDGpx+TOmxdo+1SV8s6Ura8QME0H7sAZSNfOBcb
         73roq/xZq/KpncvCB0l0e8aJSAHNK8GCNX7vYUPoXBNY2hkdmfbdKwTpyRTU8khA4HVe
         Y4qSgA98eqn01OC8wKpGNrrBPEOrx8KhLgVWeTiB/CD71duTZq2hgSQjODHUMeY1gxjl
         PtXejKojvSyQN9p3NJQwDa0EmZJXvO2DLZyS2QjekEDZGqXSmD/opoyxZ5t+1NKyZ8t4
         tMuA==
X-Gm-Message-State: AAQBX9cmJTxBup4OcdR9RDxrogGlSwTE0AvX6USdyQ6uXt+dI3yDcgkF
        kEHuhZSDU0EDZpocFXv7NyBEMJySXumw/QTXRee1iQ==
X-Google-Smtp-Source: AKy350Ya/sZULMGEbEtQU9KGQaGm5VaHp7eMiCvGYwSTFGWCS2N4haHSjJjZPUnm2JyF2P/1WaRnviAwa1jxE+kXDlo=
X-Received: by 2002:a50:8a9c:0:b0:504:d7ff:8da7 with SMTP id
 j28-20020a508a9c000000b00504d7ff8da7mr1686669edj.3.1681313502298; Wed, 12 Apr
 2023 08:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-1-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 12 Apr 2023 16:31:31 +0100
Message-ID: <CAN+4W8hhrJznohpbkx0wOt8J+S5HeBTaWhfy+=VgqGi3OjnKqg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/19] BPF verifier rotating log
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 7, 2023 at 12:42=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> This patch set changes BPF verifier log behavior to behave as a rotating =
log,
> by default. If user-supplied log buffer is big enough to contain entire
> verifier log output, there is no effective difference. But where previous=
ly
> user supplied too small log buffer and would get -ENOSPC error result and=
 the
> beginning part of the verifier log, now there will be no error and user w=
ill
> get ending part of verifier log filling up user-supplied log buffer.  Whi=
ch
> is, in absolute majority of cases, is exactly what's useful, relevant, an=
d
> what users want and need, as the ending of the verifier log is containing
> details of verifier failure and relevant state that got us to that failur=
e. So
> this rotating mode is made default, but for some niche advanced debugging
> scenarios it's possible to request old behavior by specifying additional
> BPF_LOG_FIXED (8) flag.

I just ran selftest/bpf/test_verifier_log on top of bpf-next which now
fails with:

Test log_level 0...
Test log_size < 128...
ERROR: Program load returned: ret:-1/errno:28, expected ret:-1/errno:22

Seems like these tests are now superseded by test_progs?
