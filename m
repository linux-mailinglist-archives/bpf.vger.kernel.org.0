Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB479268E3C
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 16:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgINOsv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 10:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbgINOsn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 14 Sep 2020 10:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600094919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=W4P8//HlrhPt80RxRb260znKZ/8rgSdwWFcESpPeaME=;
        b=NwFUEH7gVJYCOAQjRtsphEhQ0Dmf+zrQSq1ueG93ZcFtDL9KwfTJSJ1RCyP1hwviCeyZvH
        cxm5ShcqdROrW1fTzQOZqcBxs6mk7qzyopowiOHPteL1BdqV9oFVujLBlIReyQNExwxepm
        7rbEJ9oWc97QtHS4CS4OaO7OBq3lvms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-8Fp63eJZNrm5wEZPICjQ0g-1; Mon, 14 Sep 2020 10:48:37 -0400
X-MC-Unique: 8Fp63eJZNrm5wEZPICjQ0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 019C1913123
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 14:48:37 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDD4627C2A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 14:48:36 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id E223E8C7D1;
        Mon, 14 Sep 2020 14:48:36 +0000 (UTC)
Date:   Mon, 14 Sep 2020 10:48:36 -0400 (EDT)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     bpf <bpf@vger.kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>
Message-ID: <748495289.11017858.1600094916732.JavaMail.zimbra@redhat.com>
In-Reply-To: <1723352278.11013122.1600093319730.JavaMail.zimbra@redhat.com>
Subject: Build failures: unresolved symbol vfs_getattr
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.195.179, 10.4.195.11]
Thread-Topic: Build failures: unresolved symbol vfs_getattr
Thread-Index: mVt8G1XSLssUMGkdQV7uHxEwnGJGvQ==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hello,

we tested the bpf-next tree with CKI and ran across build failures. The
important part of the build log is:

00:18:05   GEN     .version
00:18:05   CHK     include/generated/compile.h
00:18:05   LD      vmlinux.o
00:18:27   MODPOST vmlinux.symvers
00:18:27   MODINFO modules.builtin.modinfo
00:18:27   GEN     modules.builtin
00:18:27   LD      .tmp_vmlinux.btf
00:18:42   BTF     .btf.vmlinux.bin.o
00:19:13   LD      .tmp_vmlinux.kallsyms1
00:19:19   KSYM    .tmp_vmlinux.kallsyms1.o
00:19:22   LD      .tmp_vmlinux.kallsyms2
00:19:25   KSYM    .tmp_vmlinux.kallsyms2.o
00:19:28   LD      vmlinux
00:19:40   BTFIDS  vmlinux
00:19:40 FAILED unresolved symbol vfs_getattr
00:19:40 make[2]: *** [Makefile:1167: vmlinux] Error 255
00:19:40 make[1]: *** [scripts/Makefile.package:109: targz-pkg] Error 2
00:19:40 make: *** [Makefile:1528: targz-pkg] Error 2

Going git-bisect style, the issue is introduced by the patch series in [0].
Commit 2532f849b5134c4c62a20e5aaca33d9fb08af528 (last one before the
mentioned series were merged) passes, testing of
cd04b04de119a222c83936f7e9dbd46a650cb688 (last patch of the series)
fails. The failure is still present with the current top of the tree.

The kernel config used is a Fedora 32 config base + olddefconfig +
kselftest-merge, you can grab it directly from [1]. Environment is
Fedora rawhide.


The failure is easily reproduced with our container image that already
has all the needed dependencies installed:
registry.gitlab.com/cki-project/containers/builder-rawhide:latest


Steps to reproduce after starting the image:

git clone https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git --depth 1
curl https://gitlab.com/-/snippets/2014934/raw -o bpf-next/.config
cd bpf-next/
make -j 10 INSTALL_MOD_STRIP=1 targz-pkg



I already notified Jirka (cced) earlier today but am also sending a
bug report here in case someone else runs into the issue.

I can help with testing of potential fixes if it's needed.

Veronika


[0]: https://lore.kernel.org/bpf/20200825192124.710397-1-jolsa@kernel.org/
[1]: https://gitlab.com/-/snippets/2014934/raw

