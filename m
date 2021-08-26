Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E669D3F86FC
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhHZMKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 08:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234332AbhHZMKr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 08:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629979799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nWrE2HDlrjtGecuiHb39mNXd8P/fR0BmAr5iq/4KUOo=;
        b=d++5g4Wz4ySkn0nuSfmo8fsAOYICvJ0YKWZWxVwyTxrmwKs7H3mFqWK74+3Wst4MZjey+M
        W4+KN2fUzSwYkpjpamJuLsJXpynUTtGEPHjfu1UgB4dPsB4P66OAQs7DoErVW85dbNYhF1
        q/lGBq+1LpaQyWzJcKA2bpJGEoiFBM0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-gQxxC8iNNVuAZl9JRY65BA-1; Thu, 26 Aug 2021 08:09:58 -0400
X-MC-Unique: gQxxC8iNNVuAZl9JRY65BA-1
Received: by mail-ed1-f70.google.com with SMTP id g4-20020a056402180400b003c2e8da869bso1400449edy.13
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 05:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nWrE2HDlrjtGecuiHb39mNXd8P/fR0BmAr5iq/4KUOo=;
        b=NyawQ29TEPPbZ3kkxPfCfoEOi9QJUHuxOxHh4SqFZEipmJnxmshc1bK+mylwc02t+f
         +wOBtQuCNAynyeTTdVbOlBw2aS2By03irHE4HWsfykW4hkiPudx/GQwhMQcr9u5IWtvv
         vgT+q7DCysM9vYa9KXFh0AvH9MBtiEVZKjOVdI+259ExmYn106BcVOESxCKGdfcBKuV5
         Jd0qCPPXWcjSdHQQz9ZnBdCkRu3CbOTjT+ujtWiTjOSF5CiTOgaN0wG7zgqZmSPj8BNK
         vpnohfK6/Uagut4V/908domv4afiNm1WCMeppqM4VlywHHFjgB0N9ciZMCtS2tFk8VVK
         zjYg==
X-Gm-Message-State: AOAM532zOwIy1z5C/pael6YNo5CbVYydHLDkSTgp+BRkrA2qKdetyzV0
        4I/MbLql381t4n/mNih5Js85T0qhM2Vhm5Y08LFHoX2uV+2cCyZ0/QCounWV2sEE1rfUk+4AVSk
        xZaMG4d+SZ0Zr
X-Received: by 2002:a17:906:919:: with SMTP id i25mr3825645ejd.171.1629979797253;
        Thu, 26 Aug 2021 05:09:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDTy7MYeSlLofghaX7Wawjfw7wPqvh8RZCCqlh2GHsJC031WE+0KbJ0nbNLJyQJOtIjogVMA==
X-Received: by 2002:a17:906:919:: with SMTP id i25mr3825621ejd.171.1629979797009;
        Thu, 26 Aug 2021 05:09:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id mf2sm1292612ejb.76.2021.08.26.05.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 05:09:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 01CC8180082; Thu, 26 Aug 2021 14:09:54 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2] libbpf: ignore .eh_frame sections when parsing elf files
Date:   Thu, 26 Aug 2021 14:09:53 +0200
Message-Id: <20210826120953.11041-1-toke@redhat.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When .eh_frame and .rel.eh_frame sections are present in BPF object files,
libbpf produces errors like this when loading the file:

libbpf: elf: skipping unrecognized data section(32) .eh_frame
libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32) .eh_frame

It is possible to get rid of the .eh_frame section by adding
-fno-asynchronous-unwind-tables to the compilation, but we have seen
multiple examples of these sections appearing in BPF files in the wild,
most recently in samples/bpf, fixed by:
5a0ae9872d5c ("bpf, samples: Add -fno-asynchronous-unwind-tables to BPF Clang invocation")

While the errors are technically harmless, they look odd and confuse users.
So let's make libbpf filter out those sections, by adding .eh_frame to the
filter check in is_sec_name_dwarf().

v2:
- Expand explanation in the commit message

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 88d8825fc6f6..b1dc97b95965 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2909,7 +2909,8 @@ static Elf_Data *elf_sec_data(const struct bpf_object *obj, Elf_Scn *scn)
 static bool is_sec_name_dwarf(const char *name)
 {
 	/* approximation, but the actual list is too long */
-	return strncmp(name, ".debug_", sizeof(".debug_") - 1) == 0;
+	return (strncmp(name, ".debug_", sizeof(".debug_") - 1) == 0 ||
+		strncmp(name, ".eh_frame", sizeof(".eh_frame") - 1) == 0);
 }
 
 static bool ignore_elf_section(GElf_Shdr *hdr, const char *name)
-- 
2.33.0

