Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340716237D6
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 00:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiKIX7U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 18:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKIX7T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 18:59:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0141E63C8
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 15:59:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s12so629793edd.5
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 15:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8OKdJNW3KH2X3d0fEN5aG0KCtVW/N660XLjhVrbKY3M=;
        b=Lws/A4wnINRSuUYUn1tR+uBTuTeNYP3L2Tb7OU+ZA0F9YS0MDYmjYImWRYuWaAOi/4
         JtnCRZWU2FHtHwJCas0Jgmt3eaDQLJNgvt8y+UdQVnwyjC5yYgnsOWytUMm0yqUZawbG
         3/2Q2VwcpHoAkKgE/2s0iAoXZph/M3QtcOACdd7fOb+MylDQ6mKKfkNH6fk0QYQWeW57
         5LdPF/loJ2Wpzocshx+uRfWuccG/XvAXfnP1rCiBpouWBpvzZG+sLeYYeSMfE7SNTAmq
         3GqrKOe9wjA6B6JV+Buwv2elYLcRH5uSSKlEkgVjAAxpfb8UBIKuF1syca+GwT47Y+NX
         3RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OKdJNW3KH2X3d0fEN5aG0KCtVW/N660XLjhVrbKY3M=;
        b=UPZ0iK5EEGp8NcVVtwMQBaRP3VJdnofpwVFbJmL/ZMFnIblfsLzCOcBb/qCAMxb7BA
         r16x2qZ1bHYRFIHVa1WBa7p01Kk5ckgtloOOOEX2AI3GIOACx1onKGb5xr2YGcwmWQbw
         G4AFv3I9cTjuigzo5Sq19lukAmVGMoN399eBpH+mEVjGQiYDJwdGSdxkVHEIJ5IrRBFR
         ihxL+i5ihQIpFga1xcoXZrlEIY31FToIhmFXd4dWx+2MFX+8GQpu1/lqFwe+qMXvmc3M
         VEvhdC5Sdd80r9dPS4RSBXtUaK++5C78Be//YZe8dnRo7duFLoicVl1LqyjuAC/C6R9Z
         6A7Q==
X-Gm-Message-State: ACrzQf0GSXr/kbzMk9gS8AQ1wB7JAsq72OizQCz3um11yV97fjVZGBYd
        sfWd1py/mWM6O+Jgc7+IJVeoIAhxRitcU9s5jG4=
X-Google-Smtp-Source: AMsMyM7OjS2c2QkUh/izUJipX0duwBQsHDe8t4fwG1yqF5zsagTQU/RZaCyRue1f1wZn6BfiGP9QhOLqr7lT55zJ4NQ=
X-Received: by 2002:a05:6402:951:b0:459:aa70:d4b6 with SMTP id
 h17-20020a056402095100b00459aa70d4b6mr1301718edz.224.1668038357539; Wed, 09
 Nov 2022 15:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20221109074427.141751-4-sahid.ferdjaoui@industrialdiscipline.com>
In-Reply-To: <20221109074427.141751-4-sahid.ferdjaoui@industrialdiscipline.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Nov 2022 15:59:05 -0800
Message-ID: <CAEf4BzYttY8C9R5uUiduz1WUY0vEXXkH6KzH6Ha_WKmhWvmHFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpftool: fix error message when function
 can't register struct_ops
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 8, 2022 at 11:45 PM Sahid Orentino Ferdjaoui
<sahid.ferdjaoui@industrialdiscipline.com> wrote:
>
> It is expected that errno be passed to strerror().
>
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>
> ---
>  tools/bpf/bpftool/struct_ops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
> index 68281f9b7a0e..e0927dbb837b 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c
> @@ -513,8 +513,7 @@ static int do_register(int argc, char **argv)
>                 link = bpf_map__attach_struct_ops(map);
>                 if (libbpf_get_error(link)) {
>                         p_err("can't register struct_ops %s: %s",
> -                             bpf_map__name(map),
> -                             strerror(-PTR_ERR(link)));
> +                             bpf_map__name(map), strerror(errno));

if you are relying on errno anyways, then just drop libbpf_get_error altogether:

if (!link) {
    p_err(...);
    ...
}

>                         nr_errs++;
>                         continue;
>                 }
> --
> 2.34.1
>
>
