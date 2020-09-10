Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F241264512
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 13:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgIJLFo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 07:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbgIJLDf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 07:03:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E62C0613ED
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 04:03:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so6191044wrn.10
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 04:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfqt6awegfu4eCKMTPUVt2xWS4iWxmPjrAG4fsrRWl8=;
        b=UMwB+xyu2FbRNy+laHBG9WCGsbQgQzlOyXDoGnjuxl1vgL3M3dFU9x976IEjWfhFcB
         0bRQmLGAVQtVx1ivjujqslpBmip3UapRlhddQ2OjHqN7nlHzrdr+Elm7PZxqC1dMg71z
         lIP+6TnolGm9UCabGiEspsDathf8IlPDbG7J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jfqt6awegfu4eCKMTPUVt2xWS4iWxmPjrAG4fsrRWl8=;
        b=rxQZwBVya6n4KRNz0NsEN2aY7H01V8vT1SdjWUf89MhOtUvIIEFz8oWTOMuHvJVRW1
         9EgfDwfLLopgoOX6OShxaxVLVrJOPMZ1pios+u8AGaHlnorR+yYy8Xnle6nVeFYmnT7l
         fsrkwgnRj7hQvWQbLkDaK01eMr3P1kkXawX4FIBjR5/2xywsufs+RnjwWD9TBWsyC60j
         UJVIOXSFGglsuZTc0ilfm6I3YH6TeKs3xhimXl4sThwlYmJqPgpkmHQPOj1WSRGkjkTB
         TJ/kQ9i0T/Y6Q71qfJBkn3AaF4DUuBPeSc9ORlm+8RrON5lpdUGLNbI90NDT331850dq
         kj1g==
X-Gm-Message-State: AOAM533qlq11gFb0rRWHkw2fRxX+a1bJi+310Z0mXdJddl+NncSHU7S+
        T4UyiM8iddEZWArX+hSD5177VQ==
X-Google-Smtp-Source: ABdhPJyQbVb2gXaLF9khRxz4hVgGGlPxaQ2CfD0oi3kWlmKrCbcP3FqB0BJVTnR0KbIbXjUoBXTasw==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr8158198wrn.209.1599735814060;
        Thu, 10 Sep 2020 04:03:34 -0700 (PDT)
Received: from antares.lan (6.9.9.0.0.d.a.3.9.b.d.2.8.1.d.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:7d18:2db9:3ad0:996])
        by smtp.gmail.com with ESMTPSA id a85sm3238871wmd.26.2020.09.10.04.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 04:03:33 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, jakub@cloudflare.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf] bpf: plug hole in struct bpf_sk_lookup_kern
Date:   Thu, 10 Sep 2020 12:02:48 +0100
Message-Id: <20200910110248.198326-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As Alexei points out, struct bpf_sk_lookup_kern has two 4-byte holes.
This leads to suboptimal instructions being generated (IPv4, x86):

    1372                    struct bpf_sk_lookup_kern ctx = {
       0xffffffff81b87f30 <+624>:   xor    %eax,%eax
       0xffffffff81b87f32 <+626>:   mov    $0x6,%ecx
       0xffffffff81b87f37 <+631>:   lea    0x90(%rsp),%rdi
       0xffffffff81b87f3f <+639>:   movl   $0x110002,0x88(%rsp)
       0xffffffff81b87f4a <+650>:   rep stos %rax,%es:(%rdi)
       0xffffffff81b87f4d <+653>:   mov    0x8(%rsp),%eax
       0xffffffff81b87f51 <+657>:   mov    %r13d,0x90(%rsp)
       0xffffffff81b87f59 <+665>:   incl   %gs:0x7e4970a0(%rip)
       0xffffffff81b87f60 <+672>:   mov    %eax,0x8c(%rsp)
       0xffffffff81b87f67 <+679>:   movzwl 0x10(%rsp),%eax
       0xffffffff81b87f6c <+684>:   mov    %ax,0xa8(%rsp)
       0xffffffff81b87f74 <+692>:   movzwl 0x38(%rsp),%eax
       0xffffffff81b87f79 <+697>:   mov    %ax,0xaa(%rsp)

Fix this by moving around sport and dport. pahole confirms there
are no more holes:

    struct bpf_sk_lookup_kern {
        u16                        family;       /*     0     2 */
        u16                        protocol;     /*     2     2 */
        __be16                     sport;        /*     4     2 */
        u16                        dport;        /*     6     2 */
        struct {
                __be32             saddr;        /*     8     4 */
                __be32             daddr;        /*    12     4 */
        } v4;                                    /*     8     8 */
        struct {
                const struct in6_addr  * saddr;  /*    16     8 */
                const struct in6_addr  * daddr;  /*    24     8 */
        } v6;                                    /*    16    16 */
        struct sock *              selected_sk;  /*    32     8 */
        bool                       no_reuseport; /*    40     1 */

        /* size: 48, cachelines: 1, members: 8 */
        /* padding: 7 */
        /* last cacheline: 48 bytes */
    };

The assembly also doesn't contain the pesky rep stos anymore:

    1372                    struct bpf_sk_lookup_kern ctx = {
       0xffffffff81b87f60 <+624>:   movzwl 0x10(%rsp),%eax
       0xffffffff81b87f65 <+629>:   movq   $0x0,0xa8(%rsp)
       0xffffffff81b87f71 <+641>:   movq   $0x0,0xb0(%rsp)
       0xffffffff81b87f7d <+653>:   mov    %ax,0x9c(%rsp)
       0xffffffff81b87f85 <+661>:   movzwl 0x38(%rsp),%eax
       0xffffffff81b87f8a <+666>:   movq   $0x0,0xb8(%rsp)
       0xffffffff81b87f96 <+678>:   mov    %ax,0x9e(%rsp)
       0xffffffff81b87f9e <+686>:   mov    0x8(%rsp),%eax
       0xffffffff81b87fa2 <+690>:   movq   $0x0,0xc0(%rsp)
       0xffffffff81b87fae <+702>:   movl   $0x110002,0x98(%rsp)
       0xffffffff81b87fb9 <+713>:   mov    %eax,0xa0(%rsp)
       0xffffffff81b87fc0 <+720>:   mov    %r13d,0xa4(%rsp)

1: https://lore.kernel.org/bpf/CAADnVQKE6y9h2fwX6OS837v-Uf+aBXnT_JXiN_bbo2gitZQ3tA@mail.gmail.com/

Fixes: e9ddbb7707ff ("bpf: Introduce SK_LOOKUP program type with a dedicated attach point")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/filter.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 995625950cc1..e962dd8117d8 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1287,6 +1287,8 @@ int copy_bpf_fprog_from_user(struct sock_fprog *dst, sockptr_t src, int len);
 struct bpf_sk_lookup_kern {
 	u16		family;
 	u16		protocol;
+	__be16		sport;
+	u16		dport;
 	struct {
 		__be32 saddr;
 		__be32 daddr;
@@ -1295,8 +1297,6 @@ struct bpf_sk_lookup_kern {
 		const struct in6_addr *saddr;
 		const struct in6_addr *daddr;
 	} v6;
-	__be16		sport;
-	u16		dport;
 	struct sock	*selected_sk;
 	bool		no_reuseport;
 };
-- 
2.25.1

