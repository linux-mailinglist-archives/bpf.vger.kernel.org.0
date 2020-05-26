Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F281E29E5
	for <lists+bpf@lfdr.de>; Tue, 26 May 2020 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgEZSRD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 May 2020 14:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgEZSRD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 14:17:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70148C03E96D
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 11:17:02 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z1so4836384qtn.2
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8fJ7Ero04FoeXZXfBQOcwufXLxaMawhjqdWnm8WNEo=;
        b=Clq9zv90rpy4ADL0404HZV1rrZzxKPkSXRPLe4ZtmVN4XP0XGzJcOGgXfV6c/aH8AF
         G0RVft2SHR0q7uaMHEQJ/r6dU+VkIgUYPTQMP0x9N8bHxuguckMC/HT+JLeMR2bExWIE
         3crMe2K37rAs3mNcovBNP08qJn9Uhh2UxYmLefdvkdzJQIWKkNgGwBWr8sfOBTVHYZ4n
         Byf6igG3IfwaeUt6ruiDq4gk38ca+80ZlfT8VgSbpLLT4A7dmLZr68kepGCH8hnQ6DBW
         en/mOfr0dC6Mj3lf2k5UETxgUwzWek3/6YbFGaTVjJL9FTLLkb95dwuWhDM7BDGE7P8i
         Yd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8fJ7Ero04FoeXZXfBQOcwufXLxaMawhjqdWnm8WNEo=;
        b=k6gp8bJk9puNDdKkPUo3OTyhw4GdYd+i15KC0BJFekckHfBTd6Mgt+4U4G6fhw6+9t
         roSh+UEVkIeYg9t6vv+h1mDmMk5RiyV3TYnzkgvOEDR9tDdnOZ2iHIpsxjU9wgCLfVCA
         hq/IGcmQ1IhfAtpVVEbhqSz5ftRhMSGoqOILARswh6aGDp5VG+5hlVN9epoOK59c91Wh
         0OxO+rtYsabpBUg3s7podCgqsHF3mNC9kAKXpTdE6qZlZ4ND903P4bSkWsKHg1X1qct3
         vIUpCZGcECc8fqhHHLsLvPc6zmuLODj4fbpTiWsQreck6gA+vdRSYo816OxZI0NIPfJs
         eaUg==
X-Gm-Message-State: AOAM531eLayvKPZEojAl+gx25Ckl8F9pIJZr8u5lD8Sq/C7bq0uDNuYo
        nu0qSVB8GJ6AlSSJcJ6217vAkZkDCMl50nConhk=
X-Google-Smtp-Source: ABdhPJyuHU76io7UifAVhQmB6EiDM8bcMAZZJquhXLECZAraBgAX0qhx/KCZ/SB8Taa6PV+7T+IFVl5QUjqe9A3CBwU=
X-Received: by 2002:ac8:342b:: with SMTP id u40mr68493qtb.59.1590517021696;
 Tue, 26 May 2020 11:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <159050511046.148183.1806612131878890638.stgit@firesoul>
In-Reply-To: <159050511046.148183.1806612131878890638.stgit@firesoul>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 11:16:50 -0700
Message-ID: <CAEf4BzaXE5AsR1EvC8kQRoiRbsdLtq2AkHSU9_NqijAWxcN5fQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix map_check_no_btf return code
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 26, 2020 at 7:59 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> When a BPF-map type doesn't support having a BTF info associated, the
> bpf_map_ops->map_check_btf is set to map_check_no_btf(). This function
> map_check_no_btf() currently returns -ENOTSUPP, which result in a very
> confusing error message in libbpf, see below.
>
> The errno ENOTSUPP is part of the kernels internal errno in file
> include/linux/errno.h. As is stated in the file, these "should never be seen
> by user programs."
>
> Choosing errno EUCLEAN instead, which translated to "Structure needs
> cleaning" by strerror(3). This hopefully leads people to think about data
> structures which BTF is all about.

How about instead of tweaking error code, we actually just add support
for BTF key/values for all maps. For special maps, we can just enforce
that BTF is 4-byte integer (or typedef of that), so that in practice
you'll be defining it as:

struct {
    __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
    __type(key, u32);
    __type(value, u32);
} my_map SEC(".maps");

and it will just work?

>
> Before this change end-users of libbpf will see:
>  libbpf: Error in bpf_create_map_xattr(cpu_map):ERROR: strerror_r(-524)=22(-524). Retrying without BTF.
>
> After this change end-users of libbpf will see:
>  libbpf: Error in bpf_create_map_xattr(cpu_map):Structure needs cleaning(-117). Retrying without BTF.
>
> Fixes: e8d2bec04579 ("bpf: decouple btf from seq bpf fs dump and enable more maps")
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>  kernel/bpf/syscall.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d13b804ff045..ecde7d938421 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -732,7 +732,7 @@ int map_check_no_btf(const struct bpf_map *map,
>                      const struct btf_type *key_type,
>                      const struct btf_type *value_type)
>  {
> -       return -ENOTSUPP;
> +       return -EUCLEAN;
>  }
>
>  static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>
>
