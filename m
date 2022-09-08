Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF425B128B
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 04:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiIHCfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 22:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIHCfW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 22:35:22 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C300B89CEA
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 19:35:20 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id o123so16903036vsc.3
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 19:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=KieW3drvXiTOLYA5jp0rEPB79hndueLow4c4JSecks8=;
        b=Jp4c0jixyEtoHNDhvMXYqNHFSyZAgnrukZQxO6tT3J40lyss3jF+R1b7H/vwQ8EicO
         Gkgzfs1CCn7/mAEzLmEYolm6GcLceLQr/ESmYkJhrRdhIkULu9csv4ts3JlO8CdniCo+
         QfnLTm5pguphFFJ57sSKGwIDUm+5tXgDBmaylMiewNSrJoNYQvauq7X5LgDYI6ZCMxBd
         mtsy/H+QxaaENOJsYoTVqV0dJMi6LO1qFMd7HOHfEINnkTKUhBDw7peXdkVxgiNRQDrc
         5ZSi3po30Kj3CnaETpdC4TxSu0uqmmoSapGNUiMoFk9VZbCc1LfXbV9MdiyUMgpXh1+s
         gfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=KieW3drvXiTOLYA5jp0rEPB79hndueLow4c4JSecks8=;
        b=2YSKXkuVqz+WsrqhOXvzovWvu3sN8o+9eAzvX1k4bxm78EfiI5deyMF3RYiiNnGbJV
         X1TytY6OFrSDqib24yXzKHB/6orDfiLzzgx1O857JxBpF+t+HjQ98s3u3rZrIo+abF5p
         /XUxTnmlNJ5nzkqVlRyemniRV+9AX6l6HxIR90bSL3o4TKVpg2zx+PU3cIKPPUiEcxDe
         HKXImms9M4z+OgNm4DjBQ6v1QZlku6E7a6NC7hrtdosk1IphWdpBH+KmQKYOTZ+khWjW
         Denwye1K84f0aH9xHAKivNyej2ZIRg2LpVBOFVyAU3YMu5y9rxFHoifCAUGOaTlpRuPf
         AiFg==
X-Gm-Message-State: ACgBeo2i4kTQ89ufUwGYTup8yiBCNf78G5YrYPC5KoOaSmeiiemRJmkK
        RWCkNEmHLUOUrlH9qpdGNvy0ExPRHl8kZjdBl59RhrkHPX1Rsg==
X-Google-Smtp-Source: AA6agR6LZ9OMtJCVND3xNCJhyaxLFup345SOOz2iJv+cY+ZISyG9A3NVooOyMNsCD8AhtOyidGLDNP9AgOQmDV/GU1g=
X-Received: by 2002:a05:6102:4413:b0:394:7850:c78f with SMTP id
 df19-20020a056102441300b003947850c78fmr2146988vsb.65.1662604519612; Wed, 07
 Sep 2022 19:35:19 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Wed, 7 Sep 2022 19:35:08 -0700
Message-ID: <CAK3+h2zZQ4zEB55Bn565Xf0okf+Jotmo6qHYmzpoJPBcFWPP0A@mail.gmail.com>
Subject: differentiate the verifier invalid mem access message error?
To:     bpf <bpf@vger.kernel.org>
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

Hi,

I see some verifier log examples with error like:

R4 invalid mem access 'inv'

It looks like invalid mem access errors occur in two places below,
does it make sense to make the error message slightly different so for
new eBPF programmers like me to tell the first invalid mem access is
maybe the memory is NULL? and the second invalid mem access is because
the register type does not match any valid memory pointer? or this
won't help identifying problems and don't bother ?

 4772         } else if (base_type(reg->type) == PTR_TO_MEM) {

 4773                 bool rdonly_mem = type_is_rdonly_mem(reg->type);

 4774

 4775                 if (type_may_be_null(reg->type)) {

 4776                         verbose(env, "R%d invalid mem access
'%s'\n", regno,

 4777                                 reg_type_str(env, reg->type));

 4778                         return -EACCES;

 4779                 }

and

 4924         } else {

 4925                 verbose(env, "R%d invalid mem access '%s'\n", regno,

 4926                         reg_type_str(env, reg->type));

 4927                 return -EACCES;

 4928         }
