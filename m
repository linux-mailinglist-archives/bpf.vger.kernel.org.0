Return-Path: <bpf+bounces-1332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC36F712CAB
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 20:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250A61C2112B
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 18:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9510127205;
	Fri, 26 May 2023 18:42:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047D18B0D
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 18:42:11 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F24E42
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 11:41:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4bd608cf4so1221923e87.1
        for <bpf@vger.kernel.org>; Fri, 26 May 2023 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685126498; x=1687718498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vAKOTAyhD0TnNbivgOsSZqPuLgX+ojQaeOdc/rxb/wE=;
        b=Ekusghw9ajijIbIfIYD1zFbTGIszGrbBzhEgB6pzxpkvMWBX2xm4Wg3Wi3Yg89fKBu
         9rqJ/LSrvxTbKBa2LPs3Xf96RueJxzdjs0nNTk/Ri7AFxM4NRKwB6R+GOfBfvLNlFXAj
         H0ZskkG3DnX6khzRZHxukuC4saiP6QU5cgewZEwCO+qUkR67IpavDlHA++JqvhgDCqCb
         OO9PMQKhlbwxKNaqbFGOYARq/9PsDmDP/EWbGbO4SV9Ri5bKnzbiSgfxBQpRPWhQefQO
         HYwNNZPsjxS1S/KoU0nTvAA5KvoSF4yRo0vFfYLb22B1pyaahtUU1TCaBe5U0WMU6O02
         hGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126498; x=1687718498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAKOTAyhD0TnNbivgOsSZqPuLgX+ojQaeOdc/rxb/wE=;
        b=DJ38ui893MktycARawUv6eeuGfEUYBZxwEw4gH+XEv4gFQoi813Q+zlWrwBjN8ZbQS
         +bxLYnDGnkIr6MgaactCTyl8LMb4mC3VtJBtm7zDqSDMfqfpn1tZIzO9lR7n//v0hTQI
         EnX4tBVuLjk5m3g6uhfjCDpt1zwnyVVIxbP/ZArQ78V0YwfADipyktv4Opy3FeLH6HgA
         4nh74wlLwyR8eAtrsg7ZX/T8H3I/fKbupCj5ibxOfqjb7uSB1Ry+jG01B04gwKFmgeh3
         4lzLnZjquVUWFSbSXK37TaTuorsIJsK0+4jU8QgiBVSdlAC0EQzGMfB3CcJD45//esdk
         vW1A==
X-Gm-Message-State: AC+VfDxS+Vwq1Ek3/GtfSfkyTuqpyUa9JsyB2+ZGPHe8TlGLeREk01xO
	ZNi1utHqP/N7i42q0QkhVGNJ6I/9rj30bw==
X-Google-Smtp-Source: ACHHUZ483jYpVhdlcnqKJVJ4Iicx+YErp7UpsB4sTQH/o5mMHgxW/F3pMSntsFqD0rATkwm9+U4e7A==
X-Received: by 2002:a05:6512:248:b0:4f2:34f1:cf24 with SMTP id b8-20020a056512024800b004f234f1cf24mr1015155lfo.22.1685126497353;
        Fri, 26 May 2023 11:41:37 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x7-20020ac25dc7000000b004f155762085sm735767lfq.122.2023.05.26.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 11:41:36 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yhs@fb.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 0/2] bpf: verify scalar ids mapping in regsafe()
Date: Fri, 26 May 2023 21:41:24 +0300
Message-Id: <20230526184126.3104040-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Update regsafe() to use check_ids() for scalar values.
Otherwise the following unsafe pattern is accepted by verifier:

  1: r9 = ... some pointer with range X ...
  2: r6 = ... unbound scalar ID=a ...
  3: r7 = ... unbound scalar ID=b ...
  4: if (r6 > r7) goto +1
  5: r6 = r7
  6: if (r6 > X) goto ...
  --- checkpoint ---
  7: r9 += r7
  8: *(u64 *)r9 = Y

See patch #1 for detailed description.

The change has limited impact on verification performance.
Here is veristat log comparing this patch with current master on a set
of selftest binaries listed in tools/testing/selftests/bpf/veristat.cfg
and cilium BPF binaries (see [1]):

$ ./veristat -e file,prog,states -f 'insns_pct>1' -C master-baseline.log current.log
File                      Program                         States (A)  States (B)  States   (DIFF)
------------------------  ------------------------------  ----------  ----------  ---------------
bpf_xdp.o                 tail_handle_nat_fwd_ipv6               648         660     +12 (+1.85%)
bpf_xdp.o                 tail_nodeport_nat_ingress_ipv4         375         455    +80 (+21.33%)
bpf_xdp.o                 tail_rev_nodeport_lb4                  398         472    +74 (+18.59%)
pyperf600_nounroll.bpf.o  on_event                             34169       39465  +5296 (+15.50%)
test_verif_scale1.bpf.o   balancer_ingress                      8636        8942    +306 (+3.54%)
test_verif_scale2.bpf.o   balancer_ingress                      3048        3149    +101 (+3.31%)
test_verif_scale3.bpf.o   balancer_ingress                      8636        8942    +306 (+3.54%)

This was previously posted as an RFC [2].

Changelog:
- RFC -> V1:
  - Function verifier.c:mark_equal_scalars_as_read() is dropped,
    as it was an incorrect fix for problem solved by commit [3].
  - check_ids() is called only for precise scalar values.
  - Test case updated to use inline assembly.

[1] git@github.com:anakryiko/cilium.git
[2] https://lore.kernel.org/bpf/20221128163442.280187-1-eddyz87@gmail.com/
[3] commit 71f656a50176 ("bpf: Fix to preserve reg parent/live fields when copying range info")

Eduard Zingerman (2):
  bpf: verify scalar ids mapping in regsafe() using check_ids()
  selftests/bpf: verify that check_ids() is used for scalars in
    regsafe()

 kernel/bpf/verifier.c                         | 31 +++++++++-
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c | 59 +++++++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_scalar_ids.c

-- 
2.40.1


