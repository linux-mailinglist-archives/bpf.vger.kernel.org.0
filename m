Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CFE67BDFE
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 22:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbjAYVSS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 16:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbjAYVSO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 16:18:14 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20297279BD
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:17:55 -0800 (PST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 43BA63F2D8
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 21:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674681473;
        bh=4XXPsquE4crqlP/f8SYeV9AApmFeElABtLmoY87F+y0=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=FJOjr1RsqytqspTDTV2vWTfWQ3dIPxHttb1mi0+pVIbBendAuuEyUaS52FhQ90NyE
         zV72X3Gq5xKYAhUEZcAhS8xSjVcbyMRBvyy+K1CNzB3Lk8o7hRrdar1hqyuoIgcuXm
         uqiKaELKLRtpHxwS48trqTnH/gVpXEf+bEU2JohqS2Uio91AE3DgWUtcE9sbrKSVK0
         IM/oe/V4arBiG/yvKiTSa3NlIZbN3tAa/VAaw3TNmrAVlgfEDeBvqRw3p90eeLc2Di
         w/2ArN9pN0HlKtSZw6+UvJsS22XHViqHgifFDw92eKLP1NKdStkkDrVAPsO8clZ+un
         g6llqlYO17GtA==
Received: by mail-wr1-f72.google.com with SMTP id o9-20020adfa109000000b002bfc062eaa8so268582wro.20
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 13:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XXPsquE4crqlP/f8SYeV9AApmFeElABtLmoY87F+y0=;
        b=yjjF/z8YSLyXmqjorvY1dsGxvyVPfo0ZzEMgGE3iOgXTKpvNVHP1MVa7IRP7hfzZj2
         wc6yU9wnBvjCAhvn7XLPgPvmvAsYheifzq+STtIuYc284oh1G4pKTQx7E8Yd6UKcU0u0
         9UzUgN4PU0U946oNd4J4YtlLpOltZx/AvynPl8d6AxgndSCJdpGt63hkZ95e2ws7y3AS
         Qv+PcUceAXzqEZShJGLa7/vOUxIOm05HqoOf22tFm8RmXRAvGs4RePTI8Y06P6FHaw3/
         OmKP7fFCUObyadGan1TqQbejbMmyolvsthfZ/ZSjjF57r0YJtTHqx5dBFOC+7Vo/AOk1
         1RvA==
X-Gm-Message-State: AFqh2kqGbA73KArhdaLyRuwP+c1CqiKhZbAYzZmb9N5fP+CBXSkH10QM
        LnjH1gSCLqMnXO7t0qgvSG0Pwxo617Sdqg2Y7WpYhJEh3Zuce1zZkP9XNuPwNHJuhf3lkCSTTTt
        MK5UJOmMTmkGWosAQ3i68J6XN2VAggQ==
X-Received: by 2002:a05:600c:5025:b0:3db:14dc:8cff with SMTP id n37-20020a05600c502500b003db14dc8cffmr28600086wmr.33.1674681472864;
        Wed, 25 Jan 2023 13:17:52 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvaUhjYEizwZIqGzcq/BvdHDsNuG4S6o9rLtFKw1MWoycAbAqXFjWVBeJcDZtzALgn7VapqkQ==
X-Received: by 2002:a05:600c:5025:b0:3db:14dc:8cff with SMTP id n37-20020a05600c502500b003db14dc8cffmr28600077wmr.33.1674681472715;
        Wed, 25 Jan 2023 13:17:52 -0800 (PST)
Received: from qwirkle ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c500d00b003db2b81660esm3044957wmr.21.2023.01.25.13.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:17:52 -0800 (PST)
Date:   Wed, 25 Jan 2023 21:17:50 +0000
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: net: Fix missing nat6to4.o when running
 udpgro_frglist.sh
Message-ID: <Y9GcfuZloWqRf5Hf@qwirkle>
References: <20230125170845.85237-1-andrei.gherzan@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125170845.85237-1-andrei.gherzan@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 05:08:44PM +0000, Andrei Gherzan wrote:
> From: Andrei <andrei.gherzan@canonical.com>
> 
> The udpgro_frglist.sh uses nat6to4.o which is tested for existence in
> bpf/nat6to4.o (relative to the script). This is where the object is
> compiled. Even so, the script attempts to use it as part of tc with a
> different path (../bpf/nat6to4.o). As a consequence, this fails the script:
> 
> Error opening object ../bpf/nat6to4.o: No such file or directory
> Cannot initialize ELF context!
> Unable to load program
> 
> This change refactors these references to use a variable for consistency
> and also reformats two long lines.
> 
> Signed-off-by: Andrei <andrei.gherzan@canonical.com>

I have sent a v2 that fixes SoB and From.

-- 
Andrei Gherzan
