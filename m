Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A72B4D6437
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiCKPAt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Mar 2022 10:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240728AbiCKPAs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Mar 2022 10:00:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D8C4175814
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 06:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647010784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I9nC5wQqiuVhnAx4Yqa5lMKKFE1c4cG7N09X/H5kS2s=;
        b=hYmywskwp0mtjMpIBXAjejrO51gDWLgU43SQoHvX2hYptAHc7a/3KmckcRVAk/SK8A7JqB
        9P7HXytsKdfK7m+UH81YrNHD30vhOAI6d1/LZIIMVX4iJqTo42Wmbyf/7HkBLl4hB/sojm
        WTR0DxMc/0HpI/cxaKTSPaYwIMNvPfE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-pU8Nf9DsN-yY8Zce-tk4iA-1; Fri, 11 Mar 2022 09:59:43 -0500
X-MC-Unique: pU8Nf9DsN-yY8Zce-tk4iA-1
Received: by mail-ed1-f69.google.com with SMTP id i17-20020aa7c711000000b00415ecaefd07so4985352edq.21
        for <bpf@vger.kernel.org>; Fri, 11 Mar 2022 06:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=I9nC5wQqiuVhnAx4Yqa5lMKKFE1c4cG7N09X/H5kS2s=;
        b=JQWKGK40hC6tdeWmgzeKxpFkZk3crdWdlIoVKwAg7n/+VGEctkBmiwIGPZDi/4+sh5
         sMv8FK2iQWbFUGWwSEy/hn7U6XL9ObraP0QPcZ8YPffQGMWn6zpVDSk/bY5kOwZzERV0
         ktfxm0BI6ULtA13gDAQWQfJRQIMGB55S37MsNEArXgBafNPIg+Ja2ixswJiEq/gVPwz3
         jloHIiioZifwsSXXXwymNUigyQ+sJZPQMxFqkf+CK1RbU2HIWHiFxlrYPaXR5pMxxpxE
         DjSnsxHaLJ32Rn5Mjj+aIg6rXhxLyekTV6czvJXezPAMY5OEz3OcoxOztzvGySDT3CL8
         OwUg==
X-Gm-Message-State: AOAM530eV5fHj/hHxRjFR5IkhfFR2OFqxfm6EKXUcXIC5SL/FgxYhEkG
        n8Ibm71D6/pW3qTtaDGaUE5z49N5xeqyV02RQK2xUwbQQXWf3bGR3HA07qVYk4NJyJE7TqyXGah
        u2UWHXd7i5LNz
X-Received: by 2002:a17:906:6841:b0:6cf:9c02:8965 with SMTP id a1-20020a170906684100b006cf9c028965mr8836218ejs.440.1647010780645;
        Fri, 11 Mar 2022 06:59:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmvxSgTS3KGD0JT0bQe+CFeJKixbHXYNmnspT9wGRFZguAzPo/qRrGHol+cQjJym43mPW+eg==
X-Received: by 2002:a17:906:6841:b0:6cf:9c02:8965 with SMTP id a1-20020a170906684100b006cf9c028965mr8836110ejs.440.1647010779157;
        Fri, 11 Mar 2022 06:59:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm3338254edb.47.2022.03.11.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:59:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B955C1AB56D; Fri, 11 Mar 2022 15:59:37 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, brouer@redhat.com, pabeni@redhat.com,
        echaudro@redhat.com, lorenzo.bianconi@redhat.com,
        toshiaki.makita1@gmail.com, andrii@kernel.org
Subject: Re: [PATCH v5 bpf-next 3/3] veth: allow jumbo frames in xdp mode
In-Reply-To: <d5dc039c3d4123426e7023a488c449181a7bc57f.1646989407.git.lorenzo@kernel.org>
References: <cover.1646989407.git.lorenzo@kernel.org>
 <d5dc039c3d4123426e7023a488c449181a7bc57f.1646989407.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Mar 2022 15:59:37 +0100
Message-ID: <87v8wkwn52.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Allow increasing the MTU over page boundaries on veth devices
> if the attached xdp program declares to support xdp fragments.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

