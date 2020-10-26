Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972282999BB
	for <lists+bpf@lfdr.de>; Mon, 26 Oct 2020 23:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394540AbgJZWga convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 26 Oct 2020 18:36:30 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:59899 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390190AbgJZWga (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Oct 2020 18:36:30 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-QSUjQuWVNhqXOqaRy69d0g-1; Mon, 26 Oct 2020 18:36:25 -0400
X-MC-Unique: QSUjQuWVNhqXOqaRy69d0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBE988049D7;
        Mon, 26 Oct 2020 22:36:23 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33F926EF50;
        Mon, 26 Oct 2020 22:36:18 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [RFC 0/3] pahole: Workaround dwarf bug for function encoding
Date:   Mon, 26 Oct 2020 23:36:14 +0100
Message-Id: <20201026223617.2868431-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
  - function is generated only once

These checks ensure that we encode function with defined
symbol/address and argument names.

I marked this post as RFC, because with this workaround in
place we are also encoding assembly functions, which were
not present when using the previous gcc version.

Full functions diff to previous gcc working version:

  http://people.redhat.com/~jolsa/functions.diff.txt

I'm not sure this does not break some rule for functions in
BTF data, becuse those assembly functions are not attachable
by bpf trampolines, so I don't think there's any use for them.

thoughts?
jirka


[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060
---
Jiri Olsa (3):
      btf_encoder: Move find_all_percpu_vars in generic config function
      btf_encoder: Change functions check due to broken dwarf
      btf_encoder: Include static functions to BTF data

 btf_encoder.c | 221 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
 elf_symtab.h  |   8 +++++
 2 files changed, 170 insertions(+), 59 deletions(-)

