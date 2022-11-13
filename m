Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293166272A1
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 21:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiKMUwY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 15:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKMUwX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 15:52:23 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8674062CD
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 12:52:20 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id cg5so5812573qtb.12
        for <bpf@vger.kernel.org>; Sun, 13 Nov 2022 12:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iT6pfWern1Qiiv8smmZ52O7IcpGFrteGiRbpn9hGLEE=;
        b=SAF//zcSZ0Hcv6uF8z8sSDW+nSsB1vWBvKfiRO15K5dnptOtZOHGj1jsTzVgCxWRJ1
         nSVB/oZIdKhcVUJhLoDtPq1evkW2xC/1TIqhZquOTGq89NEehlttIKNh6oz8vWwAyzEh
         MUICYIik5+KC5npezQU1aK0qbeFuK2X+SajQJuduW2n06+ElyU8f5tmSIhbhZu5jzb06
         sapz8/BoH8B+0MtJkIoYgFUJe2tw8zkJG5ooWoPoAuSTwv2G/TT97S/gHBDd3FVgo3l1
         hujQ+t60p1Qn3saznNfX761v9EYrxUSEuqrvSHb52mWkQUaWinTEESz6vSp9pGw3rWtn
         KXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iT6pfWern1Qiiv8smmZ52O7IcpGFrteGiRbpn9hGLEE=;
        b=6QqIbKMZne6AB76n3FyEbM7rQfSryuM6WXoTJQejfFXAibmMAbmR8PXdDXNqrEFD+e
         oYihfof/V0Jj5Bz1ZgtVT6tVLVc/jRWJwiIMyFVidGs45HgJN8WL7Nmt16C1Z7mPXtTv
         vg3qXlE6sb1SNCx2J20tZGRgA559oR/6ncOCG+vHLNZ8+g/1tzyHS15jzzTq5o4Y+GB6
         ZQYhqqBOEduXXWpml9ADXy/xflNzJCVvEmBAxmebrpSQ/Tl7uxCse5FWqrZce8MQ29W3
         RY61MMPXOxHDS+xNYB4c7CVE33Tb+UhjJAU5BICSuTE68755rhknzvfWrgJ2Qw4h4K26
         yDWQ==
X-Gm-Message-State: ANoB5pnACjlpL8ydH2uk4fDVubLIpSg7bvAtpNjFyEoLE6VYkKwOKFLL
        FJgkhl59l7UDIo05s4As8HmelZCXND8=
X-Google-Smtp-Source: AA0mqf7tAKIWCcHkuACLz/ulHCNvusWbZeWDh6g92wKXQ+Hzu3LwRsB1X0+Y2Q6oFl9eD/euWLyQyg==
X-Received: by 2002:ac8:760a:0:b0:3a5:410c:bb75 with SMTP id t10-20020ac8760a000000b003a5410cbb75mr9856568qtq.423.1668372739381;
        Sun, 13 Nov 2022 12:52:19 -0800 (PST)
Received: from callisto (172-79-192-125.mrbg.wv.frontiernet.net. [172.79.192.125])
        by smtp.gmail.com with ESMTPSA id bv11-20020a05622a0a0b00b00398ed306034sm4699124qtb.81.2022.11.13.12.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 12:52:18 -0800 (PST)
From:   David Michael <fedora.dm0@gmail.com>
To:     andrii@kernel.org
Cc:     bpf@vger.kernel.org
Subject: [PATCH] libbpf: Fix uninitialized warning in btf_dump_dump_type_data
Date:   Sun, 13 Nov 2022 15:52:17 -0500
Message-ID: <87zgcu60hq.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

GCC 11.3.0 fails to compile btf_dump.c due to the following error,
which seems to originate in btf_dump_struct_data where the returned
value would be uninitialized if btf_vlen returns zero.

btf_dump.c: In function =E2=80=98btf_dump_dump_type_data=E2=80=99:
btf_dump.c:2363:12: error: =E2=80=98err=E2=80=99 may be used uninitialized =
in this function [-Werror=3Dmaybe-uninitialized]
 2363 |         if (err < 0)
      |            ^

Fixes: 43174f0d4597 ("libbpf: Silence uninitialized warning/error in btf_du=
mp_dump_type_data")
Signed-off-by: David Michael <fedora.dm0@gmail.com>
---

Hi,

I encountered this build failure when using Gentoo's hardened profile to
build sys-kernel/gentoo-kernel (at least some 5.19 and 6.0 versions).
The following patch fixes it.  Can this be applied?

Thanks.

David

 tools/lib/bpf/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 12f7039e0..e9f849d82 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1989,7 +1989,7 @@ static int btf_dump_struct_data(struct btf_dump *d,
 {
 	const struct btf_member *m =3D btf_members(t);
 	__u16 n =3D btf_vlen(t);
-	int i, err;
+	int i, err =3D 0;
=20
 	/* note that we increment depth before calling btf_dump_print() below;
 	 * this is intentional.  btf_dump_data_newline() will not print a
--=20
2.38.1
