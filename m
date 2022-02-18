Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6835C4BB3A1
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 08:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiBRHzN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 02:55:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiBRHzM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 02:55:12 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1026EC5597
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 23:54:57 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s24so7595556edr.5
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 23:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/c7X9q/HtkYc7IBv2SRx8XqKDC3hbzOQDSeLDKW4Ja0=;
        b=StkExcZkjZg8vZMxsmZXnfhe2ziWmzAKAloNXhhbqrhERfYemmtS+c4lEfG4aLF2gC
         zXPGaMXzA7L2rZjZGnEn2+OL99Q8iGiMtyCo904u6dNteau2WEOmgw/sk5h7JteB/uRV
         AyaG0ZhUN7/go5i7oXmnIFf0acdqBrrj+aV397LSdLgBC3Ybc8LK4TQkyTANWVjUu+8Z
         M0YlAilwOFk+VL3wgj2ExEaD5Zj1TdbhBpnbClTtp5IPP3YkNWfmGp5tUAQrT6B6S5PH
         +b3p928Xo6GixOYg3pi8RDD8ydNwH841c/u8+FZfRxk2TVhxEvf7GlaJiZ3Sby3uxKMa
         mzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/c7X9q/HtkYc7IBv2SRx8XqKDC3hbzOQDSeLDKW4Ja0=;
        b=c9Qtmffajw90eq6mFoPsHuHNanDJvgM1vPiW4T86diBTH45HPT+U2wQ7tfDZXgyFBT
         vdOnJYhr/U5gRd4gk48qVpGUelonDn3xY2ZKvwT8W5hs2ZHZtOU6tT6AEwhKFC9frZFE
         K7lvBDYJtFUX18tfWCetgj2H6FB1pqaHwEfuwkvb9H82CFrzSpGBbjxBBgmDAN2q7Iur
         AvmuZN1eajbVm92uamV48/KfOmmryCPBc9IhmzOHuXGpQp65sSO3o+6tTZQh3Z/w5ygK
         JpRmUXFQUy+rPsjLQEI3T/4FI3kpebFrv8sxO5mcQizbD+CCn+zHGt9sElOn1RDKvc2s
         E8dQ==
X-Gm-Message-State: AOAM530v9Az3rqO1zXpJhdzFKvSXBDtO1wR4MBWKvTLIST4cgl+myEvz
        91rkX7817Q2IWef1BRs1Rj6aR6NMxJSdtQ==
X-Google-Smtp-Source: ABdhPJzIKxPBOU3YX6wkRaWEShUldOfUbWNgiI99V3Jr4xLJQmFjEmwr6hujpVR9xcktKvbFsXzK/g==
X-Received: by 2002:aa7:d648:0:b0:412:b567:3664 with SMTP id v8-20020aa7d648000000b00412b5673664mr3362086edr.296.1645170895554;
        Thu, 17 Feb 2022 23:54:55 -0800 (PST)
Received: from erthalion.local (dslb-178-012-046-224.178.012.pools.vodafone-ip.de. [178.12.46.224])
        by smtp.gmail.com with ESMTPSA id b14sm1956717ejb.160.2022.02.17.23.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 23:54:55 -0800 (PST)
Date:   Fri, 18 Feb 2022 08:54:33 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
Subject: Re: [RFC PATCH v3] bpftool: Add bpf_cookie to link output
Message-ID: <20220218075433.e6v6t5oyretfvk6p@erthalion.local>
References: <20220218075103.10002-1-9erthalion6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218075103.10002-1-9erthalion6@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Fri, Feb 18, 2022 at 08:51:03AM +0100, Dmitrii Dolgov wrote:
> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> BPF perf links") introduced the concept of user specified bpf_cookie,
> which could be accessed by BPF programs using bpf_get_attach_cookie().
> For troubleshooting purposes it is convenient to expose bpf_cookie via
> bpftool as well, so there is no need to meddle with the target BPF
> program itself.
>
> Implemented using the pid iterator BPF program to actually fetch
> bpf_cookies, which allows constraining code changes only to bpftool.

I have to admit, with pid iterator it looks a bit clumsy. Would love to
know if there is a better way.
