Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8C4A35FA
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2019 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfH3Lrc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Aug 2019 07:47:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbfH3Lrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 07:47:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64FA3875219;
        Fri, 30 Aug 2019 11:47:32 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-116-97.ams2.redhat.com [10.36.116.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D17931001938;
        Fri, 30 Aug 2019 11:47:30 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, jolsa@redhat.com
Subject: Re: [PATCH v2] bpf: s390: add JIT support for bpf line info
References: <xunyd0go9cba.fsf@redhat.com>
        <20190829200217.16075-1-yauheni.kaliuta@redhat.com>
        <879D38E9-3F3D-4C77-A370-8D4998F9FEF9@linux.ibm.com>
Date:   Fri, 30 Aug 2019 14:47:28 +0300
In-Reply-To: <879D38E9-3F3D-4C77-A370-8D4998F9FEF9@linux.ibm.com> (Ilya
        Leoshkevich's message of "Fri, 30 Aug 2019 13:39:19 +0200")
Message-ID: <xuny4l1yan8v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 30 Aug 2019 11:47:32 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Ilya!

>>>>> On Fri, 30 Aug 2019 13:39:19 +0200, Ilya Leoshkevich  wrote:

 >> Am 29.08.2019 um 22:02 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
 >> 
 >> This adds support for generating bpf line info for JITed programs
 >> like commit 6f20c71d8505 ("bpf: powerpc64: add JIT support for bpf
 >> line info") does for powerpc, but it should pass the array starting
 >> from 1 like x86, see commit 7c2e988f400e ("bpf: fix x64 JIT code
 >> generation for jmp to 1st insn".
 >> 
 >> That fixes test_btf.
 >> 
 >> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 >> ---
 >> 
 >> The patch is on top of "bpf: s390: add JIT support for multi-function
 >> programs"
 >> 
 >> V1-> V1:
 >> 
 >> - pass address array starting from element 1.
 >> 
 >> ---
 >> arch/s390/net/bpf_jit_comp.c | 1 +
 >> 1 file changed, 1 insertion(+)
 >> 
 >> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
 >> index b6801d854c77..ce88211b9c6c 100644
 >> --- a/arch/s390/net/bpf_jit_comp.c
 >> +++ b/arch/s390/net/bpf_jit_comp.c
 >> @@ -1420,6 +1420,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 fp-> jited_len = jit.size;
 >> 
 >> if (!fp->is_func || extra_pass) {
 >> +		bpf_prog_fill_jited_linfo(fp, jit.addrs + 1);
 >> free_addrs:
 >> kfree(jit.addrs);
 >> kfree(jit_data);
 >> -- 
 >> 2.22.0
 >> 

 > Checkpatch complains about the missing ")" at the end of
 > 7c2e988f400e commit description. With that fixed:

Huh, looks like I did not run checkpatch after the very last
editing :((

Thanks! Just a moment

 > Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
 > Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>

 > Thanks!

-- 
WBR,
Yauheni Kaliuta
