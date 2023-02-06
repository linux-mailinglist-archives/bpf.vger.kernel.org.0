Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAB068C725
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 20:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjBFT7N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 14:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBFT7M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 14:59:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BC42917F;
        Mon,  6 Feb 2023 11:59:05 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mc11so37435479ejb.10;
        Mon, 06 Feb 2023 11:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HMN1zat10jBr22fYuOn4khaUn1y+YL7NGcVt8J94/II=;
        b=qa+wYAR8WuIq5wi0XaKu62WK1I3OHWYPuerrBxWeWFSeCzOossEPHnSt8xOzdQWCIm
         laN6edncWt4Muu5xihetQGOizGjhu27bFcyOTQLemPJJYgFKkOo9/FHhoEAH+se6NPy+
         VVG/R61hYxsUnYbGeeV47mxH60V+k7SxiQ2GvEY7Gdiy3koI1L1p7bFnycQFK96DOrTD
         PSwFBnesZ2yeIHgf8lHpynV4Ok3BQy2kJT2bjppTTBmu4dyp7fs9deQklNdYKXKFzqvB
         wlxYlK5WgMfBKtllzbmA8LMfFA2/SwddmyMW1PfUqH/LrdeNe0/R3l3evW21qjW51yG9
         7YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMN1zat10jBr22fYuOn4khaUn1y+YL7NGcVt8J94/II=;
        b=Fp4i7CbZ/Diy4CPqCliq5VAS7jGzKHCioxedYvMn6Ke3Q159UQFgKo1fC8QGg4MpqZ
         9QHquIufAE3CGBJNNO6oVTSl00He15cuPdqmVddFneN3V2CD8nTfNfN+XkVHzcNM+Sss
         P6I+ELVMiCTqSl86mltBTKP1uSFFm29cnhuuQ7sCeGXaV8YuKR4JpjeawZaOIUxP+3NM
         AEUjsDHK/oSF3+RcgaJqtTyI1YYdpylXRfj5OXJOUh80lW4Z/ds1eTY6B6r7YQlvmfk6
         udGzlWJQJFqvwnujj+cF8WOaYV0KR4cBMjyTazgNb2y/aZ5DdGbK0Iiil/ZFMg5YZW8d
         OGxg==
X-Gm-Message-State: AO0yUKWUksjKAPqmq16BUA6EoM6RzxWu0J7/hIxOc6vCzhDO6dcEQ/XM
        7zaUDZXiniBzLmJV757Spc6IndMpnwrtRH1d9iA=
X-Google-Smtp-Source: AK7set/r2N3e58ZO16uitn1YASUGRs6MUKw6bQSH/yYT9vZTH21RhrNHpnbwt8x+3DWCQbFtI3ivK1rM4gJQXpbZP5k=
X-Received: by 2002:a17:906:924c:b0:877:5b9b:b426 with SMTP id
 c12-20020a170906924c00b008775b9bb426mr163060ejx.12.1675713544043; Mon, 06 Feb
 2023 11:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20230203031742.1730761-1-imagedong@tencent.com> <20230203031742.1730761-2-imagedong@tencent.com>
In-Reply-To: <20230203031742.1730761-2-imagedong@tencent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Feb 2023 11:58:51 -0800
Message-ID: <CAEf4Bzbig9DmCEJd0i64gA=jzczK7n=joqiD0MAa6sFSgd=WAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add support to set kprobe/uprobe
 attach mode
To:     menglong8.dong@gmail.com
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
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

On Thu, Feb 2, 2023 at 7:18 PM <menglong8.dong@gmail.com> wrote:
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
> Link: https://lore.kernel.org/bpf/20230113093427.1666466-1-imagedong@tencent.com/
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  tools/lib/bpf/libbpf.c | 26 +++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h | 19 ++++++++++++++++---
>  2 files changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index eed5cec6f510..0d20bf1ee301 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9784,7 +9784,7 @@ struct bpf_link *bpf_program__attach_perf_event_opts(const struct bpf_program *p
>         link->link.dealloc = &bpf_link_perf_dealloc;
>         link->perf_event_fd = pfd;
>
> -       if (kernel_supports(prog->obj, FEAT_PERF_LINK)) {
> +       if (kernel_supports(prog->obj, FEAT_PERF_LINK) && !opts->no_link) {
>                 DECLARE_LIBBPF_OPTS(bpf_link_create_opts, link_opts,
>                         .perf_event.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0));
>
> @@ -10148,16 +10148,28 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
>         struct bpf_link *link;
>         size_t offset;
>         bool retprobe, legacy;
> +       enum probe_mode mode;
>         int pfd, err;
>
>         if (!OPTS_VALID(opts, bpf_kprobe_opts))
>                 return libbpf_err_ptr(-EINVAL);
>
> +       mode = OPTS_GET(opts, mode, PROBE_MODE_DEFAULT);
>         retprobe = OPTS_GET(opts, retprobe, false);
>         offset = OPTS_GET(opts, offset, 0);
>         pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
>
>         legacy = determine_kprobe_perf_type() < 0;
> +       switch (mode) {
> +       case PROBE_MODE_LEGACY:
> +               legacy = true;
> +       case PROBE_MODE_PERF:
> +               pe_opts.no_link = true;
> +               break;
> +       default:
> +               break;
> +       }
> +
>         if (!legacy) {
>                 pfd = perf_event_open_probe(false /* uprobe */, retprobe,
>                                             func_name, offset,
> @@ -10817,10 +10829,12 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>         int pfd, err;
>         bool retprobe, legacy;
>         const char *func_name;
> +       enum probe_mode mode;
>
>         if (!OPTS_VALID(opts, bpf_uprobe_opts))
>                 return libbpf_err_ptr(-EINVAL);
>
> +       mode = OPTS_GET(opts, mode, PROBE_MODE_DEFAULT);
>         retprobe = OPTS_GET(opts, retprobe, false);
>         ref_ctr_off = OPTS_GET(opts, ref_ctr_offset, 0);
>         pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
> @@ -10849,6 +10863,16 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>         }
>
>         legacy = determine_uprobe_perf_type() < 0;
> +       switch (mode) {
> +       case PROBE_MODE_LEGACY:
> +               legacy = true;
> +       case PROBE_MODE_PERF:
> +               pe_opts.no_link = true;
> +               break;
> +       default:
> +               break;
> +       }
> +

I think this is a good place to also return errors early if, say, user
requested LINK mode, but that mode is not supported by kernel. Instead
of returning some -ENOTSUP generic error, we can error out early?
Similar for PERF mode, if only legacy is supported, and so on. Similar
for attach_uprobe, of course.

>         if (!legacy) {
>                 pfd = perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
>                                             func_offset, pid, ref_ctr_off);
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 8777ff21ea1d..7fb474e036a3 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -451,8 +451,10 @@ struct bpf_perf_event_opts {
>         size_t sz;
>         /* custom user-provided value fetchable through bpf_get_attach_cookie() */
>         __u64 bpf_cookie;
> +       /* don't use bpf_link when attach eBPF pprogram */

typo: pprogram

> +       bool no_link;

I've been struggling with this "no_link" name a bit. It is quite
confusing considering that from libbpf's API side we do return `struct
bpf_link`. So I'm thinking that maybe "force_ioctl_attach" would be a
better way to describe it (and will be scary enough for people not
knowing what this is about to not set it to true?)

Also, we'll need size_t: 0 at the end to avoid uninitialized padding
issues (like we have in kprobe_opts and uprobe_opts)

>  };
> -#define bpf_perf_event_opts__last_field bpf_cookie
> +#define bpf_perf_event_opts__last_field no_link
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_perf_event(const struct bpf_program *prog, int pfd);
> @@ -461,6 +463,13 @@ LIBBPF_API struct bpf_link *
>  bpf_program__attach_perf_event_opts(const struct bpf_program *prog, int pfd,
>                                     const struct bpf_perf_event_opts *opts);
>
> +enum probe_mode {

shall we call it probe_attach_mode?

also let's elaborate a bit more in doc comment that specifying mode
will force libbpf to use that, but if kernel doesn't support it --
then we'll error out.

> +       PROBE_MODE_DEFAULT = 0, /* latest supported by kernel */
> +       PROBE_MODE_LEGACY,
> +       PROBE_MODE_PERF,
> +       PROBE_MODE_LINK,
> +};
> +
>  struct bpf_kprobe_opts {
>         /* size of this struct, for forward/backward compatiblity */
>         size_t sz;
> @@ -470,9 +479,11 @@ struct bpf_kprobe_opts {
>         size_t offset;
>         /* kprobe is return probe */
>         bool retprobe;
> +       /* kprobe attach mode */
> +       enum probe_mode mode;

nit: mode -> attach_mode?

>         size_t :0;
>  };
> -#define bpf_kprobe_opts__last_field retprobe
> +#define bpf_kprobe_opts__last_field mode
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_kprobe(const struct bpf_program *prog, bool retprobe,
> @@ -570,9 +581,11 @@ struct bpf_uprobe_opts {
>          * binary_path.
>          */
>         const char *func_name;
> +       /* uprobe attach mode */
> +       enum probe_mode mode;
>         size_t :0;
>  };
> -#define bpf_uprobe_opts__last_field func_name
> +#define bpf_uprobe_opts__last_field mode

ditto

>
>  /**
>   * @brief **bpf_program__attach_uprobe()** attaches a BPF program
> --
> 2.39.0
>
