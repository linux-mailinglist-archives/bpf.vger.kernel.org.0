Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8566C2D46DE
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 17:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgLIQgz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 11:36:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730525AbgLIQgt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 11:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607531722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKbfQ5NMpepEtLGaIbY4oPWcWPfYiGHOrnLYShZ/gfM=;
        b=P4Uknr64xLoaQh57YMs9U0OL3RD+3D1o4mkW7E57n4o5r7zToLa8lZA/n1VMmkEvzFcMLf
        wqi1nnN2O6rNnFw99/LAoGIMh/b5W/hQK0sbl0kGeK9gG6PgWEXtXQPyx2Wc0iFDKjpPfH
        yyM+SO9TA3JAeF8HuJY7zX1sBCMbGiY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-UujefTbjOkOPbhJ2VsvUnQ-1; Wed, 09 Dec 2020 11:35:21 -0500
X-MC-Unique: UujefTbjOkOPbhJ2VsvUnQ-1
Received: by mail-wr1-f69.google.com with SMTP id v1so860452wri.16
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 08:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qKbfQ5NMpepEtLGaIbY4oPWcWPfYiGHOrnLYShZ/gfM=;
        b=ETmK6AEdQZM4CRihoXyqm1wl7jfVAMkcRUX2DDol/HSKK/GtjBIzlDLm1H7NNA4vCY
         kNAuh5Jyth6PG5Bi95MPnFD3aqXT4oCH/WPP8D+Rv8yhbvPU+9L3SamkGOTwQkrfUM9Z
         PcZDjIwRqN3yU8dCPAmMMHc87SRedf0rMTbNaBHC1NuSWkQuXkl3hs1e6C1bNl3P8GhA
         weXBuO1miivEjcEussYDBbfzfhM0zr6RYVlhOGPrdTepakpVVon/pZUy7MVc16gsZoJn
         p/Qwcg1rySRGeswDkJVjJYBv0ZZSSH9uYaDYyLi62pslnlvjPDE5UVShZfhLvxVa8NJD
         MfeQ==
X-Gm-Message-State: AOAM5321q1Pxk5lmPaWk5XBlSVqym+3nNhP4+HTEjp+FMjcWdxhi96Uh
        l06CJoMoGCdO8D6M2PGCjbIfoagjyCPzl0gNHdM1L5UG+VzEhLooTGez+hbX8HOFL+ysPdYiT1x
        A8yPuRbtnTESY
X-Received: by 2002:adf:e64b:: with SMTP id b11mr3557924wrn.257.1607531719278;
        Wed, 09 Dec 2020 08:35:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOSGetvGWLvNiBbhFZtDNafEkdK0HcIhVsLONLeDTzLG1ZxkKy8fBmAKT54r9JsOK4JA58cQ==
X-Received: by 2002:adf:e64b:: with SMTP id b11mr3557876wrn.257.1607531718948;
        Wed, 09 Dec 2020 08:35:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id n14sm4415803wmi.1.2020.12.09.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:35:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AF8BF180068; Wed,  9 Dec 2020 17:35:17 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Simon Horman <simon.horman@netronome.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Jiri Benc <jbenc@redhat.com>, oss-drivers@netronome.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf v4 0/7] selftests/bpf: Restore test_offload.py to
 working order
In-Reply-To: <2263984f-68b9-c678-5cae-a26b3e96e36b@iogearbox.net>
References: <160752225643.110217.4104692937165406635.stgit@toke.dk>
 <2263984f-68b9-c678-5cae-a26b3e96e36b@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 09 Dec 2020 17:35:17 +0100
Message-ID: <87h7ovndiy.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 12/9/20 2:57 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> This series restores the test_offload.py selftest to working order. It s=
eems a
>> number of subtle behavioural changes have crept into various subsystems =
which
>> broke test_offload.py in a number of ways. Most of these are fairly beni=
gn
>> changes where small adjustments to the test script seems to be the best =
fix, but
>> one is an actual kernel bug that I've observed in the wild caused by a b=
ad
>> interaction between xdp_attachment_flags_ok() and the rework of XDP prog=
ram
>> handling in the core netdev code.
>>=20
>> Patch 1 fixes the bug by removing xdp_attachment_flags_ok(), and the rem=
inder of
>> the patches are adjustments to test_offload.py, including a new feature =
for
>> netdevsim to force a BPF verification fail. Please see the individual pa=
tches
>> for details.
>>=20
>> Changelog:
>>=20
>> v4:
>> - Accidentally truncated the Fixes: hashes in patches 3/4 to 11 chars
>> v3:
>> - Add Fixes: tags
>> v2:
>> - Replace xdp_attachment_flags_ok() with a check in dev_xdp_attach()
>> - Better packing of struct nsim_dev
>
> Applied, thanks! I took the liberty to document the prior review with 'LG=
TM' as
> an Ack so it's documented in the git log as well.

SGTM, thanks! :)

-Toke

