Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DABF1264AD
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 15:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLSO3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 09:29:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47788 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726701AbfLSO3g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 09:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576765775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XXaL0Ehva81EpX1fgLORIXhqiGmMAsoySk2W7xqmZvc=;
        b=Izvzm/Hhn1xPE6iHmadJbQI9Z+s7gzPVDk9bXkuqGslnaBZ0OqR0AClmjcZ8R1b4VEPTlh
        QamzUujB58s7jSMUA4EUXShazqIF6AQndlB0gJTEcHAiu4oIitBD9V5SUpzFKo2BJPetGf
        B38Au3ptW8ZmWKHdc9AQf49lqQFI8yE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-gwJxFlCxO3azQeExi7hqwg-1; Thu, 19 Dec 2019 09:29:34 -0500
X-MC-Unique: gwJxFlCxO3azQeExi7hqwg-1
Received: by mail-lj1-f199.google.com with SMTP id z17so1974973ljz.2
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 06:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=XXaL0Ehva81EpX1fgLORIXhqiGmMAsoySk2W7xqmZvc=;
        b=ujKeDqnF/Zg7ZJyT+rm6XTKKoMqgxGH7AoUCWNc0XcBZ35BpbklY2qLPZJiXYlpwio
         /KHtPusdxpoIiVQZ6Wmf9JrVaIL4y60xSOo4iy0rDjNKUdP4wu9jo5WEllryAcH87jqi
         khNHWXRgrSaosb9vItdwDhIroYc5vDS3W2P/cc3CO1HmLZv6WSvucThqPVreg8HSd0ra
         gSSPPzsODgqzbF7JnlLaMt8+npLktPZSaA5hR24ZefA7MOKnvnvo0nTSor/+dyMuDbFU
         xbMYklhARhUrqx39wOTvv8yRof2p7dV1bnNI4szYuQIFM6kdn6b0r9aVkE4dDo9Lkqxi
         9r2g==
X-Gm-Message-State: APjAAAU26ZYpV2tNhNYzUGnajq8pmNGqsSAooOR449UaOxIRgyXSBDGx
        pZpXz17wnRDf7SZhL5zKqF37b8O8T31rF9Kid9nUaS4yOOQUMJcWg/c+by8Y8EBmzSYnlnTiWF/
        krQ0zhP3W59c/
X-Received: by 2002:a2e:8e72:: with SMTP id t18mr6212558ljk.132.1576765772518;
        Thu, 19 Dec 2019 06:29:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyWzHIpBrjXnAT0Xq2Y3XNH6XrhBLKBgA/hSFlWsvcUqO1ekrRgkQ3EDYnwqgoLsqjlnQNdfw==
X-Received: by 2002:a2e:8e72:: with SMTP id t18mr6212540ljk.132.1576765772350;
        Thu, 19 Dec 2019 06:29:32 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v24sm3515868ljc.18.2019.12.19.06.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 06:29:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 92EED180969; Thu, 19 Dec 2019 15:29:30 +0100 (CET)
Subject: [PATCH RFC bpf-next 0/3] libbpf: Add support for extern function
 calls
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Thu, 19 Dec 2019 15:29:30 +0100
Message-ID: <157676577049.957277.3346427306600998172.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds support for resolving function calls to functions marked as
'extern' in eBPF source files, by resolving the function call targets at load
time. For now, this only works by static linking (i.e., copying over the
instructions from the function target. Once the kernel support for dynamic
linking lands, support can be added for having a function target be an already
loaded program fd instead of a bpf object.

The API I'm proposing for this is that the caller specifies an explicit mapping
between extern function names and function names in the target object file.
This is to support the XDP multi-prog case, where the dispatcher program may not
necessarily have control over function names in the target programs, so simple
function name resolution can't be used.

I'm sending this series as an RFC because it's still a bit rough around the
edges: There are several places where I'm handling things in a way I'm pretty
sure is not the right way. And while this works for the simple programs added to
the selftest in patch 3, it fails with more complicated target programs.

My problem is that I don't really know what the right thing to do is for these
things, so I've marked them with FIXME comments in the code, in the hope that
someone more knowledgeable can suggest fixes.

Other regular RFC comments are welcome as well, of course; the API in particular
could use a second set of eyes or two :)

---

Toke Høiland-Jørgensen (3):
      libbpf: Add new bpf_object__load2() using new-style opts
      libbpf: Handle function externs and support static linking
      selftests/bpf: Add selftest for XDP multiprogs


 tools/lib/bpf/btf.c                                |   10 +
 tools/lib/bpf/libbpf.c                             |  299 ++++++++++++++++----
 tools/lib/bpf/libbpf.h                             |   28 ++
 tools/lib/bpf/libbpf.map                           |    1 
 .../selftests/bpf/prog_tests/xdp_multiprog.c       |   52 +++
 tools/testing/selftests/bpf/progs/xdp_drop.c       |   13 +
 tools/testing/selftests/bpf/progs/xdp_multiprog.c  |   26 ++
 7 files changed, 366 insertions(+), 63 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_multiprog.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_drop.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_multiprog.c

