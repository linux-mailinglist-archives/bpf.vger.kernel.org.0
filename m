Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D44260E3
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 02:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhJHAFq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 20:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhJHAFp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 20:05:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899DC061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 17:03:51 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k23-20020a17090a591700b001976d2db364so6488853pji.2
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n1t5p37iKBBcwF6sPtfDdCi5/kUJhRqol/yhhvJM3R0=;
        b=KVsz5DU4Ic50o9aw1EPRi2ClrYJtxHep59Lk8ladTwUFgpp4BF3f1XiiPb+YYkKWDo
         3s2etQi64mHgpv3xmov9uxDTXQrKyVni4lgALgjCfUrC6qhCPgG2VHi6aCIrGxPdAA88
         ks3QbEtK6Ni2vnGSyuejR0BaqSmy1n0D3sNEFK20fq0kAuzzv2OryYjshtveln9rL+GJ
         dkDBWcNuZkI6NEyg5Vo8hvWsFDWb4JV4eaHLfp1nrPmpVhTgw9orhNaPED3kuhiEQ3Un
         fjdSJtv/Axng6E2w+0xXEMFoM+AYJtxhkXmgpYIUtw7PUwPei/1Wom4zHLjqdTJrnIAY
         07ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n1t5p37iKBBcwF6sPtfDdCi5/kUJhRqol/yhhvJM3R0=;
        b=fi2Liq/7+N5JR74aXg2XBVsf56Yi3DDJPWl8DddPmLiIuPmCNBHjnW7fHRgDe13kWr
         E75vnUKgs5xGKymIO8ZA+vCcCzD9oAevCRqpnNUlcewvqACoEkrRYLcsnzizOR90OY/l
         7zZBRCjm2bsRPFu/sgHyFfMOEePTxtche2Jr8jyy17/n3E8o/qe+kYxCt0dLjr6XTQzT
         NrPACRlfOL2qS1vFu7IzA5flZtJDq/TQmbEWNvsY9a9LW3hpXXuV/9sNsX3jvrA6KYrR
         raZvtwIQHZcg9dO+vJAtqeVRzHjuhCCC3qPg63vte+T27GybdvjSl0f9eIfGVtuOxPnS
         CjtQ==
X-Gm-Message-State: AOAM532+nMYZyzMbxojuIYFvV3NtQHX0F1xIMenJVQkmAcpoTGWfWgu7
        1xC00sJayKtqogW5HdaMOvADlvdvMhVApg==
X-Google-Smtp-Source: ABdhPJw/nQVnRKtTR47gyExwkql1saVM3FEOzl66hgCrazxNq0OOhVpn/nLjX8QZyM7fMFbYqgaJuw==
X-Received: by 2002:a17:90a:910:: with SMTP id n16mr8633568pjn.246.1633651430861;
        Thu, 07 Oct 2021 17:03:50 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:500::e050])
        by smtp.gmail.com with ESMTPSA id u17sm342612pjn.30.2021.10.07.17.03.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 17:03:50 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf-next 09/10] libbpf: simplify look up by name of internal maps
Date:   Thu,  7 Oct 2021 17:03:08 -0700
Message-Id: <20211008000309.43274-10-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008000309.43274-1-andrii@kernel.org>
References: <20211008000309.43274-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Map name that's assigned to internal maps (.rodata, .data, .bss, etc)
consist of a small prefix of bpf_object's name and ELF section name as
a suffix. This makes it hard for users to "guess" the name to use for
looking up by name with bpf_object__find_map_by_name() API.

One proposal was to drop object name prefix from the map name and just
use ".rodata", ".data", etc, names. One downside called out was that
when multiple BPF applications are active on the host, it will be hard
to distinguish between multiple instances of .rodata and know which BPF
object (app) they belong to. Having few first characters, while quite
limiting, still can give a bit of a clue, in general.

Another downside of such approach is that it is not backwards compatible
and, among direct use of bpf_object__find_map_by_name() API, will break
any BPF skeleton generated using bpftool that was compiled with older
libbpf version.

Instead of causing all this pain, libbpf will still generate map name
using a combination of object name and ELF section name, but it will
allow looking such maps up by their natural names, which correspond to
their respective ELF section names. This means non-truncated ELF section
names longer than 15 characters are going to be expected and supported.

With such set up, we get the best of both worlds: leave small bits of
a clue about BPF application that instantiated such maps, as well as
making it easy for user apps to lookup such maps at runtime. In this
sense it closes corresponding libbpf 1.0 issue ([0]).

BPF skeletons will continue using full names for lookups.

  [0] Closes: https://github.com/libbpf/libbpf/issues/275

Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 054549846025..01ebdb8a36d1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9037,6 +9037,16 @@ bpf_object__find_map_by_name(const struct bpf_object *obj, const char *name)
 	struct bpf_map *pos;
 
 	bpf_object__for_each_map(pos, obj) {
+		/* if it's a special internal map name (which always starts
+		 * with dot) then check if that special name matches the
+		 * real map name (ELF section name)
+		 */
+		if (name[0] == '.') {
+			if (pos->real_name && strcmp(pos->real_name, name) == 0)
+				return pos;
+			continue;
+		}
+		/* otherwise map name has to be an exact match */
 		if (map_uses_real_name(pos)) {
 			if (strcmp(pos->real_name, name) == 0)
 				return pos;
-- 
2.30.2

