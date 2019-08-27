Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74479EBD4
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2019 17:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfH0PFr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Aug 2019 11:05:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfH0PFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Aug 2019 11:05:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C30FF10892CD;
        Tue, 27 Aug 2019 15:05:46 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 834EC5C1B2;
        Tue, 27 Aug 2019 15:05:45 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, jolsa@redhat.com
Subject: Re: [RFC PATCH] bpf: s390: add JIT support for multi-function programs
References: <20190826182036.17456-1-yauheni.kaliuta@redhat.com>
        <3F7BF2AC-E27D-4E69-90D6-07B36C7D7598@linux.ibm.com>
        <xunyd0gq8z39.fsf@redhat.com>
        <898C056B-D7F1-4CE9-AB86-D1C43E7A98E8@linux.ibm.com>
Date:   Tue, 27 Aug 2019 18:05:43 +0300
In-Reply-To: <898C056B-D7F1-4CE9-AB86-D1C43E7A98E8@linux.ibm.com> (Ilya
        Leoshkevich's message of "Tue, 27 Aug 2019 16:46:46 +0200")
Message-ID: <xuny4l228x88.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 27 Aug 2019 15:05:46 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Ilya!

>>>>> On Tue, 27 Aug 2019 16:46:46 +0200, Ilya Leoshkevich  wrote:

 >> Am 27.08.2019 um 16:25 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
 >> 
 >> Hi, Ilya!
 >> 
 >>>>>>> On Tue, 27 Aug 2019 15:21:30 +0200, Ilya Leoshkevich  wrote:
 >> 
 >>>> Am 26.08.2019 um 20:20 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
 >>>> 
 >>>> test_verifier (5.3-rc6):
 >>>> 
 >>>> without patch:
 >>>> Summary: 1501 PASSED, 0 SKIPPED, 47 FAILED
 >>>> 
 >>>> with patch:
 >>>> Summary: 1540 PASSED, 0 SKIPPED, 8 FAILED
 >> 
 >>> Are you per chance running with a testsuite patch like this one?
 >> 
 >>> --- a/tools/testing/selftests/bpf/test_verifier.c
 >>> +++ b/tools/testing/selftests/bpf/test_verifier.c
 >>> @@ -846,7 +846,7 @@ static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
 >>> tmp, &size_tmp, &retval, NULL);
 >>> if (unpriv)
 >>> set_admin(false);
 >>> -	if (err && errno != 524/*ENOTSUPP*/ && errno != EPERM) {
 >>> +	if (err && errno != EPERM) {
 >>> printf("Unexpected bpf_prog_test_run error ");
 >>> return err;
 >>> }
 >> 
 >>> Without it, all the failures appear to be masked for me.
 >> 
 >> BTW, I have several failures because of low BPF_SIZE_MAX. If I
 >> increase it, some tests pass (#585/p ld_abs: vlan + abs, test 1),
 >> but some crash (#587/p ld_abs: jump around ld_abs, haven't
 >> found the reason yet).
 >> 
 >> Have you observed anything like that?

 > Yes, this is because right now JIT generates clrj and friends,
 > which can jump only by +-32k. Improving this is actually my
 > next task (after fixing more or less "obvious" test suite
 > problems).

ah, great. Sorry for the noise.

-- 
WBR,
Yauheni Kaliuta
