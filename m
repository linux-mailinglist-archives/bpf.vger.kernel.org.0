Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED0B3D3881
	for <lists+bpf@lfdr.de>; Fri, 23 Jul 2021 12:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhGWJie (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Jul 2021 05:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44726 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230135AbhGWJiO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Jul 2021 05:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627035527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wAtWjoPMs7b2mfoHjDz+Kbot8us4IZ8w5i6dg1usQ+I=;
        b=NYwjXrd02/Rl8eIMkAbwCDZBZh2rB2vivj6MzDQ2OB6ObIa6COuqw8U4Imuz/zSoukOnWV
        gPgdA3ZPXit2m2BysnfDihvUY+d6uMu8u7hgno14Mq0C7qs+HnBKT2tUUzT8zhOulKtr7a
        wO3ra+32wJQ3UTcVgLWz/EK62PLvYLM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-jQ7GqsLkOQeGvWwimIDxqQ-1; Fri, 23 Jul 2021 06:18:45 -0400
X-MC-Unique: jQ7GqsLkOQeGvWwimIDxqQ-1
Received: by mail-io1-f69.google.com with SMTP id w4-20020a5ec2440000b029053e3f025a44so1312771iop.15
        for <bpf@vger.kernel.org>; Fri, 23 Jul 2021 03:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wAtWjoPMs7b2mfoHjDz+Kbot8us4IZ8w5i6dg1usQ+I=;
        b=bZOngvexUK8jcd2Oe2WPr72y9TZGKO4uXBlyko7oopFDBiQK2Fxk7s98qNiYDhvvv2
         2U4stEuu2zLxwaSCyB13uqOiAbHSc+zT2UxbeZhj+OGVPhbI65120Yy19EW2ANiv6Dag
         iyu+dlnPLXGBhjx9AG70Xr8Tpt7QipNLZ7ODWoCj/A6X9bQYRBS0OhhyAKUROZjUABur
         hkff3gKMDvtm3koU5PFrEqtqLifzgPRhf/XrbgKF51f8pwcZcbKwRjccLXOqYFnXN/pv
         D5KGp3cOtVTkdYh/bOyghiyQtGYA+QVPbdt3QZ09tvbkpW8JchnR/E4G3C4hEjuUccmh
         EdHw==
X-Gm-Message-State: AOAM530KZptpvOuuVS8np3wsIuJW7HBDVZguJekWBBSY12+n64AHdQaA
        5VVeUwK87NQYLMZbS2iglrqJFcOkT3owlLVVWXKpz6Lr8Poxcc+KmmZ/7Fw1+kCFx9FsGdnsEPM
        dgRK/YBPNjoKPxYxdkl5DOhL6wjO4
X-Received: by 2002:a92:8747:: with SMTP id d7mr3114542ilm.173.1627035524404;
        Fri, 23 Jul 2021 03:18:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnLBvtdojuHWZ+mNPTTTHfo9sbPOXAPakPJPZrby6KidLaTImlo80uTrFXXtrK0loo+mBtHtFm2LaSGMOgU7E=
X-Received: by 2002:a92:8747:: with SMTP id d7mr3114532ilm.173.1627035524289;
 Fri, 23 Jul 2021 03:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210723035721.531372-1-sashal@kernel.org> <20210723035721.531372-9-sashal@kernel.org>
 <CACT4oucVa5Lw538M2TEc1ZNU4mUZms+9fiTxw-p5-7J7xcM+kQ@mail.gmail.com>
In-Reply-To: <CACT4oucVa5Lw538M2TEc1ZNU4mUZms+9fiTxw-p5-7J7xcM+kQ@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Fri, 23 Jul 2021 12:18:33 +0200
Message-ID: <CACT4oudPRf=RjqxncVrWGpMNfYTUhHOEbydtTq1O-R70P47guA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.13 09/19] sfc: ensure correct number of XDP queues
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 23, 2021 at 12:12 PM =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com=
> wrote:
> This one can be applied too, but not really a must-have.

Sorry, I have to correct myself. Both must be applied:
58e3bb77bf1b sfc: ensure correct number of XDP queues
f43a24f446da sfc: fix lack of XDP TX queues - error XDP TX failed (-22)

Otherwise, if there are some left-over TXQs because of round up,
xdp_tx_queue_count coud be set to a wrong value, higher than it should
be.

Regards
--=20
=C3=8D=C3=B1igo Huguet

