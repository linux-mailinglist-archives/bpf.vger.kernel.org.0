Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB5D04E0
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 02:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfJIAtd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Oct 2019 20:49:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35537 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfJIAtc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Oct 2019 20:49:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15so996044qtq.2
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2019 17:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=WepzXzTte12+Zryhvz2uw0bMesLDlFuZ+ZK8LrsbFP8=;
        b=WLi5KXz05pP7Sw00jeg4x93ZWXH/C6pfztk/5QvWfSZksh9esr+ycyHrT7rawNs9/8
         n35C1eYJgi7afekoIsrjbjNBM/4kMK9tAITBX+j/MuUzbmog8fuqzRma4RIh9kGdYzvD
         rbvoaV+km+gVgQh47VZKtwugXG4yybAfxtaNmXErr8rOI8CTZODNBZrkw67SFmxZbfAs
         xVgm2jcP41pZ/P1dXLBd7MxAjGOLgh27CS70kNccuu8XIlRB8edEln8LN3a1/ptBvMAa
         2imGOUyf0heWM7Yfq/ufaoZGXF8jICJfrRRo4pFIzYplcejR7607jJrj2hCSW5a2laCE
         oKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=WepzXzTte12+Zryhvz2uw0bMesLDlFuZ+ZK8LrsbFP8=;
        b=GTYqqH3mgm6+DRiLEUjUGdTYWqjTwGZTu9ftWlBZpbpmvHtN4gQpsHaHaO2XBZmpLn
         EYXq3Z3GSGOfEBUY1JYPY2s8SjgRymFvcczcOFb9XkX/cm6KlGo4Myes1PZDLxifjSpa
         pA5f+fqBOul9uXbBgnXOm4tq2A/DWj7nJ+XveLxQmcUKuW1t2UkycGUlWpzJv63FlGL8
         w6YPOoNxKYxGDXBQQs6pNsUmCCZSdNNFx2PlMpm9q6Chdml0xc/u6WG68PP2zx0Yel0x
         k4to7Bpwro7kRmg7fin3l9COlpNGjjZk+ofTCXzUPczewAC3lJavxJpX1gRxHqh6UVnA
         3W6Q==
X-Gm-Message-State: APjAAAXBOY3PvbcrIr9jVMqHpM+INaRDwG91aNl+9GRBXSr1otlUGmRO
        hNBIJFISHQAZGJ5dZpD8O3JhSA==
X-Google-Smtp-Source: APXvYqzYhnSh3SLldsjxkUvyH1tg1oDkQ38sFtBZHRZ9gtflcgiSDdeGd+lNzYFjWKyCOI4rtfDmhw==
X-Received: by 2002:a0c:b59b:: with SMTP id g27mr1135087qve.184.1570582171452;
        Tue, 08 Oct 2019 17:49:31 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id x19sm212674qkf.26.2019.10.08.17.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 17:49:31 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:49:19 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
        tom.herbert@intel.com
Subject: Re: [PATCH bpf-next 0/4] Enable direct receive on AF_XDP sockets
Message-ID: <20191008174919.2160737a@cakuba.netronome.com>
In-Reply-To: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon,  7 Oct 2019 23:16:51 -0700, Sridhar Samudrala wrote:
> This is a rework of the following patch series 
> https://lore.kernel.org/netdev/1565840783-8269-1-git-send-email-sridhar.samudrala@intel.com/#r
> that tried to enable direct receive by bypassing XDP program attached
> to the device.
> 
> Based on the community feedback and some suggestions from Bjorn, changed
> the semantics of the implementation to enable direct receive on AF_XDP
> sockets that are bound to a queue only when there is no normal XDP program
> attached to the device.
> 
> This is accomplished by introducing a special BPF prog pointer (DIRECT_XSK)
> that is attached at the time of binding an AF_XDP socket to a queue of a
> device. This is done only if there is no other XDP program attached to
> the device. The normal XDP program has precedence and will replace the
> DIRECT_XSK prog if it is attached later. The main reason to introduce a
> special BPF prog pointer is to minimize the driver changes. The only change
> is to use the bpf_get_prog_id() helper when QUERYING the prog id.
> 
> Any attach of a normal XDP program will take precedence and the direct xsk
> program will be removed. The direct XSK program will be attached
> automatically when the normal XDP program is removed when there are any
> AF_XDP direct sockets associated with that device.
> 
> A static key is used to control this feature in order to avoid any overhead
> for normal XDP datapath when there are no AF_XDP sockets in direct-xsk mode.

Don't say that static branches have no overhead. That's dishonest.

> Here is some performance data i collected on my Intel Ivybridge based
> development system (Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz)
> NIC: Intel 40Gb ethernet (i40e)
> 
> xdpsock rxdrop 1 core (both app and queue's irq pinned to the same core)
>    default : taskset -c 1 ./xdpsock -i enp66s0f0 -r -q 1
>    direct-xsk :taskset -c 1 ./xdpsock -i enp66s0f0 -r -q 1
> 6.1x improvement in drop rate
> 
> xdpsock rxdrop 2 core (app and queue's irq pinned to different cores)
>    default : taskset -c 3 ./xdpsock -i enp66s0f0 -r -q 1
>    direct-xsk :taskset -c 3 ./xdpsock -i enp66s0f0 -r -d -q 1
> 6x improvement in drop rate
> 
> xdpsock l2fwd 1 core (both app and queue's irq pinned to the same core)
>    default : taskset -c 1 ./xdpsock -i enp66s0f0 -l -q 1
>    direct-xsk :taskset -c 1 ./xdpsock -i enp66s0f0 -l -d -q 1
> 3.5x improvement in l2fwd rate
> 
> xdpsock rxdrop 2 core (app and queue'sirq pinned to different cores)
>    default : taskset -c 3 ./xdpsock -i enp66s0f0 -l -q 1
>    direct-xsk :taskset -c 3 ./xdpsock -i enp66s0f0 -l -d -q 1
> 4.5x improvement in l2fwd rate

I asked you to add numbers for handling those use cases in the kernel
directly.

> dpdk-pktgen is used to send 64byte UDP packets from a link partner and 
> ethtool ntuple flow rule is used to redirect packets to queue 1 on the 
> system under test.

Obviously still nack from me.
