Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB013C9884
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 07:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhGOFv5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 01:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhGOFv5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 01:51:57 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA465C06175F
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 22:49:04 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p186so5052527iod.13
        for <bpf@vger.kernel.org>; Wed, 14 Jul 2021 22:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+YuORpriXKWUOqaLUO0QYAPlWHiXrkjZSayNgaNvPJU=;
        b=th+IjOcwU4wVH/52hbAeTnyp5n2WWQne71/pKbryoILPp7RB4A9gYAZBGxy7JPjscu
         uOSalqF+3lOTbfgIw+b1A+Vq6j2tpU7bwxphm9CYTw+AodGmOP1d4A/tGZCnsCsRcoyS
         0uUWBOVfaHLpBcQ+9aST5pVdvavU6Dp5rMUWmreFdbVC7ZUh3XhzgpONpnDT6VGCHKtF
         iW+6kKIhJ+rMMxk9yNES0xBAG2qRAvHGoZJ1c/CBFNwz+++MTcRBSdJ209qpXrPuu86W
         DSvOvKpiv2Y4CLm4sXHs3nFrZ5nG92xIYEQSHHeEijOT0V2U7khslHcP7toVgnTMGoQO
         RLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+YuORpriXKWUOqaLUO0QYAPlWHiXrkjZSayNgaNvPJU=;
        b=XMf7eXuuYZ5mSjKrNrZhN1oXxnPL09PNc6XEBQLG8lgNV6ojYmIzS7/kWJ8R9CM9bT
         JIqQKkEBGfflCSgnapVnBW70uXOy6dN1ivIXU6ndi96k+qpIWbXsa1oTfTelXS8sgyAU
         kAPdSl7jmx19OEOe1Rp8XQBEIScwnId+BHWk524A9yrGukIOdtBcxMyjWcW2hLCpJWd6
         NUdzDHl+yms4JgI1hlczKDBC8hjd6oDMPLA5zbnLvcFYTq9W0Cza1Uc8z0lgvN2unMMW
         R1lYvUdy9pvjvwdMjgdrAROX1GZ8sHlBPQJFa3umSe1LgKx9wLZH2UVWljnaC+BBX9HM
         /5Lw==
X-Gm-Message-State: AOAM533Ed1dGsHfI5SP2j+29RPLVv7je8/UrP+/dSReur/XmdVQmX4Ud
        mMIw8+rGKL9MYVaNv9IqtMA=
X-Google-Smtp-Source: ABdhPJwIyQad6HlnigNQnnfLBDu1G7sQUyE3Qzd3q3gVb2aMD8W0mi/1UwruxFF+yJkcX8xi6B6nEA==
X-Received: by 2002:a6b:ef01:: with SMTP id k1mr1756815ioh.102.1626328144306;
        Wed, 14 Jul 2021 22:49:04 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id x9sm2336805iov.45.2021.07.14.22.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 22:49:03 -0700 (PDT)
Date:   Wed, 14 Jul 2021 22:48:56 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Lorenzo Fontana <fontanalorenz@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net
Message-ID: <60efcc48c4de0_5a0c1208e@john-XPS-13-9370.notmuch>
In-Reply-To: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
References: <aa97c776-9a82-9acc-fb13-dd082fdcaa61@gmail.com>
Subject: RE: [PATCH bpf-next 1/2] tools/lib/bpf: bpf_program__insns allow to
 retrieve insns in libbpf
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Fontana wrote:
> This allows consumers of libbpf to iterate trough the insns
> of a program without loading it first directly after the ELF parsing.
> 
> Being able to do that is useful to create tooling that can show
> the structure of a BPF program using libbpf without having to
> parse the ELF separately.
> 
> Usage:
>   struct bpf_insn *insn;
>   insn = bpf_program__insns(prog);
> 
> Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>
> ---

Seems reasonable to me. Couple comments on the 2/2 patch.

Acked-by: John Fastabend <john.fastabend@gmail.com>
