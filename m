Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9BF487C36
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 19:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348765AbiAGSbK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 13:31:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241055AbiAGSbI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 13:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641580267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CnnFuMGhB5JyFl3Jry+SDDf7d1TYi2ACAz22LLK65xE=;
        b=bCQE51Uyh7x/eEChs9Um11b5i7zbeU19NlXZF8LNz1CW6D6NB0UAJNQVJRKCa8d84CEAUg
        f7Mujx+fytc9tiLKx+kTpIM6tBSJMsJoFF1+ayX+jke0r1VCeh+U5y6OpH6FsM16AXPda+
        dPiUUeNEoreSk+dQIkoFE8axOddR2vs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-sC02aEXYMfCh2bl_8s0LJg-1; Fri, 07 Jan 2022 13:31:06 -0500
X-MC-Unique: sC02aEXYMfCh2bl_8s0LJg-1
Received: by mail-ed1-f71.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so5365962edb.4
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 10:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnnFuMGhB5JyFl3Jry+SDDf7d1TYi2ACAz22LLK65xE=;
        b=tDMyIv/fSxFhAOPGxMFk/weKjb0HPii8ThqPzPEc5HPQEpXH4TcamcUAcMdcF4afve
         ZsMyu5gRWN588hn3uKfhcvhyWRI80vNlfk6QJKTavgkBgn61MOsGOmsEFAcuc5a+1NSx
         lwiecyGH6vK2M1vj3ECmFXfvKYFE/A0RZsrniZ//qw+8LSf9OtzsRZO3SZyqALzY+Gqv
         ccZ1eokKiMpK0KBRNQ68xHcxsLgIJsfaFeXzWPmRowE82xDu5kC8rwkdXh5lv0F7Enag
         ZYie1t5JjuIgw7gjMrdRdoNgeWDQxQ0ks7w/RVU1nwpqMVuAxvAUiY25t6aO6gCKfGoq
         SAJA==
X-Gm-Message-State: AOAM533SlOvKbXYnFjvnQEBnPmV+zwgyJ5MRWP33WGn4nIslL2GfrT9T
        yWrym5CA3etFXTMmTZOeqalsO+P7nA+HLIqyBZwb48KyH7mqH0nlGJBs4Tk97wifAeW3rRhQdsS
        lQRoiaHOnKxFL
X-Received: by 2002:a05:6402:28e:: with SMTP id l14mr2378929edv.396.1641580265228;
        Fri, 07 Jan 2022 10:31:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOjDvG04fHiqW1oMWTPMiyPLrLIZvdP2d1EgvGYDfE3UckOVJN/UxvqyJ1rQW3vEZHpke8HQ==
X-Received: by 2002:a05:6402:28e:: with SMTP id l14mr2378909edv.396.1641580264843;
        Fri, 07 Jan 2022 10:31:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 1sm1614361ejo.192.2022.01.07.10.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 10:31:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 617CF181F2A; Fri,  7 Jan 2022 19:31:03 +0100 (CET)
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
Subject: [PATCH bpf 1/2] xdp: check prog type before updating BPF link
Date:   Fri,  7 Jan 2022 19:30:48 +0100
Message-Id: <20220107183049.311134-1-toke@redhat.com>
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

