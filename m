Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B894292B0C
	for <lists+bpf@lfdr.de>; Mon, 19 Oct 2020 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgJSQFC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Oct 2020 12:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730286AbgJSQFC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Oct 2020 12:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603123500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8bo8cf5aJo8M1yKCvFmSlNrAoAUtB8iBLzXxibkxA9Q=;
        b=C+CnhrfDyigWQQL9wPxwUko3PV/Mx5YSwh6KhyHklL9ohsshVNVM9FLGPzPLsRdwk2WOwM
        6rrM7W1sVQJRGwOMk/sWhya+bNLxiaij1Ha5oCPo7MniE0575FRGOrgaSv/xDPSbM+nXBw
        QWTDxGt8w42UYl9ywCWeZY9p58kERoI=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-92_quxVlMmCYlfKRyhO1zQ-1; Mon, 19 Oct 2020 12:04:58 -0400
X-MC-Unique: 92_quxVlMmCYlfKRyhO1zQ-1
Received: by mail-vk1-f198.google.com with SMTP id x134so94938vkd.17
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 09:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=8bo8cf5aJo8M1yKCvFmSlNrAoAUtB8iBLzXxibkxA9Q=;
        b=mi5btKlfGn5r6Jz+dd8h/BQbEeAG0sd/SrNIc9criuteyMfu+IpXRGAaYTUdD+tiwf
         370LqbtEyYc7ppV/8DQW4EPMzfCqfBJHKa3LPV6OmvgWolAwjinr5t6edjiE8Vn9eVkK
         QawQTMyCAhOedDHxpj4gN+J5QvIa8oT7IY6hD31kZNtXxQ8D0kE7C2ingsMaKCCGTqfh
         Eixg4mILsZV2vfXLanP9YBlY9f4ZgtwCXRA276GngG2jc37jXrpAozG29FRGueMxVad1
         B6hjUX64ZLsc5rpRWFHqwFNzSLl2ZmBNhYN6OYOuk+pGAw2II7Ldm8hvqHkik07vqKJm
         e9xw==
X-Gm-Message-State: AOAM531jGR+IMXZOOKhahbvUpSSY/38TpZifIgJ1t8zOspgmM7/+OY2D
        9SpwxAQG4vQXuxhzUpecyR8B1kzjbDYFW6BmxfMIhC8KesMX6DUq5BYfYAFJQAIoh45u9iWrFXO
        VhsFtQaxkRHZP
X-Received: by 2002:ab0:77d8:: with SMTP id y24mr115576uar.72.1603123497784;
        Mon, 19 Oct 2020 09:04:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7hgqYDiGK3fo9M+EQ0I/2eoGDqyHzpBNKEi1QG1ZZ12eqNIarn7r9ERJu1rzkvpreT3iOaA==
X-Received: by 2002:ab0:77d8:: with SMTP id y24mr115521uar.72.1603123497295;
        Mon, 19 Oct 2020 09:04:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r126sm34843vke.27.2020.10.19.09.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:04:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0811C1838FB; Mon, 19 Oct 2020 18:04:53 +0200 (CEST)
Subject: [PATCH bpf 0/2] bpf: Rework bpf_redirect_neigh() to allow supplying
 nexthop from caller
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Mon, 19 Oct 2020 18:04:53 +0200
Message-ID: <160312349392.7917.6673239142315191801.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Based on previous discussion[0], we determined that it would be beneficial to
rework bpf_redirect_neigh() so the caller can supply the nexthop information
(e.g., from a previous call to bpf_fib_lookup()). This way, the two helpers can
be combined without incurring a second FIB lookup to find the nexthop, and
bpf_fib_lookup() becomes usable even if no nexthop entry currently exists.

This patch (and accompanying selftest update) accomplishes this by way of an
optional paramter to bpf_redirect_neigh(). This series is against the -bpf tree,
since we need to change this call signature before it becomes API.

[0] https://lore.kernel.org/bpf/393e17fc-d187-3a8d-2f0d-a627c7c63fca@iogearbox.net/

Changelog:

v1:
- Rebase on -bpf tree
- Fix compilation with INET/INET6 disabled (kbot)
- Keep v4/v6 signatures similar, use internal flag (Daniel)
- Use a separate selftest BPF program instead of modifying existing one (Daniel)
- Fix a few style nits (David Ahern)

---

Toke Høiland-Jørgensen (2):
      bpf_redirect_neigh: Support supplying the nexthop as a helper parameter
      selftests: Update test_tc_redirect.sh to use the modified bpf_redirect_neigh()


 .../selftests/bpf/progs/test_tc_neigh.c       |   5 +-
 .../selftests/bpf/progs/test_tc_neigh_fib.c   | 142 ++++++++++++++++++
 .../testing/selftests/bpf/test_tc_redirect.sh |  27 +++-
 3 files changed, 169 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_tc_neigh_fib.c

