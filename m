Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055986D8D1F
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 03:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjDFB67 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 21:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDFB66 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 21:58:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA010A
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 18:58:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so145762405ede.8
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 18:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680746336; x=1683338336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtCBOqM7XENl0a4d7rd3L6kyMRQPgFEgO8nFdYv5jBo=;
        b=M0iEkO0sBNVMW0GAFRTCxcu8KgBf5SXRNE9xsIo0BwxJ4NhrYyHm6PcqLRS4953lwy
         QhBIZdhbFO+WG7STff2ysaya9UUi3/ugag8scOtlaZk5Uk/hTaV1x89C4upR/lDMeE9N
         nk49eAjh/3m6j+rAoC4Mn+Zlzr0hjO3xh6QrWjVvGHbZkf/vyhDS921AwCgHn5Gc2/SM
         a+zJgulJBMmGsofE9WSyO/QjjcOa9f2TaCGziWi9KewXU+fkzo+ObyYchn5pU0NSMEYB
         sMCeEuXUNaaK5/hFaD85188+bBMA2IuSUlTxq+HaUS4Q72nV8vn/fcCU0cNwEWLNA3u4
         ifYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680746336; x=1683338336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtCBOqM7XENl0a4d7rd3L6kyMRQPgFEgO8nFdYv5jBo=;
        b=fqZZiMsFH7bbXoZaeCZ2y8FfJycE3Qbg4gF7WZ4fVR3POuAeNi/S6sOQzICoHMfd2M
         0fPg1CfiVUfIX5zxhYXfcEbFBqSqhIczBMu+4Mo/R1otJ55eVUBsh9z75bTW5VzGw/Tp
         ZsVO357XvV0PZ9aY0hW9ltgCtH2ZXaA7IucYypXxjO6nDp19LcndR7+JXj1cg91kaiTT
         Y5bfZApRSDtLWr+Z8DPEcuSirKrphRHzwoejP5UzCEPJaJkuuvuINTHtjvevZY9+BJRH
         KYSVRnNjs9/YhWWMLzWfwY+YvyAmWKkC4SdqRPr6nRTyp7WF0IsXxpZyR4XeoP3EhR5Y
         ZJDg==
X-Gm-Message-State: AAQBX9dLR8BphHYPr7F9EdlBwiyyZOdFVhFcxqp5f4/iiJUoN7rwo/2/
        QZzjIxQmnmITvJQ2TldeF96vDExDeVwaHkUUtwNMBZDv
X-Google-Smtp-Source: AKy350ataTsALzEIgqWY8LcCphMkxYciyDn6LHOcVSO6H2G3bd2+KaVD/5ndOHAxc5wnct3dIB52IopSslrzUmy+lXM=
X-Received: by 2002:a17:907:8a07:b0:924:32b2:e3d1 with SMTP id
 sc7-20020a1709078a0700b0092432b2e3d1mr2644270ejc.3.1680746335763; Wed, 05 Apr
 2023 18:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230406014351.8984-1-zhongjun@uniontech.com>
In-Reply-To: <20230406014351.8984-1-zhongjun@uniontech.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 5 Apr 2023 18:58:44 -0700
Message-ID: <CAADnVQLdY1hRgG3xPPBD1unrnpu2zweGjb133cBnmuCUmdhJpQ@mail.gmail.com>
Subject: Re: [PATCH] BPF: make verifier 'misconfigured' errors more meaningful
To:     zhongjun@uniontech.com
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 5, 2023 at 6:53=E2=80=AFPM <zhongjun@uniontech.com> wrote:
>
> From: zhongjun <zhongjun@uniontech.com>
>
> There are too many so-called 'misconfigured' errors potentially
> feed back to user-space, that make it very hard to judge on
> a glance the reason a verification failure occurred.
> This patch make those similar error outputs more sensitive and readible.
>
> Signed-off-by: Jun Zhong <zhongjun@uniontech.com>
> base-commit: 738a96c4a8c36950803fdd27e7c30aca92dccefd

This is a Nack. We don't add debug code to the kernel.
If you see these messages you're hacking the verifier incorrectly.
