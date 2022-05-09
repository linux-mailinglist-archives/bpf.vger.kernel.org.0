Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2D15209B4
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 01:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiEIX5K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 19:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiEIX5J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 19:57:09 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F04229B819
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 16:53:14 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i20so17027412ion.0
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 16:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B/Azu1SP8rTjquO3N9ZuOJnO0ZA53pk9Jbi+CkdSlWA=;
        b=MLU2VWQB2LDGj7QsNItNdGQ8+CJmymtXw/+l9BUE4Ok+TFEWZg3zJPJ3IN5OnW3L5e
         BcssQarX8QXccsVdHAQ7mLmXARvfzdk5tMV8fLLK2Gyi42Jbq9iOm/aouo5QPsqelHJi
         rIB8X8Dr88s1Hk4Ejm3eiY2YdaCOVITP1zfTxcGIlaMACjS3flK5D6GUVWPHM8U9p5Zv
         hp5iGz642fxsXy+L7aB8qnlTsAxEH9LyngyuW14WCj4XZaEV+tyXjwetnH5AdT1Qa3Rw
         r37b/E8HZngkFXoa5bWgg9eRvZNmvp6P1dvAk3WyALckJgzQzeNq66tUtaG1iC47ti6E
         Eu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/Azu1SP8rTjquO3N9ZuOJnO0ZA53pk9Jbi+CkdSlWA=;
        b=SMrs7KUsPAXQUjHYO+LGaGyc/ezjevm0Mm4nB/kkaMLz6PcnzLJYFS8sK+3due51iQ
         WbIVE0PE+wXTLFjcIhsa3HzYwEMAX1nJt5autyreY/AJ0Tn48H0xetdEm7bacNrwntkk
         CvL/q2G+btDAXukpvSrEDe+4ETqpI0Pgxt6PXv2/q3kY8VJFam7BI6y2l3lmB21bJSDl
         0rgzydS/fmabLfRu64o24T/vehfgXftdMQcUMsGpPG8N8nz14/aqSt3bTfXiTY6Hoz+T
         SXZakYnOYqtn1vPo3aL8FNL1iCafOOXUbpf3FFKhuvYeufLq99faJsqi0Qq3ahSmnjqj
         FA2g==
X-Gm-Message-State: AOAM533VDdiIP5rOMCNhxX8kxlZSSAP85z6sZYdxtQ2/ObHnFDNxB1uk
        bucU1LngtJ6NfYu9ge1vfZZOZY5y/+0wEEzeb05nX1BEPj4=
X-Google-Smtp-Source: ABdhPJy0/2RAywOKpWM880jP2Fp1fd9KX3iy8KoTjPDArWdLtfiPi/E1D7nZEAwQqU8JnoL4GEneQPyTaXLL/m4kvGk=
X-Received: by 2002:a05:6638:533:b0:32a:d418:b77b with SMTP id
 j19-20020a056638053300b0032ad418b77bmr8464954jar.237.1652140393939; Mon, 09
 May 2022 16:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651532419.git.delyank@fb.com> <e109e32027ffa592f97ffe12854803101c85376d.1651532419.git.delyank@fb.com>
In-Reply-To: <e109e32027ffa592f97ffe12854803101c85376d.1651532419.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 16:53:03 -0700
Message-ID: <CAEf4Bzasc6mJkuimpDUxX5o2TT+05YO8mZDwA0SSHugptPms9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] libbpf: add support for sleepable kprobe
 and uprobe programs
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 2, 2022 at 4:09 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Add section mappings for uprobe.s and kprobe.s programs. The latter
> cannot currently attach but they're still useful to open and load in
> order to validate that prohibition.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>

One nit below, otherwise LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 63c0f412266c..d89529c9b52d 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8945,8 +8945,10 @@ static const struct bpf_sec_def section_defs[] = {
>         SEC_DEF("sk_reuseport",         SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
>         SEC_DEF("kprobe+",              KPROBE, 0, SEC_NONE, attach_kprobe),
>         SEC_DEF("uprobe+",              KPROBE, 0, SEC_NONE, attach_uprobe),
> +       SEC_DEF("uprobe.s+",            KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
>         SEC_DEF("kretprobe+",           KPROBE, 0, SEC_NONE, attach_kprobe),
>         SEC_DEF("uretprobe+",           KPROBE, 0, SEC_NONE, attach_uprobe),
> +       SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
>         SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>         SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>         SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt),
> @@ -10697,6 +10699,7 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>         else
>                 func_name = prog->sec_name + sizeof("kprobe/") - 1;
>
> +

unnecessary empty line?

>         n = sscanf(func_name, "%m[a-zA-Z0-9_.]+%li", &func, &offset);
>         if (n < 1) {
>                 pr_warn("kprobe name is invalid: %s\n", func_name);
> @@ -11222,7 +11225,8 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
>                 break;
>         case 3:
>         case 4:
> -               opts.retprobe = strcmp(probe_type, "uretprobe") == 0;
> +               opts.retprobe = strcmp(probe_type, "uretprobe") == 0 ||
> +                               strcmp(probe_type, "uretprobe.s") == 0;
>                 if (opts.retprobe && offset != 0) {
>                         pr_warn("prog '%s': uretprobes do not support offset specification\n",
>                                 prog->name);
> --
> 2.35.1
