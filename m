Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669D760D45E
	for <lists+bpf@lfdr.de>; Tue, 25 Oct 2022 21:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiJYTMX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 15:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJYTMV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 15:12:21 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432A4D57E1;
        Tue, 25 Oct 2022 12:12:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bs21so6862433wrb.4;
        Tue, 25 Oct 2022 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VPIu48F91thyVRL/4BDv5jL0+CFMMKeoDRA1S+YdX4o=;
        b=LCUvZR3yYa/Nutg3QkhMRnhv6yvrfn9PxCgju1eYjWeMl1hOqi1gjokN0+iWx5BIZQ
         4kiK+UtvJO2vE+UdGS0xx+gLvLysuGwQf0qQ2C01gYWV5kWEOKNA2yHE45zJUQH5MIoX
         ZFsjF0JMfvI0/NGU1a7NB8FkEB2qINUoQ41UH4jWpiWssSoNduadXr7z3yN+onFQEL2k
         MQwUJIwFwQ+yam/tshhYQr537YOl0h30gwg1++W8NubdU2DMPDl/No06STF5NTmQE9Na
         xa3ibrhosRBx3JQCpYwfTF9uUGpi8MMMUXtnw2JcpNqMB+5Z+EAh3/hoNMUxQ2PrftDt
         l3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPIu48F91thyVRL/4BDv5jL0+CFMMKeoDRA1S+YdX4o=;
        b=f3WbkcBaEqLJn4blRa4Mzq4G0eXR09YP29xirEtU/h1Du0SiqqWF8zsEoQZmt5luwx
         X5kOduFV7zcdQCXNL6jhfbEp01ErRy2tq/CS5QBt9mGRedl9bYshRkomFUUO8Do5qODL
         guecMU8Xu6wN0O6EtarBSoKblFLfCgoVrFycaHxzpDCP6yvXC0Gj/s/wQFPQBi9LFFdv
         lUSdjdl2BqofoYxNm2ywRfoTDAIWO3GXsBk7XDJ4s+3weZVMqZLsxFga+eUpEMvZzJ5W
         Vslf8lkA40ZyjgiQVbTqXIr7aZ2kA+2IAHeJFFsQG2XbopR/6DVDkOCVSG+0wOhyObdZ
         gZdA==
X-Gm-Message-State: ACrzQf3njZG35hC1Ljq2jUfDT8W+M99zCSEN3oXIKw+n41Af/l6pkypk
        tam5wGR+/hMQB2p4xP3dKo/6Fwz3J8sI5A==
X-Google-Smtp-Source: AMsMyM5k4u979KYcnvA1I9HIFwOh+Bej88iUJ3WYqT2q2E2vkOORNnEWPq54/iMv/V9JdD4sNJ/0Iw==
X-Received: by 2002:a05:6000:170e:b0:22f:7c62:6251 with SMTP id n14-20020a056000170e00b0022f7c626251mr25986941wrc.679.1666725138261;
        Tue, 25 Oct 2022 12:12:18 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:d0eb:e336:b451:acd2])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c501000b003cf4006a9casm2640061wmr.39.2022.10.25.12.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 12:12:17 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     dave@dtucker.co.uk, "Jesper D. Brouer" <netdev@brouer.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH bpf-next v9 0/1] Document BPF_MAP_TYPE_ARRAY
Date:   Tue, 25 Oct 2022 20:12:05 +0100
Message-Id: <20221025191206.95584-1-donald.hunter@gmail.com>
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

