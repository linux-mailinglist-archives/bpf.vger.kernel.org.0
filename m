Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44C5F7B6C
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 18:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJGQ2S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJGQ2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 12:28:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1562ECF1A6;
        Fri,  7 Oct 2022 09:28:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv10so4481811wrb.4;
        Fri, 07 Oct 2022 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o929Wlotx+zgOvZersPSdgp4ep76WzezbPIvd7EtX0g=;
        b=G47Fu9heInruhYJMPWbO91+njZyJZ4vRE6UdBmK0FwnNLariA0AWpYej1fSVU0OYrg
         a+BbrAvY/q71OYiv8SUXunn4G1T89O55Qwxht8IC4BZ65qLRjdjUptAyQR3ugTh8DnAt
         Kb947Ol5zS99TE7iFVuZEserv6yqJQe5eXMOs3KhRjuvzjwPRZweaZt1PDqb6r76U5J6
         Q/n1Vm68/DAa+ozsbkPP6JccYMVRQ9z/Z8gPYiFUwU+P9clxgXxNwcvvEVwX3xTJvR0L
         2nSb6ew2L9a/04ydEwHZBIZF0VxO0OlRU8e8RgP09xZHYrLs3xfTF5mk8nhzlaMD9D3n
         STzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o929Wlotx+zgOvZersPSdgp4ep76WzezbPIvd7EtX0g=;
        b=6EVrRuq1Gj5zGEoftXqgMlJjSEkRwW7taUjK+s7i79U681WWsQlAPNDIasadQfy7Lv
         z5kEyEXRn1M0z4e6fkW4Xp+VPXCVgwu0Q/8UEuNNNvLkVSlIxtPVcz7HqHsn+/fHfQ3U
         RT/tvgVZArbQ5TT8swn0f+2YIz/MgXkGtp/u3id6pwQE5JmLtJSKkg87wJ7YFqVeE4It
         LmrpzTbCayyBsevFvH3VlXrk9FUKQY5k+zJU7LC7d+S5ZdcaFXLmt5Nc3QAb6U+sUXfo
         EJ3FPD50yv6mx/Dw6naUJNnnpECGE78phT1coPKPmnGS2ycNCfJmgjjLZUKHABodAeo0
         o5VQ==
X-Gm-Message-State: ACrzQf0miOba9w/hZVooKzCvpjRtB1AjEN9EzSwlihBSyQ5RdSJ2qY3P
        ILMt+Y9V0FT+TbnQd77zNyuJpmSFkzjRxQ==
X-Google-Smtp-Source: AMsMyM4ZOA2LIMZIZJVd2LGSBDeGdvVNFW2LzIibAc1Y2RKVUS8ZUiAqbIMSFjWyiPok7pdG8eRFqQ==
X-Received: by 2002:a5d:6d86:0:b0:22e:404f:1101 with SMTP id l6-20020a5d6d86000000b0022e404f1101mr3684191wrs.343.1665160089959;
        Fri, 07 Oct 2022 09:28:09 -0700 (PDT)
Received: from imac.redhat.com ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5229000000b0022cd59331b2sm2487855wra.95.2022.10.07.09.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 09:28:09 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     dave@dtucker.co.uk, Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v7 0/1] Document BPF_MAP_TYPE_ARRAY
Date:   Fri,  7 Oct 2022 17:27:54 +0100
Message-Id: <20221007162755.36677-1-donald.hunter@gmail.com>
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

 Documentation/bpf/map_array.rst | 232 ++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)
 create mode 100644 Documentation/bpf/map_array.rst

-- 
2.35.1

