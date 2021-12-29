Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B9481683
	for <lists+bpf@lfdr.de>; Wed, 29 Dec 2021 21:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhL2UA0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Dec 2021 15:00:26 -0500
Received: from ofcsgdbm.dwd.de ([141.38.3.245]:53089 "EHLO ofcsgdbm.dwd.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231419AbhL2UA0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Dec 2021 15:00:26 -0500
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Dec 2021 15:00:25 EST
Received: from localhost (localhost [127.0.0.1])
        by ofcsg2dn2.dwd.de (Postfix) with ESMTP id 4JPMV81QNJz2ym9
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 19:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dwd.de; h=
        content-type:content-type:mime-version:message-id:subject
        :subject:from:from:date:date:received:received:received:received
        :received:received:received:received; s=dwd-csg20210107; t=
        1640807488; x=1642017089; bh=G0+ktz/mXWsTWCyQVR/K1IMbKOf3E3xkd+g
        PxC8B3x0=; b=y/OPvhwcjkopul24xNeTjDo7FcCkrZtlotDgVR7oDJZ0QBxIEp1
        6RA+EKmRYAlLbC7gOFeqjFyULDUj/txkNSVk7MKUHOgYaVWmDyG8MV5dP6HPx6I4
        4t9hHE3H7f8Hj/Y9mkhOGnQTX43g4CgKI+EfiM9g3Cg0VZJYI4eK4R5DzlrxLrW+
        9+trG6jeX+SC6wB1ILEvNpxY+QePYK9EKsg8Tc+gsRqbFO//gzJojLTEr8lQzCP5
        n7l3qOlG8UBeNWrlmp8BlanWjqGENe0bhd6PZxy5xAcD8hMDOeaxrh84t6W8+zEx
        KQMxHrOBBbybUwf2ZFtNc37J9Rzfsjll28w==
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2ctev1.dwd.de ([172.30.232.67])
        by localhost (ofcsg2dn2.dwd.de [172.30.232.25]) (amavisd-new, port 10024)
        with ESMTP id UiTd_s52-2S4 for <bpf@vger.kernel.org>;
        Wed, 29 Dec 2021 19:51:28 +0000 (UTC)
Received: from ofcsg2ctev1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id F40FD5E108A
        for <root@ofcsg2dn2.dwd.de>; Wed, 29 Dec 2021 19:51:27 +0000 (UTC)
Received: from ofcsg2ctev1.dwd.de (unknown [127.0.0.1])
        by DDEI (Postfix) with ESMTP id E50255E1081
        for <root@ofcsg2dn2.dwd.de>; Wed, 29 Dec 2021 19:51:27 +0000 (UTC)
X-DDEI-TLS-USAGE: Unused
Received: from ofcsgdbm.dwd.de (unknown [172.30.232.25])
        by ofcsg2ctev1.dwd.de (Postfix) with ESMTP
        for <root@ofcsg2dn2.dwd.de>; Wed, 29 Dec 2021 19:51:27 +0000 (UTC)
Received: from ofcsgdbm.dwd.de by localhost (Postfix XFORWARD proxy);
 Wed, 29 Dec 2021 19:51:27 -0000
Received: from ofcsg2dvf1.dwd.de (ofcsg2dvf1.dwd.de [172.30.232.10])
        by ofcsg2dn2.dwd.de (Postfix) with ESMTPS id 4JPMV76CCCz2ym8;
        Wed, 29 Dec 2021 19:51:27 +0000 (UTC)
Received: from ofmailhub.dwd.de (ofmailhub.dwd.de [141.38.39.208])
        by ofcsg2dvf1.dwd.de  with ESMTP id 1BTJpR3x004009-1BTJpR40004009;
        Wed, 29 Dec 2021 19:51:27 GMT
Received: from diagnostix.dwd.de (diagnostix.dwd.de [141.38.44.45])
        by ofmailhub.dwd.de (Postfix) with ESMTP id BB779453F9;
        Wed, 29 Dec 2021 19:51:27 +0000 (UTC)
Date:   Wed, 29 Dec 2021 19:51:27 +0000 (GMT)
From:   Holger Kiehl <Holger.Kiehl@dwd.de>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: bpfilter: write fail messages with 5.15.x and centos 7.9.2009
 (fwd)
Message-ID: <a12e914c-4be1-85d9-5242-34855f9eeac@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-FE-Policy-ID: 2:2:1:SYSTEM
X-TMASE-Version: DDEI-5.1-8.6.1018-26622.002
X-TMASE-Result: 10--9.132200-10.000000
X-TMASE-MatchedRID: VDoNChkxNB7mzYT8cOkbWbxygpRxo469pWOBfK9L1z/qhznGDJ0qbWk6
        SkG4JvUZIXuvUou2O0KimSJP5hNpi8+9kIneOZlhHmtCXih7f9MpA2ExuipmWp+4ziUPq4LxbYJ
        NfOu+O6NO0Or7SjyKaK0Yi0eH5gffbvLgaIkO7vKeAiCmPx4NwFsKO+9Zlb5J9VtWc97tWtMXeu
        QCqIxled934/rDAK3zhG2qikEpQGU48KxzGT4fhKgVlx2/8uQQutPON7fSDcEmvhPF731mqrClN
        kgvr+26
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-DDEI-PROCESSED-RESULT: Safe
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

hope I am now sending it to the correct list.

Please, what else can I do to solve this?

Thanks,
Holger

---------- Forwarded message ----------
Date: Wed, 29 Dec 2021 13:27:58 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Subject: bpfilter: write fail messages with 5.15.x and centos 7.9.2009

Hello,

I just upgraded the kernel from 5.10.x to 5.15.12 on an old Centos
7.9.2009 server. The kernel is build on a new fedora 35 system
via 'make binrpm-pkg'. With this I see the following errors:

    [  232.140766] bpfilter: Loaded bpfilter_umh pid 6327
    [  232.152144] bpfilter: write fail -32
    [  232.187175] bpfilter: Loaded bpfilter_umh pid 6330
    [  232.198540] bpfilter: write fail -32
    [  232.234604] bpfilter: Loaded bpfilter_umh pid 6332
    [  232.245916] bpfilter: write fail -32
    [  232.281883] bpfilter: Loaded bpfilter_umh pid 6337
    [  232.293222] bpfilter: write fail -32
    [  232.335798] bpfilter: Loaded bpfilter_umh pid 6380
    [  232.347157] bpfilter: write fail -32
    [  244.411821] bpfilter: Loaded bpfilter_umh pid 6712
    [  244.423216] bpfilter: write fail -32

These appear as soon as something is done via iptables (setting
something or just viewing). Is this something I need to worry
about? Under 5.10.81 I did not see these messages.

In Jul 2020 I see a similar report 'bpfilter logging write errors in
dmesg', but could not find a solution.

Any hint what I can do to fix this?

Thanks,
Holger

