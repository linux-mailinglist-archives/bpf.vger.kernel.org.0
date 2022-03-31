Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E244EDDB6
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbiCaPsw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbiCaPsa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 11:48:30 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B932F38F
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 08:46:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id m21so6088290qtw.8
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdaverde-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3LYS65c4ngde5Sf/CRmanaRSxKjEDRgSvxSuSxBsqEc=;
        b=AME818MNJpYFqVRzMQ8G2/TffOi/1CdJh+Ov+TIOXiss4DrbP66b+15RGUt3T+S8Ep
         b2f9QS/+lhzki/omOxU8k1m+o4ftE3Q9wwOZQmfGXEvWl/wMNVGMqTGb/wR4rv3QY3/4
         mPhqA7lOTYvOAOGxbhBfaQNv/VpNrmlO/oQIJHegQETrRsYeYJBzj59n6BqngL3GoiCG
         tq6AkBUhFQZsGJgaECD36mqldNReo8DFULqsVnvhuOU+V96rXR+o4NVP/xIoJeIbhQLV
         0gKG49XvuRzaVT+v+kfuDEl2izRofzj0pIs12qQnywnGrQOo/dUn2Oe/+hsTcswovLXB
         VD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3LYS65c4ngde5Sf/CRmanaRSxKjEDRgSvxSuSxBsqEc=;
        b=oEInx9EMOuv4v/XdT7BUnwdb1LUaR0hoQI4hsXfITzt5qmHNWfFgHm1vsYo3R1kciV
         cbX6kdv0WE+tZqsmR13RiJf2A9nwWn6YDuWVJTCFVQphjimgxMTTOScsbUdplUU32kss
         JbzsK/PCGYxHCqOMik2hIar6K/lgh0ac4N1YsfIZOye55eGALoTGF3Jk6EQUGoQzKF6s
         tmeip1asjbq/1WdvVY7rv0tD4yTAu9QhFbIkEfAiX4AVuhzgcVlx8EQiuiaDzhhtVrAW
         XBFgJGLf9IkrEzT+Fzwhb2H0KdxSXtgpcW/ghBdJ7e1B/eCi1d37L0z1mPrahQycNwxj
         ikeA==
X-Gm-Message-State: AOAM531uPBinz3SDoCUZbiiparR6ouzmNqoGBTKPyQAgWjiZJvwlB9p6
        x2bfCRttcrZ5XGx3I2YQEV02PZCI+UEQQQNxViCW/A==
X-Google-Smtp-Source: ABdhPJygwSfyTwbWopq/cvK0vHooNH/Lu7ir5ljdbjSyLh1lNPef8vRFmtoDL7HrM8Le0yUZ6O1luw==
X-Received: by 2002:ac8:5cc2:0:b0:2eb:8308:91f3 with SMTP id s2-20020ac85cc2000000b002eb830891f3mr4869207qta.280.1648741598786;
        Thu, 31 Mar 2022 08:46:38 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:1d10:5830:565c:ffc5:fa04:b353])
        by smtp.gmail.com with ESMTPSA id j12-20020ae9c20c000000b0067ec380b320sm13126797qkg.64.2022.03.31.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:46:37 -0700 (PDT)
From:   Milan Landaverde <milan@mdaverde.com>
To:     bpf@vger.kernel.org
Cc:     milan@mdaverde.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        quentin@isovalent.com, davemarchevsky@fb.com, sdf@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/3] bpf/bpftool: add program & link type names
Date:   Thu, 31 Mar 2022 11:45:52 -0400
Message-Id: <20220331154555.422506-1-milan@mdaverde.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the addition of the syscall prog type we should now
be able to see feature probe info for that prog type:

    $ bpftool feature probe kernel
    ...
    eBPF program_type syscall is available
    ...
    eBPF helpers supported for program type syscall:
        ...
        - bpf_sys_bpf
        - bpf_sys_close

And for the link types, their names should aid in
the output.

Before:
    $ bpftool link show
    50: type 7  prog 5042
	    bpf_cookie 0
	    pids vfsstat(394433)

After:
    $ bpftool link show
    57: perf_event  prog 5058
	    bpf_cookie 0
	    pids vfsstat(394725)

Milan Landaverde (3):
  bpf/bpftool: add syscall prog type
  bpf/bpftool: add missing link types
  bpf/bpftool: handle libbpf_probe_prog_type errors

 tools/bpf/bpftool/feature.c | 2 +-
 tools/bpf/bpftool/link.c    | 2 ++
 tools/bpf/bpftool/prog.c    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

--
2.32.0

