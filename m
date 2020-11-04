Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F442A7012
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbgKDWA6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 4 Nov 2020 17:00:58 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:53002 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732137AbgKDV7g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 16:59:36 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-KbrjyP_dOTqHtslNMw_j3g-1; Wed, 04 Nov 2020 16:59:31 -0500
X-MC-Unique: KbrjyP_dOTqHtslNMw_j3g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45F938014C1;
        Wed,  4 Nov 2020 21:59:29 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 052221002C03;
        Wed,  4 Nov 2020 21:59:23 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: [PATCHv3 0/3] pahole/kernel: Workaround dwarf bug for function encoding
Date:   Wed,  4 Nov 2020 22:59:20 +0100
Message-Id: <20201104215923.4000229-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

v3 changes:
  - added Hao's ack for patch 1
  - fixed realloc memory leak [Andrii]
  - fixed addrs_cmp function [Andrii]
  - removed SET_SYMBOL macro [Andrii]
  - fixed the 'valid' function logic
  - added .init.bpf.preserve_type check
  - added iterator functions to new kernel section
    .init.bpf.preserve_type [Yonghong]

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

thanks,
jirka


[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060

