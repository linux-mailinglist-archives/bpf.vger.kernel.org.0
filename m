Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD51426CBF
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 16:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhJHOa2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 10:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbhJHOa1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Oct 2021 10:30:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E0C061570
        for <bpf@vger.kernel.org>; Fri,  8 Oct 2021 07:28:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k23so7767143pji.0
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=axtJcHZV0CC/72kCrQBXBxS1HPNlzpvK5e7u/fn38QE=;
        b=ZpRghE/t0VSWC9ZxQnSfoeqlENfca/I2gofNMiKQsNXHQYFzdWfAAsU2AdmcGx8MXZ
         hUntDWE1spPDJMbX9Ea2XgL7TLcI3lSJxn8cMY4I7hzfUV3vc+kmpzUYtT3MYVmgfvnM
         kEw7VKGmkwHq4HZyCN+sNmc8dq3jEBzA+tURbIgFnrriUr2hCdxE5SWN+3sXeeW2lpyR
         m6+xI1qiDIFSGahT7sLsYVw/LzlPNpmZai0aGODZeJVHzPk0cIyoB+9oLNjB0Q4B7qH2
         bbO70FtcvaovLQYszcrlsoeiPOWBquO2qgEd91kvhZXVmzqEM4APT/u7xzOnWRKsq0L1
         MwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=axtJcHZV0CC/72kCrQBXBxS1HPNlzpvK5e7u/fn38QE=;
        b=0jZH+kyQ8NY68ZZDSkEbbYbS0003zU/Uaka9yI6VUD/6cIxVonsubpGBMEbSsU66Jb
         a+sVStzoz3rYa4B/LTC4mUwb9FHfQ1VGtPT6gMbZ7/LtUH4gVerRnsAGZ1RG38+gBAp5
         NLdaJnr3Wvg0B0oHJUpfDEp2U4+7lvIt0UDoP2OfG51uaTmm0vPEGWmf9K3RKrFKoK+5
         Ga7V4WIVHzW5aUWzPvwpZvX3pXR+YToDE7+3eVQaoHP+9y8Wf5wJkpeQ+0xdajHr6H9g
         5kcAkrL+eq+DU0hcH+GVwKv9LAsIloE6xGbe+BmwiSWFGIqGsQdLy15vrLRDnU4dkcWv
         R3sw==
X-Gm-Message-State: AOAM533HgWJWMgB90uObP1uIpkJNmACUORl6cyegpKT79obsIY451szk
        KQEadkPCW13ivz7GA+iHE9B0iuUYKiA=
X-Google-Smtp-Source: ABdhPJzZlNTol8J9Tb3NlhBW2dwe6PvAYLAeZ1QsSkcaHfH9PFqgJ7jQDTVI2FOhrA1+ifBFcIvCCw==
X-Received: by 2002:a17:902:ecd0:b0:13f:1469:c0f2 with SMTP id a16-20020a170902ecd000b0013f1469c0f2mr4084550plh.10.1633703311528;
        Fri, 08 Oct 2021 07:28:31 -0700 (PDT)
Received: from [0.0.0.0] ([104.207.159.124])
        by smtp.gmail.com with ESMTPSA id e6sm2867303pfm.212.2021.10.08.07.28.29
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 07:28:31 -0700 (PDT)
To:     bpf@vger.kernel.org
From:   zerons <sironhide0null@gmail.com>
Subject: branch prediction issue
Message-ID: <57c1bcd6-f034-f5d1-f282-a6d843a2937f@gmail.com>
Date:   Fri, 8 Oct 2021 22:28:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In check_cond_jmp_op(), the is_branch_taken() is called when
1) SRC op is imm
2) the value of SRC op is known

Here comes the question: what if the value of DST op is known.

Consider the following instructions:

BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_8, 0),
BPF_JMP32_IMM(BPF_JGT, BPF_REG_7, 0x7ffffff0, 1),
BPF_EXIT_INSN(),
BPF_LD_IMM64(BPF_REG_3, 0x7fffffe0),
BPF_JMP32_REG(BPF_JGT, BPF_REG_3, BPF_REG_7, 1),
BPF_EXIT_INSN(),
BPF_EXIT_INSN(), ==> point_a

At point_a, the state of regs[7] is
(gdb) p /x $regs[7]
$219 = {
  type = 0x1,
  {
    range = 0x0,
    map_ptr = 0x0,
    btf_id = 0x0,
    mem_size = 0x0,
    raw = 0x0
  },
  off = 0x0,
  id = 0x0,
  ref_obj_id = 0x0,
  var_off = {
    value = 0x7fffffc0,
    mask = 0xffffffff0000003f
  },
  smin_value = 0x800000007fffffc0,
  smax_value = 0x7fffffff7fffffff,
  umin_value = 0x7fffffc0,
  umax_value = 0xffffffff7fffffff,
  s32_min_value = 0x7ffffff1,
  s32_max_value = 0x7fffffdf,
  u32_min_value = 0x7ffffff1,
  u32_max_value = 0x7fffffdf,
  parent = 0xffff88807127e348,
  frameno = 0x0,
  subreg_def = 0x0,
  live = 0x4,
  precise = 0x1
}

u32_min_value is larger than u32_max_value.

The point_a instructions should be dead code. I wonder if the
verifier do this on purpose. Do we need to handle this situation?

Thanks.
