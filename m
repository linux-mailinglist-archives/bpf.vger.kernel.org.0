Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109D3561B62
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 15:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiF3NbY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 09:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbiF3NbW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 09:31:22 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E27B3335C;
        Thu, 30 Jun 2022 06:31:22 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9719B4B7;
        Thu, 30 Jun 2022 13:31:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9719B4B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656595881; bh=1EC0329QxYfLRGNBRpnpevcA4Q9j85FeMC+JfN7TBCI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=l6ofSvMbdhmG+GkKAjOCA24DA1kPQDHGvx/RghviLwtsxziVXuzY6THZqEPtXDdLf
         veGPsmxhQ6onLv4Ayl++64ZGFcr8ILuUmx3c8BqsVsCGCyKBGUJ5cXAkZFUkEHV3W/
         72OeayI9z8ik3L4vxy/wKZoU5iYoCS6oaXcdZbaissHrINCs8Ce083wRi9CBoZKAmf
         tYdOkiHpeW1dMHN3SgPSu9hEqwZO19D1AE/ubY/2AenUCn3hQWQ64sJjH/i3S3oGPI
         dW3UyrR2hiMYSTCtQx+aYFUnt/m/bw5vYOoPzi0CCdx3ZrL63agmHZ/dLXW8LZOLje
         HxN/O9vGR9lFA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dave Tucker <dave@dtucker.co.uk>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-doc@vger.kernel.org,
        Dave Tucker <dave@dtucker.co.uk>
Subject: Re: [PATCH v4 bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
In-Reply-To: <ca8a57db17da57f403b029c14ba4f0b89774d361.1656590177.git.dave@dtucker.co.uk>
References: <cover.1656590177.git.dave@dtucker.co.uk>
 <ca8a57db17da57f403b029c14ba4f0b89774d361.1656590177.git.dave@dtucker.co.uk>
Date:   Thu, 30 Jun 2022 07:31:20 -0600
Message-ID: <87sfnmp9av.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
>  Documentation/bpf/map_array.rst | 183 ++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>  create mode 100644 Documentation/bpf/map_array.rst

Don't forget to add your new file to index.rst so that it's part of the
docs build.

Thanks,

jon
