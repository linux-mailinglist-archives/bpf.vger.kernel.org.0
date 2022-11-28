Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3956063ADE0
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 17:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiK1QfH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 11:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiK1QfG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 11:35:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DBA20F64
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 08:35:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gu23so9051080ejb.10
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 08:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g9sllZafn/89VKTfG/2+O3Qv9N8hP6iOecl6/BJ9wRs=;
        b=U19/g46NvKSTIkG5uqTg2cRZqU/Osg3TFaLODZsfjxffIbHyW67YvQKbs9+Hrs1CZP
         RncEqKIZicyHWna9ILzsrUntYkhxhSc0GEOJ3Jbh3gzRxydU7QyvHVe4Qt5tsuFTbqd5
         DzOyRTHTj+c1YTNB4TR9FkLOFTFtMkm9Ol8g7bFb+5GiwhKZCmMfCw7R/uEkCa54YKGo
         rcTSmQUjQcVtjo36EVSxx+Nc7885qcSB7hi5X4mKMzuoShqeucPjtbWOPFG69V7kZi1T
         Gbt2ypRq3980dS6ocUOrErYQgcPvP/VNqIbfOVXolOhbnIDX3kWhMpRum5UXYFHl0zo3
         3FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9sllZafn/89VKTfG/2+O3Qv9N8hP6iOecl6/BJ9wRs=;
        b=AKPyn0d2C0/SQGP+TIg5wDcviWX10OekOxjc/q1cSGbnZrTbskAjEW0go5w1cM35y6
         Ch3LBmc0W9yY5fa912kX//uj+/bafvuAFUMhYQkP30k41OJa821Me0NX9mI8CRubogeF
         ZqR/WOBwDQpFf1j/z29Orp5WfeyiRuAqgd2H6KQPgMxVNKdzlfTpn9Fog5lC0D6G+dK7
         FVNnmU3LvgZHsxUglw3tlt4Hoix9BeNDJX58VahaBnM/GK5Wn8xnxld67g2ZyiHATHKa
         Ci82rWR/ScdGtr5NgLYPQY2tOcSpQ9Z8DZQc4M7t9pgZUxkzI5iPQTMThO0p6qBrcejj
         1x/g==
X-Gm-Message-State: ANoB5pkYgwEmQelTxbPm3Bm3MetuCBuBRUAPuBkLnhI2/aHJBkTB1rLD
        LhEHSMWyY1jlxHvBcgETKRsMsI3HzVs=
X-Google-Smtp-Source: AA0mqf7Lfw4ak+32sRfyBPMXwcPUn0QRYh1aCK9VPuljFp9pZYM8T74Qx7MLNpUsAOU4lM357sIOyQ==
X-Received: by 2002:a17:906:6892:b0:78d:ab48:bc84 with SMTP id n18-20020a170906689200b0078dab48bc84mr7868759ejr.22.1669653303294;
        Mon, 28 Nov 2022 08:35:03 -0800 (PST)
Received: from pluto.. (178-133-113-180.mobile.vf-ua.net. [178.133.113.180])
        by smtp.gmail.com with ESMTPSA id kv7-20020a17090778c700b007417041fb2bsm5145605ejc.116.2022.11.28.08.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:35:02 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 0/2] bpf: verify scalar ids mapping in regsafe() using check_ids()
Date:   Mon, 28 Nov 2022 18:34:40 +0200
Message-Id: <20221128163442.280187-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently the following test case is considered safe by the verifier:

 1: r9 = ... some pointer with range X ...
 2: r6 = ... unbound scalar ID=a ...
 3: r7 = ... unbound scalar ID=b ...
 4: if (r6 > r7) goto +1
 5: r6 = r7
 6: if (r6 > X) goto ...   ; <-- suppose checkpoint state is created here
 7: r9 += r7
 8: *(u64 *)r9 = Y
 
This happens because function regsafe() used (indirectly) form
is_state_visited() does not compare id mapping for scalar registers.

The following patch makes two chages:
- regsafe() is updated to use check_ids() for scalar registers;
- registers that obtain their range via find_equal_scalars() are
  marked as read in the parent checkpoint states. See
  mark_equal_scalars_as_read() for detailed explanation.

However, I'm not sure if mark_equal_scalars_as_read() is sufficient or
mark_chain_precision() should be called / updated as well.

In current form the patch does not have a big impact on the tests
verification time, as checked on BPF object files listed in
tools/testing/selftests/bpf/veristat.cfg and Cilium object files
obtained from [1]:

./veristat -e file,prog,insns,states -f 'insns_diff!=0' -C master.log current.log
File         Program                  Insns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States (DIFF)
-----------  -----------------------  ---------  ---------  ---------------  ----------  ----------  -------------
bpf_host.o   cil_from_host                  556        603     +47 (+8.45%)          37          41   +4 (+10.81%)
bpf_xdp.o    tail_lb_ipv4                 77248      77302     +54 (+0.07%)        4643        4646    +3 (+0.06%)
loop6.bpf.o  trace_virtqueue_add_sgs      15144      18594  +3450 (+22.78%)         337         403  +66 (+19.58%)

A tweak adding !tnum_is_const(src_reg->var_off) in check_alu_op() is
necessary to achieve this.

[1] git@github.com:anakryiko/cilium.git

Eduard Zingerman (2):
  bpf: verify scalar ids mapping in regsafe() using check_ids()
  selftests/bpf: verify that check_ids() is used for scalars in
    regsafe()

 kernel/bpf/verifier.c                         | 87 ++++++++++++++++++-
 .../selftests/bpf/verifier/scalar_ids.c       | 61 +++++++++++++
 2 files changed, 146 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/scalar_ids.c

-- 
2.34.1

