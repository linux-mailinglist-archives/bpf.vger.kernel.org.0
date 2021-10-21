Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3418436D53
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 00:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhJUWSZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 18:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhJUWSY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 18:18:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF4CC061764
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 15:16:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id g5so1408385plg.1
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hO1VhO7a6Fs5xO3cS2jJfaIXrrni6VqzUqnRj5rrzfE=;
        b=iAihlfD4AlADTmCIL/W/Exvn9vflVKAPtVzxn6FpnYC/lJOBYej4yZi/bEMB1oMBNr
         +sr8sBb0nI78CEj0CGMsXYHxWdL3nn3U4uIyRAxAAXuwqULioWrppBeNtnx4kewtpVxk
         E9gYCRwNW+TAosFveWkuziG6k32ppmAWCSolkroVRqGLo+zfH8iKJDWzCnHSSuE0xSao
         VAclbJnLBNF5Gr0VVkpYnSa97dE+r1jxvSoAyIfeZtlyzpB3NEGHc+NGWJTW4eUj65F/
         dh4ls9EOUbcEBYEIEb9YO2UFbx29r4ULm41FSkBeuZF8coAqO/+9k3P1/94zKasIdLTb
         lUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hO1VhO7a6Fs5xO3cS2jJfaIXrrni6VqzUqnRj5rrzfE=;
        b=xi8EjA0UiIKH3X4rwawunHewC0BU5d0VMMCafN0QKTadQUsOdTmtVZ9mFB5JB6CTzt
         HVroHcwTp+kNTNYKGQCCqY8HH8HdhwQDOOqs3RrpqYY/AUkcQx/y+KHnHTPObytr7myz
         UZGxHeBdwQ27XIbevDjNDsZEzX7L+Lh1TT2n8K/1CKBJnssEhRp0YN+jr/C55s5XPMvG
         Rp1BtYpeoju/QI5PTLn+DGPn7GLCk0B25vXoa+tImBopnH1h2YkkhmPrVe6Msf3i3InM
         94XnftdqIaGLdKDO7a7g025wkHdHhH92CWuiKRw5gz4we+vl9IRQ2jBXif5oYjo9n6Ve
         bnfw==
X-Gm-Message-State: AOAM5313xH7jOezxPYdEAX0jharylLwSESysh2YlvbcY3qQVdIVNDWWM
        Z3X72Ll3fMRlXLfhXKbvortOeLH2StAQ2tuSLSNLnGVl
X-Google-Smtp-Source: ABdhPJzN3va9C6T89lDHuHioxjN9lfLw0H7TuvOspOo8eQzynrdleFcbir0ZOjlux4X/c/AVC8tDNzx7UP9q4Qyh/OQ=
X-Received: by 2002:a17:90a:6b0d:: with SMTP id v13mr9695566pjj.138.1634854567816;
 Thu, 21 Oct 2021 15:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211021054623.3871933-1-andrii@kernel.org>
In-Reply-To: <20211021054623.3871933-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Oct 2021 15:15:56 -0700
Message-ID: <CAADnVQJY6xQqGhGhA2V2Np43tLsDRS67=WZsM1ZgKj_tA0Y-5A@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: fix BTF header parsing checks
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Evgeny Vereshchagin <evvers@ya.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 10:46 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Original code assumed fixed and correct BTF header length. That's not
> always the case, though, so fix this bug with a proper additional check.
> And use actual header length instead of sizeof(struct btf_header) in
> sanity checks.
>
> Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
> Fixes: a138aed4a80 ("bpf: btf: Add BTF support to libbpf")

there is no such commit sha.
