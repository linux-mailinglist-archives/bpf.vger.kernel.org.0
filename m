Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0EB1E82AE
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 17:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgE2P7o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 11:59:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43405 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727062AbgE2P7o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 May 2020 11:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590767983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VntPpR9u98L+N1ionzHID7bD1Jl6O7zFn7tkv1DNgkg=;
        b=Oc/vY0HpNVZn2J4iarBb0/W8Zbju16V+WL3MkOlDIDbulLhSjO4Q+c/nEmAZJLh+59Dc/z
        Sh5348+4dkmdwVS1ljb00OOZxJA40S1451TbOEGVERkzn5l3nK6oQuG/cnD1aY0pTMzQ9n
        +3JBp7T0jGAytBKmO5mMjsVelSif218=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-RLG4ksL5Ps6bBoIUCXZlAg-1; Fri, 29 May 2020 11:59:41 -0400
X-MC-Unique: RLG4ksL5Ps6bBoIUCXZlAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6AA7464;
        Fri, 29 May 2020 15:59:39 +0000 (UTC)
Received: from firesoul.localdomain (unknown [10.40.208.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B876D5D9F3;
        Fri, 29 May 2020 15:59:36 +0000 (UTC)
Received: from [192.168.42.3] (localhost [IPv6:::1])
        by firesoul.localdomain (Postfix) with ESMTP id 8B6D9300003E9;
        Fri, 29 May 2020 17:59:35 +0200 (CEST)
Subject: [PATCH bpf-next RFC 0/3] bpf: dynamic map-value config layout via BTF
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     David Ahern <dsahern@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 29 May 2020 17:59:35 +0200
Message-ID: <159076794319.1387573.8722376887638960093.stgit@firesoul>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset is based on top of David Ahern's work V3: "bpf: Add support
for XDP programs in DEVMAP entries"[1]. The purpose is to address the kABI
interfaces that is introduced in that patchset, before it is released.

[1] https://lore.kernel.org/netdev/20200529052057.69378-1-dsahern@kernel.org

The map-value of these special maps are evolving into configuration
interface between userspace and kernel. The approach in[1] is to expose a
binary struct layout that can only be grown in the end of the struct.

With the BTF technology it is possible to create an interface that is much
more dynamic and flexible.

---

Jesper Dangaard Brouer (3):
      bpf: move struct bpf_devmap_val out of UAPI
      bpf: devmap dynamic map-value storage area based on BTF
      samples/bpf: change xdp_fwd to use new BTF config interface


 include/uapi/linux/bpf.h                           |    9 -
 kernel/bpf/devmap.c                                |  227 +++++++++++++++++---
 samples/bpf/xdp_fwd.h                              |   24 ++
 samples/bpf/xdp_fwd_kern.c                         |    5 
 samples/bpf/xdp_fwd_user.c                         |    9 +
 tools/include/uapi/linux/bpf.h                     |    9 -
 .../selftests/bpf/prog_tests/xdp_devmap_attach.c   |   18 +-
 .../bpf/progs/test_xdp_with_devmap_helpers.c       |   10 +
 8 files changed, 252 insertions(+), 59 deletions(-)
 create mode 100644 samples/bpf/xdp_fwd.h

--

