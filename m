Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E53019CA06
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 21:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbgDBTbu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 15:31:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40194 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389108AbgDBTbt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 15:31:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id l25so5406980qki.7;
        Thu, 02 Apr 2020 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7I6mCCWO0NI2W9Hv1j2ODnDFaCT13IrYKH20fIeShyM=;
        b=qtiL8TpB80vLSxlF06cwi699QC+hLcU4dTsjnFf39v34jsBq6n0YTbCvrIiysheT5e
         0iDCSMRVYq48fkYuwf7bD68+pxz7nQ74cvtLS3nYaJvZ/0obYVA+yCpyTHkq7mg+SMkQ
         8f1FSy+tnNukU5h6Ew2OMmoz4LRVMG1Hy91BKk6TaIta7EWlN7Im+cdyphWu6CHElvxQ
         DI6YuEBFoXYi0/2CuK1IpIDQrK2TiGauWUnjjcXO3tbCTNXIgzwz0uY+weQQYLLwH4qV
         HMR0Up/BJT+QPMlycRANAHWJQePSQ3f0ZrLLcHFbcQdmKZVoe2t3s0mBEG/syw612Eko
         iu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7I6mCCWO0NI2W9Hv1j2ODnDFaCT13IrYKH20fIeShyM=;
        b=iO1TQrhKCdF/9JFs2YDL9/No7/v6XhhhpIyEAYXS8pGNyk/CAzbzxZNA6zhW5b53+m
         j9MVAs49Glfx3KDHds3uGBCqrl9lc5QRk9LQUzDchlcd8E2qyf5qPlgJoZlGKX+omwY7
         jLigLxRBYyfVWdIt4Vv5e/2qeqr1RlslH6p0bfPKFoyvHigfC9wKkJKjKjMLyS6ol22F
         5TuwkZ0G/v9sAqG5eT5cXeufqpxav238zinQOK4uckvb0zRjOvzG7dpg+tke8dUzW2a0
         5yk4sKCyc2qF/FPUDzKXCvFidatSFjuF/081XOOlXXN+/njRtCqk4xWeMvWX5ccbHtM3
         PgIQ==
X-Gm-Message-State: AGi0PuZ/8R61U06U7cm9WlGbf1ENSomLLiyjCQl6fi0u1Y2icIkbeLXH
        Cf0mdOWrL1zDBuFmxiClm/qsjEXx0NyOnGHW7e4=
X-Google-Smtp-Source: APiQypK/ZbpMk9Dj0Hosok9jPEo30Su45nhINvZzVFcgTSuckkMrLuD8FT88jQlIP1pGI5Y6rlhHf2KJzp2UlipKQtA=
X-Received: by 2002:a37:6411:: with SMTP id y17mr5397810qkb.437.1585855906945;
 Thu, 02 Apr 2020 12:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <202004010849.CC7E9412@keescook> <20200402153335.38447-1-slava@bacher09.org>
 <f43f4e17-f496-9ee1-7d89-c8f742720a5f@bacher09.org>
In-Reply-To: <f43f4e17-f496-9ee1-7d89-c8f742720a5f@bacher09.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Apr 2020 12:31:36 -0700
Message-ID: <CAEf4Bzb2mgDPcdNGWnBgoqsuWYqDiv39U2irn4iCp=7B3kx1nA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Kees Cook <keescook@chromium.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>, kpsingh@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 2, 2020 at 8:40 AM Slava Bacherikov <slava@bacher09.org> wrote:
>
>
>
> 02.04.2020 18:33, Slava Bacherikov wrote:
> > +     depends on DEBUG_INFO || COMPILE_TEST
>
> Andrii are you fine by this ?

I think it needs a good comment explaining this weirdness, at least.
As I said, if there is no DEBUG_INFO, there is not point in doing
DWARF-to-BTF conversion, even more -- it actually might fail, I
haven't checked what pahole does in that case. So I'd rather drop
GCC_PLUGIN_RANDSTRUCT is that's the issue here. DEBUG_INFO_SPLIT and
DEBUG_INFO_REDUCED look good.
