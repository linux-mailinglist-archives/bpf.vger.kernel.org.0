Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32DE4D6790
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 18:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350738AbiCKR0p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 12:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350358AbiCKR0p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 12:26:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F4B71ED5
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 09:25:42 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id r12so8209625pla.1
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 09:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QxcnJJvBNCY+bGfnFgLArG30Rx8eamlF+KA/wCgp2ak=;
        b=sRCgtqRwTdMHtzhNI7YQxf++43csWqxxhxHiIWZUApUDmTYDJj6RFA3fKtOLrA6TRZ
         us6iW/6dQnVO9b1lfj1tYw12dO15MDaYQE6sKJczkNASZFF9D4quSBe5hBiC9syF6uf8
         2HV4UTD2g3FVMUTUeZWvo0Wtp0D2MsxbQTACr31G+le84FCm8bfgQLOHMy9SYT0YGysB
         2iCxbNK47qhvPHQKQhKOr4b91cjsrKCQFsNzdTF1OQff4gEOnwDyMqeA/g4Kg0NkQsSW
         87XI4DbRm5XxB7QmhHK3c7Gd9kSjw4M+inl8695FsRfLk3tAfEAegD2HG0+rziACkca2
         /ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QxcnJJvBNCY+bGfnFgLArG30Rx8eamlF+KA/wCgp2ak=;
        b=EsjClicXobtb0PkA6iuowSYXIm1iqmR56Ad/0H5WUtaH45m9C1NmhluruHjXRQQoA2
         RNu0RvvrDnSRCPugpvhzxn1evuQcYhfqV5gLOM1YTZJvxbQLCTwg6rCPPC1WjPMO6kLZ
         y938yNBzRfK00t1usGUiYqKtYDJfVHcq90AmI3tSQiLQPe/cLqpDD53d+KKQ3cAHQQRv
         UmcNJcgjsTlpAk1VlREBaQc4CPOTxTyGFlSHEnScb5GZGyvjBavivEFex7Y5blY+TcK2
         2HTA6hRf+qIEgX+9DGjwGkuDJmpvKSzD2rjbc3opVc1qjWZpi0u0k9Hoovqvi3LsOP81
         gN+g==
X-Gm-Message-State: AOAM532hKXeUCRZN4E2EBhfoCBb7YBzV90EO1PqOiTyUN0EwBseZDI5u
        bJByPFVhCQNpnG4L6guK9o8oeQ==
X-Google-Smtp-Source: ABdhPJzrbt6D2XQuVil7KpcYtFucz4BGvOQxIezfqXq84jqtbTpP4Bi8DbC26FKdK98HEcgNv8MtgA==
X-Received: by 2002:a17:902:e5ca:b0:152:54c1:f87f with SMTP id u10-20020a170902e5ca00b0015254c1f87fmr11485758plf.59.1647019541529;
        Fri, 11 Mar 2022 09:25:41 -0800 (PST)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id v14-20020a056a00148e00b004e1cee6f6b4sm12178835pfu.47.2022.03.11.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:25:41 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:25:38 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] hv_netvsc: Add check for kvmalloc_array
Message-ID: <20220311092538.0cb478cf@hermes.local>
In-Reply-To: <20220311032035.2037962-1-jiasheng@iscas.ac.cn>
References: <20220311032035.2037962-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 11 Mar 2022 11:20:35 +0800
Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:

> As the potential failure of the kvmalloc_array(),
> it should be better to check and restore the 'data'
> if fails in order to avoid the dereference of the
> NULL pointer.
> 
> Fixes: 6ae746711263 ("hv_netvsc: Add per-cpu ethtool stats for netvsc")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 3646469433b1..018c4a5f6f44 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -1587,6 +1587,12 @@ static void netvsc_get_ethtool_stats(struct net_device *dev,
>  	pcpu_sum = kvmalloc_array(num_possible_cpus(),
>  				  sizeof(struct netvsc_ethtool_pcpu_stats),
>  				  GFP_KERNEL);
> +	if (!pcpu_sum) {
> +		for (j = 0; j < i; j++)
> +			data[j] = 0;
> +		return;
> +	}

I don't think you understood what my comment was.

The zeroing here is not necessary. Just do:
        if (!pcpu_sum)
               return;

The data pointer is to buffer allocated here:

static int ethtool_get_stats(struct net_device *dev, void __user *useraddr)
{
...
	if (n_stats) {
		data = vzalloc(array_size(n_stats, sizeof(u64)));  <<<<< is already zeroed.
		if (!data)
			return -ENOMEM;
		ops->get_ethtool_stats(dev, &stats, data);
