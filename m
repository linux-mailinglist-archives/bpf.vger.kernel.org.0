Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF992B0814
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 16:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgKLPFT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 12 Nov 2020 10:05:19 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:55835 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728274AbgKLPFS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 10:05:18 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-vwG7bqLTMvyOpFV0Wt3oZA-1; Thu, 12 Nov 2020 10:05:11 -0500
X-MC-Unique: vwG7bqLTMvyOpFV0Wt3oZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1729018B9EC1;
        Thu, 12 Nov 2020 15:05:09 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DFCE60C0F;
        Thu, 12 Nov 2020 15:05:07 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC 0/3] btf_encoder: Fix functions BTF data generation
Date:   Thu, 12 Nov 2020 16:05:03 +0100
Message-Id: <20201112150506.705430-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

I tried the approach I described in my former email and
basically process all dwarf data first and collect args
before we generate any BTF function.

I had to change LSK__DELETE to LSK__KEEPIT for every
CU we process, so that might have some implications
that I still need to check.

Andrii,
could you please check this with your gcc?

thanks,
jirka


---
Jiri Olsa (3):
      btf_encoder: Generate also .init functions
      btf_encoder: Put function generation code to generate_func
      btf_encoder: Func generation fix

 btf_encoder.c | 177 +++++++++++++++++++++++++++++++++++----------------------------------
 pahole.c      |   2 +-
 2 files changed, 91 insertions(+), 88 deletions(-)

