Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8033E89E5
	for <lists+bpf@lfdr.de>; Wed, 11 Aug 2021 07:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhHKFwK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Aug 2021 01:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbhHKFwJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Aug 2021 01:52:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6FDC061765
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 22:51:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d17so1218834plr.12
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 22:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=G1JOgseE17QuGnTnIIRGKit07EFTiM5265wO8NpEMhc=;
        b=WgShVGlCKim5U95xhF5xbv9M7eCmxyf18R8v9bdtn2fXksV/X6OjGHlN+yZdIgF2EW
         5/SJcjr6nh+qPTA7I9IlYo1kLB0IQDVMSdayq8gjez8fmJ5CZ6j+jbRgURFJGoy7W2hz
         Kmk7yz4asLyQla2fgj7Nrj5bB9p0Fl5LJ2wdi7qNxlOJcKUM/wiOXPN5mEuy15YNsoi/
         bHNjL5/4rtWPYYbvFat9Ar+RQUMqrHbgW074R+GbV9TO+zPJKMJqbG7kT9IQMa2zYNkG
         Zhdnc9w1/Te/GBJoKUVq8GgW+vtEqdt3N2uW9pZwsbw1fXLBOjqn6NGnPdeyq6JJITYB
         2/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=G1JOgseE17QuGnTnIIRGKit07EFTiM5265wO8NpEMhc=;
        b=MsyIwRyzteKLwSZbFLk8YHOfdnJX+5wegOgy6E6vV0mEAb/ARTBu4OnbbDrUpy8kXu
         PBbBuSm5Nq9P2omIzCZPwk07+q9e/rkp/zh5+r1/oGAcVxHEHjlqRlaV3Rql0MHNgrKp
         /PQ11cr5HKVhcZnpCIA9r5u4k4PEKAG2pqm86jXre/3ofllBdWSTZashqfrH1VWXzDzZ
         ye6ztc0lfefJvvdD66/JL990g4gnxOKXXNkm7IXNMjlq5gxF/hUPl7ue54KllmZoQLbN
         XzR9p2EzEqUwjAB96yWXiegSCJ07syvwpMCFcocjHRd/jcIFtq0eqUmEjwdGlSHQ5Zn4
         NpiQ==
X-Gm-Message-State: AOAM532w6jSqFLbvmj+Z4q0kCgw8r7wvg7GSlXDJFIXnMnSxf98ruXR0
        aNok/az21+szlLXaO8BWVg6m0sy8zOO2tfSDKMfsftDmIAjtrs2Z
X-Google-Smtp-Source: ABdhPJzwI/jkRkRAIjEXKO//M+V4ApeRU0y43eNw6zrESsaKsEaVorb83P1toontG8WYRx6PXXHtKQEXuKIIfAP0DzA=
X-Received: by 2002:a63:1460:: with SMTP id 32mr48163pgu.323.1628661104524;
 Tue, 10 Aug 2021 22:51:44 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Date:   Wed, 11 Aug 2021 13:51:33 +0800
Message-ID: <CAEEdnKFMZaWtCkuezA5t_W2PyjB68VdaV67rqSaBwiUXqCPfvQ@mail.gmail.com>
Subject: [External] Kernel panic when running bpf selftest cases
To:     bpf <bpf@vger.kernel.org>, daniel <daniel@iogearbox.net>,
        ast <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I pull master branch code from upstream, and try to run bpf self test
cases.  The kernel panics when running tunnel related cases.
It seems that the kernel panics when calling the function
"_xfrm_get_state".  Could someone help to check this ?

The output message is as follows:
"
# [60] FUNC _xfrm_get_state type_id=59
# [61] VAR _version type_id=15 linkage=1
# [62] INT char size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
# [63] ARRAY (anon) type_id=62 index_type_id=6 nr_elems=4
# [64] VAR _license type_id=63 linkage=1
# [65] DATASEC license size=0 vlen=1 size == 0
#

Message from syslogd@n131-251-111 at Aug 11 13:14:15 ...
 kernel:[19128.469403] skbuff: skb_under_panic: text:ffffffff817f8480
len:257 put:12 head:ffff88828cdaf000 data:ffff88828cdaeff8 tail:0xf9
end:0x2c0 dev:ip6gretap11

Message from syslogd@n131-251-111 at Aug 11 13:14:15 ...
 kernel:[19128.554292] Kernel panic - not syncing: Fatal exception in interrupt
"
