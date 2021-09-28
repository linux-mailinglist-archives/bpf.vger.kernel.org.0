Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D5A41B131
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbhI1NyI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 09:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbhI1NyI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 09:54:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52701C061604
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 06:52:29 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so2886191pjb.1
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=xQrYULKok+hL+AIRGJuG9CojAZcnV9Xr+it7yxQJVlY=;
        b=e/iW6KcfM0KbgIKF5krnXLnWxn8t7nonMeuCYGP6IEtLXBTHT5R38wXii8sDxDzOrV
         wg5cfFVJZUp5igwbYLnMtkz3u84IVmOSfJP3Duv9s8T1t3NyMxXAD0bUVx94rP6GmfwE
         A3fw1ktYHUhjvUfgk8Mm21Uwnoc6yXAEIHLhyoOC2PloNa37QjlKnmYhUYlceX3dme5B
         JwKylAu6Nb6fXmgRGqM7deP+mRSpNyBNVRmyuCsS8QkSqrnjTecF2ukrlNFf7yYcOD5+
         E7sKESKEolyEKyqE67Bw/UOWQpwK8fRGaerokaDSrWMd1i6ROOBlIVuu7BtyfsvKAHwu
         xvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=xQrYULKok+hL+AIRGJuG9CojAZcnV9Xr+it7yxQJVlY=;
        b=4t1wp00S8EqYJWXy5pNcWIigmwHAkYAhUwjfgRom9tThNo+4h7M0TsfHZOfUQSQYxk
         iujgf/GjAKemMt1W7r1uLFiR4SbATCu6BAZS1u3YYJoKXBWbisC9EOHyqMs7bhE8cPRA
         Lyh9dr/GUkjiHDDUClneEXLzqKJNYc82zeCe3+iq9z7IDAGtZ1rguhF2bWYyPdbo1AfB
         AioulG6+dopKI7hKZOP938djzxED7sLchQC1DyL32+0UNGiKDFvPFq6B/NgtWywVFsVD
         ZwfcjOD3DT2Me2Trc3kgHjWZwKIDgf/+E04xyI+O9zho1kJW5QNzXuUYD7ftvEUjjp3z
         socg==
X-Gm-Message-State: AOAM530bsa2ne2XDbdEf6HVEw5lb//JLo4DT6DWh7XokkrFiAyy4yfup
        0lrARZD2vEpnIKTzEyvIkTF5M//wyC1KGISmPzM=
X-Google-Smtp-Source: ABdhPJyApkv8+0KUYGJsCjxlHs3B/mHECoGqYkixzXL5ZJJvm9Q8N8JgDkUPP9IGFsaLugf4LNj3xHZuKepGVADNpVc=
X-Received: by 2002:a17:902:b188:b029:11b:1549:da31 with SMTP id
 s8-20020a170902b188b029011b1549da31mr4892640plr.7.1632837148891; Tue, 28 Sep
 2021 06:52:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:fa90:0:0:0:0 with HTTP; Tue, 28 Sep 2021 06:52:28
 -0700 (PDT)
Reply-To: mrsaishag45@gmail.com
From:   Mrs Aisha Al-Qaddafi <gaddafimrsaisha68@gmail.com>
Date:   Tue, 28 Sep 2021 06:52:28 -0700
Message-ID: <CAKKV1NxFHP1DYdduqetBffUhWNVy7tOq+Ohx+d+rs_wUxPyuGw@mail.gmail.com>
Subject: Dear Friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior to a private search while in
need of your assistance. I am Aisha Al-Qaddafi, the only biological
Daughter of Former President of Libya Col. Muammar Al-Qaddafi. Am a
single Mother and a Widow with three Children.

I have investment funds worth Twenty Seven Million Five Hundred
Thousand United State Dollar ($27.500.000.00 ) and i need a trusted
investment Manager/Partner because of my current refugee status,
however, I am interested in you for investment project assistance in
your country, may be from there, we can build business relationship in
the nearest future.

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply
urgently to enable me to provide you more information about the
investment funds.

Your Urgent Reply Will Be Appreciated

Best Regards
Mrs Aisha Al-Qaddafi
