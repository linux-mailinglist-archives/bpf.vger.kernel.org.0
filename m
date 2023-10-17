Return-Path: <bpf+bounces-12482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A7D7CCE14
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 22:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A297F281A6F
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 20:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80162D797;
	Tue, 17 Oct 2023 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TlFpcos9"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B42E3FA
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 20:30:27 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD5792
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 13:30:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27d153c7f00so4084884a91.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1697574626; x=1698179426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ehV8iSxnyOyDyf4C9sEgcF0r6K+laBQfqTpRwsFcRM=;
        b=TlFpcos9nMpRHSeZkIi063u+T2tYu3SHKJhM/JZB9fZeozBrQWc0V6WU7wsyesdaiC
         5zjrAGyXbXKKH/aL+zg4IC1MX24R6TUXctYwoEVybErKpZVknW1LTSCXXR6Wy+6xA8V+
         o+tG6s7fh7UJUvEJfJ/Mw5Or9lkljlYyPRRkSFI6S7jaVL6jfxKsIqxD3ADLMs1BcIxc
         LjM8HSVfjHAFy9bmmm9shdiKX9nDX53h2gTTrpc+av3c1oEB140UGQUarGrK8d5KSN0O
         pP2dxhuPujVyimbWInDi6ipgEj+E5dLXYMGO0Ow7VUaDPAWRYUFqsP9co+TAQER6FVUi
         zMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697574626; x=1698179426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ehV8iSxnyOyDyf4C9sEgcF0r6K+laBQfqTpRwsFcRM=;
        b=wxL8viBmE8TYwEcfb1HJATgGcJqBg62ZershRXEq0zk7CVxC+FhiBmFrUT1utw0Npk
         fPH6k2VixMFELMW7OG9LRpsKMlEZpvUXd7eZ2Ubfsvt8X7PW5pIi+ZzymHl1gA5IoolP
         RQj4/KRBq6+LnTvOxGv3Lt8iZT9nuf/SdTVNNhokMVU7DpXu2VIQQ/4WCbsujOZxJhTI
         /HVJWUNIW5lwmrvKzZLr7YW3vE+ttsdQ52KP2Fjatz4AWCd2uth7+Re3177PdCMG06d3
         qnAHYd3x9HlN0eIk48Q5yUnu+CTfWaSGATvnt/P+0eLyduoXPgGC6jAy84nrBtwttBQH
         sL6Q==
X-Gm-Message-State: AOJu0Yz1aUW+fY6KuzEJJocMaK+TJ57rzb7ZO+CsRZQ6KAEIgktSSo8f
	mG46UxOeIoxjjVQxwI7uOCsgFJVVTeP5HA==
X-Google-Smtp-Source: AGHT+IGf/fg4e1bxpRgEyW5b8Xnh8EkRAbGDpjqfn79l6U8cm4qjbhI7m49xH29W9Hlil3B4Jm+YvQ==
X-Received: by 2002:a17:90a:53a1:b0:27d:19ef:fa2c with SMTP id y30-20020a17090a53a100b0027d19effa2cmr3089584pjh.14.1697574625613;
        Tue, 17 Oct 2023 13:30:25 -0700 (PDT)
Received: from mariner-vm.. (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id pj1-20020a17090b4f4100b0027d0c3507fcsm6719993pjb.9.2023.10.17.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:30:25 -0700 (PDT)
From: Dave Thaler <dthaler1968@googlemail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler@microsoft.com>
Subject: [PATCH bpf-next] bpf, docs: Define signed modulo as using truncated division
Date: Tue, 17 Oct 2023 20:30:20 +0000
Message-Id: <20231017203020.1500-1-dthaler1968@googlemail.com>
X-Mailer: git-send-email 2.33.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dave Thaler <dthaler@microsoft.com>

There's different mathematical definitions (truncated, floored,
rounded, etc.) and different languages have chosen different
definitions [0][1].  E.g., languages/libraries that follow Knuth
use a different mathematical definition than C uses.  This
patch specifies which definition BPF uses, as verified by
Eduard [2] and others.

[0]: https://en.wikipedia.org/wiki/Modulo#Variants_of_the_definition
[1]: https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/
[2]: https://lore.kernel.org/bpf/57e6fefadaf3b2995bb259fa8e711c7220ce5290.camel@gmail.com/

Signed-off-by: Dave Thaler <dthaler@microsoft.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index c5d53a6e8c7..245b6defc29 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -283,6 +283,14 @@ For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
 is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
 interpreted as a 64-bit signed value.
 
+Note that there are varying definitions of the signed modulo operation
+when the dividend or divisor are negative, where implementations often
+vary by language such that Python, Ruby, etc.  differ from C, Go, Java,
+etc. This specification requires that signed modulo use truncated division
+(where -13 % 3 == -1) as implemented in C, Go, etc.:
+
+   a % n = a - n * trunc(a / n)
+
 The ``BPF_MOVSX`` instruction does a move operation with sign extension.
 ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
 bit operands, and zeroes the remaining upper 32 bits.
-- 
2.33.4


