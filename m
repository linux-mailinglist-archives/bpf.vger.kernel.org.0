Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916D94D3EEC
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 02:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiCJBsI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 20:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiCJBsH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 20:48:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36483FDFB4
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 17:47:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r10so5678211wrp.3
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 17:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=Vx6dd+ks4J5/gHkntPwv7PJmVhploogtKbTeNfHoC5Cui+t0byirTxsf2NI4qLMD7B
         hU29W/65j0tG0Q8gOjsrakgkRKbrGMjDsUdII+QfwucUal2NliB0BFybFkbTLNF6F0bY
         VZlSqcBFYAvFEoLt7Iudd928+MdgTQ2OgmcvbxXWm9dZ0c7wwEn0Ebxb5igHxZQ2wiQ/
         FyIeNlvy0t8xb7tKhmnMGdtwy9tyYbBo5H+ELTzwnMJLrF4f/j6ioa8aZr8ePRqTZJei
         4vzVU5yaSK58DF3sBRAROluL2evABTGRikZtWsnEw0YqmrFASIpGXE5ft/Kf1ynYVNAq
         3UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=h+fKb8/om8QW/HKh+nFUdb4rWB6YssLjFC1U2aXgK4Cv2d173th6ds0+u0blh4i1YR
         g6kDVsI7P82LBqWpmewr9GJQ/V9Z+L7VMmx4M8GUcTu3NgPvMM99h5B1pa+tIk2NP/c+
         uVKgVZZlImXGVD0vyMMWg0joA9IWkdwon1DLTsP4LmhOD+JLN4F5CxrpP62x4rXOfT1O
         vrMkylXEtRpOqoafoVnhTKZajCt29UJkoHOFFON1Bksq55SZMspOGKRrFvOJaA9VtP7i
         PV3wDBOIBpiNcs5d2BW2J0zfIlKXUN8huxnn/gwGUFrpc0gyeCZS9hF0vlN8zav8eNQd
         t1Gg==
X-Gm-Message-State: AOAM533E8ZuiyeNTnIU/FHDi4BlJgMhnHj4bAo1/5T/yYzHIgd6mcnCt
        IS5u4AAd72XsD57ckEMuAc5NlbJKZKrn+4UjAXo=
X-Google-Smtp-Source: ABdhPJwPVtyyNxOl/B09012G4cGrkj/s347xn4x4Wwly4ym0H4db4yLsV/8QKDxls2mMnP7nEjwi0ZRsxG7TtyTEjwo=
X-Received: by 2002:adf:f804:0:b0:1f0:326e:5e78 with SMTP id
 s4-20020adff804000000b001f0326e5e78mr1759665wrp.251.1646876826869; Wed, 09
 Mar 2022 17:47:06 -0800 (PST)
MIME-Version: 1.0
Sender: gb676779@gmail.com
Received: by 2002:a05:600c:4fcc:0:0:0:0 with HTTP; Wed, 9 Mar 2022 17:47:06
 -0800 (PST)
From:   "Mrs. Latifa Rassim Mohamad" <rassimlatifa400@gmail.com>
Date:   Wed, 9 Mar 2022 17:47:06 -0800
X-Google-Sender-Auth: hroB-J-_m63eRKtCqQsOhZ73WJw
Message-ID: <CAO9H84MLdwGdLW0spUTKH7+TsuoJ5LjGu-Ausbb=LrLfCcRjcg@mail.gmail.com>
Subject: Hello my beloved.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greetings dears,

Hello my dear Good evening from here this evening, how are you doing
today? My name is Mrs.  Latifa Rassim Mohamad from Saudi Arabia, I
have something very important and serious i will like to discuss with
you privately, so i hope this is your private email?

Mrs. Latifa Rassim Mohamad.
