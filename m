Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25C261C86
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2019 11:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfGHJoH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jul 2019 05:44:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42077 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfGHJoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 05:44:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id a10so15174000wrp.9;
        Mon, 08 Jul 2019 02:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=W8H7tL5YAKJJruwvB/WgPiCppzSKiEn/kLOU4t/xGrs=;
        b=AJlgkjFNBKBO+bscHJXJ3+8k6gE7b0FMBHTo5gwYmVkI99qYUCyjP9kMRbaAsHoytC
         jWWK+DDmjghvBjgmS2mTLG09nS4OwuvguTQbHc2C+Se8WVZRxyJeekrkpvqtx3fkA32Q
         y79rdCvJSBW6oh00zrh/HTGiWz81eVc/7wGFaGWZ6xM4OB5XW0ylFlMb1o3gAYO7Y+8J
         Vwc6mDCbietGQPaw4JYNN6aguctoeDb4JTV0CPW3UpXVk2VCAkwwyCqf72VpoJW9sf6i
         2EvQVlYT/c1Iv2icOkihA2LbeoCs39lREvj596dihpbyXPxC3fMebbbRQy8RgBVzE8ep
         8A9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=W8H7tL5YAKJJruwvB/WgPiCppzSKiEn/kLOU4t/xGrs=;
        b=P0GqKO4whtEIPG0jA+YICooVWS7kf3PsiLU7ZNK+C2lrrRH49jUFGv4K4m3XmTQxDW
         lB+FK/BeByjuOwBoJP8w+A3Ysv8+f0JYJP40W8rgrJ2JnnIJr7VMV+xUVwYWd6shKzb1
         fnkmYn8qmWMFopexh1uudlv8bLhnUA62rF1LsyePfqrf0m0wb3EaFPN9FHJSzXbk4W56
         K7AMfQ2Hb21BPNJI/5IojkHLIYt1WYRUSvvUsRggBPpkVojVWfZN518QMhlD9tXTLzIb
         8P3RY/JG0bYNK3AU/XPcIVB8319kmqscgwll/qkJE5fn72XWKTo0Ipez7sgk75uDNJ11
         yafg==
X-Gm-Message-State: APjAAAWPqz8TCg15Je3O/x5LZniD0nMMGTbxQZD/BQqzhbMWC/KzXeQF
        0j/PU4I7g+zi1HAqfGibBOT/RY5p5rEF57jyL2nOPOCzh8U=
X-Google-Smtp-Source: APXvYqy6Q8L1UPm52TwwUtY/KLs2NjZFUyzSDKL+cWVLOxUEmklSDvh6wOHt2i5moqj+ncjPwROM4fju4chMZ+H4Aco=
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr18556129wrk.229.1562579044492;
 Mon, 08 Jul 2019 02:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <CACVXFVN-YX0oRHDu8zBZHYpRvkD2C=zp04s20MN9MHASJBFSRA@mail.gmail.com>
In-Reply-To: <CACVXFVN-YX0oRHDu8zBZHYpRvkD2C=zp04s20MN9MHASJBFSRA@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 8 Jul 2019 17:43:52 +0800
Message-ID: <CACVXFVMoi01a2WhF-LWhf3C10Ee5qRXHZjNNMY-Ky+Qk1E4N2Q@mail.gmail.com>
Subject: Re: ebpf trace doesn't work during cpu hotplug
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 29, 2019 at 11:28 AM Ming Lei <tom.leiming@gmail.com> wrote:
>
> Hi,
>
> Looks ebpf trace doesn't work during cpu hotplug, see the following trace:
>
> 1) trace two functions called during CPU unplug via bcc/trace
>
> /usr/share/bcc/tools/trace -T 'takedown_cpu "%d", arg1'  'take_cpu_down'
>
> 2) put cpu7 offline via:
>
> echo 0 > /sys/devices/system/cpu/cpu7/online
>
> 3) only trace on 'takedown_cpu' is dumped via bcc/trace:
>
> TIME     PID     TID     COMM            FUNC             -
> 03:23:17 733     733     bash            takedown_cpu     7
>
> The lost trace on 'take_cpu_down' can never be shown, even though
> CPU7 is switched ON again.
>
> take_cpu_down is called via stop_machine_cpuslocked.

From a user view, I think the tool should be reliable to collect
traces any time.

So ping on this issue...


Thanks,
Ming Lei
