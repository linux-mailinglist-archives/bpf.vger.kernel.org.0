Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B45F6A4DBE
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 23:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjB0WHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 17:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjB0WGp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 17:06:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7B5298D8;
        Mon, 27 Feb 2023 14:06:44 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ec43so31873394edb.8;
        Mon, 27 Feb 2023 14:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCTNgYAK7IFGbvLWwI1Elm6eJ4MRXAIuntOOPn+id8w=;
        b=cImA1qFtrJOm7nFVzxEh79FedOBCEQHx+xZRBJnjp+p41F8PYDblhreqmJvnycJk6B
         QAM/JzuIa8pNIRzHLdu1OUtul8Ua3nZXEuIkUqKeqA1x1hDu/Kqdah9rGcOMFUtTXQqz
         OI06TEYCMPSUjrzzGQw34wt2+NewIgnHIumES+x/+WzpLTF1TDsOBlka53rqENh85mHJ
         tdZfzsZFvai0MRX8diPjkJch3pmNhb2VVXrCpH7DfKbaRIzxtiEpSCdMJfuBDNuzu21R
         en8tzkbib3Q+DDsrKXa3uHeVFJLmEtTrbrTy7SRe0cSaPFEKzdBnrhl3oXBHvTYkRd2c
         waQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCTNgYAK7IFGbvLWwI1Elm6eJ4MRXAIuntOOPn+id8w=;
        b=7hGFF2FD++YgymiXAqKOAJxY7tRCZ1Y0YB1xq2SOn91HeTagCpkCNzOaK1ErBFhDrQ
         z9s71ve8BJpdA9dBt5c4VRNi1HHt2dL66FX9QPn6LOcqTZYu4Pfp8u60rFDxEmXHz7aB
         GFJkhk+OSqWTenEBAaF8t1paQkNs93gK9ew7m1MOCn7wbdGae42UBCWoqjHowZZ6CnsE
         QdvL22jGtNeXpJluYn8cBcMVl6HkygIrXkrQrckoWT45opibEkMxomSE39flMZ7ZVUc5
         TXvRIcFhrlPIDwTzphDnSOMvInF7VHEXEQuX8FfSJCE5m0YxWsyfm7SgHvI7xoTkjuge
         zQkA==
X-Gm-Message-State: AO0yUKVdyLQeyWnz/La9PloZlGzRM/D2Dl0p6PdX42hVONrbAv/ODUrl
        pAn+20l7lYE78Qk2fVlJexwjEQV4pbxy26RJD+0=
X-Google-Smtp-Source: AK7set8xWOejXti4Yw8krEBe/H4+cYD+XpLCtiGu+z5UPxwgsMcaRlQR/nK6CnxHQSZWsZwxqZ8CePeZVURWeI/fgXA=
X-Received: by 2002:a17:907:a04b:b0:8a5:c8bd:4ac4 with SMTP id
 gz11-20020a170907a04b00b008a5c8bd4ac4mr89067ejc.15.1677535602725; Mon, 27 Feb
 2023 14:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20230221025347.389047-1-imagedong@tencent.com> <20230221025347.389047-2-imagedong@tencent.com>
In-Reply-To: <20230221025347.389047-2-imagedong@tencent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 14:06:30 -0800
Message-ID: <CAEf4BzZPYWKqquK8-v2nTVfy3991DsZBBMybXYx4Rprjid78_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] libbpf: add support to set kprobe/uprobe
 attach mode
To:     menglong8.dong@gmail.com
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        benbjiang@tencent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 6:54=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> By default, libbpf will attach the kprobe/uprobe eBPF program in the
> latest mode that supported by kernel. In this patch, we add the support
> to let users manually attach kprobe/uprobe in legacy or perf mode.
>
> There are 3 mode that supported by the kernel to attach kprobe/uprobe:
>
>   LEGACY: create perf event in legacy way and don't use bpf_link
>   PERF: create perf event with perf_event_open() and don't use bpf_link
>   LINK: create perf event with perf_event_open() and use bpf_link
>
> Users now can manually choose the mode with
> bpf_program__attach_uprobe_opts()/bpf_program__attach_kprobe_opts().
>
> Link: https://lore.kernel.org/bpf/20230113093427.1666466-1-imagedong@tenc=
ent.com/
> Reviewed-by: Biao Jiang <benbjiang@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
> v2:
> - rename no_link to force_ioctl_attach
> - rename probe_mode to probe_attach_mode
> - add more doc for probe_attach_mode
> - return -ENOTSUP when necessray in bpf_program__attach_uprobe_opts and
>   bpf_program__attach_kprobe_opts
> ---
>  tools/lib/bpf/libbpf.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 69 insertions(+), 4 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 2efd80f6f7b9..ef8f68da42f9 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -451,8 +451,11 @@ struct bpf_perf_event_opts {
>         size_t sz;
>         /* custom user-provided value fetchable through bpf_get_attach_co=
okie() */
>         __u64 bpf_cookie;
> +       /* don't use bpf_link when attach eBPF program */

please also use "BPF" consistently, libbpf doesn't use "eBPF"
terminology, except literally 3 very old references (which we should
update)

> +       bool force_ioctl_attach;
> +       size_t :0;
>  };
> -#define bpf_perf_event_opts__last_field bpf_cookie
> +#define bpf_perf_event_opts__last_field force_ioctl_attach
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);

[...]
