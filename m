Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0906D33B5
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDAUFj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 16:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDAUFi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 16:05:38 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FF9B76B
        for <bpf@vger.kernel.org>; Sat,  1 Apr 2023 13:05:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t10so102585226edd.12
        for <bpf@vger.kernel.org>; Sat, 01 Apr 2023 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680379535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BauMoVEdBRNUmhyKQWpTMY+pK53QDrEhMEnzlBQ1VSk=;
        b=EVnRLmnB7t8VykQN31rr/xSdf5X8whej+MNO7nT8xRMqhgdo1g4IHLP6iGGrqYSIP0
         PboDnPD3PoPuw47rdPMr8gTwyjp9enUUna9qXWyO11WvzTYaWYfKG3/uIVORKFOHSp2a
         41gxZGsH8ya/PAn789NMTn9jaMlHm3FGztofEa92wJ3T6ByHL87Q4Qrh51W88bzgZCWx
         YtAPJSwr8z4AwgE+SDCZap6BXlBbwcWf2X2vMbkFdPBjv4sEjurzv2busy4f3B9rm+oX
         JbVpJ5YIwuGv985gIyXrFPKjzQm5/RiJJsDyB0vKbIgrJYqc9LgSRHk8KKVOFYL3DWvM
         gzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680379535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BauMoVEdBRNUmhyKQWpTMY+pK53QDrEhMEnzlBQ1VSk=;
        b=l9lxrvMNPq+20scG33oAN68L0Tiwmi8Y+dU2ZU/T79QyG7ph3u2vukY6Oq3oR5vljM
         RST3Z61avmpAasdGs2ArAP6i1mdZ5VxkyI3QoUCtV5In3ywL+fCN1Bzc5aOdMfRlB19R
         ILPRhzoq4JZskDbG0+HmKxxN+/fuotQSBWyMIyFU1LsKADb001RZzRKKwDu66AcxHz4h
         5nk1dB+iwBdQFWznE8/KHFkWhsvaoFh6V3ypGVN76AUChHUiubPxlpOiFNz03FR+vbwn
         HAwBFP975jPlk+FOVMF3P739AQq2M/PaoPqS5tcatfyx4eKpMwNWfULncQUaSm459tmG
         2+xQ==
X-Gm-Message-State: AAQBX9ca46/WdgKQmO7J6QKbWuEyMR8C3IeR6otoEYNRMGDfnhjMLITo
        fyr+w7pJZVRPtJ06fGNbr2v4kM+mjRpWWIHkHBZFyg==
X-Google-Smtp-Source: AKy350aRz6MUAHy63v9TQy17HRbi66Asf3MZq+edqi9gHrQ9+cuMBmoZqeB6Ob7uC42jbNj+9HXUDQ==
X-Received: by 2002:a17:906:2b9b:b0:933:f310:34f7 with SMTP id m27-20020a1709062b9b00b00933f31034f7mr29261325ejg.15.1680379535091;
        Sat, 01 Apr 2023 13:05:35 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id nd7-20020a170907628700b009484e17e7f5sm117144ejc.100.2023.04.01.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 13:05:34 -0700 (PDT)
From:   Anton Protopopov <aspsk@isovalent.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH v2 bpf-next] bpf: optimize hashmap lookups when key_size is divisible by 4
Date:   Sat,  1 Apr 2023 20:06:02 +0000
Message-Id: <20230401200602.3275-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF hashmap uses the jhash() hash function. There is an optimized version
of this hash function which may be used if hash size is a multiple of 4. Apply
this optimization to the hashmap in a similar way as it is done in the bloom
filter map.

On practice the optimization is only noticeable for smaller key sizes, which,
however, is sufficient for many applications. An example is listed in the
following table of measurements (a hashmap of 65536 elements was used):

    --------------------------------------------------------------------
    | key_size | fullness | lookups /sec | lookups (opt) /sec |   gain |
    --------------------------------------------------------------------
    |        4 |      25% |      42.990M |            46.000M |   7.0% |
    |        4 |      50% |      37.910M |            39.094M |   3.1% |
    |        4 |      75% |      34.486M |            36.124M |   4.7% |
    |        4 |     100% |      31.760M |            32.719M |   3.0% |
    --------------------------------------------------------------------
    |        8 |      25% |      43.855M |            49.626M |  13.2% |
    |        8 |      50% |      38.328M |            42.152M |  10.0% |
    |        8 |      75% |      34.483M |            38.088M |  10.5% |
    |        8 |     100% |      31.306M |            34.686M |  10.8% |
    --------------------------------------------------------------------
    |       12 |      25% |      38.398M |            43.770M |  14.0% |
    |       12 |      50% |      33.336M |            37.712M |  13.1% |
    |       12 |      75% |      29.917M |            34.440M |  15.1% |
    |       12 |     100% |      27.322M |            30.480M |  11.6% |
    --------------------------------------------------------------------
    |       16 |      25% |      41.491M |            41.921M |   1.0% |
    |       16 |      50% |      36.206M |            36.474M |   0.7% |
    |       16 |      75% |      32.529M |            33.027M |   1.5% |
    |       16 |     100% |      29.581M |            30.325M |   2.5% |
    --------------------------------------------------------------------
    |       20 |      25% |      34.240M |            36.787M |   7.4% |
    |       20 |      50% |      30.328M |            32.663M |   7.7% |
    |       20 |      75% |      27.536M |            29.354M |   6.6% |
    |       20 |     100% |      24.847M |            26.505M |   6.7% |
    --------------------------------------------------------------------
    |       24 |      25% |      36.329M |            40.608M |  11.8% |
    |       24 |      50% |      31.444M |            35.059M |  11.5% |
    |       24 |      75% |      28.426M |            31.452M |  10.6% |
    |       24 |     100% |      26.278M |            28.741M |   9.4% |
    --------------------------------------------------------------------
    |       28 |      25% |      31.540M |            31.944M |   1.3% |
    |       28 |      50% |      27.739M |            28.063M |   1.2% |
    |       28 |      75% |      24.993M |            25.814M |   3.3% |
    |       28 |     100% |      23.513M |            23.500M |  -0.1% |
    --------------------------------------------------------------------
    |       32 |      25% |      32.116M |            33.953M |   5.7% |
    |       32 |      50% |      28.879M |            29.859M |   3.4% |
    |       32 |      75% |      26.227M |            26.948M |   2.7% |
    |       32 |     100% |      23.829M |            24.613M |   3.3% |
    --------------------------------------------------------------------
    |       64 |      25% |      22.535M |            22.554M |   0.1% |
    |       64 |      50% |      20.471M |            20.675M |   1.0% |
    |       64 |      75% |      19.077M |            19.146M |   0.4% |
    |       64 |     100% |      17.710M |            18.131M |   2.4% |
    --------------------------------------------------------------------

The following script was used to gather the results (SMT & frequency off):

    cd tools/testing/selftests/bpf
    for key_size in 4 8 12 16 20 24 28 32 64; do
            for nr_entries in `seq 16384 16384 65536`; do
                    fullness=$(printf '%3s' $((nr_entries*100/65536)))
                    echo -n "key_size=$key_size: $fullness% full: "
                    sudo ./bench -d2 -a bpf-hashmap-lookup --key_size=$key_size --nr_entries=$nr_entries --max_entries=65536 --nr_loops=2000000 --map_flags=0x40 | grep cpu
            done
            echo
    done

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---

v1->v2:
  - simplify/optimize code by just testing the (key_len%4 == 0) in hot path (Alexei)

 kernel/bpf/hashtab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 96b645bba3a4..00c253b84bf5 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -607,6 +607,8 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
 {
+	if (likely(key_len % 4 == 0))
+		return jhash2(key, key_len / 4, hashrnd);
 	return jhash(key, key_len, hashrnd);
 }
 
-- 
2.34.1

