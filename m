Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA1EF51A
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2019 06:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfKEFtt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Nov 2019 00:49:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37686 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKEFtt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Nov 2019 00:49:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id z24so8666460pgu.4
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2019 21:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=vxEtMtEhb2gWEXlTPJA6ddjm9H4tsBmVdOrNaw1VCQM=;
        b=n8LAdQu9EgxXy1mj0XqGpxjs1lEp3q0Ir14BTXRqzzVQEPpzd2ixxvEB1gSCY+NBOu
         9sk5EYnF4VPqPBL1L+5wTSif3jdIXDTWvSECsS2s8WwMNRK8XTb3xSUQamkLheBZjywQ
         pGJiFyZGOYFIglCuNMo1l5flWX9TQvB+QHlH5FIhYhmhyvfYYJ9PRpJHFa0OztkiCCuj
         KCXc56ajukZ3HNA09xkA1tFheqAAVWiYf/3cKjXUSUevDwlaVujo7xyMzJm10M5Cliin
         Yq4mkO1LJr0DF8wyqtFNdSqfACXxp3tHp/SGU7kbIw/fWCN2Q1Q8HiOGPkC3xHL3r3xD
         +O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=vxEtMtEhb2gWEXlTPJA6ddjm9H4tsBmVdOrNaw1VCQM=;
        b=IdMogH2VFgGQSOtefOs9IaQkSOyayltH4yIHgSgORsm8sNhvANvuvyat4amXgVcK4c
         Wf+iSMsH+7xREwmqho0t8SxvTk/vKTgJ7PPZqmZqYmUoxkHlkpNQu8Zdh0vnRyG96jhX
         Xnq/IOIPx+Z3Ottd5ZNSUH3TXnhIXX0JYiee8Vn8FzslRt5dgdt2DqnZYT5jzpUAI2lE
         DYW1JYcKI2WM5a13jekZRjfo8TMPwqklc+32EFNEV8eTvgflFvu4WZfZ5UnlAZ1bBQaP
         JxGPHiJE3DBZuANsm4dTo9KXCex6SfJZgYC0PM6AwffwzqzA8/iqe8edVojyiBrQdZCi
         t0yQ==
X-Gm-Message-State: APjAAAUuOwiME0FfYMdOemVXej07QKcMgPvjEyqTqTqqdwBqELBmv/TT
        HI75eWB0S+pqkCO18fvRLj+Wbg==
X-Google-Smtp-Source: APXvYqws3dyCZENwQMQrkhbmerylekwKAR0pZF0bkZcnqwhtOVsryWw2kALaHyobPflsSHPHraAWhw==
X-Received: by 2002:a17:90a:ca0e:: with SMTP id x14mr4084583pjt.95.1572932988303;
        Mon, 04 Nov 2019 21:49:48 -0800 (PST)
Received: from cakuba.netronome.com ([2601:646:8e00:e18::4])
        by smtp.gmail.com with ESMTPSA id m34sm17155181pgb.26.2019.11.04.21.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 21:49:48 -0800 (PST)
Date:   Mon, 4 Nov 2019 21:49:43 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next] bpf: re-fix skip write only files in debugfs
Message-ID: <20191104214943.6c4339d9@cakuba.netronome.com>
In-Reply-To: <20191104184550.73e839f8@cakuba.netronome.com>
References: <94ba2eebd8d6c48ca6da8626c9fa37f186d15f92.1572876157.git.daniel@iogearbox.net>
        <20191104184550.73e839f8@cakuba.netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 4 Nov 2019 18:45:50 -0800, Jakub Kicinski wrote:
> On Mon,  4 Nov 2019 15:27:02 +0100, Daniel Borkmann wrote:
> >  [
> >    Hey Jakub, please take a look at the below merge fix ... still trying
> >    to figure out why the netdev doesn't appear on my test node when I
> >    wanted to run the test script, but seems independent of the fix.
> > 
> >    [...]
> >    [ 1901.270493] netdevsim: probe of netdevsim4 failed with error -17
> >    [...]
> > 
> >    # ./test_offload.py
> >    Test destruction of generic XDP...
> >    Traceback (most recent call last):
> >     File "./test_offload.py", line 800, in <module>
> >      simdev = NetdevSimDev()
> >     File "./test_offload.py", line 355, in __init__
> >      self.wait_for_netdevs(port_count)
> >     File "./test_offload.py", line 390, in wait_for_netdevs
> >      raise Exception("netdevices did not appear within timeout")
> >    Exception: netdevices did not appear within timeout
> >  ]  
> 
> I got this fixed, looks like the merged also added back some duplicated
> code, surreptitiously.
> 
> I'm still debugging another issue with the devlink.sh test which looks
> broken.

Looks like the resource tests didn't unwind the state and when health
tests were added they revealed the brokenness. A couple patches to
iproute2 are required to fix that, I'll send all the patches tomorrow.
