Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A6E487EC7
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 23:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiAGWLY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 17:11:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230373AbiAGWLY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 17:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641593483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=W74pDxNFjz7NcYMYnihFwM/9aHZKzCb3JGwhZFxTX/A=;
        b=arbrR+A1RwTd/HKVEhKAhzFCCVZjC7leEmOM/JsSWOdRCXD7coLa7qz+KWzrFN2iBYl26k
        /LYSfcASE6HNRyP22SPb/GXjMIv6DBqfGLBaQdlpuGSj3Hl/zSc5F0LEuZ3CQ7KrGHgaVr
        9U9ytFVhSe0TkfyDp6+yvOBSp1S7dWI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-5VIQeHBIND6dNoDUvrUHwg-1; Fri, 07 Jan 2022 17:11:22 -0500
X-MC-Unique: 5VIQeHBIND6dNoDUvrUHwg-1
Received: by mail-ed1-f72.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso5720117edt.20
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 14:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W74pDxNFjz7NcYMYnihFwM/9aHZKzCb3JGwhZFxTX/A=;
        b=HA5TFq09FfEhgnUYr1RqW9dKZUthQ//OKmMbvfY0NPphlxbAimIvAhc/ljTPYYhNb1
         zUnkw+iYFDwwpdsg3+d6NOci7m9hxE31AmXydh1UF9OgzSlVPWYqqJrVFPKe8zhjPWP2
         AOR4W78AvgS9Wt0bfHuaxD2PTyHztoFc0DxKVQve2cw0ujGDFiwRQuP2b6in/zWFOKAo
         XO55sQ8zgC+MLIBkQdGC2yPQitasevBsgv9HipWkuSoILUDfj+MH7IbYtUVmbQKmbat6
         gkTHMa8+mGGiGhEEHzmiX9/MgvclSd/nWEnljYJ4P9miuAjuuE72UCDMDW+y9YyXwC3L
         fpug==
X-Gm-Message-State: AOAM533au7WNph6muiXvTpbJhqpCTbjL4GNJ1fAcBzju+LxaqvCbyy2Q
        bo7hqD08DPI1i8hP7cRR59Q1V/nuSL4ecB1aG4+gz6fmFVu0aX9j/klHC24XN1x8FV3imw/A6sC
        L9JJtuhlDRXkY
X-Received: by 2002:a17:906:f01:: with SMTP id z1mr22139422eji.346.1641593480132;
        Fri, 07 Jan 2022 14:11:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRefX40qs5EO3OKkITmeknKrexgrVp35uaBM2Gaea+gDH6rWiowUPlZZ4VJEWYCVYtgR67vw==
X-Received: by 2002:a17:906:f01:: with SMTP id z1mr22139392eji.346.1641593479180;
        Fri, 07 Jan 2022 14:11:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j13sm2645087edw.89.2022.01.07.14.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 14:11:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7B205181F2A; Fri,  7 Jan 2022 23:11:16 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        syzbot+983941aa85af6ded1fd9@syzkaller.appspotmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf v2 1/3] xdp: check prog type before updating BPF link
Date:   Fri,  7 Jan 2022 23:11:13 +0100
Message-Id: <20220107221115.326171-1-toke@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_xdp_link_update() function didn't check the program type before
updating the program, which made it possible to install any program type as
an XDP program, which is obviously not good. Syzbot managed to trigger this
by swapping in an LWT program on the XDP hook which would crash in a helper
call.

Fix this by adding a check and bailing out if the types don't match.

Fixes: 026a4c28e1db ("bpf, xdp: Implement LINK_UPDATE for BPF XDP link")
Reported-by: syzbot+983941aa85af6ded1fd9@syzkaller.appspotmail.com
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/core/dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index c4708e2487fb..2078d04c6482 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9656,6 +9656,12 @@ static int bpf_xdp_link_update(struct bpf_link *link, struct bpf_prog *new_prog,
 		goto out_unlock;
 	}
 	old_prog = link->prog;
+	if (old_prog->type != new_prog->type ||
+	    old_prog->expected_attach_type != new_prog->expected_attach_type) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
 	if (old_prog == new_prog) {
 		/* no-op, don't disturb drivers */
 		bpf_prog_put(new_prog);
-- 
2.34.1

