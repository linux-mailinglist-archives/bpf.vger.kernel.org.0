Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C58F484
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfHOT27 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 15:28:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39649 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfHOT27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 15:28:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id 125so2753301qkl.6
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 12:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=qnb1kJVM+ye3vGOEYAiSOgWaI3eqtlq3N9qsMgSh97Q=;
        b=JaxEwRb54HjwKuEneJpNZxQXixF0DRverv10uYcg0cKMh+ECh1y3PYBIoVR8Ow63CY
         /WKKphuy/0ciV1fNmih3/+fh1ESfjqrk8yHo0doVrzNTOxcJMsagAdyXMS8N/hUKLJPO
         ys+xqkbDGaAu2an70dXBKE7/dX6r7CD1hTWHgLBbP8r7EYoOkBUlQbeN2jIMyj9Dysla
         wDX7CxJU3y8ZMIq76PCJUoS7kW/AF751fzeef3qiIS7S2cYClSK9dT24i7ZuQPd5uFoz
         f6s3KOUMGs1sEJvIxWN86ubo0VVUcfS6hyOVGtopxRcSTT/nWToBiiYmv8ZNyyHvpMvH
         Y0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=qnb1kJVM+ye3vGOEYAiSOgWaI3eqtlq3N9qsMgSh97Q=;
        b=ojGBsIyORTuza5C590mvkn7ygxadirqmp1Bf2YLY+M44Mv6t1dhfQIjyyYRbrdKXbT
         EHWVg+MLSTK1xT7Vn5PUBnEZlL9gGGkTNOGMM1AKxJIQA8MIozz55hITFt8x5LI9Mux+
         FWAjD76TRY8X67nZByciypW/1SRVWZ/FGqLRsCg8q70xXGjQx4usr7VgnMuNtHqHwG16
         k0r2eoawuKZ2a2JyIHZ8FAesX6eu9FVB4T5OVQ1MACdpv5Lqpcdg0eWPRSnc/K1qi68x
         t01/RCMhojPaQOnxNCxy8bdx0G60oC9HJX/l5KsBvjSohypnkLOWDRzvnG7qik69fKJN
         jZww==
X-Gm-Message-State: APjAAAVittYmbGxP8/EFzTg/uBaWZz5BA3f0SPN0YKMrNyPXSPwbQAzI
        N3Ac2npg9OljHZvsYmlW7MjTUQ==
X-Google-Smtp-Source: APXvYqwkPh8ov3QUSzCWMxSKt+ziOPYpJfoCxehX3GtP2xT/V0Zjj4WnEp5aVw6Y7vkICXjTGBM3Aw==
X-Received: by 2002:a05:620a:100c:: with SMTP id z12mr5528461qkj.279.1565897338446;
        Thu, 15 Aug 2019 12:28:58 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id x3sm1885999qkl.71.2019.08.15.12.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 12:28:58 -0700 (PDT)
Date:   Thu, 15 Aug 2019 12:28:44 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
        tom.herbert@intel.com
Subject: Re: [PATCH bpf-next 0/5] Add support for SKIP_BPF flag for AF_XDP
 sockets
Message-ID: <20190815122844.52eeda08@cakuba.netronome.com>
In-Reply-To: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
References: <1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 14 Aug 2019 20:46:18 -0700, Sridhar Samudrala wrote:
> This patch series introduces XDP_SKIP_BPF flag that can be specified
> during the bind() call of an AF_XDP socket to skip calling the BPF 
> program in the receive path and pass the buffer directly to the socket.
> 
> When a single AF_XDP socket is associated with a queue and a HW
> filter is used to redirect the packets and the app is interested in
> receiving all the packets on that queue, we don't need an additional 
> BPF program to do further filtering or lookup/redirect to a socket.
> 
> Here are some performance numbers collected on 
>   - 2 socket 28 core Intel(R) Xeon(R) Platinum 8180 CPU @ 2.50GHz
>   - Intel 40Gb Ethernet NIC (i40e)
> 
> All tests use 2 cores and the results are in Mpps.
> 
> turbo on (default)
> ---------------------------------------------	
>                       no-skip-bpf    skip-bpf
> ---------------------------------------------	
> rxdrop zerocopy           21.9         38.5 
> l2fwd  zerocopy           17.0         20.5
> rxdrop copy               11.1         13.3
> l2fwd  copy                1.9          2.0
> 
> no turbo :  echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
> ---------------------------------------------	
>                       no-skip-bpf    skip-bpf
> ---------------------------------------------	
> rxdrop zerocopy           15.4         29.0
> l2fwd  zerocopy           11.8         18.2
> rxdrop copy                8.2         10.5
> l2fwd  copy                1.7          1.7
> ---------------------------------------------	

Could you include a third column here - namely the in-XDP performance?
AFAIU the way to achieve better performance with AF_XDP is to move the
fast path into the kernel's XDP program..

Maciej's work on batching XDP program's execution should lower the
retpoline overhead, without leaning close to the bypass model.
