Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D993063BD7C
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 11:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiK2KGQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 05:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiK2KGO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 05:06:14 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7945D6A6
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 02:06:13 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w15so8026790wrl.9
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 02:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d347PGicPnHnSxrHiUKliUhsEGwWWeTMGutskcoO1f8=;
        b=EQZnEFyV6mFuWYFQuEzwyqMFNjQs5N9crFahKpo7263Zh2Nd3ZsoGQxxnHwkT7pEen
         76EdLhcmC+3Ro6CSIHl13rw7Xhu6djlkChnF//XJGsydrFDOIiMEQy56S17I3xZEuFp7
         ZDdICQR0I/7uUIeVP0de6tCQH1LL5uhimWLYHYTvbv6AFPorP1RX5+r3zV19rm9sGXER
         vnsXA20bG1rvRXfXbY8UIuIhgaZI/BNxv1S3dZDFeHLrn7RTpMHGrrsHueHxh0IKe9s/
         xZSUBig4tyAf+xbinrPYxpZqVarHionIOD1W1U1zzgL+oT2p6cbH8Wrya3K+XgVpNk+N
         7oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d347PGicPnHnSxrHiUKliUhsEGwWWeTMGutskcoO1f8=;
        b=LX1/mGZ/ls64bnq1E+XkpkbMSdTSFaLjFdfFIyS+aahfGbUjceSnlgeLD4vG+zizPB
         QXIn5PDRGzD0nFM48QQxPwo5RjZ9mCkkvMp4t6gKYMzNPC33FIp132mw0DpmToGgtbr9
         p59TMe4gpLAc+BrURgWaH2OTnKoGWAdpw1vCmyncDoFTull5Z7tfsj0dUKMo7RVkw0Qz
         wk5sDZ/+bxkWQkcNhpfTA5FCWgH0Ny0OXg42dpRI+IVg1Q4JmpymQ3mPr15BLjjuE9KW
         XTW8Xq+bB0sVuvUZ6Be+VNxlCGSeC9MTiKsGbJu1XJCuc4JZjEk+8GFHQGNJV+UiIOXG
         lI8Q==
X-Gm-Message-State: ANoB5pk0qBvtVpmgDb73kWf0RCpf6xi/GimKTiGYxYCdmJkUSPLqx0tY
        IjupoNoDLXgHrujaoJCtjns9vQ==
X-Google-Smtp-Source: AA0mqf7uqmv4AbHgFCGUCfF/aINhYFGb6bNTPlW8AYXWDL6hu+2EPxT8e41XcOLKCYyw6vOEEc9eTg==
X-Received: by 2002:a5d:628b:0:b0:242:26f0:d395 with SMTP id k11-20020a5d628b000000b0024226f0d395mr200276wru.510.1669716371830;
        Tue, 29 Nov 2022 02:06:11 -0800 (PST)
Received: from lavr ([81.6.34.132])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b003c6c182bef9sm1978757wmq.36.2022.11.29.02.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 02:06:11 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:06:09 +0100
From:   Anton Protopopov <aspsk@isovalent.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 5/8] selftests/bpf: Verify xdp_metadata
 xdp->af_xdp path
Message-ID: <Y4XZkZJHVvLgTIk9@lavr>
References: <20221121182552.2152891-1-sdf@google.com>
 <20221121182552.2152891-6-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121182552.2152891-6-sdf@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 22/11/21 10:25, Stanislav Fomichev wrote:
>
> [...]
>
> +
> +	if (bpf_xdp_metadata_rx_timestamp_supported(ctx))
> +		meta->rx_timestamp = bpf_xdp_metadata_rx_timestamp(ctx);
> +
> +	if (bpf_xdp_metadata_rx_hash_supported(ctx))
> +		meta->rx_hash = bpf_xdp_metadata_rx_hash(ctx);

Is there a case when F_supported and F are not called in a sequence? If not,
then you can join them:

	bool (*ndo_xdp_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);

so that a calling XDP program does one indirect call instead of two for one
field

	if (bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_timestamp)) {
		/* ... couldn't get the timestamp */
	}
