Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8E6EC05F
	for <lists+bpf@lfdr.de>; Sun, 23 Apr 2023 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjDWO0R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Apr 2023 10:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWO0R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Apr 2023 10:26:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC82AA9;
        Sun, 23 Apr 2023 07:26:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b67a26069so5037772b3a.0;
        Sun, 23 Apr 2023 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682259975; x=1684851975;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcKUbMruOsqkDexw5FTEAcEah3bFZ275+DG3/6wvTW8=;
        b=VwkNE4KGxYxh6Cm1sfBaC8E7XRAhfYukj605PaKpaQlbHwSsm0dBhUUI3ZbGaZsvAq
         IG66IpPnIJikSlNkd3VMIp9ZrNAVMlSdW1+yeRvnweTCNH5BxHYk4QtXhwC8/3HCay9U
         is/T5uf2u9eZz9O6Z/XzWm35TL7CxpRR2q5L5umfbV44sOTZV3OewmhRyCScWJBvuLc1
         JY3L7jzsofu8S8LBzoLWOk/JaVuJyHQvujMR9pKzSqxY/qxbkTLGONaAY8LKlxeE3O5+
         2+cCTxSuOBni/eeOXmAQbAfs01oyPCEvoa01QByffgZvVssQi3CvNv7SVu4q5T7dUsbE
         dTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682259975; x=1684851975;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XcKUbMruOsqkDexw5FTEAcEah3bFZ275+DG3/6wvTW8=;
        b=NUVjvVgQrN8+Cw2INDRGRpFLnvY2b5lomZ5J4De7AoBQkO5L962MtgFDgNxMkFDgv1
         Riw5oq4JYwiTJ2Cd1QogAs2KrAtoQqWjSZk6zGffp5ruzvGcjoww+SrN5IetLqItesrv
         6gcme/vlznCfis3vKSsPEBTxUeP/doOd5uEPHGpcoylVuoLPWpD9rEWoQR8qAk1liGow
         X7fO6RSy3Viv8hKdyEl4VkDHcCbNhL8qcCQceGs2XcjwqCE7WDxMkaZNz7hca40dckga
         ZCH+NUDdaxhOK2xhGOGll4Ylj0V+JSr4BxvpaL20A32oSGy5tGCUhKXO0N1rVOy07AIX
         qtzg==
X-Gm-Message-State: AAQBX9fJR7yHijVMuEOMZEFKfYlYEHFVbJFaM8Y9G0Qy+8PIAa/vos1l
        Dq9/Y8vX4J8RX+FAwmSNCcJ3YIPelv4=
X-Google-Smtp-Source: AKy350bECV2TJjOPpxNuCylXi8WPZ9a2W16re5JU0QMDMGE7F881gjqiGD2kc680zy4q+uFraQjL4A==
X-Received: by 2002:a05:6a21:3703:b0:ef:f558:b80 with SMTP id yl3-20020a056a21370300b000eff5580b80mr9228052pzb.58.1682259975239;
        Sun, 23 Apr 2023 07:26:15 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10:5905:623a:c41:59e1])
        by smtp.gmail.com with ESMTPSA id c8-20020a654208000000b00502e7115cbdsm5136838pgq.51.2023.04.23.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 07:26:14 -0700 (PDT)
Date:   Sun, 23 Apr 2023 07:26:13 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Joe Stringer <joe@isovalent.com>, bpf@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, martin.lau@linux.dev,
        bagasdotme@gmail.com, maxtram95@gmail.com, john.fastabend@gmail.com
Message-ID: <644540052bcaa_19af020828@john.notmuch>
In-Reply-To: <20230422172054.3355436-1-joe@isovalent.com>
References: <20230422172054.3355436-1-joe@isovalent.com>
Subject: RE: [PATCH bpf-next v5 1/2] docs/bpf: Add table to describe LRU
 properties
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Joe Stringer wrote:
> Depending on the map type and flags for LRU, different properties are
> global or percpu. Add a table to describe these.
> 
> Signed-off-by: Joe Stringer <joe@isovalent.com>
> ---
> v5: Use bold rather than verbatim for column header
> v4: Initial posting
> ---
>  Documentation/bpf/map_hash.rst | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
> index 8669426264c6..1314dfc5e7e1 100644
> --- a/Documentation/bpf/map_hash.rst
> +++ b/Documentation/bpf/map_hash.rst
> @@ -29,7 +29,16 @@ will automatically evict the least recently used entries when the hash
>  table reaches capacity. An LRU hash maintains an internal LRU list that
>  is used to select elements for eviction. This internal LRU list is
>  shared across CPUs but it is possible to request a per CPU LRU list with
> -the ``BPF_F_NO_COMMON_LRU`` flag when calling ``bpf_map_create``.
> +the ``BPF_F_NO_COMMON_LRU`` flag when calling ``bpf_map_create``.  The
> +following table outlines the properties of LRU maps depending on the a
> +map type and the flags used to create the map.
> +
> +======================== ========================= ================================
> +Flag                     ``BPF_MAP_TYPE_LRU_HASH`` ``BPF_MAP_TYPE_LRU_PERCPU_HASH``
> +======================== ========================= ================================
> +**BPF_F_NO_COMMON_LRU**  Per-CPU LRU, global map   Per-CPU LRU, per-cpu map
> +**!BPF_F_NO_COMMON_LRU** Global LRU, global map    Global LRU, per-cpu map
> +======================== ========================= ================================
>  
>  Usage
>  =====
> -- 
> 2.34.1
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>
