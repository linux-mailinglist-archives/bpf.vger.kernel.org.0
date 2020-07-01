Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE5B211544
	for <lists+bpf@lfdr.de>; Wed,  1 Jul 2020 23:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGAVoO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jul 2020 17:44:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22315 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgGAVoN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Jul 2020 17:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593639852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7+Ep6Xf/P4dFCVKuIZ74cprpetsQ+FPBd4xra2sllkc=;
        b=RZ1jtFkhoCPXq5432PTGQqo6+sDhRz+fWRnI6s5I2CXIXg7+rWxewVKxbMSRxO06g9BAuV
        EYA4k6Dm3zaObKFRmBVCKzR53I3moWZWWphU6r3n8sT6ZDF5NUbuV6FNjoyzKzi2EGOQ+e
        neDzV+iQuNFrRKFZeIZCboLCh10X8qg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-ODGiclHcPHi6yYTVchLHjw-1; Wed, 01 Jul 2020 17:44:08 -0400
X-MC-Unique: ODGiclHcPHi6yYTVchLHjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAE99879515;
        Wed,  1 Jul 2020 21:44:06 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73CA379235;
        Wed,  1 Jul 2020 21:44:03 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 57159300003EB;
        Wed,  1 Jul 2020 23:44:02 +0200 (CEST)
Subject: [PATCH bpf-next V3 0/3] BPF selftests test runner test_progs
 improvement for scripting
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        vkabatov@redhat.com, jbenc@redhat.com
Date:   Wed, 01 Jul 2020 23:44:02 +0200
Message-ID: <159363976938.930467.11835380146293463365.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

V3: Reorder patches to cause less code churn.

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
      selftests/bpf: test_progs indicate to shell on non-actions
      selftests/bpf: test_progs option for getting number of tests
      selftests/bpf: test_progs option for listing test names


 tools/testing/selftests/bpf/test_progs.c |   36 ++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h |    2 ++
 2 files changed, 38 insertions(+)

--

