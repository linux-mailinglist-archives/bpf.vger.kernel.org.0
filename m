Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC52262674
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 06:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgIIEup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 00:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgIIEuo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 00:50:44 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F8BC061573
        for <bpf@vger.kernel.org>; Tue,  8 Sep 2020 21:50:43 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id h206so920732ybc.11
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2020 21:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzPDU3uHQmhLlDwhkfY8F+rUV23fDKp7v9sj+jfTPKc=;
        b=AU2gIeEBQprgn9nd2b+0vZRD2epYoepgS12Wg0PTRe8uGN7JPselHctIQshisS3pXH
         H+V98sjpn8K9YcnK96+UF3KLQrQIVtatCLGUcy95HpuJZI2HaPq3SM08uOIf1KV6nm8A
         rCcw9PQREA0OYg1yED6MXC2YsaCqRxNKqeQFu04eLmcXZe75EC0AoRUVEJ64JrEh9MBn
         GmCaRhT1vw+AdVUzG1cBw+gSYgBl/YAwZN+OfBMLs6xXwROQzREGU6qq7PK8FNiChz4F
         s6ibN3QcZrTxDAST8tmrVOJnfwzzkRbUcHQNbjk+9Zals+hRYLtDJ1i6dQdyQaQk47ZW
         jNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzPDU3uHQmhLlDwhkfY8F+rUV23fDKp7v9sj+jfTPKc=;
        b=Zgaou/I/vM+X4ESXT4MTx3zsNkRXxwZxKQqjG7k8YD7d0vIkFH+NC7CGA+cSMWcNl2
         nNQ0NdEDer8NyWx7rCS3far3oJKSaICkWrKDY6XxWUbTd6DV1VKnz1rzhvrWRZxLFKcO
         qNxycJeogH+iJHyoYsTOVWAgegurkoQtIS4D48yTxDtrlizyyB2j262cBTPahJQNe4ea
         xBHu5K4ZWXoAlcNROt31lhgCGV1RIZOrzpjXvAcsiSm8kmYDln7BWgKO/c0/TkrUPelO
         QPcF3dwjDtl0G0Qu4GfAl+X3FveL7/zjKIf8nkoKBpKtPH22HhJideCub2/kF0XEhpCc
         db0w==
X-Gm-Message-State: AOAM533RU+3N38ZWXp7Hz47TMZSIFgy2xKJjZzpxhpqsqdS9IGEt8kFM
        lSGXft/HxIfC0SYK29nlDQlX2SJihFeR00KsrvA=
X-Google-Smtp-Source: ABdhPJw7bGVcCYAzdChOl3+N1NP6HjRgnApcKd5k+t54zd8aIricvOfyMM/R4nPKticcOxyw0Zs6f/tbt2BNwkQpdOY=
X-Received: by 2002:a25:c049:: with SMTP id c70mr3291849ybf.403.1599627042853;
 Tue, 08 Sep 2020 21:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-7-lmb@cloudflare.com>
In-Reply-To: <20200904112401.667645-7-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Sep 2020 21:50:32 -0700
Message-ID: <CAEf4BzaG3fLExg9h2=K0yi+BYJYB+JpDJxZ0TAukBCmgGw602A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/11] bpf: make reference tracking in
 check_func_arg generic
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 4, 2020 at 4:30 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Instead of dealing with reg->ref_obj_id individually for every arg type that
> needs it, rely on the fact that ref_obj_id is zero if the register is not
> reference tracked.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

[...]
