Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BADE687E0B
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 13:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjBBM5p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 07:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjBBM5n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 07:57:43 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50FB71984
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 04:57:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h12so1603701wrv.10
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LBR6r1I5bCusw1p/5QXFIJuzOImuINrkR1+VsjnpYro=;
        b=FNpbKxqjJvincUBCsJGyILhFp9+k0PEAJJ/BUFpdxL+vkZ3akn2dJXasUUxmdliNXu
         aX4xeF57oQRg2454Hv9U+6RjFlOMLE7qxFHdt0/QXCTc9YfThlEUv0T2PGuLibEI7t3l
         inmURBGZTbCy6AhUSR9orNcAnxdEtL0BwQ34GRJL+uPf9iGNPNbUurUaaGB71XdCmo2U
         +fj3wfeyXZRyZvWG1/6uJp8LzcGsVqI5gusSeB4Grt2NEyzJTG7v+s1TfV34wkv/OAAY
         yRRUD9V6ImEtBXNp27M4nBiWSOAwecG8lryPAmvZIOc/etaC348nC+oBsBO3FJ69qp5W
         eibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBR6r1I5bCusw1p/5QXFIJuzOImuINrkR1+VsjnpYro=;
        b=BjQ/N0rccmRH/kZndbRlbYL6auLPRJoEJyFgHSy5pPxjgBW+BNstfCce7n3bVTprCj
         Bt3vulieVq/7a2mbY1IBIfyrjPpI8mdTF0TG44IRsOA0xonKkjX+TeP7VHGs6oiMh6OD
         bFq7UGSagkZgWbiQo3BdGcy1KxvlBkId6Wd2xo+RCqo9FHhuJnvToi25fol40Ve3rJTx
         TbhKODM0xy6B3gBvMwOdbUXOTLN5yBOBtnym7/KrCXF7HXUAevK/Jvx88qCSaMDEiLxa
         787cU6sJWSWjfcPHDt/zLJrOcVd8dynxitRtAXRVnm8iGKvJfN9AmCIDvoTW2Qby7l82
         RnTw==
X-Gm-Message-State: AO0yUKXsGFfWfFZE9VeTNT2ud9fhrzxgAd2JinGx6Xc5YbQcyVL3ZtOa
        yMB2fCALiAplfQwZD1da82iCsKAp8dF30Q==
X-Google-Smtp-Source: AK7set+TjuR6/7Ik/FIv1kNdawyd9SCIV/6CYq54bo7rvaq14L1TBX6Sfoa1bdfsbffMKz85RuIpgg==
X-Received: by 2002:adf:f7c4:0:b0:2bf:decb:ecac with SMTP id a4-20020adff7c4000000b002bfdecbecacmr5290647wrq.11.1675342648194;
        Thu, 02 Feb 2023 04:57:28 -0800 (PST)
Received: from pluto.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f9-20020a056000128900b002bf95500254sm8853236wrx.64.2023.02.02.04.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:57:27 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, ecree.xilinx@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 0/1]  docs/bpf: Add description of register liveness tracking algorithm
Date:   Thu,  2 Feb 2023 14:57:12 +0200
Message-Id: <20230202125713.821931-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

An overview of the register tracking liveness algorithm.
Previous versions posted here: [1], [2], [3].
- Changes from RFC to v2 (suggested by Andrii Nakryiko):
  - wording corrected to use term "stack slot" instead of "stack spill";
  - parentage chain diagram updated to show nil links for frame #1;
  - added example for non-BPF_DW writes behavior;
  - explanation in "Read marks propagation for cache hits" is reworked.
- Changes from v2 to v3:
  - lot's of grammatical / wording fixes as suggested by David Vernet;
  - "Register parentage chains" section is fixed to reflect what
    happens to r1-r5 when function call is processed (as suggested by David and Alexei);
  - Example in "Liveness marks tracking" section updated to explain
    why partial writes should not lead to REG_LIVE_WRITTEN marks
    (suggested by David);
  - "Read marks propagation for cache hits" section updates:
    - Explanation updated to hint why read marks should be propagated
      before jumping to example (suggested by David);
    - Removed box around B/D in the diagram updated (suggested by Alexei).
- Changes from v3 to v4 (suggested by Edward Cree):
  - register parentage chain diagram updated to explain why r6 mark is
    not propagated;
  - read mark propagation algorithm pseudo-code fixed to correctly
    show "if state->live & REG_LIVE_WRITTEN" stop condition;
  - general wording improvements in section "Liveness marks tracking".

[1] https://lore.kernel.org/bpf/20230124220343.2942203-1-eddyz87@gmail.com/
[2] https://lore.kernel.org/bpf/20230130182400.630997-1-eddyz87@gmail.com/
[3] https://lore.kernel.org/bpf/20230131181118.733845-1-eddyz87@gmail.com/

Eduard Zingerman (1):
  docs/bpf: Add description of register liveness tracking algorithm

 Documentation/bpf/verifier.rst | 295 +++++++++++++++++++++++++++++++++
 1 file changed, 295 insertions(+)

-- 
2.39.0

