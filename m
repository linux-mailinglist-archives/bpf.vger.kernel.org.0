Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59C0A6A27
	for <lists+bpf@lfdr.de>; Tue,  3 Sep 2019 15:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfICNkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Sep 2019 09:40:18 -0400
Received: from www62.your-server.de ([213.133.104.62]:46502 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICNkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Sep 2019 09:40:18 -0400
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i592e-0002Od-B7; Tue, 03 Sep 2019 15:40:16 +0200
Received: from [178.197.249.19] (helo=pc-63.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i592d-0004YW-S9; Tue, 03 Sep 2019 15:40:16 +0200
Subject: Re: [PATCH v3] bpf: s390: add JIT support for bpf line info
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, bpf@vger.kernel.org
Cc:     iii@linux.ibm.com, jolsa@redhat.com
References: <20190829200217.16075-1-yauheni.kaliuta@redhat.com>
 <20190830115109.3896-1-yauheni.kaliuta@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f630be61-c2af-028a-0160-8ebbbd3ea580@iogearbox.net>
Date:   Tue, 3 Sep 2019 15:40:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190830115109.3896-1-yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25561/Tue Sep  3 10:24:26 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/30/19 1:51 PM, Yauheni Kaliuta wrote:
> This adds support for generating bpf line info for JITed programs
> like commit 6f20c71d8505 ("bpf: powerpc64: add JIT support for bpf
> line info") does for powerpc, but it should pass the array starting
> from 1 like x86, see commit 7c2e988f400e ("bpf: fix x64 JIT code
> generation for jmp to 1st insn").
> 
> That fixes test_btf.
> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>

Applied, thanks! Few notes: please carry on Acked-by/Tested-by from
prior version since there haven't been fundamental changes. I've done
that manually now. Also, the reference above to x86 is somewhat
misleading since both JITs fill the addr array in a different manner
and the commit you've referenced is a bug fix (which would be good
if someone double checks on s390x).

Thanks,
Daniel
