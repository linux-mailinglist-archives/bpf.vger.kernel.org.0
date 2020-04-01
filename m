Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5B719ADA1
	for <lists+bpf@lfdr.de>; Wed,  1 Apr 2020 16:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732908AbgDAOSI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 1 Apr 2020 10:18:08 -0400
Received: from postout1.mail.lrz.de ([129.187.255.137]:40505 "EHLO
        postout1.mail.lrz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgDAOSI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 10:18:08 -0400
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
        by postout1.mail.lrz.de (Postfix) with ESMTP id 48spFT0jhJzyVF
        for <bpf@vger.kernel.org>; Wed,  1 Apr 2020 16:18:05 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: 0.814
X-Spam-Level: 
X-Spam-Status: No, score=0.814 tagged_above=-999 required=5
        tests=[ALL_TRUSTED=-1, BAYES_05=-0.5, LRZ_CT_PLAIN_ISO8859_1=0.001,
        LRZ_DATE_TZ_0000=0.001, LRZ_DKIM_DESTROY_MTA=0.001,
        LRZ_DMARC_OVERWRITE=0.001, LRZ_ENVFROM_FROM_ALIGNED_STRICT=0.001,
        LRZ_ENVFROM_FROM_MATCH=0.001, LRZ_FROM_AP_PHRASE=0.001,
        LRZ_FROM_HAS_A=0.001, LRZ_FROM_HAS_MDOM=0.001, LRZ_FROM_HAS_MX=0.001,
        LRZ_FROM_HOSTED_DOMAIN=0.001, LRZ_FROM_NAME_IN_ADDR=0.001,
        LRZ_FROM_PHRASE=0.001, LRZ_FWD_MS_EX=0.001, LRZ_HAS_CLANG=0.001,
        LRZ_HAS_THREAD_INDEX=0.001, LRZ_HAS_X_ORIG_IP=0.001,
        LRZ_MSGID_HL32=0.001, LRZ_RCVD_BADWLRZ_EXCH=0.001,
        LRZ_RCVD_MS_EX=0.001, LRZ_RDNS_NONE=1.5, RDNS_NONE=0.793,
        SPF_HELO_NONE=0.001] autolearn=no autolearn_force=no
Received: from postout1.mail.lrz.de ([127.0.0.1])
        by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id zE6r2xwqR_GC for <bpf@vger.kernel.org>;
        Wed,  1 Apr 2020 16:18:04 +0200 (CEST)
Received: from BADWLRZ-SWMBX05.ads.mwn.de (BADWLRZ-SWMBX05.ads.mwn.de [IPv6:2001:4ca0:0:108::161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "BADWLRZ-SWMBX05", Issuer "BADWLRZ-SWMBX05" (not verified))
        by postout1.mail.lrz.de (Postfix) with ESMTPS id 48spFS6XNkzySb
        for <bpf@vger.kernel.org>; Wed,  1 Apr 2020 16:18:04 +0200 (CEST)
Received: from BADWLRZ-SWMBX03.ads.mwn.de (2001:4ca0:0:108::159) by
 BADWLRZ-SWMBX05.ads.mwn.de (2001:4ca0:0:108::161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 1 Apr 2020 16:18:04 +0200
Received: from BADWLRZ-SWMBX03.ads.mwn.de ([fe80::b83a:fd44:92bb:7e5e]) by
 BADWLRZ-SWMBX03.ads.mwn.de ([fe80::b83a:fd44:92bb:7e5e%13]) with mapi id
 15.01.1913.010; Wed, 1 Apr 2020 16:18:04 +0200
From:   "Gaul, Maximilian" <maximilian.gaul@hm.edu>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Compare *bpf_ktime_get_ns* in userspace
Thread-Topic: Compare *bpf_ktime_get_ns* in userspace
Thread-Index: AQHWCDAD/UOqIiO7PUa5k89z3yfvHQ==
Date:   Wed, 1 Apr 2020 14:18:04 +0000
Message-ID: <847e02c956f249aa8daab85c538e75fe@hm.edu>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 04
X-MS-Exchange-Organization-AuthSource: BADWLRZ-SWMBX03.ads.mwn.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2003:c6:4f25:4b06:a9f2:d944:66d0:c35c]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I was just wondering whether there is a way to make the timestamp received in XDP/BPF via *bpf_ktime_get_ns* comparable with the usual functions in user-space such as *clock_gettime(CLOCK_MONOTONIC, &t);*?

Unfortunately, *ktime_get_ns* is defined as the time since system boot, but as far as I know, there is no way in user-space to determine the time since system boot any finer than in seconds.
