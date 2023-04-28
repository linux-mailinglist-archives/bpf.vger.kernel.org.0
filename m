Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288196F1055
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 04:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjD1Cas (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 22:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjD1Car (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 22:30:47 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F055268D
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 19:30:46 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-760f4dcfdf4so769712039f.2
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1682649045; x=1685241045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rpaz0eJGJA5l8Hon6/RpUnLq37qiZp4zEqr73e46w4k=;
        b=ZGmV/XK3HqFILNx1rd2+a24aRSkn+Cev7UR/qv6mGbtlpCk6YJuDtKpeLlkSFlEAip
         rJ1fkjZfaivxBMf3gYWaSuwORl9E6FBg9aBOAnd++c+BWwV1XHy6Nd3TNcDDhk17eKmP
         L8eDy6+a6+O6Dy8BdI2W4R2c+Ku+kQ2dC1ofMhnI+jVSUE3/qYlDEw0Ydd5MhBYl4NQR
         E8krH0lbGt5REXozvrXJqwa8teBl/y2nO9VFM0l/LDVReCMstOOHblvOm5KiNPupvVD5
         dwDXzWGUt/xoTIqaHoE8ZeY28UF+JfJgNtzpqFTMLucul+WXK6ZrKUxBZXu/yRubACyP
         et8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682649045; x=1685241045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rpaz0eJGJA5l8Hon6/RpUnLq37qiZp4zEqr73e46w4k=;
        b=YnWRTDstyKYO9uiQOXG2jloEXHkDdmaiP7sJ38zO/EtOdlcqbLAEeRM6mB/o8vFNCX
         btZx2cw79FZSeBny0RVd5eetelRQur5YCzISvDclhTRd7vHZTt+1JBDiku44AraI+nRK
         NwyodmeUumAm+VSw+lomyv363RzKGhlGYnpPZ0YCbNZWTTfIyQ0/ysIFAFaEeP2FOJ4t
         Yk8+NVibRFHJhRZU7n2rWPt+JOX1i8VQUFHWDDFILcTj/A2I6COr+1tWPsrCeRWyryB9
         sHIm19rxYXVVuKSRBj2Z3u1siAOTdGo2Ro3hhj22I/OIvRok37uG1/5c0esx9lc4Vl5U
         iT8A==
X-Gm-Message-State: AC+VfDyoUjk/Hme2OqzmKo+UnqzY7zpwyPxZYiGdkXUkMMYJC2+6TWqo
        DyEp6y9pG8VvTR16iUGpNN41K3JbsCF25B4J2/Q=
X-Google-Smtp-Source: ACHHUZ7QYRR52QqItGJnTRwQrn94KD9t4kkZi2UDafojAEafpq2aTQYfLYOG5GN/sfQUH8NjboTRvg==
X-Received: by 2002:a6b:d208:0:b0:763:d695:dc66 with SMTP id q8-20020a6bd208000000b00763d695dc66mr2606660iob.17.1682649045209;
        Thu, 27 Apr 2023 19:30:45 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id x20-20020a6bda14000000b007635e44126bsm5486259iob.53.2023.04.27.19.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 19:30:44 -0700 (PDT)
From:   Will Hawkins <hawkinsw@obs.cr>
To:     bpf@vger.kernel.org
Cc:     Will Hawkins <hawkinsw@obs.cr>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 0/1] bpf, docs: Update llvm_relocs.rst with typo fixes
Date:   Thu, 27 Apr 2023 22:30:14 -0400
Message-Id: <20230428023015.1698072-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you all for donating your valuable time to maintaining such an
incredible piece of technology. 

I found a few typos that I thought I could help correct while I was
reading the LLVM relocation documentation. I hope that they are helpful
to a future newcomer. 

I tried to follow all the best practices for submitting patches and hope
that I am taking the right steps. Please let me know what changes need
to be made.

Thanks again for your work!
Will

Will Hawkins (1):
  bpf, docs: Update llvm_relocs.rst with typo fixes

 Documentation/bpf/llvm_reloc.rst | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.39.2

