Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EED618855
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 20:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiKCTLq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 15:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKCTLo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 15:11:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5D71DA46
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 12:11:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 130so2508160pfu.8
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6scBjni5t8FaahTk/dclz3eKhkfX8m6V+lHzzTiQN0=;
        b=Uw3OMUOY+WHZdTODuInBjrh+lqnUAieUoqEIp94wTNlwK9xWDYJnZDfcDJdJ30YDN4
         K9yZR+562/m1rXz0YiKrA4BNUKAvu0vPYYoVOjtwX+K+Gf3Ry5/R7DU9bTtkqOPME6Vx
         CnQTPpzim/wcZwAyB2G5071Hy29T1+mfX4QcLEZP0ALu5NZlMkB77krhcluYn99EIZN0
         wNx+5+TAIVhOpiXrY6177+TEEkpDpl66f/OTtI8YZ9EdcwClj0iAgtlBnmuAjj47oOaf
         XZZviIry1ha6QxfdUVDzP9g2Jhbd2mQZGjnY6m1EqjK7sWI9Cbv2oSGJhi/S0jUzSK1i
         ZzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6scBjni5t8FaahTk/dclz3eKhkfX8m6V+lHzzTiQN0=;
        b=GOKANIUbWI+yODaaUlyZfb4Ga9sV8HHZDaVBDOz/BYum6ZAEKDXNR84iYNfGn5uCR2
         986kaCknuLV952Ie9wVXfAC8UP6xZiEBMCm2SIvLuiPEqfAPaJfl7LFWsY4segXrlQs9
         r06k2P60Gkw+zJ2hS1olhGqMiHiHzMBisSQl6pJt6S19FVdb+jrbIp3hNbL5vzlIcvCB
         ka9b2LFSEwBzNgMqnlMPn9KdnK3auFQw8f3ZRwKjsHaKRcYiWpsnAPKoW7XsgPWBc9Wz
         3pjiFfJdQ3rKlzXdzAJUuTVwZswxlciVjQcDKs8TXGX5HyY9EzsjYAlOqlL+4yR7GjBd
         kLIw==
X-Gm-Message-State: ACrzQf1JpCkTlwEzPkA8eUmk1dJ5AkpHlkls3oKGhRzyrzhfDOI6zcIe
        vyZhMxYlq71fe64+EQXuOY2j6UcmC1K+TA==
X-Google-Smtp-Source: AMsMyM43ndhTzKHT8fbH52sP0u5CF/aF9HG7lIMH+NJEmpUpfd8KtvEW7fTognPFzXV330+38lMovw==
X-Received: by 2002:a65:644a:0:b0:470:f04:5b67 with SMTP id s10-20020a65644a000000b004700f045b67mr7258842pgv.586.1667502703382;
        Thu, 03 Nov 2022 12:11:43 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id d135-20020a621d8d000000b0056262811c5fsm1117336pfd.59.2022.11.03.12.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:11:43 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v4 21/24] bpf: Permit NULL checking pointer with non-zero fixed offset
Date:   Fri,  4 Nov 2022 00:40:10 +0530
Message-Id: <20221103191013.1236066-22-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103191013.1236066-1-memxor@gmail.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2157; i=memxor@gmail.com; h=from:subject; bh=tCYNsHRaCiUjbIk01Wr8z5hVuWD4hUnicmoHUm8A+ZE=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjZBIB/ZswiHSAe9PUv/IqZI36ziLYK6AVzt8k0/tW fUtAMHGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2QSAQAKCRBM4MiGSL8Ryjq9EA CD/48tgrTaP7Epd+TYhUWLZO6Tv1iwpZrjCtKUwXHdSAPivuBo1gu7hf03CQ+LmvWCp6HRnYi+0jV9 O0LEA+5EXurGoaPVHq13mto4RQhQsBchtkxcP4emDPPf9I8obcYcvpZJT2uQdDe5FWit46fLjoxVOt bi6LiXQYmwTMCgOtG74oL0mrdw/Yk0MzhxNoQX9S23MSRagzX5IDGpTRDauOcknRCGlVQThzOXBPGc 4KjXhlOnITukDsVme5rPy6cdy8dC9cEXwgUZydIpNjMeefWiqt0b+jdmqP96692qUAe231ZEUm7pdZ s6SJhMud/+UX3xtHoVYEIFU2ELRTyryePeGpAhrXB1j3co43P6JEaiN5uBYYwfnLAlgUBLVp/1Ggln 9KkoUeXgPgm1FdnymTtbqN9Tj8muImpmggkgBKb3ntuH+tWhIxH52KyuUgJAKzm27ZXeW1kIqcNkJg 1tIWHk8/1umab5nyK5ByVNjWH4PAh43JUXfLRTtiBtpv3O7XwgEdyWEWB4l5vJ0WgSAZYaxOyokULX FpercPdfJzvG5PB0LMKQzbeA6cygjzf83/jBImri7JMpdkxG0XOkBeFbRdTaNlH0xtGRIAdvOfbzDL qDB8Mb7AwGqRaWdreH2kjhqLKs2UtDea5MNO/yhP6W2pYr+vGU9K39YosVNQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pointer increment on seeing PTR_MAYBE_NULL is already protected against,
hence make an exception for local kptrs while still keeping the warning
for other unintended cases that might creep in.

bpf_list_del{,tail} helpers return a local kptr with incremented offset
pointing to bpf_list_node field. The user is supposed to then obtain the
pointer to the entry using container_of after NULL checking it. The
current restrictions trigger a warning when doing the NULL checking.
Revisiting the reason, it is meant as an assertion which seems to
actually work and catch the bad case.

Hence, under no other circumstances can reg->off be non-zero for a
register that has the PTR_MAYBE_NULL type flag set.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1e72e559ea6b..58e58678382a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10622,15 +10622,20 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 {
 	if (type_may_be_null(reg->type) && reg->id == id &&
 	    !WARN_ON_ONCE(!reg->id)) {
-		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value ||
-				 !tnum_equals_const(reg->var_off, 0) ||
-				 reg->off)) {
+		if (reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0) || reg->off) {
 			/* Old offset (both fixed and variable parts) should
 			 * have been known-zero, because we don't allow pointer
 			 * arithmetic on pointers that might be NULL. If we
 			 * see this happening, don't convert the register.
+			 *
+			 * But in some cases, some helpers that return local
+			 * kptrs advance offset for the returned pointer.
+			 * In those cases, it is fine to expect to see reg->off.
 			 */
-			return;
+			if (WARN_ON_ONCE(reg->type != (PTR_TO_BTF_ID | MEM_TYPE_LOCAL | PTR_MAYBE_NULL)))
+				return;
+			if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
+				return;
 		}
 		if (is_null) {
 			reg->type = SCALAR_VALUE;
-- 
2.38.1

