Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498911E377B
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 06:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgE0Epu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 00:45:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27864 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725294AbgE0Epu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 May 2020 00:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590554748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lY4nsy+z0erajJB0eMA92mGIWRcBi9lS2Mr4MNMGG0U=;
        b=RfR3CBTHHdv9bhKTzuxR66aTYxr3jJm+fzZFuRtqtjPadvc0sBd0bf/yTtuL76aB9LTH7K
        47SP69lbzKEAX9teA4TaKyF9qmrqPobp8XssxpdnwpdfHsGdO7H03e8MKOveO4fBxmrZTu
        IWte8IT0blFKEfR7rb8b1gGczFyMCus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-j3Tct9jZOea4b-feQmxWrw-1; Wed, 27 May 2020 00:45:42 -0400
X-MC-Unique: j3Tct9jZOea4b-feQmxWrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C70CD461;
        Wed, 27 May 2020 04:45:40 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4594310013D5;
        Wed, 27 May 2020 04:45:39 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 0/8] selftests/bpf: installation and out of tree build fixes
In-Reply-To: <77645d8b-2448-a35b-912a-abd3e329139d@iogearbox.net> (Daniel
        Borkmann's message of "Tue, 26 May 2020 23:48:01 +0200")
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
        <xuny367so4k3.fsf@redhat.com>
        <77645d8b-2448-a35b-912a-abd3e329139d@iogearbox.net>
Date:   Wed, 27 May 2020 07:45:37 +0300
Message-ID: <xunyzh9uouj2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Daniel!

>>>>> On Tue, 26 May 2020 23:48:01 +0200, Daniel Borkmann  wrote:

 > On 5/22/20 8:40 AM, Yauheni Kaliuta wrote:
 >> 
 >> Actually, a bit more needed :)

 > Not quite sure how to parse this, I presume you are intending
 > to send a v2 of this series with [0] folded in? Please also do
 > not add line-breaks in the middle of all your Fixes tags as
 > otherwise it would break searching for commits in the git
 > log. For the v2 respin, please also add a better cover letter
 > than just saying nothing more than 'I had a look, here are
 > some fixes.'. At least a minimal high level summary of the
 > selftest Makefile changes in this series.

Thanks! That was part of thread with Andrii, but I should have
sent separated. Anyway (see Andrii's comments) it's not coming as
is, so I'll do v2. Sorry for that. 

 > Thanks,
 > Daniel

 >   [0]
 > https://patchwork.ozlabs.org/project/netdev/patch/20200522081901.238516-1-yauheni.kaliuta@redhat.com/

 >>>>>>> On Fri, 22 May 2020 07:13:02 +0300, Yauheni Kaliuta  wrote:
 >> 
 >> > I had a look, here are some fixes.
 >> > Yauheni Kaliuta (8):
 >> >   selftests/bpf: remove test_align from Makefile
 >> >   selftests/bpf: build bench.o for any $(OUTPUT)
 >> >   selftests/bpf: install btf .c files
 >> >   selftests/bpf: fix object files installation
 >> >   selftests/bpf: add output dir to include list
 >> >   selftests/bpf: fix urandom_read installation
 >> >   selftests/bpf: fix test.h placing for out of tree build
 >> >   selftests/bpf: factor out MKDIR rule
 >> 
 >> >  tools/testing/selftests/bpf/Makefile | 77 ++++++++++++++++++++--------
 >> >  1 file changed, 55 insertions(+), 22 deletions(-)
 >> 
 >> > --
 >> > 2.26.2
 >> 
 >> 


-- 
WBR,
Yauheni Kaliuta

