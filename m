Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF012C2CA7
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 17:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390292AbgKXQT3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 24 Nov 2020 11:19:29 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:53102 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390290AbgKXQT2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 11:19:28 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-C8JLxtVcNbqAPPPZTPfRhA-1; Tue, 24 Nov 2020 11:19:24 -0500
X-MC-Unique: C8JLxtVcNbqAPPPZTPfRhA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 536D6107B461;
        Tue, 24 Nov 2020 16:19:22 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 425211346D;
        Tue, 24 Nov 2020 16:19:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC 0/2] btf_encoder: Detect kernel modules
Date:   Tue, 24 Nov 2020 17:19:17 +0100
Message-Id: <20201124161919.2152187-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
adding support to detect kernel module and use its
mcount_loc section data as function filter.

It's working on my setup, but I fear there might be
kernel configuration where it could fail.

I'm mostly worried about the assumption that there's
always relocation section '.rela__mcount_loc' for
'__mcount_loc' section in kernel modules.

And because the relocation changes addresses, we need
to be sure we compare relative or relocated addresses.

I still need to double check scripts/recordmcount.c
to be sure about that. 

Any testing feedback would be great.

thanks,
jirka


---
Jiri Olsa (2):
      btf_encoder: Factor filter_functions function
      btf_encoder: Detect kernel module ftrace addresses

 btf_encoder.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
 dutil.c       |  16 ++++++++++++++++
 dutil.h       |   2 ++
 3 files changed, 137 insertions(+), 23 deletions(-)

