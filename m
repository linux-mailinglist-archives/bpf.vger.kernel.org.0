Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A284452FF
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 13:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhKDMcM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 08:32:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230148AbhKDMcL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Nov 2021 08:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636028973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bQXzPZMaU6OVRiducNageKXDUkhgANFnnTFSvV4jgyA=;
        b=e+Dd4QepsHWHrUb17msc2GSRt9SYtndnMoAeaGqRw26+9E/DbB1GYQvWYOT+T4uLfrhQkL
        ONvnOzJU4hmav8HGnsuk6WWnWi1AeN6KCIuI87o6MDyqHTPYfxpHHwu+XHXqO1Pcozy7UM
        Kznf48iM+lzjINEL3gH2NAnaDLoXrjc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-V0TfGQz6NQ-VvXLtFGkDJw-1; Thu, 04 Nov 2021 08:29:31 -0400
X-MC-Unique: V0TfGQz6NQ-VvXLtFGkDJw-1
Received: by mail-ed1-f69.google.com with SMTP id y12-20020a056402270c00b003e28de6e995so5534039edd.11
        for <bpf@vger.kernel.org>; Thu, 04 Nov 2021 05:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQXzPZMaU6OVRiducNageKXDUkhgANFnnTFSvV4jgyA=;
        b=HLNUxhzPwnsUczBjMThwA04DB0mTvpdyFraQ3mKbL50D5Cyin6z9kpRTlNATKtNNgK
         uM/f1UdB6JAiK3iADzZ9wE1n+9z2sdvCds3Zu21BR01dN4urzEwFCaGdS/jea2Nv/NzV
         v1qlqPKkk1mEUX4TdyOWNm1X68f1W7nQ/bC+61xmuIeBifVqZId7LxKR0BTp16Z2L1VH
         DJ6c9PR9Jvq4Jc32ZT7icSlzxnTbkl49ZEbLi6xx87CdEDhcJHhphPI7mWaWEDJAjkTZ
         K0Hf7+EgwP2qf0qZQ60xnnUdRa60pB2zuAMeFy7qpVsmVtrIbdTbqSoNuRbzk+lhRlct
         +z+A==
X-Gm-Message-State: AOAM533Ialv2ufFRrNF2/UOCooAGdna335Clypb3CjFFQZkPoy9wbl+L
        Txp3sUCtX8ZGtIaN+HxiIQ/+Ri8U1Vwvmnr/xvJMoa2u1vIQCKSnfm9YqNzZE1+mfR7tQXT3lt4
        degY7g9uHP1jE
X-Received: by 2002:a17:907:c0b:: with SMTP id ga11mr24681827ejc.39.1636028970537;
        Thu, 04 Nov 2021 05:29:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySnazKAUQe6h3xmQl47i+YRM9FMYzj6XeSlpopFjDiEVSyIkLI1GzQzf7IN2OpZ35ue9vfyA==
X-Received: by 2002:a17:907:c0b:: with SMTP id ga11mr24681776ejc.39.1636028970094;
        Thu, 04 Nov 2021 05:29:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z10sm3198746edd.12.2021.11.04.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 05:29:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 10DDF180248; Thu,  4 Nov 2021 13:29:29 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>,
        Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH bpf-next] libbpf: demote log message about unrecognised data sections back down to debug
Date:   Thu,  4 Nov 2021 13:29:11 +0100
Message-Id: <20211104122911.779034-1-toke@redhat.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When loading a BPF object, libbpf will output a log message when it
encounters an unrecognised data section. Since commit
50e09460d9f8 ("libbpf: Skip well-known ELF sections when iterating ELF")
they are printed at "info" level so they will show up on the console by
default.

The rationale in the commit cited above is to "increase visibility" of such
errors, but there can be legitimate, and completely harmless, uses of extra
data sections. In particular, libxdp uses custom data sections to store
metadata and run priority configuration of XDP programs, which triggers the
log message. Ciara noticed that when porting XSK code to use libxdp instead
of libbpf as part of the deprecation, libbpf would output messages like:

libbpf: elf: skipping unrecognized data section(7) .xdp_run_config
libbpf: elf: skipping unrecognized data section(8) xdp_metadata
libbpf: elf: skipping unrecognized data section(8) xdp_metadata
libbpf: elf: skipping unrecognized data section(8) xdp_metadata

In light of this, let's demote the message severity back down to debug so
that it won't clutter up the default output of applications.

Cc: Magnus Karlsson <magnus.karlsson@intel.com>
Reported-by: Ciara Loftus <ciara.loftus@intel.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a1bea1953df6..ac0eadbe1475 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3297,8 +3297,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 				obj->efile.st_ops_data = data;
 				obj->efile.st_ops_shndx = idx;
 			} else {
-				pr_info("elf: skipping unrecognized data section(%d) %s\n",
-					idx, name);
+				pr_debug("elf: skipping unrecognized data section(%d) %s\n",
+					 idx, name);
 			}
 		} else if (sh->sh_type == SHT_REL) {
 			int targ_sec_idx = sh->sh_info; /* points to other section */
-- 
2.33.0

