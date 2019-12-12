Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 986BB11D6FE
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 20:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfLLTYD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 14:24:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42383 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfLLTYA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Dec 2019 14:24:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id x13so1057167plr.9
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 11:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0bnwhQPrNoLKShlvQAzBBKAOH/VCCS9XFOqu0ESqP/Y=;
        b=YSC85zcbWFrbTaI0+aNFg+ZOORvDZCCajBd/r4XT0ZsSO7yV8DrhYiohqNGS+r9ozk
         AD81wxqimeqeEVYT/sWCf4E4XUq2wCZjw8W5Sc+hPWe2X0uMqjiCfPlork8yjnKWOasS
         AtVdapZYsViEcsmiWzKxoJNz69SV/O15vdHcP8u2/hurW/5lU3RUmW2bK2KwrUkxxHWv
         4CdQTpuPxWGL+g+HpRSrgKftQFZdu6XqEJrWQm8xa4bjtGYA/ea+39e+110GcvNBh2a9
         ktTAc5p1fCYDjNorBsdXQvlKpVFgSh7mGwdfJZy9KuzQ0rD+jHE/xU91sKvLpr6Xhi8t
         V0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0bnwhQPrNoLKShlvQAzBBKAOH/VCCS9XFOqu0ESqP/Y=;
        b=jWjNh37h/Y/oa3T2hZ3rdKGNT3t6RzQ4ECiQhZNAY9DXcLQamPs/bKry2jV+o0Hdjh
         MFI+G6bkv8+KKBvP80WgGfFNGe4v+OgoL5ZX7n40ucdy8OG8DFiwrfJ59wsNyLENQe7P
         pVwt/r2SlWEx667iPDC06RQv+a7DMx2RSjacf0fCx0o1xYR7BqBlb+wk6HvqoHdhduoy
         3y54ZuBMqhvLX3LKkq+vRslF8EhcRjJ3Eu9SzQzBDohMlSEoCO/QrNQGiTHt84kZbxM9
         0sB/vFWfPl7iuj6z3bwv8cj0opl8kFuzzJIVe20QLvp8OO0bG+8U4ehOBwsq4e2jOpxJ
         fr4Q==
X-Gm-Message-State: APjAAAXJQy8c/OsG4G2yLreM3sLw2/HDXbPhI/DsTkeDlyySgHfJNP10
        90DbMfw7tycuerD7/vIKWLEWoQ==
X-Google-Smtp-Source: APXvYqyuUQoo7OqdUF2hZ8Tymf+B4ZnOq2m3N/lN2LknjI8630Nd7AaDmNqXMbioGtaaq+6IX0689A==
X-Received: by 2002:a17:90a:d682:: with SMTP id x2mr11930941pju.44.1576178638725;
        Thu, 12 Dec 2019 11:23:58 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k23sm7600955pgg.7.2019.12.12.11.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 11:23:58 -0800 (PST)
Date:   Thu, 12 Dec 2019 11:23:54 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 11/15] bpftool: add skeleton codegen command
Message-ID: <20191212112354.55881154@cakuba.netronome.com>
In-Reply-To: <20191212185831.GN3105713@mini-arch>
References: <CAEf4Bzb+3b-ypP8YJVA=ogQgp1KXx2xPConOswA0EiGXsmfJow@mail.gmail.com>
        <20191211191518.GD3105713@mini-arch>
        <CAEf4BzYofFFjSAO3O-G37qyeVHE6FACex=yermt8bF8mXksh8g@mail.gmail.com>
        <20191211200924.GE3105713@mini-arch>
        <CAEf4BzaE0Q7LnPOa90p1RX9qSbOA_8hkT=6=7peP9C88ErRumQ@mail.gmail.com>
        <20191212025735.GK3105713@mini-arch>
        <CAEf4BzY2KHK4h5e40QgGt4GzJ6c+rm-vtbyEdM41vUSqcs=txA@mail.gmail.com>
        <20191212162953.GM3105713@mini-arch>
        <CAEf4BzYJHvuFbBM-xvCCsEa+Pg-bG1tprGMbCDtsbGHdv7KspA@mail.gmail.com>
        <20191212104334.222552a1@cakuba.netronome.com>
        <20191212185831.GN3105713@mini-arch>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 12 Dec 2019 10:58:31 -0800, Stanislav Fomichev wrote:
> > I'd honestly leave the distro packaging problem for people who actually
> > work on that to complain about.  
> I'm representing a 'Google distro' :-D

Suits me :)
