Return-Path: <bpf+bounces-66945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E15DB3B4DE
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 09:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B3A9847A5
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81E286D60;
	Fri, 29 Aug 2025 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kokq4rww"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD4285077;
	Fri, 29 Aug 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454136; cv=none; b=jYhrASCshKcUm4BruqVwNDrQyevnQawZWNlfHTZbiAJ7lnpfZxUA8ne1vMQF4k1kCpLoc/d6AOykxpaxyYocQeSqvNMTsA2NxckKWVyyg729vpMrT5EIkxv8piSwIV0QTFlv5Vj9C09iSCxN4dQfo92n+hre86xY84hUsde6dLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454136; c=relaxed/simple;
	bh=UJUK8/oCaP8or4xMM6dYj2gtHalMI9xq0zTRRM+Er48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQvZ1G9ecPqnXZg+rVVzVsDNpKcJQ1fObEzlTBXSdyJphpfsmHGTXkUqSdyAVIjigHHnNYSkVO+yuwc+a5FfCeVpTRW83LCc2cYrM9xvQXCYajhbkYGWN2UjcBfUfAzWUpvpYXh6yD2/M0lKQA3VL/pIMjpKLWxvAZQWYmKE8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kokq4rww; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-248c7f955a2so16704015ad.2;
        Fri, 29 Aug 2025 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454134; x=1757058934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1dzl/9HN9fCmWWoku2EUAe+4oZJtgdEcU9UZmXN/7A=;
        b=Kokq4rwwv9kr4Aoe18BW0bhcPqdWkfT8VFobv5jQ0ddyir/b8CkYjUUTzzk2/5NWD6
         k9ovOq3/edK3u9B5g8x0PR/uF65j7iZ7SPeHJDtlkaLEIPSZmunTi1ae+wdfjhbYMMEs
         Z6lcDyh0rcaB3I3RzTHV+oQ0B/nbBfSXZInDuWK85WA+rCjiyeLmQyDaFZ0yiUVZMz1t
         28KwQ1kVTsoabTsnDKQPwIiD5WuF/ePsSxct6Zg7SYFjqLsZ2Ru3t9YLEpaLNcUH1tF5
         37fD+hPEp6aFDDfLFvDBEu6SEI0IC+1vtvC74p1k0hwNrSJaPYVf4ngEezMn2vH8fv6i
         EY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454134; x=1757058934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1dzl/9HN9fCmWWoku2EUAe+4oZJtgdEcU9UZmXN/7A=;
        b=Ak3wnzQWT0gRbqvFYaB5oW7EIIbnDcZwSqKbTTK+XaNpyj9BMiUoK0ifC2YSuZmybx
         WDYSbTt06AeDPujou4w+xid9M7vYZQ6Zdp/ZPWhsHUOPMV/liETWpRRl5u2cnIqJnfZh
         ycjKxJFqz+MqAQqJAcbxieHdCeUePczNHFp3NPOKlhA/dlWdFg6N+47L36XsYAgEFZfy
         rEIlXt+fY2DMjAYy97q62/XwIh9IXa6a1f3mSpU9M6LJ3K0GjjA4qHWsxdKn86DI93z7
         mqz1q973mf8w5c/fPPu5/HRNEZKW/gVRbcE8RwVmOM4XrviyJSrG1Z8yKjCxixY0qozx
         YQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/kP5btMwaqykAgFlRB1o1XMmT900etxlz/GspTY8cMk9FhODTa1KP21zf92qQeEgeqXOOEPJ7sOUH@vger.kernel.org, AJvYcCUWIj/P/32OJegev1BTdZBa8LLqa3i+JBk3erobSK8moVKte88KmBWQ+AznBgJtxnumOTgb/g7x@vger.kernel.org, AJvYcCVHrqD/Ph2BeD3JjkOAjoR/fWeasbVdF8rWnHky6TwWUKLfmrn/OJubib2067IA++a2hJqpTA/ATv7uBoU=@vger.kernel.org, AJvYcCWEROOUk/uokrp44eT6Do82R8WqF28bIw94IKDET8hWmnAOQC42t4PQgP3FUj6DsFMUpAjypkfBNXhTXg==@vger.kernel.org, AJvYcCWLLW01uQs3QEDhMdvQwCucilt4eqvbzkHktMQnpcDtrU4V8CUKTMTmsqCMBooosWFlXt8=@vger.kernel.org, AJvYcCWLvokeoXvlBFFh5MNeIqWkOgsB0OQd7/q4OeWALSEku/XE2FTtn0yo4BdFdMtueAfw7p++/pj/fmni@vger.kernel.org, AJvYcCX8QgUP1FlVu7D8Vu2cL8oe7ic23Wnw25dqzSMFoB51fp0eqa7OKeCluiA5VH2g4MW0mQeU4ie8Q1w=@vger.kernel.org, AJvYcCXGEzbj/JF0nCS6SkPWJJxvH4N2WPfO2aX3dZJrMNlm6sugJtXabVxRVyHsRUU7nchFz4qKZJD/pP5ixduj@vger.kernel.org, AJvYcCXnQUZAxlb15sfSQeN+avIS7oG/SnGUWaD35JfZaLwaHo7GQ8eKKuCdlUQpS2yQam8dK+0Anp80LVgmbFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwuN6/iEdk4yLzGo7pPsGuVdOksnYPxSJtS3XReKMQIFEmyLL1
	CtW7JjWXcPmvhAkn/RD2jXuP6qgl1PbT/pwmC8sOruL01gxGyycn7UFc
X-Gm-Gg: ASbGncu4pG6TY0wFGGILhqbLTLZ3+gml0zIfrFc+8XKR7tcOIEclAEfwQX8myyoi25H
	t4Ss7HkjADGXXgsep8WFQEiWyap3qd+hoLwmhPeFwnuuZb9O+7WEaAyYN6W7OhmhTqqzA2IFjc7
	6e2gLC6PqQgl24nVdBSGbmWGF8uUzfM21Li+hZGslX33yIzWUY+ePs4VSwYeUkV5vGSmS5qwFZm
	M5Z0GOFaEKb/nOVkarrsZxZxr1VamCi+Wk8ctit81fH2Y8QNGZHdZNTpn6sbWvdlkTw/xspxucp
	hlT3cofzoHAt2a4M2caU1Q9PFhNcL6PHQ/brK1t4VCZOKOKjUBwe0A/FMK5kAWp+7FMe3XBsYTi
	aU5RPG7YFrP6lX4LWuoCpS9rK6TJ6/IqpO9Ud
X-Google-Smtp-Source: AGHT+IHHspv4kBSvuOju+syLfWNvxBR1WSkz7mrwJNK9paKzC+4NcNK8VdwZC8CcLSepusoSJLIitw==
X-Received: by 2002:a17:903:15ce:b0:246:c7dd:8da7 with SMTP id d9443c01a7336-246c7dd91f6mr219457635ad.32.1756454133503;
        Fri, 29 Aug 2025 00:55:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037043b3sm17009045ad.22.2025.08.29.00.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 92CC9411BF96; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DAMON <damon@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux KASAN <kasan-dev@googlegroups.com>,
	Linux Devicetree <devicetree@vger.kernel.org>,
	Linux fsverity <fsverity@lists.linux.dev>,
	Linux MTD <linux-mtd@lists.infradead.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Kernel Build System <linux-lbuild@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Sound <linux-sound@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	tytso@mit.edu,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 00/14] Internalize www.kernel.org/doc cross-reference
Date: Fri, 29 Aug 2025 14:55:10 +0700
Message-ID: <20250829075524.45635-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3498; i=bagasdotme@gmail.com; h=from:subject; bh=UJUK8/oCaP8or4xMM6dYj2gtHalMI9xq0zTRRM+Er48=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY17c4br6T35GuJHFF8Yt24416R5lZZr0d5nIjOkLd Wbtjd2k0FHKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJxIow/NNvVZZWvf59gvln 8f09a96zlV1ddP/qfkeet3OelO1bF7GW4X+WSslpN8ZtovrZdcGNj+0m353MlHX12bkXf15P2h5 ctoADAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Cross-references to other docs (so-called internal links) are typically
done following Documentation/doc-guide/sphinx.rst: either simply
write the target docs (preferred) or use :doc: or :ref: reST directives
(for use-cases like having anchor text or cross-referencing sections).
In some places, however, links to https://www.kernel.org/doc
are used instead (outgoing, external links), owing inconsistency as
these requires Internet connection only to see docs that otherwise
can be accessed locally (after building with ``make htmldocs``).

Convert such external links to internal links. Note that this does not
cover docs.kernel.org links nor touching Documentation/tools (as
docs containing external links are in manpages).

This series is based on docs-next tree.

Bagas Sanjaya (14):
  Documentation: hw-vuln: l1tf: Convert kernel docs external links
  Documentation: damon: reclaim: Convert "Free Page Reporting" citation
    link
  Documentation: perf-security: Convert security credentials
    bibliography link
  Documentation: amd-pstate: Use internal link to kselftest
  Documentation: blk-mq: Convert block layer docs external links
  Documentation: bpf: Convert external kernel docs link
  Documentation: kasan: Use internal link to kunit
  Documentation: gpu: Use internal link to kunit
  Documentation: filesystems: Fix stale reference to device-mapper docs
  Documentation: smb: smbdirect: Convert KSMBD docs link
  Documentation: net: Convert external kernel networking docs
  ASoC: doc: Internally link to Writing an ALSA Driver docs
  nitro_enclaves: Use internal cross-reference for kernel docs links
  Documentation: checkpatch: Convert kernel docs references

 Documentation/admin-guide/hw-vuln/l1tf.rst    |   9 +-
 .../admin-guide/mm/damon/reclaim.rst          |   2 +-
 Documentation/admin-guide/perf-security.rst   |   2 +-
 Documentation/admin-guide/pm/amd-pstate.rst   |   3 +-
 Documentation/block/blk-mq.rst                |  23 ++--
 Documentation/bpf/bpf_iterators.rst           |   3 +-
 Documentation/bpf/map_xskmap.rst              |   5 +-
 Documentation/dev-tools/checkpatch.rst        | 121 ++++++++++++------
 Documentation/dev-tools/kasan.rst             |   6 +-
 .../bindings/submitting-patches.rst           |   2 +
 .../driver-api/driver-model/device.rst        |   2 +
 Documentation/filesystems/fsverity.rst        |  11 +-
 Documentation/filesystems/smb/smbdirect.rst   |   4 +-
 Documentation/filesystems/sysfs.rst           |   2 +
 .../filesystems/ubifs-authentication.rst      |   4 +-
 Documentation/gpu/todo.rst                    |   6 +-
 Documentation/kbuild/reproducible-builds.rst  |   2 +
 Documentation/locking/lockdep-design.rst      |   2 +
 .../can/ctu/ctucanfd-driver.rst               |   3 +-
 .../device_drivers/ethernet/amazon/ena.rst    |   4 +-
 Documentation/networking/ethtool-netlink.rst  |   3 +-
 Documentation/networking/snmp_counter.rst     |  12 +-
 Documentation/process/coding-style.rst        |  15 +++
 Documentation/process/deprecated.rst          |   4 +
 Documentation/process/submitting-patches.rst  |   4 +
 Documentation/sound/soc/codec.rst             |   4 +-
 Documentation/sound/soc/platform.rst          |   4 +-
 Documentation/virt/ne_overview.rst            |  10 +-
 28 files changed, 165 insertions(+), 107 deletions(-)


base-commit: ee9a6691935490dc39605882b41b9452844d5e4e
-- 
An old man doll... just what I always wanted! - Clara


