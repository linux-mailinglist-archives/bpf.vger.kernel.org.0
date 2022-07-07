Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FBE569E58
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 11:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiGGJOg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiGGJOf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 05:14:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D6E2A97F
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 02:14:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk26so10313122wrb.11
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=mhKD3kwdgMB9Qn80+T46D0eCXTbFVc5sj//rIlFsM2U=;
        b=KPgiK3NH6s0Yx6dbn9KhVT8Umhm/BLGANOwvcXqhGeYkXqGFoGqpYUcmy7Xd9oSoHl
         dXDF9QdeQfK2Tnh4hyv9SGZv8Ai2Zz3/ss/VftyE2TKw0a3+tt4tj8DyOvCqe+q8HMZB
         jqLABvbnKEd9DMJ/RkteG0K+Tpsvtdz9mvB/u4EDSW7bvuXFnQz2pOTdXkkXhbKSUe09
         P9PSGJD8vEGUCpwIjIPmidBnngaMd3k9PmRqtPskYtPIuMDkogvHynSQQPnQ9Vba126G
         285/ef78WCZqwMEBM5Ui2D1gJMqJ+kBIzJCMvry4uwueFYJv2Yx/wTqm5jHQsp8mkZ2G
         A9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mhKD3kwdgMB9Qn80+T46D0eCXTbFVc5sj//rIlFsM2U=;
        b=XCrX45QMIsQjXqmZ0uIcYupZx5P2+r7z82SrvMjnRF5+OLH9xPftwjjCVTVHmUIefn
         9ToS+FS/di9C6rcivLJOnLPLe+x3hjv3CXcrr6DU2T1JEl4N5mUjqgzxnB480Z3KIXJr
         vi2gCWsPfnD2nWcGjYWZtvbM+Mso9FqCxM+xLE9Hc8um2Q+FgSVQsBMiMj+gxlStxB2V
         VHNjq3xNMzAsQUDgH8DkYJLeLhcNcWcaV/1Hpoy8sip9UbZkupQmGkl3UzMcB6lNd4PQ
         UeS/iP2NlybdSGRroO1GpCjy5DkyUrcL91k8iD5K/NAuf0YpiND3fMahtIstLw83jten
         PPnw==
X-Gm-Message-State: AJIora/vXzK6awYLFtu1/iVLW5gjUMm7yQSweJENJkOoabeQ4g+mEnWq
        h2o/32/5XrRC1xaDqt88HZ3a+ggJ48L1uF7t
X-Google-Smtp-Source: AGRyM1sNeFRUozvoeE/BCUaJZ2M4GzBPsuHwV9T5h0AjpaUrdxxAgOg2jtS8ZvwJ3mvpMvC0ICX93w==
X-Received: by 2002:a5d:4304:0:b0:21b:9b2c:be34 with SMTP id h4-20020a5d4304000000b0021b9b2cbe34mr44012536wrq.577.1657185273382;
        Thu, 07 Jul 2022 02:14:33 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c19d400b0039c4f53c4fdsm31155139wmq.45.2022.07.07.02.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 02:14:32 -0700 (PDT)
Message-ID: <05a05458-9673-8556-443c-a80902aedba2@isovalent.com>
Date:   Thu, 7 Jul 2022 10:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH bpf-next 0/2] Add KIND_RESTRICT support to bpftool
Content-Language: en-GB
To:     =?UTF-8?Q?Daniel_M=c3=bcller?= <deso@posteo.net>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
References: <20220706212855.1700615-1-deso@posteo.net>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220706212855.1700615-1-deso@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/07/2022 22:28, Daniel Müller wrote:
> As pointed out in an earlier discussion [0] not all paths in bpftool's
> minimization logic handle the restrict type qualifier properly. Specifically,
> the gen min_core_btf command fails when encountering the corresponding BTF kind
> for a TYPE_EXISTS relocation (TYPE_MATCHES support was added earlier):
>   > Error: unsupported kind: restrict (26)
> 
> This patch set fixes this short coming.
> 
> [0]: https://lore.kernel.org/bpf/20220623212205.2805002-1-deso@posteo.net/T/#m4c75205145701762a4b398e0cdb911d5b5305ffc
> 
> Daniel Müller (2):
>   bpftool: Add support for KIND_RESTRICT to gen min_core_btf command
>   selftests/bpf: Add test involving restrict type qualifier
> 
>  tools/bpf/bpftool/gen.c                                   | 1 +
>  tools/testing/selftests/bpf/prog_tests/core_reloc.c       | 2 ++
>  tools/testing/selftests/bpf/progs/core_reloc_types.h      | 8 ++++++--
>  .../selftests/bpf/progs/test_core_reloc_type_based.c      | 5 +++++
>  4 files changed, 14 insertions(+), 2 deletions(-)
> 

Acked-by: Quentin Monnet <quentin@isovalent.com>
Thanks!
