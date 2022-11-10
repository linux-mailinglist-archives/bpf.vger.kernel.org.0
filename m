Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61E8624274
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 13:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKJMj7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 07:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJMj6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 07:39:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BA96BDF9
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 04:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668083941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IaA03jOVzd31zgKd7oHCTW0S56r7zJC93B/TpVDsAp0=;
        b=C874kcdlJ6vD+1xJmuCkZOUvWP852/S+PA7GX18Cm3YKyDHGQzXd7OswRE2X0n2IGg0a8R
        /6grD8TTzgfRZPvqz9H3zII/3muzI8Xrq3S3MYMkddJVugHyTtJNjvOerVrf1mGygpbNve
        1hzYMlWB/PcXmVvP0/VysCbFx9t+JVQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-313-KvTRBd7tOU64VkBtaxd6vA-1; Thu, 10 Nov 2022 07:38:58 -0500
X-MC-Unique: KvTRBd7tOU64VkBtaxd6vA-1
Received: by mail-ed1-f71.google.com with SMTP id e15-20020a056402190f00b00461b0576620so1426916edz.2
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 04:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaA03jOVzd31zgKd7oHCTW0S56r7zJC93B/TpVDsAp0=;
        b=S1XOErNSm6ULVQVxwgC+YDgfoy4d/jC++06rksXab3JuBVM74dXhGUnR6KRL975Cfm
         UUiBCtzynNwh7PXcJv0Xr3c1qd5GLT6cUc5bY46xhBlNAQRXvRRhbds7uNzzZfFqkSHR
         N3T01x5k/MwFT0l9SMwLkZbym+f7MzZoIMrSjuC8/wIqf3uQZXpeW+iDSFFKMIdQOvdZ
         hr1wv2vqkmzptk5M4TkX7cuqoM6IfoeQSqHFv2BpUY1MCvugnZVQJZnCkoDf+Y7ToWFA
         /1EWd/0BfdbvfkSbXjCivjn8tl9hivTiRdwu6FLSvmiZYrvoy7RNyXZX+C6/wOoA+hcf
         H+WQ==
X-Gm-Message-State: ACrzQf3Uh8J3vgWcBQjdKMgX6VNqaG+plHmtmSgYWDwMaU3mhJsN+ug/
        8UiY21SsXkzkQVm4O4yLPkYR58ZfGB7T916a7NQfo6xH/2DQS8Uf39byp/lGayUlKMaZSclsyMR
        cbxT/N8IVrQyF
X-Received: by 2002:a17:906:cc48:b0:7a8:4a3b:11f7 with SMTP id mm8-20020a170906cc4800b007a84a3b11f7mr60834293ejb.388.1668083936548;
        Thu, 10 Nov 2022 04:38:56 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5wj+sHnBlbkfOl9wABMq59Dy+pHBeFGF3Sqg5hr6qA4gRkqeQ/XoGakBpfsaC+QSpM+8JWyw==
X-Received: by 2002:a17:906:cc48:b0:7a8:4a3b:11f7 with SMTP id mm8-20020a170906cc4800b007a84a3b11f7mr60834253ejb.388.1668083935084;
        Thu, 10 Nov 2022 04:38:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id kv3-20020a17090778c300b0077a11b79b9bsm7197104ejc.133.2022.11.10.04.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 04:38:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1C4267826A6; Thu, 10 Nov 2022 13:38:54 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        yhs@meta.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [PATCH bpf-next v7 1/1] doc: DEVMAPs and XDP_REDIRECT
In-Reply-To: <20221110102950.2633685-2-mtahhan@redhat.com>
References: <20221110102950.2633685-1-mtahhan@redhat.com>
 <20221110102950.2633685-2-mtahhan@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 10 Nov 2022 13:38:54 +0100
Message-ID: <87fseryof5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

mtahhan@redhat.com writes:

> From: Maryam Tahhan <mtahhan@redhat.com>
>
> Add documentation for BPF_MAP_TYPE_DEVMAP and
> BPF_MAP_TYPE_DEVMAP_HASH including kernel version
> introduced, usage and examples.
>
> Add documentation that describes XDP_REDIRECT.
>
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>

Just re-read this, and I think it's much improved over previous versions
- nice work!

With just one nit below, feel free to re-add my:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

[...]

> +With ``BPF_F_BROADCAST`` the packet will be broadcast to all the interfa=
ces
> +in the map, with ``BPF_F_EXCLUDE_INGRESS`` the ingress interface will be=
 excluded
> +from the broadcast.
> +
> +.. note::
> +    - The key is ignored if BPF_F_BROADCAST is set.
> +    - Multicast can also be achieved using multiple DEVMAPs.

That last bullet was a bit confusing on a first read. Maybe change it
to:

- The broadcast feature can also be used to implement multicast
  forwarding: simply create multiple DEVMAPs, each one corresponding to
  a single multicast group.



-Toke

