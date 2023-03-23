Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341BA6C6CEA
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 17:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCWQHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 12:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCWQHF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 12:07:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F0630281
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 09:06:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y15so28466119lfa.7
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679587618;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYR+TcNAb57HIBY+DJdHPWQ48HOpkEZ/ZRHsSFux8M4=;
        b=pkBMD4hEQmSQ0/LvOiWX33O5wgdTWwDWdpCnCKn0roTf92+3OFs+E1/HdnIGaux2uA
         6A0sJtbSlquw9RvAtwGZ7JaKjSEDaS4LEeLAGcNzYbOIgq/T069plkuckpQ1sIAMsvuG
         gHaURVrM1yb6Cls8k+NWFORvRhewBQ/0XKgnyf2raQmuAzBn+dqeieTUT4zPOTaHGgk1
         BEH3IWKUe6Z71mUM2d4FIg9bcDELTWej98gmATf8Ur/v/6cH7My/eRfLGEIVpG/Dg6Cx
         xFK5JtSqllmr0fHEl79pTm0VLgMVhkhzUaq8RgtxH28XQEmKyCq4ie4bwPghLaUu9WD/
         xWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679587618;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYR+TcNAb57HIBY+DJdHPWQ48HOpkEZ/ZRHsSFux8M4=;
        b=Oay/FTy4RiGR5PM1w1xAoOi0Jai8Wttmk4Sc58TLRrAwn/PQ1VKPEB+/p7Cj9fftyN
         l4I8wDCLMwPskWOYpU+svvEqMFxwIxt3UnaiEO1xqrNw3xIJq1NzK2yIutSsfV4UIz8U
         k6gFNU23yu/Jqu/0+ClvvvXCJ7PP0jXjkUQROf2HKJGyuu4/7zSVm+TLnRGvc/SV96w1
         9xJW5OoHug4xg71H9e1iq8KxX51YQNA9NFD5kIRdJYWnF/s5owIx3FisPqVJtR3yqLSQ
         Gf7filMg1XqyEa9borcVDbQKgUj6OpAVIUF3OZ2LYVqDyXJV/b/ZymRBMFB+eZ1M/qTU
         V+Dg==
X-Gm-Message-State: AO0yUKUsrAw0zgAl/+Lai/6U7hQF+hrT+xvIpW9UpA+OL92nmxFptX0e
        FRkDqE8swNelv/XDrQkVt6B9aq3BCu0aLpWDoxY=
X-Google-Smtp-Source: AK7set939CwReN70zlzui9h1DTprbKCKUUL3aMBkYQ3IebBXwio8JmGLCj4sfawRTviyJEyeIWu4Lwixm5ZKn2hn/58=
X-Received: by 2002:ac2:5224:0:b0:4e9:74fe:91b8 with SMTP id
 i4-20020ac25224000000b004e974fe91b8mr3320009lfl.6.1679587617811; Thu, 23 Mar
 2023 09:06:57 -0700 (PDT)
MIME-Version: 1.0
Sender: ccollvuk@gmail.com
Received: by 2002:ab3:5408:0:b0:224:15fc:cad4 with HTTP; Thu, 23 Mar 2023
 09:06:57 -0700 (PDT)
From:   Mrs Aisha Al-Qaddafi <mrsaishag16@gmail.com>
Date:   Thu, 23 Mar 2023 16:06:57 +0000
X-Google-Sender-Auth: xbqVOBysxMmgJOVili1CScAd9tg
Message-ID: <CAGzvb1EBnZYyqJus-517EFAG1V1PFqkwnP+vd-hYZDXGRRy=Wg@mail.gmail.com>
Subject: Allah the Merciful,Peace be upon you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_HUNDRED,MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Please bear with me. I am writing this letter to you with tears and
sorrow from my heart.

I am sending this message to you from where i am now, Aisha Ghaddafi
is my name, I am presently living here,i am a Widow and single Mother
with three Children, the only biological Daughter of late Libyan
President (Late Colonel Muammar Ghaddafi) and presently I am under
political asylum protection by the government of this country.

I have funds worth $27.500.000.00 US Dollars "Twenty Seven Million
Five Hundred Thousand United State Dollars" which I want to entrust to
you for investment project assistance in your country.

Kindly reply urgently for more details.

Thanks

Yours Truly

Mrs Aisha
