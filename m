Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC92A1B0C
	for <lists+bpf@lfdr.de>; Sat, 31 Oct 2020 23:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgJaWbp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 31 Oct 2020 18:31:45 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:50904 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbgJaWbp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 31 Oct 2020 18:31:45 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-gMbSyiJCNFmTCj5WlHpgoA-1; Sat, 31 Oct 2020 18:31:40 -0400
X-MC-Unique: gMbSyiJCNFmTCj5WlHpgoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 760DB1084D62;
        Sat, 31 Oct 2020 22:31:38 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E16175261;
        Sat, 31 Oct 2020 22:31:32 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [PATCHv2 0/2] pahole: Workaround dwarf bug for function encoding
Date:   Sat, 31 Oct 2020 23:31:29 +0100
Message-Id: <20201031223131.3398153-1-jolsa@kernel.org>
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
because of gcc bug [1] we can no longer rely on DW_AT_declaration
attribute to filter out declarations and end up with just
one copy of the function in the BTF data.

It seems this bug is not easy to fix, but regardless if the
it's coming soon, it's probably good idea not to depend so
much only on dwarf data and make some extra checks.

Thus for function encoding we are now doing following checks:
  - argument names are defined for the function
  - there's symbol and address defined for the function
  - function address belongs to ftrace locations (new in v2)
  - function is generated only once

v2 changes:
  - add check ensuring functions belong to ftrace's mcount
    locations, this way we ensure to have in BTF only
    functions available for ftrace - patch 2 changelog
    describes all details
  - use collect* function names [Andrii]
  - use conventional size increase in realloc [Andrii]
  - drop elf_sym__is_function check
  - drop patch 3, it's not needed, because we follow ftrace
    locations

With v2 patchset I'm getting 38334 BTF functions, which is
reasonable subset of ftrace's available_filter_functions.

thanks,
jirka


[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060
---
Jiri Olsa (2):
      btf_encoder: Move find_all_percpu_vars in generic collect_symbols
      btf_encoder: Change functions check due to broken dwarf

 btf_encoder.c | 338 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 283 insertions(+), 55 deletions(-)

