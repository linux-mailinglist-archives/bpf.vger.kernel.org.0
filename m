Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3801541E0
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2020 11:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgBFK3e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Feb 2020 05:29:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728394AbgBFK3d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Feb 2020 05:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580984972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=rLvLgIFZDxpilM3hf5DEhzcY/HFRNtYD6YOwnh0ogoY=;
        b=h5o1eGldVWADIgwt4ahfL8uohvV237L2TACJFkw3g7H7Ou87/dKmhQP+evFzCHsVQTa5MI
        /bkM4ISR/EH/wEJ940o9SEANvpsk7SlLfw2r5AoPql++UeyIX8KvSly6wqJT2Ecxi1DkcX
        Wq14liJ+3EraTwXChLJjygHJajPI+b4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-1Suq3jNkPJ2aHhwwSoZcNQ-1; Thu, 06 Feb 2020 05:29:30 -0500
X-MC-Unique: 1Suq3jNkPJ2aHhwwSoZcNQ-1
Received: by mail-lj1-f200.google.com with SMTP id y15so874680ljh.22
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2020 02:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rLvLgIFZDxpilM3hf5DEhzcY/HFRNtYD6YOwnh0ogoY=;
        b=R4X+Gn/dWRPPgrKc1Srn3Jwh8qe5Pm+OxFD5Vf7HvW9jy+5l3oSfa/IFIWsT3Zt5GI
         5SLLyKCohieilRz5ZgY1wNqMv2M8DQZJdgqzQ5cOp5klk2QRZqfyO2Ig1H3fSYkhzh62
         QlZ6fspw0hWb6tO/KfyAkWyoZ6OMbI+8GRshOxw1pQ2YGDvcXs9IJGljRZWJytgtCAfa
         c8ab7oJtF/d84Ed3DCMSQnWGhBb8zBFQdrUv2+YsQ3nsSBzuWCi2mc/myAvA4L4BqJcW
         8yocnCcYtW7ng6KfL/tIBzEK2vU/HETglzGhEvWKMpJtXilXGTNnrNnowkEJokzwbsdA
         1AuA==
X-Gm-Message-State: APjAAAWzXiJtVfRMCIGrg8yg2wu2Y3vZYqw/Xz/Y/HpnthgBZngvgNJp
        NB89kOA9sWlhdB4gjepExz/JISULZ98I9cwkPdc2oyMA1+zw3vXoCfvEoqavcpUhNEdNVEGkJhD
        EIbTl2/eb2a2H
X-Received: by 2002:ac2:5335:: with SMTP id f21mr1447275lfh.150.1580984968383;
        Thu, 06 Feb 2020 02:29:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwYbfo9IHDqEGxf6Vub/TsJPik3bcwC8zpaV6QIIn8M6U1RKrDRN0ymXE20jLuePMN6xC3CA==
X-Received: by 2002:ac2:5335:: with SMTP id f21mr1447259lfh.150.1580984968139;
        Thu, 06 Feb 2020 02:29:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y21sm1050515lfy.46.2020.02.06.02.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 02:29:27 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 31CC71802D4; Thu,  6 Feb 2020 11:29:24 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf] bpftool: Don't crash on missing xlated program instructions
Date:   Thu,  6 Feb 2020 11:29:06 +0100
Message-Id: <20200206102906.112551-1-toke@redhat.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Turns out the xlated program instructions can also be missing if
kptr_restrict sysctl is set. This means that the previous fix to check the
jited_prog_insns pointer was insufficient; add another check of the
xlated_prog_insns pointer as well.

Fixes: 5b79bcdf0362 ("bpftool: Don't crash on missing jited insns or ksyms")
Fixes: cae73f233923 ("bpftool: use bpf_program__get_prog_info_linear() in prog.c:do_dump()")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a3521deca869..b352ab041160 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -536,7 +536,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 		buf = (unsigned char *)(info->jited_prog_insns);
 		member_len = info->jited_prog_len;
 	} else {	/* DUMP_XLATED */
-		if (info->xlated_prog_len == 0) {
+		if (info->xlated_prog_len == 0 || !info->xlated_prog_insns) {
 			p_err("error retrieving insn dump: kernel.kptr_restrict set?");
 			return -1;
 		}
-- 
2.25.0

