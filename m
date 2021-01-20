Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36982FDA7A
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 21:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbhATOD7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 09:03:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733215AbhATMyc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Jan 2021 07:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611147175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Taj+EswQldqKUIFQmaJPXclMJabya3UPoVORBovNqEA=;
        b=Jvznwj2PV+giN4VDESCkS3Enzyf3e665LzGWQufG1NOG/FVQuHcTDPK36E9HU/YMTnWUQO
        dVEWbZwzlCIslVzK85f02biiv3JGf3xE9+2ANqxxsE75jyM/DMhnkCRWWpPkcRaSuHghXL
        kVO9PgLnR2j2ehMtfTN+mrnfGs2RrYU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-7_4j5jf3Og2G4N0G6lGlVQ-1; Wed, 20 Jan 2021 07:52:54 -0500
X-MC-Unique: 7_4j5jf3Og2G4N0G6lGlVQ-1
Received: by mail-ed1-f71.google.com with SMTP id a24so5735200eda.14
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 04:52:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Taj+EswQldqKUIFQmaJPXclMJabya3UPoVORBovNqEA=;
        b=mY5BfKdEYcmB3dbvj9gQuJzPrclEGqgHGPSYmnPw+l4OL7PsUEo8YV2v/UoukSOUgE
         1Q4E8iHWnVSK2YBu6ZFrh7sec2/BKQNDGa08gUe5KBri09FPFlVOicSYA5mf7IolK2KU
         72UM6KT8aT8kniSFORZKNK2PxyrwsnTKcubscEal6DpLIYPl/0wPKqKHhEhGMQuIFQa0
         5HYiq1srhLnTFQ2AkgImVyWexIT3Dd4G6IV/K2mwkzqaQbv/x273FYHRpQpCSdfVvwV6
         XL1TbJMqajAisfV/sLl4iDLd947b0cVyOUxICKTEfFMZ6U2k9IMDXaL8w2i6ug3o65q7
         ww5w==
X-Gm-Message-State: AOAM5326jLXofvMrFP6LjJd5FKe8lm24M9XVI1kTkOJH0DzkaVFA9uqH
        2XThfyQpJhMJpfspdgyNAWnIixLubF3JI0JPHCfFER2zwuhMdcRS8h/1Ylz18ZCzD6GbD3W5WWV
        AZe1wF/fYfP9I
X-Received: by 2002:aa7:ce87:: with SMTP id y7mr7283829edv.211.1611147172870;
        Wed, 20 Jan 2021 04:52:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9go95uH5akXQC+KBEihJbMv6KtIQM8A+/MZ1aH+Ky6Rn6XfXLrNt1ly2FZiJLGIP6BMj6cw==
X-Received: by 2002:aa7:ce87:: with SMTP id y7mr7283808edv.211.1611147172749;
        Wed, 20 Jan 2021 04:52:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m24sm861822ejo.52.2021.01.20.04.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:52:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EB048180331; Wed, 20 Jan 2021 13:52:51 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        kuba@kernel.org, jonathan.lemon@gmail.com, maximmi@nvidia.com,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        ciara.loftus@intel.com, weqaar.a.janjua@intel.com,
        Marek Majtyka <alardam@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/8] libbpf, xsk: select AF_XDP BPF program
 based on kernel version
In-Reply-To: <20210119155013.154808-6-bjorn.topel@gmail.com>
References: <20210119155013.154808-1-bjorn.topel@gmail.com>
 <20210119155013.154808-6-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Jan 2021 13:52:51 +0100
Message-ID: <875z3repng.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> Add detection for kernel version, and adapt the BPF program based on
> kernel support. This way, users will get the best possible performance
> from the BPF program.

Please do explicit feature detection instead of relying on the kernel
version number; some distro kernels are known to have a creative notion
of their own version, which is not really related to the features they
actually support (I'm sure you know which one I'm referring to ;)).

-Toke

