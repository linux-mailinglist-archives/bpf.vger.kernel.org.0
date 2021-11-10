Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30EC44BCF8
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 09:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhKJIjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 03:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhKJIjN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 03:39:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B558DC061764
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 00:36:25 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v127so1374260wme.5
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 00:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P3ex3Y/JqfiottMx/xPchUEVWxBEI/96t8WHOpWOlwc=;
        b=BrkCsEbFksKENGwL9BW6Tjuq6MOEv8RErTYA1CzxLT/hhyc74mDe0BRRUH86BYAl+e
         31j3AQGO/ZOtyXFRkgIMfiVAAx/SQTqRAjtH3wXus4yO2D2jVtnZlEHa8KUp1vCdz6xX
         2PJv5XJZyhy9Hzt8QE+NkmBvkMM4e8DxJ9nPRNGGKhPaEVjihF2sG0tfsZG+9FiOtwfl
         ChXpxJd+SWHxFPJnwlnfPE5ucUncv221tIMZRzN0BRZ4SOibkXGckkeT9LoSD/mu4t+I
         QFKnPirFX9ovY8664cWRtz4Y3KGVdwNa0A0XIX+EDm7RkrVRbcEqRIfqjQMc1svMl4g/
         sjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P3ex3Y/JqfiottMx/xPchUEVWxBEI/96t8WHOpWOlwc=;
        b=LxSMDHL0W1oO09/Wzy/3JLiIt69Oa9f6zA79soDjyktpwfaQa1IPWSBvT57EOubcES
         QuND1+3jyzeSTPguHyUuRkGM5dV36/J8x8ysI7pvy+OofjAZG2NIvAXoJQOX6gPq8UCm
         YuYTre/IxnEk/8ZGQpkp40EQmDJUVQTeMJRSVUFlxCN9FaTAUIj/oLu09UvFHwDq8rJw
         ApLa93NpIvVFvFL+zFzc3McFmzCOH+OTqbbLftggXJTWl3Ahpyp5EwZdznh/0sy1NQuH
         Zc1sgUjI7c+nLm+urhG5ZUfHBCqVl5OkquB33IHTTJ9456oMnDHrHNUiJ/3WuJ+zn3Gf
         dVDw==
X-Gm-Message-State: AOAM530+xsMmlciveGHEnTopnOnDlcQVo4xJJZsSKlmnpxY751LGWokG
        fTADtLrYMm4Yv744p/4xHJJDI5ZkjavqNKx4
X-Google-Smtp-Source: ABdhPJwxNqnTEYLifRDamp1z10bsNS3TWpGvIkf5dRVq2WH7GWsUxp/msiracCdwAcTS0f1+QCsWsg==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr14686663wmb.140.1636533384344;
        Wed, 10 Nov 2021 00:36:24 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id l18sm23150446wrt.81.2021.11.10.00.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 00:36:23 -0800 (PST)
Date:   Wed, 10 Nov 2021 08:36:02 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, Joe Stringer <joe@cilium.io>,
        Peter Wu <peter@lekensteyn.nl>, Roman Gushchin <guro@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH bpf-next] bpftool: Fix SPDX tag for Makefiles and
 .gitignore
Message-ID: <YYuEcp/8ECfWzZcl@myrica>
References: <20211105221904.3536-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105221904.3536-1-quentin@isovalent.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 05, 2021 at 10:19:04PM +0000, Quentin Monnet wrote:
> Bpftool is dual-licensed under GPLv2 and BSD-2-Clause. In commit
> 907b22365115 ("tools: bpftool: dual license all files") we made sure
> that all its source files were indeed covered by the two licenses, and
> that they had the correct SPDX tags.
> 
> However, bpftool's Makefile, the Makefile for its documentation, and the
> .gitignore file were skipped at the time (their GPL-2.0-only tag was
> added later). Let's update the tags.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andriin@fb.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Joe Stringer <joe@cilium.io>
> Cc: Peter Wu <peter@lekensteyn.nl>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>

Acked-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

