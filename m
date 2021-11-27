Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D1245FD17
	for <lists+bpf@lfdr.de>; Sat, 27 Nov 2021 07:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348759AbhK0G2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Nov 2021 01:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhK0G0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Nov 2021 01:26:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F5FC061574
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 22:23:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 506DC60DB9
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 06:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3544C53FAD
        for <bpf@vger.kernel.org>; Sat, 27 Nov 2021 06:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637994217;
        bh=2Z2mzQWw6XiRgkXZSy3bN98M08tkfKZH9aJQSn4JS30=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zd97ty1kwpjOWI1CbyJIr7vGWKRaudEvX5v2Kn3/8d/zmISa5zUMLhnSAueaO2Sln
         7CGmPZDLZF6MptLPtq85b/l1PsgK86ECWhImLu+fPkx9p/gBJYGpmHtErnG4hFMaKw
         Jlpa9XOb91KeiNqxNcJzh94eR8ti/mDUOq/raLcPen5Znsk5RUc8nLXon4uLy95a2Z
         XJMn+85TwqvF1PyKMZ/lxKQIJMPNXPhWcNXz+/6kx40A8tHE5Iy/XXtNHdyYasXVkl
         p5pB9lyJp9Tci7Qasz40jeRiNf4jXCP43ne++BdOy3I5gQqiYl7FJE52gRA7ViQAxR
         2sOs9eafjJraw==
Received: by mail-yb1-f182.google.com with SMTP id v7so25891939ybq.0
        for <bpf@vger.kernel.org>; Fri, 26 Nov 2021 22:23:37 -0800 (PST)
X-Gm-Message-State: AOAM531Ddr6eg6i9LmxOV0fCBn5RxANm3m/vEFkRVVnvIErGeHPO23o0
        hipPQ2XsHUqNXayJ2H2LvLpg52qoz8gAnm6Ofqk=
X-Google-Smtp-Source: ABdhPJwTKoq0uP2sG+HA0KQUUphBd2uJF40bxYUke3W2YCcld+QwQBsMg0Cr+Y4snD7OEEMUIBDgqFQEeHVO1E/BOmU=
X-Received: by 2002:a25:660d:: with SMTP id a13mr21215718ybc.460.1637994216796;
 Fri, 26 Nov 2021 22:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20211127024325.10949-1-arshad.rad@gmail.com>
In-Reply-To: <20211127024325.10949-1-arshad.rad@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 26 Nov 2021 22:23:26 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4PawP7DQsXeHHFJjKnYD_5Ja8SveK8a06J3dFuj1Y5Fg@mail.gmail.com>
Message-ID: <CAPhsuW4PawP7DQsXeHHFJjKnYD_5Ja8SveK8a06J3dFuj1Y5Fg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Remove duplicate assignments
To:     Mehrdad Arshad Rad <arshad.rad@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 26, 2021 at 7:45 PM Mehrdad Arshad Rad <arshad.rad@gmail.com> wrote:
>
> There is a same action when load_attr.attach_btf_id is initialized.
>
> Signed-off-by: Mehrdad Arshad Rad <arshad.rad@gmail.com>

The fix looks good. Please rebase the change on top of bpf-next/master branch.
Also, please prefix the patch with "[PATCH bpf-next]".

Thanks,
Song
