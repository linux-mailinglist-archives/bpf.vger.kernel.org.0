Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C03E7F2E
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 19:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhHJRhl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Aug 2021 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbhHJRgE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Aug 2021 13:36:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33DEC06179A
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 10:33:36 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u13so30300191lje.5
        for <bpf@vger.kernel.org>; Tue, 10 Aug 2021 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=y3BZ+wT7TMDVjM2/WQcyPOhYkG/NWjvDbJIsMqFI2RA=;
        b=BggyEzSIpVznrhWTl8MIRAYEe15KlTxcMGseAQSFa7RDeDzVHxU4eSoETbmExnaLIE
         zuq8OYsbcAC4TRTZpDVHuqOpZQ9IWzoDnFG9KE9Hgoh5GHNRpLrX7GaTa2Rlpi17Sa+7
         wynv7o5vGtXcABH0YLjEMHBgYbVN4gwCCmMbmqM96vylTsH+XuSJQxB2T0aZ0px1WpyQ
         RfAqEbEJWHwau3sZBSpHTPqcKq0lEWF+TZfP6Hoo/gEZtnmpQsbvRYpoOVsYPdrPzr7x
         t3j+1ErMjanfyKX6UgQnU/AAqtfTm/Qksyzzn7HfgMwEBK6s4oZtKRsuVtciK72GKLQ3
         6YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=y3BZ+wT7TMDVjM2/WQcyPOhYkG/NWjvDbJIsMqFI2RA=;
        b=lU4eRc55n19OI9QjV7zyqsB0xAjkFSqi9+UPJz/1Dgv1546Xz/La7/0/zsfrTjAVOL
         ENE70Nw2jjXiXzQuZuAdGBFsDS4zZ/PIlYRrH/eu4gVmqKhfCZfqDfoQANlwtRgsDLRU
         qoeRijDEF+VIQofSHcB+5Hnnx+5m6URidusC3SXlVokaI5aDZmAcIc4HmEVi/KKfHI9i
         e/A2fl22cEpDv4+4D+HvDIpqVy2RfA/GLjYEr33dojPk+nREw3PTmCm0bFa2zRmvZCHG
         LdaUFordUKxWHiYQGOcRgdK1npHxsIbqLRbk3hydjlKBLCCmyi7RbNCTdgX6mzZnZjZ5
         B1sw==
X-Gm-Message-State: AOAM531a3uJZq2tOgQV1ecTOCZ001e0IRkQJkWQpX9wgT1L/KG8D8GuG
        4lmOCh1Mig/r0q2J4aeFucrSd+xeodtaLQZLWng=
X-Google-Smtp-Source: ABdhPJxJzT1Kb5atT5yD66iaERNxaunOV6XJPdXL1z2OXUo9BKjwXZsRFKaZJQfJZWzQJ7vPYlv2A2MhcLNWOaJIEsQ=
X-Received: by 2002:a2e:b61c:: with SMTP id r28mr13615658ljn.274.1628616814996;
 Tue, 10 Aug 2021 10:33:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac2:5d2e:0:0:0:0:0 with HTTP; Tue, 10 Aug 2021 10:33:33
 -0700 (PDT)
Reply-To: majidmuzaffar8@gmail.com
From:   Majid Muzaffar <ing.abdullabin.rishid.me@gmail.com>
Date:   Tue, 10 Aug 2021 20:33:33 +0300
Message-ID: <CAFsu49W_3bbJbgEKV5RQo3TBRgLduTA-4EwS7hHkwcfSHSRrcg@mail.gmail.com>
Subject: Proposal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Salam alaikum,

I am the investment officer of UAE based investment company who are
ready to fund projects outside UAE, in the form of debt finance. We
grant loan to both Corporate and private entities at a low interest
rate of 3% ROI per annum. The terms are very flexible and interesting.
Kindly revert back if you have projects that needs funding for further
discussion and negotiation.

Thanks

investment officer
