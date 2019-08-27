Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6369EB70
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2019 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfH0OsL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Aug 2019 10:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfH0OsL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Aug 2019 10:48:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D7DF80F98;
        Tue, 27 Aug 2019 14:48:11 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-102.ams2.redhat.com [10.36.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F233C5D9C3;
        Tue, 27 Aug 2019 14:48:09 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>, daniel@iogearbox.net, jolsa@redhat.com
Subject: Re: [RFC PATCH] bpf: s390: add JIT support for multi-function programs
References: <20190826182036.17456-1-yauheni.kaliuta@redhat.com>
        <3F7BF2AC-E27D-4E69-90D6-07B36C7D7598@linux.ibm.com>
        <3DC02E46-160A-420E-B15F-1D68F7639851@linux.ibm.com>
        <xunyh8628z9w.fsf@redhat.com>
        <E6931E4D-0F0F-4572-AABD-BC896AEA6DD9@linux.ibm.com>
Date:   Tue, 27 Aug 2019 17:48:07 +0300
In-Reply-To: <E6931E4D-0F0F-4572-AABD-BC896AEA6DD9@linux.ibm.com> (Ilya
        Leoshkevich's message of "Tue, 27 Aug 2019 16:37:04 +0200")
Message-ID: <xuny8sre8y1k.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 27 Aug 2019 14:48:11 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Ilya!

>>>>> On Tue, 27 Aug 2019 16:37:04 +0200, Ilya Leoshkevich  wrote:

 >> Am 27.08.2019 um 16:21 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
 >> 
 >> Hi, Ilya!
 >> 
 >>>>>>> On Tue, 27 Aug 2019 15:46:43 +0200, Ilya Leoshkevich  wrote:
 >> 
 >>>> Am 27.08.2019 um 15:21 schrieb Ilya Leoshkevich <iii@linux.ibm.com>:
 >>>> 
 >>>>> Am 26.08.2019 um 20:20 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
 >>>>> 
 >>>>> test_verifier (5.3-rc6):
 >>>>> 
 >>>>> without patch:
 >>>>> Summary: 1501 PASSED, 0 SKIPPED, 47 FAILED
 >>>>> 
 >>>>> with patch:
 >>>>> Summary: 1540 PASSED, 0 SKIPPED, 8 FAILED
 >>>> 
 >>>> Are you per chance running with a testsuite patch like this one?
 >>>> 
 >>>> --- a/tools/testing/selftests/bpf/test_verifier.c
 >>>> +++ b/tools/testing/selftests/bpf/test_verifier.c
 >>>> @@ -846,7 +846,7 @@ static int do_prog_test_run(int fd_prog, bool
 >>>> unpriv, uint32_t expected_val,
 >>>> tmp, &size_tmp, &retval, NULL);
 >>>> if (unpriv)
 >>>> set_admin(false);
 >>>> -	if (err && errno != 524/*ENOTSUPP*/ && errno != EPERM) {
 >>>> +	if (err && errno != EPERM) {
 >>>> printf("Unexpected bpf_prog_test_run error ");
 >>>> return err;
 >>>> }
 >>>> 
 >>>> Without it, all the failures appear to be masked for me.
 >> 
 >>> Hmm, I'm sorry, I thought about it a bit more, and the patch I
 >>> posted above doesn't make any sense, because the failures you
 >>> fixed are during load, and not run time.
 >> 
 >>> Now I think you are using CONFIG_BPF_JIT_ALWAYS_ON for your
 >>> testing, is that right? If yes, it would be nice to mention
 >> 
 >> Right.
 >> 
 >>> this in the commit message.
 >> 
 >> Sure. Should I post non-RFC v2 or wait for some more comments?

 > So far I only spotted a minor issue:

 > +		if (ret < 0)
 > +			return ret;

 > Right now bpf_jit_insn returns 0 or -1, but
 > bpf_jit_get_func_addr returns 0 or -errno. This does not
 > affect anything in the end, but just to be uniform, maybe
 > return -1 here or -EINVAL in the default: branch?

ok. I choose "return -1" since changing default to -EINVAL sounds
as unrelated change to the patch.

 > I don't see any other obvious problems with the patch, but I'd
 > like to take some time to understand how exactly some parts of
 > it work before acking it. So I think it's fine to post a
 > non-RFC version.

Good, thanks!

-- 
WBR,
Yauheni Kaliuta
