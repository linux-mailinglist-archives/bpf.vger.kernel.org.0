Return-Path: <bpf+bounces-4902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2788475165A
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5700E1C20D6E
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD211ED9;
	Thu, 13 Jul 2023 02:33:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AEF7C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:33:06 +0000 (UTC)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDD19E
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:33:05 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 5614622812f47-3a3373211a1so219039b6e.0
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689215584; x=1691807584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzLE27wZ9RTtwtcsT3D79Brq91d5MH8HhRDwTtSvoc0=;
        b=E8uknnmae1YKJm+YTS3bNv6jeSnwf8iSTdN9J+eHWMg/D2SAj5dc+T6TjdiT0WV4Hf
         fRXkxzi7YLdJzZO9qwuC2GxlelTAv+y7Rno1FrelD2So4D8wvXKBphUXPe3ro0qtAIpy
         OL6HCoPAJjD4i4g3BHuz+DY3Pl8zVKiCfv/Fh4D2wiTqeWO0a3D8ArO0O137gCiij0dO
         mtcE9YyLTFKdNr3aGbQ5JlHfst6GfKIqWYeQByqCoQgmYLlqIlLYrdAtZIwenHBrEsof
         za/bOHwO7O6Jq3jzdu24jrcXgt1tNlWOgBk4EyLb0o3Nta5JIpuuADR5yNPER2gSUsFQ
         wOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689215584; x=1691807584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzLE27wZ9RTtwtcsT3D79Brq91d5MH8HhRDwTtSvoc0=;
        b=K7Xd0Bx21jRxLhDmf3oIqqNVhUJ4JFIIAiux59Ibbg6NBFvQXBx9bbmetZGDtQcQsQ
         ZWw2cCjX0GhaT6FlYuLJUPgZm54OpBd7qEizbczXRhALcrbbbUyik308EvHtnSPGlE0Z
         CVIz/zj1hHxBo1arp61yFJWBiXW3bI6hH9R7I8jvZIuPWZ/fMJfzT+HQlPcQSi2pnfoh
         ZJaTIYPP4VOrYacyUlotPWrSw2Oy8EAd8uIR36E2BS3uYRVlVjcr3NEJ/zNdj3v5TVFr
         rlgJF84n8Jtpat5y8XfA37MQEYbI4XA3NeJgscB9+px1KgP84rWiys2qa+NS9MNx3nM8
         Y5wg==
X-Gm-Message-State: ABy/qLY8wwSv/79cLTGeQ3/6mA6ax8sLfJ8BJp9L0T9iBcuI+etRuQ0/
	yaNcLdtYfdtNEau52x1Rbj/WC2CCH3G07A==
X-Google-Smtp-Source: APBJJlELrwXzgsQOwuRBTEiWea7q4v9FlBV5gK7mSRlR4cwdvQQp6oMME+L/T3I2kmWMIyw/DY57Sg==
X-Received: by 2002:a05:6808:d52:b0:3a4:f8e:d798 with SMTP id w18-20020a0568080d5200b003a40f8ed798mr339670oik.36.1689215584150;
        Wed, 12 Jul 2023 19:33:04 -0700 (PDT)
Received: from localhost ([49.36.211.37])
        by smtp.gmail.com with ESMTPSA id fe11-20020a056a002f0b00b006827d9dd64esm4275696pfb.8.2023.07.12.19.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:33:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v1 07/10] bpf: Ensure IP is within prog->jited_length for bpf_throw calls
Date: Thu, 13 Jul 2023 08:02:29 +0530
Message-Id: <20230713023232.1411523-8-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713023232.1411523-1-memxor@gmail.com>
References: <20230713023232.1411523-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; i=memxor@gmail.com; h=from:subject; bh=9pzt7wZ/J35F3BWasIxB0BTPih6S4YIqMjJB+Ic5+Pg=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBkr2HIfCJ0f/8ZjN0METxLvDGsqndp5w6zcWya+ WQIoHemMuGJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZK9hyAAKCRBM4MiGSL8R yrsbD/4sI45rI8DWHZ1onVzBSezq5UdBc4mXGfw52vKxxEdY1MMk/Jw8a8BxXogkoYEnQHgykig DtspP/zOl+EbtpaM14Qtka8R9DwuJ7amRfDS1oGwZQ98Lkd+H9qK623A9saXADCB6JEj3d/WwDs QHWmEMGfCw0ZrQmaLFkMZBUX1sNngH8oh7KFV8T6qYaIwa+7fwjn3x+lDd2dAvxRDMTAB2t7D21 mv58oG7kDCjHLn/NiVHCywRQDe1TEx9Yzt0NB4hYKszLmWFNpFCkylM382UBTt6mhbAZeUM4BRa 8xOgwnm7Ow0iF+O7bPaCIn9mYM/ZD6vZBH8/UMRmLwTN5LpZZ2/YlYrvlfq33+GjQ2sYlUV0/5y ugHpBYIFXoeyA8K0ah+jbRTSSTAzmMtbagYjdVzGQg4WfjjpjdOpFe64iT6UzS26mNpfpLmVKGN TfZttlF2lCr69kPtbq7bbDYAAA9riHEFjhEnybCj+mUZ5ma7OnT+7LkIanf79KvMmV+jz+kn4bA ab4yAId8g0N7qAYI5kkXeyPlqDmqNSyWJjlD0CNdAuc7DJImnGYU27PbFfXfOe/oSMSV+xm8Vqt KHDoBhTgiI/7hfs5b/ZW5B4r7R3+9/HbF9CWNlWinCPsJlLJKUw3ajLdoF7bhagcrtsOzfDS+JW 15aT4f5UEi0Terg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Now that we allow exception throwing using bpf_throw kfunc, it can
appear as the final instruction in a prog. When this happens, and we
begin to unwind the stack using arch_bpf_stack_walk, the instruction
pointer (IP) may appear to lie outside the JITed instructions. This
happens because the return address is the instruction following the
call, but the bpf_throw never returns to the program, so the JIT
considers instruction ending at the bpf_throw call as the final JITed
instruction and end of the jited_length for the program.

This becomes a problem when we search the IP using is_bpf_text_address
and bpf_prog_ksym_find, both of which use bpf_ksym_find under the hood,
and it rightfully considers addr == ksym.end to be outside the program's
boundaries.

Insert a dummy 'int3' instruction which will never be hit to bump the
jited_length and allow us to handle programs with their final
isntruction being a call to bpf_throw.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 11 +++++++++++
 include/linux/bpf.h         |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 8d97c6a60f9a..052230cc7f50 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1579,6 +1579,17 @@ st:			if (is_imm8(insn->off))
 			}
 			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
 				return -EINVAL;
+			/* Similar to BPF_EXIT_INSN, call for bpf_throw may be
+			 * the final instruction in the program. Insert an int3
+			 * following the call instruction so that we can still
+			 * detect pc to be part of the bpf_prog in
+			 * bpf_ksym_find, otherwise when this is the last
+			 * instruction (as allowed by verifier, similar to exit
+			 * and jump instructions), pc will be == ksym.end,
+			 * leading to bpf_throw failing to unwind the stack.
+			 */
+			if (func == (u8 *)&bpf_throw)
+				EMIT1(0xCC); /* int3 */
 			break;
 		}
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 61cdb291311f..1652d184ee7f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3111,4 +3111,6 @@ static inline gfp_t bpf_memcg_flags(gfp_t flags)
 	return flags;
 }
 
+extern void bpf_throw(u64);
+
 #endif /* _LINUX_BPF_H */
-- 
2.40.1


