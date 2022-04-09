Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2023D4FA063
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 02:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbiDIAEC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 20:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiDIAEB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 20:04:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7512EC4F8
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 17:01:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C46BFB82DF0
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 00:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BED2C385A1
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 00:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649462513;
        bh=g6hWiPJ22PRRGq5r0TNinCXRIkIo1Pin+UHNbS2ccMQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H0jwkmiVy1wPAZ8Q8KZ1s0cNhi0jEAio80HP9PFjWQNx98tL1+VC+zGo2XS/uH/m1
         x5y/oH977dR+5dYyptmJzajs/adCqO78c8cGWroEnQ64DjPhzV0BoWwpU3Qlz5YGNM
         +qjtkdAR5lmiWJl2pnVim78duGw5BD2U/1t3SO0S3RBU9wE0gAEQTAzpMZYZ1pDhUM
         wH+h/dSjY35Af8PtzqXiwYGHu9rEUlFFqj99PrFWsauIOVKes2hWAJaaL0Ts4uDsJ4
         SlUmiCxOz/uFfEfqPVMdTMBnrzlopntJoEqtPQ/n4PX3TdBxEHCC7hSVWjTDvvrKf1
         z7zLlM+RvwLug==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2db2add4516so113055057b3.1
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 17:01:53 -0700 (PDT)
X-Gm-Message-State: AOAM533xCycrRMgAlSuutyGdW/VI7BA84x7gt2nda074SblJ1xOAdH00
        aqZc49MMfvVSpnYxwOLQdvVrJG/L7efZKsNESYg=
X-Google-Smtp-Source: ABdhPJyaAkZYlibkOnH3zBStPbWhqcZH5z2lyIuZcLb5owpsd2NKN3xsJrlRuBdcwZPo+QBy4huibPlD0wxeinDEqk0=
X-Received: by 2002:a81:92cb:0:b0:2eb:e628:c17b with SMTP id
 j194-20020a8192cb000000b002ebe628c17bmr4556713ywg.472.1649462512419; Fri, 08
 Apr 2022 17:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220408224442.599566-1-geomatsi@gmail.com>
In-Reply-To: <20220408224442.599566-1-geomatsi@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Apr 2022 17:01:39 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7KhNhMnNMNSu+wo7YKYTM++_pcpVj7rGn4uXS9+bsNtw@mail.gmail.com>
Message-ID: <CAPhsuW7KhNhMnNMNSu+wo7YKYTM++_pcpVj7rGn4uXS9+bsNtw@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: add ARC support to bpf_tracing.h
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Vladimir Isaev <isaev@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 8, 2022 at 3:44 PM Sergey Matyukevich <geomatsi@gmail.com> wrote:
>
> From: Vladimir Isaev <isaev@synopsys.com>
>
> Add PT_REGS macros suitable for ARCompact and ARCv2.
>
> Signed-off-by: Vladimir Isaev <isaev@synopsys.com>
> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
