Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 504E72D443
	for <lists+bpf@lfdr.de>; Wed, 29 May 2019 05:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfE2D2s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 May 2019 23:28:48 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:53964 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfE2D2s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 May 2019 23:28:48 -0400
Received: by mail-wm1-f51.google.com with SMTP id d17so489663wmb.3;
        Tue, 28 May 2019 20:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GY3PfFOyZcoJdIfdvR1GAwUmaDcfBTuvp/0vdZRtI1E=;
        b=ttYncVVwVbPKTN+8oqzzmeWBiAIK7agvYOD1F/yo7xsJVJ/ZrJFIeQvZ8Jq2VsiXrK
         vRm2ow+MF8qrdetTuxdvRxFywJuPAyv3jbvWolI5y4jfuN4VAMwWDjfLQf5SreQ3sFkF
         XgaUTFQWt674FsEnZJqx7OVv20JcY6sYLOMZFmgtXyZQj0zsildDkHXBl+X8MSZvdUdB
         64XG6us9gF0wDCTh8Umj/GruSC08/RUSWHYqBrh0K7ewoZogN8TvOBHzwr9JUVJlP7C1
         pE9iDgQAxeRUubO90q9i7F21v37SRYd/vtMt7Ck26PmrKOHTvdxNsTnIFPaQOkzz82y5
         FSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GY3PfFOyZcoJdIfdvR1GAwUmaDcfBTuvp/0vdZRtI1E=;
        b=T7Mxg6pUSMAfQaUAWUpuiweg952uiTwLiYjXyjXqv8EYU+O8veN6MrgLxvKz3OGnKu
         wrAIANiUfPMqQPsnr+g9tiwAd9+QRe9fvucrFwgoP/YTB/QouPtctHoDmnVNFI5izwFO
         bKoAzyAc6LaMu4FvKqf01W4ca/Xooc45xgEzTMoSKVaGZnOiVRmkZ7tIeDtrVzCFtXYI
         9qX6IwyVq5GyBiHQga5zPlbJ+hd3ACw8W2Dc6Zl1UytqAke9ZTrdBpe1Kl7RnA2tuwtw
         /y8ikGkM7jRZXb4f3pYqZN9mwcB0nZVz1GK7/OBAfDDIvq5I3O0OMtFiJZ/y/6mVUVp0
         ZdNw==
X-Gm-Message-State: APjAAAWJGPJROD/dP1BCz+9kS4QKm1ehYXMAxag3PG3fBhqQUreau1bn
        egrFKQY1fitccujAZRmv5bxGfTF7hkGu/6IYQLS2HEcf9y/DkQ==
X-Google-Smtp-Source: APXvYqzhVLOOi/yvOCD8uKoYRVZAu6fBQCcXv5ZMU3Fq7B/ovWjOSwxMZ61lqogvojDUIyryuActSUGlwWJw5mT0t70=
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr732886wme.146.1559100525867;
 Tue, 28 May 2019 20:28:45 -0700 (PDT)
MIME-Version: 1.0
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 29 May 2019 11:28:34 +0800
Message-ID: <CACVXFVN-YX0oRHDu8zBZHYpRvkD2C=zp04s20MN9MHASJBFSRA@mail.gmail.com>
Subject: ebpf trace doesn't work during cpu hotplug
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Looks ebpf trace doesn't work during cpu hotplug, see the following trace:

1) trace two functions called during CPU unplug via bcc/trace

/usr/share/bcc/tools/trace -T 'takedown_cpu "%d", arg1'  'take_cpu_down'

2) put cpu7 offline via:

echo 0 > /sys/devices/system/cpu/cpu7/online

3) only trace on 'takedown_cpu' is dumped via bcc/trace:

TIME     PID     TID     COMM            FUNC             -
03:23:17 733     733     bash            takedown_cpu     7

The lost trace on 'take_cpu_down' can never be shown, even though
CPU7 is switched ON again.

take_cpu_down is called via stop_machine_cpuslocked.

Thanks,
Ming Lei
