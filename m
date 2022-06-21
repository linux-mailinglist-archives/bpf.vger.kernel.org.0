Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B733553C29
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 22:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354546AbiFUUvI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 16:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354549AbiFUUtT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 16:49:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D342ED48
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 13:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE5DDB81B30
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 20:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7553C341C4
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 20:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844500;
        bh=t1XMw3g4Buqba29JyAYcuXXVn69FbVIYD+HoGbR2Jt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YljWZDlYRtE3Crg/6G1MfUXnceNqx78QQLfNcM4mgZYfU0oxEC0zLzIwUN951MqPb
         c+i6DztMfM9LtN1Ce8n1YvWGRbpv0FFK7AkqcazCFtXTBMQTCO8mgu3OoEJN4YZYAS
         nUTCwo1poezC8eBhXHGeLlVpA66XRM0yToSZtCBOeGCbeXgK0c9POAXDulIez9SMQt
         0088sz2H24g5N7bijyOoTqwjotRGeD9XM+huTeeRAunWm4cjSNskiB7AM28Bl0gSyF
         kbLaQAda0mSF5wh15feMqs3tnLF2xbf5hKJKr09ioMQ1YayQMppuUwtdVm1bhv4qrE
         98wbqi24P0+MQ==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3176b6ed923so142997217b3.11
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 13:48:20 -0700 (PDT)
X-Gm-Message-State: AJIora/qYb1riRhfpjovZDxam/LXRFJVX1Q5GJ/z8mj6xCNI3fts2r85
        9w2p8N7TrSpi/s/I5iSbb6JBe1/I2qSraL2STqMpkA==
X-Google-Smtp-Source: AGRyM1vpKiG68tZuli+HPlIhHtrOpzij6JrQJMj6vTR9uy5UdmqTjZA1ak3XZK8F1TE2UwUnOv37nufgVZt2Ru6vaSY=
X-Received: by 2002:a81:1b4b:0:b0:317:a2dd:31fa with SMTP id
 b72-20020a811b4b000000b00317a2dd31famr34481ywb.476.1655844499736; Tue, 21 Jun
 2022 13:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220621204642.2891979-1-kpsingh@kernel.org> <20220621204642.2891979-2-kpsingh@kernel.org>
In-Reply-To: <20220621204642.2891979-2-kpsingh@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 21 Jun 2022 15:48:09 -0500
X-Gmail-Original-Message-ID: <CACYkzJ4vU8qSXOhYGY+7=AcFdzptbZTJst5M1SNHj53RGwasbw@mail.gmail.com>
Message-ID: <CACYkzJ4vU8qSXOhYGY+7=AcFdzptbZTJst5M1SNHj53RGwasbw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] btf: Add a new kfunc set which allows to
 mark a function to be sleepable
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 3:46 PM KP Singh <kpsingh@kernel.org> wrote:
>
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> This allows to declare a kfunc as sleepable and prevents its use in
> a non sleepable program.
>
> Acked-by: KP Singh <kpsingh@kernel.org>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Please feel free to drop this, this is my broken "automation".
