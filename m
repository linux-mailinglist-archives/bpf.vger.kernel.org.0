Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D422A3830
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 02:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgKCBFt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Nov 2020 20:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgKCBFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Nov 2020 20:05:49 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0A3C0617A6
        for <bpf@vger.kernel.org>; Mon,  2 Nov 2020 17:05:47 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id a4so13350883ybq.13
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2020 17:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KMgF+6D6y5x+lEyQkQDpvXsLydfEkrScLwogXfq76cQ=;
        b=tsLBVHVbEzvyoMizzE3nUoUovjr8nWiIC5gIqRgFbe3WlqQ+iLTevpVu+1Xo5rlsAP
         7YGJAsD9+d/hkbLSUk40sjpGoEzaLJuFO8jESMPvzy78wyT09eaYFiocHhwg5Ae24tzj
         AmSKDJn1/Me+ah9FETU3NmwnsNOrgXLlyiYmjsMV+iO13uejkbtkGMwMRLOFI1HZLAnc
         0Q4xur28TvT9EEBq8+PSvlxY3kyEIImn9nAr3Gje7hv3Syg+zLfy+8Mu5NRPPy5sIpAu
         NqOJtZLfVemW5l9fK9MEpRsXyjtUhPHEwnPmtfKiH1zH7AV9cvVLzr8vuhu3oo8147vy
         CWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KMgF+6D6y5x+lEyQkQDpvXsLydfEkrScLwogXfq76cQ=;
        b=IbgS7/pVdFjn0dB8kc+kGGBcrdrxtgGn2J3k+QZhPWjc82B6n57EFjW/a/Ng8lSZBb
         6/VaxhJfqn7PaM1hcJJpLDRgaCp1NtCXiKKhuiC8Np3z0Pwm/q2dn1EQ/RVh+n0OFsBp
         6lHDs3E+LLtq2dFZHU9i3tSv4L2BJBp4/8NgDH98HlelpayuUr3OHht+qUT3FG/ilVqR
         jahad0WrqeZ9Md+dYV3oHe/Mxv3R6rgaO6Afb+Syrf9DBviQH97eM+orOXZ7RiokKKjR
         WBVchhOFtJ5+yW9UO/jR8lcvSQp02a4d1KM1prUpp97AwWEeh2y41zTZhaKXcpkpIj8+
         1sLw==
X-Gm-Message-State: AOAM5326BGTuJ15ncou1/MC9NNl0DXCh0m7JCgBLxzmwrW5Gdt2BvcEt
        jnARKZkQ6RF161XoVzVs0me7oyPKirdjA9iKhH8=
X-Google-Smtp-Source: ABdhPJx9K2wYvKlHgCG05FcIiIU2NMb1Z0fO82AnDMZq87BbmzNuOiWM1tQJUWZRRAWAHBW6oojE42ZmvpneNSLHF8w=
X-Received: by 2002:a25:b0d:: with SMTP id 13mr25753675ybl.347.1604365546423;
 Mon, 02 Nov 2020 17:05:46 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 2 Nov 2020 17:05:35 -0800
Message-ID: <CAEf4Bzb3OThNBAMHfk6KGEgoiknLNZay1wRHWWo=5Pb2CY6dYA@mail.gmail.com>
Subject: potential NULL deref in xsk_socket__delete
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Magnus, Bjorn,

Coverity found ([0]) a potential issue with NULL deref in
xsk_socket__delete. Could you guys check and send a fix? Thanks!

  [0] https://scan3.coverity.com/reports.htm#v40547/p11903/fileInstanceId=43078192&defectInstanceId=10367821&mergedDefectId=298800

-- Andrii
