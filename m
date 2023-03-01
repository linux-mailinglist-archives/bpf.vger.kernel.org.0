Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB4E6A6934
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 09:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCAIzD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 03:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCAIzC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 03:55:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BA127D79
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 00:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677660855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DlW3kHBDAdQXToAj5qkrohzGUpsyTpz9hndHzJqw5hc=;
        b=dOSimHbM9KOQ488VO7qUg02tTJ8dCibEujThMmpXP2hc5dKfIbkK/vwhCV/s2qXJ0hoJD+
        1+24lQaQ3wLOM7miN8MM69P6sK+IH5UsIb/jR/xOvJt90QXvz4HCoRJhT2PS67jVbZuEU4
        LoW+SedLH4ChfoHPCamVsvuuCriJNas=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-p2Df4QIiMTCWUt_8FLNuSA-1; Wed, 01 Mar 2023 03:54:11 -0500
X-MC-Unique: p2Df4QIiMTCWUt_8FLNuSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84B7F2807D62;
        Wed,  1 Mar 2023 08:54:10 +0000 (UTC)
Received: from dhcph048.fit.vutbr.cz (unknown [10.45.224.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 627BA2026D4B;
        Wed,  1 Mar 2023 08:54:07 +0000 (UTC)
From:   Viktor Malik <vmalik@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 0/3] libbpf: fix several issues reported by static analysers
Date:   Wed,  1 Mar 2023 09:53:52 +0100
Message-Id: <cover.1677658777.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixing several issues reported by Coverity and Clang Static Analyzer
(scan-build) for libbpf, mostly removing unnecessary symbols and
assignments.

No functional changes should be introduced.

Viktor Malik (3):
  libbpf: remove unnecessary ternary operator
  libbpf: remove several dead assignments
  libbpf: cleanup linker_append_elf_relos

 tools/lib/bpf/btf.c       |  2 --
 tools/lib/bpf/libbpf.c    |  3 +--
 tools/lib/bpf/linker.c    | 11 ++---------
 tools/lib/bpf/relo_core.c |  3 ---
 4 files changed, 3 insertions(+), 16 deletions(-)

-- 
2.39.1

