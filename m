Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E448642103
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 02:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiLEBSV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 20:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiLEBST (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 20:18:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFCC6576
        for <bpf@vger.kernel.org>; Sun,  4 Dec 2022 17:18:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d20so13829706edn.0
        for <bpf@vger.kernel.org>; Sun, 04 Dec 2022 17:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2c02C6DwkmoTYgvdL1/tjxZanA7XLnR2lrp3yAHH9q0=;
        b=pNMTJTp97vj6SgkUsP7MAAe2MToMqH2rWjutmoStc2JEHI1FQRl4UiE66JGV5VZmtY
         AcQcCgepBkFpZ8Z5mt9fTZBwmWzmmCvfxqr9cBBItZpQLojSAzceWXke1A87VLwWGNw/
         C376xOkIJAcvAj9nMzyWSnFjGdlUfsf/NL4C2bNH5uD+tw+HG5w6epOEen8pIbQULK9b
         sHDAFXnLoODK6+BgX7ePVeBDmTznAuRvxyQLtCyPD9/rT3e41Tdyih2u5sj52pk2g264
         SPjyuzD5F9ioBctUZ9jnkQmo5TOvEtsBFtc9sdDR/C1Fn2Uw1X6JkdHM+iOP4Oa5QLdl
         B7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2c02C6DwkmoTYgvdL1/tjxZanA7XLnR2lrp3yAHH9q0=;
        b=w6GqIdJG7ZLJBvKoPoFNnpme0lOAGiZwvgkm4f1I3sq4OaRVRXM0IcejSmqKzPdyDJ
         LGT4xi/SG+f7UxwDj7ONltR/l1meOgPXZXLsst55XPVdQzfBngAmS33voNuWgcoYyOtM
         cbsNn4UuxdbEHdgSvVMfxE3Rf5va+Bd+SSULFnKB5RHBBNsB6FdScVeDMB8nzBe6tUg5
         ANPmWXPIYmlII3+UKCuZ8NCpk52a4JwDMZFIsbrjHr+uGJ/ib/E1wJGULA9jU756/3cF
         YR1PSCR+/LUL6f4Xt33LaHkCVWwMNTQ1uq2X2zjzIUAIIrSMpyZf8YfQ2LrfCcVXPYoa
         7pWg==
X-Gm-Message-State: ANoB5pn3e+D8wKA1XYm/Oe5OOBboGWez8LZfCnTO39OBYs6NdlyIHl6J
        SrG9fz4+VZOt3KK+8/dElbJ5+07ElQI=
X-Google-Smtp-Source: AA0mqf7uQnQmj13uI6mWgT5PjKStCyWyvuukOqLjuOpxcQn0fM1ZgXr74AGKd54dr9QK3LLjQJ6uwA==
X-Received: by 2002:aa7:cf03:0:b0:46b:35dc:cf4d with SMTP id a3-20020aa7cf03000000b0046b35dccf4dmr29049694edy.423.1670203094240;
        Sun, 04 Dec 2022 17:18:14 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id e18-20020a170906315200b007b935641971sm5686334eje.5.2022.12.04.17.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 17:18:13 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Fix to preserve reg parent/live fields when copying range info
Date:   Mon,  5 Dec 2022 03:17:52 +0200
Message-Id: <20221205011754.310580-1-eddyz87@gmail.com>
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

Struct bpf_reg_state is copied directly in several places including:
- check_stack_write_fixed_off() (via save_register_state());
- check_stack_read_fixed_off();
- find_equal_scalars().

However, a literal copy of this struct also copies the following fields:

struct bpf_reg_state {
	...
	struct bpf_reg_state *parent;
	...
	enum bpf_reg_liveness live;
	...
};

This breaks register parentage chain and liveness marking logic.
The commit message for the first patch has a detailed example.
This patch-set replaces direct copies with a call to a function
copy_register_state(dst,src), which preserves 'parent' and 'live'
fields of the 'dst'.

The fix comes with a significant verifier runtime penalty for some
selftest binaries listed in tools/testing/selftests/bpf/veristat.cfg
and cilium BPF binaries (see [1]):

$ ./veristat -e file,prog,states -C -f 'states_diff>10' master-baseline.log current.log 
File                        Program                         States (A)  States (B)  States   (DIFF)
--------------------------  ------------------------------  ----------  ----------  ---------------
bpf_host.o                  tail_handle_ipv4_from_host             225         297    +72 (+32.00%)
bpf_host.o                  tail_handle_nat_fwd_ipv4              1746        1900    +154 (+8.82%)
bpf_host.o                  tail_handle_nat_fwd_ipv6               709         722     +13 (+1.83%)
bpf_host.o                  tail_nodeport_nat_ingress_ipv4         276         316    +40 (+14.49%)
bpf_host.o                  tail_nodeport_nat_ingress_ipv6         243         254     +11 (+4.53%)
bpf_lxc.o                   tail_handle_nat_fwd_ipv4              1746        1900    +154 (+8.82%)
bpf_lxc.o                   tail_handle_nat_fwd_ipv6               709         722     +13 (+1.83%)
bpf_lxc.o                   tail_nodeport_nat_ingress_ipv4         276         316    +40 (+14.49%)
bpf_lxc.o                   tail_nodeport_nat_ingress_ipv6         243         254     +11 (+4.53%)
bpf_overlay.o               tail_handle_nat_fwd_ipv4              1082        1116     +34 (+3.14%)
bpf_overlay.o               tail_nodeport_nat_ingress_ipv4         276         316    +40 (+14.49%)
bpf_overlay.o               tail_nodeport_nat_ingress_ipv6         243         254     +11 (+4.53%)
bpf_sock.o                  cil_sock4_connect                       47          70    +23 (+48.94%)
bpf_sock.o                  cil_sock4_sendmsg                       45          68    +23 (+51.11%)
bpf_sock.o                  cil_sock6_post_bind                     31          42    +11 (+35.48%)
bpf_xdp.o                   tail_lb_ipv4                          4643        6996  +2353 (+50.68%)
bpf_xdp.o                   tail_lb_ipv6                          7303        8057   +754 (+10.32%)
test_cls_redirect.bpf.o     cls_redirect                          7918        8210    +292 (+3.69%)
test_tcp_hdr_options.bpf.o  estab                                  180         215    +35 (+19.44%)
xdp_synproxy_kern.bpf.o     syncookie_tc                         22513       22564     +51 (+0.23%)
xdp_synproxy_kern.bpf.o     syncookie_xdp                        22207       24206   +1999 (+9.00%)

This patch-set is a continuation of discussion from [2].

[1] git@github.com:anakryiko/cilium.git
[2] https://lore.kernel.org/bpf/517af2c57ee4b9ce2d96a8cf33f7295f2d2dfe13.camel@gmail.com/

Eduard Zingerman (2):
  bpf: Fix to preserve reg parent/live fields when copying range info
  selftests/bpf: Verify copy_register_state() preserves parent/live
    fields

 kernel/bpf/verifier.c                         | 25 +++++++++----
 .../selftests/bpf/verifier/search_pruning.c   | 36 +++++++++++++++++++
 2 files changed, 54 insertions(+), 7 deletions(-)

-- 
2.34.1

