Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4A169E916
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 21:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjBUUoD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 15:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBUUoC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 15:44:02 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC3BDBD2
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:44:01 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id w23so5744456qtn.6
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaXXq+Hlml7j9WAFCv8jGX2idvH4Mv1E04K/qDL2BGg=;
        b=bfj9YA1EiNwbYzcSWoFAqNGROGYCjhuC1IhQGwNTssPupS6P/OCYBMUV2RSty73giu
         ZuKNslrQw8XggdFTK0GvrzBxK6Y1MGWhdEzr1ICal8GGy26sv6igQjn0cAKrRg6e1496
         2dhJm5jz0KB+yS1IIWB8uslF7Sbwe9MU+tKWo2rXX4ieDRoPJBRsmYeoIvmCRHp4Z1sU
         EPV8u5ykzGTYh6zzQxxvaMgO0bk0j5SAlVx0+7RyH1zUG4kJzUfXaBRmC5i9yCZojppH
         3qpr2FZA5/L0btkcuFh+FxWCXlX5q+yNQqqBMka0TSZCTTPa6nxnmuNNEFPecURRuesa
         DS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VaXXq+Hlml7j9WAFCv8jGX2idvH4Mv1E04K/qDL2BGg=;
        b=e321MiMxHx6l5Llhhg4q1jsvB7/ckdqwQcRqa7wGt1vec5m07/NDY5Gt23miZ6hihr
         UrEN7htPYSMsxMKuj58H4LNLn/IqYGXJvtIqyZp/LdkVpUcRsmRISXYQ3ssESAgvJJUG
         OnIgSu9bg99OQgz/9tiZwoBmXirvK7oMvWfnqcSTllQtSnmwAR0MSf1TskzVvi8tnXw+
         fEulQih9a0JzK1zDtG3b81e90F79D9vnID9N+OUyDi+BjFKYilV5b4KDrj09IVCkeoXE
         EoFGAupReC9A9aCAfGKFO/JtE2r+053px3BeIMC3dn3gXU0xAsLighEnXgsiaRVF110F
         fNoQ==
X-Gm-Message-State: AO0yUKXAs2ckpokKNYlGxJrkZ5A+5YLRx9k+UADV5kL3b87FC5Z8Ik6O
        dRmhvdQtw4V8umcbml8rrwAo2eifc9Q=
X-Google-Smtp-Source: AK7set9o0KLIOk6mMwP/oEvkfYZFSCiiEsPRLpWqPSxVNX3OZ+vwSRKSEmkfEhX3shMwtLdx6j0aPQ==
X-Received: by 2002:ac8:5c82:0:b0:3b8:67c4:b11d with SMTP id r2-20020ac85c82000000b003b867c4b11dmr24354335qta.49.1677012240489;
        Tue, 21 Feb 2023 12:44:00 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id j64-20020a378743000000b00739e7e10b71sm11517482qkd.114.2023.02.21.12.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:44:00 -0800 (PST)
Date:   Tue, 21 Feb 2023 15:43:59 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Message-ID: <63f52d0fe8351_1409c0208a3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230221180518.2139026-1-sdf@google.com>
References: <20230221180518.2139026-1-sdf@google.com>
Subject: RE: [PATCH bpf-next] selftests/bpf: Fix
 BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL for empty flow label
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

Stanislav Fomichev wrote:
> Kernel's flow dissector continues to parse the packet when
> the (optional) IPv6 flow label is empty even when instructed
> to stop (via BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL). Do
> the same in our reference BPF reimplementation.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Willem de Bruijn <willemb@google.com>

Thanks for fixing this. We do want entropy if L4 is available.
