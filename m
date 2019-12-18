Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B63AE12459B
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2019 12:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLRLUB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Dec 2019 06:20:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42025 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726699AbfLRLUA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Dec 2019 06:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576667999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lv2aG88TsoBY1Gtzn+rvzVvVT3dJSL+Og5VTXQp1x9s=;
        b=NTrO9yxhwMsTwFRWJUOkDUarX5kjSXP+dku7DSRxisQs3HKGBTrC84RMc1/8SwxBSFlz39
        8kDHm1/R+a3HtvzesTYZI3+F33EPvDRlZ0P/snL/ON82IbaA8v597k5geM2JiZvyIIpPeb
        c1fDpUTtkHrOaCRJgy9RxYMzh/sS3XM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-tZKMpp-6P5SpROb_hdhEBQ-1; Wed, 18 Dec 2019 06:19:58 -0500
X-MC-Unique: tZKMpp-6P5SpROb_hdhEBQ-1
Received: by mail-lf1-f70.google.com with SMTP id i29so185013lfc.18
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2019 03:19:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lv2aG88TsoBY1Gtzn+rvzVvVT3dJSL+Og5VTXQp1x9s=;
        b=D4RP1qwAH1iN0Zntf/TvnKFt6zZMjJ+IFsG9aVk++R67q0kz7P86UvOE+ainCeE58/
         67eiugAfOANgl8jKoi0Z5x328Ze7+W9lmEO4NZPt8tynAPvUQtrrQWKHu1fIfrYADD2v
         V/EO1cY4iTbegFT3ltuzTJxT+bYHP5FqrK15FbTGhA5sK8ups7PZbg8Wh2BiHcOyDy21
         f40BFh+D9uPXi+cWQeda9yORuJz7po6s8ZaNZ2AbvHdikCktXZCs7PGRMbGio8E0aVaU
         S7aNNkJhvAX1DzCvA2guV/sbnPTBLUSnXMkXl3EECJqudHv5yiI3NYSs0B0E7/ne7zw4
         3m6Q==
X-Gm-Message-State: APjAAAX4fL9wGnpsnu+GPjvOIj0zBgA6pd5BR5xBrHOVkSWleAwqm44E
        ZPHzDsvhOCKFAwsqkYaXREGrchYgCnDHk5TQIWCDK7lG9A6ji5F6AOU8zfnZnI3lhWnVKNcCs0Z
        rvfbT+6rXflEi
X-Received: by 2002:a2e:978c:: with SMTP id y12mr1168041lji.167.1576667997139;
        Wed, 18 Dec 2019 03:19:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjHsRTG2Z0nKVQalh7Mb+J6dmxqtTJQ2370SvMZTHE1AYkHBlJiLkPJrWqvCmhldcNKnJlHQ==
X-Received: by 2002:a2e:978c:: with SMTP id y12mr1168025lji.167.1576667997003;
        Wed, 18 Dec 2019 03:19:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b20sm956994ljp.20.2019.12.18.03.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 03:19:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9B3EF180969; Wed, 18 Dec 2019 12:19:55 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Subject: Re: [PATCH bpf-next 6/8] xdp: make cpumap flush_list common for all map instances
In-Reply-To: <20191218105400.2895-7-bjorn.topel@gmail.com>
References: <20191218105400.2895-1-bjorn.topel@gmail.com> <20191218105400.2895-7-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 18 Dec 2019 12:19:55 +0100
Message-ID: <87o8w56ftw.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> The cpumap flush list is used to track entries that need to flushed
> from via the xdp_do_flush_map() function. This list used to be
> per-map, but there is really no reason for that. Instead make the
> flush list global for all devmaps, which simplifies __cpu_map_flush()
> and cpu_map_alloc().
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

