Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD461E378C
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 06:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgE0Ewc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 00:52:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51912 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725294AbgE0Ewc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 May 2020 00:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590555151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ja/cStKxag9nXu1z0czzY4VTO1HDbvhSpCRFAWDBR94=;
        b=AIKEpVSCvdUwnQXDDzmqlGlIkuZhnWXJKalNoo6WFe1CaOZDKM8U+tI+R3Evuj0SoloppZ
        QjlG7+X8xGSdz60JzfeU2H9g3dUtBg6z8gU2EQkm0ic1ALS/0ach+E3BMcRkFpBY1vqjca
        Wp7DXw/i1gwWOdoOL/+ClEMBQCcMPII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-37YDUOYLOIKJ4GMlL7e5cw-1; Wed, 27 May 2020 00:52:26 -0400
X-MC-Unique: 37YDUOYLOIKJ4GMlL7e5cw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6239D18FE864;
        Wed, 27 May 2020 04:52:25 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8F8979C57;
        Wed, 27 May 2020 04:52:21 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/8] selftests/bpf: installation and out of tree build fixes
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
        <xuny367so4k3.fsf@redhat.com>
        <CAEf4BzZd507Hyfu8GYxZfJ-Rc0GAs1UNCN0uBqX3kYS9sz-yDA@mail.gmail.com>
Date:   Wed, 27 May 2020 07:52:19 +0300
In-Reply-To: <CAEf4BzZd507Hyfu8GYxZfJ-Rc0GAs1UNCN0uBqX3kYS9sz-yDA@mail.gmail.com>
        (Andrii Nakryiko's message of "Tue, 26 May 2020 15:32:10 -0700")
Message-ID: <xunyv9kiou7w.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Andrii!

>>>>> On Tue, 26 May 2020 15:32:10 -0700, Andrii Nakryiko  wrote:

 > On Thu, May 21, 2020 at 11:41 PM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 
 >> 
 >> Actually, a bit more needed :)

 > From the other kselftest thread, it seems like selftests are not
 > supporting builds out-of-tree. With that, wouldn't it be simpler to
 > build in tree and then just copy selftests/bpf directory to wherever
 > you need to run tests from? It would be simple and reliable. Given I
 > and probably everyone else never build and run tests out-of-tree, it's
 > just too easy to break this and you'll be constantly chasing some
 > non-obvious breakages...

 > Is there some problem with such approach?

This is `make install` ;).

I personally do not need OOT build, but since it's in the code,
I'd prefer either fix it or remove it, otherwise it's
misleading. But I have not got reply from kselftest.

 >> 
 >> >>>>> On Fri, 22 May 2020 07:13:02 +0300, Yauheni Kaliuta  wrote:
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
 >> --
 >> WBR,
 >> Yauheni Kaliuta
 >> 


-- 
WBR,
Yauheni Kaliuta

