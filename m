Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060DE64ED24
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 15:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiLPOxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 09:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiLPOxU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 09:53:20 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E37C4A583;
        Fri, 16 Dec 2022 06:53:19 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id bw27so707981qtb.3;
        Fri, 16 Dec 2022 06:53:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOiPjXQIxXWdtEdaDgALBdOOZPdxqDznsMSDkV/eY3M=;
        b=p8AJHZI7O0yJC/pcwxu6lmGZGEigs1ufm5Bs6ffdxu+VXBdtd7QKzROtdp0HbUs8w/
         wZ83ljpYyducUzDPOS5azrgjzwyPIWxV38wZlwoy4COTCB1t7pIrSLJdRPgDlKCStBPx
         MoklLhqx4FYt4AlRMd2cz1YVI7LW33M5svG4j0oIf/jqPHpWmV+R41Y4tZqcMtedTxNa
         oaq50WJA/m9XAuhG28AUbYYV+xd2WNHvme1DXMX2/BEue3tGaNH76NvwZaWmofrgcKc1
         dOn4UIY9uBxsAGU85QtNPRcIzQGloJpMl5qROVL149ucIm005mc03GkuphjHkbsrLK25
         si8A==
X-Gm-Message-State: ANoB5pn5iOpF/VPiq8pwIICnXUDUMZYvkL9qB/qkxTV1wgh+4MWbQU7C
        XLG2n9bFTjwi1fDsUC1pe7w=
X-Google-Smtp-Source: AA0mqf5pClytxKGos159wN8+5ZmeC5U9v2ZWL7oDM68ERmPlVd/e9CjTulfG6Vc74AGy4JlfuNEf5g==
X-Received: by 2002:ac8:6607:0:b0:3a6:a43a:8ba9 with SMTP id c7-20020ac86607000000b003a6a43a8ba9mr41709083qtp.3.1671202398129;
        Fri, 16 Dec 2022 06:53:18 -0800 (PST)
Received: from maniforge.lan (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id bw20-20020a05622a099400b003a7f1e16649sm1438726qtb.42.2022.12.16.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 06:53:17 -0800 (PST)
Date:   Fri, 16 Dec 2022 08:53:14 -0600
From:   David Vernet <void@manifault.com>
To:     mtahhan@redhat.com
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, jbrouer@redhat.com,
        thoiland@redhat.com, donhunte@redhat.com, john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next v5 1/1] docs: BPF_MAP_TYPE_SOCK[MAP|HASH]
Message-ID: <Y5yGWlrdyRm+Hx2V@maniforge.lan>
References: <20221216100135.13125-1-mtahhan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216100135.13125-1-mtahhan@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 16, 2022 at 10:01:35AM +0000, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_SOCK[MAP|HASH]
> including kernel versions introduced, usage
> and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>

Hi Maryam,

FYI I think you're missing a few tags? You can add my Acked-by, and I
believe that John and Bagas acked and reviewed it respectively in on the
v3 [0] set as well.

Thanks,
David

[0]: https://lore.kernel.org/bpf/Y5EOC7HjtaRFAVfq@maniforge.lan/T/#m247ac7e1673731a9cf8b06d5ce027a1acbcce953
