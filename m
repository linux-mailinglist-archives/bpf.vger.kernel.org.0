Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174753C767D
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 20:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGMSgA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 14:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhGMSf7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 14:35:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ECFC0613DD
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 11:33:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb6so43233127ejc.5
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:subject:cc:from:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mEi0R5Tc0vHRfKtwtLkvXfDbKbF151cHEPpvfJf3atQ=;
        b=iw4SpqGomN4e2B7nEFSH2+bs1ZoJzT5HLI7RTTqacejUEHML3Y56wXF1f5qajZAI1a
         OosSPZmnniWOFTUe4XEXZvcDyr1nJD2j8qx0ZhztsjZ5DQ6buw1Okj0g7+WcNYlb9fZd
         GNuIhltrJlPeULP9g6nd9BHAvlg33LyfDxOAd1SHPIQ0cZvZoKPFbDy2B+ybLqi3vuMc
         sg2z/tI/9R+GW61YoBAgz6ckG/tZVaL6bINxz4dvukbpGcc0GyEuD20lmhf7MSHeHFwy
         0xF9sLymJPpG+57AGwdV1cI2momwE337mbwISBUkCZQrDRSsrkZl+8cKB6Z3UTtoAOuT
         6DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:cc:from:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mEi0R5Tc0vHRfKtwtLkvXfDbKbF151cHEPpvfJf3atQ=;
        b=e1a3CCrJBCbd37+FdUsXxUyJ4z3QrC+ajKxPP3s93f+ToiDiT5IACnWv6hXXVh1Ew6
         biCrRxhfvqJBnYSq9hd/RnxsQ9JYcB/obpXVkTTnb71yTgpmUbqHI+IGaSWUlGEFs62a
         yJ7kjMLTMGXM1G5/t8WhDphIndKDYxaq1up9GC5s5EruVWi9cDBb9cKGhKtMDQB9vsc7
         SrQ9cH9R9eL98MwOZ/d3N+l1TzLZUqOdgixWoFYmMyXMpobEk0LoO0KOzGWfNBOGx013
         Qxw8puglNhpu1n50dzrDgcGRNScDAj1nxWQ21kLHXmAwJDj9YyiQoe9FPLNFSDoPh/Pg
         ykbQ==
X-Gm-Message-State: AOAM532fz+zuYU4SvEgma40+cLW0xZAK7aYQe6CJG9vvup2eCs0nVavu
        DTtWnN8e3QErIpC80S0xEzg=
X-Google-Smtp-Source: ABdhPJyVYxDugkU8B49f2j7GWhknPU5yoj3BOILAj5VvV7kp/29L+21M3VKz10BEskRcquxiHoVyJA==
X-Received: by 2002:a17:906:d977:: with SMTP id rp23mr7273635ejb.512.1626201186583;
        Tue, 13 Jul 2021 11:33:06 -0700 (PDT)
Received: from [192.168.2.75] (host-95-232-75-128.retail.telecomitalia.it. [95.232.75.128])
        by smtp.gmail.com with ESMTPSA id kb12sm8562185ejc.35.2021.07.13.11.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 11:33:05 -0700 (PDT)
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 1/2] tools/lib/bpf: bpf_program__insns allow to
 retrieve insns in libbpf
Cc:     ast@kernel.org, daniel@iogearbox.net
From:   Lorenzo Fontana <fontanalorenz@gmail.com>
Message-ID: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
Date:   Tue, 13 Jul 2021 20:33:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This allows consumers of libbpf to iterate trough the insns
of a program without loading it first directly after the ELF parsing.

Being able to do that is useful to create tooling that can show
the structure of a BPF program using libbpf without having to
parse the ELF separately.

Usage:
  struct bpf_insn *insn;
  insn = bpf_program__insns(prog);

Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
---
 tools/lib/bpf/libbpf.c | 5 +++++
 tools/lib/bpf/libbpf.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1e04ce724240..67d51531f6b6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8866,6 +8866,11 @@ void *bpf_program__priv(const struct bpf_program *prog)
 	return prog ? prog->priv : libbpf_err_ptr(-EINVAL);
 }
 
+struct bpf_insn *bpf_program__insns(const struct bpf_program *prog)
+{
+	return prog ? prog->insns : libbpf_err_ptr(-EINVAL);
+}
+
 void bpf_program__set_ifindex(struct bpf_program *prog, __u32 ifindex)
 {
 	prog->prog_ifindex = ifindex;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6e61342ba56c..e4a1c98ae6d9 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -195,6 +195,7 @@ typedef void (*bpf_program_clear_priv_t)(struct bpf_program *, void *);
 LIBBPF_API int bpf_program__set_priv(struct bpf_program *prog, void *priv,
 				     bpf_program_clear_priv_t clear_priv);
 
+LIBBPF_API struct bpf_insn *bpf_program__insns(const struct bpf_program *prog);
 LIBBPF_API void *bpf_program__priv(const struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_ifindex(struct bpf_program *prog,
 					 __u32 ifindex);
-- 
2.32.0

