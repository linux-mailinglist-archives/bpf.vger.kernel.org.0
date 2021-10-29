Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F134403ED
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 22:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJ2USe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 16:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhJ2USd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 16:18:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC6C061714
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 13:16:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ee16so29363954edb.10
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=4No1XCyCGsiw9xAW/GRRXowLAJaXLMQgdEe+LUff2rw=;
        b=DpBA17G0K46SyP2ag+MqE098//g4dWEi/oFZHD4AN9NnYvSYDLOftfnd/NXmYwT7L6
         thEVX2vGJ6Gg62MXzVZkOqbNeuP6mvbTlkYoTsYCzV/evqu0gUOXu1wiVoeJjMuwqaRG
         igb28p9e7k1x7z0hsuqhL0W0vRUO2iLd/XhOjm+fZ1iIFuVh0XolC6p+QXAeQsHu/Gdp
         TuIiK9gB2ue4yzxpCfRXylXQ/ikjD+Q/Uw5jqlErNV5Aup+D7aIz6ctIZqRlzfz8Qsni
         bSNqTiPWJqp5R63My6zomelty6gQdcCPn7fov19IRtbhyO7pA2NwP5erLsj+FmrYc0wm
         ek6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=4No1XCyCGsiw9xAW/GRRXowLAJaXLMQgdEe+LUff2rw=;
        b=ixnzJAfU6w534taQ4JmkCmE0NmZPl3hMbvTV+N0a7phoFu0rCp1Pzq4o8e2Fp/rUR/
         Q0eYbbWfLRCxvY7H9wN3QzlSvfbm4wE6FUo1IDbwyhX1nD+C07UgzJ4fgMBskJm0bbHy
         kUPz2raZmqynp3Y/LCfDESH8LLieoAUqvE+sUOHgLbGCAG7GK7I8Qzt1GJcYNrC4dH9j
         gb4exSn8dA15FWdE1oW+YHKppGLUyVMgfymzH+e3SY73BDBNOhSqKTTTor6lKphpxcVb
         pRAVEixrWEd8zkDwmp2U8G7/UxpV9OTYaCHzp9MSuCGsj50/eqo1I1NwWbktUewyEHOc
         OELw==
X-Gm-Message-State: AOAM533SD5ggLwE8cpV1S/hd1mV9xfA5h6FDCiwgBTmYJZfvKRYqveLe
        Br39rPiNSivfX4p53WI+r4AA4fmZEReOD+4rufg=
X-Google-Smtp-Source: ABdhPJwxCuY9+DgNZYRpE6j1I73MpeqggWUMScQIy2WaqL3VaCYk6VM5DPSkm3VqmzgHYy2k/bgm4+fxZn1mCzB5GYI=
X-Received: by 2002:a05:6402:27d3:: with SMTP id c19mr17829012ede.70.1635538563020;
 Fri, 29 Oct 2021 13:16:03 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieuapekou@gmail.com
Received: by 2002:a17:907:7fa4:0:0:0:0 with HTTP; Fri, 29 Oct 2021 13:16:02
 -0700 (PDT)
In-Reply-To: <CAANH6z4xRd8Z7WU-2O8MSBbOOaHbm1RhdPcidxACEb6uBrjuTA@mail.gmail.com>
References: <CAANH6z72gAZmNJCfRRkL5Ny74zCi+V_aRF7Tpc_AphtrRJJnKA@mail.gmail.com>
 <CAANH6z5XWmG5B_qEumUkMO9-TxQ=f5OCEnrHxMUr5pC=maxBMA@mail.gmail.com>
 <CAANH6z6MJLz+V_su+V0bH=JcQ2+wxfi6+-kpf0vofkGRo1WTng@mail.gmail.com>
 <CAANH6z69LdxStuZXzteKEzN-Gv9cKkgxaVZ96HeJmSd9V-YVJg@mail.gmail.com>
 <CAANH6z64xPoEYM4ghbWARGWJE8uH+PQgGthx1f20tEBjBrD-ig@mail.gmail.com>
 <CAANH6z742pjV0ap9m-vu4npC4BYoRQu6xOW+m9Ypp7KLNtJz8A@mail.gmail.com>
 <CAANH6z4mydtHjB8OfhkBuxXuARqNqfaGRgLYn13tbUSKtgXBhQ@mail.gmail.com>
 <CAANH6z4rQgp5vtz7jQop8qZDAsUgpdF8XLP4hW2ASfa=KhjkoQ@mail.gmail.com>
 <CAANH6z7JuidGvHkqgXveWvAZAGwsgVoWDcuMQqx-L40t-P4gbQ@mail.gmail.com>
 <CAANH6z56Quc8b=SgVSTQC_wTOOih2sv1e8uHspjexeqqOu1UeA@mail.gmail.com>
 <CAANH6z5dNBBgGsX1CDJkHhqqHquNSJmJNOD1nBwhkZoahiaW4Q@mail.gmail.com> <CAANH6z4xRd8Z7WU-2O8MSBbOOaHbm1RhdPcidxACEb6uBrjuTA@mail.gmail.com>
From:   "Mrs. Rose Guzman Donna" <ebubedikemplc@gmail.com>
Date:   Fri, 29 Oct 2021 20:16:02 +0000
X-Google-Sender-Auth: mKkr03HbIIMYKUxoimBm_y4ZmVU
Message-ID: <CAANH6z5846-z8cNS0YC=FjDR=4HinnAypa89tk7UBGFx4N3OkQ@mail.gmail.com>
Subject: Fwd: I'm Mrs.Guzman Donna from America
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I am contacting you because, I want to donate a huge amount of money
to help the  poor people ETC / covid19 victims and to open a charity
foundation on your behalf in your country is OK?. This involves a lot
of money Get back to me for more details. R Guzman from America.
