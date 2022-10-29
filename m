Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39317612122
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 09:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJ2HxY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 Oct 2022 03:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJ2HxX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Oct 2022 03:53:23 -0400
X-Greylist: delayed 17127 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Oct 2022 00:53:20 PDT
Received: from out203-205-251-73.mail.qq.com (out203-205-251-73.mail.qq.com [203.205.251.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030072872;
        Sat, 29 Oct 2022 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667029998;
        bh=+DzGGmzgC+pXMjNXZtuoYW7aaeiptNxaQfitvxP5P1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FYYuTW8Rx4q7D+sLngTrGEU0lDL/uPlA1pWUdhwPnHWsW8f0TL9rOLEbJ9LmZgPvy
         IvO8nmWDHK8XpkmvNpJIN4e73kPygjt7eaUPk3cVFbnUtFR3Y3beyW4Bw3FUAD6IFU
         vB6hhLYC5aydu2mCZlwOf98q8eM3Lf8noUrkRjCU=
Received: from localhost.localdomain ([111.199.189.86])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id D4E04CEB; Sat, 29 Oct 2022 15:53:14 +0800
X-QQ-mid: xmsmtpt1667029994t99qqcvlu
Message-ID: <tencent_7DD02046A8398BE3324F85E0F56ED41EB105@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtEqSkamGclXo01fwlP9MOoZDqUX1NWl3bDUhmuEGRou3hroWzZe
         fO0zJSGcZRxO4A+m7kerwdTwJSAUcu2pYdv5RCJxjLsxRSH43nvVnb8DmU8bAg1pgf8FG0FRFA0b
         H0E9RiE01svpNHEnVoVwJsYR5OLWjfoE1wEJRjG7lRKcNAb2oUt/s6Kehv1zAK6QdupLKl8DVQ0W
         kO4xShdrhmbIT4cCLKz4TfFDtGF/lJnmW1dXZ3eX+DnPstLUgQVteesFY2MVEPF8lR49BdYBMrpr
         voJoMpTGjsHk7lkfpTusbKrd3hB8PBTIXjDbkPis/PTnbJTX6IMOSO8UUVY1LJ6uXwW2Fdl72uuj
         XVEE1Iu3KVB4w5c4e04Kp8CQxX7FYReIhTuD2LNCU7+91OtQzk77K1uUjpZMYHB6zz4ahGsyDM0T
         mwPx5AEy1yhiS2sPXxJK0cTW/ipMSG1eTRAxIIFtsbI9BtvZieBPSBY2Gm4lqeZek34O5YEH32tn
         Ts1IxoazaO5pg+9UGCC9+75GaTe+UV7Ef6LtCihjtfTlapqihjcipd1f0yr6OLnftEwlnzUAPSed
         Gz8auusMeJLJ3P/RTLeQVtrmiTsBhZW14QpOkoPOOGALX+uKq4u3FyYjBEAb2w3Qqp7C05aDv9kr
         MzoqY1RnwOqEK2YzpL01nFtlRlr0Os3uQmX0AInQMPlxldN4gqNozW/2QbYEhFeoQeqYSajt4zZz
         YA8FEUjfkEu7XVzs4Iqu8Rv2ZI4Q9uyYEZG96aYKkL4ISIrzniPZMtIHVY0ABDJVy4Q7bfaCR+O/
         FCZSZ89A8a2HJojr4/wcBZ0ax3bWLlNCRcYH/W5C8aMOob9kjtN5gPqAZZHn06JPpyLwKYnbdQbZ
         qqPlJYozQZs+nABXfwmccEhoson0dZqOHvkYNZOQXUnFHbMxQPuNqPq2BocDqbfSOgHKUyy02gSB
         3c0X7gUx/NxZXnGXhPk9y+lw1gjcA/frEoASpuA/zeO6Q7wpC5mvG29f4Z6kkwQsk5oIPK2zE=
From:   Rong Tao <rtoax@foxmail.com>
To:     andrii.nakryiko@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next] samples/bpf: Fix sockex3: missing BPF prog type
Date:   Sat, 29 Oct 2022 15:53:12 +0800
X-OQ-MSGID: <20221029075312.45206-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAEf4Bza_6qND8iOuiur+xX0cBVkKJfKoJAOjihnVYRjoB3tWqw@mail.gmail.com>
References: <CAEf4Bza_6qND8iOuiur+xX0cBVkKJfKoJAOjihnVYRjoB3tWqw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

since commit 450b167fb9be("libbpf: clean up SEC() handling"),
sec_def_matches() does not recognize "socket/xxx" as "socket", therefore,
the BPF program type is not recognized, set "socket/xxx" to SOCKET_FILTER
solves this error.

 $ cd samples/bpf
 $ sudo ./sockex3
 libbpf: prog 'bpf_func_PARSE_IP': missing BPF prog type, check ELF section name 'socket/3'
 libbpf: prog 'bpf_func_PARSE_IP': failed to load: -22
 libbpf: failed to load object './sockex3_kern.o'
 ERROR: loading BPF object file failed

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/sockex3_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/bpf/sockex3_user.c b/samples/bpf/sockex3_user.c
index cd6fa79df900..dc79c17ad195 100644
--- a/samples/bpf/sockex3_user.c
+++ b/samples/bpf/sockex3_user.c
@@ -39,6 +39,9 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	bpf_object__for_each_program(prog, obj)
+		bpf_program__set_type(prog, BPF_PROG_TYPE_SOCKET_FILTER);
+
 	/* load BPF program */
 	if (bpf_object__load(obj)) {
 		fprintf(stderr, "ERROR: loading BPF object file failed\n");
-- 
2.31.1

