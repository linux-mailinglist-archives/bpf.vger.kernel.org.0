Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2D61A4EB
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 23:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKDWyo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 18:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiKDWy3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 18:54:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91FC4FF88;
        Fri,  4 Nov 2022 15:54:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id t25so16867557ejb.8;
        Fri, 04 Nov 2022 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=100fY9KESFaq3hq0fX+Iw8RTNm69n7uFfyY6208fkpo=;
        b=gReDsr7Bvlbcz4buxyw+70IReOD+ZV8RqRzj56Tu3/IerQ/G6ETQwdXlldmVRxKhCR
         bnumTTApG89yPYGwDPin9nYTj6t5V8pyLf6HcqrMnE1WBKXXnYM9zFAHnyJe3KyV07CM
         xTtutHjwSEseogeHbXDawoE8JiGkdNXuXamB2j0gEpT0b2pkK2zybsA71Tck7sU3Gpdz
         xIqnFRVFO/pJ6yvFk4IFiqLJsez2p7QDywvfaAmjRMHyE0ZJJuU9M/I4KlxULQQ1OkV8
         F0XMvMUtTXqKfqjMYpRntJqaz2Dik0/NM1j6vME/HPSdnUxZRUSX0pPRNiz5I5FqDdq/
         Ztog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=100fY9KESFaq3hq0fX+Iw8RTNm69n7uFfyY6208fkpo=;
        b=mSHy2jepucYMZ25JJFqWIAPj8swJOYhvzl7oeuULyYphhdi/Ble0GlA+hPkS9ds7UF
         ptzXzIhivkVDZiZBWz2t42V8VSLMrVNFZWPuv4+etZlGvWZ86f3IiiAf+praAWZTDOZR
         yVVYE6iHmL2Ydu32ILk/FhDPnwuKC407aKD1Ms/XjnwPH4sol00R2Cm2PtV+QCdQSQqO
         jpCVvOul7xkRxE/x37NVLGhZgDntWKvXj5KPiFjJGkIQBEqoYvpCXfxMERttJxLKUkoP
         f9tSyejtLJnmMm3C/LvcRLWOEyp6G1wVBBiHSKxWIcSkQX90FrzqkVn4V9UCeN/r1S8t
         uf8Q==
X-Gm-Message-State: ACrzQf1hX96lKZwg1WGvXHeI9vQjpJPCPfbb2caoTrE+m2DbCqXG1WzB
        3m5rW7U0MxC3VQyCnoqYkVK2VB2H8cODO55R2xQ=
X-Google-Smtp-Source: AMsMyM4c/5imPL+QWpu8mN5nTB1mvVwXVTyxeyZA2Vg/xchascXVGOrmXycgsu1SPi2ymFpzNC6glET1MR76HnJhIxY=
X-Received: by 2002:a17:906:11d6:b0:7ad:fd3e:2a01 with SMTP id
 o22-20020a17090611d600b007adfd3e2a01mr17392619eja.545.1667602452262; Fri, 04
 Nov 2022 15:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221104101928.9479-1-donald.hunter@gmail.com>
In-Reply-To: <20221104101928.9479-1-donald.hunter@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 15:54:00 -0700
Message-ID: <CAEf4BzYXz_VNYPUsqv_NkFEwZsj6XM-4gJbZvFnCd5-pfqnbkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: document BPF ARRAY_OF_MAPS and HASH_OF_MAPS
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maryam Tahhan <mtahhan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 4, 2022 at 3:20 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Add documentation for the ARRAY_OF_MAPS and HASH_OF_MAPS map types,
> including usage and examples.
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
> v1 -> v2:
> - Fix formatting nits
> - Tidy up code snippets as suggested by Maryam Tahhan
> ---

Didn't notice v2 and left a few comments on v1. Please check them and
see if you can address suggestions. Thanks!

>  Documentation/bpf/map_of_maps.rst | 129 ++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/bpf/map_of_maps.rst
>

[...]
