Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52AE2B0174
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 10:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgKLJAN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 04:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKLJAL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 04:00:11 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0F2C0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 01:00:09 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id j205so7178893lfj.6
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 01:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=6hq1Ugv3HkONjgb2TpIAbqEThyFQQyw3Au9DYtN5sqo=;
        b=dlRZk+ptqphaGEnbeS4FBLHGHSycXqm81pivADn5zLixb/0WuNC3Nv+3BkIPc/2bi5
         aD5MPdoTphBw3cL1Hkx6NO7Qdv6McoWaVDQH4JmCHuXpDjjZAUXAS3gFerqTQOEVz4W2
         bXK5FHEMiMoHScuK2sC1br0HL3tbBc0FZbwXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=6hq1Ugv3HkONjgb2TpIAbqEThyFQQyw3Au9DYtN5sqo=;
        b=iUXTotiCtIMCubwAAKrcT4+jDVio2xW1vcYw8JFpvJdlvsdyYKd9qMhj2SLl8Q2JoW
         rz61smiP8bZbXAjhIVAU0QT/hp8BcV05PzROiz8F+GIwlS4Ej1gzDV73nbVSadsnGQ9x
         YR4qZSXNcXP7Lg+PfSh6MeWC+hGfLumi/k5bSBH2o8+e/q9dOfWqAYdljFO35HfwK34a
         mV2TNRJN+pBrf9ZglnAB61jEyX5vzl2y1MMqzPMM5XiI8sRyiNN/32wvi0otUMftO2kh
         zgPs3qiWDK259Af2xcYyND0066pYlzswujawwKYEHY2uw/OonsXNQ3+Qzkr6cH+QkRmq
         6P9A==
X-Gm-Message-State: AOAM531OnIybfwrSX49dOxtFt6JMlH3DxGyJbjYyHaiX7/sPoQ/K+MWE
        o1w8DbZBImoCYrUWLgKHPZo3/w==
X-Google-Smtp-Source: ABdhPJwkLX0tbuLgl+cGAeACPaweC5UrkY8OHb9dP3CA9ymo1IWJVv4o8CJHQs+bJpeI8L6QKJqQGw==
X-Received: by 2002:ac2:515b:: with SMTP id q27mr11462732lfd.123.1605171608405;
        Thu, 12 Nov 2020 01:00:08 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id 129sm487138lfg.214.2020.11.12.01.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 01:00:07 -0800 (PST)
References: <X6rJ7c1C95uNZ/xV@santucci.pierpaolo> <CAEf4BzYTvPOtiYKuRiMFeJCKhEzYSYs6nLfhuten-EbWxn02Sg@mail.gmail.com> <87imacw3bh.fsf@cloudflare.com> <X6vxRV1zqn+GjLfL@santucci.pierpaolo> <292adb9d-899a-fcb0-a37f-cd21e848fede@iogearbox.net>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Santucci Pierpaolo <santucci@epigenesys.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        sdf@google.com
Subject: Re: [PATCH] selftest/bpf: fix IPV6FR handling in flow dissector
In-reply-to: <292adb9d-899a-fcb0-a37f-cd21e848fede@iogearbox.net>
Date:   Thu, 12 Nov 2020 10:00:06 +0100
Message-ID: <87h7pvvtk9.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 12:06 AM CET, Daniel Borkmann wrote:

[...]

>>> I'm not initimately familiar with this test, but looking at the change
>>> I'd consider that Destinations Options and encapsulation headers can
>>> follow the Fragment Header.
>>>
>>> With enough of Dst Opts or levels of encapsulation, transport header
>>> could be pushed to the 2nd fragment. So I'm not sure if the assertion
>>> from the IPv4 dissector that 2nd fragment and following doesn't contain
>>> any parseable header holds.
>
> Hm, staring at rfc8200, it says that the first fragment packet must include
> the upper-layer header (e.g. tcp, udp). The patch here should probably add a
> comment wrt to the rfc.

You're right, it clearly says so. Nevermind my worries about malformed
packets then. Change LGTM:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
