Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F73568A7FD
	for <lists+bpf@lfdr.de>; Sat,  4 Feb 2023 04:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjBDDgn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 22:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjBDDgm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 22:36:42 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A239369B0F
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 19:36:41 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d2so3179151pjd.5
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 19:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3/aDuV8U2sPGopzctEu9Jxopgz5QJ8+7nFyWXwCzOE=;
        b=gTpuxNcsUSFpvRZhoz9O8m45EPsZhrMQPQDMrORAx+epq6H9e22TvlupLAn/xIBpXl
         HbduMic1LITptY6LrSZVklHrOWMq7P59idg0H3TGxc2luRRVXTY9M7k2LbX3XrH/wqyV
         Ha0CTq8OkYvKw3RKnMXqnpEmVvwXbegXuw5DvepswaLxJ5vvLdYKvO7xbBBb3mHM7eKm
         GGVwLMWCxa/PYChQFxPCr2rADZluzsYILPbeULlb/ycfADQDur6vlueoNySPiXCG0h7O
         AK4UJbWgNiKLPxlq1x7LVFr9gK0aOrnBk4UykVdK3dUBmyTyXPv6RTJ614uJ8DEablim
         W94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u3/aDuV8U2sPGopzctEu9Jxopgz5QJ8+7nFyWXwCzOE=;
        b=QqRYmvaUcvagYVKijVVBM15nAfkzDwxQ+iDN28WHqhxtC/jUMdPvVGBvfviL3T4QUF
         vKUWQRwaGoEZMeJKp57CJYmtv6z6We+PctEbIFcQ4hHiqx8XKjy5gU2IiWImN67uzXpJ
         oSSVBUskjmXI93+aNJ8dp60EbWgOhCGA8/Uf7l3aIa3vXzakFSMpkATgOyt1HcdraOrJ
         q/c80lQsSIpfNQUyIX6hX57F0syJDZXMGdkXzN+zZ/CwPkstf1/SBk1ymDe20PWRkf6W
         boBEVuA4nU8qXW6QW4WgLvyW4nM5qmp0NRfbahJwu3YbT0LZPdtpT+QN7K9HZoxISDyj
         jOJw==
X-Gm-Message-State: AO0yUKVMMeoXzb5dKhCWKXgktKHpZpAzuVji8ejMWEDE2t0KfcsYYH3P
        dk2jb6oI8fWbmeBmbotHkhk=
X-Google-Smtp-Source: AK7set9Ea5o+5ttFps0GBa4hOxCfAnnVafEkrsCgxIV4JXLtyuo1W0F86qoYR3ZvwkzE5JJBJa9CXg==
X-Received: by 2002:a17:902:f543:b0:196:5f76:1e51 with SMTP id h3-20020a170902f54300b001965f761e51mr15397824plf.64.1675481801148;
        Fri, 03 Feb 2023 19:36:41 -0800 (PST)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902ce1200b00196251ca124sm2337985plg.75.2023.02.03.19.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 19:36:40 -0800 (PST)
Date:   Fri, 03 Feb 2023 19:36:38 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Florian Lehner <dev@der-flo.net>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Florian Lehner <dev@der-flo.net>
Message-ID: <63ddd2c6d9fc4_6bb1520824@john.notmuch>
In-Reply-To: <20230203121439.25884-1-dev@der-flo.net>
References: <20230203121439.25884-1-dev@der-flo.net>
Subject: RE: [PATCH] bpf: fix typo in header for bpf_perf_prog_read_value
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Lehner wrote:
> Fix a simple typo in the documentation for bpf_perf_prog_read_value.
> 
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---
>  include/uapi/linux/bpf.h       | 2 +-
>  tools/include/uapi/linux/bpf.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ba0f0cfb5e42..17afd2b35ee5 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2801,7 +2801,7 @@ union bpf_attr {
>   *
>   * long bpf_perf_prog_read_value(struct bpf_perf_event_data *ctx, struct bpf_perf_event_value *buf, u32 buf_size)
>   * 	Description
> - * 		For en eBPF program attached to a perf event, retrieve the
> + * 		For an eBPF program attached to a perf event, retrieve the
>   * 		value of the event counter associated to *ctx* and store it in
>   * 		the structure pointed by *buf* and of size *buf_size*. Enabled
>   * 		and running times are also stored in the structure (see
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index ba0f0cfb5e42..17afd2b35ee5 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -2801,7 +2801,7 @@ union bpf_attr {
>   *
>   * long bpf_perf_prog_read_value(struct bpf_perf_event_data *ctx, struct bpf_perf_event_value *buf, u32 buf_size)
>   * 	Description
> - * 		For en eBPF program attached to a perf event, retrieve the
> + * 		For an eBPF program attached to a perf event, retrieve the
>   * 		value of the event counter associated to *ctx* and store it in
>   * 		the structure pointed by *buf* and of size *buf_size*. Enabled
>   * 		and running times are also stored in the structure (see
> -- 
> 2.30.2
> 

Sure,

Acked-by: John Fastabend <john.fastabend@gmail.com>
