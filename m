Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE029823D
	for <lists+bpf@lfdr.de>; Sun, 25 Oct 2020 16:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416945AbgJYPNa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Oct 2020 11:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1416925AbgJYPN3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Oct 2020 11:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603638808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BW0pmlSPihsKBpCrU+u9mnxvxiC531ZaObDfhIazzx0=;
        b=fFnKSH26F5xQxp4Act0DZxwcqJ3+TxTZ9VGBlz1HL0YJOuNKkmOjzrUqfHYEawH/i7cLq2
        6cNqRFZ51A/pc+4Uv4ogR2WmiJpKuqeAMARUfh5hCF619uBDUT3oFPLDpE2B6bAzAUjbRb
        7iqCKA6XZUrMTCCJgx06aSL0RQLMEtU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-ancbEP0xP9i7UTB0Rpc-dw-1; Sun, 25 Oct 2020 11:13:26 -0400
X-MC-Unique: ancbEP0xP9i7UTB0Rpc-dw-1
Received: by mail-io1-f70.google.com with SMTP id x19so282581iow.23
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2020 08:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BW0pmlSPihsKBpCrU+u9mnxvxiC531ZaObDfhIazzx0=;
        b=JHO1WUoT8vHmMlLnmvIRVCEHt95+7LahojioulI0q416wB120zq8jMPsPvt4a44mgm
         HklgyUah3mX8vs9GyZhjmOlzhOTX5PpqzJgbw6Iduwa2gtsPZbBftRs+th6g00nFGgUS
         MbXXfPkNlhwiTuYMtcyPyfQ9cwUD6R+eowNA1X2tAJZ4HtKUOVhdPfLE2o7Wd2z7vg52
         uup2ivWaEYlMm/XU9VSGzotWALRxu2comg7un93+t3qAXN/I7+JwWUXW9u89FMqZpuOD
         4js5ZSO1dbbGS7niKVl0IJ460TS3f+Q3t1rLsellFYHyPdAg1s7eJUYHYBHI6/4d8wrL
         5Bow==
X-Gm-Message-State: AOAM531K3qJRTwVw3XYNdwpD1PmAAwwH0fnjj26Kf0QME5bJ5zhXNDME
        5PWH5H5A6pUomELPzB8hMrEc+G94eHSxtSDrJOrDbPdS3yN9EgQfy4Xz2IgBSji7aUOIwhh9SJ/
        b4y3sowIWRBLu
X-Received: by 2002:a02:a518:: with SMTP id e24mr8689337jam.131.1603638805889;
        Sun, 25 Oct 2020 08:13:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlQldSJLlwusJU2GMA08/TIVvvRjeRtzaxuUFVvAU2jTRs4z6GmjyPCYejdk4BG+O81YDuqw==
X-Received: by 2002:a02:a518:: with SMTP id e24mr8689318jam.131.1603638805601;
        Sun, 25 Oct 2020 08:13:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f22sm2347281ioh.34.2020.10.25.08.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 08:13:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1A55C181CEC; Sun, 25 Oct 2020 16:13:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     David Ahern <dsahern@gmail.com>, Hangbin Liu <haliu@redhat.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH iproute2-next 3/5] lib: add libbpf support
In-Reply-To: <29c13bd0-d2f6-b914-775c-2d90270f86d4@gmail.com>
References: <20201023033855.3894509-1-haliu@redhat.com>
 <20201023033855.3894509-4-haliu@redhat.com>
 <29c13bd0-d2f6-b914-775c-2d90270f86d4@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 25 Oct 2020 16:13:23 +0100
Message-ID: <87eelm5ofg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Ahern <dsahern@gmail.com> writes:

> On 10/22/20 9:38 PM, Hangbin Liu wrote:
>> Note: ip/ipvrf.c is not convert to use libbpf as it only encodes a few
>> instructions and load directly.
>
> for completeness, libbpf should be able to load a program from a buffer
> as well.

It can, but the particular use in ipvrf is just loading half a dozen
instructions defined inline in C - there's no object files, BTF or
anything. So why bother with going through libbpf in this case? The
actual attachment is using the existing code anyway...

-Toke

