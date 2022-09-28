Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BD75EE987
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 00:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiI1Wkq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 18:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiI1Wkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 18:40:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC6D106F73
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:40:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b24so15844393ljk.6
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=7yNsdm8zWt7iBaGclb8SHUjFgCbXXKTqGasNTGsbCNI=;
        b=gRx5iDxyfyCRPZ/fT/BGyDpMCtiI6b820OnrVDKe0//jd6zX/CnoJzptXFDnTrJ73K
         1w2mxYP8i0LIL9h33OnlqJvk28AhXLp1mSJiJgW8WX3d/G3n18dG1Za3KJC+VYrJ0cjf
         vWVRfEZf+Dbn6r2gg7eqs+iD6mxZRo90QRxPvwD4cvDOtCwNKE0s23jUKbwu1d8SmIzz
         DIR3SoM0pnSVzHTEHfksBFvyRlhOs7yiU6qpju8iXcOqwNQP5KnJClHXsB7hzBAbh5Kq
         a0GHnP/WHhrp3UWykTQyuxRly48wn/yCGMwKUOY2NL5/fjhqZR2e88GbJea3J+2Z9uzh
         Fq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7yNsdm8zWt7iBaGclb8SHUjFgCbXXKTqGasNTGsbCNI=;
        b=IWHR2GQN1Pzpg9vDEoFSHa8F4e2GTy4Xr1KkDUELUSB1A3uNkwtcMb0YF7D67X67yz
         ArDM0MYZmcKLQGpl8ZxVrE6YSSUIycIavq67dDo1Jh6eYHlpz8rQ7yCvfjKG3kTGaxkK
         PpnAvu7fci54tGs2L4PQSvTf+TICTMAbzTPy4QbOhEuDZGM+ksPAJbjtyIh8Bbti4AIm
         9SkaqJ06oznt3OMzJqnR5CpiHSoPIECWBwpTWauBZdDpR10dv/FIojgCNEBGygYh8BiZ
         9FqYE1pkiVWWGZlOxqfgwRuTtAiY+9tb7505vckSUakcqgJp4tTTqWe3gGf9DYxGfKlV
         63ug==
X-Gm-Message-State: ACrzQf0lNpmOBnBWIgniPohUJt4wGiruFKCLuiia9xtjdhVJPf0BL/mn
        Dbp/vIIvpInHSYp1LcSVFw5c8xpQtL89HX7RcMQ=
X-Google-Smtp-Source: AMsMyM7Bzw/kjTY3WwXH4i/crZBWid/T6BkfhYYaiIjpl1BEyiBWRGtH8uEtd+t7Jac1+/6OZcsnZect33k0EUOd4mw=
X-Received: by 2002:a2e:908a:0:b0:26b:fd3:1870 with SMTP id
 l10-20020a2e908a000000b0026b0fd31870mr28130ljg.120.1664404842804; Wed, 28 Sep
 2022 15:40:42 -0700 (PDT)
MIME-Version: 1.0
Sender: bazarkowanigeria@gmail.com
Received: by 2002:a05:6520:266f:b0:223:a226:45d6 with HTTP; Wed, 28 Sep 2022
 15:40:39 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher001@gmail.com>
Date:   Wed, 28 Sep 2022 15:40:39 -0700
X-Google-Sender-Auth: tD3xNvzm075-AmH0hoiLsff2ino
Message-ID: <CAPgaJa2W0WofoAGehN_DuqRgZ_mgSnM7LMwnOsuUzFKaxBsvPw@mail.gmail.com>
Subject: Humanitarian Project For Less Privileged.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
Hello Dear

  Am a dying woman here in the hospital, i was diagnose as a
Coronavirus patient over 2 months ago. I am A business woman who is
dealing with Gold Exportation, I Am 59 year old from USA California i
have a charitable and unfufilling  project that am about to handover
to you, if you are interested to know more about this project please reply me.

Margaret
