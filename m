Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073D9611E0B
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 01:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ1XU6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Oct 2022 19:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1XU5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Oct 2022 19:20:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8FB1B1562
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 16:20:55 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g62so5994061pfb.10
        for <bpf@vger.kernel.org>; Fri, 28 Oct 2022 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Uzk3Lk212hyHZBLwlj2n7xSyIpu4M+s529OGHEaZT0=;
        b=B8aWKoOO0GoF8AiUGXJozKzeXmiazZMi08nQIIgI1vQ+juvz74hqj4aAg8aEcxN0AQ
         Ugbz1xQtwy0oz4bObXoA6is/lIM9SMw9XhNEn5ovDTngCf47wJ1SJzt+8SVQ6ZfoQKfr
         UhujcdG4hNCAL0zY8YwK6j9xPElcapgf1AoGrM82509Kn7I0jPZLZT0s0Sn4HFe3BtOM
         gJ+iOMI3hcjf+4sTvO2DhsfpT4rdyqZleA5cVRh05PxtVTQunobl2N3MwJUXHFSqw01s
         xhnOXEauJqFqE8pm1KuyieWEffxdBGD6wtyU8VZnay2GG/CK7uykJ8/ml+o0YtQg/wJY
         CAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Uzk3Lk212hyHZBLwlj2n7xSyIpu4M+s529OGHEaZT0=;
        b=pNbhIxCEvkNIMtOm+9s5ZywfVHeGuez2I7LbIDKZ5DNR0u+Pz/jj+UFDSNt8jhdtwi
         Pe3co4Wzwizef6YOO4xYmDGsMm3eAR38KYeaphVNzb6iL5yqjj1msyfHJ6FXjFQHnERN
         3cldbczCYovXDXIq4G1FwwzgMlvJSfATWhQ8J1e8UOWLVd+IBuSa0bCzP4DtNXR0lkNa
         82s8yPsDXQo+2Py1AwBzT4b+risO0pAh+pm+KouFqqlfn7X75Ep8eDP42hKSt+0AIE/l
         t5po3FN+eQZs1nMNevlGMQGoF6O3hqheWVWvKuEi/QoOghXN7ZKE79fqzea8fa7RPqiQ
         BMTw==
X-Gm-Message-State: ACrzQf255/46Q8cuisUQhUCo/Nldx0ihB0WmtzaBUNYUTCUL2VjoC6gp
        W5IOlM/ze2MS1/F84oqeaGLDggNyiX5bxQ==
X-Google-Smtp-Source: AMsMyM7J/tsteH1ahjJmE1q/+uXd5BRjzt8zY+i9ncugk2gkEyO6xt3FrVzRawEoWTV6BW4JCE/1JA==
X-Received: by 2002:a65:6951:0:b0:42b:b13:b253 with SMTP id w17-20020a656951000000b0042b0b13b253mr1693104pgq.555.1666999254731;
        Fri, 28 Oct 2022 16:20:54 -0700 (PDT)
Received: from localhost ([98.97.41.13])
        by smtp.gmail.com with ESMTPSA id w35-20020a634763000000b0046ef0114367sm3210347pgk.71.2022.10.28.16.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:20:54 -0700 (PDT)
Date:   Fri, 28 Oct 2022 16:20:52 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Florian Lehner <dev@der-flo.net>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, Florian Lehner <dev@der-flo.net>
Message-ID: <635c63d4d8ad2_b1ba20896@john.notmuch>
In-Reply-To: <20221028183405.59554-1-dev@der-flo.net>
References: <20221028183405.59554-1-dev@der-flo.net>
Subject: RE: [PATCH bpf-next v2] bpf: check max_entries before allocating
 memory
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Lehner wrote:
> For maps of type BPF_MAP_TYPE_CPUMAP memory is allocated first before
> checking the max_entries argument. If then max_entries is greater than
> NR_CPUS additional work needs to be done to free allocated memory before
> an error is returned.
> This changes moves the check on max_entries before the allocation
> happens.
> 
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---

LGTM.
 
Acked-by: John Fastabend <john.fastabend@gmail.com>
