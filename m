Return-Path: <bpf+bounces-3601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE47405C1
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 23:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B4B1C20A90
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 21:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F4D511;
	Tue, 27 Jun 2023 21:39:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52C7473
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 21:39:24 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B45B213F
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 14:39:23 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id DD8BCC131C4F
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1687901962; bh=fN7WC0Dw+aFT5eQkUCcoCD923XPHPtuph4YpM/RgdSo=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Hf7A4BBx/3EEHepLV8tRoG+Zz0jo6VfedbLVmmiQPrc3nD9fWUAuiXuShTlK40Omk
	 Z6PmaRXfVkFHqoSTam0w4Z9ks2a3t2rkllTTwIreD53Jdh3659mITDVLzRXE+hGGBR
	 EA+i6P1/yEGSuOrDXyT+7+HRECBrMb6f74iytlCk=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id BB846C137393;
 Tue, 27 Jun 2023 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1687901962; bh=fN7WC0Dw+aFT5eQkUCcoCD923XPHPtuph4YpM/RgdSo=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=GAKZ4UxY+Hi2Y+TL+FXSFUKEc5Mtn82K12IgIC356jP0ktoWocWhLl3cTzeX59g4W
 hN1IJIKG1D5vdoGC7QmL6SoeVEOteQV8XI+EQjVwRiLCpK3HeVbtcXFc9YXsQll6qR
 nCyKcKWmh20ysNjm/SzxDUlYUHxLYszMxbc2aFz4=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 24F28C137393
 for <bpf@ietfa.amsl.com>; Tue, 27 Jun 2023 14:39:21 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.845
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ABQx9mIfFFr for <bpf@ietfa.amsl.com>;
 Tue, 27 Jun 2023 14:39:17 -0700 (PDT)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4B900C13AE52
 for <bpf@ietf.org>; Tue, 27 Jun 2023 14:39:17 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-55b0e7efb1cso651036a12.1
 for <bpf@ietf.org>; Tue, 27 Jun 2023 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20221208; t=1687901956; x=1690493956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zZ9y6QRdu6OKqSRcId44hSNEZdSQokxImaizAMqnnzI=;
 b=ciUhEUEh/fgucB23VxRKLV1NC22GCX6+ff4NC2K1rkG9+pevOiXlEnSmnchNBAJNNM
 YNgttOuAMH8povK7lkCpU8Wr0+YqBui4rnkAvaEtwJb5AmbQUG7Kb+iX/KMg4RH1o7zs
 lD6M1IpvHfLTcbDPSXSKt5X8suHpljLzPOB0mtSiD1OzVBl5tmXQFkKXYtWx1ypiLDQj
 PIXYRwKJxesV1CgpEUKBpSSQGSbt5mb+zKIO1VUl0C2ARH+M/0pYvyyQi0SeKWZgjDZE
 wBHa2nYh114uI7gvhpLeH/3zI9o3TEJ3u30qbVJ+p/A71a3ZpF9ZvtKROjIK3xeLBNMB
 CK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687901956; x=1690493956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zZ9y6QRdu6OKqSRcId44hSNEZdSQokxImaizAMqnnzI=;
 b=Rhs8zR9o7S+ACw9YoUglmqMAWr64Qrwplxf7AC6mNC+65e5VqowQpVDmvDwvTcoVb9
 ARCZxDI3awCKcP2SFUcEQzMHhi21dLyAAwufUdh6NtR+3+1OMMfW6Bq/69iuMq2BnFZB
 ol1COWVRWO21NnIOW2O2rjohJ9bAD7KVAqIIho/VpfTIQRJqfwA7MIymSbGxLaGNQrWY
 hHRcD6tsk/3MVQf9nUTjh1okuVpwZJBGgxMX3BNgodEY+CzcarJ8i15DqOfUXzY0a23p
 MLE6mFumTDZ1CGeGacWo2kZyBBjehzCak4cqeL//XuOLaJAQYUuwagrj+vANsPlt2qR2
 zwBw==
X-Gm-Message-State: AC+VfDzGLpWeqMZtOUwY3Q/HMQO5JhK6dhIiWocvebsFRGfhgjzf0p4x
 fURuFucIB0Q057oCLtLJqwVc1d6RAuQ=
X-Google-Smtp-Source: ACHHUZ7PHwh1JD5aoBDpi0RLH0WnbNgHMPjyzfz+jYm5rMBJ+5rYpskko1BcZmOiT4jhlGt9JRHHEg==
X-Received: by 2002:a17:90a:a789:b0:263:b62:4472 with SMTP id
 f9-20020a17090aa78900b002630b624472mr3253770pjq.48.1687901956607; 
 Tue, 27 Jun 2023 14:39:16 -0700 (PDT)
Received: from mariner-vm.. (c-71-197-160-159.hsd1.wa.comcast.net.
 [71.197.160.159]) by smtp.gmail.com with ESMTPSA id
 sj18-20020a17090b2d9200b00262ec29ef90sm4631122pjb.21.2023.06.27.14.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 14:39:16 -0700 (PDT)
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler@microsoft.com>
Date: Tue, 27 Jun 2023 21:39:12 +0000
Message-Id: <20230627213912.951-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/hWe0ixMYzYio43X_0_Ld2Kihv_k>
Subject: [Bpf] [PATCH bpf-next] Fix definition of BPF_NEG operation
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Dave Thaler <dthaler1968@googlemail.com>
From: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dave Thaler <dthaler@microsoft.com>

Instruction is an arithmetic negative, not a bitwise inverse.

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/instruction-set.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 6644842cd3e..751e657973f 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -165,7 +165,7 @@ BPF_OR    0x40   dst \|= src
 BPF_AND   0x50   dst &= src
 BPF_LSH   0x60   dst <<= (src & mask)
 BPF_RSH   0x70   dst >>= (src & mask)
-BPF_NEG   0x80   dst = ~src
+BPF_NEG   0x80   dst = -src
 BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
 BPF_XOR   0xa0   dst ^= src
 BPF_MOV   0xb0   dst = src
-- 
2.33.4

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

