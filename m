Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF752AEA2
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiEQXeH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiEQXeE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:34:04 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18A7527DA
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:34:03 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id r27so542323iot.1
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jEvE1vNwXcZPS2N+BLky0y70snAyglXlya3Vv5d2qRk=;
        b=ZgleHdDbir4mpQJQie9+W2c9mYvUIl0bM5rOx5WeRP79ShvEZ+M4a9nEqnksGL52ME
         8IYUAbZY7FkICCQU6KI11/cKi3QFbJhNdXHM6xI0XG2NfFJNs6sEkTbe6y6jXcgz7EUP
         3DguaEhaLVxtURd3lvJHFL31mVDAWtWeltzJGXrT8nMynCify0/PRSMGvRmRKH2Dv5CS
         Gqo4K0KTtRXSJ60vPhEsULGzNTc+lFG8ZJcNKgKxvqturPp6nKGQcfK43pHDkRTXRTkb
         2N8qDxDMBqozL/SDetLz7NIYWFovASrIOeVj1iJ/OGqtJVIpE7Va0ZyrTeKUoz83smhQ
         y0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jEvE1vNwXcZPS2N+BLky0y70snAyglXlya3Vv5d2qRk=;
        b=H+842prpFp1u3t64FqM9IvsIwrdGe2uiF2g/E9bgN0u7IGULmAl/AHACTtaqB2XyFd
         PpZT1Y0fMkbRy3/Sk/au+yUE9ocORKFf67SpeARsTy76CGbzw4H6ssIxOfX4fe21etd1
         tTnIDthRIxdDO7NmsYVFX+1QB0Gi3tbJcLBJxRUCMmKaOXseE0/QwpYxpXFi6uLFzRZ6
         pXQPl60eEoWlXD5TC76B0mpKBIg40rceVNAfDFByOexLdL2S9CnbV2EUGb6azo2LAykb
         1M1KXm1y1e5tFdcvyZujhWHfNK2ydbpkySQuJzWFkPGZX1W9wzPi3iwvkXUSihHJDMeY
         hpww==
X-Gm-Message-State: AOAM530Iue+UCY+KFj9lJEAN4xg9Op9wxFgz2TynoMTop3H2PYOJhS6b
        b8IiifsaBmCt+BE4nYyjtPzV5LG1qYMBQvtlPtg=
X-Google-Smtp-Source: ABdhPJwvKyEsrK/Ga6HlyP3aSe/rU9GuGo+aX8iCy/PuNN0cyrLte+oxgfAwTVUbgyseE5hE0EImE9sEHiOFfgLjJxY=
X-Received: by 2002:a05:6602:1695:b0:65d:cbd3:eed0 with SMTP id
 s21-20020a056602169500b0065dcbd3eed0mr11200444iow.144.1652830443428; Tue, 17
 May 2022 16:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031324.3245558-1-yhs@fb.com>
In-Reply-To: <20220514031324.3245558-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 16:33:52 -0700
Message-ID: <CAEf4Bzac+oRvDwv_yKMMpdwgasjo0JOHL06n3bcPrsk9PYW6Sw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 12/18] selftests/bpf: Fix selftests failure
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>
> The kflag is supported now for BTF_KIND_ENUM.
> So remove the test which tests verifier failure
> due to existence of kflag.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]
