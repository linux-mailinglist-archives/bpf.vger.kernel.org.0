Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1A61B7B9A
	for <lists+bpf@lfdr.de>; Fri, 24 Apr 2020 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgDXQ3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Apr 2020 12:29:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40893 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXQ3X (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Apr 2020 12:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587745762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=Ua2JQC+8y80jj9oY9ZwRBXi6U/0wsfCWjB1ciNTr+8g=;
        b=aV/3ApJqmSVIX7WAz0UkeNp7q0/dbFcnesfa6bXzy87RaWItDdFOyuKoFjibhqJCDVtZlk
        68ZdWZ7+OoqdTgULwEh59e6dqzrIz2Z3RiBT/JznPCmyawPEIaqJ3GYGSQgF3cRDathnx9
        Cq7g8ZhxTlSWoxhGG10gV23rZFLGEt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-y0rO_QDxOfmpFOgaTa79tQ-1; Fri, 24 Apr 2020 12:29:17 -0400
X-MC-Unique: y0rO_QDxOfmpFOgaTa79tQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20AAE800D24;
        Fri, 24 Apr 2020 16:29:16 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 184F460605;
        Fri, 24 Apr 2020 16:29:16 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 0651A4CA94;
        Fri, 24 Apr 2020 16:29:16 +0000 (UTC)
Date:   Fri, 24 Apr 2020 12:29:15 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     andriin@fb.com
Cc:     bpf@vger.kernel.org, Jesper Brouer <jbrouer@redhat.com>
Message-ID: <1205209934.20590134.1587745755940.JavaMail.zimbra@redhat.com>
In-Reply-To: <187929551.20583102.1587742448675.JavaMail.zimbra@redhat.com>
Subject: selftests 'make install' crashing due to bpf makefile bug
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.195.205, 10.4.195.25]
Thread-Topic: selftests 'make install' crashing due to bpf makefile bug
Thread-Index: 4z6aAr0NRkFXjiA0z8fTacx9vFw6mw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi,

we've been working on adding selftests to CI for bpf-next and ran into
problems when running 'make install'.

Steps to reproduce:

make -C tools/testing/selftests install TARGETS="bpf"

The underlying build completes fine but the install step crashes with
following error:

rsync: link_stat "/kernel/bpf-next/tools/testing/selftests/bpf/runqslower"
       failed: No such file or directory (2)

lib.mk expects all TEST_GEN_PROGS_EXTENDED to be present in the subsystem
selftests directory, while runqslower is located in tools subdirectory
instead [0].

The directory override was originally added together with the runqslower
target in [1] a few months ago. The issue was most likely overlooked for
two reasons:
- people don't use 'make install' for bpf selftests
- kselftest_install.sh script happily continues after errors so while
  the same error is present, it is easy to overlook. runqslower is
  "simply" not present in the created kselftest_install/bpf


We currently see two potential solutions:
a) Remove "OUTPUT=$(SCRATCH_DIR)/" from runqslower target
   - Tested this for our use case but it has a potential of breaking
     workflows
b) Add a copy from bpf/tools to the bpf directory at the end of the target

Which one of them is preferred? Or does anyone have an alternative idea?
I'm willing to post a proper patch if needed (once we agree on the proper
fix) or test any proposals in our environment.


[0]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/Makefile#n143
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3a0d3092a4edbbc

Thanks,
Veronika

