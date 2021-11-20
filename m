Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA65E457C34
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 08:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbhKTHmh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 02:42:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236392AbhKTHmd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Nov 2021 02:42:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D4B960E94;
        Sat, 20 Nov 2021 07:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637393970;
        bh=ZyTVqjOSKrp5VXX+khXGou2v7HAND6IAqcRDKMOPn8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=ZNY8zejO7ZM9vSZU3k/3RhBSZVfY+X1xLg24jqzDlINwEMfwdsUpBy52yy39ph8U1
         QkaFwY9aS9WTX+epYdzXdXkopMDOMC5k/M63z2LFT5JCZRmh3GqV92YIoZtqvG9MdB
         GK7QyNq0MDqN2y5lCLEQUBZGiglKVPGjNgJAjNVnWcbYVdVGwnEBfn2Lh0Emtzd7fU
         py4QIBzbJREgfjDafPxbqahs/TQX5uQRdLTtBH62NCYQXma+jnSEDADCW8yHP1mMfi
         lmaDkgqZof3YJh3Sl4K+AQsiP5Q3DLStqZdCWXb5x7Egvya0m3h92NVSTyQjYVk13x
         WJqcnz6aXuBfw==
From:   SeongJae Park <sj@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bpf@vger.kernel.org, axboe@kernel.dk,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, yuq825@gmail.com, robdclark@gmail.com,
        sean@poorly.run, christian.koenig@amd.com, ray.huang@amd.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, jingoohan1@gmail.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzysztof.kozlowski@canonical.com,
        mani@kernel.org, pawell@cadence.com, peter.chen@kernel.org,
        rogerq@kernel.org, a-govindraju@ti.com, gregkh@linuxfoundation.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sj@kernel.org,
        akpm@linux-foundation.org, thomas.hellstrom@linux.intel.com,
        matthew.auld@intel.com, colin.king@intel.com, geert@linux-m68k.org,
        linux-block@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH bpf] treewide: add missing includes masked by cgroup -> bpf dependency
Date:   Sat, 20 Nov 2021 07:39:19 +0000
Message-Id: <20211120073920.16261-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211120035253.72074-1-kuba@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jakub,

On Fri, 19 Nov 2021 19:52:53 -0800 Jakub Kicinski <kuba@kernel.org> wrote:

> cgroup.h (therefore swap.h, therefore half of the universe)
> includes bpf.h which in turn includes module.h and slab.h.
> Since we're about to get rid of that dependency we need
> to clean things up.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: SeongJae Park <sj@kernel.org>

for DAMON part.


Thanks,
SJ

[...]
