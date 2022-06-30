Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A8B5622FE
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 21:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiF3TVB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 15:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiF3TU7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 15:20:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FC543AE3
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 12:20:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fw3so13225106ejc.10
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z47LFZy89yGsWvB479Vn8mKvDWE5geAeIy8MmuzMe0Y=;
        b=a2W2wOsnaeelBJVsQWBApyAeDkf7l20Hz1gF3AAyv/YfDH3mrriXmFN7Wvlsq+hlE4
         YIEUP1sK9MRJmwgn75G5vTU551xqtYF78FJ6g/I8ZSh5vIwpKkDWih2KpZDNVdxYU2ip
         gpkGBiWIR4n3WQqJ+emuEdy0ei1WOd7b8S6tkYxzQfEV3ogI7iKdseQ+kmZW25eYlaoc
         u84efCwOjwYG30iNoG5hDYwh+re316hPiXhdOPDyvtfwVgzX43c2UF+IjRcNWMxPpthB
         l/LjMaWZzFmUfFXCUkxr0zqkx9MVCD8GJMj/xMX4vAuY5lYiPYVAD3+Gt2KDgDowLn3v
         HHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z47LFZy89yGsWvB479Vn8mKvDWE5geAeIy8MmuzMe0Y=;
        b=A9rjqCfno6Jffmxz3VEpEVntomF+VXJqIYF/SGlM5Pw05ltjcSGQbDK84cuTFeQ7qD
         /T+UMKav0ojokdK6iSj/Q9ce1LqxjSpF5BAdZP71C+EhGzw18FOVO/PFJhZgUZkUqj+b
         mVvri3WhJ12EvqfUgT6r2ENpb2KEEj6WQDmZjgYxs4xBT/BsMOXcjvqDlAW7+pe60c5d
         u6r4jv5+HzoGN0VSKD8AgNTxe/ya6seffqplANmWITOGRpv1Mk2mgK3/XzWti91w3gYC
         qLzWq5OhEeNOlc/OF2dPtBjVEA2SNFISmZ1EJucHCkCEm+VH6cgtdHkFJZBe1rFAzcXX
         wZaQ==
X-Gm-Message-State: AJIora9YiYPRIpwsfbQyKH1NHyiFWr2Vtdx/utdCqHm4KDD25P93JK+5
        ZHuKYsy8MCelAGQ2upIkdkWmNNkCb5Lc3eu/FCU=
X-Google-Smtp-Source: AGRyM1vsgMumEqPCXZ5DUgP2LnwxKmVuIhdYowc62A4wTNYMgqpsv3cBkeO6alPzoCdXnxSr58HwHbcWz3Shy2WfZSA=
X-Received: by 2002:a17:907:a075:b0:72a:7508:c014 with SMTP id
 ia21-20020a170907a07500b0072a7508c014mr2522996ejc.176.1656616856014; Thu, 30
 Jun 2022 12:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220630135250.241795-1-hengqi.chen@gmail.com>
In-Reply-To: <20220630135250.241795-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 30 Jun 2022 12:20:44 -0700
Message-ID: <CAEf4Bzb+OyuRJbsxd2dfU2ROcuD4v24Wx3xVZctnbob-bUiPEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Allow attach USDT BPF program without
 specifying binary path
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
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

On Thu, Jun 30, 2022 at 6:53 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Currently, libbpf requires specifying binary path when attach USDT BPF program
> manually. This is not necessary because we can infer that from /proc/$PID/exe.
> This also avoids coredump when user do not provide binary path.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---

Hm... just because I specify PID, doesn't mean I mean main binary of
that process, it could be some other shared library within that
process.

I don't really like this change because it doesn't feel 100% obvious
and natural. User can easily specify "/proc/self/exe" or
"/proc/<pid>/exe" if that's what they are targeting.

Documentation for bpf_program__attach_usdt() states

@param binary_path Path to binary that contains provided USDT probe

it doesn't say it is optional and can be NULL, so there is no valid
reason to pass NULL and expect things to work.


>  tools/lib/bpf/libbpf.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8a45a84eb9b2..4ee9b6a0944e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10686,7 +10686,19 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
>                 return libbpf_err_ptr(-EINVAL);
>         }
>
> -       if (!strchr(binary_path, '/')) {
> +       if (!binary_path) {
> +               if (pid < 0) {
> +                       pr_warn("prog '%s': missing attach target, pid or binary path required\n",
> +                               prog->name);
> +                       return libbpf_err_ptr(-EINVAL);
> +               }
> +               if (!pid)
> +                       binary_path = "/proc/self/exe";
> +               else {
> +                       snprintf(resolved_path, sizeof(resolved_path), "/proc/%d/exe", pid);
> +                       binary_path = resolved_path;
> +               }
> +       } else if (!strchr(binary_path, '/')) {
>                 err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
>                 if (err) {
>                         pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
> --
> 2.30.2
>
