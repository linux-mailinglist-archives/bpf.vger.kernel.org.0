Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E284726D626
	for <lists+bpf@lfdr.de>; Thu, 17 Sep 2020 10:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgIQINl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Sep 2020 04:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIQING (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Sep 2020 04:13:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3D7C061226
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2020 01:03:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so1052123wmi.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2020 01:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TUShtxADeMIRUv08jDyFnIdO2h4AVdi1g89uLOtrWXw=;
        b=Xm9muXpLMfdw+3JTaQ5+6nxJDSneO0K8th2wgQ0VLh2VI2BmK+XWoQ9cDtIn8+KaRJ
         B45Xbntr5JjNU8mF7nIZd8VP+CTHviEtF1Um5VazOhr6GEQCgh9bbRNIM6C+XWioNjmk
         ImuOo8Gi8eD0FtSQ7hHZ1yPAo82BLFHJwGGg0UxKCYs0oMSSpMWIe45dJUN+DzUELaKQ
         JzvvcS8KVPQMZJTfgm/lLBewbBl9UGKGHM3XV6hYGQwunOqgCSfJKO8sQaLl1M6X9BRD
         K+XM2hJttDJQqNZl5Xftk9yd2fnhmTZR2ol6vfSH0itoQkT2+o/FcX7saxpuLl0f47l5
         EzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TUShtxADeMIRUv08jDyFnIdO2h4AVdi1g89uLOtrWXw=;
        b=KmS9G6Qs5eGsXZB6rh6j43s06wGVcx0wCHRCDHTp4LseifLoq9xRKZSMPFEQb2RdtA
         966mjAiz90fKvAlp9/BzfzZN16eJCCQ1zByVLCNMi4JKR2tL/G76gHgGYEKFRlBHN6bM
         nVptjMXqhvrpbwaSKYU35sKtREeVT4/f5FAzHHIKYr/n4q5Wj1/1Jzu70TfBcpy14o+z
         d1AmG+/w8WOM5BNxdW0F9C8VUAD6LHAQMbobHBJ7MSl1riyl3+PSGOmkRtqeRAGwqKSc
         IVgxfY3/qNNev1kV48yYqvnJb5e2T3cz6oCLaNUPUZJLil3Yf29NVHSi1KMlnkSSf0Cj
         +JfQ==
X-Gm-Message-State: AOAM533bHK/1bktxKB4Ws6OkCawKADzl+OzKgPLnTGgoQ5dSkexcGH+n
        ZyyiHLEw0Z0nQG+CDMUDXSkcwpZxx656ZIDq
X-Google-Smtp-Source: ABdhPJzTwzfeJOnCQh65prZummqH9JR09Yxja+zvv2OTSAZpPcom4k7xuvXSyH3Yv50qn/8+2aIWyQ==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr8793930wmg.33.1600329817598;
        Thu, 17 Sep 2020 01:03:37 -0700 (PDT)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id a13sm9836030wme.26.2020.09.17.01.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 01:03:36 -0700 (PDT)
Date:   Thu, 17 Sep 2020 10:03:35 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Kees Cook <kees.cook@canonical.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, dm-devel@redhat.com,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        oss-drivers@netronome.com, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-scsi@vger.kernel.org,
        storagedev@microchip.com, sparclinux@vger.kernel.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, bpf@vger.kernel.org,
        dccp@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-sctp@vger.kernel.org,
        alsa-devel <alsa-devel@alsa-project.org>
Subject: Re: [oss-drivers] [trivial PATCH] treewide: Convert switch/case
 fallthrough; to break;
Message-ID: <20200917080334.GB5769@netronome.com>
References: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 01:06:39PM -0700, Joe Perches wrote:
> fallthrough to a separate case/default label break; isn't very readable.
> 
> Convert pseudo-keyword fallthrough; statements to a simple break; when
> the next label is case or default and the only statement in the next
> label block is break;
> 
> Found using:
> 
> $ grep-2.5.4 -rP --include=*.[ch] -n "fallthrough;(\s*(case\s+\w+|default)\s*:\s*){1,7}break;" *
> 
> Miscellanea:
> 
> o Move or coalesce a couple label blocks above a default: block.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

...

> diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
> index 252fe06f58aa..1d5b87079104 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c
> @@ -345,7 +345,7 @@ static int matching_bar(struct nfp_bar *bar, u32 tgt, u32 act, u32 tok,
>  		baract = NFP_CPP_ACTION_RW;
>  		if (act == 0)
>  			act = NFP_CPP_ACTION_RW;
> -		fallthrough;
> +		break;
>  	case NFP_PCIE_BAR_PCIE2CPP_MapType_FIXED:
>  		break;
>  	default:

This is a cascading fall-through handling all map types.
I don't think this change improves readability.

...
