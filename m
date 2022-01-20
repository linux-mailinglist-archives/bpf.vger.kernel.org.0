Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F142494D4E
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 12:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiATLol (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 06:44:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231917AbiATLol (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 06:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642679080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SUtp9B5Pu7VxjVMY6rTX8qAguktRNtu7CX1rRH2NjpU=;
        b=SkhAFocLwmRMZeuzmzt2X8bdItIwYqz5alNpAnOXEV5kGEI4u2n6IkssN0GmSPEMeb8Dx1
        sIlL8X1d3sss4anYUo3+6LoCXNvjo5ZV2qUnzoz9dLBGEfFDLsJCKCXR7jtnSmk541zv8X
        SsD60UflDJOdBj8zHshFgbaSOaHtetY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-ZYt002e4N-6dz24XX-JFQw-1; Thu, 20 Jan 2022 06:44:39 -0500
X-MC-Unique: ZYt002e4N-6dz24XX-JFQw-1
Received: by mail-ed1-f70.google.com with SMTP id s9-20020aa7d789000000b004021d03e2dfso5639096edq.18
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 03:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SUtp9B5Pu7VxjVMY6rTX8qAguktRNtu7CX1rRH2NjpU=;
        b=N2+uQfqONVpcZR8faeGC3EDGgUgBFgW7FXwXFRNSi72MO+sEFCVLlay8srx6tRsLzW
         dnRhHy9Yw+Wb8CG66+mGDkV7gUIhiZDn1XJa3JKI+CwTtVb+q3syB4XljsnPkvWxQ0Yd
         7e/ic7w7yAQTV3dM3gadkFPTd/RJVpbLHeWBcBl9Xq140qfWDzNCihJBUAgU7P/rpqg2
         JgsV0mXhr5S207zTj35YBawdgPvwelB1alQJVNxCM4iLwfjLblI/8aTcQrrxmGPYqP3B
         sBXNikJBhswnyQOQvq8AA+iITc8tIIjHwwIJkgtrJMNEu7CEHOyqE6+Zkoct83pTi1Xr
         OprA==
X-Gm-Message-State: AOAM532R1mnf2ZOZprXAzLDo6tkADhQr5uY2eAJuuEs2k0LOvrUaSjQ2
        HUAlMJFhlEO13WawacJGamoVTLINpbtBHmT1j9bhYkENR36eIXKOc8rE0pA6r2P58cE2CFLGyDX
        e1XV0euo/uett
X-Received: by 2002:a17:907:7faa:: with SMTP id qk42mr1698280ejc.742.1642679077663;
        Thu, 20 Jan 2022 03:44:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSxzpV9YIo5cBC6JmDJO4W4DDM46oWBpW1/XWeeUL85mZjatQ+Ns/WXQp8gIesr3xxJ+/MxA==
X-Received: by 2002:a17:907:7faa:: with SMTP id qk42mr1698253ejc.742.1642679077238;
        Thu, 20 Jan 2022 03:44:37 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ha3sm898776ejb.157.2022.01.20.03.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 03:44:36 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 253261805F9; Thu, 20 Jan 2022 12:44:35 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 3/4] libbpf: deprecate legacy BPF map
 definitions
In-Reply-To: <20220120060529.1890907-4-andrii@kernel.org>
References: <20220120060529.1890907-1-andrii@kernel.org>
 <20220120060529.1890907-4-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 20 Jan 2022 12:44:35 +0100
Message-ID: <87wniu7hss.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii@kernel.org> writes:

> Enact deprecation of legacy BPF map definition in SEC("maps") ([0]). For
> the definitions themselves introduce LIBBPF_STRICT_MAP_DEFINITIONS flag
> for libbpf strict mode. If it is set, error out on any struct
> bpf_map_def-based map definition. If not set, libbpf will print out
> a warning for each legacy BPF map to raise awareness that it goes
> away.

We've touched upon this subject before, but I (still) don't think it's a
good idea to remove this support entirely: It makes it impossible to
write a loader that can handle both new and old BPF objects.

So discourage the use of the old map definitions, sure, but please don't
make it completely impossible to load such objects.

-Toke

