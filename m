Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E70713D776
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 11:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgAPKDP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 05:03:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40686 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAPKDP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 05:03:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so18474006wrn.7
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 02:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=oOAngD5VA2A59XTdFcUxIVFGLgGmINpgGgKrpE5agQI=;
        b=iCXS2zsQLcLQNq9PY9S+bq9GCcXElPeXa2UTXYzvPsWSssgZBp/B2dGgTLlh8G7Cbf
         BPpkbZDfSg+fOtm2qr/tH+SskwV593ZqkExv/yq2TWf8lh3b9K10m+pkmRyDHFeoXjac
         LJTmEuGYfwbU1AoDTjoZcu+Y+ZSPLKETjgbiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=oOAngD5VA2A59XTdFcUxIVFGLgGmINpgGgKrpE5agQI=;
        b=TCze1VJ53bFDKCs1T7LKTUgC3V7jFdt5+mASmEg01ZKoZeDUXKYpYcVSIMPm/BTu3y
         kk/zjAPBDFuam4wT+wtgiwumiS+KmoENY0KSfHB640Q4buo6zBcvW3yXHZe6YmHYbgum
         n2qj54EaR6cJyh6W18bY8QkYuF9HbvLvgN0+Xwc+q7yM0PEGXFaWfh5RggG7CaYvRslK
         xutl2nOKrVa35Y1QKMdFziNefVX8BySY8xwsaMSeOIYx2bmEVfbn8RuKizJHSfKus35C
         EVIGktviijHg8FB9v/bzsethRiVkWPdD/R8Cz0IsrzRxp7/9iYklCZrRnXwEQlO13lg3
         +hLw==
X-Gm-Message-State: APjAAAVJCcV/YMjMTaASQH/YlQi1gQWSkC+7xemLfNL9zKrIsFx0pE96
        EN8CBohBOQXCMyvyOpGnt0NQXw==
X-Google-Smtp-Source: APXvYqwHeVTQ8kb2OWT0ql9RSFO2AuIEnDV8UTAu41TTlqATzajQiDoWKO/ImC99bph3/VF7ofuZ5g==
X-Received: by 2002:adf:e3c1:: with SMTP id k1mr2305572wrm.151.1579168993846;
        Thu, 16 Jan 2020 02:03:13 -0800 (PST)
Received: from jackmanb.zrh.corp.google.com ([2a00:79e0:42:204:969b:bc6:900a:b44a])
        by smtp.gmail.com with ESMTPSA id j12sm28846459wrt.55.2020.01.16.02.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 02:03:12 -0800 (PST)
References: <20200115171333.28811-1-kpsingh@chromium.org>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Brendan Jackman <jackmanb@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v2 00/10] MAC and Audit policy using eBPF (KRSI)
In-reply-to: <20200115171333.28811-1-kpsingh@chromium.org>
Date:   Thu, 16 Jan 2020 11:03:12 +0100
Message-ID: <kcqxzhenen1b.fsf@jackmanb.zrh.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Wed, Jan 15 2020 at 18:13, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
[...]
> KP Singh (10):
>   bpf: btf: Make some of the API visible outside BTF
>   bpf: lsm: Add a skeleton and config options
>   bpf: lsm: Introduce types for eBPF based LSM
>   bpf: lsm: Add mutable hooks list for the BPF LSM
>   bpf: lsm: BTF API for LSM hooks
>   bpf: lsm: Implement attach, detach and execution
>   bpf: lsm: Make the allocated callback RO+X
>   tools/libbpf: Add support for BPF_PROG_TYPE_LSM
>   bpf: lsm: Add selftests for BPF_PROG_TYPE_LSM
>   bpf: lsm: Add Documentation

Just to note internal review cycles at Google; For the whole set:

Reviewed-by: Brendan Jackman <jackmanb@chromium.org>
