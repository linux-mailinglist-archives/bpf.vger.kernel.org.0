Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2F6231BB
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 18:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiKIRqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 12:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiKIRqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 12:46:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CDE1120;
        Wed,  9 Nov 2022 09:46:10 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k8so26933865wrh.1;
        Wed, 09 Nov 2022 09:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdlnLIks79/B+I8Gn+VpfQPpDKOLCTmd3NsMRAO2MqY=;
        b=CrgZLmOStm8mvrnZjaDX24MhPC9+SKs0P+9r7Jt+Ik0+XatFa8m2kFlfqWPFRrcyrI
         TVtmCftZzghigEvhHo8ZqiKytxWcSfhD3DgJ8py3CeqNDExQY3Tdtxs2vlMrReYmmDMr
         glIKBDDRFjhaVlVjJCLG4Co1hq1h5H1KPCmcqf6dJEoZ5ObnXKZmTQpAg7+arJ1wDXiG
         OL94Y50SPze10+ZzyaxKwnl5eax2XX1juafNOzLaaQ9eivqoE1/FszivIpPKdYKzZwlH
         /lvfTwYNdDZRCtk33gCezg4EB7eameNP2AYV3mHcahSVA3eZ4il7Jg5zuE2hUGR+2Y0m
         1Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdlnLIks79/B+I8Gn+VpfQPpDKOLCTmd3NsMRAO2MqY=;
        b=dOYcfKEjg7a34TkLFTmWdQ2YnBJAp7jsBTEA+WNRuVFlnKhG62aIDURZyg5ckXm8+r
         hABinvYdE7zuQyi8EPFVLChJ/VGqndus+Xqipn0tSxJbcq4Z5eB9GgzbNtHcCyk3nfOn
         4vP8mpMSW1OaJikvMHy2M8ReWEPoUPskl5FoTxgwuoProMyZWvnM7wPLIWAiVTXlE6PK
         Pjdy6hjV2M5cs0XsP8ZUPN1ekJbOZgMYTaYpUQGf7hohngnV8h3GAQCUvIaBv3F9fKR9
         5U2PSYqz2OvfYL81g4H6hSXxiH4QwLPDh8FayouLrfW4t1DIfXh0YcWmg35+Y7G0pkWY
         eYTA==
X-Gm-Message-State: ACrzQf0lPiBy6YTohldF9sk4qu4HlJKE/UqTFflm3Ax2N7LQHIOrr5R0
        sPKMcGhuY4q5rxtBKmKd/Nllsx2/fX8MNg==
X-Google-Smtp-Source: AMsMyM7D9tkOWRUQvpshRSBRuzvAOqjZEedyiYDOzYvFL3r+wnsIzdKYmlBsURrt4tw0sOxCQnBqrQ==
X-Received: by 2002:a5d:6ac6:0:b0:236:84b5:6660 with SMTP id u6-20020a5d6ac6000000b0023684b56660mr39180369wrw.555.1668015968621;
        Wed, 09 Nov 2022 09:46:08 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:e991:775d:c520:91be])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c3b0300b003b4ff30e566sm3776236wms.3.2022.11.09.09.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:46:07 -0800 (PST)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v10 0/1] Document BPF_MAP_TYPE_ARRAY
Date:   Wed,  9 Nov 2022 17:46:03 +0000
Message-Id: <20221109174604.31673-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

Add documentation for BPF_MAP_TYPE_ARRAY and BPF_MAP_TYPE_PERCPU_ARRAY
variant, including kernel version introduced, usage and examples.

v9->v10:
- Add missing Reviewed-by tag

v8->v9:
- Add "Kernel BPF" heading suggested by Jesper Brouer
- Tidy up wording to clarify BPF vs userspace APIs

v7->v8:
- Fix alignment wording reported by Alexei Starovoitov
- Avoid deprecated functions, reported by Alexei Starovoitov
- Fix code sample formatting, reported by Alexei Starovoitov

v6->v7:
- Remove 2^32 reference and reword paragraph
  reported by Jiri Olsa and Daniel Borkmann

v5->v6:
- Rework sample code into individual snippets
- Grammar mods suggested by Bagas Sanjaja

v4->v5:
- Use formatting consistent with *_TYPE_HASH docs
- Dropped cgroup doc patch from this set
- Fix grammar and typos reported by Bagas Sanjaya
- Fix typo and version reported by Donald Hunter
- Update examples to be libbpf v1 compatible

v3->v4:
- fix doctest failure due to missing newline

v2->v3:
- wrap text to 80 chars and add newline at end of file

v1->v2:
- point to selftests for functional examples
- update examples to follow kernel style
- add docs for BPF_F_MMAPABLE

Dave Tucker (1):
  bpf, docs: document BPF_MAP_TYPE_ARRAY

 Documentation/bpf/map_array.rst | 250 ++++++++++++++++++++++++++++++++
 1 file changed, 250 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

-- 
2.35.1

