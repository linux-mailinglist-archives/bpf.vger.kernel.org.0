Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B32A26884F
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgINJ3i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 05:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgINJ3e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 05:29:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37052C06174A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 02:29:34 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u126so17116839oif.13
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENRlH9SbIRX5bEXHWy1oBRXo8Zx79qj9eLQnj+2tS0I=;
        b=r1IIjpbydmwAZZdeYqAI7aP2BNIb/kmwErZJu1VSq9ShVpWidZYL7JjmmrsAbEInsJ
         GhgZAWWG6ucK6jXWj1a66Tglkl4A4GWCBy0wz1C/HFVmSPKXn2j/U8rGGzxGh8N7zunQ
         +KvNEvB8RXw98Z352SF2Y8ttbxTcFRGiYG90o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENRlH9SbIRX5bEXHWy1oBRXo8Zx79qj9eLQnj+2tS0I=;
        b=X6GCtl/1s698ffb5N5DTNKqvRfwtoJ+b92FOo0Y3EryEwA9VNsWxYooKqqn3CCaySS
         E5MVh2sBBo8wQeuMym7WnHnXmnDO8m/f7CKwQWUjUUcUoQtucoYTkf7a14oHGSG0T7kY
         vBBPx5UcCosBjP2D7jCaMuuB2v4TbphOjY9yqBTyj5DUJaoS4RggyKLMIlki6vC1OKmO
         aRWa2g6bdjrpptK5eOO6bp0rxdZht/8moPfETc7SlzQo6graCp/f9MLPvg2T+xKc2we8
         Bl7azFGCGizLQwC63BUJwrKfJMDihfFfK7+idcxVRYpNPOXKmkjeqNQhUsdGEHyhHFPw
         0I+A==
X-Gm-Message-State: AOAM533c4wJynSX8WnmjA+3igs1uZpWBmPFXCNhmrdZTTUoT/I2oBOl/
        rZtv94dmtUI6JcmFWeE2W9Fl9m3c8SvyB0Ty4UJcDw==
X-Google-Smtp-Source: ABdhPJyGOwkRJXXboyKZTX7ep3/ab9oGhkvFJrtlBSBxIq0A6lMkDnkiGbq5WN2HmiT/sB17TFjLbMK0It9bCOF06NY=
X-Received: by 2002:aca:f0a:: with SMTP id 10mr8386685oip.13.1600075773692;
 Mon, 14 Sep 2020 02:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200912045917.2992578-1-kafai@fb.com> <20200912045924.2992997-1-kafai@fb.com>
In-Reply-To: <20200912045924.2992997-1-kafai@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 14 Sep 2020 10:29:22 +0100
Message-ID: <CACAyw99zWUfZnDsr3bFPatBOdEg75cWh7rSp_M4OQ1tM7mTTyA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/2] bpf: Move the PTR_TO_BTF_ID check to check_reg_type()
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 12 Sep 2020 at 05:59, Martin KaFai Lau <kafai@fb.com> wrote:
>
> check_reg_type() checks whether a reg can be used as an arg of a
> func_proto.  For PTR_TO_BTF_ID, the check is actually not
> completely done until the reg->btf_id is pointing to a
> kernel struct that is acceptable by the func_proto.
>
> Thus, this patch moves the btf_id check into check_reg_type().
> The compatible_reg_types[] usage is localized in check_reg_type()
> now which I found it easier to reason in the next patch.
>
> The "if (!btf_id) verbose(...); " is removed for now since it won't
> happen.  It will be added back in the next patch with new error log
> specific to mis-configured compatible_reg_types[].

This is a nice idea, thanks.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
