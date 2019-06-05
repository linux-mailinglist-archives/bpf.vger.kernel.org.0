Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20ADC3648B
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2019 21:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFETSH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 15:18:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37983 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfFETSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jun 2019 15:18:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so20606947wrs.5
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2019 12:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHKa8UUAI/1Pj5REqATA4zW8nm5JTzi55W6sOf5RHPs=;
        b=Sys2i/MD9135pbUQm2IA2lulB160+0KHKQmb/RLaKMSPNR5ERUFqkNZqBd6ZHpJhmd
         e4Cg+lnMWo4nsbbYIFn2iR36b7Enhy1CkpsuystlmGOc59GIDGdHSEUq6PDd+a7Yp3k3
         IHAz9M3GbBgTv/AYPQ3sB4sFR0R4UHc5u3F/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHKa8UUAI/1Pj5REqATA4zW8nm5JTzi55W6sOf5RHPs=;
        b=c1GvnM2pQItDOLasLxGC7/eGNoDsyHCStu4yExoilTCa3mukCvoazGecLrnUocThQ/
         DCpMqgBwJnVtOjjEnKh8oWh165hj8acsywca7qXHlxKcNFmawM2wWm+wcyUoKK6ULMWk
         Rf2uX4xJYybfUAuzccaXVuGrgwstUbxYlT89R8Ck/NPDBk+G3I6F6c2x5PSKm80tQzrk
         hg6I8SSVYdt9sc9Ix5FqMgC0VIBZgBtyJMhQd+QfuXCXR1jCcDOZFAKUMa/2fHELRrXY
         LIvfswnSdvLX1r8u6Nscahsm1iMWOgMc1gua7eul8P0ARS8SWvalIeOoWX1pAzCKIa5/
         T53g==
X-Gm-Message-State: APjAAAWi0QBGEHGpKq3RVvCSzlIE1wcmwldvfQEMxUgNR2TRuEtkZPM8
        Eqtj6qN8LJE+5zLC0Q5ZWEMONqKOBE+88SBx
X-Google-Smtp-Source: APXvYqzZiBuE8ulYjDrJz20818uUQcpSe7jdJE8UZeRzu0L0qCG2gg7pP0YrWgV1LTK80w8SAuJXvg==
X-Received: by 2002:a5d:680a:: with SMTP id w10mr5115453wru.42.1559762284615;
        Wed, 05 Jun 2019 12:18:04 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aebaf.dynamic.kabel-deutschland.de. [95.90.235.175])
        by smtp.gmail.com with ESMTPSA id h23sm13781580wmb.25.2019.06.05.12.18.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 12:18:03 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     bpf@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Stanislav Fomichev <sdf@google.com>,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Okash Khawaja <osk@fb.com>,
        David Calavera <david.calavera@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BPF v1] tools: bpftool: Fix JSON output when lookup fails
Date:   Wed,  5 Jun 2019 21:17:06 +0200
Message-Id: <20190605191707.24429-1-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In commit 9a5ab8bf1d6d ("tools: bpftool: turn err() and info() macros
into functions") one case of error reporting was special cased, so it
could report a lookup error for a specific key when dumping the map
element. What the code forgot to do is to wrap the key and value keys
into a JSON object, so an example output of pretty JSON dump of a
sockhash map (which does not support looking up its values) is:

[
    "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x00"
    ],
    "value": {
        "error": "Operation not supported"
    },
    "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x01"
    ],
    "value": {
        "error": "Operation not supported"
    }
]

Note the key-value pairs inside the toplevel array. They should be
wrapped inside a JSON object, otherwise it is an invalid JSON. This
commit fixes this, so the output now is:

[{
        "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x00"
        ],
        "value": {
            "error": "Operation not supported"
        }
    },{
        "key": ["0x0a","0x41","0x00","0x02","0x1f","0x78","0x00","0x01"
        ],
        "value": {
            "error": "Operation not supported"
        }
    }
]

Fixes: 9a5ab8bf1d6d ("tools: bpftool: turn err() and info() macros into functions")
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/bpf/bpftool/map.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 3ec82904ccec..5da5a7311f13 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -716,12 +716,14 @@ static int dump_map_elem(int fd, void *key, void *value,
 		return 0;
 
 	if (json_output) {
+		jsonw_start_object(json_wtr);
 		jsonw_name(json_wtr, "key");
 		print_hex_data_json(key, map_info->key_size);
 		jsonw_name(json_wtr, "value");
 		jsonw_start_object(json_wtr);
 		jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
 		jsonw_end_object(json_wtr);
+		jsonw_end_object(json_wtr);
 	} else {
 		const char *msg = NULL;
 
-- 
2.20.1

