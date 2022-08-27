Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29845A3A7A
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 01:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiH0Xd6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 19:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiH0Xdx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 19:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4740356EE
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 16:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81E9560EAA
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 23:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5408C43141
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661643225;
        bh=gXhVvO/PrBTrxg0AflKNlLBhyVvvXS6mDZ5icDd5kBQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AwLKyyPlYqOWy7CcqMDp34ibb7lWXt63HtZL/XRycT1k4q5Z9LD/RSRaYx1MgRsmA
         wmHgR7fmBet0W4yR5C7RtoGCrDiKe82wUEGEqchjJp2FncN414CjJPh/6lxpweV0QU
         oqnMo3tPn2XeRn+Xkje346eGLTvniHVgKQxOfiGzyQ8xOB9sF23b0/FrY7BDFIbtQ5
         3mE+RREteQin0tAomGqf0B816MacEaof3ig/V66jZkw9/X3VCbzT37XywhU/PIeBEu
         CgVo3vWcXZvRQmSmDMxto5zbgkm8OhH1j0OoMVfUok4X+hf0LSm9yho5NCfZKLdYhB
         apKWptAzG2cfA==
Received: by mail-qk1-f169.google.com with SMTP id a15so3782663qko.4
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 16:33:45 -0700 (PDT)
X-Gm-Message-State: ACgBeo1WSByRdU5DzQOOJsqZUVJrviyuZzyai347K2k84J3DqYMC1OZY
        TFLlyUoKTxjLB4m6hSQHaQMeqQ5VJ3cndwqTjk4ckg==
X-Google-Smtp-Source: AA6agR7NBl/ztDgbInSL8Sv+s9XgjHdMbIPFExqcLxY5tM4RAN1yPQT0pDYb2rd8KKLc4Z42N4jWXz5Imu+YYK+gYoM=
X-Received: by 2002:ac8:7c47:0:b0:343:5878:83e4 with SMTP id
 o7-20020ac87c47000000b00343587883e4mr5072825qtv.101.1661643214316; Sat, 27
 Aug 2022 16:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220823150035.711534-1-roberto.sassu@huaweicloud.com> <20220823150035.711534-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220823150035.711534-4-roberto.sassu@huaweicloud.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sun, 28 Aug 2022 01:33:23 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7esNWFHTXF+sW8rgFDtKdPNfePoXQ_xnzP7eQipjKkXw@mail.gmail.com>
Message-ID: <CACYkzJ7esNWFHTXF+sW8rgFDtKdPNfePoXQ_xnzP7eQipjKkXw@mail.gmail.com>
Subject: Re: [PATCH v13 03/10] bpf: Export bpf_dynptr_get_size()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, corbet@lwn.net,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 23, 2022 at 5:02 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Export bpf_dynptr_get_size(), so that kernel code dealing with eBPF dynamic
> pointers can obtain the real size of data carried by this data structure.
>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: KP Singh <kpsingh@kernel.org>
