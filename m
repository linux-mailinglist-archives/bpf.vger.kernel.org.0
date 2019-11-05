Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBE0EF39F
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2019 03:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfKECp7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Nov 2019 21:45:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35183 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbfKECp7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Nov 2019 21:45:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id r7so11287088ljg.2
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2019 18:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=+FDcCstIIOjapCXSv7mnuJ/rUCWrh35Neal7kZlmcF4=;
        b=KN8/Wp7lwFy1gLJn5CO2zmPNm3BlLtANbvaQUUxggSaDRgwjyuy0wmyFq5W7RlWU15
         LbQt0jJNwzaM3pmDeQtxG/tqSXGsN9hnxoQtzd1N+Dk3u5U9DqaLg5esMep6PDoids7f
         aGVuwHzJKMZGr/0Ci3xXjoQM7Uz7Y/tDArKas66pASS/HOhvh+7P/LzDr7XZ7H/u9fA+
         dFLB2GlJbg/q48PzTZ3QhMR8OrEMFyIvK8qkj8beVCG6mWv7tcvW7U943HQMEoJLl8TJ
         9u0iLTu410tA/m8CLlkeZt3z1fY8ccPC1nXAVrlVUgAMP85R/ugVeKAyi4rgTuDHkkQy
         SpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=+FDcCstIIOjapCXSv7mnuJ/rUCWrh35Neal7kZlmcF4=;
        b=Ftrql1gCzD+TQazYWkEUXovoKdokz+Rask+ZU52WNlGHGn5bTM8DGV/wAhSHuYZrJU
         6HHFFqBI4/CxRaKHjzJV6ZTpL+NL7A6J8qZ4Nw+FSw/xIYGM70IX7A3/V1AjhQEtoFgk
         frW7itmOzrKYvRmpYeIuhswiHKZ7J1gGvaqOTCrHSGbaWV0P9rGG6aN2PV2GT+tic6UK
         9Ah8T1rY7Ji3ywk8IIT+cgWSdBemEbEHchbA9evxSZoGkc9Ewf2ZZpoEKS1xwNxDCpLf
         j2pQtL1O8uEtqwIUagOeAK/wE6A3w7AaDZzZ2eOnWG51bTocY6RpLkUrU9naB0NSLQbW
         39bA==
X-Gm-Message-State: APjAAAU5wPdUpLSdgxN+Akll3idKX0mURaD1eQlzzcGbTB9mIxU1L/Bw
        TU+Wci1GgcZoLIISZf2wxv2ixQ==
X-Google-Smtp-Source: APXvYqyCxT/6jRcd03iBSSQ85tFktytduN9L7wK/LczLithZ8tHu/nnaqTY/EkrLFKp9bR05sH+nMA==
X-Received: by 2002:a2e:8e21:: with SMTP id r1mr21231510ljk.81.1572921957654;
        Mon, 04 Nov 2019 18:45:57 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 68sm5065655ljf.26.2019.11.04.18.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 18:45:57 -0800 (PST)
Date:   Mon, 4 Nov 2019 18:45:50 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next] bpf: re-fix skip write only files in debugfs
Message-ID: <20191104184550.73e839f8@cakuba.netronome.com>
In-Reply-To: <94ba2eebd8d6c48ca6da8626c9fa37f186d15f92.1572876157.git.daniel@iogearbox.net>
References: <94ba2eebd8d6c48ca6da8626c9fa37f186d15f92.1572876157.git.daniel@iogearbox.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon,  4 Nov 2019 15:27:02 +0100, Daniel Borkmann wrote:
>  [
>    Hey Jakub, please take a look at the below merge fix ... still trying
>    to figure out why the netdev doesn't appear on my test node when I
>    wanted to run the test script, but seems independent of the fix.
> 
>    [...]
>    [ 1901.270493] netdevsim: probe of netdevsim4 failed with error -17
>    [...]
> 
>    # ./test_offload.py
>    Test destruction of generic XDP...
>    Traceback (most recent call last):
>     File "./test_offload.py", line 800, in <module>
>      simdev = NetdevSimDev()
>     File "./test_offload.py", line 355, in __init__
>      self.wait_for_netdevs(port_count)
>     File "./test_offload.py", line 390, in wait_for_netdevs
>      raise Exception("netdevices did not appear within timeout")
>    Exception: netdevices did not appear within timeout
>  ]

I got this fixed, looks like the merged also added back some duplicated
code, surreptitiously.

I'm still debugging another issue with the devlink.sh test which looks
broken.
