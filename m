Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289DB457F90
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 17:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbhKTQoE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 11:44:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237479AbhKTQoD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Nov 2021 11:44:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66BBC60E78;
        Sat, 20 Nov 2021 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637426459;
        bh=uEE90k9xSWDUNioG65OuNL3V8OHHKUkxHHhIwU71oc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BPEaXlCd6kMeJZGmSg27wWVvfZq0hmldu+BsDQ0wSKoII6VQ+xLCrYHasdUvBgnd/
         4INJitNkLB1zqjFHV5zlqw8Mu8IgHzLDFEwS23FYeWBWcWp1RDt6Qz4mG9t2frRbbe
         pErxAAvqlBvPlCiFXOiAhGFwzd9LGntfQXuECam1HEU1HeGDquZsWVeO5psfeyN6tH
         orJmjpu+GbNqCDShC28ob/DMXKQMSFVoxQaZX9Yl497uK0wvm1H6Toog+MTqLgQdDU
         q7XTIcIJ6l72YvLaBAdk2n9NxSDlC/1cMHLDdNuDti+1EeY9y/kj4erKEbNcRwBBvM
         xdlIVtw05Dniw==
Date:   Sat, 20 Nov 2021 08:40:58 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     bpf@vger.kernel.org, kbuild-all@lists.01.org
Subject: Re: [PATCH bpf] treewide: add missing includes masked by cgroup ->
 bpf dependency
Message-ID: <20211120084058.243eecb8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <202111201532.vX7CVJz5-lkp@intel.com>
References: <20211120035253.72074-1-kuba@kernel.org>
        <202111201532.vX7CVJz5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 20 Nov 2021 15:01:35 +0800 kernel test robot wrote:
>    In file included from include/linux/cpu.h:17,
>                     from include/linux/cacheinfo.h:6,

Yeah, okay, I think cacheinfo.h including cpu.h is the least sane part
of this chain. Let me try to attack that.
