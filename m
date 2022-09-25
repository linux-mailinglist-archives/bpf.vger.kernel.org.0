Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346735E91BF
	for <lists+bpf@lfdr.de>; Sun, 25 Sep 2022 11:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiIYJCL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Sep 2022 05:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiIYJCK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Sep 2022 05:02:10 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCB632D97
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 02:02:01 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-346cd4c3d7aso40849507b3.8
        for <bpf@vger.kernel.org>; Sun, 25 Sep 2022 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=+/h6Ny4B0orFS+QPdHRzrwIuDeGFma3Ea38XXUXAQkU=;
        b=S6IRm+qHLXh2dfCDbsWQ4PNmbUKrS9334azhzKlIOYI8RC6IS2UgeRzwV7pQmyqKag
         Sk+k3ZzADHbseFjOFvoErPrZ5YK6ZJS3bvZ5tv1y9C8mCNVcR14wB0cynBK4rGI5HrYD
         ZkUZa6tjeuDal73suPm9KzhmdrUYqa/ZPnlKxp4JguQDQp5s2pcSOErcICfAktVdgfkH
         ZXswEvXvTdfN5ChW5nxFJSQ+qA5fzOjy49/8XnH8PsDW+7ixzHphecMyW1xOb9DwGEPC
         2f37Yt8BJaR8zXwQybO8DS4yasJKQAuVIf0nG4JctejGoUlpdwxvdH1fejfYhwP9ciTn
         K5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+/h6Ny4B0orFS+QPdHRzrwIuDeGFma3Ea38XXUXAQkU=;
        b=Njcqswg8z44v/jm0rPPiH5FJBSArTsFTde5sC1lR5RfAuNJs1g/HlxdwCprmPPYaKT
         lcAczIT8oz1uLP+9pZxQUJ3Ut14YjQ2o4e2Ubq6g6CkGrN8W43spu1lLjk8N7SCicw91
         4zH3FdPqMHYFEbbInvWNEuvlw/6gK3kokTKiGg8X7jZv5F2TGdqab2X8BQd8Mx5IFjOM
         gxe0rVRvCgvyMG7B9U+CbemVgjL4E6WGJTHpTB4zY+fofroUCu9oZROhzK5NpTMIo1vx
         +AOhy3U2hw0TpTsNYLueQsV4n1soHbRt8QsqtQrvUssuxcfDwC0L7k97xvNNfrYX6aoo
         YrhQ==
X-Gm-Message-State: ACrzQf1fkI6Zmj3mzfdeB9XyGkCFh9vzazvDey/nz1FE5rQksB509Q/i
        /aeh7+kqwrMRe1vWKn52r8SGB45XE0wazUkmYgQ=
X-Google-Smtp-Source: AMsMyM7x113ffLYzkaMm3ncpK/yL+zKoXTtObNp9jF+lVvAaCZcbAJYD1WQl8q1tlOE8dUJau/VA8mcBRDzTvQnt5As=
X-Received: by 2002:a81:5455:0:b0:350:6625:437d with SMTP id
 i82-20020a815455000000b003506625437dmr9251444ywb.326.1664096520868; Sun, 25
 Sep 2022 02:02:00 -0700 (PDT)
MIME-Version: 1.0
Sender: innocentyakububawa@gmail.com
Received: by 2002:a05:7108:4383:0:0:0:0 with HTTP; Sun, 25 Sep 2022 02:02:00
 -0700 (PDT)
From:   "Mrs. Margaret Christopher" <mrsmargaretchristopher01@gmail.com>
Date:   Sun, 25 Sep 2022 02:02:00 -0700
X-Google-Sender-Auth: YlGPKMVIIWDwOOK6vA7JUBkFWRs
Message-ID: <CAO=JbK01t-cac_KDuKut4=W=mhVZgYFg-9qRAK51h1QTC9-k=A@mail.gmail.com>
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

 Hope to hear from you

Margaret
