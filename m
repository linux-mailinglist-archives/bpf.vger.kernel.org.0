Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B766B4DBE8B
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 06:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiCQFkC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 01:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiCQFkC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 01:40:02 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E640A277972
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 22:09:33 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v15so3584679qkg.8
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 22:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=XljFdoUfWopAfbGRep/wzfODzZ++uTnnGQSwefGABRY=;
        b=kD9apftEEKvPe+i9VML3fekJl9p6R59ielKjRp/fuRfGHZmcnTaN+8pmdYztLbV9Sa
         KLjo7jCqJ9Jdpi6y3crN3gn9DSNRzaTnuKP63Xs984Y35OhAKiPuc1aQ0YP1Nop5aNyT
         iRylZyQKH2nYvosMTpvJyVCCijMWXfhCqlr7cKv19LzpFSIpT8kgwx9FSy7UD34krMul
         OGaBJ+qV2strYLgLYUDaDsqMIyTFh2G5P1h1nX4O/2OKRgesDtXIwb7jvMoGlXfyLarV
         THPVOrzwZPucg85BxxaqnwZZFmmgS3HuKFyyxZ/0ZoZumYofeskNF8DeriiZUChk1bJk
         fxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=XljFdoUfWopAfbGRep/wzfODzZ++uTnnGQSwefGABRY=;
        b=YdhKR68JWJ6J+RNCXdHQdotV2RakClOdMkBuzpTcIazhqEcy8xXvo5pL5x4x9SW6e3
         ZmfZ6TMHs1pkTQEnEjHJgOWeizN8aUNVtfQBLscv5FoA6CyXsi4Z0dzAmV+MkXPZDREa
         okJZm4ACsuCtZ7vLF/dq8GpP7B+S0xwwVzdP+EYraugO1SiKTCPai94W9GSTEBXN/xdC
         a77N39Ntz84H8zBY0AYbmBgdPhSBVg8CKV2cvC9CPaEAUU25UfMZbans/SuyB2GihDgp
         W8InB0fNT35iWznNpBV9x+ABu8MRJjqs42UC1Y5XUAYk6Jjo8WcZjvZp1oVif0O/8PO0
         aNuA==
X-Gm-Message-State: AOAM532QJxQbx41KI3k+RT4XhD0ax54N35ZISh5Um34PjteSGZb+7toL
        ZYhZgTgknTJQv2LkzP6Vfp9qdAsUSLiANQ==
X-Google-Smtp-Source: ABdhPJwnIbyZMHNdtk/8OH7P4lVUvZeb2zaaIZmYXlGiPlRiL2b0C6eNhZMzPMuLS5A8u2kfvsPaqA==
X-Received: by 2002:a05:6638:4089:b0:319:b60c:3c3d with SMTP id m9-20020a056638408900b00319b60c3c3dmr1173163jam.120.1647489441061;
        Wed, 16 Mar 2022 20:57:21 -0700 (PDT)
Received: from localhost ([99.197.200.79])
        by smtp.gmail.com with ESMTPSA id 201-20020a6b14d2000000b00640df82a01csm1995884iou.3.2022.03.16.20.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 20:57:20 -0700 (PDT)
Date:   Wed, 16 Mar 2022 20:57:14 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     fankaixi.li@bytedance.com, shuah@kernel.org, bpf@vger.kernel.org
Cc:     "kaixi.fan" <fankaixi.li@bytedance.com>
Message-ID: <6232b19a306b2_3ed720828@john.notmuch>
In-Reply-To: <20220313164116.5889-1-fankaixi.li@bytedance.com>
References: <20220313164116.5889-1-fankaixi.li@bytedance.com>
Subject: RE: [PATCH] selftests/bpf: fix tunnel remote ip comments
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

fankaixi.li@ wrote:
> From: "kaixi.fan" <fankaixi.li@bytedance.com>
> 
> In namespace at_ns0, the ip address of tnl dev is 10.1.1.100 which
> is the overlay ip, and the ip address of veth0 is 172.16.1.100
> which is the vtep ip.
> When doing 'ping 10.1.1.100' from root namespace, the
> remote_ip should be 172.16.1.100.
> 
> Fixs: 933a741e ("selftests/bpf: bpf tunnel test.")
> Signed-off-by: kaixi.fan <fankaixi.li@bytedance.com>
> ---
>  tools/testing/selftests/bpf/test_tunnel.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
> index ca1372924023..2817d9948d59 100755
> --- a/tools/testing/selftests/bpf/test_tunnel.sh
> +++ b/tools/testing/selftests/bpf/test_tunnel.sh
> @@ -39,7 +39,7 @@
>  # from root namespace, the following operations happen:
>  # 1) Route lookup shows 10.1.1.100/24 belongs to tnl dev, fwd to tnl dev.
>  # 2) Tnl device's egress BPF program is triggered and set the tunnel metadata,
> -#    with remote_ip=172.16.1.200 and others.
> +#    with remote_ip=172.16.1.100 and others.
>  # 3) Outer tunnel header is prepended and route the packet to veth1's egress
>  # 4) veth0's ingress queue receive the tunneled packet at namespace at_ns0
>  # 5) Tunnel protocol handler, ex: vxlan_rcv, decap the packet
> -- 
> 2.24.3 (Apple Git-128)
> 

checks out.

Acked-by: John Fastabend <john.fastabend@gmail.com>
