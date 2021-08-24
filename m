Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DC83F55E1
	for <lists+bpf@lfdr.de>; Tue, 24 Aug 2021 04:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhHXCow (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Aug 2021 22:44:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35157 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233399AbhHXCov (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Aug 2021 22:44:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 117935C00D0;
        Mon, 23 Aug 2021 22:44:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 23 Aug 2021 22:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=AQ2rNm1uYOGK5
        B5FWkwdOh/s0DIjZmm3WuknLB0LDdM=; b=NTDot3dR5bcNp/iLf7EuJuNoJ08g0
        KLbSppWGy6uI+sm9Tmf2cPy3uaWEvmIQWEWQMbhCPMpC0K9zoXvDKf82Fc/5oA15
        pR123uIvMmNwSJQ2ihuPuYRLVcIKQvilXHB2s7wI54ORyNc+ZT23OLJVaqB70Icf
        a6VusFfvl1lEqlEHO/FGeA3dKNJQQCzMhifsZS7QHtA7lQzxGyPwqUSfjQq3ycWX
        J1M/713komNdEsv3IMhiZVDwLjqsQTrcS09gHMh2FTqUm9TkJMlas3TLe8M2Z4B+
        t0SFlMVJ+XN+zhIs9OzYZrOuhxoNPDkdz2HZnl4gQtmyYvFFG5AvS9MSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=AQ2rNm1uYOGK5B5FWkwdOh/s0DIjZmm3WuknLB0LDdM=; b=hWBza8xX
        j70QXAEoTMDlaqdbRTZtEzCGp04cqTHCrVNUjmTNBIvhZaK9CI/1eSch8cup7k0a
        LccJOOEyI1LZQ5kM9Q+zfhJ1czn8T8tC/jhEh4M9LYMeTBy717yh68hC3mf8CleV
        MJXSjyv99iMhihHpZZJMouxUzAEhIvCvtrJmgAdI/yIYLDYsM7isWPSSMicY53re
        bGo9HVJWu1WnRBzGNcILTNQnU8tcX8BFK1ImElhNjOEO2bNSRs4EKM3ceqe+erof
        CzdISCQUtylhhUDT3DckOahNIFEHU879KMK16Z6DI35enXqBwNjqCzXKMR3ZLOYF
        rattkfepUU4zjA==
X-ME-Sender: <xms:9lwkYWTcsVS5VwhDquA-BqoUee6Z3UuMByoQwssTwyTTi9BbCMDmYg>
    <xme:9lwkYbzK4gcA5zmnXba8K74RRZSmvcznh6HA1HF0Pov4Ed5XkEkFNqre4z8Qa5V6J
    FUCEezlq6qtAUeI2g>
X-ME-Received: <xmr:9lwkYT2SZQKQ2edw0on0DbRf__faAcxD9otHeVM4kLXSUFCihPfOh5zdvN1N3aYAXKqcWCKBesFDhaSEIO0Wv0ndP-GdC9NvJ9rM7cfiUYnyHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtiedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgkeduleekhfetvefhge
    fgvdegfeejfefguedvuddthffggffhhedtueeuteefieenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:9lwkYSB-wUHcJhxmkqbepkz7cEqsLF1B9f946MddjDfxsBN-EPPxHg>
    <xmx:9lwkYfg3dxh3QIe264JZldaX1liIb_N5cTVrvBkSz7F5E83BYjFkLw>
    <xmx:9lwkYepAkrBNn6LIUElFwReKkXCgc8aTyuVFor7ScWhzp0u7w1Z1Ig>
    <xmx:91wkYff8nCkP8cDH7kyHyzMSG29SaECn-BOFe8Ocql7XfYEf9UfwVQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 22:44:06 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/5] bpf: Add BTF_ID_LIST_GLOBAL_SINGLE macro
Date:   Mon, 23 Aug 2021 19:43:46 -0700
Message-Id: <a867a97517df42fd3953eeb5454402b57e74538f.1629772842.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1629772842.git.dxu@dxuuu.xyz>
References: <cover.1629772842.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Same as BTF_ID_LIST_SINGLE macro except defines a global ID.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/btf_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index bed4b9964581..6d1395030616 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -82,6 +82,9 @@ __BTF_ID_LIST(name, globl)
 #define BTF_ID_LIST_SINGLE(name, prefix, typename)	\
 	BTF_ID_LIST(name) \
 	BTF_ID(prefix, typename)
+#define BTF_ID_LIST_GLOBAL_SINGLE(name, prefix, typename) \
+	BTF_ID_LIST_GLOBAL(name) \
+	BTF_ID(prefix, typename)
 
 /*
  * The BTF_ID_UNUSED macro defines 4 zero bytes.
-- 
2.33.0

