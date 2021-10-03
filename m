Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73163420936
	for <lists+bpf@lfdr.de>; Mon,  4 Oct 2021 12:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhJDKRv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Oct 2021 06:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhJDKRv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Oct 2021 06:17:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F11FC061745
        for <bpf@vger.kernel.org>; Mon,  4 Oct 2021 03:16:02 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j27so13056795wms.0
        for <bpf@vger.kernel.org>; Mon, 04 Oct 2021 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=wlLcvdzFoeyeX6JTHYlU53G5ryTrrQ22juicajJlTfk=;
        b=RBsctk4w1xO6Z2ryQAxJ79l7zKoMaDEOJxcBFFRYe2iPdB+7eQYWzxPjIfidWFBcUc
         HD/vJBf3JNy9kfArysqlO1GQCgU3jLpUKXtxOcLAd391IxFyIHfTfHy6hUXMDi4/w8T/
         TSqDx/+yn/5goNHz3xr5vvzN+fVCID4nID94oX84G54dSP+5xfI1OCcWaFjvfd4I3OEJ
         akTEcxhKG5ytxflIrehAmgS1A6DyCWqwuLt6daNtHJEEK4+qDawdpMwgKpIjJEl+K07e
         xKS/DafaVuULEu7vk0jHWRxClKftDfbUWUK4NUOzRn62AD1i/hMrzPQdZpjQLAQ6NV+Q
         zTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=wlLcvdzFoeyeX6JTHYlU53G5ryTrrQ22juicajJlTfk=;
        b=nG+QwExjVeYkuZOQDP6YektIAzCGlztBUGU2qvtZlogLihbDp4l9XJaXkPcSII1EbM
         8iX5TZ+D35j48wvPhHK8F1rXyiv7e8+u/HZUoWxbuLtYQEik8iAmqJGG+8QNDTLiD8lV
         /99Pc41IzT3sZS7BJCJCwvNFLQ4yEH0Bn4Ndvxa6ogXIOOSyyru9aX2BpZRjBi4XIAyQ
         SCYDwDTIBo6TohETUB7eb04YCP+Xd4IPcLWyiU3IEj6utmM8x6QZ/Oaea2tj0EzfWn/j
         88gUk7r/zaTA7VwOgK4fHEUnbWW27ztC+RreUeVD9uLahjLIPUOAMBpMkgXWmGwFpCvj
         4tdA==
X-Gm-Message-State: AOAM532RWDvgEVKoWAWhpmZ8f5pO5+TfxxlUZwZHEy0VwzghYRdQqVrx
        awI6m3/3VXarCPW+kl+Zaw4=
X-Google-Smtp-Source: ABdhPJxyX8ypzK6Bjr0d0pbbLFM+mqZhalPOiyxImZxspR7wti/MhiL46z0OeuT3Wlh9GwzD90y/hg==
X-Received: by 2002:a05:600c:3784:: with SMTP id o4mr18071304wmr.180.1633342561175;
        Mon, 04 Oct 2021 03:16:01 -0700 (PDT)
Received: from [192.168.43.138] ([105.112.156.79])
        by smtp.gmail.com with ESMTPSA id h3sm7015520wro.42.2021.10.04.03.15.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 04 Oct 2021 03:15:58 -0700 (PDT)
Message-ID: <615ad45e.1c69fb81.e825b.d954@mx.google.com>
Sender: "Gen.Bella Lagan" <mrssabahibrahim11@gmail.com>
From:   Mrs Sabah Ibrahim <absa50602@gmail.com>
X-Google-Original-From: "Mrs Sabah Ibrahim" <sa2020bah1@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Dear Beloved,
To:     Recipients <sa2020bah1@gmail.com>
Date:   Sun, 03 Oct 2021 10:15:50 -0700
Reply-To: mrssabah51b@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear Beloved,

How are you doing, hope all is well? Please I am verifying if your
email is still working, I have sent you several messages, but could
not get any reply from you, would you get back to me? I have an
important message for you.

Please write me through my private email for more clarification:
mrs2018sabahibrahim@gmail.com

Warm Regards,
Sabah.
