Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F3A457EFE
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 16:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhKTPhg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 10:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhKTPhg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Nov 2021 10:37:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B14960E97;
        Sat, 20 Nov 2021 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637422472;
        bh=+Xzo38AaASEagYKM/4p1d6KqgOBRNXTKUc1F1YqdU5w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GijOpZN3Tlt2tP8nQ+J3USldu6mF6EQ13zPJ7OhwaCYFsGORenDhJLBsKmeHrBbTo
         G226mclWIgg5Uwko5+JN9GPvCTo04kcgNxxfTTF5NIpgRYMVHjgwObHSFKmgbkyt6z
         2dll4T8WSoWcoit6KBwNZEX1oDjLq7Q8FJ0ecUaXaAz2LkZFUsm/QeoK+muQNknAaK
         xpaJ2SXrCvwB2tlmmovCrERysK21RLsqGPGFKLwbyJRWCftxpa4rqd16P9zRb85R3m
         OwSsTxxW1Hz3OdmQ1ko0asfuD1J6dxTrWrV2jsJYpl3OERWokpd3Pzc6iAAwe00f70
         ywUuEVSeYjX+A==
Date:   Sat, 20 Nov 2021 07:34:31 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     bpf@vger.kernel.org, kbuild-all@lists.01.org, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com
Subject: Re: [PATCH bpf] treewide: add missing includes masked by cgroup ->
 bpf dependency
Message-ID: <20211120073431.363c2819@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <202111201602.tm0dlDfP-lkp@intel.com>
References: <20211120035253.72074-1-kuba@kernel.org>
        <202111201602.tm0dlDfP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 20 Nov 2021 16:55:16 +0800 kernel test robot wrote:
> Hi Jakub,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on bpf/master]
> 
> url:    https://github.com/0day-ci/linux/commits/Jakub-Kicinski/treewide-add-missing-includes-masked-by-cgroup-bpf-dependency/20211120-115325
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
> config: riscv-rv32_defconfig (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/e31b3bdd266ef8f63543f27cf7493e98112fd74a
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Jakub-Kicinski/treewide-add-missing-includes-masked-by-cgroup-bpf-dependency/20211120-115325
>         git checkout e31b3bdd266ef8f63543f27cf7493e98112fd74a
>         # save the attached .config to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

False positive, riscv seems to have a broken module.h so including 
it in more places results in more of the same errors.
