Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC05F2B1E59
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 16:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgKMPM3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 13 Nov 2020 10:12:29 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:47330 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbgKMPM3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Nov 2020 10:12:29 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-CX9hI2wWPtaDmoJzA00chg-1; Fri, 13 Nov 2020 10:12:26 -0500
X-MC-Unique: CX9hI2wWPtaDmoJzA00chg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 456D2101F021;
        Fri, 13 Nov 2020 15:12:25 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DCFF5D9F1;
        Fri, 13 Nov 2020 15:12:23 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCHv2 0/2] btf_encoder: Fix functions BTF data generation
Date:   Fri, 13 Nov 2020 16:12:20 +0100
Message-Id: <20201113151222.852011-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
recent btf encoder's changes brakes BTF data for some gcc
versions. The problem is that some functions can appear
in dwarf data in some instances without arguments, while
they are defined with some.

v2 changes:
  - drop patch 3 logic and just change conditions
    based on Andrii's suggestion
  - drop patch 2
  - add ack for patch 1

Andrii,
please check if it's working with your gcc.

thanks,
jirka


---
Jiri Olsa (2):
      btf_encoder: Generate also .init functions
      btf_encoder: Fix function generation

 btf_encoder.c | 67 ++++++++++++-------------------------------------------------------
 1 file changed, 12 insertions(+), 55 deletions(-)

