Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6740559ECD9
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 21:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiHWTuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 15:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiHWTtk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 15:49:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F6AB
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 11:53:08 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ce26so13520312ejb.11
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 11:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2dOEuGGOPXsAXXBcbu/VW/hh2kSOMBgir3kb7gZmhSo=;
        b=S2UTpYOBicGjJDOpRNzBZtNnpjD/nkQK8z5Uzmdj7f4J2tUZW7ULPxcUyEFU0AwN98
         isxxGN4QyvqlIWgS1ukNN/u1GfHyTvb6ezBGU1sVqR7B5H4RUcAZ28vQL9yB6HE4AUQc
         LdLPQH6LlA2fsH5zA8vm05T0l+MZqnYcGj4rOxdldp04rzHFo1yLz9jJGPcJHu3ON6xm
         HEBG+/e6YIXF1/Hv/E9RKrZeM3WiBCC2g/c+At5TJKOBBlebNDvbSJr/fs0s/cy6Jcs1
         UI1vBimJz/kkavXp0CbvWqjfJAV/5/cvdsaeiKAVY32a5SBmJhHVB2tPgl1iybSbFNQH
         p0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2dOEuGGOPXsAXXBcbu/VW/hh2kSOMBgir3kb7gZmhSo=;
        b=NOB/30Y5qfYnutLnU9oMBep37CJi8Htr0gFAaKbdgptB1YctKUb0dVF0xVlBUM/atU
         jq0Wop0g1hAMiSqKtUOIzGFwC1sMuOM7ptfr4m2rFgbtStK9bZxKLJ8ojCjaDfM9K2ne
         +EPr+hkdLdHCcQROeTRQbhJQ7RPuRODJCKin5EI+VOeWFj2UP4XyPYI0AOyoofOk2i1i
         vi+eYj+iB5q8ErP0jK/y+XrfX5HcQB1oZTkh3jwoaxAVULzdO/0Dr6w8qqB3YHuoRxm7
         180rn441tsAKk811o0CcJRvQuoY/kGvBKS/PgrkkHOlaDweWBtoS41x+sYxo4qRMRBDq
         97wA==
X-Gm-Message-State: ACgBeo3S9pGq2glPX13YcPFtoAu/fRyxY1suSTB67h6d/XVgJ6X5uZvr
        L4eeld9/j56NHg8HettsJXIPV/NQj2w=
X-Google-Smtp-Source: AA6agR44vj+/9L5YGPkL/vfRBLFtlGUBmTdleQT82rpDPR8Cf5i3lPNJgHIqfUlq9AgUq2vdICj97A==
X-Received: by 2002:a17:906:93ef:b0:73d:9ef5:e577 with SMTP id yl15-20020a17090693ef00b0073d9ef5e577mr614389ejb.127.1661280786762;
        Tue, 23 Aug 2022 11:53:06 -0700 (PDT)
Received: from localhost (vpn-254-130.epfl.ch. [128.179.254.130])
        by smtp.gmail.com with ESMTPSA id z17-20020a50cd11000000b0043be16f5f4csm1872429edi.52.2022.08.23.11.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 11:53:06 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 1/2] bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO
Date:   Tue, 23 Aug 2022 20:52:59 +0200
Message-Id: <20220823185300.406-2-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220823185300.406-1-memxor@gmail.com>
References: <20220823185300.406-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3478; i=memxor@gmail.com; h=from:subject; bh=Zic2rPrJHya0bfuj+Gvdco0EPQJKiWid70r/RKeo2tc=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBjBSIEQtmLdWTmp26P2AJZC4+G4LuZb/FgCdK9dwu3 iZcb6ZeJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYwUiBAAKCRBM4MiGSL8RyrDzD/ 47NB8P1R2FrF6ERp3qQp5G8TBeYOwcS/43PV6bKcpBhU8/VZ9ZGiU/3grEmI7vLsaoYkrOi+xkKKOe TxKv3+KUH9bTnQT7yR3vmqrEmDrPVSiA5aCsaf6VJU3n7McFJVcL7HSCAVEto4i2YjabhgbhBJUgSX QmLhaZD9zzqRMhGEB7G0UJO/X8FcXMvBEHagliJh0JUd/SoyrP6CQbZzuRMk+K3vqIYrjAaOCLEKoz SUXoYwJRFMe0qlstuVBqo5Ff2fROdS++vbOhMQz0WazkAr+7D2j+R3faA1qjwcQIzTvm5o0maOpkRI QseIccKT14hSo8eMDLokyqEEyWipBO/iSo+KAhcUeembLYcOUnqrJRXw79T2WWWNEWjH6EW9ebu0jK kJflLnDADJSPbkItnNuFM8mN3fdsDDqI0XVxDYYZzj/6o9YH8ADzyfTwTbz026vSTc4qpBbFw8nCwX T87yewvAmFO+vo7DYHQ5/XT1Il8FgQBgCj8+KMGiPSyLstf9vAW+UhGatePGllNihrlXZUaBkkW2FT xM8jtrVqXid7r3xdc7N3HUeeNDWXGKOgTT3G6hcafUNM6UGOqaPT7X0jvXo+huV+IPoU9HZlXcU4Aj i9wmjwB0xkuBoRu2jLj0su4S1diQ7iXtu6zhYnj2bVPvNKsoyHMwc4Ag31aA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Precision markers need to be propagated whenever we have an ARG_CONST_*
style argument, as the verifier cannot consider imprecise scalars to be
equivalent for the purposes of states_equal check when such arguments
refine the return value (in this case, set mem_size for PTR_TO_MEM). The
resultant mem_size for the R0 is derived from the constant value, and if
the verifier incorrectly prunes states considering them equivalent where
such arguments exist (by seeing that both registers have reg->precise as
false in regsafe), we can end up with invalid programs passing the
verifier which can do access beyond what should have been the correct
mem_size in that explored state.

To show a concrete example of the problem:

0000000000000000 <prog>:
       0:       r2 = *(u32 *)(r1 + 80)
       1:       r1 = *(u32 *)(r1 + 76)
       2:       r3 = r1
       3:       r3 += 4
       4:       if r3 > r2 goto +18 <LBB5_5>
       5:       w2 = 0
       6:       *(u32 *)(r1 + 0) = r2
       7:       r1 = *(u32 *)(r1 + 0)
       8:       r2 = 1
       9:       if w1 == 0 goto +1 <LBB5_3>
      10:       r2 = -1

0000000000000058 <LBB5_3>:
      11:       r1 = 0 ll
      13:       r3 = 0
      14:       call bpf_ringbuf_reserve
      15:       if r0 == 0 goto +7 <LBB5_5>
      16:       r1 = r0
      17:       r1 += 16777215
      18:       w2 = 0
      19:       *(u8 *)(r1 + 0) = r2
      20:       r1 = r0
      21:       r2 = 0
      22:       call bpf_ringbuf_submit

00000000000000b8 <LBB5_5>:
      23:       w0 = 0
      24:       exit

For the first case, the single line execution's exploration will prune
the search at insn 14 for the branch insn 9's second leg as it will be
verified first using r2 = -1 (UINT_MAX), while as w1 at insn 9 will
always be 0 so at runtime we don't get error for being greater than
UINT_MAX/4 from bpf_ringbuf_reserve. The verifier during regsafe just
sees reg->precise as false for both r2 registers in both states, hence
considers them equal for purposes of states_equal.

If we propagated precise markers using the backtracking support, we
would use the precise marking to then ensure that old r2 (UINT_MAX) was
within the new r2 (1) and this would never be true, so the verification
would rightfully fail.

The end result is that the out of bounds access at instruction 19 would
be permitted without this fix.

Note that reg->precise is always set to true when user does not have
CAP_BPF (or when subprog count is greater than 1 (i.e. use of any static
or global functions)), hence this is only a problem when precision marks
need to be explicitly propagated (i.e. privileged users with CAP_BPF).

A simplified test case has been included in the next patch to prevent
future regressions.

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 096fdac70165..30c6eebce146 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6066,6 +6066,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->mem_size = reg->var_off.value;
+		err = mark_chain_precision(env, regno);
+		if (err)
+			return err;
 		break;
 	case ARG_PTR_TO_INT:
 	case ARG_PTR_TO_LONG:
-- 
2.34.1

