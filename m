Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F8226B02A
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 00:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgIOWDv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 18:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgIOWDe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 18:03:34 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CABC06178C
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 15:03:33 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id db4so2547613qvb.4
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOLtYWV5k43t7zSbOIgN7n22Qeg30cuT8X6VukPd788=;
        b=bTy/eiUmBRcA2datxSAmLf8APHcXrKNfoi7DcoTegfryY5ZEBzTSirUErrimu584Xu
         AsJiAXThsmidhIga+KvkysynDV//n6c8F76aN2aWK5X74oq8Tdqda2TlWY90JgCDlBps
         yFKqjqfrdq1nDgRkno7HvOeSEIs1GvhGnslTR/fuitSEJ6k1N/MDIv2R2ADIYcQf2MdX
         r7O1U9WYHSm49mk/0uubwoTZPPrfrQb/FkPjU03FiYcSAB106SC03LnKbimvvbWzYAJ2
         thtEsoE74MaII0EE1Yl4Bw2PrQJpNR7CD0baI4AqKIz1cqz9H7p/K3hVwCtMMoU20/Yd
         yu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOLtYWV5k43t7zSbOIgN7n22Qeg30cuT8X6VukPd788=;
        b=CDS+LP2folQqE57UVcE7c6Xqe5aSttW2pqTfM0VdoqXrLefHXJgmq8awgkOlK7uEGB
         LU+Xfvz2lnzYb2IlcFo6nZoDMIagTSenhgJeejQhcB8LsXblrgefCpn9qnq2FV4OoTF1
         2SP+ytuzztXxhNldDDwat40r/rC7Ko+m/+n4OY5qwPG8VPr8DJGirAh4z6LHlVzA5YDO
         bY8CxMoyIl94Fm4cXEBHAg3EjSTkH78wOZNVZyZL0e60pnGnN32PdWrUk9Be6zjX4Hmf
         j0DwQeUsx80YlaPlAmOyg74qNjE1C30byGeMas7MO0jpVNWp/qHvXo65aokbyQmiphEY
         c/Yw==
X-Gm-Message-State: AOAM530TKWDLNKcLdEZ3Uc/mVBAhOCJkg1N9R3N5KyNSKhE2ICK1QrNm
        66GWQMmoHs/qAMKVTFCo9bNwwhSopkf35N4vIX1rvA==
X-Google-Smtp-Source: ABdhPJwal7ruFnyisaxC3ZAEvhE3qWh1qncCnYQR8nf232vyk+NFYH/WW1mOYb3sZlPKJFIGdOLDTLlDCcNUgmuNHJ0=
X-Received: by 2002:a05:6214:b2a:: with SMTP id w10mr3940821qvj.33.1600207411895;
 Tue, 15 Sep 2020 15:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200914183615.2038347-1-sdf@google.com> <20200914183615.2038347-5-sdf@google.com>
 <CAEf4BzZUS1Ht9mu3R+RY=CYbkdLt7k-xG5r35hUkeSDr_sjnFQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZUS1Ht9mu3R+RY=CYbkdLt7k-xG5r35hUkeSDr_sjnFQ@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 15 Sep 2020 15:03:21 -0700
Message-ID: <CAKH8qBuCGiRCj=ju5XZpuHvVBqLme6pgfpH0JV+2jgr30j0idA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/5] bpftool: support dumping metadata
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 14, 2020 at 4:39 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Sep 14, 2020 at 11:37 AM Stanislav Fomichev <sdf@google.com> wrote:
> > +               if (map_info.type != BPF_MAP_TYPE_ARRAY)
> > +                       continue;
> > +               if (map_info.key_size != sizeof(int))
> > +                       continue;
> > +               if (map_info.max_entries != 1)
> > +                       continue;
> > +               if (!map_info.btf_value_type_id)
> > +                       continue;
> > +               if (!strstr(map_info.name, ".rodata"))
> > +                       continue;
> > +
> > +               *map_id = map_ids[i];
>
> return value_size here to avoid extra syscall below; or rather just
> accept bpf_map_info pointer and read everything into it?
Good idea, will just return bpf_map_info.

> > +       value = malloc(map_info->value_size);
> > +       if (!value)
> > +               goto out_close;
> > +
> > +       if (bpf_map_lookup_elem(map_fd, &key, value))
> > +               goto out_free;
> > +
> > +       close(map_fd);
> > +       return value;
> > +
> > +out_free:
> > +       free(value);
> > +out_close:
> > +       close(map_fd);
> > +       return NULL;
> > +}
> > +
> > +static bool has_metadata_prefix(const char *s)
> > +{
> > +       return strstr(s, BPF_METADATA_PREFIX) == s;
>
> this is a substring check, not a prefix check, use strncmp instead
Right, but I then compare the result to the original value (== s).
So if the substring starts with 0th index, we are good.

"strncmp(s, BPF_METADATA_PREFIX, BPF_METADATA_PREFIX_LEN) == 0;" felt
a bit clunky, but I can use it anyway if it helps the readability.

> > +}
> > +
> > +static void show_prog_metadata(int fd, __u32 num_maps)
> > +{
> > +       const struct btf_type *t_datasec, *t_var;
> > +       struct bpf_map_info map_info = {};
>
> it should be memset
Sounds good.

>
> > +       } else {
> > +               json_writer_t *btf_wtr = jsonw_new(stdout);
> > +               struct btf_dumper d = {
> > +                       .btf = btf,
> > +                       .jw = btf_wtr,
> > +                       .is_plain_text = true,
> > +               };
>
> empty line here?
Sure.
