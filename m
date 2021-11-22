Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C58459567
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 20:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhKVTSS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 14:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhKVTSR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 14:18:17 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C980DC061574;
        Mon, 22 Nov 2021 11:15:10 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D412C453;
        Mon, 22 Nov 2021 19:15:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D412C453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1637608510; bh=2DScLwxEQkZJ+KOGDf/I8k+ZqlK/H4tFChsMdLSMieY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=K/21WexYGSH+5FiJoiASZQ1HCZH8C+Ii3551NniwCpX+bOCRBUlzgiEmgOusSpKOR
         uKkFFvyaauYACuO3Ex/nXAkwORIczzMzdLKDo4m4WInkrPatNR9CFDfS+ENQ5zhleh
         Zcxcmd8Od1o696y4uocmYcI7y0RERvn4xPc9oubWlVJdottDcv991DPyP4OGqS4CFy
         lGwbUnHTJb4Zfctis1lwtr8n4czawqayrbQIpZqj0bVjZws/jAvwcywSpZL+aO+b2F
         espAaSbqvzUxyhn+pl6QZO0+c/Wgqrys0GePehyX/KzOp2djqPOFlJGJ/GqBQlk6R2
         baVmv/rkM7KGQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dave Tucker <dave@dtucker.co.uk>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-doc@vger.kernel.org,
        Dave Tucker <dave@dtucker.co.uk>
Subject: Re: [PATCH bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
In-Reply-To: <5da383bc01c66e6c1342cdb2b3dc53196214e003.1637601045.git.dave@dtucker.co.uk>
References: <cover.1637601045.git.dave@dtucker.co.uk>
 <5da383bc01c66e6c1342cdb2b3dc53196214e003.1637601045.git.dave@dtucker.co.uk>
Date:   Mon, 22 Nov 2021 12:15:09 -0700
Message-ID: <87ee78vw76.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dave Tucker <dave@dtucker.co.uk> writes:

> This commit adds documentation for the BPF_MAP_TYPE_ARRAY including
> kernel version introduced, usage and examples.
> It also documents BPF_MAP_TYPE_PERCPU_ARRAY since this is similar.
>
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> ---
>  Documentation/bpf/map_array.rst | 150 ++++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/bpf/map_array.rst

When you add a new BPF file, you need to add it to the corresponding
index.rst file as well.  Otherwise it won't be part of the docs build
and will, instead, generate the warning you surely saw when you tested
the build...:)

Thanks,

jon
