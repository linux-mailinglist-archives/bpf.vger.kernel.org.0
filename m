Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67450211434
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgGAUTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 16:19:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50805 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgGAUTG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Jul 2020 16:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593634745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dKZmOeNL7dRFJv7ne+iMiyx9xpXNmjSAduaZbNtTvqg=;
        b=HKIaLv1v10q6ukJ3xMM05cqFGdhMtTwQy2sNbTUXfypbcq+pXk6AMM76ryqFXd97RA0dhW
        T/LjL1EXWkiYaUx7JKTa9RxQ5lgap8bSJPAJLhHLS6GRGSMZgdu9Xs82N7Xd50fhJKJtLH
        59T7SypWugz5ctkrVaCTimOuB1MYpF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-n52f086xOn-_yE-uxA0P3w-1; Wed, 01 Jul 2020 16:18:59 -0400
X-MC-Unique: n52f086xOn-_yE-uxA0P3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A20F264ACA;
        Wed,  1 Jul 2020 20:18:58 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 428EF79225;
        Wed,  1 Jul 2020 20:18:55 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 15801300003EB;
        Wed,  1 Jul 2020 22:18:54 +0200 (CEST)
Subject: [PATCH bpf-next V2 0/3] BPF selftests test runner test_progs
 improvement for scripting
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        vkabatov@redhat.com, jbenc@redhat.com
Date:   Wed, 01 Jul 2020 22:18:54 +0200
Message-ID: <159363468114.929474.3089726346933732131.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF selftest 'test_progs' contains many tests, that cover all the
different areas of the kernel where BPF is used.  The CI system sees this
as one test, which is impractical for identifying what team/engineer is
responsible for debugging the problem.

This patchset add some options that makes it easier to create a shell
for-loop that invoke each (top-level) test avail in test_progs. Then each
test FAIL/PASS result can be presented the CI system to have a separate
bullet. (For Red Hat use-case in Beaker https://beaker-project.org/)

Created a public script[1] that uses these features in an advanced way.
Demonstrating howto reduce the number of (top-level) tests by grouping tests
together via using the existing test pattern selection feature, and then
using the new --list feature combined with exclude (-b) to get a list of
remaining test names that was not part of the groups.

[1] https://github.com/netoptimizer/prototype-kernel/blob/master/scripts/bpf_selftests_grouping.sh

---

Jesper Dangaard Brouer (3):
      selftests/bpf: test_progs option for getting number of tests
      selftests/bpf: test_progs option for listing test names
      selftests/bpf: test_progs indicate to shell on non-actions


 tools/testing/selftests/bpf/test_progs.c |   37 ++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h |    2 ++
 2 files changed, 39 insertions(+)

--

