Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200AE557E88
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 17:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiFWPWn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 11:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiFWPWm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 11:22:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B088D3EF1A
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 08:22:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o16so28452021wra.4
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=JJmoq/ZADJvfUkTIPovwoxSHG0QChe7hCEODQxUM/Co=;
        b=h4c/iJiGDYLXiD6ONbffLtD9i1UnklYK0yUKooAgAq0MJBC3MC5olTYq1tZd5ZuwDy
         DV0SNcM1KTUhahC4vobMO5KOBHokLhd41DiKOv6KL5HKVD2azwqIsLFfEjXNWcx6U966
         zdC+LjBNl8GSOJvHohmhgH1cdtMP4zmftr2n5Hv0/s5DYA7jaWweSWTpdgzVn+m+CXyC
         Rmtw4ED2UhViXBInU9B3vCAhpVE1wQRbSC4drWG3xPEptxYICBDJ9XR4y/sP32dFGUS0
         n9qkFzgvIJEJq10OUAmZnQO/9DMVsSOHK0MyjVvKt4iNfDFJ3flRdvwsFu5XXNAXMumc
         y6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=JJmoq/ZADJvfUkTIPovwoxSHG0QChe7hCEODQxUM/Co=;
        b=QvfafRJewscnQvZ/usJu6G7L/JipTH05lgyEQ2A1h4bGavQdrz5w94Au0MM6+dCBcn
         WiD6Fv3404dE52Hg3TShjejWHdyvh3nQX//VyiFTv4LaLik3hXccOXC9CudjgR4u4Q1E
         BQ51xVSJyDJqDv61/5BO3YcyTHheo32GWhe6hkBXM6j3+mzOOH32FHVbpJSKYZ8VSgUa
         uxN5oqADMb4jQtaRXxK0l/p4qD96hnaayLVaAHG+UnzkvvqDda+S2oImiO49YLdyEquH
         5AGnulrnwbY9yGB68kbUYBp/L0BzQGt28X1xIZJZusznjKX3OjSTGx/Skk4yMz8IVy3f
         LFow==
X-Gm-Message-State: AJIora/M81zPO7h7KZYUovOW6DsddFBn7kFnEUY6RguFKRUntCBHzckI
        XqX3z/uMrE9XH78lOeTHHODxDW+Oan8=
X-Google-Smtp-Source: AGRyM1s4Ac1sbNHmSh8wePdnx/YPc3d+nno9ZefWrj4TOP2C8pKsQUvxVQReoriWOwx2PyRUK3ou/w==
X-Received: by 2002:a5d:6da8:0:b0:218:510a:be9f with SMTP id u8-20020a5d6da8000000b00218510abe9fmr8890295wrs.352.1655997760194;
        Thu, 23 Jun 2022 08:22:40 -0700 (PDT)
Received: from DESKTOP-DLIJ48C ([39.42.130.216])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b0039748be12dbsm3746014wmq.47.2022.06.23.08.22.39
        for <bpf@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2022 08:22:39 -0700 (PDT)
Message-ID: <62b4853f.1c69fb81.3baf3.6d0b@mx.google.com>
Date:   Thu, 23 Jun 2022 08:22:39 -0700 (PDT)
X-Google-Original-Date: 23 Jun 2022 11:22:41 -0400
MIME-Version: 1.0
From:   spencer.crosslandestimation@gmail.com
To:     bpf@vger.kernel.org
Subject: Quote To Bid
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,=0D=0A=0D=0AWe provide estimation & quantities takeoff service=
s. We are providing 98-100 accuracy in our estimates and take-off=
s. Please tell us if you need any estimating services regarding y=
our projects.=0D=0A=0D=0ASend over the plans and mention the exac=
t scope of work and shortly we will get back with a proposal on w=
hich our charges and turnaround time will be mentioned=0D=0A=0D=0A=
You may ask for sample estimates and take-offs. Thanks.=0D=0A=0D=0A=
Kind Regards=0D=0ASpencer Harrison=0D=0ACrossland Estimating, INC=
=20

