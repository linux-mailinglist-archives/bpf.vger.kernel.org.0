Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97351B56
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfFXTXr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 15:23:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44517 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfFXTXr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jun 2019 15:23:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so15703860qtk.11
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2019 12:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=XF5fVBoylNZT+Rt5eFhQ6Xg4xHbB+c9F4s1NaC6Ff/8=;
        b=slBuDBfqK6xQMQM5Cvpg+kar+TuxY5ENCZYrUkRSvw3aYF54R6FsZR4tZ7r33aatrW
         kL8hhmG689fOfWUngact/Bi33JqpkPkZd598xkgiHL8SD/nQkcCqkVW2QeyUzEaUzaHq
         eH0OJjVVTvCIKg3AVlYklRhdvGhQX5UItH8FYgKIcltmjs8bJQTIXrL0pF9WKH2rg//G
         dx6TxBVsdo/T32Bi5pEICLDCuY54r0FLHVXS1y9F8O/eKU50QSSr6GCm8bo+blraYGry
         vkI9GGOTn+y3KH4TwLsLDSJGGpeyJ3/IaJMJP8EVrl805YoCdyfXfnLtYe/2DE6rDWut
         L5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=XF5fVBoylNZT+Rt5eFhQ6Xg4xHbB+c9F4s1NaC6Ff/8=;
        b=f1eE7sWUFynBNLTeK5F5o/VdDPVGf2JeL2aqnOklXXB8w4RPmp5XM19TSp/Nk8noX/
         IwA1wMxWecnqdx9ZnjTnB0lQV+97lnK+HlHs/TLFz5NrivMKXyTAYhAZmn7eSk//IfNi
         8gbigKr3ljI91ZZK8ox6T5EglggzhGCEz9dUt1qvlt1WG0p0WjRx4ct+7XihQ7Gi7G/c
         jehNE0BmBQD55TU/LzYBn3wLlPmMrgEKiHKDPBZx9GVcxcJL5B5w48hSMbNI3sv01mes
         vXhuoR6kF+vUWS43/rYQqgK/Kq5VdIZ4YwXTcSOXDPe65yxAzUDv4oJXF/xx6GgZ1IBN
         DoUg==
X-Gm-Message-State: APjAAAW3YdsVyWnAjtz9+2RruEKfPWq6hFAIUqi8Ihzw7+5oFyXV1K0w
        N/NQLR7MikkYPy5d6mwNEJtNdQ==
X-Google-Smtp-Source: APXvYqyobHYL/ETH1tbtB7n7voBMNgOjmR0hAIAPGupu4dQsQkjyk9ducas3vFju3400CVWWnyRCGQ==
X-Received: by 2002:a0c:8aaa:: with SMTP id 39mr59788011qvv.17.1561404226506;
        Mon, 24 Jun 2019 12:23:46 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r17sm6144363qtf.26.2019.06.24.12.23.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 12:23:46 -0700 (PDT)
Date:   Mon, 24 Jun 2019 12:23:42 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Kevin Laatz <kevin.laatz@intel.com>
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bjorn.topel@intel.com, magnus.karlsson@intel.com,
        bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        bruce.richardson@intel.com, ciara.loftus@intel.com
Subject: Re: [PATCH 03/11] xdp: add offset param to zero_copy_allocator
Message-ID: <20190624122342.26c6a9b4@cakuba.netronome.com>
In-Reply-To: <20190620090958.2135-4-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
        <20190620090958.2135-4-kevin.laatz@intel.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 20 Jun 2019 09:09:50 +0000, Kevin Laatz wrote:
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 0f25b3675c5c..ea801fd2bf98 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -53,7 +53,8 @@ struct xdp_mem_info {
>  struct page_pool;
>  
>  struct zero_copy_allocator {
> -	void (*free)(struct zero_copy_allocator *zca, unsigned long handle);
> +	void (*free)(struct zero_copy_allocator *zca, unsigned long handle,
> +			off_t off);
>  };

Please run checkpatch --strict on all your changes.  The code
formatting is incorrect in many ways in this series.

Please include performance measurements proving the slow down
is negligible in the cover letter.
