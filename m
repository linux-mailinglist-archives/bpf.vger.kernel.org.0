Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6C4DE81C
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 14:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbiCSNLE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 09:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbiCSNLE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 09:11:04 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF73F6E2AB
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 06:09:40 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k25so12121542iok.8
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=H2YfWCG0balrUsjNebe6NPqLv9wl/pqUnfwIaMT7BYE=;
        b=m8C6d6pgrigIff0d6/IXmT9/20kmJ5/0P6omsiLamYGdL7Xc8cOQitXuqqogoQdBM9
         Z8kmG/cryjHnsx8U/Ca785x9oriNwUAAPSnCW/wqygfj7upX8jSw1UeIzcyg/HdyH8O7
         +rxEIo8qijwpkLqiWo9IbGBRcJr2aaD9E9CsPdCjhR/Kod7uSJHvEB1M9JmjeApJGbTE
         phWbV2fu2A7AlurONKd0N23CFuHXRraDiil1XcDVtelumTlnuFY3LKH124wrNcFXEjig
         MtjwX0l0H080++lId416o5sQmhN5hhay7E93FhXEq6IUOZNd61M8h/NQb3jUSOQj15YH
         0nmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=H2YfWCG0balrUsjNebe6NPqLv9wl/pqUnfwIaMT7BYE=;
        b=PFvXvNyRruHaFA/mAROpeVihduEiaQh8YApUwvon5MQjHNe7nWR1XrRPz8GzwDdVLe
         uIN55SPKHyrPkuLp6vRqkpgWv2lrhpS51/MpA0Ett8nFdxDVx94y9N9yGt7bsvptKNjz
         K+66n3IduYPoDeKl0V5RZIfNSzJM0d5aRseR2H2t1ohst1QZKa/tbRvQT++7EtPSdyqK
         C3hMNt6TeymicHWSnXHd49T9ljDQzzUN8ppgECoBGsWsJe5LbUxaXe6md7gDkCzQ75EJ
         S9JxiGhFSFbUj9xMbjZAmda8Rs/S6vI3kV8vMrAkKcEWUTUVpEx9qB7g12guyE6ABFsS
         KJaw==
X-Gm-Message-State: AOAM533fLSpfbMtrUgY+m7UJNrFPfisQns2ireulwgxsn/vSoqJDKmBU
        SprREE25woswuG+yZz+ic0LtNauWmrHAYC5PFvs=
X-Google-Smtp-Source: ABdhPJwiQrwTrIDsRune45ddQKTcQu1nHnm9jmBZDPbLs6WnF6AJ5oUreXwneWER6HFjEVn1Joes4BR99lGm0bjC8YM=
X-Received: by 2002:a05:6638:b1a:b0:311:4aa1:6c36 with SMTP id
 a26-20020a0566380b1a00b003114aa16c36mr7303235jab.281.1647695380177; Sat, 19
 Mar 2022 06:09:40 -0700 (PDT)
MIME-Version: 1.0
Sender: esaeunice42@gmail.com
Received: by 2002:a05:6e02:1906:0:0:0:0 with HTTP; Sat, 19 Mar 2022 06:09:39
 -0700 (PDT)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Sat, 19 Mar 2022 13:09:39 +0000
X-Google-Sender-Auth: sFflAZpE5yHrc6JhfLbVtBpO6qg
Message-ID: <CABuF3V4tzPqU1J+NLDwPvoG_7yZnd6VxAUYRrCS7zYjWz_-8LA@mail.gmail.com>
Subject: My name is Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hi Dear,

My name is Lisa  Williams, I am from the United States of America, Its
my pleasure to contact you for new and special friendship, I will be
glad to see your reply for us to know each other better.

Yours
Lisa
