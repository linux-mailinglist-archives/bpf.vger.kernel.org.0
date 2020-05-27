Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7B41E3A3D
	for <lists+bpf@lfdr.de>; Wed, 27 May 2020 09:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgE0HTm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 May 2020 03:19:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24009 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728303AbgE0HTl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 May 2020 03:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590563980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2WSodhddhcczpJcpZSP8fFSZgIhy8ts7ASS/NpkaoMA=;
        b=PQWdWcOzqdF/mb7dScesFcLV9feJV56RvjvaeeHsT6e2ipNSHvqauC1VZuQ9meAkaanYqZ
        Ge3KYO+hXpUqZvRXvQ0kRWWYbMDxG06NnOXfo/Uz6DdhlD6zdh3Jt71uIZ4Vkjl2s05Ekm
        E4FRsQykbYOc5ytd/dT7ecPH0VM5ij8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-XJjdueJBMRG6HRzmcQeNOQ-1; Wed, 27 May 2020 03:19:36 -0400
X-MC-Unique: XJjdueJBMRG6HRzmcQeNOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B145460;
        Wed, 27 May 2020 07:19:35 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-49.ams2.redhat.com [10.36.114.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BA845C1B0;
        Wed, 27 May 2020 07:19:32 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] selftests/bpf: split -extras target to -static and -gen
References: <xuny367so4k3.fsf@redhat.com>
        <20200522081901.238516-1-yauheni.kaliuta@redhat.com>
        <CAEf4BzZaCTDT6DcLYvyFr4RUUm4fFbyb743e1JrEp2DS69cbug@mail.gmail.com>
        <xunya71uosvv.fsf@redhat.com>
        <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
Date:   Wed, 27 May 2020 10:19:30 +0300
In-Reply-To: <CAADnVQJUL9=T576jo29F_zcEd=C6_OiExaGbEup6F-mA01EKZQ@mail.gmail.com>
        (Alexei Starovoitov's message of "Tue, 26 May 2020 22:37:39 -0700")
Message-ID: <xuny367lq1z1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Alexei!

>>>>> On Tue, 26 May 2020 22:37:39 -0700, Alexei Starovoitov  wrote:

 > On Tue, May 26, 2020 at 10:31 PM Yauheni Kaliuta
 > <yauheni.kaliuta@redhat.com> wrote:
 >> 
 >> Hi, Andrii!
 >> 
 >> >>>>> On Tue, 26 May 2020 17:19:18 -0700, Andrii Nakryiko  wrote:
 >> 
 >> > On Fri, May 22, 2020 at 1:19 AM Yauheni Kaliuta
 >> > <yauheni.kaliuta@redhat.com> wrote:
 >> >>
 >> >> There is difference in depoying static and generated extra resource
 >> >> files between in/out of tree build and flavors:
 >> >>
 >> >> - in case of unflavored out-of-tree build static files are not
 >> >> available and must be copied as well as both static and generated
 >> >> files for flavored build.
 >> >>
 >> >> So split the rules and variables. The name TRUNNER_EXTRA_GEN_FILES
 >> >> is chosen in analogy to TEST_GEN_* variants.
 >> >>
 >> 
 >> > Can we keep them together but be smarter about what needs to
 >> > be copied based on source/target directories? I would really
 >> > like to not blow up all these rules.
 >> 
 >> I can try, ok, I just find it a bit more clear. But it's good to
 >> get some input from kselftest about OOT build in general.

 > I see no value in 'make install' of selftests/bpf
 > and since it's broken just remove that makefile target.

Some CI systems perform testing next stage after building were
build tree is not available anymore. So it's in use at the
moment.

-- 
WBR,
Yauheni Kaliuta

