Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1174560109
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 15:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiF2NN0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiF2NNZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 09:13:25 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D33715714
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 06:13:25 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id h26so7451914vkc.2
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 06:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zwr+gvqINn5s/ZV6IyRPgfhaWD9WdQkp9Eb4Seu1lr8=;
        b=l6YDHleXUxTieS001JUjLo1OssAxr7rZXUGkTk+z1p1+5KvquGnEgllkG6K2wdqv58
         B34JxxJySGJekntBF9LeQPlwFPD1OVlbLHiogN6SwiYYB0iTckbWq8qQWFnx0ClBo0PH
         wVyLp1n/vuoXtbXXfGhetGo14K9fVZpfD1b2lBTkwoiuiPisVQcnd9eHf5D2s6FaLVd5
         SeBLjnlG19ATpeQg21M5xmKDMSQILp7++YTG02ayPEOnqVPeEQ2vkS646a2xJLQl5Z6l
         ZBh9EOEBjPSYfEmBjEc176eXaNOGg+pcvJvdDLHG3k8Q9ssu2z70CtrVRhxu5HcCGQ8+
         gLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zwr+gvqINn5s/ZV6IyRPgfhaWD9WdQkp9Eb4Seu1lr8=;
        b=Xew2Pb4sh7b1rukThoUxxBheR2/5CZgh3dTVW8uHHQPbFHa8oRdyPP2ZzEPVU9qSnF
         PlMj30dmhn4axNVukGtRRb/HvQGNKr6pgVIhH1UNln70qS7eFWFAX/KeDB1wG/WU9YUm
         udyTJ4yskgp6yNvg+ilrUz0w3pa8ke7kgm4wsgXh/WX9CQDD0QhIvGd61dKrQg9+DFVJ
         PL1tzllE84yHVLVp+iFS3dMZU152tCiuWevLEadcPcnWybJA/vKG3lrYzcmCl5XJHwbU
         AnIlWypvfl32dc/AvfC1F8hpVNGwlw0wpQwXqgh0MNu/FAROi4iXulaiV6pJi1cdQIjw
         HZYw==
X-Gm-Message-State: AJIora/1byYyNG0B4M5WVpHCMnnnP9yrpTwrn9zqiBicUiI90U3W94y2
        0kdQH/0E4f0xTAwQTZxYIn0Pw2rJGBMxcmE8Oss=
X-Google-Smtp-Source: AGRyM1uuaB3Bq5KRjd0AWHP4p8MOlZ76Fk+LFkH2b93Bii+UHvyzCATjdDMNSvXeJUhodEt8gm7hYpJymSYM0157zTE=
X-Received: by 2002:a05:6122:485:b0:36b:f9d7:5305 with SMTP id
 o5-20020a056122048500b0036bf9d75305mr4486894vkn.39.1656508404230; Wed, 29 Jun
 2022 06:13:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6d8f:0:0:0:0:0 with HTTP; Wed, 29 Jun 2022 06:13:23
 -0700 (PDT)
Reply-To: dravasmit09@yahoo.com
From:   Dr Ava Smith <missmichelkzongo01@gmail.com>
Date:   Wed, 29 Jun 2022 13:13:23 +0000
Message-ID: <CAEzZF595RAN6aA7a1SFcJNkP2i-ezXXf2H_mSfKgJvhRm-7bWg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
