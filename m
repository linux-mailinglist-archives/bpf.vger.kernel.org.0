Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422A76F6992
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjEDLJ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 07:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEDLJ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 07:09:29 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EAC448E
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 04:09:24 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-55a1462f9f6so2221857b3.3
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683198563; x=1685790563;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GROeopruJWajWKHt8r0gfzVZxA7J+E5dzgTrhJcym+A=;
        b=M74sXPkjK4yTESDXjEh9VHufZayaiaEtWDMel6olq/v7ncO61ctW9/z2S8je2i1cYl
         mx9JVKCkb55sBz+FrP1pC1cLsHhAMKnm1hWLqI4dd2DEQGmp+Nw7uEknBpVwpCLtDGOq
         wImbeJMzHT4HKcRvSDwJR53gDV+HdpIxOAkkeENu78iwZm+twuvyrq0v2ilycXQp7szM
         tH+3Cx+pt9hdW/OcQrCHTbU/zH2cb/WYFLFhLkFKVPvoIbsqPA7FtkENxCTy0VBm/dDt
         EtmabeyGyrYn849rpOq2hN79cYptjaz1NSc/7eWzXLlxMPCJQdCxsZHPUQ4QyRnb1TIg
         LylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683198563; x=1685790563;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GROeopruJWajWKHt8r0gfzVZxA7J+E5dzgTrhJcym+A=;
        b=lSbVVBxmQX36EOMKHKGx/kdiPJ+8ciXlaTB+I7Lqo8aFp/4Oz5DuMi0HEa5edLaT3l
         n5w4tzCf/QzGD+4KkMe3ViExE1TLWhsCK0DQnUHN2F2J0MmZiSTYokbj0I9lMic40jsv
         aMOGKj9RB/Hc9mcVgDpDzJo/jIooTyrPt9fQHfGJFxbslPvZTsBWwz6rJAJKk5UHxA8D
         SaEHIjhGSylIHY9oEmuk1Romw/d6DLAm0eusw8IeXlCYDIP5XljeSNYgdCzS9fQ4HM2+
         QYh1c2eOQa9bAtfYPVEcur7Zj2VLdj7JC0cIuF7TpR9EX0rtpoTnpQEmZUtMnQVoqmD2
         qlRw==
X-Gm-Message-State: AC+VfDzN5uUJYKOYVkI0aPhDrMwSug/l9F7JApIp+OwTDRg0rKAAF0/K
        BIX2trVAcak+Z3LIlvxrFrb6Qz5zzuz2mVsMYQE=
X-Google-Smtp-Source: ACHHUZ4+eVHXvY11VJjReHB05TqXb9+VvIQfgKJWiHPuJDqeTf9S2cg7qzfoGKhwi0+AR1SGLNMrdZOVSsFez3Kh1XY=
X-Received: by 2002:a25:320f:0:b0:b9a:3836:bf15 with SMTP id
 y15-20020a25320f000000b00b9a3836bf15mr26230592yby.37.1683198563740; Thu, 04
 May 2023 04:09:23 -0700 (PDT)
MIME-Version: 1.0
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Thu, 4 May 2023 19:09:12 +0800
Message-ID: <CADxym3ax73kYEyJMZwN+bTwmX9VhZ3WJe+wC9RGGwpfdjLdf3g@mail.gmail.com>
Subject: bpf: add support to check kernel features in BPF program
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I find that it's not supported yet to check if the bpf features are
supported by the target kernel in the BPF program, which makes
it hard to keep the BPF program compatible with different kernel
versions.

For example, I want to use the helper bpf_jiffies64(), but I am not
sure if it is supported by the target, as my program can run in
kernel 5.4 or kernel 5.10. Therefore, I have to compile two versions
BPF elf and load one of them according to the current kernel version.
The part of BPF program can be this:

#ifdef BPF_FEATS_JIFFIES64
  jiffies = bpf_jiffies64();
#else
  jiffies = 0;
#endif

And I will generate xxx_no_jiffies.skel.h and xxx_jiffies.skel.h
with -DBPF_FEATS_JIFFIES64 or not.

This method is too silly, as I have to compile 8(2*2*2) versions of
the BPF program if I am not sure if 3 bpf helpers are supported by the
target kernel.

Therefore, I think it may be helpful if we can check if the helpers
are support like this:

if (bpf_core_helper_exist(bpf_jiffies64))
  jiffies = bpf_jiffies64();
else
  jiffies = 0;

And bpf_core_helper_exist() can be defined like this:

#define bpf_core_helper_exist(helper)                        \
    __builtin_preserve_helper_info(helper, BPF_HELPER_EXISTS)

Besides, in order to prevent the verifier from checking the helper
that is not supported, we need to remove the dead code in libbpf.
As the kernel already has the ability to remove dead and nop insn,
we can just make the dead insn to nop.

Another option is to make the BPF program support "const value".
Such const values can be rewrite before load, the dead code can
be removed. For example:

#define bpf_const_value __attribute__((preserve_const_value))

bpf_const_value bool is_bpf_jiffies64_supported = 0;

if (is_bpf_jiffies64_supported)
  jiffies = bpf_jiffies64();
else
  jiffies = 0;

The 'is_bpf_jiffies64_supported' will be compiled to an imm, and
can be rewrite and relocated through libbpf by the user. Then, we
can make the dead insn 'nop'.

What do you think? I'm not sure if these methods work and want
to get some advice before coding.

Thanks!
Menglong Dong
