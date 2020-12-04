Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394F22CEDFA
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 13:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgLDMVE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 07:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727385AbgLDMVD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 07:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607084378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R4OGEJo66P6rsNAhT6jP92o68BJnxBUwibF+4bWbC2k=;
        b=HTe/2PK48XE0HX8Dk1NkPwR6z6ofIVhdHI9Aq2SU1Z9hNTyP6brsRq2ailgpWAFn+yMPx0
        WxJd+mEcZkY5vF1RX9yj7/sEIEy6vd1BKGk4mQb2kNk4aGqpF//jyh666rQcNUUXWlkEMy
        CMWHiU1bb7k215c59iJVBRnXSaNDCSM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-u91IsDobPAy1lJJKbgekqg-1; Fri, 04 Dec 2020 07:19:36 -0500
X-MC-Unique: u91IsDobPAy1lJJKbgekqg-1
Received: by mail-ej1-f72.google.com with SMTP id f12so1999213ejk.2
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 04:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=R4OGEJo66P6rsNAhT6jP92o68BJnxBUwibF+4bWbC2k=;
        b=mf74nedq8Jt1hSVubdZus0jEK3CmeG8uPe0yHvPm3q6D/uICC31UIebswrrtk5VwPj
         x/KZotvqDUST4LU6NRsclSeMQahLV+VeluDQ1cnj7ClVw/Lfp68gioeVMLQVJbnX/4+T
         IdAd6wYALlbcgylUClV22dROFbOclW3o7Ob1KXwDg0CF72K2lH81Zb1Ai5mzGC7p610g
         2thUN7FdMWLRUH6o+FXRJx+FSSEXWSgKsfOvTaW4090IdQv5Za0k1wPki3spgxn8kAcr
         +ONTX2rsGRQmsmPEON4RRlj1pCVgQonAvUfhSkmTL0JlAQ5qsVKGF6ss8gxC7fuv8Y1e
         g19w==
X-Gm-Message-State: AOAM532MpeGYtUhUqVu9lzng35P0SmQm8atWK1X5SQJa9wIuV2IrM5Yp
        Pd1Lh1Gg9v0eMmyn/4grwZfO4r2mgxNoHqTSSQzCc1DotGvSpootJ6G/BHC3/I4BlV5f7XyIL5d
        7zVj9aFFjyoK0
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr6819059ejp.190.1607084373992;
        Fri, 04 Dec 2020 04:19:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHftUesGbbLZt8khqeFgqcDmh06X5sj1NJhXevWW4Jj6/igg4fia1bqWrg5ljp1M1eXKTFOw==
X-Received: by 2002:a17:906:660b:: with SMTP id b11mr6819030ejp.190.1607084373603;
        Fri, 04 Dec 2020 04:19:33 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id e27sm3007351ejm.60.2020.12.04.04.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:19:32 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 91941182EEA; Fri,  4 Dec 2020 13:19:32 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     alardam@gmail.com, magnus.karlsson@intel.com,
        bjorn.topel@intel.com, andrii.nakryiko@gmail.com, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        davem@davemloft.net, john.fastabend@gmail.com, hawk@kernel.org
Cc:     maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
        bpf@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        maciejromanfijalkowski@gmail.com, intel-wired-lan@lists.osuosl.org,
        Marek Majtyka <marekx.majtyka@intel.com>
Subject: Re: [PATCH v2 bpf 2/5] drivers/net: turn XDP properties on
In-Reply-To: <20201204102901.109709-3-marekx.majtyka@intel.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-3-marekx.majtyka@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 04 Dec 2020 13:19:32 +0100
Message-ID: <875z5h931n.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

alardam@gmail.com writes:

> From: Marek Majtyka <marekx.majtyka@intel.com>
>
> Turn 'hw-offload' property flag on for:
>  - netronome.

Can you add this to netdevsim as well, please? That way we can add a
test for it in test_offload.py once the userspace bits land in
ethtool...

-Toke

