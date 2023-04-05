Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A66D84EC
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 19:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjDER2y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 13:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDER2x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 13:28:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D165FDC
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 10:28:42 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w9so142956266edc.3
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680715720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRowmXI2gUxOwnPkTg6fsw+cfqZmEfJOVr05BgfR1pQ=;
        b=f4pPlQsrWYdNcx2a0HcXvGST9LKiRaK/Kg1RFFEn36oCh7BEQWj9b0srzw8K5t7zGS
         dG2D5h+H3Q6n055HcCo/yOdfwwCBMyw4m6UL6uTSEVvN5h2ArgK+uG/WltFOHYDGfEjX
         KdiRi9MY3BZKkfsym0hkz1CmWHG+uq3SXwyCGumMXEuDVEryS0u3yHZdDAaRzsqAr3Mw
         yQ6FU0CApeNwzv2vfa4ujlVYsQWcqXNJ7mSVKnwjNgkWAsVzDBKJEmy5RrMZJ+1KhRH3
         /qwn4fUTQWpoanpQn5kKW4JRS5KCfzIPSDlx5ZP4xIrG0bly1Pfznw7jfmEJthkkIutk
         iHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRowmXI2gUxOwnPkTg6fsw+cfqZmEfJOVr05BgfR1pQ=;
        b=ZuEyZhZaKsTCBg2xy5fUtPVFXp8ijengDXy1lQ8J3FoWYiBcsJ00G0CUnFOCACIUjr
         ufGpo15WXuaCWcB7mgYQLPMMxwuFbsChhz/lfY7XxBlZ2me07e0Kbsuzu7CU4hW6ioXu
         ffgfJ/hxD8RDpx4dxqSlyL3dfkHTox/gB4E3lggqBZHBig84atNvRcziPVxEs7x2J5E0
         e/HounKsrrNwcrdGIJDFHWQZBqc6Vp778fugMgW/9Bx6hI6jFgFWFR9Kxv+v3xrHcaS3
         YZ3YoXkqbTjaZnsQ0bl21+bFQmiFVF7pFp7CUUvj0AorlNqN+YuuTjJHfhNdci/Vfpz8
         8fiw==
X-Gm-Message-State: AAQBX9fqq9tzS5JCvZvpq0/zd07gLW8YPy+zCsnlQVTz85sdcbcTjJda
        eCbhCd2JCGZiKMtr+w1DMt2Bw7JSOLAi/kG6l70+ew==
X-Google-Smtp-Source: AKy350ZEzcXS9UcYiENZTx4HlhxAzybrxx3GNzgc2qXDaeJmhCHu0j8BL7l3Ql5S4riwJq4R7wbBOU2C1ZYTCy78CP8=
X-Received: by 2002:a17:906:3b4f:b0:932:4d97:a370 with SMTP id
 h15-20020a1709063b4f00b009324d97a370mr1808584ejf.14.1680715720212; Wed, 05
 Apr 2023 10:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-10-andrii@kernel.org>
In-Reply-To: <20230404043659.2282536-10-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 5 Apr 2023 18:28:28 +0100
Message-ID: <CAN+4W8gx-OZtj6kHWnxxyxpfVJgGHKSybg64dffuG5PTb4xOfg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 09/19] bpf: avoid incorrect -EFAULT error in
 BPF_LOG_KERNEL mode
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

On Tue, Apr 4, 2023 at 5:37=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
>
> If verifier log is in BPF_LOG_KERNEL mode, no log->ubuf is expected and
> it stays NULL throughout entire verification process. Don't erroneously
> return -EFAULT in such case.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>
