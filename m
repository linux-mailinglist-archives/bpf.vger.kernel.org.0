Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533C9655E4E
	for <lists+bpf@lfdr.de>; Sun, 25 Dec 2022 22:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiLYVMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Dec 2022 16:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYVMI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Dec 2022 16:12:08 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E7638AB
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 13:12:06 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id p30so3385696vsr.1
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 13:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1DFvd/qB2iPwiRdxjvsshI/YDS4Nv+p2asGKuDLehw=;
        b=oK8Eh9B+yHOXfP1XHpB9rgLumw3z/CFDQ8ajs9HPJjpfGMi4yXdCoynUJZpehlVnEI
         dEpUAnHGp2J5BSynlWSIwlNGQwQYe0x50S3znVzZwiW7axV8oIA9XHpGJ/OBfbLwIYEc
         GRLxaw7kEqealA1izuTWJPPB93TgGMo5mGPSGrC4CAkldGJddqa+NybuBbvepPv3FQxm
         9dtQ3xKlqgNdtXZgMfCy2auB+ghqY9MIZ3e6S/9gRfiLghtHR+869TnYVEGuHgsI3XRN
         P9K/ypjqYMguB+Wu2BQmOiQP2iPP3yovnuquA4DXPqKR6UgLTpHECcgpJePiNceDnzNz
         7bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1DFvd/qB2iPwiRdxjvsshI/YDS4Nv+p2asGKuDLehw=;
        b=VhgwOV19rHDtNFR69jTHfsp/N0lNPC7NivT4pxhhRCiQSDthUwLG3DMrXsxDEfhgwZ
         i9kvasES3WEUMEXy1bpczddOu7KTkT6ZlrM6qou/s8fKBbki9gyBEgpDeg0VLxpGM3Jy
         AhQxqFNOhC2eNQW5AAs3HMWmS2celbnFdG4cphqhay1PwupeOecqxHFMa5H/uWFb4wmq
         xgjmgCUKyTqZxZbWcQ9kvAmCbFz0l+1aWzrduAat8XtPGWozqtyoznyW3kB2HZkrNv+a
         1mbOlM0YuNeVl8uE0VBHEyKZpbTVDMbbcVBtW48WPdLHTLaFWzAlNg5f1JoClohOpy9I
         v6xw==
X-Gm-Message-State: AFqh2kr8x36P6mEvbiZCsPFJWRtpOdvC1hMQgKAkKz7EyFSCQQlqvqwH
        FM63+JAMQdt6HYSTG60JJ6N2G7UAHoEbSzQhEis=
X-Google-Smtp-Source: AMrXdXtCKURN/TjvkcGOd8HhH1L3UPXbOH/MQkgIS+YSuvGibT/16D2SF/K68BJyUD9kYs/mXNl+N7kssaWy5mTVVk4=
X-Received: by 2002:a05:6102:19a:b0:3c5:796a:c2a1 with SMTP id
 r26-20020a056102019a00b003c5796ac2a1mr611486vsq.57.1672002725792; Sun, 25 Dec
 2022 13:12:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6122:134c:0:0:0:0 with HTTP; Sun, 25 Dec 2022 13:12:05
 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <nambiemagrang@gmail.com>
Date:   Sun, 25 Dec 2022 21:12:05 +0000
Message-ID: <CACrRiTEExGfppTBSTL4nHVQeUAUtt1qP+8HQDA3HxJ5PDhW1rQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Good Day Dearest,

 I am Mrs. Thaj Xoa from Vietnam, I Have an important message I want
to tell you please reply back for more details.

Regards
Mrs. Thaj xoa
